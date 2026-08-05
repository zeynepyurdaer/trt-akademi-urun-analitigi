SELECT
  kaynak,
  COUNT(*) AS olay_sayisi,
  COUNT(DISTINCT kullanici_id) AS kullanici_sayisi,
  COUNTIF(olay = 'register') AS kayit_sayisi,
  ROUND(
    SAFE_DIVIDE(
      COUNTIF(olay = 'register'),
      COUNT(DISTINCT kullanici_id)
    ) * 100,
    2
  ) AS kayit_donusum_yuzdesi
FROM
  `project-0c02ccd1-f443-4521-96f.trt_analitik_egitim.web_olaylari`
GROUP BY
  kaynak
