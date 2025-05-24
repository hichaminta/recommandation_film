package com.example.recommandation_film

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import android.content.pm.PackageManager
import android.os.Build
import java.io.File

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        if (isDeviceRooted()) {
            // Fermer l'application si le téléphone est rooté
            finish()
        }
    }

    private fun isDeviceRooted(): Boolean {
        // Vérifier les fichiers système
        val paths = arrayOf(
            "/system/app/Superuser.apk",
            "/system/xbin/su",
            "/system/bin/su"
        )

        for (path in paths) {
            if (File(path).exists()) {
                return true
            }
        }

        // Vérifier les tags de build
        val buildTags = Build.TAGS
        if (buildTags != null && buildTags.contains("test-keys")) {
            return true
        }

        return false
    }
}
