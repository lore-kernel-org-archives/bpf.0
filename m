Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE0436657B
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481417; cv=none; b=m3TyAgzWu6nZuxVg4ibLoYugBGv6a+YGi4zOW43nRUfM7lCdaFANakp06/Xhb1HpOV1torMoSAK1i1VGlBDb73AJ3SeFkBkAgA9N9IGVc+Ck+oO6BpnVE4qh/KW2pc//s2J/UD7WjiX7AOOIhPJkMPgukwyRKOrUrh0zGSZiq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481417; c=relaxed/simple;
	bh=QhSIqwbTSVpMwUotbVQpXsmcHIs42anAR8gQTM/0TIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPkZ6jU1H1JO8sk2iHthSfd+6zu81u09ugG+/gOJBvhuih/sILaqKq5t9TWcVKvMv+fPemMX9Uy+F5TpEOWS5eFRdWNWoZbbhWkf7Kj3hSuopzFlX3AGT4MDd1l+4o6b3ltlS5UA9Jtx1tEQh2neoNxvrcEIvP+8qQTZveoCM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YT5+oT8S; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT5+oT8S"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e7b06acb8so4797465e9.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481412; x=1790086212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oG2I+YRHWYyEY2URyOjJcHuShKrDjC3Aae5HKbPmC5k=;
        b=YT5+oT8SbIbEwqNpF7IjA7teh+rDc76I7j+4+DlatfnVEuSGwszyFSgp+MFPH5TiTN
         McDBNj3H3l/qbXmj83jnhLlZh1nzCuTTgZp1d1uc8XCQiGulfS1GI+5aasARntjVUZ3P
         /qPIyni/OJGLaE/JlKZWqC5iNPggDz191na+3x3ICTnKfYPPEw+VOh5W0wodwSsH7c1D
         VfRPqgUs/RVAMxgWzBrLgpxMofBfVAJqUdfDh6e/2hoh/+hQZ8wTpHAEr4A8ofKB6e7J
         HlJ5u1L7hBA49CKiYMhlMiRd0qjXCsig16vOKquYd6Cn9eGglRiuOjPXtBfrddbLN/hw
         gPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481412; x=1790086212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oG2I+YRHWYyEY2URyOjJcHuShKrDjC3Aae5HKbPmC5k=;
        b=KJ+DWOTNjDWj68MkW8YmSlfxEr3CwgbCUtlrtQnS6T8f7Lm7db5q7tj9ZH/dwOwPry
         cGb51mUrmiHtLUSiARoJKPBVTM2rJRZlSS+Mo6A8ng0NCxJ0GQkllGzmjQV6BA+CfeLc
         E0ukxAu5ACw+flpaGYi7Q91zd/4h5Kgzt94b/Jjx+cj/BmqN1Am+UxoTFIhZboa2Q+aC
         qAYsVUZFsk63+a1Rz3iBc1Vpb+4044Ay8+E0V21K7R5He5+hruCMW7vqX7Yg7IPKL8n4
         wOsT51tq50nQO/GAoB7j7CGcjy/yzOHu5BAa+5mtCPGK3bxmQBi13aRK/12oVrOZ8w5b
         7Wkg==
X-Gm-Message-State: AFuF++mi1h3wIetH+Sazsq0hAjR6mX6gpmTUtccz9krvgN0Te6qmi6Z0
	zOGBVbJXoutglssv8GBuygtMMBw8JLqvSy7Jwt4ln08V474AnyBPL9NevS1tCU9hcQU=
X-Gm-Gg: AYBFou0mWMlA9b9IWygatuxSqT04k1UxXbok3mm9ukMJ+2qIG78kgBJ152KYVR7M16/
	3cdLs6yDVnXUrEegZxvvAyqtVDdgyAemsQ5m/lAQlXQa6xwDRo8QS1s/HMbhryeNpRnn2VK6bag
	ln5DrenuGQfnT7S+fjja4MR0YcjXhfegAmvlvT/9ck0HrMmPeo13VL1QPTSs/ublh+Ce0mlZdRE
	hqIoB0QJvZn1KwpIh6xANgVAlNUyzGscr+r58TSeAyC9BSTMrsSMX6GVe3acMbZsOI3uNb8oIRI
	kBKXmSHfx+8kn88cpotcR+yJgJhQEnJqXHEqDyn1JbpygCkleFQRywgfMNrQtdQrARjC4XXFYMS
	vjfTCnIbRs+YAW/OQKqziBROCWaP0O7AEk6zA3mI7euLxK8vAJ3fNPSaPXxbEECi8g5nmZQCLJq
	t/aSzzOk97qrWyV9Hl6e36Tc+8wC+gMrmfxKhI3i/1usumax3LZVVdF4nlHjRCY7YRqnvX6f1Zs
	pG3zkDgbOqVQyA/uzowumoddTk2+nqqh1uKj2gB/jClUajeBid05ipOi64muamVfcekCvzTBgbi
	vaub6X8xQfZ0YYltHmPRg43LlXzss2xdRDaDag==
