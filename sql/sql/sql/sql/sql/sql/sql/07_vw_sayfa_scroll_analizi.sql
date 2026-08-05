SELECT
  sayfa,

  COUNTIF(
    olay = 'page_view'
  ) AS sayfa_goruntuleme,

  COUNT(
    DISTINCT IF(
      olay = 'page_view',
      kullanici_id,
      NULL
    )
  ) AS benzersiz_kullanici,

  COUNTIF(
    olay = 'scroll'
    AND scroll_orani >= 25
  ) AS scroll_25_sayisi,

  COUNTIF(
    olay = 'scroll'
    AND scroll_orani >= 50
  ) AS scroll_50_sayisi,

  COUNTIF(
    olay = 'scroll'
    AND scroll_orani >= 75
  ) AS scroll_75_sayisi,

  COUNTIF(
    olay = 'scroll'
    AND scroll_orani >= 100
  ) AS scroll_100_sayisi,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(olay = 'scroll' AND scroll_orani >= 25),
      COUNTIF(olay = 'page_view')
    ) * 100,
    2
  ) AS scroll_25_yuzdesi,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(olay = 'scroll' AND scroll_orani >= 50),
      COUNTIF(olay = 'page_view')
    ) * 100,
    2
  ) AS scroll_50_yuzdesi,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(olay = 'scroll' AND scroll_orani >= 75),
      COUNTIF(olay = 'page_view')
    ) * 100,
    2
  ) AS scroll_75_yuzdesi,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(olay = 'scroll' AND scroll_orani >= 100),
      COUNTIF(olay = 'page_view')
    ) * 100,
    2
  ) AS scroll_100_yuzdesi

FROM
  `project-0c02ccd1-f443-4521-96f.trt_analitik_egitim.web_olaylari`

GROUP BY
  sayfa

HAVING
  COUNTIF(olay = 'page_view') > 0
