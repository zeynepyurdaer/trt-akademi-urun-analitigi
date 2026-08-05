SELECT
  sayfa,

  COUNTIF(
    olay = 'page_view'
  ) AS sayfa_goruntuleme,

  COUNT(
    DISTINCT kullanici_id
  ) AS benzersiz_kullanici,

  COUNT(
    DISTINCT oturum_id
  ) AS oturum_sayisi,

  ROUND(
    AVG(oturum_suresi_sn),
    2
  ) AS ortalama_oturum_suresi_sn,

  COUNTIF(
    olay = 'scroll'
  ) AS scroll_sayisi,

  COUNTIF(
    olay = 'click'
  ) AS tiklama_sayisi,

  COUNTIF(
    olay = 'register'
  ) AS kayit_sayisi,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(olay = 'click'),
      COUNTIF(olay = 'page_view')
    ) * 100,
    2
  ) AS tiklama_orani_yuzdesi,

  ROUND(
    SAFE_DIVIDE(
      COUNT(
        DISTINCT IF(
          olay IN ('scroll', 'click', 'register'),
          oturum_id,
          NULL
        )
      ),
      COUNT(DISTINCT oturum_id)
    ) * 100,
    2
  ) AS etkilesimli_oturum_yuzdesi

FROM
  `project-0c02ccd1-f443-4521-96f.trt_analitik_egitim.web_olaylari`

GROUP BY
  sayfa

HAVING
  COUNTIF(olay = 'page_view') > 0
