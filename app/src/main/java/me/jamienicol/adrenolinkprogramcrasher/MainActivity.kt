package me.jamienicol.adrenolinkprogramcrasher

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        Log.w("JAMIE", "Adding delayed callback")
        val handler = Handler(Looper.getMainLooper())
        handler.postDelayed(Runnable {
            Log.w("JAMIE", "Running delayed callback")
            val container = findViewById<View>(R.id.main) as ViewGroup
            for (i in 1..5) {
                container.addView(MyGLSurfaceView(this@MainActivity))
            }
        }, 100)

    }
}
