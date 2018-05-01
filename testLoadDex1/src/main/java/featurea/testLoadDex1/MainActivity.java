package featurea.testLoadDex1;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.widget.TextView;
import dalvik.system.DexClassLoader;
import featurea.android.util.ApkFileUtil;
import featurea.util.ClassPath;

import java.io.File;
import java.net.URL;
import java.net.URLClassLoader;

public class MainActivity extends Activity {

    private TextView textView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main_activity);
        textView = findViewById(R.id.textView);
        textView.setText(new X().getX());
        try {
            File dexOutputDir = getDir("dex", Context.MODE_PRIVATE);
            DexClassLoader dexClassLoader = new DexClassLoader(ApkFileUtil.getRoot(getApplication()) + "/testLoadDex2.jar",
                    dexOutputDir.getAbsolutePath(), null, getClass().getClassLoader());
            X x = (X) dexClassLoader.loadClass("testLoadDex2.X2").newInstance();
            textView.setText(x.getX());
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }

}
