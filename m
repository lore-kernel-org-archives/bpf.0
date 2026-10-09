Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258E4C9DE5
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542951; cv=none; b=sDjNiHZX6K7+QrvtbAU2gnHZ/OunM6oM6rD0pEgSJLVjIzEfIqkQVfjAqKlZlQFyFmFNKHOIe4j2qlfsuyXgwdpJPQezsGqQL8bAireIv0wuGT2A0qa2fVGhgWj6yJggQuKHOyVP28ApMnntaybAmxdIPPngGhaNNC4q0Dg20LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542951; c=relaxed/simple;
	bh=7OFN80J6GRQTotWqCH5yq3O4vkITEhdiwzl1trv2Tko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2Ju8vIvLraHafSYGho9xOk3Il0QH4UX5XOoG7+hJzwCOQneDPntN+4c9ewlbfb+uC+V+/Wz4JNOTjaDLbA54tdccCtCy9wceTXEzkOak9xm/2LHUw/abKuZT/QKZCqsI9SbXKtcjgX+alMoQAgHTXDAjLN5/OGBfvX1jU4XL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOzyJoG+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOzyJoG+"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so1068417a91.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542934; x=1792147734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qlEgu+bHEcNxV3ateDvI0u6KzUarElNt1EVK1Cn4YYk=;
        b=MOzyJoG+bPndVUx94uyMZfsVvos74rAxxCrCUmSaVlLr3CwM7HgxXidivEorih7IPT
         hGSIMEsdn+a6ez5//hkvrppwtBb15DguLPxN8Fs23Sc19arlntu4JcTklzFE+fikiVMj
         1Vu1NYHtgadHUl2K7Yx7D3GH8jVcQIpkF9hRDGGf4Lc47vDhrVnKPeVhXOb0vZQlkP2N
         vjTGPbhylSshXQnq+Kpdb1KV+vu/68P6d+eRKJXzEMQvUi7O2XgfCaSj0YweMpzHA/a5
         kbFAkTWxmITbafw3AT5U/tIk2W/PS5r0ViT+yf3WCPcLgZYzJgoA+2ALg2uhXPpoW+vj
         M8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542934; x=1792147734;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qlEgu+bHEcNxV3ateDvI0u6KzUarElNt1EVK1Cn4YYk=;
        b=bxRHF5OkE3U5AONASHNKQ0yAedgTj1vRRX5xlRx8eFJmtM6r4Zribl0rc5oyNKD148
         mOTYPMYN7y1s/jG5CK2pbdOj9zvncUrIU3XeCfLe566VhUWRr1/XZMPbh6FEo8vigt8G
         QD9sNMNcnVxYuLNOIfj2Xo1X+j4MzZ4TVXYW1ps9dfdjDsyxX7l7Qaqwj3gD0vxCAXQp
         EK9DyFSoQlkoA1v1ofkkpFrgmJsqX6NA7h96firWgAFxY5MUSPpDChe4sGQwBApP5lTH
         0rkxfe5rdE0qL2xvlR0cF+lzyOyp63PJgkruMHVvtErU038m8li05t8u7jZYwI8UtcFN
         E/iQ==
X-Gm-Message-State: AFq9FYIVNOtutj5t4fdmngyvqS/eadwnNt291pQayVzpInsZtW7Combt
	ahYc6GxWGpE8dOLrvQWsv8BFOn7r92vnEuwuSgraWkdh14pXHKdYM5F+NPW4q7qx
X-Gm-Gg: AYBFou3nglpltPt7g9xijgsddaQ8aJOLOFGnhiKrfv6p82hIU8tnMOB3I4jwcrqb5wW
	tyijqTVW4uqDyhkqTKIumnP/JrswPlMlnC3uZXOBfTCzSnXAJgwlSJjTjCRdKSDPlwCFCWU+0Ey
	NN1Ceuj7qSJZZjP1mdXy9He1JfvCN3BBN2YsjXk3ZQnvmncyuLTW11G+Q5kCt/wlPiKsEqn4CbQ
	fpJd6OufTNWVfpwSvWMQtxfKiKjnpPZ2Wi/Bm0UR5MG10HdtsSZ67EryFjYMOFKfb0nOoaI1t04
	WDLScyPq5tW0T1KPq9NJ8Xi3/sByuWdIdWC6kx9q0n2FtaKnbSNS3jCdJjiODiWZDpi7/VjLSYv
	ocBqY1dqTQLTg+lB2dj7eRFpQS7SDHOxKn09jbi/jKZVydsE9eipn1UFnlqMMeb+LpiyYBGfoL9
	cXjKA2P7QlDvaBji99Bp07IjowgzAUrGcIxGEqAX2xdBGnWnZAGRbZSlZkZ1IlyFruCZnCHwAKD
	ypPoIKb5uzfibk=
