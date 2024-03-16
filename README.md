# InstaMap Clone Basics

InstaMap Clone Basics, kullanıcıların giriş yapabileceği ve ardından mekanlar ekleyip görüntüleyebileceği bir uygulamadır. Uygulama, Parse platformunu kullanarak backend veritabanı işlevselliğini sağlar.

## Kurulum

1. Öncelikle projeyi klonlayın:
  git clone https://github.com/yourusername/InstaMap-clone-basics.git
2. Terminali açın ve projenin dizinine gidin:
cd InstaMap-clone-basics
3. Pod dosyasını oluşturun:
    pod init
4. Oluşturulan Podfile'ı açın ve Parse kütüphanesini ekleyin:
 pod 'Parse'
5. Terminalde projenin dizininde pod dosyasını yükleyin:
pod install
6. Xcode'u açın ve proje dosyasını açın:
open InstaMap-clone-basics.xcworkspace
7. Projeyi çalıştırın ve kullanmaya başlayın!

## Kullanım

Uygulamayı çalıştırdıktan sonra, kullanıcılar giriş yapabilecekleri bir ekranla karşılaşacaklar. Daha önceden bir hesapları yoksa, "Sign Up" butonuna tıklayarak bir hesap oluşturabilirler. Hesap oluşturduktan veya giriş yaptıktan sonra, kullanıcılar mekanlarını ekleyebilir ve mevcut mekanları görüntüleyebilirler.

- Mekan Ekleme: Ana ekrandan "+" butonuna tıklayarak yeni bir mekan ekleyebilirsiniz. Mekan adını, türünü ve atmosferini girdikten sonra "Save" butonuna tıklayarak mekanı kaydedebilirsiniz.
- 
- Mekanlara Yol Tarifi ana ekranda mekanin ismine tiklayarak yapin

## Backend Veritabanı

Uygulama, Parse platformunu kullanarak backend veritabanı işlevselliğini sağlar. Uygulamayı kullanmak için, Parse üzerinde bir hesap oluşturup, Parse kütüphanesini projenize ekleyerek kendi backend veritabanı anahtarlarınızı kullanmanız gerekmektedir.

Bu README dosyası, uygulamanın kurulumu ve kullanımı hakkında genel bilgi sağlamak içindir. Daha fazla bilgi için kodu inceleyebilir veya [back4app](https://www.back4app.com/) gibi Parse alternatiflerini inceleyebilirsiniz.




