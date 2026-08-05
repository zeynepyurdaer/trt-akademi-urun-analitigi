# trt-akademi-urun-analitigi
BigQuery ve Looker Studio ile hazırlanmış sentetik ürün analitiği dashboard projesi
Kişisel eğitim ve portföy projesidir. TRT ile resmî bağlantısı yoktur ve sentetik veriler kullanılmıştır.
## Kullanılan Teknolojiler

- Google BigQuery
- Looker Studio
- SQL
- Microsoft Excel
- GitHub
## Veri Seti

- 3.000 satır sentetik web olayı
- Tarih aralığı: 01.05.2026–31.07.2026
- Ana tablo: `web_olaylari`
- Dataset: `trt_analitik_egitim`
- Analiz alanları: kullanıcı, oturum, kayıt, trafik, cihaz, platform, scroll ve sayfa performansı
  ## Temel KPI Sonuçları

- Toplam kayıtlı kullanıcı: **205**
- Son 91 gün: **204**
- Son 28 gün: **64**
- Son 14 gün: **30**
- Son 7 gün: **15**
- Dün: **7**
 ## Dashboard İçeriği

- Kayıtlı kullanıcı KPI kartları
- Günlük kayıt trendi
- Trafik kaynakları analizi
- Kayıt yöntemi dağılımı
- Platform ve cihaz dağılımları
- Sayfa bazlı scroll analizi
- Sayfa performansı tablosu
 ## Kurulum

1. Veriyi BigQuery’ye aktar.
2. `sql/` klasöründeki sorguları numara sırasıyla çalıştır.
3. Looker Studio’yu `web_olaylari` tablosuna bağla.
4. Kayıt metriklerinde `olay = register` filtresini kullan.
5. Kullanıcı metriklerini `COUNT DISTINCT kullanici_id` olarak ayarla.