X-Received: by 2002:a17:90b:6ce:b0:3a6:e9bf:f244 with SMTP id 98e67ed59e1d1-3ab3a369de9mr902451a91.1.1791542933578;
        Fri, 09 Oct 2026 03:48:53 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 46/51] selftests/bpf: tests for register base/step arithmetic
Date: Fri,  9 Oct 2026 03:48:04 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-46-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

- step_arith{32,64}_no_overflow: non-overflowing +, *, <<
  operations maintain step and base.
- step_neg_value_range: Preserve the signed range of {-3, 0, 3, 6}
  when intersecting with a non-power-of-two step across zero.
- step_arith{32,64}_overflow: Reset the stride and preserve valid
  bounds when a {32,64}-bit operation wraps.
- step_mov32_truncate: Reset the stride when MOV32 discards nonzero
  upper bits from positive values.
- step_mov32_negative: Reset the stride when MOV32 zero-extends
  the low 32 bits of negative signed values.
- step_movsx: Reset the stride when sign extension changes the
  register value.
- step_movsx_bounds_on_line: Keep bounds and stride when sign
  extension does not change the register value.
- step_bounds_resync_after_arith: Snap bounds refined from var_off
  back onto the line.
- step_linked_regs_add64: Translate both bounds and base when
  propagating a comparison's refinement through a scalar-ID delta.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_bounds_step.c     | 363 +++++++++++++++++++++
 2 files changed, 365 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 460ad10ddc02..4f3af1cb998b 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -20,6 +20,7 @@
 #include "verifier_basic_stack.skel.h"
 #include "verifier_bitfield_write.skel.h"
 #include "verifier_bounds.skel.h"
+#include "verifier_bounds_step.skel.h"
 #include "verifier_bounds_deduction.skel.h"
 #include "verifier_bounds_deduction_non_const.skel.h"
 #include "verifier_bounds_mix_sign_unsign.skel.h"
@@ -205,6 +206,7 @@ void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
 void test_verifier_bounds(void)               { RUN(verifier_bounds); }
+void test_verifier_bounds_step(void)          { RUN(verifier_bounds_step); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
 void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_bounds_deduction_non_const); }
 void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_unsign); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
