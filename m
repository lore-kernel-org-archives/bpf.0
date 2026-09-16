Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCC40759B
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586914; cv=none; b=D0dwURuAMP1vtTu+s/gtpnkgyjj6kjIXXis0DO6cagt2z2V0LNHgyeuwY9Y9WTnXDkyDsm0PO3fY/xMfbPH/HQwdIGbAg3ypJ0wv927ELHfJXKmt1dj5HhXijtew4RujlJf0fktqb7yWxtMEB0Ovl1wXDsNQAXylZzeaII+bh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586914; c=relaxed/simple;
	bh=N3N6V1UJabyo+qjnlcTbzEG4ZG1ePU3laOEJ700WtLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEP0msbgu4PvvVJEUkwGXGp/b4BrT4TyTjvgLpXBld9zQwH+b6HS3Stfk2uNsKXrFoRt366kzyQgKDrccUyPpGkKmzx7X2hnIRiDbOsMpBqtSFrhqms0pbdgEmNM4FJwVHNV+MoS2frjGTCYYLDhERkskezrV6iQMnLvw6lXzFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIAAOlkX; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIAAOlkX"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-485850cf4deso29145f8f.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586896; x=1790191696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/RpXY/cayyaWlIsmhGVSDdJd+3n3JRw883lLb8LqxY=;
        b=FIAAOlkXcJJ80mVE/97aLySfjFLIPvfOgoT3DwtUJGkRotfbTs1cA6IeHVzGPQxNsu
         mEVu21rxpXz/fUIWHvSM0707LF0MwFRQUSlPi5qk2DI5SKynTJiUYaA9CwWD8ZxFqtnm
         JJBZnYZjacPDj6SjUHm4Wo10MBwUAzbu/sAqks7nccfu7OWMWI80daoOwDUSq+nDdzwI
         xtDJHx6mpawGpyOgxonRxpOtAYb0pBBtMhyNI4HoGjRIC8bBzDhpL9ruw+E/jSlqm3+D
         WzRsSri0c5aaB3imgHZ9Uf9zls690VJVDgwMOSK8KGPBb6viDW3t4MEFzdkzHIMTt6Vz
         gfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586896; x=1790191696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o/RpXY/cayyaWlIsmhGVSDdJd+3n3JRw883lLb8LqxY=;
        b=ygSLWHiTFv4y4kMLpvRsaxoSuWT4217Q4QZfFDFDjNW25q1hqCWuBv9DyuBkcfvxE1
         Pmp8RqozMFsp0Ent6y0XBv99CZGC7imbWwo3JTmOwWKgoKWQSIxEXnaAPi4bbge4dNuY
         pMYVlaSgOC8S2a72doSV+yaNigHg6Lb0Fm6L7VPYnH44rHKER3VdUmzxv/+yCwUh7XGO
         4vmVRLEB+EPl88f0i/G2gn4kraLfqyyvWd4hbrOFREK+gtPAmFhqYDF8PHOhAEKA3/R8
         W90ScfcCL5UuJLXUbVPCtZsO1U0Grkvx3QqU0tlAJS9+oWY/BjNuwfB1OxCygdeyS3YX
         h6nA==
X-Gm-Message-State: AFuF++nIVGK1uwYCp9u3CzdwdXOesXXoWGgNeQcTVmM4Rqrv8RfgBQdu
	pnixjLd+TkezGwv37LB5ztcy1bILUBA3OIBqnQW4tILfex2Rjm28hm0kIfhVuVrC
X-Gm-Gg: AYBFou3TrRStPdBIHAcNszCjJQFS+UKtuJTyzBkGzgMYlilcpLpKGw0sUf0MiI/TVUo
	rWFajy8B1qpA+QsbgPdndG5HEXcfsx4XhzLVJwY1vcNKmVap7I8wqs7wElQ+2l/V4OPDU6ll5Ed
	qU6qmxESnUY6yJbyZ2s0Ju+B19SJm6fw9FcXSiEHxBo1McjiuE/IC1qswfskR8/BQ0Xgd7ORfTh
	t+UQjWXmve4elo6zvgZzKJ7aoqpsJhwuiov8au/HIjbgWg1sEqurYVRZauASEvHxq/5Z4FlwLUk
	BfjJtuAjbs0ufnhjSLdrHkqx0TDcr4gh7QQwoA6D4YzpOOzUEluHAf+HZWRJ2EtJaGtX33Mu6cy
	RLW5coSoiMNnMKG8DasglJ415vofacr1x6Hpgv3JB9sYsUYb2PxqdR3NXkbvgxgOP0OlrgkOtk5
	BLThlBs+Z6DeI88PFb04OM+PsB6LE2754evZVj+JVK4l2cLrxWYc/TX+UaxWyWWobIakoVnrF9b
	ZCFbwNTL7sTMbK3Oa2pvFAzGDemyGhfg47SmF8TpCEF3BhJqJ8UmIZUnHakYtn27tK3KAmufJ1I
	zdhIz8RTyiPbpGauZm11aC3qOLUStiaVkHqZNw==
X-Received: by 2002:a05:6000:1acd:b0:487:81c:b5e2 with SMTP id ffacd0b85a97d-4870cee48b6mr4776418f8f.5.1789586895515;
        Wed, 16 Sep 2026 12:28:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf344fcsm9581143f8f.26.2026.09.16.12.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:28:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Cover __uninit kfunc output argument slots
Date: Wed, 16 Sep 2026 21:28:02 +0200
Message-ID: <20260916192805.3991983-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916192805.3991983-1-memxor@gmail.com>
References: <20260916192805.3991983-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7886; i=memxor@gmail.com; h=from:subject; bh=N3N6V1UJabyo+qjnlcTbzEG4ZG1ePU3laOEJ700WtLQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvV2/omacVD2Xud16X+dXkxZZesZ86MdU7HnuaWrmdMS 3jzei5rRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYSkcnIsEW0KXItw4SwpVs7 Y35/fqd0o8Mz2XGq1CXhQ84+fst2sjMyfCn91V1eNtUo4njHxeon6Yd//3CSqRTz0ovTOZVtUHu IBwA=
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
index 4a9affe81ee1..f3c1428ac155 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -56,6 +56,7 @@
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_jit_convergence.skel.h"
 #include "verifier_kfunc_uninit.skel.h"
+#include "verifier_kfunc_uninit_multi.skel.h"
 #include "verifier_kfunc_packet_access.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
@@ -223,6 +224,7 @@ void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
 void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_uninit); }
+void test_verifier_kfunc_uninit_multi(void)   { RUN_TESTS(verifier_kfunc_uninit_multi); }
 void test_verifier_kfunc_packet_access(void)  { RUN_TESTS(verifier_kfunc_packet_access); }
 void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
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
index dfffbdff06fa..2fd5b6719308 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1337,6 +1337,23 @@ __bpf_kfunc int bpf_kfunc_test_uninit_alias(int *out__uninit, const int *in)
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
@@ -1771,6 +1788,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
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

