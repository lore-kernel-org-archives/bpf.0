Return-Path: <SRS0=8uh4=SB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B8DC10F05
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 00:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6B321773
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 00:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553904993;
	bh=OdY7Mz4krwMGT9FYT6j9sIWcOcCM5uG/3AnZ99tRsU4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PI9ZBKb34npqHfAWzId+YBuJiaAzNewxfiCIChZ0nMXaborGDVekEzUc0AnVf4Stj
	 SeSwlaYiMPbZ4G5NmOYHG+PiNiKqFv62zct+9TjnPxqNHmZQ1VxhrK3x++gOEXO98x
	 3XkFJNu4ALpysqW0oSu8rBrkvmMQ0G8PKyOx9pqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfC3AQc convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 29 Mar 2019 20:16:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49452 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730289AbfC3AQb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Mar 2019 20:16:31 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2U0CcaN007152
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2019 17:16:29 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rhwcag2tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2019 17:16:29 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 29 Mar 2019 17:16:28 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 2596E760BC0; Fri, 29 Mar 2019 17:16:27 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 7/7] selftests/bpf: add few verifier scale tests
Date:   Fri, 29 Mar 2019 17:16:12 -0700
Message-ID: <20190330001612.2354959-8-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190330001612.2354959-1-ast@kernel.org>
References: <20190330001612.2354959-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add 3 basic tests that stress verifier scalability.

test_verif_scale1.c calls non-inlined jhash() function 90 times on
different position in the packet.
This test simulates network packet parsing.
jhash function is ~140 instructions and main program is ~1200 insns.

test_verif_scale2.c force inlines jhash() function 90 times.
This program is ~15k instructions long.

test_verif_scale3.c calls non-inlined jhash() function 90 times on
But this time jhash has to process 32-bytes from the packet
instead of 14-bytes in tests 1 and 2.
jhash function is ~230 insns and main program is ~1200 insns.

$ test_progs -s
can be used to see verifier stats.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/bpf_verif_scale.c          | 49 +++++++++++++
 .../testing/selftests/bpf/progs/test_jhash.h  | 70 +++++++++++++++++++
 .../selftests/bpf/progs/test_verif_scale1.c   | 30 ++++++++
 .../selftests/bpf/progs/test_verif_scale2.c   | 30 ++++++++
 .../selftests/bpf/progs/test_verif_scale3.c   | 30 ++++++++
 tools/testing/selftests/bpf/test_progs.c      |  6 +-
 tools/testing/selftests/bpf/test_progs.h      |  1 +
 7 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_jhash.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_verif_scale1.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_verif_scale2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_verif_scale3.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
