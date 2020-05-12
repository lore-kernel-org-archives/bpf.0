Return-Path: <SRS0=1NzR=62=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B0DC54E8D
	for <bpf@archiver.kernel.org>; Tue, 12 May 2020 05:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC3520746
	for <bpf@archiver.kernel.org>; Tue, 12 May 2020 05:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BxylhaXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgELF5o (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 12 May 2020 01:57:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgELF5n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 May 2020 01:57:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C5v2Ti113118;
        Tue, 12 May 2020 05:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=2ISzv+g8exC8vxvO8tEc1c0iu0qXodNhI+rQCSctVkg=;
 b=BxylhaXJvJIOO4FDQPKQn/qoRzQjAcuaVZHdROa4BhvY5oX+lR/X/KrOZu/rfttF5jkz
 JsCr4+AVsXpbcrNSdlDyKBfZVsc2UKY74Iuux1DrToqrMEcNk9QXLvWZiq3pLprxud5l
 +rysiDE/pI8ogu5m+h1UjoMsXBCYhWi8jU8xA8nE9McvgY72YLXMBi2MgbUqV0N2UWEq
 aQHG7+i1jqL0ANHXp+LirWfoI+sj8HPTFkUJNpcQzdi6EV9QfCzLqppiN6X+rIbvAJHv
 yr0q9Rlux4zWF4PO0CYZyQ5up0ws3NTWNeDUEmPcuzjTCglJS6kwKYcnj5BmiBVxOKXy Lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30x3mbrv2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 05:57:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C5sJNh110748;
        Tue, 12 May 2020 05:57:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30x69sfw47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 05:57:24 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04C5vNkY018045;
        Tue, 12 May 2020 05:57:23 GMT
Received: from localhost.uk.oracle.com (/10.175.210.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 22:57:23 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Cc:     joe@perches.com, linux@rasmusvillemoes.dk, arnaldo.melo@gmail.com,
        yhs@fb.com, kafai@fb.com, songliubraving@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 6/7] bpf: add support for %pT format specifier for bpf_trace_printk() helper
Date:   Tue, 12 May 2020 06:56:44 +0100
Message-Id: <1589263005-7887-7-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589263005-7887-1-git-send-email-alan.maguire@oracle.com>
References: <1589263005-7887-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120052
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow %pT[cNx0] format specifier for BTF-based display of data associated
with pointer.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/uapi/linux/bpf.h       | 27 ++++++++++++++++++++++-----
 kernel/trace/bpf_trace.c       | 21 ++++++++++++++++++---
 tools/include/uapi/linux/bpf.h | 27 ++++++++++++++++++++++-----
 3 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9d1932e..ab3c86c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -695,7 +695,12 @@ struct bpf_stack_build_id {
  * 		to file *\/sys/kernel/debug/tracing/trace* from DebugFS, if
  * 		available. It can take up to three additional **u64**
  * 		arguments (as an eBPF helpers, the total number of arguments is
- * 		limited to five).
+ *		limited to five), and also supports %pT (BTF-based type
+ *		printing), as long as BPF_READ lockdown is not active.
+ *		"%pT" takes a "struct __btf_ptr *" as an argument; it
+ *		consists of a pointer value and specified BTF type string or id
+ *		used to select the type for display.  For more details, see
+ *		Documentation/core-api/printk-formats.rst.
  *
  * 		Each time the helper is called, it appends a line to the trace.
  * 		Lines are discarded while *\/sys/kernel/debug/tracing/trace* is
@@ -731,10 +736,10 @@ struct bpf_stack_build_id {
  * 		The conversion specifiers supported by *fmt* are similar, but
  * 		more limited than for printk(). They are **%d**, **%i**,
  * 		**%u**, **%x**, **%ld**, **%li**, **%lu**, **%lx**, **%lld**,
- * 		**%lli**, **%llu**, **%llx**, **%p**, **%s**. No modifier (size
- * 		of field, padding with zeroes, etc.) is available, and the
- * 		helper will return **-EINVAL** (but print nothing) if it
- * 		encounters an unknown specifier.
+ *		**%lli**, **%llu**, **%llx**, **%p**, **%pT[cNx0], **%s**.
+ *		Only %pT supports modifiers, and the helper will return
+ *		**-EINVAL** (but print nothing) if it encouters an unknown
+ *		specifier.
  *
  * 		Also, note that **bpf_trace_printk**\ () is slow, and should
  * 		only be used for debugging purposes. For this reason, a notice
@@ -4058,4 +4063,16 @@ struct bpf_pidns_info {
 	__u32 pid;
 	__u32 tgid;
 };
+
+/*
+ * struct __btf_ptr is used for %pT (typed pointer) display; the
+ * additional type string/BTF id are used to render the pointer
+ * data as the appropriate type.
+ */
+struct __btf_ptr {
+	void *ptr;
+	const char *type;
+	__u32 id;
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d961428..c032c58 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -321,9 +321,12 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	return &bpf_probe_write_user_proto;
 }
 
+#define isbtffmt(c)	\
+	(c == 'T' || c == 'c' || c == 'N' || c == 'x' || c == '0')
+
 /*
  * Only limited trace_printk() conversion specifiers allowed:
- * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %s
+ * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %pT %s
  */
 BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	   u64, arg2, u64, arg3)
@@ -361,8 +364,20 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 			i++;
 		} else if (fmt[i] == 'p' || fmt[i] == 's') {
 			mod[fmt_cnt]++;
-			/* disallow any further format extensions */
-			if (fmt[i + 1] != 0 &&
+			/*
+			 * allow BTF type-based printing, and disallow any
+			 * further format extensions.
+			 */
+			if (fmt[i] == 'p' && fmt[i + 1] == 'T') {
+				int ret;
+
+				ret = security_locked_down(LOCKDOWN_BPF_READ);
+				if (unlikely(ret < 0))
+					return ret;
+				i++;
+				while (isbtffmt(fmt[i]))
+					i++;
+			} else if (fmt[i + 1] != 0 &&
 			    !isspace(fmt[i + 1]) &&
 			    !ispunct(fmt[i + 1]))
 				return -EINVAL;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9d1932e..ab3c86c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -695,7 +695,12 @@ struct bpf_stack_build_id {
  * 		to file *\/sys/kernel/debug/tracing/trace* from DebugFS, if
  * 		available. It can take up to three additional **u64**
  * 		arguments (as an eBPF helpers, the total number of arguments is
- * 		limited to five).
+ *		limited to five), and also supports %pT (BTF-based type
+ *		printing), as long as BPF_READ lockdown is not active.
+ *		"%pT" takes a "struct __btf_ptr *" as an argument; it
+ *		consists of a pointer value and specified BTF type string or id
+ *		used to select the type for display.  For more details, see
+ *		Documentation/core-api/printk-formats.rst.
  *
  * 		Each time the helper is called, it appends a line to the trace.
  * 		Lines are discarded while *\/sys/kernel/debug/tracing/trace* is
@@ -731,10 +736,10 @@ struct bpf_stack_build_id {
  * 		The conversion specifiers supported by *fmt* are similar, but
  * 		more limited than for printk(). They are **%d**, **%i**,
  * 		**%u**, **%x**, **%ld**, **%li**, **%lu**, **%lx**, **%lld**,
- * 		**%lli**, **%llu**, **%llx**, **%p**, **%s**. No modifier (size
- * 		of field, padding with zeroes, etc.) is available, and the
- * 		helper will return **-EINVAL** (but print nothing) if it
- * 		encounters an unknown specifier.
+ *		**%lli**, **%llu**, **%llx**, **%p**, **%pT[cNx0], **%s**.
+ *		Only %pT supports modifiers, and the helper will return
+ *		**-EINVAL** (but print nothing) if it encouters an unknown
+ *		specifier.
  *
  * 		Also, note that **bpf_trace_printk**\ () is slow, and should
  * 		only be used for debugging purposes. For this reason, a notice
@@ -4058,4 +4063,16 @@ struct bpf_pidns_info {
 	__u32 pid;
 	__u32 tgid;
 };
+
+/*
+ * struct __btf_ptr is used for %pT (typed pointer) display; the
+ * additional type string/BTF id are used to render the pointer
+ * data as the appropriate type.
+ */
+struct __btf_ptr {
+	void *ptr;
+	const char *type;
+	__u32 id;
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
1.8.3.1

