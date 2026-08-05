SELECT
  MIN(tarih) AS ilk_tarih,
  MAX(tarih) AS son_tarih,
  COUNT(*) AS toplam_olay,
  COUNT(DISTINCT kullanici_id) AS toplam_kullanici,
  COUNT(DISTINCT oturum_id) AS toplam_oturum,
  COUNTIF(olay = 'page_view') AS sayfa_goruntuleme,
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
