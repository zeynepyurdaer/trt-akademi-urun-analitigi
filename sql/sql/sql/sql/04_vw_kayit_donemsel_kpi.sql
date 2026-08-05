WITH referans_tarih AS (
  SELECT
    MAX(tarih) AS son_tarih
  FROM
    `project-0c02ccd1-f443-4521-96f.trt_analitik_egitim.web_olaylari`
),

kayitlar AS (
  SELECT
    tarih,
    kullanici_id
  FROM
    `project-0c02ccd1-f443-4521-96f.trt_analitik_egitim.web_olaylari`
  WHERE
    olay = 'register'
),

sayimlar AS (
  SELECT
    r.son_tarih,

    COUNT(DISTINCT kullanici_id)
      AS toplam_kayitli_kullanici,

    COUNT(
      DISTINCT IF(
        tarih BETWEEN DATE_SUB(r.son_tarih, INTERVAL 90 DAY)
        AND r.son_tarih,
        kullanici_id,
        NULL
      )
    ) AS son_91_gun,

    COUNT(
      DISTINCT IF(
        tarih BETWEEN DATE_SUB(r.son_tarih, INTERVAL 181 DAY)
        AND DATE_SUB(r.son_tarih, INTERVAL 91 DAY),
        kullanici_id,
        NULL
      )
    ) AS onceki_91_gun,

    COUNT(
      DISTINCT IF(
        tarih BETWEEN DATE_SUB(r.son_tarih, INTERVAL 27 DAY)
        AND r.son_tarih,
        kullanici_id,
        NULL
      )
    ) AS son_28_gun,

    COUNT(
      DISTINCT IF(
        tarih BETWEEN DATE_SUB(r.son_tarih, INTERVAL 55 DAY)
        AND DATE_SUB(r.son_tarih, INTERVAL 28 DAY),
        kullanici_id,
        NULL
      )
    ) AS onceki_28_gun,

    COUNT(
      DISTINCT IF(
        tarih BETWEEN DATE_SUB(r.son_tarih, INTERVAL 13 DAY)
        AND r.son_tarih,
        kullanici_id,
        NULL
      )
    ) AS son_14_gun,

    COUNT(
      DISTINCT IF(
        tarih BETWEEN DATE_SUB(r.son_tarih, INTERVAL 27 DAY)
        AND DATE_SUB(r.son_tarih, INTERVAL 14 DAY),
        kullanici_id,
        NULL
      )
    ) AS onceki_14_gun,

    COUNT(
      DISTINCT IF(
        tarih BETWEEN DATE_SUB(r.son_tarih, INTERVAL 6 DAY)
        AND r.son_tarih,
        kullanici_id,
        NULL
      )
    ) AS son_7_gun,

    COUNT(
      DISTINCT IF(
        tarih BETWEEN DATE_SUB(r.son_tarih, INTERVAL 13 DAY)
        AND DATE_SUB(r.son_tarih, INTERVAL 7 DAY),
        kullanici_id,
        NULL
      )
    ) AS onceki_7_gun,

    COUNT(
      DISTINCT IF(
        tarih = DATE_SUB(r.son_tarih, INTERVAL 1 DAY),
        kullanici_id,
        NULL
      )
    ) AS dun,

    COUNT(
      DISTINCT IF(
        tarih = DATE_SUB(r.son_tarih, INTERVAL 8 DAY),
        kullanici_id,
        NULL
      )
    ) AS gecen_hafta_ayni_gun

  FROM
    kayitlar
  CROSS JOIN
    referans_tarih AS r
  GROUP BY
    r.son_tarih
)

SELECT
  *,

  ROUND(
    SAFE_DIVIDE(
      son_91_gun - onceki_91_gun,
      onceki_91_gun
    ) * 100,
    2
  ) AS son_91_gun_degisim_yuzdesi,

  ROUND(
    SAFE_DIVIDE(
      son_28_gun - onceki_28_gun,
      onceki_28_gun
    ) * 100,
    2
  ) AS son_28_gun_degisim_yuzdesi,

  ROUND(
    SAFE_DIVIDE(
      son_14_gun - onceki_14_gun,
      onceki_14_gun
    ) * 100,
    2
  ) AS son_14_gun_degisim_yuzdesi,

  ROUND(
    SAFE_DIVIDE(
      son_7_gun - onceki_7_gun,
      onceki_7_gun
    ) * 100,
    2
  ) AS son_7_gun_degisim_yuzdesi,

  ROUND(
    SAFE_DIVIDE(
      dun - gecen_hafta_ayni_gun,
      gecen_hafta_ayni_gun
    ) * 100,
    2
  ) AS dun_degisim_yuzdesi

FROM
  sayimlar
