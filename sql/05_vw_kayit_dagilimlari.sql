WITH kayitlar AS (
  SELECT
    kullanici_id,
    uygulama,
    platform,
    kayit_yontemi,
    cihaz
  FROM
    `project-0c02ccd1-f443-4521-96f.trt_analitik_egitim.web_olaylari`
  WHERE
    olay = 'register'
),

birlesik_dagilim AS (

  SELECT
    'uygulama' AS dagilim_turu,
    uygulama AS kategori,
    COUNT(*) AS kayit_sayisi,
    COUNT(DISTINCT kullanici_id) AS kullanici_sayisi
  FROM kayitlar
  GROUP BY uygulama

  UNION ALL

  SELECT
    'platform' AS dagilim_turu,
    platform AS kategori,
    COUNT(*) AS kayit_sayisi,
    COUNT(DISTINCT kullanici_id) AS kullanici_sayisi
  FROM kayitlar
  GROUP BY platform

  UNION ALL

  SELECT
    'kayit_yontemi' AS dagilim_turu,
    kayit_yontemi AS kategori,
    COUNT(*) AS kayit_sayisi,
    COUNT(DISTINCT kullanici_id) AS kullanici_sayisi
  FROM kayitlar
  GROUP BY kayit_yontemi

  UNION ALL

  SELECT
    'cihaz' AS dagilim_turu,
    cihaz AS kategori,
    COUNT(*) AS kayit_sayisi,
    COUNT(DISTINCT kullanici_id) AS kullanici_sayisi
  FROM kayitlar
  GROUP BY cihaz
)

SELECT
  dagilim_turu,
  kategori,
  kayit_sayisi,
  kullanici_sayisi,

  ROUND(
    SAFE_DIVIDE(
      kayit_sayisi,
      SUM(kayit_sayisi) OVER (
        PARTITION BY dagilim_turu
      )
    ) * 100,
    2
  ) AS pay_yuzdesi

FROM
  birlesik_dagilim
