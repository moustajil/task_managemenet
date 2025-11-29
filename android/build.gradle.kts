import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

// Redirect build directories
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// Plugins section (no version here)
plugins {
    id("com.google.gms.google-services") apply false
}

// If you don’t have the classpath yet, add it in the buildscript block
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.4.4") // specify version here
    }
}
