Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776BE43F8B1
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238401; cv=none; b=Gmt6lln7zMP+qF3cLB+qdaUocvszm9uoUaGNaeyWb2lckYeOvhct0XWUvCThbBEGLDpVw4aXGz2S9D34PBZ74GMVmeeGKzJINgD81Efl37rmHDzwLnv09J9xP/wl/BcQwo7LEpQLmiG8Km/uWlgrPMAN5KqTiJwwPRQV4tkdNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238401; c=relaxed/simple;
	bh=oJE96KIUGfF6g+KxUc1Zc8KFMZzV9H64FoTRnKyPBP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TywsemFTaggdfEPrXOxaAUKcxiTjDeDcvT22hcU9iv8oxxSLQWXs4W+Ixym/EksseOWbsi4AAEOA5VYzY2TB5b/DNefKayrnSJBxAsmsfWKJsiase2+S0SdhzhyqeeuTXN1Xh0H3ByvUi10NyG+AqaGCc4ghgSRrQ2HtBzzv1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYrjanGc; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYrjanGc"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484349b1961so848803f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238397; x=1790843197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ci3lsM9QzkFDC6CW/fpkfMTdyw776Nl9UlzmH/0KC4c=;
        b=XYrjanGcRbr7+7bbOkTDbg425YWHBno+JJcfkGjJBs1Xbnh+1X3fOiANPXoVSOjRNu
         zyvSAAAaKaw+x9kJujZmOAuRa7/VAmLsEg8Nep1VMN2MHghP3MTX2oPWWXWarMVS0wVb
         FrwW7zZT4TnZsyRw1Jl5UIVLENsekRiX1dEP+m4CRgsvob11nuetAh3QtC+iQqYRfJkp
         K1X8WWubxYTCf6qtW+glB4RuVYhzxLDQVNdpIo+NdVvQO6yrq7+3Jyeh623sM6kHoE2n
         kh6uV/Tl5etc42rFBhmEzfMtucLpUrYA9lH89ge7ug+m5wkeTXmAOswv1ddGGKeM7TUe
         QUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238397; x=1790843197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ci3lsM9QzkFDC6CW/fpkfMTdyw776Nl9UlzmH/0KC4c=;
        b=FFOexamoTD0lSSUPaGTfoCAMRwZ+fQ//p/Jzml3iuf/rzgAdRwhf3LA4XOa3lrr/RC
         9505ofI6+DLpJwhZHi/+GsOu7q3oQivgSTH3jfbNpFYzhOZysukvlhkkzz8ZxgTIR4MT
         ww+xXa2r95e/ZOswg0iSKAjcoEOb8HL9ugfx8kpyd/C3n9HhQWmYGn+cK/kND4P7Mphn
         YgFLss0luRA1WkApONiVMkeK2XNSyCkay0H1tFlIYKrqmGWSi6CiUbWlLMkwhrNHzhg/
         TrbbAvJSY50QOgat0V74reV/Tgo7qz0ZD04OpF5fvZWMZW7qaeA5TrNQKA/LghAWlByY
         TpYQ==
X-Gm-Message-State: AFuF++neRjDmXUUFa5jhzB8W0y/4ymRYS1VDABcDhsGpw3mezbpAiT7u
	XXdBQr0LSyKoWK0uM/I961Qbs1tdk2kf+q7/mZhOkgiWYQPoN9+b2/f6YNkSAk2G
X-Gm-Gg: AYBFou0XqgQjCLOjsyLbjoIUKfuX7BuG12I9AMym0JIdSb/lqxWhiZXSslxCy/UGqNl
	HXdWP6KYUQRYOkFFytdWX0HY1oMPS2UKeDORkjzIQL4UDBRZ/xwvz4vz1KX/Ab304Xt7rB7B6hU
	owDq1TUiAo2t5xW+Ke/ii5nuHkJ3s+ybYLK0P/Qg7nnQzUeseya6XF9N17keakoO2XI2YlRDOoq
	+UDjBkhxGKHexQ6qu2mhqzI6Ogrs5yN/ApHDSk2qegIl7KUtMr/fftkld5cvuUXURKr7EAhKbR4
	ubXjkDfI1w2TqQqazA+/SrpuGqfIFBRApi9zV9OZDtl0O00A1vXpps8xsGNv9+s5NTegf+pl2yC
	Y1AcxHKQfWCLydar/m5eGpUKudd+gsaa3zorYDEcaLlHTLJgXTBzXTLA93NkZTtMoxkfbEQqMeo
	N7kuPM4tJhYE1rpacfmQacw/Ec2eUzt92SBxLRUnIL4MyQMHFH/wrWA+G/q8mAbNKf1bnIif1mz
	Jyy5xlNnlaZAzAhA6YNqKshO5/YFFAIGZBWbv3rq/IqcN0l02yEaf/e/L7kPXuXPCfwpcf0Ah3H
	JcKshthKA4Dpb7+aDGF2Bt2rxc6EUGqgEE0AsQ==
