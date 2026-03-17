Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A6236F435
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746343; cv=none; b=Mzr5OuydpF5BU0xwzEx6nsUTx78MuLujYuHyW3V3nm4e2T5cPpPPbHoQq1c75lAS8S/yha3Z/3O+oTl8Yk5tKlS02B2o5JxPaZHhBfH+e7K8z9pYb/CO71TIg6gv4lbOzCl8B9+X/0x19kYh0EWui3SheJu/9DkAWIq/UMrDGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746343; c=relaxed/simple;
	bh=Uqwysqa4YQf17vCw7Ai0DC3ilNtmo/saShotUw4BYQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOmD8gnpkkPw/mT+GEtpE5AyibzT0zLqal2zPX4YmeKIXqVsMU34/dxw6OW3sbIFBFIl9V32TVk/RtpTAzysQEshzDJZxsxG8sqj58R5FUulD9GVtupWez39aUXqN/8RwCFpdzlKF1u0dLy2aXxSjNGEM8odozhVPN3IEin2jAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEiWc5nJ; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEiWc5nJ"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-46702742c7dso1066214b6e.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 04:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746337; x=1774351137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNKG6sx5h75+rdXJg1xLXglDcj573DP+mDZmxlgvc6I=;
        b=HEiWc5nJKDlwiK7Q7DTp5gkmE/i/nRuFGoBGyCC/wpieXGRN/mpyNS0BSkiFyfxU+1
         Iz+BjhtoNLn4IeXgyzE1bT6xLloTHQdP9MYYPbyxNKUWw/omhZXwjzUX4o019nTNrPnQ
         7G+gAX0mTle1hzYtHbJX3InHFa7fVx1QsNgEBwx7kV6aGJSw0HobFs+Jgtn2DmzITWSF
         Yl+eku3PtKvHcFVQ5t3gVjfqc7pen33VL1XssgaEewwzv4/InBpVIKoN58Duj7KYTglf
         ZQhoLgZ3bMRzLNzRAtezDRkA3cAfq4ACpAP1uDmdMA6QlwfLlXpMtL2k/M8+G/GoMkib
         otHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746337; x=1774351137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNKG6sx5h75+rdXJg1xLXglDcj573DP+mDZmxlgvc6I=;
        b=Q8YRB9q9/HBlCHRwOrYRXuqdhd9t5Q2Y6RMTFIx9SjxyakHFDIffaIcSn2iM7WWFRo
         Yp8U2ZmFjdYBUbWMxQGnDXS6W8D/VKKH3Y982yCZYyr4DgQAHHynhYyAFert7ZIkU+yB
         m0WiL1rlvqUuVPhhk1IP0AK9fv4iZslpy0a/voPcZ3MUdvCumZ055K86cM44L96NlyFI
         qjwFhf/hCwJeHtiWkE/8aVoTDLHIRSiYOcITPQEFyVsi0YW5H0KOPyoTmOim8bNzSz8a
         yn/WgaHx2XqE5goUKwcydq1Z8adzxzKeIHXs17pgN9rf7wQ6dK3gA5SMNaetvTEJGs6T
         5xUA==
X-Gm-Message-State: AOJu0YxDCjH22+4GJkI7eqCgyDeYwvoh7RFSRKEyruoWqNMVP04cdgmm
	MmEtztwYiNBg4vJqBeMf2POfJYxQ3LXoRSnD2fo32eBiBrQserYAi7r4N1kFajt7Uf0=
