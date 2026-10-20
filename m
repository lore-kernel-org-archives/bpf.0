Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519315;
	b=cMeqPkFHWa+CqL8KXOHis+Zv36prhdklqfLqqciNDFUePFzXeg5hqA+nBDofQLyMCNmD
	 Zt6elc9z40w896EG8to7p/2uHIp4dRLawAetkageC6rR9fXtxTdwSRplLLFvGQLX+SgVp
	 rDiv/6CckJSBrGKBCQrU6BDRGb0kHHvDDJwULpv2S3k25cFdLeRHpjqM0zQkOASsBVeRb
	 xeoVOk+K1ejHDWgk+rish93MOxPedPLLoPg+X3cMu0KtwPJ6GKWBpuTCkHBx/cdop7D2k
	 uoTVpXNuDhog9XzAZGOebCAiR5LjeyC1ffsf2YbzF3qEXu5VMvU4HmuaSS/PtIlw4RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=PzxBmXxz2S9+xqMHjY/Mvx86jOdkxBtADkyPsu2Pxcg=;
	b=XPsk7+IwyFnUoOcyqBueA96N8PPmYeqdP8zLZQCbssTOvhxW2MOiy4oSeFcMFK4AVPDC
	 EH/nY1o2osKNG5yU0m5aMntus4PbLAeyFzR2Zy7S8itGCr4JC21EqBJN3uctZfQwqYJS1
	 MyKcSI0E9KYKlaAaYWfAnZAaWX1CXiAOQpvAwR78KF6MwF6mceYRRHn9vvk4ks1m3FxUY
	 Qx36tNV9vdcXQNfpz6AZQQ9nprW7lMp/FgInsFwgz6/EMCsJ+FH+U4X6iftIw6TOTrTzW
	 cgzTzqw5cXVPo4nmRd64UG6aOqv1EQ6cqu7bodaenc1tmTyyLzp6CR+T8K15jjEKwsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hFJWzAOA;
	arc=none smtp.remote-ip=74.125.225.72
Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B37606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60B37606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hFJWzAOA
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48df4afd489so1156309f8f.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519314; x=1793124114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PzxBmXxz2S9+xqMHjY/Mvx86jOdkxBtADkyPsu2Pxcg=;
        b=hFJWzAOAJMX1OXDqeF5Z5852Z5O49wymGa1hw9TdNMINKT/yyVJTmJN4BRo46a8WEm
         3F4VGv2stoP4FkcNfLh/vaSXrGZj7i7HoJMP2xtXY9CQH9TjwSkaZI/4JX2EnEKS3q58
         WLtsFB55AsaU/VA4rI2T7tPMw4heaK/uvtXPCorH2mMaFxapcCz+xRpZ3uyO8X9T7pAw
         +KnsdVH+jxUpGpB3vc7QOWQoTd0Fa5EIj1SdKzmNOTD1w5Yq7p1hFEiC/TyNNDI1SfGj
         9jws1C0+WJaQbPT1kwhZYVkn+20UA+PCwlxBUW2Z8+DxRNdxNXJw6kmaR9+G+5z3L5Io
         Z2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519314; x=1793124114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PzxBmXxz2S9+xqMHjY/Mvx86jOdkxBtADkyPsu2Pxcg=;
        b=Y1LROutVLvAp55n3jI7Hkx5E6WpqgQPTjFGkrD4aagnGfTYJFs8zvSx1uqNTQ0O8mK
         x0wMnTxSBYBK6CxNRvyhGZNseqCI4uBQlqgxwogjjYBVD3a7l+Ag82xul5fJZTPVQaRE
         J+vIqv9CxOMkUo1yzuO2mbN3Q/CNuJF5ZjYRPeimrG6Nnu5IhEnebXdpaP9HiJFj4muf
         SATzdB/eUbH17zRd0lEnaj3MMcHIL/655SHtcF6xJ+2lpj5gUxssojnKpulH4q+lU6LZ
         GBP3gcRlg4Di6bQWn0ke2H2waQZYLME5qaak06k1DtpbBzYh/jqAD3vcvkSNhwEjvWaI
         5mxQ==
X-Gm-Message-State: AFq9FYL/HXFDbqKiSddnDeOCUsWIXllMGk/zGlc/KBaKg6Jt8Xis64Zy
	1F9n4ZRue2Mi3cbv22Po0Z15ni6H/8JFyaDWQxRPQdYWpSgMZPKVPLOZUGN4Ez41
