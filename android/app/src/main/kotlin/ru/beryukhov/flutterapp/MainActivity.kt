package ru.beryukhov.flutterapp

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity() : FlutterActivity() {
    private val CHANNEL = "interop_example";

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "tryInterop" && call.arguments is List<*> && (call.arguments as List<*>).size==2) {
                val args = call.arguments as List<String>
                result.success(args[0]+args[1]);
            } else {
                result.notImplemented()
            }
        }
    }
}
