# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Flutter embedding
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.embedding.**

# Play Core (for deferred components)
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Gson specific classes
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}

# Keep custom application class
-keep public class * extends android.app.Application

# Keep Parcelable implementations
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

# Keep enum classes
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Additional Flutter rules
-keep class androidx.lifecycle.DefaultLifecycleObserver
