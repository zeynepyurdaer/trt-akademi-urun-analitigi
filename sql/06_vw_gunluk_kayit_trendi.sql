WITH tarih_sinirlari AS (
  SELECT
    MIN(tarih) AS ilk_tarih,
    MAX(tarih) AS son_tarih
  FROM
    `project-0c02ccd1-f443-4521-96f.trt_analitik_egitim.web_olaylari`
),

takvim AS (
  SELECT
    gun AS tarih
  FROM
    tarih_sinirlari,
    UNNEST(
      GENERATE_DATE_ARRAY(ilk_tarih, son_tarih)
    ) AS gun
),

gunluk_kayitlar AS (
  SELECT
    tarih,
    COUNT(*) AS kayit_sayisi,
    COUNT(DISTINCT kullanici_id)
      AS kayitli_kullanici_sayisi
  FROM
    `project-0c02ccd1-f443-4521-96f.trt_analitik_egitim.web_olaylari`
  WHERE
    olay = 'register'
  GROUP BY
    tarih
),

tamamlanmis_gunler AS (
  SELECT
    t.tarih,
    COALESCE(g.kayit_sayisi, 0)
      AS kayit_sayisi,
    COALESCE(g.kayitli_kullanici_sayisi, 0)
      AS kayitli_kullanici_sayisi
  FROM
    takvim AS t
  LEFT JOIN
    gunluk_kayitlar AS g
    ON t.tarih = g.tarih
),

trend_hesaplari AS (
  SELECT
    tarih,
    kayit_sayisi,
    kayitli_kullanici_sayisi,

    ROUND(
      AVG(kayitli_kullanici_sayisi) OVER (
        ORDER BY tarih
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
      ),
      2
    ) AS yedi_gun_hareketli_ortalama,

    LAG(kayitli_kullanici_sayisi, 7) OVER (
      ORDER BY tarih
    ) AS gecen_hafta_ayni_gun,

    SUM(kayit_sayisi) OVER (
      ORDER BY tarih
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS kumulatif_kayit_sayisi

  FROM
    tamamlanmis_gunler
)

SELECT
  *,

  ROUND(
    SAFE_DIVIDE(
      kayitli_kullanici_sayisi - gecen_hafta_ayni_gun,
      gecen_hafta_ayni_gun
    ) * 100,
    2
  ) AS haftalik_degisim_yuzdesi

FROM
  trend_hesaplari