X-Received: by 2002:a5d:5f52:0:b0:486:f450:64e5 with SMTP id ffacd0b85a97d-488716f6e23mr2876710f8f.26.1790238396386;
        Thu, 24 Sep 2026 01:26:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877a19bsm13841394f8f.25.2026.09.24.01.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 15/18] selftests/bpf: Give the 512-byte stack boundary tests a 2 KiB twin
Date: Thu, 24 Sep 2026 10:25:51 +0200
Message-ID: <20260924082607.2695649-16-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924082607.2695649-1-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28848; i=memxor@gmail.com; h=from:subject; bh=oJE96KIUGfF6g+KxUc1Zc8KFMZzV9H64FoTRnKyPBP0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLvVRdrcu8yzLL1ot9Kv0a+uSAa5yc6P5LixiNo4Pv9 C0O2Pu4o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOJfc/I8O32fwf/KV0ek82O 3bvevtbEafri179mfA+5r73adZuUawwjQ/eHLFsHMdXQ+E3rGl9d3vlL5Oqu6ncfU9NqW+Yv/8E vxgoA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A number of tests pin the 512-byte stack limit: accesses just past it,
call chains that add up to more than it, private stack frames and
async callbacks that exceed it. Once a JIT raises the budget to 2 KiB
those programs load, so mark them __load_if_no_large_stack() and add a
counterpart at the 2 KiB boundary under __load_if_large_stack(), so
that each kernel runs the pair that matches its budget. The
combined-depth tests that were built from frames of a few hundred
bytes now chain five 480-byte frames, which exceeds both budgets and
keeps them valid on every architecture; the number of frames reported
in the error then differs, so those messages match any count. The C
tests are limited to 512 bytes per function by the compiler, hence the
chains. The callx stack depth tests, whose callee frames add up to 608
bytes, chain four 480-byte frames behind the callx target for the same
reason.

No kernel grants the larger budget yet, so the 512-byte tests still run
everywhere and the 2 KiB twins are skipped.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/async_stack_depth.c   |  75 +++++++++++
 .../bpf/progs/struct_ops_private_stack_fail.c |  47 ++++++-
 .../selftests/bpf/progs/test_global_func1.c   |  65 ++++++++++
 .../bpf/progs/test_global_func_deep_stack.c   |  33 ++++-
 .../selftests/bpf/progs/verifier_callx.c      |  61 +++++++--
 .../bpf/progs/verifier_callx_rodata.c         |  53 +++++++-
 .../selftests/bpf/progs/verifier_live_stack.c |   4 +-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  21 +++
 .../selftests/bpf/progs/verifier_stack_ptr.c  |  53 ++++++++
 .../selftests/bpf/progs/verifier_var_off.c    |  32 +++++
 tools/testing/selftests/bpf/verifier/calls.c  | 122 ++++++++++++++----
 11 files changed, 523 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/async_stack_depth.c b/tools/testing/selftests/bpf/progs/async_stack_depth.c
index 36734683acbd..9cd874a90b39 100644
--- a/tools/testing/selftests/bpf/progs/async_stack_depth.c
+++ b/tools/testing/selftests/bpf/progs/async_stack_depth.c
@@ -29,7 +29,49 @@ static int bad_timer_cb(void *map, int *key, struct bpf_timer *timer)
 	return buf[255] + timer_cb(NULL, NULL, NULL);
 }
 
