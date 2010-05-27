--- src/flow-print.c.orig	2010-02-25 15:37:31.000000000 +0200
+++ src/flow-print.c	2010-05-21 17:13:46.000000000 +0300
@@ -77,15 +77,16 @@
 int format22(struct ftio *ftio, int options);
 int format23(struct ftio *ftio, int options);
 int format24(struct ftio *ftio, int options);
+int format25(struct ftio *ftio, int options);
 
 struct jump format[] = {{format0}, {format1}, {format2},
           {format3}, {format4}, {format5}, {format6}, {format7},
           {format8}, {format9}, {format10}, {format11}, {format12},
           {format13}, {format14}, {format15}, {format16}, {format17},
           {format18}, {format19}, {format20}, {format21}, {format22},
-          {format23}, {format24}};
+          {format23}, {format24}, {format25}};
 
-#define NFORMATS 25
+#define NFORMATS 26
 
 void usage(void);
 
@@ -2282,6 +2283,114 @@
 } /* format24 */
 
 
+/*
+ * function: format25
+ *
+ * 1 line summary, steve's favorite
+ */
+int format25(struct ftio *ftio, int options)
+{
+  struct ftsym *sym_asn;
+  struct tm *tm;
+  struct fttime ftt;
+  struct fts3rec_all cur;
+  struct fts3rec_offsets fo;
+  struct ftver ftv;
+  char fmt_buf1[64], fmt_buf2[64], fmt_buf3[64], fmt_buf4[64], fmt_buf5[64];
+  char *rec;
+  time_t time_ftt;
+
+  if (ftio_check_xfield(ftio, FT_XFIELD_DPKTS |
+    FT_XFIELD_DOCTETS | FT_XFIELD_FIRST | FT_XFIELD_LAST | FT_XFIELD_INPUT |
+    FT_XFIELD_OUTPUT | FT_XFIELD_SRCADDR | FT_XFIELD_DSTADDR |
+    FT_XFIELD_SRCPORT | FT_XFIELD_DSTPORT | FT_XFIELD_UNIX_SECS |
+    FT_XFIELD_UNIX_NSECS | FT_XFIELD_SYSUPTIME | FT_XFIELD_TCP_FLAGS |
+    FT_XFIELD_PROT | FT_XFIELD_EXADDR )) {
+    fterr_warnx("Flow record missing required field for format.");
+    return -1;
+  }
+
+  sym_asn = (struct ftsym*)0L;
+    if (options & FT_OPT_NAMES) {
+        sym_asn = ftsym_new(FT_PATH_SYM_ASN);
+          }
+          
+  ftio_get_ver(ftio, &ftv);
+  
+  fts3rec_compute_offsets(&fo, &ftv);
+
+  puts("Start             End               P Sif   SrcIPaddress    SrcP  DIf   DstIPaddress    DstP    Pkts       Octets Fl ToS SrcAS DstAs Exporter \n");
+
+  while ((rec = ftio_read(ftio))) {
+
+    cur.unix_secs = ((uint32_t*)(rec+fo.unix_secs));
+    cur.unix_nsecs = ((uint32_t*)(rec+fo.unix_nsecs));
+    cur.sysUpTime = ((uint32_t*)(rec+fo.sysUpTime));
+    cur.dOctets = ((uint32_t*)(rec+fo.dOctets));
+    cur.dPkts = ((uint32_t*)(rec+fo.dPkts));
+    cur.First = ((uint32_t*)(rec+fo.First));
+    cur.Last = ((uint32_t*)(rec+fo.Last));
+    cur.srcaddr = ((uint32_t*)(rec+fo.srcaddr));
+    cur.dstaddr = ((uint32_t*)(rec+fo.dstaddr));
+    cur.input = ((uint16_t*)(rec+fo.input));
+    cur.output = ((uint16_t*)(rec+fo.output));
+    cur.srcport = ((uint16_t*)(rec+fo.srcport));
+    cur.dstport = ((uint16_t*)(rec+fo.dstport));
+    cur.prot = ((uint8_t*)(rec+fo.prot));
+    cur.tcp_flags = ((uint8_t*)(rec+fo.tcp_flags));
+    cur.tos = ((uint8_t*)(rec+fo.tos));
+    cur.src_as = ((uint16_t*)(rec+fo.src_as));
+    cur.dst_as = ((uint16_t*)(rec+fo.dst_as));
+    cur.exaddr = ((uint32_t*)(rec+fo.exaddr));
+
+    ftt = ftltime(*cur.sysUpTime, *cur.unix_secs, *cur.unix_nsecs, *cur.First);
+    time_ftt = ftt.secs;
+    tm = localtime(&time_ftt);
+
+    printf("%-2.2d/%-2.2d/%-4.4d %-2.2d:%-2.2d:%-2.2d -> ",
+      (int)tm->tm_mon+1, (int)tm->tm_mday, (int)tm->tm_year+1900,
+      (int)tm->tm_hour, (int)tm->tm_min, (int)tm->tm_sec);
+
+    ftt = ftltime(*cur.sysUpTime, *cur.unix_secs, *cur.unix_nsecs, *cur.Last);
+    time_ftt = ftt.secs;
+    tm = localtime(&time_ftt);
+
+    printf("%-2.2d/%-2.2d/%-4.4d %-2.2d:%-2.2d:%-2.2d ",
+      (int)tm->tm_mon+1, (int)tm->tm_mday, (int)tm->tm_year+1900,
+      (int)tm->tm_hour, (int)tm->tm_min, (int)tm->tm_sec);
+                
+    /* other info */
+    fmt_ipv4(fmt_buf1, *cur.srcaddr, FMT_PAD_RIGHT);
+    fmt_ipv4(fmt_buf2, *cur.dstaddr, FMT_PAD_RIGHT);
+    fmt_uint16s(sym_asn, 18, fmt_buf3, (uint16_t)*cur.src_as, FMT_JUST_LEFT);
+    fmt_uint16s(sym_asn, 18, fmt_buf4, (uint16_t)*cur.dst_as, FMT_JUST_LEFT);
+    fmt_ipv4(fmt_buf5, *cur.exaddr, FMT_PAD_RIGHT);
+
+    printf("%-4u %-5u %-15.15s %-5u <-> %-5u %-15.15s %-5u %-10lu %-10lu %1s%1s%1s%1s%1s%1s %-2.2x %-8.8s %-8.8s %-15.15s\n",
+
+           (unsigned int)*cur.prot,
+           (unsigned int)*cur.input, fmt_buf1, (unsigned int)*cur.srcport, 
+           (unsigned int)*cur.output, fmt_buf2, (unsigned int)*cur.dstport,
+           (u_long)*cur.dPkts, 
+           (u_long)*cur.dOctets,
+           0x01 & (unsigned int)*cur.tcp_flags ? "F" : "-",
+           0x02 & (unsigned int)*cur.tcp_flags ? "S" : "-",
+           0x04 & (unsigned int)*cur.tcp_flags ? "R" : "-",
+           0x08 & (unsigned int)*cur.tcp_flags ? "P" : "-",
+           0x10 & (unsigned int)*cur.tcp_flags ? "A" : "-",
+           0x20 & (unsigned int)*cur.tcp_flags ? "U" : "-",
+           (unsigned int)*cur.tos, fmt_buf3, fmt_buf4, fmt_buf5);
+
+    if (options & FT_OPT_NOBUF)
+      fflush(stdout);
+
+  } /* while */
+
+  return 0;
+
+} /* format25 */
+
+
 void usage(void) {
 
   fprintf(stderr, "Usage: flow-print [-hlnpw] [-d debug_level] [-f format]\n");