new file mode 100644
index 000000000000..3a0d22aa4fb8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* Tests for the linear "base + step * k" description tracked per scalar register. */
+
+#define __no_step __not_msg("step=") __msg("\n")
+
+/*
+ * Safe ALU64 arithmetic preserves a non-power-of-two stride and scales its base:
+ * step=0+3 -> step=1+3 -> step=2+6 -> step=4+12.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 *= 3 {{.*}}step=0+3)")
+__msg("r0 += 1 {{.*}}step=1+3)")
+__msg("r0 *= 2 {{.*}}step=2+6)")
+__msg("r0 <<= 1 {{.*}}step=4+12)")
+__naked void step_arith64_no_overflow(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r0 *= 3;					\
+	r0 += 1;					\
+	r0 *= 2;					\
+	r0 <<= 1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Safe ALU32 multiplication and addition preserve the stride and scale its base:
+ * step=0+3 -> step=1+3 -> step=2+6. MOV32 preserves the result.
+ * LSH32 currently resets the stride, but must preserve the correct upper bound.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("w0 *= 3 {{.*}}step=0+3)")
+__msg("w0 += 1 {{.*}}step=1+3)")
+__msg("w0 *= 2 {{.*}}step=2+6)")
+__msg("w1 = w0 {{.*}}R0=scalar({{.*}}step=2+6) R1=scalar({{.*}}step=2+6)")
+__msg("w0 <<= 1 {{.*}}smax=umax=smax32=umax32=3064,") __no_step
+__naked void step_arith32_no_overflow(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	w0 *= 3;					\
+	w0 += 1;					\
+	w0 *= 2;					\
+	w1 = w0;					\
+	w0 <<= 1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Sign-crossing range with a non-power-of-2 step. After "*= 3; += -3" the value
+ * set is {-3, 0, 3, 6}. The line description is tracked in signed space, so the
+ * intersection keeps smax=6.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 += -3 {{.*}}smax=smax32=6,step=0+3)")
+__naked void step_neg_value_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 3;					\
+	r0 *= 3;					\
+	r0 += -3;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * 0x49249249 * 7 wraps to U32_MAX; inferring step=0+7 would incorrectly
+ * cap the result at 0xfffffffc instead of U32_MAX.
+ * Adding 4 to {0xfffffffc, U32_MAX} wraps to {0, 3}; keeping step=1+3
+ * incorrectly narrows the result to 1.
+ * Shifting the same input left by 1 gives {0xfffffff8, 0xfffffffe};
+ * inferring step=0+6 incorrectly narrows the result to 0xfffffffc.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("w0 *= 7 {{.*}}umax=0xffffffff,") __no_step
+__msg("r2 = r0 {{.*}}R0=scalar({{.*}}step=0+3) R2=scalar({{.*}}step=0+3)")
+__msg("w0 += 4 {{.*}}smax=umax=smax32=umax32=3,") __no_step
+__msg("w2 <<= 1 {{.*}}smax=umax=umax32=0xfffffffe,") __no_step
+__naked void step_arith32_overflow(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 *= 7;					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 1;					\
+	r0 *= 3;					\
+	r1 = 0xfffffffc ll;				\
+	r0 += r1;					\
+	r2 = r0;					\
+	w0 += 4;					\
+	w2 <<= 1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Multiplying {0x2aaaaaaaaaaaaaab, 0x2aaaaaaaaaaaaaac} by 3 crosses S64_MAX
+ * and gives {S64_MIN + 1, S64_MIN + 4}. Keeping step=0+3 excludes both.
+ *
+ * Adding 5 to {S64_MAX - 4, S64_MAX - 1} gives {S64_MIN, S64_MIN + 3}.
+ * Updating the line to step=2+3 incorrectly narrows it to S64_MIN + 1.
+ *
+ * Adding -5 to {S64_MIN + 1, S64_MIN + 4} wraps to
+ * {S64_MAX - 3, S64_MAX}. The stale base 0 modulo 3 excludes S64_MAX.
+ *
+ * Shifting {0x4000000000000008, 0x400000000000000b} left by 1 gives
+ * {S64_MIN + 16, S64_MIN + 22}. Keeping step=0+6 excludes both.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 *= 3 {{.*}}smax=0x8000000000000004,") __no_step
+__msg("r0 += r1 {{.*}}step=0+3)")
+__msg("r0 += 5 {{.*}}smax=0x8000000000000003,") __no_step
+__msg("r0 += r1 {{.*}}step=2+3)")
+__msg("r0 += -5 {{.*}}umax=0x7fffffffffffffff,") __no_step
+__msg("r0 += r1 {{.*}}step=0+3)")
+__msg("r0 <<= 1 {{.*}}smax=0x8000000000000016,") __no_step
+__naked void step_arith64_overflow(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 1;					\
+	r2 = r0;					\
+	r1 = 0x2aaaaaaaaaaaaaab ll;			\
+	r0 += r1;					\
+	r0 *= 3;					\
+	r2 *= 3;					\
+	r0 = r2;					\
+	r1 = 0x7ffffffffffffffb ll;			\
+	r0 += r1;					\
+	r0 += 5;					\
+	r0 = r2;					\
+	r1 = 0x8000000000000001 ll;			\
+	r0 += r1;					\
+	r0 += -5;					\
+	r0 = r2;					\
+	r1 = 0x4000000000000008 ll;			\
+	r0 += r1;					\
+	r0 <<= 1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * MOV32 maps {2^32, 2^32 + 3} to {0, 3}. The old base 1 modulo 3
+ * excludes both results.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 += r1 {{.*}}step=1+3)")
+__msg("w0 = w0 {{.*}}smax=umax=smax32=umax32=3,") __no_step
+__naked void step_mov32_truncate(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 1;					\
+	r0 *= 3;					\
+	r1 = 0x100000000 ll;				\
+	r0 += r1;					\
+	w0 = w0;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * MOV32 maps {-4, -1} to {0xfffffffc, U32_MAX}. The old base 2
+ * modulo 3 excludes U32_MAX.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 += -4 {{.*}}step=2+3)")
+__msg("w0 = w0 {{.*}}umax=0xffffffff,") __no_step
+__naked void step_mov32_negative(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 1;					\
+	r0 *= 3;					\
+	r0 += -4;					\
+	w0 = w0;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Sign-extending {128, 131} from s8 gives {-128, -125}.
+ * Keeping base 2 modulo 3 incorrectly narrows the result to -127.
+ *
+ * Sign-extending {32768, 32771} from s16 gives {-32768, -32765}.
+ * Keeping base 2 modulo 3 incorrectly narrows the result to -32767.
+ *
+ * Sign-extending {2^31, 2^31 + 3} from s32 gives {S32_MIN, S32_MIN + 3}.
+ * Keeping base 2 modulo 3 incorrectly narrows the result to S32_MIN + 1.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 += 128 {{.*}}step=2+3)")
+__msg("r0 = (s8)r0 {{.*}}smax=smax32=-125,") __no_step
+__msg("r0 += 32768 {{.*}}step=2+3)")
+__msg("r0 = (s16)r0 {{.*}}smax=smax32=-32765,") __no_step
+__msg("r0 += r1 {{.*}}step=2+3)")
+__msg("r0 = (s32)r0 {{.*}}smax=0xffffffff80000003,") __no_step
+__naked void step_movsx(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 1;					\
+	r0 *= 3;					\
+	r2 = r0;					\
+	r0 += 128;					\
+	r0 = (s8)r0;					\
+	r0 = r2;					\
+	r0 += 32768;					\
+	r0 = (s16)r0;					\
+	r0 = r2;					\
+	r1 = 0x80000000 ll;				\
+	r0 += r1;					\
+	r0 = (s32)r0;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * R1 = R0 + 1 shares R0's scalar ID. Refining R0 to {0, 3, 6} must
+ * translate its line as well as its bounds when updating R1 to {1, 4, 7}.
+ * Copying R0's base 0 modulo 3 excludes the reachable value 7.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("r1 += 1 {{.*}}step=1+3)")
+__msg("if r0 > 0x6 {{.*}}R1=scalar({{.*}}smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=7,{{.*}}step=1+3)")
+__naked void step_linked_regs_add64(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 3;					\
+	r0 *= 3;					\
+	r1 = r0;					\
+	r1 += 1;					\
+	if r0 > 6 goto l_out_%=;			\
+	r0 = r1;					\
+l_out_%=:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * r0 &= 7       -> [0, 7]
+ * r0 *= 24      -> [0, 168]   step=0+24
+ * r0 += 8       -> [8, 176]   step=8+24
+ * r0 & 0x10     -> [32, 176]  step=8+24  (var_off alone: umin=16)
+ * r0 > 80       -> [104, 176] step=8+24  (var_off alone: umin=88)
+ * r1 += 24      -> [128, 200] step=8+24
+ * Bounds and step stay in sync after each refinement.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 += 8 {{.*}}smin=umin=smin32=umin32=8,smax=umax=smax32=umax32=176,{{.*}}step=8+24)")
+__msg("from 4 to 6: R0=scalar(smin=umin=smin32=umin32=32,smax=umax=smax32=umax32=176,{{.*}}step=8+24)")
+__msg("r1 = r0 {{.*}}R1=scalar(id={{[0-9]+}},smin=umin=smin32=umin32=104,smax=umax=smax32=umax32=176,{{.*}}step=8+24)")
+__msg("r1 += 24 {{.*}}R1=scalar({{.*}}smin=umin=smin32=umin32=128,smax=umax=smax32=umax32=200,{{.*}}step=8+24)")
+__naked void step_bounds_resync_after_arith(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 7;					\
+	r0 *= 24;					\
+	r0 += 8;					\
+	if r0 & 0x10 goto l_set_%=;			\
+	goto l_out_%=;					\
+l_set_%=:						\
+	if r0 <= 80 goto l_out_%=;			\
+	r1 = r0;					\
+	r1 += 24;					\
+	*(u64 *)(r10 - 8) = r1;				\
+l_out_%=:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * r0 &= 7       -> [0, 7]
+ * r0 *= 24      -> [0, 168]    step=0+24
+ * r1 = (s16)r0  -> [0, 168]    step=0+24
+ * r0 += -24     -> [-24, 144]  step=0+24
+ * r2 = (s16)r0  -> [-24, 144]  step=0+24
+ * r3 = (s8)r0   -> [-128, 127] no step
+ * w4 = (s16)w1  -> [0, 168]    step=0+24
+ * w5 = (s8)w1   -> [-128, 127] no step
+ * Bounds and step stay in sync, the step is dropped when the value does not fit.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("r1 = (s16)r0 {{.*}}R1=scalar(id={{[0-9]+}},smin=smin32=0,smax=umax=smax32=umax32=168,{{.*}}step=0+24)")
+__msg("r2 = (s16)r0 {{.*}}R2=scalar(smin=smin32=-24,smax=smax32=144,{{.*}}step=0+24)")
+__msg("r3 = (s8)r0 {{.*}}R3=scalar(smin=smin32=-128,smax=smax32=127)") __no_step
+__msg("w4 = (s16)w1 {{.*}}R4=scalar(id={{[0-9]+}},smin=smin32=0,smax=umax=smax32=umax32=168,{{.*}}step=0+24)")
+__msg("w5 = (s8)w1 {{.*}}R5=scalar({{.*}}smin32=-128,smax32=127,{{.*}})") __no_step
+__naked void step_movsx_bounds_on_line(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 7;					\
+	r0 *= 24;					\
+	r1 = (s16)r0;					\
+	r0 += -24;					\
+	r2 = (s16)r0;					\
+	r3 = (s8)r0;					\
+	w4 = (s16)w1;					\
+	w5 = (s8)w1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.53.0