+/*
+ * The same shapes scaled to the 2 KiB budget of JITs with large stacks. The
+ * compiler caps a single function at 512 bytes, so the depth comes from a
+ * chain of 480-byte frames.
+ */
+__attribute__((noinline))
+static int timer_cb_large_0(void *map, int *key, struct bpf_timer *timer)
+{
+	volatile char buf[480] = {};
+	return buf[69];
+}
+
+__attribute__((noinline))
+static int timer_cb_large_1(void *map, int *key, struct bpf_timer *timer)
+{
+	volatile char buf[480] = {};
+	return buf[69] + timer_cb_large_0(map, key, timer);
+}
+
+__attribute__((noinline))
+static int timer_cb_large_2(void *map, int *key, struct bpf_timer *timer)
+{
+	volatile char buf[480] = {};
+	return buf[69] + timer_cb_large_1(map, key, timer);
+}
+
+__attribute__((noinline))
+static int timer_cb_large_3(void *map, int *key, struct bpf_timer *timer)
+{
+	volatile char buf[480] = {};
+	return buf[69] + timer_cb_large_2(map, key, timer);
+}
+
+/* 5 * 480 = 2400 bytes on its own */
+__attribute__((noinline))
+static int bad_timer_cb_large(void *map, int *key, struct bpf_timer *timer)
+{
+	volatile char buf[480] = {};
+	return buf[255] + timer_cb_large_3(map, key, timer);
+}
+
 SEC("tc")
+__load_if_no_large_stack()
 __failure __msg("combined stack size of 2 calls is")
 int pseudo_call_check(struct __sk_buff *ctx)
 {
@@ -44,7 +86,25 @@ int pseudo_call_check(struct __sk_buff *ctx)
 	return bpf_timer_set_callback(&elem->timer, timer_cb) + buf[0];
 }
 
+/* main plus the four frames under timer_cb_large_3: 2400 bytes */
 SEC("tc")
+__load_if_large_stack()
+__failure __msg("combined stack size of 5 calls is")
+int pseudo_call_check_large(struct __sk_buff *ctx)
+{
+	struct hmap_elem *elem;
+	volatile char buf[480] = {};
+
+	elem = bpf_map_lookup_elem(&hmap, &(int){0});
+	if (!elem)
+		return 0;
+
+	timer_cb_large_3(NULL, NULL, NULL);
+	return bpf_timer_set_callback(&elem->timer, timer_cb_large_3) + buf[0];
+}
+
+SEC("tc")
+__load_if_no_large_stack()
 __failure __msg("combined stack size of 2 calls is")
 int async_call_root_check(struct __sk_buff *ctx)
 {
@@ -58,4 +118,19 @@ int async_call_root_check(struct __sk_buff *ctx)
 	return bpf_timer_set_callback(&elem->timer, bad_timer_cb) + buf[0];
 }
 
+SEC("tc")
+__load_if_large_stack()
+__failure __msg("combined stack size of 5 calls is")
+int async_call_root_check_large(struct __sk_buff *ctx)
+{
+	struct hmap_elem *elem;
+	volatile char buf[480] = {};
+
+	elem = bpf_map_lookup_elem(&hmap, &(int){0});
+	if (!elem)
+		return 0;
+
+	return bpf_timer_set_callback(&elem->timer, bad_timer_cb_large) + buf[0];
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
index 1442728f5604..c8cb35b37867 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -25,6 +26,44 @@ __noinline static int subprog1(int *a)
 	return subprog2(a, b);
 }
 
+/*
+ * A chain of 480-byte frames under test_2, so that its call chain exceeds
+ * the 2 KiB budget of JITs with large stacks as well as the 512 bytes
+ * allowed elsewhere. The compiler caps a single function at 512 bytes, and
+ * the buffers are volatile so that it cannot shrink them.
+ */
+__noinline static int subprog_deep4(int *a)
+{
+	volatile char b[480] = {};
+
+	__sink(b[479]);
+	return a[10] + b[20];
+}
+
+__noinline static int subprog_deep3(int *a)
+{
+	volatile char b[480] = {};
+
+	__sink(b[479]);
+	return subprog_deep4(a) + b[20];
+}
+
+__noinline static int subprog_deep2(int *a)
+{
+	volatile char b[480] = {};
+
+	__sink(b[479]);
+	return subprog_deep3(a) + b[20];
+}
+
+__noinline static int subprog_deep1(int *a)
+{
+	volatile char b[480] = {};
+
+	__sink(b[479]);
+	return subprog_deep2(a) + b[20];
+}
+
 
 SEC("struct_ops")
 int BPF_PROG(test_1)
