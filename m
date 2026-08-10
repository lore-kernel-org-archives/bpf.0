Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873F3090D4
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388979; cv=none; b=P7pedBVfq0Bq444YiGhtbe80Mj8xETCzixRnjeV4kXdo1dcvMMfxNXPUmNumkWyX8f8STBnuMBXSQljtUjeO4Kh4xMOR5QKkuHIHMyKJvqGhbD3eYHngY3LQHxy7spk3YrywkQhdF+pIiWbyNQNFcE9lImdQ8ZlI174Ov8/NmpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388979; c=relaxed/simple;
	bh=/ILh9Jua4mFxD/uOItmnjGL5SS9cY6Bq+y6LfSqRz7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTfYTcTgbGvWeFiR8v43FpJJgq7K4uPm2z1P5WcZkLnFJYq2WlYZFNWdT9vdy0/1VqSCa3Le3i8RuFWEIhg4xoX7sBWs8yJKmVjTqqwZxzuQoeWVogAjFrY7P0yxST4I5Yz/YLn2/xG0HpgXtXxYkEcqIr9Qhx6MUSVa1TsNfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+LSbQNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+LSbQNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21A91F000E9;
	Mon, 10 Aug 2026 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388978;
	bh=Oc+vPC0k/si5rDWVtB3oh2fKD8nr3VrnaodlGJ6USnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O+LSbQNl+LKQwXALtSE947uzHN8DAyg+B9BhTEmKGnZd1QyMpMHM+JFyZ9rO3J9Cq
	 OtMK+clIebo04PLZ7OKNTTipBbtvOQPyCK2e5kghqTjDjIfafrxjoTJpbjBzhJp1LB
	 P3rNFiGQB/T4RjZhO1gFVxfUvUeudXJQhtYnxoQrAvo0dy8OLmsfcV+xFsXBR83xz1
	 Tp15HYmjbKFBIIFaj/0+8i/y2dwpmGGHSR1iZLZcjukJ4q1kj5J67ym0lw0q1NAGJ4
	 e6nO45N2tDBX8IiJkiJ0OTOagp9lvqBg0gXmRc1aByFnTN0K/CaQAMZ8SUx7TXnRjQ
	 4u372PzA3cSzA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH bpf-next 1/7] bpf, arm64: Fix stack-passed arguments for indirect trampolines
Date: Mon, 10 Aug 2026 12:09:14 -0700
Message-ID: <20260810190922.3408757-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810190922.3408757-1-puranjay@kernel.org>
References: <20260810190922.3408757-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

save_args() reads stack-passed arguments relative to FP assuming the
trampoline is entered through the fentry call from a traced function, in
which case both the parent frame (FP/x9) and the traced function frame
(FP/LR) are saved before FP is set, so the arguments start at FP + 32.

An indirect trampoline for a struct_ops callback is entered through a
function pointer (blr), so only the FP/LR frame is pushed and the
arguments start at FP + 16, not FP + 32. Every stack-passed argument of
a struct_ops callback with more than eight argument slots is read two
slots off.

This went unnoticed because no struct_ops member passed arguments on the
stack until bpf_testmod_ops3::test_arena_stack, added by
commit 2d4de9a493a0 ("selftests/bpf: Test stack-passed struct_ops arena arguments").
That member covers this on arm64 once the JIT gains arena argument
support later in this series. Pass is_struct_ops into save_args() and
pick the offset accordingly, mirroring the x86 fix.

Fixes: 9014cf56f13d ("bpf, arm64: Support up to 12 function arguments")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index d14d297ebb967..4af5a98b84e19 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2509,9 +2509,8 @@ static void clear_garbage(struct jit_ctx *ctx, int reg, int effective_bytes)
 }
 
 static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
-		      const struct btf_func_model *m,
-		      const struct arg_aux *a,
-		      bool for_call_origin)
+		      const struct btf_func_model *m, const struct arg_aux *a,
+		      bool for_call_origin, bool is_struct_ops)
 {
 	int i;
 	int reg;
@@ -2531,7 +2530,15 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
 		bargs_off += 8;
 	}
 
-	soff = 32; /* on stack arguments start from FP + 32 */
+	/*
+	 * On-stack arguments start above the frame(s) pushed by the trampoline
+	 * prologue. Entered through the fentry call from a traced function, the
+	 * prologue saves both the parent (FP/x9) and the traced function
+	 * (FP/LR) frames, so the arguments start at FP + 32. A struct_ops
+	 * callback is called indirectly and only the FP/LR frame is saved, so
+	 * they start at FP + 16.
+	 */
+	soff = is_struct_ops ? 16 : 32;
 	doff = (for_call_origin ? oargs_off : bargs_off);
 
 	/* save on stack arguments */
@@ -2721,7 +2728,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	store_func_meta(ctx, func_meta, func_meta_off);
 
 	/* save args for bpf */
-	save_args(ctx, bargs_off, oargs_off, m, a, false);
+	save_args(ctx, bargs_off, oargs_off, m, a, false, is_struct_ops);
 
 	/* save callee saved registers */
 	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -2770,7 +2777,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* save args for original func */
-		save_args(ctx, bargs_off, oargs_off, m, a, true);
+		save_args(ctx, bargs_off, oargs_off, m, a, true, is_struct_ops);
 		/* call original func */
 		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
 		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
-- 
2.53.0-Meta

