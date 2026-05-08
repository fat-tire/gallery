# Proguard configuration for Gson
# Gson uses generic type information stored in a class file when working
# with fields. Proguard removes such information by default, so configure it
# to keep all of it.
-keepattributes Signature

# For using GSON @Expose annotation
-keepattributes *Annotation*

# Gson specific classes
-dontwarn sun.misc.**
#-keep class com.google.gson.stream.** { *; }

# Prevent R8 from leaving Data object members always null
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# Keep class TypeToken (respectively its generic signature)
-keep class com.google.gson.reflect.TypeToken { *; }

# Keep any (anonymous) classes extending TypeToken
-keep class * extends com.google.gson.reflect.TypeToken

# Application classes that will be serialized/deserialized over Gson
-keep class com.google.ai.edge.gallery.data.AllowedModel { *; }
-keep class com.google.ai.edge.gallery.data.ModelAllowlist { *; }
-keep class com.google.ai.edge.gallery.data.DefaultConfig { *; }
-keepclassmembers class com.google.ai.edge.gallery.data.AllowedModel { <fields>; }
-keepclassmembers class com.google.ai.edge.gallery.data.ModelAllowlist { <fields>; }
-keepclassmembers class com.google.ai.edge.gallery.data.DefaultConfig { <fields>; }

# Keep mediapipe tasks classes.
-keep public class com.google.mediapipe.tasks.** {
  *;
}

# Additional flags to pass to Proguard when processing a binary that uses
# MediaPipe.

# Keep public members of our public interfaces. This also prevents the
# obfuscation of the corresponding methods in classes implementing them,
# such as implementations of PacketCallback#process.
-keep public interface com.google.mediapipe.framework.* {
  public *;
}

# This method is invoked by native code.
-keep public class com.google.mediapipe.framework.Packet {
  public static *** create(***);
  public long getNativeHandle();
  public void release();
}

# This method is invoked by native code.
-keep public class com.google.mediapipe.framework.PacketCreator {
  *** releaseWithSyncToken(...);
}

# This method is invoked by native code.
-keep public class com.google.mediapipe.framework.MediaPipeException {
  <init>(int, byte[]);
}

# Required to use PacketCreator#createProto
-keep class com.google.mediapipe.framework.ProtoUtil$SerializedMessage { *; }

-keep class com.google.ai.edge.gallery.proto.** { *; }

-keep class com.google.protobuf.** { *; }

-keepclassmembers class * extends com.google.protobuf.GeneratedMessageLite {
    <fields>;
}

-keep class androidx.datastore.** { *; }

-keep class com.google.ai.edge.litert.** { *; }
-keep class com.google.ai.edge.litertlm.** { *; }

-keep class * implements com.google.ai.edge.litertlm.** { *; }

-keep class com.google.ai.edge.gallery.runtime.LlmModelHelper { *; }
-keep class com.google.ai.edge.gallery.ui.llmchat.LlmChatTask { *; }

-keepclasseswithmembernames class * {
    native <methods>;
}
-keep class com.google.ai.edge.gallery.tools.** { *; }

-keepclassmembers class * {
    @com.google.ai.edge.litertlm.Tool <methods>;
    @com.google.ai.edge.litertlm.Tool <fields>;
}

-keepclassmembers class com.google.ai.edge.gallery.tools.params.** {
    <fields>;
    <init>(...);
}

-keepattributes Signature, AnnotationDefault, EnclosingMethod, InnerClasses


# removing analytics is fine
-dontwarn com.google.android.gms.measurement.**
-dontwarn com.google.firebase.analytics.**
-assumenosideeffects class com.google.android.gms.measurement.** { *; }
-assumenosideeffects class com.google.firebase.analytics.** { *; }

-dontobfuscate