X-Received: by 2002:a05:600c:698d:b0:49d:827:e5b6 with SMTP id 5b1f17b1804b1-49e7a68cc4cmr93487855e9.20.1789481411321;
        Tue, 15 Sep 2026 07:10:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34fdd2sm34731465f8f.28.2026.09.15.07.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:10:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Cover generic __uninit kfunc output buffers
Date: Tue, 15 Sep 2026 16:10:03 +0200
Message-ID: <20260915141004.1196460-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915141004.1196460-1-memxor@gmail.com>
References: <20260915141004.1196460-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16182; i=memxor@gmail.com; h=from:subject; bh=QhSIqwbTSVpMwUotbVQpXsmcHIs42anAR8gQTM/0TIs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtlYNdnQV0+xXt2E3/vdVnR18jnuLabY2fiomUTCu+ZK mh6TTjSUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIns2cDw3+HfSk/HGubMlu3Z 7yZ13nK+ICbEerZN3OuAjXOzUEdsA8M/286wZaZGR9bNv5/F02Ric0RHZPr0Y8weeQJRXBW+ehq cAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise scalar, scalar-only struct and sized output buffers, both with
uninitialized stack storage and with a checkpoint that poisons prior stores.
Run the accepted programs and check the values written by the kfuncs.

Use the annotation-driven loader to repeat cases with CAP_BPF and
CAP_NET_ADMIN, but without CAP_PERFMON or CAP_SYS_ADMIN. Prepare module BTF
before dropping capabilities with __prepare_priv so the cases reach the
verifier. Cover stack-passed output pointers and outputs following by-value
arguments in both capability modes.

