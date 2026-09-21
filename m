Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE8F30BF70
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958341; cv=none; b=lNxy0Vpsp26lcOb4V7mK7+DnjrxRHkqyeF9Dq7hgcpRDPmQbSnOY1vwkHmaTbvQEwf2eeIUjGY/Zuq9pWmasDgEs85i+oOVuU9OQRLvYxK31WdDVFteEa79KkBqHP8WvBVIdF1Wkuy0SQ5k09kobH8kKyD+ynW26RuAsAfpNwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958341; c=relaxed/simple;
	bh=XUmBoZ+0f9e7bZHCIKXfEURJ57R2He88i2rFQa/tnVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cG8dkKhHyCfu/7oB4qydcNHTOqgmCKsmmqLas7DRfniYClXxv3+O//1FyD986ao8cCAvZM+4CDr4/1cr18XjYkGSFSDDJqT5enmyI8XphRN9A3cGLv88tfeCcbSN0GSZnX4ZkX0gnj6bTwK+/OPuO2xpmQo+A7+qGXWdUsvGBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6VC12X5; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6VC12X5"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e7b06acb8so9786905e9.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789958337; x=1790563137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pKvsBOoNgMCbH65i+dcJhUE7IH90v1GuVec087ThqfA=;
        b=J6VC12X5N1oxLNHE1I2oEYaEFHw+Pj7GSM31NS5vexqFc9KdMJ5mIu+/+dvfRbIGx0
         3vfA99Wnkkimdq2juUn246jHpe7JPcElpiFcw/RxHUojY4iVtTpgtQ66RpbKyDxbM9Xj
         PdYo/K3fs81bebtj+V9n5g0TmN0YH+egv0NW9MdEdZa3MNwAdoJVDPtsX4RLfyUHpCWm
         jhBoAjw/Tz0NAFi966GMI4Ijd+X7CEwZDV4YqKUxdPBbpDu/DjK0cp/C4cE2uWTFKdj+
         S7ZMw/NwxyVBscq2T7BbzbJsdqEfdt/rwU0B5qL+8WGA1sNZPmXhqPKeYBAjOWUoRamy
         BAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958337; x=1790563137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pKvsBOoNgMCbH65i+dcJhUE7IH90v1GuVec087ThqfA=;
        b=HvlfixeqSQyPqe0vbVXFikKs324KdDdbJix9FS4IXpQYDaUk/TB1D2W0VDKfPk1TLA
         MJzo9p8omKZ3yq09lVEq4ITSrxn/S2TxWlgvOdKMPxfJNXV0FhIc9VfT7H2QRm35oPQ/
         /nbFUQP6oeOVICrh+P3yFVOwQAVUYgs1ejCSbbPas5JfwNkIIgDusHRWAuSgLVC+6z2U
         kPdMcP5PXwRjoafjvbZy0w8/v80TT7bTRbNZoANSILUX4i9MZbWjs31cRW+eDP5F2YAr
         oUxLbHjF7YnHFVSYv59dEly9spAK+Cz3Epil4aSB7nrOdXMtoYpk9Cf+Ue1H77pFXfZg
         WP8Q==
X-Gm-Message-State: AFuF++kaBUFa3laXm5VfJbw1V4cnilNiQvwoyOynw1HaptgiB3ueLYsN
	eGyZOd4c6Usx88eVAe0VkjOFrIykxkWH5Q4Tm3B7nq96jiEnK9GPmtPaU9J3SW+F
