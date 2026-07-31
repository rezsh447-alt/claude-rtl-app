# Claude RTL WebView App

این پروژه یک WebView ساده برای [claude.ai](https://claude.ai) است که مشکل نمایش متن‌های راست‌به‌چپ (RTL) مانند فارسی و عربی را برطرف می‌کند.

## ویژگی‌ها

- **WebView برای claude.ai**: دسترسی به Claude AI در یک محیط اپلیکیشن بومی.
- **رفع مشکل RTL**: با استفاده از جاوااسکریپت، جهت‌دهی متن‌های RTL به صورت خودکار تنظیم می‌شود.
- **ساخت خودکار APK**: با استفاده از GitHub Actions، فایل APK به صورت خودکار ساخته و قابل دانلود است.

## ساختار پروژه

ساختار پروژه از یک پروژه استاندارد Flutter پیروی می‌کند:

```
claude_rtl_app/
├── .github/
│   └── workflows/
│       └── build-apk.yml  # GitHub Actions workflow برای ساخت APK
├── android/
│   ├── app/
│   │   └── src/
│   │       └── main/
│   │           └── AndroidManifest.xml # تنظیمات اندروید شامل دسترسی به اینترنت
│   └── build.gradle # تنظیمات Gradle پروژه اندروید
├── lib/
│   └── main.dart      # کد اصلی اپلیکیشن Flutter
├── pubspec.yaml       # وابستگی‌ها و متادیتای پروژه Flutter
└── README.md          # همین فایل
```

## راه‌اندازی و استفاده

برای استفاده از این پروژه و ساخت فایل APK، مراحل زیر را دنبال کنید:

### ۱. آماده‌سازی ریپازیتوری GitHub

۱. یک ریپازیتوری جدید در GitHub ایجاد کنید (مثلاً `claude-rtl-app`).
۲. این پروژه را به ریپازیتوری خود Push کنید. می‌توانید از دستورات زیر استفاده کنید:

```bash
cd /home/ubuntu/claude_rtl_app
git init
git add .
git commit -m "Initial commit: Claude RTL WebView App"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git # YOUR_USERNAME و YOUR_REPOSITORY_NAME را با اطلاعات خود جایگزین کنید
git push -u origin main
```

### ۲. ساخت APK با GitHub Actions

پس از Push کردن کد به شاخه `main` در GitHub، GitHub Actions به صورت خودکار شروع به کار می‌کند و فایل APK را می‌سازد.

برای دانلود فایل APK:

۱. به ریپازیتوری خود در GitHub بروید.
۲. روی تب **Actions** کلیک کنید.
۳. آخرین اجرای Workflow با عنوان "Flutter CI/CD" را انتخاب کنید.
۴. در بخش **Artifacts**، فایل `app-release.apk` را پیدا کرده و دانلود کنید.

### ۳. نصب و اجرا

فایل `app-release.apk` را به گوشی اندرویدی خود منتقل کرده و نصب کنید. ممکن است نیاز باشد نصب از منابع ناشناس را در تنظیمات گوشی خود فعال کنید.

## نیازمندی‌ها

- Flutter SDK (برای توسعه محلی، اما برای GitHub Actions نیازی به نصب محلی نیست)
- Android SDK (برای توسعه محلی)
- یک حساب GitHub

## مجوزها

این اپلیکیشن نیاز به دسترسی `android.permission.INTERNET` دارد تا بتواند محتوای وب را از `claude.ai` بارگذاری کند. این مجوز در فایل `AndroidManifest.xml` تنظیم شده است.

`minSdkVersion` برای این پروژه حداقل `20` تنظیم شده است.
