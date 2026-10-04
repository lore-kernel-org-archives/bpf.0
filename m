Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041543934A
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121153; cv=none; b=Xod6uPLwdGrH7ZfYOhxoHk5v+fSOOxScxNd4jbF9f++Uy8nVLdJlz9zLV0nMCO85HuviQf2YI17x8q6irMN8cBJM2sZ3CfkaHC4MJW4XG9XrVOmbJ5MeOf867BcV1giL4wnwkQQS9UXq6Uu3c1VEItqY9wZej3dUUUCN3j1wWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121153; c=relaxed/simple;
	bh=vv8hZIDbhk+0Sjlp53hgIKBfvZhCV1lU34K+uSU7Nmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGGpWaId2l7Z+ymBitpqIeG0EIG+xTHibpsnjb+G+eswITYs3SyMv874eNMlsGYTNaaCcmg6CcLzmj2z5jOXOO5TiEEKYR6slSkGExJQWhNxjYjisS7TIajLngvTcDWLqPoFVcluOoDd1y9KC/Pei2wXGMHc9daD/2yT41a6BJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpzeP4zM; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpzeP4zM"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4c3304833so222901a12.3
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121151; x=1791725951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yo2t9W/lz6cM2cv3eUoFvC83tUrJm/BFi8seqKxNDNE=;
        b=bpzeP4zMbIXT+eXk8+quZyx0aGwoO0aSFMzmJWp7m0KJDlikgv84bBVAf3IsOXUBg2
         wl0tW5d24k2rE1+WWg/CmXIQAhOOWaFAovkNa1TGHYMeVsXEL7rk9LqByxs2i5cLLI9R
         OUaoaYIcmGl+YSxG9cf2+hR1Nv6r9u3m1uDMlGhn0DnDoJdBk3CFqiGpf83Qhw005Y+n
         AWi9RVhcFdhqx0K1UY+O/CgDo3+kwgPwxQJdj2ioo956MKC79g8iEWircoBC7Uc01lxr
         FzanuRA3KSHbiU8LGErvXuQMfxRZ+nO8IbzpAUKwJdyVcrvq613rRLa7sURKjnUcq01L
         QXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121151; x=1791725951;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yo2t9W/lz6cM2cv3eUoFvC83tUrJm/BFi8seqKxNDNE=;
        b=XwWF4UiZl5VmWtJyz8NtLxtiYcmDBmScPAyMsjDgJpREnzs3OPkWu3odkxXDQ662o3
         8WjGcT2EZKdPTnPLwTRhOKDQLbFJqq9Qa5e/l9DUmIR/y8yBmc/q2U5AWbY2nFXw3Ui7
         sNH+/NgnMT/SKRMDi1722yLhtbnvWtZDGNOOd/vIzeJtKfUnPtr+uHBQfU5dS0ma4nGL
         Miaqtii/bEFQ63h8EMXohurTv7XXQ8IYOCRdU1wUx8yHBgu3VkUgyHdXA/IFz74lIDxV
         1yxoirCzIrXADx/pfPifU5N2XN3d9VkYCbVV8Ai6Nh3QUyRyTniFtGmU2ejt6ryzaXpH
         ikKg==
X-Gm-Message-State: AFq9FYJBHH47YPGZK+5NDxuj3dyjl7XwcjECvlS7Lw9kckftmgroFdXk
	RZPRPVnliOPaxcu1uoGPiVsI3luGst/hwwsKFfYufxqIeK148jwh/Vz2UgscSA==
X-Gm-Gg: AYBFou3HyQu9EYq+hGxxSiHEz93B9j75mvm+tgLMy1Ii9cjAO+9ldy58GW9VJC+yLkv
	E0O7T/ia3En/pfR6L67M7+cUuuBuFX/6Uy+GrkpLtgiJjfN+0QKnV2knr4r/Jq93K+/17aC4dtJ
	ZED5MVpthCqLCRfan7nwFz3amq6En6aHAYhMgcIezf9COitYsKzvd8rY+eFw04booDTRNMTf+Vd
	siRi1OUKgUDN+4wzTaYr+URG3DypO7TPBon4V5MaPwqE0EJCOXI7MXKc2hs1mx7MkuDvrBUgVD0
	iZTWGftgyeO5jT+ybg0Nbr+2JhaAUMYoyGv8OJzZeiyGdSzTIrXoYdoVKVeuGopP9vQsZtSZH1q
	5yPN4KdqUqr5hSpiJckv9q+qTUWnxqww/XrD2+XSIwY0C3aE4WDEE8LNLpXWoIzYb6DBVXanaDK
	XDmZYS6S9tZbpf/Z6ZBjwk2hou7iflerb3wyeTcNDB5jiulDm8wy4Ayfx7CoDGtOqOa4sVSZiqa
	vUkCzEb+4EezMQ=
X-Received: by 2002:a17:90b:2885:b0:3a4:adea:50c3 with SMTP id 98e67ed59e1d1-3a6ce82b564mr6050213a91.49.1791121150895;
        Sun, 04 Oct 2026 06:39:10 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 38/43] selftests/bpf: tests for register base/step arithmetic
Date: Sun,  4 Oct 2026 06:38:20 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-38-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

- step_mul_non_pow2: Retain step 3 after multiplying a bounded scalar
  by a non-power-of-two constant.
- step_lsh: Record step 4 after shifting a bounded scalar left by two.
- step_add_const_base: Shift the base to 1 while preserving step 4
  after adding a constant.
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
- step_linked_regs_add64: Translate both bounds and base when
  propagating a comparison's refinement through a scalar-ID delta.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_bounds_step.c     | 290 +++++++++++++++++++++
 2 files changed, 292 insertions(+)

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
index 000000000000..079e34820a8f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
@@ -0,0 +1,290 @@
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
+__msg("w1 = w0 {{.*}}step=2+6)")
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
+ * intersection keeps smax=6. A u64-modular intersection would mis-place the
+ * line for the negative values and wrongly narrow smax to 4.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 += -3 {{.*}}smax=smax32=6)")
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
+ * 0x49249249 * 7 wraps to U32_MAX. Keeping step=0+7 incorrectly caps the
+ * result at 0xfffffffc instead of U32_MAX.
+ * Adding 4 to {0xfffffffc, U32_MAX} wraps to {0, 3}; keeping step=1+3
+ * incorrectly narrows the result to 1.
+ * Shifting the same input left by 1 gives {0xfffffff8, 0xfffffffe};
+ * keeping step=0+6 incorrectly narrows the result to 0xfffffffa.
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
+char _license[] SEC("license") = "GPL";

-- 
2.53.0
