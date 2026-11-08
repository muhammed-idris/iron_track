pluginManagement {
    val flutterSdkPath =
        run {
            val localProperties = java.util.Properties()
            file("local.properties").inputStream().use { localProperties.load(it) }
            val sdkPath = localProperties.getProperty("flutter.sdk")
            require(sdkPath != null) { "flutter.sdk not set in local.properties" }
            sdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.5.1" apply false
    id("org.jetbrains.kotlin.android") version "2.4.21" apply false
}

include(":app")