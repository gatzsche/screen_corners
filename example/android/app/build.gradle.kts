
import java.util.Properties

plugins {
  id("com.android.application")
  id("kotlin-android")
  id("dev.flutter.flutter-gradle-plugin")
}

val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
  localPropertiesFile.reader(Charsets.UTF_8).use { reader ->
    localProperties.load(reader)
  }
}




val flutterVersionCode = localProperties.getProperty("flutter.versionCode") ?: "1"
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

android {
  namespace = "com.example.example" // Replace with your actual namespace
  compileSdk = flutter.compileSdkVersion
  ndkVersion =  "27.0.12077973"  // flutter.ndkVersion

  compileOptions {
      sourceCompatibility = JavaVersion.VERSION_1_8
      targetCompatibility = JavaVersion.VERSION_1_8
  }

  kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString()
  }

  sourceSets {
    getByName("main").java.srcDirs("src/main/kotlin")
  }

  lintOptions {
    disable("InvalidPackage")
  }

  defaultConfig {
      applicationId = "com.audanika.audio_engine_example"
      // You can update the following values to match your application needs.
      // For more information, see: https://flutter.dev/to/review-gradle-config.
      minSdk = 23
      targetSdk = flutter.targetSdkVersion
      versionCode = flutter.versionCode
      versionName = flutter.versionName
  }



    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
  source = "../.."
}

dependencies {

}
