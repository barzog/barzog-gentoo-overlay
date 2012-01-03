--- lib/ftlib.h.orig	2012-01-03 13:13:35.000000000 +0300
+++ lib/ftlib.h	2012-01-03 13:13:51.000000000 +0300
@@ -152,7 +152,7 @@
 #define FT_D_BUFSIZE           32768 /* stream data buffer size */
 #define FT_RCV_BUFSIZE         2048  /* enough to handle largest export */
 #define FT_SO_SND_BUFSIZE      1500  /* UDP send socket buffer size */
-#define FT_SO_RCV_BUFSIZE      (4*1024*1024) /* UDP recv socket buffer size */
+#define FT_SO_RCV_BUFSIZE      (8*1024*1024) /* UDP recv socket buffer size */
 
 #define FT_IO_SVERSION         3     /* stream version */
 
