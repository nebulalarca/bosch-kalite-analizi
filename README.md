# Bosch Uretim Hatti Kalite Analizi

Bosch uretim hatti performans verisi uzerinde yapilan kalite analizi projesi.

## Proje Ozeti
- 1.18 milyon urun, 969 sensor olcumu analiz edildi
- DuckDB ile buyuk veri RAM doldurmadan islendi
- Random Forest modeli ile %97.4 dogruluk elde edildi
- Hatali urunlerin %100u basariyla tespit edildi

## Kullanilan Teknolojiler
- R, RStudio
- DuckDB (buyuk veri isleme)
- Random Forest (makine ogrenmesi)
- ggplot2 (gorsellestirme)

## Ana Bulgular
- L3 hatti uretimin %66sini karsiliyor
- En kritik sensorler: L3_S29_F3321 ve L3_S33_F3855
- Urun hata orani: %0.58 (gercekci endustri verisi)
- Veri dengesizligi oversampling ile cozuldu

## Dosyalar
- `bosch_analiz.R` - Ana analiz kodu

## Veri Seti
Kaggle Bosch Production Line Performance
https://www.kaggle.com/competitions/bosch-production-line-performance