X-Gm-Gg: AYBFou1Z8bXGSFJzzIdYr2Q+4w3Y1pwLB5FoIm/XBaaLlYk5ObKLBImKEgqVu/CI2km
	NpAlogOUAbpdgCSepzklUnnYWbLPx+SuR5tbpYxoRNFe3V6BmFQjnCkfjAks8CLhufLvou8WSXh
	BP76U72nzNycePJ4MtNMUPs5FVI9ZOWJGSQNZHA9VtHGw6k206SbyFTi5wma+taLEDHi87b4ULi
	LF6ghmskzFNI53e0sdIEkBe3cUz+qXxQ458x4yX0UpfqzpSrDDdUJTpP/YovnyM9mp34khsrzGa
	hxBYhc88VdG53kkM8/rygSIVRJgaR5LpeQtJhtWB9048hg5zsLLD+awkqGK+9klB9MA1o2GcxCQ
	ogHtLWkH2ArM5vVQ1hrHrwgUSxcYNCNwIVloUszbWQhbqR2DrlXAx83nnyCN51WdOlYl66Z0h+0
	74neb7ClW6ijvl1VCERWLfugtf56Ii5KqihA6h+QsEZhYdyhEUNQ+C6lm7WEUMuhmCq6CmD8ZnM
	hMShmsWExDV4wbDq5AgVAleqqMb75axIDcGFemMwCuU12z38Z52rBFU1vdcL9AsxW4RTOa76kTx
	2rLJPhY5EP3uctealJlVZGiWb6P6WOX4vJiFCA==
X-Received: by 2002:a05:600c:3b96:b0:49f:ce73:4a with SMTP id 5b1f17b1804b1-49fce7300a2mr85644435e9.34.1789958337530;
        Sun, 20 Sep 2026 19:38:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc521f5d9sm95088515e9.2.2026.09.20.19.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:38:57 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 07/11] selftests/bpf: Cover __uninit kfunc output argument slots
Date: Mon, 21 Sep 2026 04:38:31 +0200
Message-ID: <20260921023843.411943-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921023843.411943-1-memxor@gmail.com>
References: <20260921023843.411943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7863; i=memxor@gmail.com; h=from:subject; bh=XUmBoZ+0f9e7bZHCIKXfEURJ57R2He88i2rFQa/tnVw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvD9C3M61T8TLfPfnVDuHpDXMFpmZjS6L7zD6VE804Js jnvON7RUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkUOzMyPGCW6ze5ZmyfvPxo 89LX5vP5D+r2/Y05I8b1MjfvVey8FYwMD39X7nbk31U8qYBNhe+9/ouU+MnscX/Krf+4LmJkS97 CDQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Keep coverage for per-slot output tracking separate from the immediate
single-output regression tests. Check that both constant-size outputs are
initialized, and that a variable-size output does not disable initialization
of an independent constant-size output.

Also exercise an output following a by-value parameter that occupies two
argument slots, and an output pointer passed on the stack. Run each case
with normal capabilities and with CAP_BPF and CAP_NET_ADMIN only. Leave the
stack-passed output uninitialized so its reduced-capability case fails if
the verifier treats it as an ordinary input buffer.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_kfunc_uninit_multi.c   | 113 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  20 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   4 +
 4 files changed, 139 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index ffeba2d1464a..4f1e1c1cd5ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -57,6 +57,7 @@
 #include "verifier_jit_convergence.skel.h"
 #include "verifier_kfunc_packet_access.skel.h"
 #include "verifier_kfunc_uninit.skel.h"
+#include "verifier_kfunc_uninit_multi.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
@@ -225,6 +226,7 @@ void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null)
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
 void test_verifier_kfunc_packet_access(void)  { RUN_TESTS(verifier_kfunc_packet_access); }
 void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_uninit); }
+void test_verifier_kfunc_uninit_multi(void)   { RUN_TESTS(verifier_kfunc_uninit_multi); }
 void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c
