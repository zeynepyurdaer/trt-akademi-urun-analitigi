# Looker Studio KPI Parse Hatası

## Sorun
Tek satırlık KPI view'larındaki `205` değeri tarih olarak algılandı ve
`Failed to parse input string "205"` hatası oluştu.

## Çözüm
KPI kartlarında doğrudan `web_olaylari` tablosu kullanıldı.
Metrik `kullanici_id`, toplama `Count Distinct` ve filtre `olay = register` olarak ayarlandı.
