plugins {
    id("com.android.library")
    id("kotlin-android")
}

rootProject.allprojects {
    repositories {
        google()
        jcenter()
    }
}


android {
    namespace = "com.alekangelov.screen_corners"
    compileSdk = 34 // use flutter.compileSdkVersion when Flutter 3.27.0 is widely used

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }
    defaultConfig {
        minSdkVersion(21)

        ndk {
            abiFilters.addAll(listOf("x86_64", "arm64-v8a", "armeabi-v7a"))
        }
    }
    lintOptions {
        disable("InvalidPackage")
    }


    ndkVersion = "27.0.12077973"

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString()
    }
}






if (tasks.findByName("clean") == null) {
    tasks.register<Delete>("clean") {
        delete(rootProject.buildDir)
    }
}
