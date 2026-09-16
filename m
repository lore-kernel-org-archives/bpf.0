Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214F3DB327
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586918; cv=none; b=gn5F9HWWNMlrcEBliX8WeQrdiYCGJt6DBRAlrnsYX/zFQSVAEVGCfZzdR3eJE8KhMH+JIBJRKa6umQ9FSmhItaxazvdgE2wJbyhZlXrcHuIbJovwUiIuR8d0qhLnzoCh4d5MDaR2O7ZXjpI6JZuGmVP0x2TQSUo4V3B8cNQLFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586918; c=relaxed/simple;
	bh=2nufXZq3ylVxTWVjGNLuQ3dUWmObskA+yIubO5tyh94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBdeRcyXkHe7NI4m8e7MEKNj5L38pXC8yCdbeQNemAkOW8nvTf9poCxpEzzZyLb7tLbrkOInyANNcaHPMPGPI9UMwaajUqx2qXrQlymXespOw8FhLA76BCsK9rkeAgNS0QtfLIc7fh1JGxxL0DcyZBREHqzsXHx6P4MOF4ILuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLbxpDP1; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLbxpDP1"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so243675e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586892; x=1790191692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MZc/2tA5mLKu9JQZ3fuM3QcM75zTTdkwqscCm0wBp5E=;
        b=YLbxpDP1Luc0GVfDztD3kbrLiQBY0yfwrhjSsm72vM/Uvi2PlijYOvHY5PxgtIKO2r
         YVhlrOPHA0xiitkb3dQY/ucklmoj9hOaQQU1nzByWTKVUhKpM1IBP9ppPWsiBtWDXFyp
         g1X3r8Qn2afDZ7wlteGJqfilFgaKrp6scE2LXe4PVBjlr/Qp6WJhyXtIIfrKXKgc9xyp
         YEMFX63Qfvoruh0XPlbE4dDJhnw/+9Z08k+YNYGzbt2aOveDfPar8yNPHLna05/ntYPJ
         +vbiq3vw3g5ua8BHeUzCBTfKGwPrAkXn95LCtbdzKZSHUg8ksSV2BOr+6w8CBNdM0gFc
         AXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586892; x=1790191692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MZc/2tA5mLKu9JQZ3fuM3QcM75zTTdkwqscCm0wBp5E=;
        b=y131naeMdmn60Aorw/aGV6y29/XFpl264wmg3y/orOwkj5me/vw4jZDrq0FeA8QykH
         DFQydEivn1GvVc+1sSDMFkGoHWvp7HFIdXTSP2EOTvmKnN2+NrDykrtJ258zE1ogW4wq
         2i0Tek3WrdL7gUPAfEZTMIpH8TbPF8JW65WV4DT9OSO6GwvBUmDXhc1AlAjp0Jj29f4+
         r1piMnuvrFuLNIcnMUG2MQIYQXZ9g3SynI2syMUP5LdfEj69KcjLpqJkKuNQ9zSgSEdA
         F6OLre+j+RdvELClJWZFYfs3ZxqjiOZWJom/tbjzbPnDo2QAIF0Gmd5mMxSp3udVNRtK
         Zmwg==
X-Gm-Message-State: AFuF++mw/Y7ThSGuTSehAfq98GUgoPs4SQTQZ1LXcViXF9KzrWQiu72u
	/mdGwMVD1nYhq1YhBrXsxdyQm1atT7+H69vH1qeubP50oTL3tsSAGeugWDzI+wAo
X-Gm-Gg: AYBFou1xL8U/YFlm3QcI29JUqf2p+etzpI+SuxYQa345PbxuZOUpAsfsrRRIiHeBJvF
	l73v/GFMxTglPaXmekZZniKSyH6nlQrR/eBuc11HYUZwOhAKtNRbsltUqC7ov02QLeyFTgUAzaa
	Z8R8+GMAebHoJp6s0JaDBCENVcROJomeOYMyWv2j1Dwf8+CtpGdh3u2TIYjAoU9wS50PV2duVJb
	C3lDpRTQ6CBqfyZDxO+k7Lnplw+hGQDeIbX4hyhoUGBkvUyJ6UUSYUZohu/mQGKU7AvTzPBpJvY
	NyzEZ+fLYvnsgHJFTV48n5QK7COR8ZQ5lrNi0LzQWEMI9TcjR50zj9WKQhNuLwAk0TZ2bF9tX4m
	SfPoNBUd4ynJZGsmAohW6Td9+yHdGGwEFviPybkkbeoaZ7GFI7O07ti9Da2By8ILnMw31j94P/r
	pMwDWowEBzen9fHrWZxc4YF2kEbzNPivZfzqCoO4QW1/QF/1BFe1zH6JFGQOPGnsgkZm8QO1yjp
	nEFaitaZdABaqIb5LFMMDAJceklVjIbyVUZor3QL4T9vkE3xQUwwU2jROgLq/xwtUhV5B2OiFCC
	juoSB/Kl/2lkDYwulTfIiSiBpXJ/2HwApmlgEWbl8aYd8V6o
X-Received: by 2002:a05:6000:716:b0:487:aa8:cfda with SMTP id ffacd0b85a97d-4870cf26bcdmr4778560f8f.2.1789586892131;
        Wed, 16 Sep 2026 12:28:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f7cesm8907006f8f.10.2026.09.16.12.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:28:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/5] selftests/bpf: Cover generic __uninit output initialization
Date: Wed, 16 Sep 2026 21:28:00 +0200
Message-ID: <20260916192805.3991983-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916192805.3991983-1-memxor@gmail.com>
References: <20260916192805.3991983-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7583; i=memxor@gmail.com; h=from:subject; bh=2nufXZq3ylVxTWVjGNLuQ3dUWmObskA+yIubO5tyh94=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvV27p7KWfXrCvQ+vMsdPUkjelm19boXMh/MOfMEd/rQ i2coSJKHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjITQ+G/8mMl1cp7s58JLZv 3eIpGo9u6W18UuB37rRzDLvB9KmbWacz/HfsXJhqFREjfLnyVsoblfZi6T0vSqcXrdiyU2/16x6 9v/wA
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_kfunc_uninit.c         | 100 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  24 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   3 +
 4 files changed, 129 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 7732df9bc870..4a9affe81ee1 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -55,6 +55,7 @@
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_jit_convergence.skel.h"
+#include "verifier_kfunc_uninit.skel.h"
 #include "verifier_kfunc_packet_access.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
@@ -221,6 +222,7 @@ void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
+void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_uninit); }
 void test_verifier_kfunc_packet_access(void)  { RUN_TESTS(verifier_kfunc_packet_access); }
 void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
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
index fd2c0cdc91b1..dfffbdff06fa 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1316,6 +1316,27 @@ __bpf_kfunc void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
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
@@ -1747,6 +1768,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_int_mem_release, KF_RELEASE)
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