@@ -41,11 +80,13 @@ int BPF_PROG(test_1)
 SEC("struct_ops")
 int BPF_PROG(test_2)
 {
-	/* stack size 400 bytes */
-	int a[100] = {};
+	/* stack size 476 bytes, over 2 KiB with the four 480-byte deep subprogs */
+	volatile char buf[376] = {};
+	int a[25] = {};
 
+	__sink(buf[375]);
 	a[10] = 3;
-	val_j = subprog1(a);
+	val_j = subprog1(a) + subprog_deep1(a);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func1.c b/tools/testing/selftests/bpf/progs/test_global_func1.c
index fc69ff18880d..f0eca282e0d4 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func1.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func1.c
@@ -48,8 +48,73 @@ int f3(int val, struct __sk_buff *skb, int var)
 }
 
 SEC("tc")
+__load_if_no_large_stack()
 __failure __msg("combined stack size of 3 calls is")
 int global_func1(struct __sk_buff *skb)
 {
 	return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
 }
+
+/*
+ * A chain of five frames that stay under 512 bytes each but add up to more
+ * than the 2 KiB budget of JITs with large stacks; the chain also exceeds
+ * 512 bytes after two frames, so it is rejected everywhere.
+ */
+#define MAX_STACK_LARGE 480
+
+__attribute__ ((noinline))
+int g0(struct __sk_buff *skb)
+{
+	volatile char buf[MAX_STACK_LARGE] = {};
+
+	__sink(buf[MAX_STACK_LARGE - 1]);
+
+	return skb->len;
+}
+
+__attribute__ ((noinline))
+int g1(struct __sk_buff *skb)
+{
+	volatile char buf[MAX_STACK_LARGE] = {};
+
+	__sink(buf[MAX_STACK_LARGE - 1]);
+
+	return g0(skb) + skb->len;
+}
+
+__attribute__ ((noinline))
+int g2(struct __sk_buff *skb)
+{
+	volatile char buf[MAX_STACK_LARGE] = {};
+
+	__sink(buf[MAX_STACK_LARGE - 1]);
+
+	return g1(skb) + skb->len;
+}
+
+__attribute__ ((noinline))
+int g3(struct __sk_buff *skb)
+{
+	volatile char buf[MAX_STACK_LARGE] = {};
+
+	__sink(buf[MAX_STACK_LARGE - 1]);
+
+	return g2(skb) + skb->len;
+}
+
+__attribute__ ((noinline))
+int g4(struct __sk_buff *skb)
+{
+	volatile char buf[MAX_STACK_LARGE] = {};
+
+	__sink(buf[MAX_STACK_LARGE - 1]);
+
+	return g3(skb) + skb->len;
+}
+
+SEC("tc")
+__failure __msg("combined stack size of {{[0-9]+}} calls is")
+int global_func1_deep(struct __sk_buff *skb)
+{
+	return g4(skb);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
index 1b634b543b62..edb8a223a3cb 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
@@ -67,12 +67,30 @@ int XCAT(f, n)(unsigned long a)                  \
 #define F_31 F_30       FN(31, 30)
 #define F_32 F_31       FN(32, 31)
 
+/* Same, with a 480-byte frame, to exceed the 2 KiB budget of large stacks. */
+#define FNB(n, prev) \
+__attribute__((noinline))                        \
+int XCAT(f, n)(unsigned long a)                  \
+{                                                \
+	volatile char buf[480] = {};             \
+	volatile long b = XCAT(f, prev)(a - 1);  \
+	if (!b)                                  \
+		return 0;                        \
+	return b + buf[479] + 1;                 \
+}
+
+#define F_33 F_32       FNB(33, 32)
+#define F_34 F_33       FNB(34, 33)
+#define F_35 F_34       FNB(35, 34)
+#define F_36 F_35       FNB(36, 35)
+#define F_37 F_36       FNB(37, 36)
+
 #define CAT2(a, b) a ## b
 #define XCAT2(a, b) CAT2(a, b)
 
 #define F(n) XCAT2(F_, n)
 
-F(32)
+F(37)
 
 /* Ensure that even 32 levels deep, the function verifies. */
 SEC("syscall")
@@ -88,8 +106,21 @@ int global_func_deep_stack_success(struct __sk_buff *skb)
  * the size.
  */
 SEC("syscall")
+__load_if_no_large_stack()
 __failure __msg("combined stack size of 34 calls")
 int global_func_deep_stack_fail(struct __sk_buff *skb)
 {
 	return f32(123);
 }
+
+/*
+ * Five 480-byte frames on top of the chain: 5 * 480 + 33 * 16 = 2928 bytes,
+ * more than the 2 KiB budget of JITs with large stacks, and more than 512
+ * bytes after the second frame everywhere else.
+ */
+SEC("syscall")
+__failure __msg("combined stack size of {{[0-9]+}} calls")
+int global_func_deep_stack_fail_large(struct __sk_buff *skb)
+{
+	return f37(123);
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
index 238fc75ad154..ea3d3f97da31 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
@@ -626,19 +626,64 @@ static unsigned long use_stack_304(void)
 	);
 }
 