new file mode 100644
index 000000000000..18ced0d0a3b2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+/* Keep the kfunc BTF records used by the inline assembly. */
+void __kfunc_btf_root(void)
+{
+	asm volatile ("" :
+		: "r"(&bpf_kfunc_test_uninit_multi),
+		  "r"(&bpf_kfunc_test_uninit_pair),
+		  "r"(&bpf_kfunc_test_uninit_stack));
+}
+
+SEC("tc")
+__success __retval(42)
+__flag(BPF_F_TEST_STATE_FREQ)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void multiple_outputs(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 16) = 0;"
+		"*(u64 *)(r10 - 8) = 0;"
+		"goto +0;"
+		"r1 = r10;"
+		"r1 += -16;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"r3 = 8;"
+		"call %[bpf_kfunc_test_uninit_multi];"
+		"r0 = *(u32 *)(r10 - 16);"
+		"r1 = *(u32 *)(r10 - 8);"
+		"if r1 != 0x2a2a2a2a goto 1f;"
+		"r1 = *(u32 *)(r10 - 4);"
+		"if r1 == 0x2a2a2a2a goto 2f;"
+	"1:;"
+		"r0 = 0;"
+	"2:;"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_multi) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(42)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void variable_size_preserves_other_output(void)
+{
+	asm volatile (
+		"r3 = *(u32 *)(r1 + 0);"
+		"r3 &= 7;"
+		"*(u64 *)(r10 - 8) = 0;"
+		"r1 = r10;"
+		"r1 += -16;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"call %[bpf_kfunc_test_uninit_multi];"
+		"r0 = *(u32 *)(r10 - 16);"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_multi) : __clobber_all);
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__success __retval(42)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void output_after_by_value_argument(void)
+{
+	asm volatile (
+		"r1 = 20;"
+		"r2 = 22;"
+		"r3 = r10;"
+		"r3 += -8;"
+		"call %[bpf_kfunc_test_uninit_pair];"
+		"r0 = *(u32 *)(r10 - 8);"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_pair) : __clobber_all);
+}
+
+#if defined(__BPF_FEATURE_STACK_ARGUMENT)
+SEC("tc")
+__arch_x86_64 __arch_arm64 __arch_riscv64
+__success __retval(15)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void output_passed_on_stack(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = 3;"
+		"r4 = 4;"
+		"r5 = 5;"
+		"r6 = r10;"
+		"r6 += -8;"
+		"*(u64 *)(r11 - 8) = r6;"
+		"call %[bpf_kfunc_test_uninit_stack];"
+		"r0 = *(u32 *)(r10 - 8);"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_stack) : __clobber_all);
+}
+#endif
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 542edeb28b27..211886a8ee87 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1338,6 +1338,23 @@ __bpf_kfunc int bpf_kfunc_test_uninit_alias(int *out__uninit, const int *in)
 	return value;
 }
 
+__bpf_kfunc void bpf_kfunc_test_uninit_multi(int *a__uninit, void *b__uninit, u32 b__sz)
+{
+	put_unaligned(42, a__uninit);
+	memset(b__uninit, 0x2a, b__sz);
+}
+
+__bpf_kfunc void bpf_kfunc_test_uninit_pair(struct prog_test_pair_arg p, int *out__uninit)
+{
+	put_unaligned((int)(p.lo + p.hi), out__uninit);
+}
+
+__bpf_kfunc void bpf_kfunc_test_uninit_stack(u64 a, u64 b, u64 c, u64 d, u64 e,
+					     int *out__uninit)
+{
+	put_unaligned((int)(a + b + c + d + e), out__uninit);
+}
+
 __bpf_kfunc void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
 {
 }
@@ -1772,6 +1789,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
 BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_struct)
 BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_mem)
 BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_alias)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_multi)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_pair)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_stack)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 91b64e783123..524f2cb9bdf4 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -292,6 +292,10 @@ void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
 void bpf_kfunc_test_uninit_struct(struct prog_test_pass1 *out__uninit) __ksym;
 void bpf_kfunc_test_uninit_mem(void *out__uninit, __u32 out__sz) __ksym;
 int bpf_kfunc_test_uninit_alias(int *out__uninit, const int *in) __ksym;
+void bpf_kfunc_test_uninit_multi(int *a__uninit, void *b__uninit, __u32 b__sz) __ksym;
+void bpf_kfunc_test_uninit_pair(struct prog_test_pair_arg p, int *out__uninit) __ksym;
+void bpf_kfunc_test_uninit_stack(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
+				 int *out__uninit) __ksym;
 void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 
 void bpf_kfunc_call_test_destructive(void) __ksym;
-- 
2.53.0

