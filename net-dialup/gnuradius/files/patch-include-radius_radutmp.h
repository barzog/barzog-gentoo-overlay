--- radius-1.6.1/include/radius/radutmp.h.orig	2012-01-04 11:52:08.000000000 +0300
+++ radius-1.6.1/include/radius/radutmp.h	2012-01-04 11:52:16.000000000 +0300
@@ -30,7 +30,7 @@
 #define P_ACCT_ENABLED  131
 
 #define RUT_NAMESIZE 32
-#define RUT_IDSIZE 16
+#define RUT_IDSIZE 32
 #define RUT_PNSIZE 24           /* Phone number size */
 
 struct radutmp {
