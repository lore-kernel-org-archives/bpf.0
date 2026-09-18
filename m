Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C23C109B
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709361; cv=none; b=EHE55nVn9p+Abua/rUrBD6zj0Nt7cV7XfYn4xFmcRc2HxZziA0tUrgVvuncVNQoRufOvqfgMyzcNDrf2iWupt2FmwGz3dKdgdNAUyKeAyPF8YdS/JRpf5fqPSZYyfnbXXybx/m6cfzZ/w3h83C7y/EP9KruDgz5o+bQcRSb0GiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709361; c=relaxed/simple;
	bh=CgOhfN9sZFAJQmFU8dIMEXGMhqSdLD+BmEV243RMuWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hY2R6aVRBtIUxYkUlBzcMOrhmDizL1ucW0YQtEzoJwT/L91jnwTHvGaPqCiQrkgDuR8bOTPvGy+dDZYrofs5pPIiV6u7S5y0Zfc/SqYXjaHng5HEjdjiVLdACdEXylBN32i/+uV1RHhA7XNSBVf+fgbeiiSWP3RvAXRqmnym1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjn8hw6q; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjn8hw6q"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bd65693so1802065e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789709358; x=1790314158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0FKKLWTQvwgvHe37lbFrLTWsVqGeATeGFMPJqYRW/o=;
        b=mjn8hw6qZ7ID4kP/o1JJEvrvZt/G87XCRYjvJB/YGSIg4yiZsjNd2Y3IGaSYSf/Z4h
         ydbBzQ5TSnsSvU3Hc+nD/NIImu3qotqO8PUWbkFCPCwIkOcvVc2Z/i6eKKFVrsB9SLJb
         poe7Vtsd5JENWaxGfo56KUvFf84HOvcWf38XRivkwEOlU2D2GMyv5Z7hUAYl+owJ3XpG
         BH1LNClX4gKRUFRJTEWy4lj+MKEmvO8OO8oAI0mfI7m5UV6Paulh6oHWk1qZRIpjGLUR
         hV4YDOBGD+KjB+MM8qmjFzQEXGyD1HDqAcwgF4wMkTekjmAr18Zo/roloHgbbMN+vCKI
         x1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789709358; x=1790314158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z0FKKLWTQvwgvHe37lbFrLTWsVqGeATeGFMPJqYRW/o=;
        b=h/qwGvy11jwVvpkSQxzBr2n0Z9RDsbtHqm13wOZ9b8E7KCMPEbOjext7nEHpiN1PkN
         YABGw2YITmvcHIe5r7XdUN1IRfs1C7MHv8CPK5WBvQpTy+/r6T1vlFQWOCxZCSkCDfAd
         D0YALiehJiUI4Q/oYcj5aflGeC6s3zEcCBCxoveNKQcQwRodGNGyKA1Spw1TViD+fR/y
         D53fMge1sPfdBnjCUnbjArSCT2N5ma4KmDyNtYwXr51RPDJ7CkxKtki6wMxQFWohY3Rf
         RmYxb4D0APk2sdtGzpn2FKnj2d51WNZH76mk+IKOdESGAOPwzuCU2Tfn9cimQHok9uJ7
         4cgw==
X-Gm-Message-State: AFuF++mijEc+k38qXX3SJKQBQ5kbH0fZvdnpQEfuaIhUVQvJoOx1nluY
	evX8NpJdiRxyMmNnwnL1ZDPA5TX3XcFIQ4qOGaBpswSTtltPLp6/LjvXvxR5qg04
X-Gm-Gg: AYBFou1NPFw9dOTzaKW/g2Zf2pNEISNFMMOldp/u2C3abTDP+rux0OkOUu63bSpuMCK
	TXtIw05RKxjIX0dev5/fsVbtZGAExnEE4JetaKbWpYSn/YNU/5352+XTZmYje9fCfSFdjw6sS/R
	PrkCXPQsMbKzyp0bL8u1ukgd/MF73/fg+p02/QuLVxH6Plnwna50Zy8ALQEuHcz09rkAVKoa1BW
	ctNNhTyg5oCmVN8O2YPOX+UyTTPAFrKDLciTPE2PTKbzPyVn91D3kSU5ATp14SAP4AFgLPCeHWz
	FPBOs+Cuva/OndYR55A4w0zVlv5pr83nYCE7FwrGfhEJL3dudKavgEisrjTupqb67ibpX2cvNDR
	HARpvG1qntQFGf1YgnI3gzXA/27bVO1DwSAdrmdgcCViiKzFFNTie9MkO7Z+HBPrYfzsPAhor7T
	QJervA/RWJJGFq03Kfr+V44MCwL0U1ppe234FsuS/yOJnN8m1KIeR//7BU/qnn5++a5W15cNrT3
	WFre/tGE28ar40a4ly0PZHiiWx8nfqyeCUk1hD0VyYsFWwCJ3E0oz2DyRmamoC1ndOnSQZrdShZ
	jJOcWglnMyUdD5Mqu6WivlT45AokBYb2tltLOd3MvUTh9agW
X-Received: by 2002:a05:600c:3ba0:b0:49e:73d3:78ab with SMTP id 5b1f17b1804b1-49fc55adc12mr15300055e9.0.1789709357613;
        Thu, 17 Sep 2026 22:29:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487203f077fsm835561f8f.26.2026.09.17.22.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:29:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 6/8] selftests/bpf: Cover generic __uninit output initialization