+
+/* Four 480-byte frames, deeper than any budget together with their caller */
+__naked __noinline __used
+static unsigned long use_stack_480_0(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 480) = r0;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long use_stack_480_1(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 480) = r0;"
+		"call use_stack_480_0;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long use_stack_480_2(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 480) = r0;"
+		"call use_stack_480_1;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long use_stack_480_3(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 480) = r0;"
+		"call use_stack_480_2;"
+		"exit;"
+	);
+}
+
 /* stack of the callee of callx is accounted */
 SEC("socket")
-__failure __msg("combined stack size of 2 calls is")
+__failure __msg("combined stack size of {{[0-9]+}} calls is")
 __naked void callx_stack_depth(void)
 {
 	asm volatile (
 		"r0 = 0;"
-		"*(u64 *)(r10 - 304) = r0;"
-		"r2 = %[use_stack_304] ll;"
+		"*(u64 *)(r10 - 480) = r0;"
+		"r2 = %[use_stack_480_3] ll;"
 		"callx r2;"
 		"exit;"
 		:
-		: __imm_addr(use_stack_304)
+		: __imm_addr(use_stack_480_3)
 		: __clobber_all);
 }
 
@@ -655,19 +700,19 @@ static unsigned long apply_stack_304(void)
 }
 
 /*
- * The address of use_stack_304() is taken by the main prog that doesn't
+ * The address of use_stack_480_3() is taken by the main prog that doesn't
  * use stack, but it is called from apply_stack_304().
  */
 SEC("socket")
-__failure __msg("combined stack size of 3 calls is")
+__failure __msg("combined stack size of {{[0-9]+}} calls is")
 __naked void callx_stack_depth_nested(void)
 {
 	asm volatile (
-		"r1 = %[use_stack_304] ll;"
+		"r1 = %[use_stack_480_3] ll;"
 		"call apply_stack_304;"
 		"exit;"
 		:
-		: __imm_addr(use_stack_304)
+		: __imm_addr(use_stack_480_3)
 		: __clobber_all);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
index af1f9305da37..e39202902be4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -589,13 +589,58 @@ static unsigned long use_stack_304(void)
 	);
 }
 
+
+/* Four 480-byte frames, deeper than any budget together with their caller */
+__naked __noinline __used
+static unsigned long use_stack_480_0(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 480) = r0;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long use_stack_480_1(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 480) = r0;"
+		"call use_stack_480_0;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long use_stack_480_2(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 480) = r0;"
+		"call use_stack_480_1;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long use_stack_480_3(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 480) = r0;"
+		"call use_stack_480_2;"
+		"exit;"
+	);
+}
+
 /* stack of all possible callees is accounted */
 SEC("socket")
