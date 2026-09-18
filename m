Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1944D331EB0
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709364; cv=none; b=p8sNXzJaLd/pwytVOBg9lK/kxEU9Hszj7giDZnPP3MmAe/GtDT3rHYpS+JZ2oImaVk333WycI8z5SBAXIKs8D8vyRsIon9JelH0sE+VeStrrAzhd8LJjofGMMYRriC8bPopSEq3nzYn5Xwo0DyHwkVo9nNAWnGk5vGcgHnQOW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709364; c=relaxed/simple;
	bh=AtZpPaK5IM9I2QRoUqsCrTpb7PGhX2wEY0g4W00bfNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/fQkwNr+NyMXHA5QcCR1uJIv6sIzhnxf5rBSRyxoSf1F0wA3WSJZxv9rJVFrVMzDfgSneGWuT+CQ1Oa9ptpUUi/RjEw+s4F9ZOZKCtAIokg6ohuw0GmnNuXTJb5umUM3UUn9ev40tpfZ69tsGJvtEHhMfulXqdlDwBhw6ylTDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/Ot/JY/; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/Ot/JY/"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so1735125e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789709361; x=1790314161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8FAQE2rwTVovWlF1lyTtX6hSRDt+r/MPuSISBwB2mOk=;
        b=F/Ot/JY/GS52qKYeEpEvctbIM5pJPvuDqK4/98fH8O8JezMX0w6cwqe1+fgp7YBZHs
         U0DwBj4/jQImypTLkBCFCfzcFl3ipOMBSmdly37DJHNYQrxuisK8FOKbzpYfqfiJuXjx
         JtTSj0peQGJDBJZDgCuQH4cXWBjDOGc7qliTouaEx4ujfjw+0AcR/SRtuJOJ7vAZ1EGI
         jFE2aZFDOhq4DseCX1q7n5KnVrtrSE9+QRTD/rywMZ/KsZzjGm9saxuuCmaXHjkDG7Mt
         CAAOVSj/IzYnB0vfnybZnDBoyttpZq2gt+vAfvk/5NtcannOhP1mH/Qa2XYyu5ZFUA89
         648w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789709361; x=1790314161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8FAQE2rwTVovWlF1lyTtX6hSRDt+r/MPuSISBwB2mOk=;
        b=NghEfWZQvM9zDaa6Jly9yOGi7T9LCFv/G8Mjbkx8NbpLAG2AYZBBXFFagI1mEBcFb1
         xI7S4fKnNKY0XuO8TAR/tbGLBOOh6nNo+076IXR5InAA4R7JQplerRafs2zI+odufzhN
         mcqnO2Viys4nrZouNJjiVKWuptxSXu38U5M38Uw3E/YR4ipatxL9hz04aI2WHAlEZQqI
         fZM9yGjbK6OxYrECyy60KgZITAdvPVlSK0IOkXWitmt/gxAv6Vg/ZNZzTAsEwl3nkNOo
         Qzzoh/D5JMW951BckrIgM/m8mzsfgMAvF3L6v3jdIg6rtmB94pjyu5xLQY2ShE+q0rEY
         3VGA==
X-Gm-Message-State: AFuF++l01W1Hg6nGEV8+EdaNWmJVZAj3apZERs0SaLIGet/AfXUm6iEh
	s7TOnxSMs4p+Iz6HIsupSwnmZq0Q9KF8rlPAcuuSHQ3QTrIEet+mNj1ScyJtEfPn
X-Gm-Gg: AYBFou1r5TULByD/2c72FZoUB2/JGop5Otag+ut/wd7G0+kfiPV1IQRRm17iMSNV+dN
	6fFHfmAt5zNx+xJ9LkuzWRjK5CzGj+BEcgJwnr6Q9Oo6M17Fj66uBof6HrGWql8fE0qtDunL8rJ
	e2aZ9u32EYb8OI4BCPWxM8H1Nd2I10fyu615C12Qg486dj4sgWje7r6Eynyn9n+awNakmnVNFwQ
	e3M8RScyqg/JIm5/BAYkLxRiB2Je+vNyJKTyhznGKTEBRib7TXxqpO2E3tjDikuRo/6QlsfmlHQ
	Z8IDTHH/acK0o/NcqrY3VJ/dbTcdxObmC9HFhzOVL3Yy/Yd7nLQPaqr6Xmb27apjrSF6yfglFK6
	JCoM6gmKcXgXWXovtr/c2Y/fBL5x/RWYzkhHzW1hn3R+NEy47lqAKrIAEITmmcv5T60VwhXe4T7
	pI0eurYXJAT61aH5ZyjvrIMhpz2PCeQPloXfuZSXdg8Zjpeoxava1ZQDTGKBs6wtsex3J5qSKQ1
	gnAYlaSeuTHJDKOEerbGcqVyuXNw+XAOSR7FYsgviRXGgywXaeWRvC+JfLRSew61WNyAt5/7c5d
	RD1UMYzidcRMnGSzEXsBLJx9xPBh/rjTnXligA==
X-Received: by 2002:a05:600c:c490:b0:49e:799e:c1c3 with SMTP id 5b1f17b1804b1-49fc574115amr10719775e9.17.1789709361131;
        Thu, 17 Sep 2026 22:29:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872008160csm1356891f8f.32.2026.09.17.22.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:29:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 8/8] selftests/bpf: Cover __uninit kfunc output argument slots
Date: Fri, 18 Sep 2026 07:29:02 +0200
Message-ID: <20260918052906.12226-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918052906.12226-1-memxor@gmail.com>
References: <20260918052906.12226-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7863; i=memxor@gmail.com; h=from:subject; bh=AtZpPaK5IM9I2QRoUqsCrTpb7PGhX2wEY0g4W00bfNQ=; b=kA0DAAoWRy03e2NUL4MByyZiAGqsy+yggUPFtFPNfdEg8U2CHa+HFnN49R0JRtJthL6IigwdW 4h1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmqsy+wACgkQRy03e2NUL4P6tgEAyUYp HVoD3M681tbkfigiSrnsih0Fs0zHboOZIoy9WoUA/1ZM5SppAsuBiNkLDxu4nvMLm0XubZGGiSf 99IS8hvUG
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
index d1e50a952a13..24a69807c74c 100644
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
@@ -224,6 +225,7 @@ void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null)
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