X-Gm-Gg: AYBFou1C39575UzU9SH4k5ss27FVmUoYw6rgxLtySsVXzbrnKtQqnRJP+BrB0djfvxc
	04CQZ7zKSsSNiPdBsDpDyUNve9YSv6FhOawvF7FixyF4el2aBkwR3qM7jiTuVY/ukNaxsg6xEr3
	dLfVUuo34VLg5AgoozFaamhmCsUeZP9uWNtPE61TCwPtVtvU36pxLuWBTHxqDvZdm/SdyBpWvDE
	605vrKwzVrtlYKPC3MsPCBfz2OAmWeqZIN9VE05Yh2D+727UmkRAhrhPlih1aBCksOKHu7WMa5u
	hNOm1GLlBLCWdPFuwyGp0N9/HtC835/CS1kSORLSbVk6wSW33wTP1eH2bOKAFA7IT6w5qO6Mda1
	9QvnqQgXrXXBynwyFzT1xa+FyIxTmlDr22vEZKZz4vAEENaweZuHnPG86Lm2PsVhWsMbyruQxb8
	Zl7p8BYrAMMN/Ejyij0O0r8hWMq01fLW0Npchwh1x0Rrv1cj+QaZKKqLzDwpBFBnYGu8gBvYV5i
	q1VctpxhqNwBflt/vV3lPoDiGMylAJog/jMTFn3otu7qTA0IYmjj7z4cFbDdHgsU3dIi/gOnlfV
	1VdxAduRnuKx8Iq2qDrAOMw9Nxz46unmfL9cZg==
X-Received: by 2002:a05:6000:2990:20b0:48b:11df:c496 with SMTP id ffacd0b85a97d-48e07bbffddmr17119346f8f.28.1792519313307;
        Tue, 20 Oct 2026 11:01:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f0b1sm16699f8f.9.2026.10.20.11.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:01:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/6] bpf: Record where JITed subprograms keep callee-saved registers
Date: Tue, 20 Oct 2026 20:01:38 +0200
Message-ID: <20261020180147.1769873-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020180147.1769873-1-memxor@gmail.com>
References: <20261020180147.1769873-1-memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6643; i=memxor@gmail.com; h=from:subject; bh=ltt2d6Vm5+Hs+T2C8O3a2PZteR8EGPScbv6PNFp9re0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIev6ioeHePjib/xPEgnafDstvof9ySqmLP2D9+85xse8m H6EuVOpo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOp+8zI8G+byN5p2XusOy3e dqpP3dLtF+x3jvvQ06sVcRuzV5/69oyRYd07zuyL9+yLppWvnSFTt2nHil9L1n2dcNPKXbmXzbv VnRMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

When bpf_throw() unwinds to the exception callback of the main program,
the frames between the throw site and the main program are discarded
without their epilogues running, so the callee-saved registers they
clobbered have to be restored some other way. Doing that from the frames
themselves needs, for each JITed program, where its prologue saved the
caller's R6..R9: walking from the throw site outwards, a register is
either still in the physical register, when no deeper frame saved it, or
sits in the prologue spill area of the nearest deeper frame that did.

Add callee_reg_off[4] to struct bpf_prog_aux, holding the offset of each
saved register from the native frame pointer that arch_bpf_stack_walk()
reports for the frame, or 0 when the register is not saved, and fill it
in from the x86-64 and arm64 JITs. Nothing consumes it yet.

On x86-64 the frame below rbp holds, from high to low addresses, the
program stack of round_up(stack_depth, 8) bytes (none with a private
stack), the tail call count and its pointer when tail_call_reachable,
r12 when the program is an exception boundary or uses an arena, and then
rbx, r13, r14 and r15 in push order, each only when it is pushed. An
exception boundary pushes all four.

On arm64 the frame record sits at x29, the tail call count pair right
below it, and the callee-saved registers follow as 16 byte pairs in the
order find_used_callee_regs() lists them, with the first register of a
pair at the lower address. The i-th pushed register is thus at
-32 - 16 * (i / 2) + 8 * (i % 2). An exception boundary pushes x19..x28
in order, so R6..R9 take the first four slots.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 37 +++++++++++++++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp.c   | 33 +++++++++++++++++++++++++++++++
 include/linux/bpf.h           |  6 ++++++
 3 files changed, 76 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 1d5f4cf88d33..6a99f883a091 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -421,6 +421,42 @@ static void find_used_callee_regs(struct jit_ctx *ctx)
 	ctx->nr_used_callee_reg = i;
 }
 