Date: Fri, 18 Sep 2026 07:29:00 +0200
Message-ID: <20260918052906.12226-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918052906.12226-1-memxor@gmail.com>
References: <20260918052906.12226-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7824; i=memxor@gmail.com; h=from:subject; bh=CgOhfN9sZFAJQmFU8dIMEXGMhqSdLD+BmEV243RMuWc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvN6ddtEoZ8PgW2PxLmB6XqOVq/fXM899aV7/HsnjHT4 zQYf9t2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLnTzIyTFtX8X1yyfajTLtP vZG2naPxiycsufDIg2W2bGc7ON87rmVkmBJntKRFy2amSrgyW63b1PfHm3PPXBFulpy9TjFI+DQ TGwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise the struct and sized-buffer cases where stack liveness poisons an
output before a kfunc call. Check that the verifier accepts these outputs
and that the kfunc initializes the memory read after the call.

Verify that an uninitialized input aliasing an output is still rejected
without CAP_PERFMON or CAP_SYS_ADMIN. Include an initialized alias as a
positive control, using an int-width store so its value is independent of
endianness.

Use __prepare_priv to resolve the test module's BTF before dropping to
CAP_BPF and CAP_NET_ADMIN for program loading. Keep multiple-output and
argument-slot coverage separate from these immediate regression tests.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_kfunc_uninit.c         | 100 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  25 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   3 +
 4 files changed, 130 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 7732df9bc870..d1e50a952a13 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -56,6 +56,7 @@
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_jit_convergence.skel.h"
 #include "verifier_kfunc_packet_access.skel.h"
+#include "verifier_kfunc_uninit.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
@@ -222,6 +223,7 @@ void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
 void test_verifier_kfunc_packet_access(void)  { RUN_TESTS(verifier_kfunc_packet_access); }
+void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_uninit); }
 void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
new file mode 100644
index 000000000000..f7818303e703
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
@@ -0,0 +1,100 @@
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
+		: "r"(&bpf_kfunc_test_uninit_struct),
+		  "r"(&bpf_kfunc_test_uninit_mem),
+		  "r"(&bpf_kfunc_test_uninit_alias));
+}
+
+SEC("tc")
+__success __retval(10)
+__flag(BPF_F_TEST_STATE_FREQ)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void struct_poisoned_at_checkpoint(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 16) = 0;"
+		"*(u64 *)(r10 - 8) = 0;"
+		"goto +0;"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_kfunc_test_uninit_struct];"
+		"r0 = *(u32 *)(r10 - 16);"
+		"r1 = *(u32 *)(r10 - 12);"
+		"r0 += r1;"
+		"r1 = *(u32 *)(r10 - 8);"
+		"r0 += r1;"
+		"r1 = *(u32 *)(r10 - 4);"
+		"r0 += r1;"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_struct) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(0x2a2a2a2a)
+__flag(BPF_F_TEST_STATE_FREQ)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void sized_buffer_poisoned_at_checkpoint(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 8) = 0;"
+		"goto +0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 8;"
+		"call %[bpf_kfunc_test_uninit_mem];"
+		"r0 = *(u32 *)(r10 - 8);"
+		"r1 = *(u32 *)(r10 - 4);"
+		"if r0 == r1 goto +1;"
+		"r0 = 0;"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_mem) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(7)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void initialized_input_alias(void)
+{
+	asm volatile (
+		"*(u32 *)(r10 - 8) = 7;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = r1;"
+		"call %[bpf_kfunc_test_uninit_alias];"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_alias) : __clobber_all);
+}
+
+SEC("tc")
+__success
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__failure_unpriv __msg_unpriv("invalid read from stack")
+__naked void uninitialized_input_alias(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = r1;"
+		"call %[bpf_kfunc_test_uninit_alias];"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_alias) : __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index fd2c0cdc91b1..542edeb28b27 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -17,6 +17,7 @@
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/un.h>
+#include <linux/unaligned.h>
 #include <linux/filter.h>
 #include <linux/rcupdate_trace.h>
 #include <net/sock.h>
@@ -1316,6 +1317,27 @@ __bpf_kfunc void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
 {
 }
 
+__bpf_kfunc void bpf_kfunc_test_uninit_struct(struct prog_test_pass1 *out__uninit)
+{
+	out__uninit->x0 = 1;
+	out__uninit->x1 = 2;
+	out__uninit->x2 = 3;
+	out__uninit->x3 = 4;
+}
+
+__bpf_kfunc void bpf_kfunc_test_uninit_mem(void *out__uninit, u32 out__sz)
+{
+	memset(out__uninit, 0x2a, out__sz);
+}
+
+__bpf_kfunc int bpf_kfunc_test_uninit_alias(int *out__uninit, const int *in)
+{
+	int value = get_unaligned(in);
+
+	put_unaligned(42, out__uninit);
+	return value;
+}
+
 __bpf_kfunc void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
 {
 }
@@ -1747,6 +1769,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_int_mem_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_struct)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_mem)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_alias)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index d3696d5254c9..91b64e783123 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -289,6 +289,9 @@ __u64 bpf_kfunc_call_stack_arg_big(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
 void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
 void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
 void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
+void bpf_kfunc_test_uninit_struct(struct prog_test_pass1 *out__uninit) __ksym;
+void bpf_kfunc_test_uninit_mem(void *out__uninit, __u32 out__sz) __ksym;
+int bpf_kfunc_test_uninit_alias(int *out__uninit, const int *in) __ksym;
 void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 
 void bpf_kfunc_call_test_destructive(void) __ksym;
-- 
2.53.0

