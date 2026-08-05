WITH referans_tarih AS (
  SELECT
    MAX(tarih) AS son_tarih
  FROM
    `project-0c02ccd1-f443-4521-96f.trt_analitik_egitim.web_olaylari`
)

SELECT
  r.son_tarih,

  COUNT(DISTINCT kullanici_id)
    AS toplam_kullanici,

  COUNT(
    DISTINCT IF(
      tarih BETWEEN DATE_SUB(r.son_tarih, INTERVAL 90 DAY)
      AND r.son_tarih,
      kullanici_id,
      NULL
    )
  ) AS son_91_gun_kullanici,

  COUNT(
    DISTINCT IF(
      tarih BETWEEN DATE_SUB(r.son_tarih, INTERVAL 27 DAY)
      AND r.son_tarih,
      kullanici_id,
      NULL
    )
  ) AS son_28_gun_kullanici,

  COUNT(
    DISTINCT IF(
      tarih BETWEEN DATE_SUB(r.son_tarih, INTERVAL 13 DAY)
      AND r.son_tarih,
      kullanici_id,
      NULL
    )
  ) AS son_14_gun_kullanici,

  COUNT(
    DISTINCT IF(
      tarih BETWEEN DATE_SUB(r.son_tarih, INTERVAL 6 DAY)
      AND r.son_tarih,
      kullanici_id,
      NULL
    )
  ) AS son_7_gun_kullanici,

  COUNT(
    DISTINCT IF(
      tarih = DATE_SUB(r.son_tarih, INTERVAL 1 DAY),
      kullanici_id,
      NULL
    )
  ) AS dun_kullanici

FROM
  `project-0c02ccd1-f443-4521-96f.trt_analitik_egitim.web_olaylari`
CROSS JOIN
  referans_tarih AS r
GROUP BY
  r.son_tarih
