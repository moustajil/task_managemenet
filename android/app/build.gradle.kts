plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter plugin must be applied after Android & Kotlin
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.taskmanagenet"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.example.taskmanagenet"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BOM (versions managed automatically)
    implementation(platform("com.google.firebase:firebase-bom:34.6.0"))

    // Firebase Analytics
    implementation("com.google.firebase:firebase-analytics")
}