new file mode 100644
index 000000000000..23b159d95c3f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+#include <test_progs.h>
+static int libbpf_debug_print(enum libbpf_print_level level,
+			      const char *format, va_list args)
+{
+	if (level != LIBBPF_DEBUG)
+		return 0;
+
+	if (!strstr(format, "verifier log"))
+		return 0;
+	return vfprintf(stderr, "%s", args);
+}
+
+static int check_load(const char *file)
+{
+	struct bpf_prog_load_attr attr;
+	struct bpf_object *obj;
+	int err, prog_fd;
+
+	memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
+	attr.file = file;
+	attr.prog_type = BPF_PROG_TYPE_SCHED_CLS;
+	attr.log_level = 4;
+	err = bpf_prog_load_xattr(&attr, &obj, &prog_fd);
+	bpf_object__close(obj);
+	if (err)
+		error_cnt++;
+	return err;
+}
+
+void test_bpf_verif_scale(void)
+{
+	const char *file1 = "./test_verif_scale1.o";
+	const char *file2 = "./test_verif_scale2.o";
+	const char *file3 = "./test_verif_scale3.o";
+	int err;
+
+	if (verifier_stats)
+		libbpf_set_print(libbpf_debug_print);
+
+	err = check_load(file1);
+	err |= check_load(file2);
+	err |= check_load(file3);
+	if (!err)
+		printf("test_verif_scale:OK\n");
+	else
+		printf("test_verif_scale:FAIL\n");
+}
diff --git a/tools/testing/selftests/bpf/progs/test_jhash.h b/tools/testing/selftests/bpf/progs/test_jhash.h
new file mode 100644
index 000000000000..3d12c11a8d47
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_jhash.h
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+
+typedef unsigned int u32;
+
+static __attribute__((always_inline)) u32 rol32(u32 word, unsigned int shift)
+{
+	return (word << shift) | (word >> ((-shift) & 31));
+}
+
+#define __jhash_mix(a, b, c)			\
+{						\
+	a -= c;  a ^= rol32(c, 4);  c += b;	\
+	b -= a;  b ^= rol32(a, 6);  a += c;	\
+	c -= b;  c ^= rol32(b, 8);  b += a;	\
+	a -= c;  a ^= rol32(c, 16); c += b;	\
+	b -= a;  b ^= rol32(a, 19); a += c;	\
+	c -= b;  c ^= rol32(b, 4);  b += a;	\
+}
+
+#define __jhash_final(a, b, c)			\
+{						\
+	c ^= b; c -= rol32(b, 14);		\
+	a ^= c; a -= rol32(c, 11);		\
+	b ^= a; b -= rol32(a, 25);		\
+	c ^= b; c -= rol32(b, 16);		\
+	a ^= c; a -= rol32(c, 4);		\
+	b ^= a; b -= rol32(a, 14);		\
+	c ^= b; c -= rol32(b, 24);		\
+}
+
+#define JHASH_INITVAL		0xdeadbeef
+
+static ATTR
+u32 jhash(const void *key, u32 length, u32 initval)
+{
+	u32 a, b, c;
+	const unsigned char *k = key;
+
+	a = b = c = JHASH_INITVAL + length + initval;
+
+	while (length > 12) {
+		a += *(volatile u32 *)(k);
+		b += *(volatile u32 *)(k + 4);
+		c += *(volatile u32 *)(k + 8);
+		__jhash_mix(a, b, c);
+		length -= 12;
+		k += 12;
+	}
+	switch (length) {
+	case 12: c += (u32)k[11]<<24;
+	case 11: c += (u32)k[10]<<16;
+	case 10: c += (u32)k[9]<<8;
+	case 9:  c += k[8];
+	case 8:  b += (u32)k[7]<<24;
+	case 7:  b += (u32)k[6]<<16;
+	case 6:  b += (u32)k[5]<<8;
+	case 5:  b += k[4];
+	case 4:  a += (u32)k[3]<<24;
+	case 3:  a += (u32)k[2]<<16;
+	case 2:  a += (u32)k[1]<<8;
+	case 1:  a += k[0];
+		 c ^= a;
+		 __jhash_final(a, b, c);
+	case 0: /* Nothing left to add */
+		break;
+	}
+
+	return c;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_verif_scale1.c b/tools/testing/selftests/bpf/progs/test_verif_scale1.c
new file mode 100644
index 000000000000..f3236ce35f31
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_verif_scale1.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+#include <linux/bpf.h>
+#include "bpf_helpers.h"
+#define ATTR __attribute__((noinline))
+#include "test_jhash.h"
+
+SEC("scale90_noinline")
+int balancer_ingress(struct __sk_buff *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	void *ptr;
+	int ret = 0, nh_off, i = 0;
+
+	nh_off = 14;
+
+	/* pragma unroll doesn't work on large loops */
+
+#define C do { \
+	ptr = data + i; \
+	if (ptr + nh_off > data_end) \
+		break; \
+	ctx->tc_index = jhash(ptr, nh_off, ctx->cb[0] + i++); \
+	} while (0);
+#define C30 C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;
+	C30;C30;C30; /* 90 calls */
+	return 0;
+}
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_verif_scale2.c b/tools/testing/selftests/bpf/progs/test_verif_scale2.c
new file mode 100644
index 000000000000..77830693eccb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_verif_scale2.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+#include <linux/bpf.h>
+#include "bpf_helpers.h"
+#define ATTR __attribute__((always_inline))
+#include "test_jhash.h"
+
+SEC("scale90_inline")
+int balancer_ingress(struct __sk_buff *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	void *ptr;
+	int ret = 0, nh_off, i = 0;
+
+	nh_off = 14;
+
+	/* pragma unroll doesn't work on large loops */
+
+#define C do { \
+	ptr = data + i; \
+	if (ptr + nh_off > data_end) \
+		break; \
+	ctx->tc_index = jhash(ptr, nh_off, ctx->cb[0] + i++); \
+	} while (0);
+#define C30 C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;
+	C30;C30;C30; /* 90 calls */
+	return 0;
+}
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_verif_scale3.c b/tools/testing/selftests/bpf/progs/test_verif_scale3.c
new file mode 100644
index 000000000000..1848da04ea41
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_verif_scale3.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+#include <linux/bpf.h>
+#include "bpf_helpers.h"
+#define ATTR __attribute__((noinline))
+#include "test_jhash.h"
+
+SEC("scale90_noinline32")
+int balancer_ingress(struct __sk_buff *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	void *ptr;
+	int ret = 0, nh_off, i = 0;
+
+	nh_off = 32;
+
+	/* pragma unroll doesn't work on large loops */
+
+#define C do { \
+	ptr = data + i; \
+	if (ptr + nh_off > data_end) \
+		break; \
+	ctx->tc_index = jhash(ptr, nh_off, ctx->cb[0] + i++); \
+	} while (0);
+#define C30 C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;
+	C30;C30;C30; /* 90 calls */
+	return 0;
+}
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 5d10aee9e277..bf5c90998916 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -9,6 +9,7 @@
 
 int error_cnt, pass_cnt;
 bool jit_enabled;
+bool verifier_stats = false;
 
 struct ipv4_packet pkt_v4 = {
 	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
@@ -162,12 +163,15 @@ void *spin_lock_thread(void *arg)
 #include <prog_tests/tests.h>
 #undef DECLARE
 
-int main(void)
+int main(int ac, char **av)
 {
 	srand(time(NULL));
 
 	jit_enabled = is_jit_enabled();
 
+	if (ac == 2 && strcmp(av[1], "-s") == 0)
+		verifier_stats = true;
+
 #define CALL
 #include <prog_tests/tests.h>
 #undef CALL
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 51a07367cd43..f095e1d4c657 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -40,6 +40,7 @@ typedef __u16 __sum16;
 
 extern int error_cnt, pass_cnt;
 extern bool jit_enabled;
+extern bool verifier_stats;
 
 #define MAGIC_BYTES 123
 
-- 
2.20.0

