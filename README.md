# Kelime Dehası

**Süreli sorularla kategori ve puan tabanlı oyun**

| Alan | Ayrıntı |
| --- | --- |
| Proje türü | Mobil quiz oyunu |
| Teknolojiler | Flutter · Dart · Provider |
| Geliştirici | Anıl Polat |

---

Flutter ile geliştirilen kategori ve puan tabanlı quiz uygulaması.

## Proje bağlamı

Üniversite eğitimi sırasında geliştirilen bir quiz oyunu projesidir. Süre, puan, oyun durumu ve uyarlanan zorluk gibi mekaniklerin mobil bir uygulamada birleştirilmesine odaklanır.

## Özellikler

- Kategori seçimi ve süreli sorular
- Doğru/yanlış, puan ve seri takibi
- İpucu ve pas kullanımı
- Başarıya göre uyarlanan zorluk mantığı
- SharedPreferences ile yüksek puan/oyun geçmişi saklama

## Teknolojiler

Flutter, Dart, Provider, SharedPreferences, google_fonts. pubspec.yaml Dart ^3.9.2 gerektirir.

## Kurulum

```sh
flutter pub get
flutter run
```

Yerel oyun geçmişi bu kaynak kopyasına eklenmedi. Derleme çıktıları, kullanıcı dosyaları ve SDK yolları çıkarılmıştır.

## Doğrulama durumu

Kaynaklar incelendi; bu ortamda Flutter bulunmadığından derleme ve cihaz testi çalıştırılmadı. Giriş ekranı bir arayüz/oyun akışı olarak değerlendirilmelidir; doğrulanmış sunucu kimlik doğrulaması iddiası yoktur.
