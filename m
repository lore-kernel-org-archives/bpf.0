Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E8559C9D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190736; cv=none; b=NmdDIAEfjr0n5eof/bdRyy3hfDiP9K/L96rKmfcLfsx4vMKsQ7Nwfk6MwRDYHrooUxthOpoGr1sXvRM67CsdbrrNF5DNnCIew0T2Z9p6jMXCClv8YabfKE8LMIVfgyhB1aapzSKxkfibiSsfabZtcC3uHSNHgOCbyijjByZ19S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190736; c=relaxed/simple;
	bh=WyZyGqltx4YeNntXmUsWb4MIDjeTqNNMMIP59fMEuc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0IQX/A7jDgymWZfTebHmn7aalyUmiCYydxYqYROBJiqHe/HAbi930bzYvmz7hepAKVPyclt+jtDZqhDYkjx2pHkfYLAPnpu4emcZDDWY5Fdpts0B2txm/fFKmMWaTChb7Su4ukrloFVpzkbZn88Zmlontl1t03mdQPU89CYvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joq0FxDN; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joq0FxDN"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso4177205e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190732; x=1790795532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qgg0DxL6HBROdhtCBDGfqLOmC+Zh1oMRIZYTPeIkKlA=;
        b=joq0FxDNWRmBsy6BwDm7+nJ3MWtD0BJxM+aoYnEUtYf+FB6MnYmViH/40bCb8RKbZ2
         4EzUMrzqTC9bAv3wtcyvuULdyULosL7JqPvcZ/xY+cnyHaP+aSMzz/P/RE123afaZBgQ
         QLR8WCefdLhV2jZV40ga4MzGqgEb1Mbv3dczJJarQ1kdUjYSZI+BzosoJVTSWURaVeDs
         GyOQ9xA8Ru+OKR8w3Jp5sFAh0BrEXd5aIv4LuSqrzoCJrpulIYUPjBZZVSMi7ctxp5wS
         YZeWWyxPdzhOQxawUS2dvjni6mC6wLKX2hog9w7calpVWVYog8DMd4yDKki2TK3/LfTM
         Wt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190732; x=1790795532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qgg0DxL6HBROdhtCBDGfqLOmC+Zh1oMRIZYTPeIkKlA=;
        b=GvA+ciGEgY0kbqyi+MiGWQifq1zF7Pc0vgn6zN0Q/u4SRLsPh8lST37AuXuYQPO3WP
         hynkrlXXj014I54az/iCidpL2gHGnPpaCCwyWsi+XIXmBD2ZTJC6dchdgA3VyAdxsUC7
         OucyrjkchK52nF3b+OituNQ256M0Ke/X9SIkWHCtQUYe3VEyqVUj6GDdOnI7tB2T3HSX
         pjQDIzksy/0Gza5J71vkRXr+th7veZT085Hgql0Y+WttOVjZt48p+HwD/JOsboqZejbr
         /VnLQJYdVSulWLqUFD3o1//FinyZ1Wg+MLdkjmIG43Dow+o5UAvRutPsv3oEux7akdQ5
         jrYw==
X-Gm-Message-State: AFuF++kOBwvrPOy50Yds4G2kGO/zTiezNEXneiCGhCfX+ERdJcFqIzxA
	E2GT0jSOBFkWs1sm96VFrWXE32NNhjCMmIxCQGHbgQeInCrEgcEJrNBbq6txrTKc
X-Gm-Gg: AYBFou2CNctBWLespbspfAa2x0N6SYS78zPndtFdnx1+FuIu6oPcqHz5ZGTrm4ZiBqq
	JWUBiod6rADgKnWphJvYtfq5HuXBqM+Fic99L1tXE/Hn9p3cLhOjbz9uB7z2b+U/3itKIcPvzhU
	q3vtbu31b+R/HZ59gWoXdPI0QcvyivgvSc7Un5gxrwtOtTtsSxptJs8NUvw0bMiklVdDqpYRxoB
	7ko36GtjIfqGxf5s851U4vb80/o8RLvftnelL2bPqqzjlK8Az0l/erMyaqiSCzNfI66ZxYY8/jG
	V5ZZR/mpkJSkXd2Jn4jCbwqvFmyE4vJKK0iEMB4CGuj+UCC0YgwINoMXCXJSqndLk4RngV/c8ou
	HnLhlqblIq/xLmf3FE0xJqPIcpOq3AXMNUec6UJWtZdzn6Bfcgz9rlL59Sz8yEjxfI/K3nMx4PG
	lWqvcTjsN4YN2WuipYZ+aZ43liBNEiWCD+JhTe/uCHcR2e1hwCNouBv/ELuqqB/nhS+aiQN1S52
	CwpKe+s87pvTDYWc+8VcKGFnQlFTtRX/T5I9ktl92b7lPAhpiwqVKGiJRPjMiNGpjUX1Q5SJo+D
	7UYag8IJcUN75uFZ7CERoxnAKHD27mp7wE9YZdpzPRE59nKd
X-Received: by 2002:a05:600c:83c4:b0:49c:fa21:1c89 with SMTP id 5b1f17b1804b1-49fe670d822mr1991565e9.30.1790190731735;
        Wed, 23 Sep 2026 12:12:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c3731fsm76436425e9.2.2026.09.23.12.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:12:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 15/18] selftests/bpf: Give the 512-byte stack boundary tests a 2 KiB twin
Date: Wed, 23 Sep 2026 21:11:22 +0200
Message-ID: <20260923191139.2816206-16-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24031; i=memxor@gmail.com; h=from:subject; bh=WyZyGqltx4YeNntXmUsWb4MIDjeTqNNMMIP59fMEuc0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4g/TqNmVbSVWsi6LnxReCT/7esouIZN3leHsFzUWx W8X2WnRUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkkH2Bk2NpvrR2jVsA765jA 4127NyQ6Jad9W1bD4HP/Ze6NMOX72Qz/jJy5E55zWdUvnScWOHXRxM4vR56cWj8rOLfyikV0pcN LRgA=
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
chains.

No kernel grants the larger budget yet, so the 512-byte tests still run
everywhere and the 2 KiB twins are skipped.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/async_stack_depth.c   |  75 +++++++++++
 .../bpf/progs/struct_ops_private_stack_fail.c |  47 ++++++-
 .../selftests/bpf/progs/test_global_func1.c   |  65 ++++++++++
 .../bpf/progs/test_global_func_deep_stack.c   |  33 ++++-
 .../selftests/bpf/progs/verifier_live_stack.c |   4 +-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  21 +++
 .../selftests/bpf/progs/verifier_stack_ptr.c  |  53 ++++++++
 .../selftests/bpf/progs/verifier_var_off.c    |  32 +++++
 tools/testing/selftests/bpf/verifier/calls.c  | 122 ++++++++++++++----
 9 files changed, 421 insertions(+), 31 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index dec2230f32aa..7be813f06a5a 100644
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