-__failure __msg("combined stack size of 2 calls is")
+__failure __msg("combined stack size of {{[0-9]+}} calls is")
 __naked void callx_rodata_stack_depth(void)
 {
 	asm volatile (
-		FUNC_TABLE2(tbl, ret0, use_stack_304)
+		FUNC_TABLE2(tbl, ret0, use_stack_480_3)
 		"r0 = 0;"
 		"*(u64 *)(r10 - 304) = r0;"
 		"call %[bpf_get_prandom_u32];"
@@ -613,11 +658,11 @@ __naked void callx_rodata_stack_depth(void)
 
 /* stack of a callback that is read from the data is accounted too */
 SEC("socket")
-__failure __msg("combined stack size of 2 calls is")
+__failure __msg("combined stack size of {{[0-9]+}} calls is")
 __naked void callx_rodata_callback_stack_depth(void)
 {
 	asm volatile (
-		FUNC_TABLE2(tbl, use_stack_304, ret0)
+		FUNC_TABLE2(tbl, use_stack_480_3, ret0)
 		"r0 = 0;"
 		"*(u64 *)(r10 - 304) = r0;"
 		"r6 = tbl_%= ll;"
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 4736bcca55da..a832df0b5bd2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -318,7 +318,7 @@ struct {
 } map_array SEC(".maps");
 
 SEC("socket")
-__failure __msg("invalid read from stack R2 off=-1024 size=8")
+__failure __msg("invalid read from stack R2 off=-4096 size=8")
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked unsigned long caller_stack_write_tail_call(void)
 {
@@ -329,7 +329,7 @@ __naked unsigned long caller_stack_write_tail_call(void)
         "if r0 != 42 goto 1f;"
         "goto 2f;"
   "1:"
-        "*(u64 *)(r10 - 8) = -1024;"
+        "*(u64 *)(r10 - 8) = -4096;"
   "2:"
         "r1 = r6;"
         "r2 = r10;"
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
index 9f0f48ecb421..0fe631411b9c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
@@ -240,6 +240,7 @@ __naked void load_bytes_spilled_regs_data(void)
 
 SEC("tc")
 __description("raw_stack: skb_load_bytes, invalid access 1")
+__load_if_no_large_stack()
 __failure __msg("invalid write to stack R3 off=-513 size=8")
 __naked void load_bytes_invalid_access_1(void)
 {
@@ -257,6 +258,26 @@ __naked void load_bytes_invalid_access_1(void)
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("raw_stack: skb_load_bytes, invalid access 1, large stack")
+__load_if_large_stack()
+__failure __msg("invalid write to stack R3 off=-2049 size=8")
+__naked void load_bytes_invalid_access_1_large(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -2049;					\
+	r3 = r6;					\
+	r4 = 8;						\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
 SEC("tc")
 __description("raw_stack: skb_load_bytes, invalid access 2")
 __failure __msg("invalid write to stack R3 off=-1 size=8")
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 8e8cf8232255..3e0bea9819ca 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -235,6 +235,7 @@ __naked void to_stack_check_low_1(void)
 
 SEC("socket")
 __description("PTR_TO_STACK check low 2")
+__load_if_no_large_stack()
 __success __failure_unpriv
 __msg_unpriv("R1 stack pointer arithmetic goes out of range")
 __retval(42)
@@ -250,8 +251,27 @@ __naked void to_stack_check_low_2(void)
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("PTR_TO_STACK check low 2, large stack")
+__load_if_large_stack()
+__success __failure_unpriv
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__retval(42)
+__naked void to_stack_check_low_2_large(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -2049;					\
+	r0 = 42;					\
+	*(u8*)(r1 + 1) = r0;				\
+	r0 = *(u8*)(r1 + 1);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
 SEC("socket")
 __description("PTR_TO_STACK check low 3")
+__load_if_no_large_stack()
 __failure __msg("invalid write to stack R1 off=-513 size=1")
 __msg_unpriv("R1 stack pointer arithmetic goes out of range")
 __naked void to_stack_check_low_3(void)
@@ -266,6 +286,23 @@ __naked void to_stack_check_low_3(void)
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("PTR_TO_STACK check low 3, large stack")
+__load_if_large_stack()
+__failure __msg("invalid write to stack R1 off=-2049 size=1")
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__naked void to_stack_check_low_3_large(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -2049;					\
+	r0 = 42;					\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = *(u8*)(r1 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
 SEC("socket")
 __description("PTR_TO_STACK check low 4")
 __failure __msg("math between fp pointer")
@@ -483,6 +520,7 @@ l1_%=:	r0 = 42;					\
 
 SEC("socket")
 __description("PTR_TO_STACK stack size > 512")
+__load_if_no_large_stack()
 __failure __msg("invalid write to stack R1 off=-520 size=8")
 __naked void stack_check_size_gt_512(void)
 {
@@ -495,6 +533,21 @@ __naked void stack_check_size_gt_512(void)
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("PTR_TO_STACK stack size > 2048")
+__load_if_large_stack()
+__failure __msg("invalid write to stack R1 off=-2056 size=8")
+__naked void stack_check_size_gt_2048(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -2056;					\
+	r0 = 42;					\
+	*(u64*)(r1 + 0) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
 #ifdef __BPF_FEATURE_MAY_GOTO
 SEC("socket")
 __description("PTR_TO_STACK stack size 512 with may_goto with jit")
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index a63e33675091..399884911ea5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -406,6 +406,7 @@ __naked void zero_sized_access_max_out_of_bound(void)
 
 SEC("lwt_in")
 __description("indirect variable-offset stack access, min out of bound")
+__load_if_no_large_stack()
 __failure __msg("invalid variable-offset read from stack R2")
 __naked void access_min_out_of_bound(void)
 {
@@ -433,6 +434,37 @@ __naked void access_min_out_of_bound(void)
 	: __clobber_all);
 }
 
+SEC("lwt_in")
+__description("indirect variable-offset stack access, min out of bound, large stack")
+__load_if_large_stack()
+__failure __msg("invalid variable-offset read from stack R2")
+__naked void access_min_out_of_bound_large(void)
+{
+	asm volatile ("					\
+	/* Fill the top 8 bytes of the stack */		\
+	r2 = 0;						\
+	*(u64*)(r10 - 8) = r2;				\
+	/* Get an unknown value */			\
+	r2 = *(u32*)(r1 + 0);				\
+	/* Make it small and 4-byte aligned */		\
+	r2 &= 4;					\
+	r2 -= 2052;					\
+	/*						\
+	 * add it to fp.  We now have either fp-2052 or fp-2048, but\
+	 * we don't know which				\
+	 */						\
+	r2 += r10;					\
+	/* dereference it indirectly */			\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 SEC("cgroup/skb")
 __description("indirect variable-offset stack access, min_off < min_initialized")
 __success
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 8b94b87135bc..0af237c02ddf 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1037,15 +1037,34 @@
 	.result = ACCEPT,
 },
 {
-	"calls: stack overflow using two frames (pre-call access)",
+	/*
+	 * Five 480-byte frames exceed the 2 KiB budget of JITs with large
+	 * stacks, and two of them the 512 bytes allowed elsewhere.
+	 */
+	"calls: stack overflow using five frames (pre-call access)",
 	.insns = {
 	/* prog 1 */
-	BPF_ST_MEM(BPF_B, BPF_REG_10, -300, 0),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
 	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1),
 	BPF_EXIT_INSN(),
 
 	/* prog 2 */
-	BPF_ST_MEM(BPF_B, BPF_REG_10, -300, 0),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1),
+	BPF_EXIT_INSN(),
+
+	/* prog 3 */
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1),
+	BPF_EXIT_INSN(),
+
+	/* prog 4 */
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1),
+	BPF_EXIT_INSN(),
+
+	/* prog 5 */
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -1054,15 +1073,30 @@
 	.result = REJECT,
 },
 {
-	"calls: stack overflow using two frames (post-call access)",
+	"calls: stack overflow using five frames (post-call access)",
 	.insns = {
 	/* prog 1 */
 	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 2),
-	BPF_ST_MEM(BPF_B, BPF_REG_10, -300, 0),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
 	BPF_EXIT_INSN(),
 
 	/* prog 2 */
-	BPF_ST_MEM(BPF_B, BPF_REG_10, -300, 0),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 2),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
+	BPF_EXIT_INSN(),
+
+	/* prog 3 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 2),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
+	BPF_EXIT_INSN(),
+
+	/* prog 4 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 2),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
+	BPF_EXIT_INSN(),
+
+	/* prog 5 */
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -1127,7 +1161,7 @@
 	.result = ACCEPT,
 },
 {
-	"calls: stack depth check using three frames. test3",
+	"calls: stack depth check using five frames. test3",
 	.insns = {
 	/* main */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
@@ -1135,66 +1169,104 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 8), /* call B */
 	BPF_JMP_IMM(BPF_JGE, BPF_REG_6, 0, 1),
-	BPF_ST_MEM(BPF_B, BPF_REG_10, -64, 0),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	/* A */
 	BPF_JMP_IMM(BPF_JLT, BPF_REG_1, 10, 1),
 	BPF_EXIT_INSN(),
-	BPF_ST_MEM(BPF_B, BPF_REG_10, -224, 0),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
 	BPF_JMP_IMM(BPF_JA, 0, 0, -3),
 	/* B */
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 2, 1),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, -6), /* call A */
-	BPF_ST_MEM(BPF_B, BPF_REG_10, -256, 0),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 2), /* call C */
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
+	BPF_EXIT_INSN(),
+	/* C */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 2), /* call D */
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
+	BPF_EXIT_INSN(),
+	/* D */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, -12), /* call A */
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
-	/* stack_main=64, stack_A=224, stack_B=256
-	 * and max(main+A, main+A+B) > 512
+	/*
+	 * every frame is 480 bytes, main+A = 960 > 512 and
+	 * max(main+A, main+B+C+D+A) = 2400 > 2048
 	 */
 	.errstr = "combined stack",
 	.result = REJECT,
 },
 {
-	"calls: stack depth check using three frames. test4",
-	/* void main(void) {
+	"calls: stack depth check using five frames. test4",
+	/*
+	 * void main(void) {
 	 *   func1(0);
 	 *   func1(1);
 	 *   func2(1);
 	 * }
-	 * void func1(int alloc_or_recurse) {
+	 * void funcN(int alloc_or_recurse) {   N = 1..4
 	 *   if (alloc_or_recurse) {
-	 *     frame_pointer[-300] = 1;
+	 *     frame_pointer[-480] = 1;
 	 *   } else {
-	 *     func2(alloc_or_recurse);
+	 *     funcN+1(alloc_or_recurse);
 	 *   }
 	 * }
-	 * void func2(int alloc_or_recurse) {
+	 * void func5(int alloc_or_recurse) {
 	 *   if (alloc_or_recurse) {
-	 *     frame_pointer[-300] = 1;
+	 *     frame_pointer[-480] = 1;
 	 *   }
 	 * }
+	 * main also calls func2 to func5 with 1 so that every function has a
+	 * path allocating its 480 bytes, and the chain adds up to 2400 bytes,
+	 * more than the 2 KiB budget of JITs with large stacks, and to 960
+	 * bytes after two frames, more than the 512 bytes allowed elsewhere.
 	 */
 	.insns = {
 	/* main */
 	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 6), /* call A */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 12), /* call A */
 	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 4), /* call A */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 10), /* call A */
+	BPF_MOV64_IMM(BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 13), /* call B */
+	BPF_MOV64_IMM(BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 16), /* call C */
 	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 7), /* call B */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 19), /* call D */
+	BPF_MOV64_IMM(BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 22), /* call E */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	/* A */
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 2),
-	BPF_ST_MEM(BPF_B, BPF_REG_10, -300, 0),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
 	BPF_EXIT_INSN(),
 	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call B */
 	BPF_EXIT_INSN(),
 	/* B */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 2),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
+	BPF_EXIT_INSN(),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call C */
+	BPF_EXIT_INSN(),
+	/* C */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 2),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
+	BPF_EXIT_INSN(),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call D */
+	BPF_EXIT_INSN(),
+	/* D */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 2),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
+	BPF_EXIT_INSN(),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call E */
+	BPF_EXIT_INSN(),
+	/* E */
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-	BPF_ST_MEM(BPF_B, BPF_REG_10, -300, 0),
+	BPF_ST_MEM(BPF_B, BPF_REG_10, -480, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
-- 
2.53.0

