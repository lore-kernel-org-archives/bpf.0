Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8AA4C226A
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574921; cv=none; b=JuaiYYk1atDnZK/BdOKuxfnBjyAVKtW3a3VlRAFPMROaecm6Yy/oQkKXLVdYkwOocsrTRh/FXW5mMEmkDPdWOceZ3qZ0rh3JYe4PMxKEIbcoNQh6mspKPij9Jk8N1HlxmRtm1pkwuD5your6Tk4ucGvKm59/1UVysBwsBjjmnS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574921; c=relaxed/simple;
	bh=aTjgU/2eYubE5q/aiiYVhBNcTv8rYIJGTw0uDBw7xFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAQ5bNakaggRi3V3SgLwvA07Bjbgi6bM8+Kaujy7Yh9FCRYGlF/hLXHr/V3jODkofb88eTlU3a4fn7/YpAcl48GxoOl2doL6vU/4pv3DoUxVrXuaB6fc7phWglqcVgLLdl6HJdxgUXNud5qm7ADlsTAmYbY4sAa3C0PJIcawPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmEHEUug; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmEHEUug"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48433107499so2512331f8f.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789574912; x=1790179712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ovHWHI2kXgI44cbc/AU+HSVM2PKIfvT3Vz6iGiyl6AY=;
        b=MmEHEUugs7n3T4wgLlDoAwPSw1pr27uKCG40QZAnKbPRdlzt1SyXkr9tPDeFRWAmVc
         m3FUOK2qO45JNiKuuDLGLOXcaofN2nNjjv96exK/HvaPBnsF9znlnMt/Jhsh9TcXyz5Q
         XnnDhHuV92e16yBbua1eDUFEIH72DMJd7SvMNHTONrt+X9A4ATbzbpvW861UjyQJi7jJ
         nsE96tWYvDVxWaPPQdN4yP0lE5KZFc09uMoKGo39cSXG1Gt2r+8U976Worsdh1Xw7ryk
         h7vAWLaLcL2AWpNyN9P9IZeIUSEy2KMpiIbiZpTl8nUFkVFzweZyQdmBnGkMBhRMHcyt
         pOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789574912; x=1790179712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ovHWHI2kXgI44cbc/AU+HSVM2PKIfvT3Vz6iGiyl6AY=;
        b=FFqk00CarolQUCnduH0jqQSlPVNSeGQdoSeSbttDbkiHsyb1s9wrPgXM4gsAFl/8hl
         L5sr+LuszeOjwM5LR6vLCzI87cCGo8lWlwlp27W+w/IOhhOATPDgKz1e28F2guA1X2LA
         J3sv1U7CKI84N2kblIn0y2eLu9Vj8KhXp8Va+B+KULLkZFGPHaegTZN9fx1da1iVR96A
         9C9QSKIMC2KgdXK4xkbaKl02TGawsVG9iENhxTldfXvfpWhSo8NPB0mXvuf2L3MozCAy
         YmGPZ/P28iBXgEASQaSmuR7SUaBlas1T13gTcQ2gfN15fcrFc7epz3fmpYYyNutfu8Zl
         lNwA==
X-Gm-Message-State: AFuF++lE4inQ6eTOkhBTdDr9aSFmEOUwEGljoDOWXOsszu015zDTZJ5z
	L7wuk+3v79x0aKR3KcSvHO+FPs0mH8agsBtnUtuTHV4uan+w6WirKxx22II2Mdly
X-Gm-Gg: AYBFou2iS3GV4y4LUTmyOH5H/1Nk2jQ8u62y4F8vr+n1j0fk5nYRaKVZEW2uxQTFgFU
	5bm2gmLi3TQZ4V3PoTDZsN9EYhbT8d/lidlFyhm7YgHaSO4e05kEbA9ee1dZrK3CaAStkI5oNtP
	Tvl9W7XgB7c5dvIM7BlKVBBg5qluvzcfxKxJ9C4CBGCr2nB0rrf63fhsKFXsW0hPSl+uHwA8jMY
	6fDRVuHLHnOK2r2urYud0vSyMRSG1piX2Efh33Ik/UOQh4CYfgfemPaiaMgf0lEqdl7qXvcP5tO
	ryeolsD/OrNQHNhBxiBKR162WMHrFdc3CVMDvLMQ4vL/uFpcqWQD+AVNmzYQd+YqGht/6B1Y4tc
	Hw5ldnrQukkRSA79ZW4KMaW4yBPN5M/YRCIQDFidgc2PSPLtXPTPvY4KvEe6PU7GvmxBksiDtoB
	FStfwzcnpKXFjnteMrRpW0kLFY4GkPFPLBmASnR0EgMnrkYHBBzPvBasspAteJfH2SfMLNTc7jA
	+IYrTZJw5rJauiTWvE/6XUgi0/nKyc0IYBbCCKFB2HZb7UjVfdYVzTHmfdQolInJb38fMWIMDPP
	GjC8TAhYNNt5OzGulRjgWVF56rVNsOhnQ9FurQ==
X-Received: by 2002:a05:6000:4b12:b0:487:360:f17e with SMTP id ffacd0b85a97d-4870cef4138mr4297366f8f.17.1789574911762;
        Wed, 16 Sep 2026 09:08:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bcc7d1esm8103538f8f.0.2026.09.16.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:08:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Cover __uninit kfunc output argument slots
Date: Wed, 16 Sep 2026 18:08:18 +0200
Message-ID: <20260916160821.3157543-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916160821.3157543-1-memxor@gmail.com>
References: <20260916160821.3157543-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7823; i=memxor@gmail.com; h=from:subject; bh=aTjgU/2eYubE5q/aiiYVhBNcTv8rYIJGTw0uDBw7xFc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvVvhchusfny3/K8rQP261pdk3IM67qykvG+xMty1Oat btMS550lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIHPzAytLz7q5NzcVvV6Y8/ jl/9fOlf+4PQ57n7TrpYPNnw0fLbz7cM/ywfsQscXW+1eaNqsJbQrDSp5qy/ByI0b0e52SzhEzG L4wUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Keep coverage for per-slot output tracking separate from the immediate
single-output regression tests. Check that both constant-size outputs are
initialized, and that a variable-size output does not disable initialization
of an independent constant-size output.

Also exercise an output following a by-value parameter that occupies two
argument slots, and an output pointer passed on the stack. Run each case
with normal capabilities and with CAP_BPF and CAP_NET_ADMIN only.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_kfunc_uninit_multi.c   | 116 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  20 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   4 +
 4 files changed, 142 insertions(+)
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
index 000000000000..b944346b35e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c
@@ -0,0 +1,116 @@
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
+__flag(BPF_F_TEST_STATE_FREQ)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void output_passed_on_stack(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 8) = 0;"
+		"goto +0;"
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