X-Gm-Gg: ATEYQzxcA2IlS6scfxt4gMOwVkqhoEdMvqlWajMIzWWr6rENYT2Yi0LL3Nw493TJXoZ
	0nQbYWOxKDsSqviBgmPJdtc4PBW4ikiqD19r0q0FgjCgWshw7qKZQ3trnK5mTx34i0QsY5lkCiV
	ujQ95vboOGtCQg6M50qWIHCIRz6LOze2VJxAaP3/xXayxim2ZBclZD//Riw6tYYc6M+N8cY2psT
	iy3/cxwaYn8IaXSEBmvbF2NVv0FsPf5GjBU7k6L1BrJQrX55/lCyK+jXpmvV6V5dAUqcsttAj3c
	yfcRAHveOaSyNy9pE2HeKs711n4HJgZf+9Xl+Eni8/dN9dugA6E8z6SBpT6igmwX1cyCsGdmhTb
	R+LM5yuamZTp6e8YEvHuDivIGg9yX2OnjL2vrum+mC5CePLMD4/C4Bh+tqIOGr4cVzFBWxSZyzY
	/pVVEW31CyZr8OEUuBwOpdgVMnePQsxwn5YLdLBg/I/2j5
X-Received: by 2002:a05:6808:2e46:b0:450:839a:557 with SMTP id 5614622812f47-46757050889mr8765611b6e.9.1773746337493;
        Tue, 17 Mar 2026 04:18:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46734123939sm11190975b6e.3.2026.03.17.04.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:18:55 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/4] selftests/bpf: Adjust syscall ctx variable offset tests