+/*
+ * Offset from the frame pointer of the @idx-th register pushed by push_callee_regs(). The
+ * frame record sits at the frame pointer, the tail call count pair right below it, and
+ * then the pushed pairs, each 16 bytes with its first register at the lower address.
+ */
+static int callee_reg_slot_off(int idx)
+{
+	return -32 - 16 * (idx / 2) + 8 * (idx % 2);
+}
+
+/*
+ * Record where push_callee_regs() saved the caller's R6..R9, relative to the frame
+ * pointer that arch_bpf_stack_walk() reports for this frame, for the exception unwinder.
+ * An exception boundary pushes x19..x28 in order, so R6..R9 take the first four slots.
+ */
+static void record_callee_reg_off(struct jit_ctx *ctx)
+{
+	struct bpf_prog_aux *aux = ctx->prog->aux;
+	int i, j;
+
+	if (aux->exception_boundary) {
+		for (i = 0; i < 4; i++)
+			aux->callee_reg_off[i] = callee_reg_slot_off(i);
+		return;
+	}
+	for (i = 0; i < 4; i++) {
+		aux->callee_reg_off[i] = 0;
+		for (j = 0; j < ctx->nr_used_callee_reg; j++) {
+			if (ctx->used_callee_reg[j] != bpf2a64[BPF_REG_6 + i])
+				continue;
+			aux->callee_reg_off[i] = callee_reg_slot_off(j);
+			break;
+		}
+	}
+}
+
 /* Save callee-saved registers */
 static void push_callee_regs(struct jit_ctx *ctx)
 {
@@ -451,6 +487,7 @@ static void push_callee_regs(struct jit_ctx *ctx)
 			emit(A64_PUSH(reg1, A64_ZR, A64_SP), ctx);
 		}
 	}
+	record_callee_reg_off(ctx);
 }
 
 /* Restore callee-saved registers */
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ea97e068efda..2d7495438d18 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -427,6 +427,24 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
 	*pprog = prog;
 }
 
+/*
+ * Record where push_callee_regs() saved the caller's R6..R9 relative to rbp, for the
+ * exception unwinder. @off is the offset of rsp from rbp right before the first push.
+ */
+static void record_callee_reg_off(struct bpf_prog *prog, s32 off, bool *callee_regs_used)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (!callee_regs_used[i]) {
+			prog->aux->callee_reg_off[i] = 0;
+			continue;
+		}
+		off -= 8;
+		prog->aux->callee_reg_off[i] = off;
+	}
+}
+
 /* add rsp, depth */
 static void emit_add_rsp(u8 **pprog, u32 depth)
 {
@@ -2530,6 +2548,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	u32 stack_depth;
 	int callee_saved_size;
 	s32 outgoing_arg_base;
+	s32 callee_regs_off;
 	int err;
 
 	stack_depth = bpf_prog->aux->stack_depth;
@@ -2591,6 +2610,20 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		push_callee_regs(&prog, callee_regs_used);
 	}
 
+	/*
+	 * Record where the pushes above saved the caller's R6..R9, relative to the
+	 * rbp that arch_bpf_stack_walk() reports for this frame. Below rbp lie, from
+	 * high to low addresses: round_up(stack_depth, 8) bytes of program stack
+	 * (none with a private stack), the tail call count and its pointer (16 bytes)
+	 * when tail_call_reachable, r12 when exception_boundary or arena_vm_start,
+	 * and then rbx, r13, r14 and r15 in push order, each only when pushed.
+	 */
+	callee_regs_off = -(s32)round_up(stack_depth, 8) - (tail_call_reachable ? 16 : 0);
+	if (bpf_prog->aux->exception_boundary || arena_vm_start)
+		callee_regs_off -= 8;
+	record_callee_reg_off(bpf_prog, callee_regs_off,
+			      bpf_prog->aux->exception_boundary ? all_callee_regs_used : callee_regs_used);
+
 	/* Compute callee-saved register area size. */
 	callee_saved_size = 0;
 	if (bpf_prog->aux->exception_boundary || arena_vm_start)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7750df973494..010f14bb6c77 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1939,6 +1939,12 @@ struct bpf_prog_aux {
 	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
 	u16 stack_arg_sp_adjust;
 	u16 freplace_link_cnt; /* counts freplace links extending this prog */
+	/*
+	 * Offsets from the native frame pointer of this JITed program at which
+	 * its prologue saved the caller's R6..R9, or 0 when that register is not
+	 * saved. Filled by the JIT; consumed by the exception unwinder.
+	 */
+	s16 callee_reg_off[4];
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
-- 
2.53.0

