package com.reactlibrary;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.google.android.material.bottomsheet.BottomSheetDialog;

import java.lang.ref.WeakReference;

public class BottomSheetAlertModule extends ReactContextBaseJavaModule {

    private WeakReference<BottomSheetDialog> previousDialog;

    public BottomSheetAlertModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @NonNull
    @Override
    public String getName() {
        return "BottomSheetAlert";
    }

    @ReactMethod
    public void show(ReadableMap options, final Callback actionCallback) {
        if (previousDialog != null) {
            BottomSheetDialog bottomSheetDialog = previousDialog.get();
            if (bottomSheetDialog != null) bottomSheetDialog.dismiss();
            previousDialog.clear();
        }

        BottomSheetDialog bottomSheetDialog = new BottomSheetAlert(getCurrentActivity(), options).create(actionCallback);
        if (bottomSheetDialog == null) return;
        previousDialog = new WeakReference<>(bottomSheetDialog);
        bottomSheetDialog.show();
    }
}