Date: Tue, 17 Mar 2026 04:18:47 -0700
Message-ID: <20260317111850.2107846-3-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317111850.2107846-1-memxor@gmail.com>
References: <20260317111850.2107846-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17033; h=from:subject; bh=Uqwysqa4YQf17vCw7Ai0DC3ilNtmo/saShotUw4BYQ0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpuTHipysVkc4VhXHe5Njcy9FNPPTGZ8G0+qmmrJWO asMtTDCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabkx4gAKCRBM4MiGSL8RyiI4D/ 9jM8HcX8hKlkEz/ylWbJll68zqlEWFI4lbYWBhtqCdXxcd8pA87PeCzGqhUANwofzChvirYN+0PMX5 N2TNT9+dVVJIYhepAuZUjV7S8gZOyZX4PJWqTCsbjmDFIsNUHZavQDiELGW/5ny6BvxKOPnxyo/NEF 41G8T0J0n4lHZUaU/VrmhzOftefHqrG2qyJulDwpQb7KmwORgNTXywp2XyQwHeFtgYJ9tKO3WLOzib 9nQojx0PMqkR9grOLyWxq7L23QWmtDBZSdgfYjwRS3MijFrFsMgk9bBXDfbfjVPk/9Vy7YGmDmdhSi K2HTVs8/7yk5tA3RrWAHZFswf1qZHACSxSFQwGe91Mk2XWY2v4jhDpGYR/oFAre2YRUfmvoi6kqNIo +DJZwzniIlM2q1ObC1tv1GcbzgN2Qqnni6nowESpc/fOU5L84LCnKfQr8kv1Q42RtJIdStZBO02g6L t866B08dxJPV6ov9oNTZPc36lvndVU73BGUQ1zW7v6GfApGPqitPeK2E1JFk1MQWoJa+tAQ0wynT60 GwEzFmnloytMzyk7EyRtoRQfDHmZcraUmSu0bWk3q1G8FuDKfarJ/v+MCke1gemRPL7GP/2LZTAxs7 2llgv5kDOuJ9tJCjjgEdUBas/lcdwKxmNLhrd39MEwCxTdahxynAjuvn8anQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add various tests to exercise fixed and variable offsets on PTR_TO_CTX
for syscall programs, and cover disallowed cases for other program types
lacking convert_ctx_access callback. Load verifier_ctx with CAP_SYS_ADMIN
so that kfunc related logic can be tested. While at it, convert assembly
tests to C.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  34 +-
 .../selftests/bpf/progs/verifier_ctx.c        | 356 +++++++++++++++---
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
 3 files changed, 325 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8cdfd74c95d7..04d5f46264a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -126,29 +126,35 @@ struct test_val {
 __maybe_unused
 static void run_tests_aux(const char *skel_name,
 			  skel_elf_bytes_fn elf_bytes_factory,
-			  pre_execution_cb pre_execution_cb)
+			  pre_execution_cb pre_execution_cb,
+			  bool drop_sys_admin)
 {
 	struct test_loader tester = {};
 	__u64 old_caps;
 	int err;
 
-	/* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here */
-	err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
-	if (err) {
-		PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
-		return;
+	if (drop_sys_admin) {
+		/* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here */
+		err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
+		if (err) {
+			PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
+			return;
+		}
 	}
 
 	test_loader__set_pre_execution_cb(&tester, pre_execution_cb);
 	test_loader__run_subtests(&tester, skel_name, elf_bytes_factory);
 	test_loader_fini(&tester);
 
-	err = cap_enable_effective(old_caps, NULL);
-	if (err)
-		PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
+	if (drop_sys_admin) {
+		err = cap_enable_effective(old_caps, NULL);
+		if (err)
+			PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
+	}
 }
 
-#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
+#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL, true)
+#define RUN_WITH_CAP_SYS_ADMIN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL, false)
 
 void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
@@ -173,7 +179,7 @@ void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
 void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
 void test_verifier_const(void)                { RUN(verifier_const); }
 void test_verifier_const_or(void)             { RUN(verifier_const_or); }
-void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
+void test_verifier_ctx(void)                  { RUN_WITH_CAP_SYS_ADMIN(verifier_ctx); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_d_path(void)               { RUN(verifier_d_path); }
 void test_verifier_default_trusted_ptr(void)  { RUN_TESTS(verifier_default_trusted_ptr); }
@@ -293,7 +299,8 @@ void test_verifier_array_access(void)
 {
 	run_tests_aux("verifier_array_access",
 		      verifier_array_access__elf_bytes,
-		      init_array_access_maps);
+		      init_array_access_maps,
+		      true);
 }
 void test_verifier_async_cb_context(void)    { RUN(verifier_async_cb_context); }
 
@@ -306,5 +313,6 @@ void test_verifier_value_ptr_arith(void)
 {
 	run_tests_aux("verifier_value_ptr_arith",
 		      verifier_value_ptr_arith__elf_bytes,
-		      init_value_ptr_arith_maps);
+		      init_value_ptr_arith_maps,
+		      true);
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index 371780290c0d..c054c8cb7242 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -4,6 +4,10 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+const char ctx_strncmp_target[] = "ctx";
+const char ctx_snprintf_fmt[] = "";
 
 SEC("tc")
 __description("context stores via BPF_ATOMIC")
@@ -69,7 +73,6 @@ __naked void ctx_pointer_to_helper_1(void)
 SEC("socket")
 __description("pass modified ctx pointer to helper, 2")
 __failure __msg("negative offset ctx ptr R1 off=-612 disallowed")
-__failure_unpriv __msg_unpriv("negative offset ctx ptr R1 off=-612 disallowed")
 __naked void ctx_pointer_to_helper_2(void)
 {
 	asm volatile ("					\
@@ -295,77 +298,324 @@ padding_access("sk_reuseport", sk_reuseport_md, hash, 4);
 SEC("syscall")
 __description("syscall: write to ctx with fixed offset")
 __success
-__naked void syscall_ctx_fixed_off_write(void)
+int syscall_ctx_fixed_off_write(void *ctx)
 {
-	asm volatile ("					\
-	r0 = 0;						\
-	*(u32*)(r1 + 0) = r0;				\
-	r1 += 4;					\
-	*(u32*)(r1 + 0) = r0;				\
-	exit;						\
-"	::: __clobber_all);
+	char *p = ctx;
+
+	*(__u32 *)p = 0;
+	*(__u32 *)(p + 4) = 0;
+	return 0;
+}
+
+SEC("syscall")
+__description("syscall: read ctx with fixed offset")
+__success
+int syscall_ctx_fixed_off_read(void *ctx)
+{
+	char *p = ctx;
+	volatile __u32 val;
+
+	val = *(__u32 *)(p + 4);
+	(void)val;
+	return 0;
+}
+
+SEC("syscall")
+__description("syscall: read ctx with variable offset")
+__success
+int syscall_ctx_var_off_read(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+	volatile __u32 val;
+
+	off &= 0xfc;
+	p += off;
+	val = *(__u32 *)p;
+	(void)val;
+	return 0;
+}
+
+SEC("syscall")
+__description("syscall: write ctx with variable offset")
+__success
+int syscall_ctx_var_off_write(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	p += off;
+	*(__u32 *)p = 0;
+	return 0;
+}
+
+SEC("syscall")
+__description("syscall: reject negative variable offset ctx access")
+__failure __msg("min value is negative")
+int syscall_ctx_neg_var_off(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 4;
+	p -= off;
+	return *(__u32 *)p;
+}
+
+SEC("syscall")
+__description("syscall: reject unbounded variable offset ctx access")
+__failure __msg("unbounded memory access")
+int syscall_ctx_unbounded_var_off(void *ctx)
+{
+	__u64 off = (__u32)bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off <<= 2;
+	p += off;
+	return *(__u32 *)p;
+}
+
+SEC("syscall")
+__description("syscall: helper read ctx with fixed offset")
+__success
+int syscall_ctx_helper_fixed_off_read(void *ctx)
+{
+	char *p = ctx;
+
+	p += 4;
+	return bpf_strncmp(p, 4, ctx_strncmp_target);
+}
+
+SEC("syscall")
+__description("syscall: helper write ctx with fixed offset")
+__success
+int syscall_ctx_helper_fixed_off_write(void *ctx)
+{
+	char *p = ctx;
+
+	p += 4;
+	return bpf_probe_read_kernel(p, 4, 0);
+}
+
+SEC("syscall")
+__description("syscall: helper read ctx with variable offset")
+__success
+int syscall_ctx_helper_var_off_read(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	p += off;
+	return bpf_strncmp(p, 4, ctx_strncmp_target);
+}
+
+SEC("syscall")
+__description("syscall: helper write ctx with variable offset")
+__success
+int syscall_ctx_helper_var_off_write(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	p += off;
+	return bpf_probe_read_kernel(p, 4, 0);
+}
+
+SEC("syscall")
+__description("syscall: helper read zero-sized ctx access")
+__success
+int syscall_ctx_helper_zero_sized_read(void *ctx)
+{
+	return bpf_snprintf(0, 0, ctx_snprintf_fmt, ctx, 0);
+}
+
+SEC("syscall")
+__description("syscall: helper write zero-sized ctx access")
+__success
+int syscall_ctx_helper_zero_sized_write(void *ctx)
+{
+	return bpf_probe_read_kernel(ctx, 0, 0);
+}
+
+SEC("syscall")
+__description("syscall: kfunc access ctx with fixed offset")
+__success
+int syscall_ctx_kfunc_fixed_off(void *ctx)
+{
+	char *p = ctx;
+
+	p += 4;
+	bpf_kfunc_call_test_mem_len_pass1(p, 4);
+	return 0;
+}
+
+SEC("syscall")
+__description("syscall: kfunc access ctx with variable offset")
+__success
+int syscall_ctx_kfunc_var_off(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	p += off;
+	bpf_kfunc_call_test_mem_len_pass1(p, 4);
+	return 0;
+}
+
+SEC("syscall")
+__description("syscall: kfunc access zero-sized ctx")
+__success
+int syscall_ctx_kfunc_zero_sized(void *ctx)
+{
+	bpf_kfunc_call_test_mem_len_pass1(ctx, 0);
+	return 0;
 }
 
 /*
- * Test that program types without convert_ctx_access can dereference
- * their ctx pointer after adding a fixed offset. Variable and negative
- * offsets should still be rejected.
+ * For non-syscall program types without convert_ctx_access, direct ctx
+ * dereference is still allowed after adding a fixed offset, while variable
+ * and negative direct accesses reject.
+ *
+ * Passing ctx as a helper or kfunc memory argument is only permitted for
+ * syscall programs, so the helper and kfunc cases below validate rejection
+ * for non-syscall ctx pointers at fixed, variable, and zero-sized accesses.
  */
-#define no_rewrite_ctx_access(type, name, off, ld_op)			\
+#define no_rewrite_ctx_access(type, name, off, load_t)			\
 	SEC(type)							\
 	__description(type ": read ctx at fixed offset")		\
 	__success							\
-	__naked void no_rewrite_##name##_fixed(void)			\
+	int no_rewrite_##name##_fixed(void *ctx)			\
 	{								\
-		asm volatile ("						\
-		r1 += %[__off];						\
-		r0 = *(" #ld_op " *)(r1 + 0);				\
-		r0 = 0;							\
-		exit;"							\
-		:							\
-		: __imm_const(__off, off)				\
-		: __clobber_all);					\
+		char *p = ctx;						\
+		volatile load_t val;					\
+									\
+		val = *(load_t *)(p + off);				\
+		(void)val;						\
+		return 0;						\
 	}								\
 	SEC(type)							\
 	__description(type ": reject variable offset ctx access")	\
 	__failure __msg("variable ctx access var_off=")			\
-	__naked void no_rewrite_##name##_var(void)			\
+	int no_rewrite_##name##_var(void *ctx)			\
 	{								\
-		asm volatile ("						\
-		r6 = r1;						\
-		call %[bpf_get_prandom_u32];				\
-		r1 = r6;						\
-		r0 &= 4;						\
-		r1 += r0;						\
-		r0 = *(" #ld_op " *)(r1 + 0);				\
-		r0 = 0;							\
-		exit;"							\
-		:							\
-		: __imm(bpf_get_prandom_u32)				\
-		: __clobber_all);					\
+		__u64 off_var = bpf_get_prandom_u32();			\
+		char *p = ctx;						\
+									\
+		off_var &= 4;						\
+		p += off_var;						\
+		return *(load_t *)p;					\
 	}								\
 	SEC(type)							\
 	__description(type ": reject negative offset ctx access")	\
-	__failure __msg("negative offset ctx ptr")			\
-	__naked void no_rewrite_##name##_neg(void)			\
+	__failure __msg("invalid bpf_context access")			\
+	int no_rewrite_##name##_neg(void *ctx)			\
 	{								\
-		asm volatile ("						\
-		r1 += %[__neg_off];					\
-		r0 = *(" #ld_op " *)(r1 + 0);				\
-		r0 = 0;							\
-		exit;"							\
-		:							\
-		: __imm_const(__neg_off, -(off))			\
-		: __clobber_all);					\
+		char *p = ctx;						\
+									\
+		p -= 612;						\
+		return *(load_t *)p;					\
+	}								\
+	SEC(type)							\
+	__description(type ": reject helper read ctx at fixed offset")	\
+	__failure __msg("dereference of modified ctx ptr")		\
+	int no_rewrite_##name##_helper_read_fixed(void *ctx)		\
+	{								\
+		char *p = ctx;						\
+									\
+		p += off;						\
+		return bpf_strncmp(p, 4, ctx_strncmp_target);		\
+	}								\
+	SEC(type)							\
+	__description(type ": reject helper write ctx at fixed offset")	\
+	__failure __msg("dereference of modified ctx ptr")		\
+	int no_rewrite_##name##_helper_write_fixed(void *ctx)		\
+	{								\
+		char *p = ctx;						\
+									\
+		p += off;						\
+		return bpf_probe_read_kernel(p, 4, 0);			\
+	}								\
+	SEC(type)							\
+	__description(type ": reject helper read ctx with variable offset") \
+	__failure __msg("variable ctx access var_off=")			\
+	int no_rewrite_##name##_helper_read_var(void *ctx)		\
+	{								\
+		__u64 off_var = bpf_get_prandom_u32();			\
+		char *p = ctx;						\
+									\
+		off_var &= 4;						\
+		p += off_var;						\
+		return bpf_strncmp(p, 4, ctx_strncmp_target);		\
+	}								\
+	SEC(type)							\
+	__description(type ": reject helper write ctx with variable offset") \
+	__failure __msg("variable ctx access var_off=")			\
+	int no_rewrite_##name##_helper_write_var(void *ctx)		\
+	{								\
+		__u64 off_var = bpf_get_prandom_u32();			\
+		char *p = ctx;						\
+									\
+		off_var &= 4;						\
+		p += off_var;						\
+		return bpf_probe_read_kernel(p, 4, 0);			\
+	}								\
+	SEC(type)							\
+	__description(type ": reject helper read zero-sized ctx access") \
+	__failure __msg("R4 type=ctx expected=fp")			\
+	int no_rewrite_##name##_helper_read_zero(void *ctx)		\
+	{								\
+		return bpf_snprintf(0, 0, ctx_snprintf_fmt, ctx, 0);	\
+	}								\
+	SEC(type)							\
+	__description(type ": reject helper write zero-sized ctx access") \
+	__failure __msg("R1 type=ctx expected=fp")			\
+	int no_rewrite_##name##_helper_write_zero(void *ctx)		\
+	{								\
+		return bpf_probe_read_kernel(ctx, 0, 0);			\
+	}								\
+	SEC(type)							\
+	__description(type ": reject kfunc ctx at fixed offset")	\
+	__failure __msg("dereference of modified ctx ptr")		\
+	int no_rewrite_##name##_kfunc_fixed(void *ctx)		\
+	{								\
+		char *p = ctx;						\
+									\
+		p += off;						\
+		bpf_kfunc_call_test_mem_len_pass1(p, 4);		\
+		return 0;						\
+	}								\
+	SEC(type)							\
+	__description(type ": reject kfunc ctx with variable offset")	\
+	__failure __msg("variable ctx access var_off=")			\
+	int no_rewrite_##name##_kfunc_var(void *ctx)			\
+	{								\
+		__u64 off_var = bpf_get_prandom_u32();			\
+		char *p = ctx;						\
+									\
+		off_var &= 4;						\
+		p += off_var;						\
+		bpf_kfunc_call_test_mem_len_pass1(p, 4);		\
+		return 0;						\
+	}								\
+	SEC(type)							\
+	__description(type ": reject kfunc zero-sized ctx access")	\
+	__failure __msg("R1 type=ctx expected=fp")			\
+	int no_rewrite_##name##_kfunc_zero(void *ctx)			\
+	{								\
+		bpf_kfunc_call_test_mem_len_pass1(ctx, 0);		\
+		return 0;						\
 	}
 
-no_rewrite_ctx_access("syscall", syscall, 4, u32);
-no_rewrite_ctx_access("kprobe", kprobe, 8, u64);
-no_rewrite_ctx_access("tracepoint", tp, 8, u64);
-no_rewrite_ctx_access("raw_tp", raw_tp, 8, u64);
-no_rewrite_ctx_access("raw_tracepoint.w", raw_tp_w, 8, u64);
-no_rewrite_ctx_access("fentry/bpf_modify_return_test", fentry, 8, u64);
-no_rewrite_ctx_access("cgroup/dev", cgroup_dev, 4, u32);
-no_rewrite_ctx_access("netfilter", netfilter, offsetof(struct bpf_nf_ctx, skb), u64);
+no_rewrite_ctx_access("kprobe", kprobe, 8, __u64);
+no_rewrite_ctx_access("tracepoint", tp, 8, __u64);
+no_rewrite_ctx_access("raw_tp", raw_tp, 8, __u64);
+no_rewrite_ctx_access("raw_tracepoint.w", raw_tp_w, 8, __u64);
+no_rewrite_ctx_access("fentry/bpf_modify_return_test", fentry, 8, __u64);
+no_rewrite_ctx_access("cgroup/dev", cgroup_dev, 4, __u32);
+no_rewrite_ctx_access("netfilter", netfilter, offsetof(struct bpf_nf_ctx, skb), __u64);
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 94edbd2afa67..f91b484d80f2 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -716,6 +716,7 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_value)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE)
@@ -1280,7 +1281,6 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_acquire, KF_ACQUIRE | KF_RET_NULL)
-- 
2.52.0