Cover multiple outputs, an independent output next to a variable-size
buffer, variable offsets, and write-only maps. Check that read-only maps,
out-of-bounds outputs, uninitialized aliased inputs, and reads beyond the
initialized range retain their expected rejection.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_kfunc_uninit.c         | 399 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  56 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   9 +
 4 files changed, 466 insertions(+)
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
index 000000000000..99c0ee562ea0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
@@ -0,0 +1,399 @@
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
+		: "r"(&bpf_kfunc_test_uninit_scalar),
+		  "r"(&bpf_kfunc_test_uninit_struct),
+		  "r"(&bpf_kfunc_test_uninit_mem),
+		  "r"(&bpf_kfunc_test_uninit_mem_const),
+		  "r"(&bpf_kfunc_test_uninit_multi),
+		  "r"(&bpf_kfunc_test_uninit_alias),
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
+__naked void scalar_poisoned_at_checkpoint(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 8) = 0;"
+		"goto +0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_kfunc_test_uninit_scalar];"
+		"r0 = *(u32 *)(r10 - 8);"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_scalar) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(42)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void scalar_uninitialized(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_kfunc_test_uninit_scalar];"
+		"r0 = *(u32 *)(r10 - 8);"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_scalar) : __clobber_all);
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
+__success __retval(10)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void struct_uninitialized(void)
+{
+	asm volatile (
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
+__success __retval(0x2a2a2a2a)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void constant_size_buffer_uninitialized(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 8;"
+		"call %[bpf_kfunc_test_uninit_mem_const];"
+		"r0 = *(u32 *)(r10 - 8);"
+		"r1 = *(u32 *)(r10 - 4);"
+		"if r0 == r1 goto +1;"
+		"r0 = 0;"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_mem_const) : __clobber_all);
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
+__success __retval(42)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void variable_size_initialized_buffer(void)
+{
+	asm volatile (
+		"r2 = *(u32 *)(r1 + 0);"
+		"r2 &= 7;"
+		"r2 += 1;"
+		"*(u64 *)(r10 - 8) = 0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_kfunc_test_uninit_mem];"
+		"r0 = *(u8 *)(r10 - 8);"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_mem) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(42)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__failure_unpriv __msg_unpriv("invalid read from stack")
+__naked void variable_size_uninitialized_buffer(void)
+{
+	asm volatile (
+		"r2 = *(u32 *)(r1 + 0);"
+		"r2 &= 7;"
+		"r2 += 1;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_kfunc_test_uninit_mem];"
+		"r0 = *(u8 *)(r10 - 8);"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_mem) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(42)
+__naked void variable_offset_initialized_buffer(void)
+{
+	asm volatile (
+		"r2 = *(u32 *)(r1 + 0);"
+		"r2 &= 4;"
+		"*(u64 *)(r10 - 8) = 0;"
+		"r6 = r10;"
+		"r6 += -8;"
+		"r6 += r2;"
+		"r1 = r6;"
+		"call %[bpf_kfunc_test_uninit_scalar];"
+		"r0 = *(u32 *)(r6 + 0);"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_scalar) : __clobber_all);
+}
+
+SEC("tc")
+__success
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__failure_unpriv __msg_unpriv("invalid read from stack")
+__naked void output_does_not_initialize_adjacent_bytes(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_kfunc_test_uninit_scalar];"
+		"r0 = *(u32 *)(r10 - 4);"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_scalar) : __clobber_all);
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
+		"*(u64 *)(r10 - 8) = 7;"
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
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_WRONLY_PROG);
+	__type(key, __u32);
+	__type(value, int);
+} write_only_map SEC(".maps");
+
+SEC("tc")
+__success __retval(0)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+int write_only_map_output(void *ctx)
+{
+	__u32 key = 0;
+	int *out = bpf_map_lookup_elem(&write_only_map, &key);
+
+	if (out)
+		bpf_kfunc_test_uninit_scalar(out);
+	return 0;
+}
+
+static const int read_only_output;
+
+SEC("tc")
+__failure __msg("write into map forbidden")
+int read_only_map_output(void *ctx)
+{
+	bpf_kfunc_test_uninit_scalar((int *)&read_only_output);
+	return 0;
+}
+
+SEC("tc")
+__failure __msg("stack R1 off=-2 size=4")
+__naked void output_out_of_bounds(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -2;"
+		"call %[bpf_kfunc_test_uninit_scalar];"
+		"r0 = 0;"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_scalar) : __clobber_all);
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
index fd2c0cdc91b1..4015cf4fc416 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1316,6 +1316,54 @@ __bpf_kfunc void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
 {
 }
 
+__bpf_kfunc void bpf_kfunc_test_uninit_scalar(int *out__uninit)
+{
+	put_unaligned(42, out__uninit);
+}
+
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
+__bpf_kfunc void bpf_kfunc_test_uninit_mem_const(void *out__uninit, u32 out__szk)
+{
+	memset(out__uninit, 0x2a, out__szk);
+}
+
+__bpf_kfunc void bpf_kfunc_test_uninit_multi(int *a__uninit, void *b__uninit, u32 b__sz)
+{
+	put_unaligned(42, a__uninit);
+	memset(b__uninit, 0x2a, b__sz);
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
@@ -1747,6 +1795,14 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_int_mem_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_scalar)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_struct)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_mem)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_mem_const)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_multi)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_alias)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_pair)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_stack)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index d3696d5254c9..2ec8192a102f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -289,6 +289,15 @@ __u64 bpf_kfunc_call_stack_arg_big(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
 void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
 void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
 void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
+void bpf_kfunc_test_uninit_scalar(int *out__uninit) __ksym;
+void bpf_kfunc_test_uninit_struct(struct prog_test_pass1 *out__uninit) __ksym;
+void bpf_kfunc_test_uninit_mem(void *out__uninit, __u32 out__sz) __ksym;
+void bpf_kfunc_test_uninit_mem_const(void *out__uninit, __u32 out__szk) __ksym;
+void bpf_kfunc_test_uninit_multi(int *a__uninit, void *b__uninit, __u32 b__sz) __ksym;
+int bpf_kfunc_test_uninit_alias(int *out__uninit, const int *in) __ksym;
+void bpf_kfunc_test_uninit_pair(struct prog_test_pair_arg p, int *out__uninit) __ksym;
+void bpf_kfunc_test_uninit_stack(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
+				 int *out__uninit) __ksym;
 void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 
 void bpf_kfunc_call_test_destructive(void) __ksym;
-- 
2.53.0

