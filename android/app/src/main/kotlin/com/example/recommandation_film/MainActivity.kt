package com.example.recommandation_film

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import android.content.pm.PackageManager
import android.os.Build
import java.io.File
import android.widget.Toast

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Vérifier la version d'Android (doit être la première vérification)
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) { // S = 31 = Android 12
            Toast.makeText(this, "Votre version d'Android est inférieure à 12. L'application peut ne pas fonctionner correctement.", Toast.LENGTH_LONG).show()
            // Vous pouvez aussi fermer l'application ou désactiver certaines fonctionnalités ici
            // finish()
        }

        if (isDeviceRooted()) {
            Toast.makeText(this, "Votre téléphone est rooté. L'application va se fermer.", Toast.LENGTH_LONG).show()
            window.decorView.postDelayed({
                finish()
            }, 2000)
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
