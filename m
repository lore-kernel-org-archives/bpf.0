Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CC501F49
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107731; cv=none; b=gMsEPquK3ZPeY6OJPNdONe2EKM1ESlO922TwrLsqXMAqh1TccyJw8Q1IB4H8FE6u5G2f389IegIVCckSJ7k4cHq4vkm/7EC5dp9wGE77jV9Bpx59fFQjsJhoyAIlrRKv3jlNeJ9cPH8xLegNyA2wn6vifcFOYgg4xVSn1qdkB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107731; c=relaxed/simple;
	bh=H35SOpNTwgPPTzTzWtgDmdkVoG6eiFyd1GykslMm3j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VN9A4AOgo93ovt0Ri263ONpZZpd6quDZQ9Hs0fAzRtgcWosAFzdnaeB3TH8aqIVGmZHGFwK634GIxKd5ZsMypUzpql8H78w7INW7LNywNFwD4zMgh3zJJbGWLY7y+L2FP5JkZQ6yInKe+r9on+lgdSgqrz/rKl09gDt8O5BC0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhPBghyD; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhPBghyD"
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-8217177c5daso995934a34.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107728; x=1792712528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5eAl+uSul+z/ledz5bhFoJ6lwq5K33tN/upCHBIBpo=;
        b=lhPBghyDx4ZyjDD3gEnlz8VcP1tgR09Osxz2UfA1i99kL3WlchvalRffr5TGlvwFq5
         pS0uRI19Hl2rmuxV0QWJ1tah44yyasq/8of7T9AUzzdp0T4c9lyOz/ulGbqEB0p1z5Dw
         CnbC5EtpdS0hOhYLVmH/bxnaIglUs7oNyks3PFkDoc62Msax1ahGFhXhC+zpadn9Ga4Z
         oYq5wtiVDlU+nRIBsVWO5erhojOGhpohRnktqCHj7uNlTrJY2HCDPd6PUVXgB1V0UVlC
         Fj1lNlsgS/J/K04tIfQ7y7IQCaG0lW0dxDxmdghceb2lr9QgLpUe4Cti/e+Yk/JXEvKX
         hAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107728; x=1792712528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b5eAl+uSul+z/ledz5bhFoJ6lwq5K33tN/upCHBIBpo=;
        b=oQFQDbjn+O7Mt3pZlwApCd0BoJLQN/paRo0P/2CcS/kzYuKqmF/y9+nHjAr2bpwOgO
         BD5/Z/9tQq35n/NFxeuP7bhtSZlNbCXqmTqhZoFnYfujRtu/islAXYuAMa0w/2HdZFfT
         celWq2lENbNVOjj0Di9kl2J2zN+uTAzjSyU9nGAfd1D5x+6JwQvyq9o6eVVPXO9wqNww
         EvtSjqxkstKWpeVV8lOLlu8a1VntXYOslB/kZ+0H1cxldjL0J625F+ymm52WieBrkwlC
         p3K0JOVDkXM6lT42Ng28A9a3xp3vJ8Z4cigWJfp5/DifiWml2uOWR2Yn3SLfWFnrOr9Y
         TwnA==
X-Gm-Message-State: AFq9FYJWh8S508MOJf4qALrdRKSV6f3T7O81uFIGdryNpH2tHGOmdMhU
	ILkRbg26KBpXJNaSjHv8Fe9ywJi/BZXYm83WNPHrMZiIiz7zISOK8fMnYynLFfCHCEY=
X-Gm-Gg: AYBFou3seQlSJHRbn93o6/J33lDscMKglLIY85nsja0jMbQoiYtgY5ec8zleDJyvrae
	/Yz/sLblB2OHO/Xyr8FoY24tGJyUVzG9Yg2Wtxqg8+VWOpxq1gF4+SvT0AYApQ4bEaOAnBOOkrV
	vR/smq3ghzDT7atsabCvH7U4asnDTUaH2nzH2G+FJyuriVIvwqSVndxMBot3ziybgIVHEeYHGLO
	OH6uIX8dQn+hy+PoyqrRQ8hzBh4AijajoSGu+3tkjgQtLgWL+6n/lSHlAteipzc6KcW0hJ8+J3t
	Z/NLuuvyR3CzTEArX/8vW5BRiN5o3UVQ+PyJZt8UaXnLZa36YlFEBRnoScdfZlJ37E+v/F37jq6
	QA1TXecXkBtcBbPOZf6r19IilnBwvj2K+ksotszuMMK+RAoRQWzcxRfsRI7xw6YaKXLbPIkFbpz
	pzxADk34cZO5aXfaiID1fDAqOXSva1ZmarnCBvt9rmYf0V4gOS5Wk92nc5mMdk60ZrSeV3sviNw
	RdJPAqwlFzSDBH3qHOHk/ykpGHajdEE3sMCIseJqHFM682W0MGIdjrOWTid1uE3FiIPuhvl5oYD
	252fhA==
X-Received: by 2002:a05:6820:1ca9:b0:6f6:96f1:1bb with SMTP id 006d021491bc7-6f696f1066cmr9636447eaf.36.1792107728542;
        Thu, 15 Oct 2026 16:42:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a635d30esm404731a34.19.2026.10.15.16.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:42:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 12/15] bpf: Set up the arena base only in functions that use it
Date: Fri, 16 Oct 2026 01:41:18 +0200
Message-ID: <20261015234125.3152346-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13430; h=from:subject; bh=H35SOpNTwgPPTzTzWtgDmdkVoG6eiFyd1GykslMm3j8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3BuLjZ3LFNk26+z52X+fSTYvXPzJw9Cbe2prwg8nCJxa ULWjo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABM5fZbhr+iMCnZeUzXrS6fOHub7fc QvPqSXPZh34e45IkvrPAzftzEyXJ2nPWE1H++2m1vtA2390h9G/bnw19gzhrHYnK1gF68fBwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A JIT sets up the arena base in the prologue of every function of a
program that has an arena, a callee-saved register loaded with a 64-bit
immediate and spilled around the function on x86. That is paid for by
every program with an arena, whether it touches the arena or not, and
now that libbpf binds the arena of an object to every program in it, by
every program of an object that happens to contain an arena.

Have the verifier record whether a function has an insn that works with
the base: an access through an arena pointer or through a number in a
program loaded with BPF_F_ARENA_SCALAR, an addr_space_cast, or a kfunc
call with an __arena argument, which the JIT rebases. A load of an
__arena struct member is rewritten with an immediate and needs none;
dereferencing the result does.

uses_arena_insns is set per function in bpf_subprog_info and copied to
the JIT image of each subprogram, and per program in bpf_prog_aux for
the single function case. It implies that the program has an arena, as
every site that sets it checked for one. The JITs with arena support
pick up the arena base and user address only when
bpf_prog_uses_arena_insns() says so, and so generate the prologue and
epilogue of a program bound to an arena it never touches as if it had
none.

The other users of the arena address of a program stay as they are on
purpose. The struct_ops trampoline converts __arena arguments on entry
and arena_member_fixup() converts loaded __arena members after the load,
both with the base as an immediate. Both have to happen whether or not
the program dereferences the result, it may compare, store or pass it
on, so neither depends on the base register nor on the flag. The arena
fault report reads the user address of the arena the faulting insn
belongs to, and such an insn sets the flag anyway.
check_map_prog_compatibility() checks the user address when the arena
is bound, before any use is known. The rest, in arena.c and sched_ext,
works with the map and not with a program.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c   |  6 ++++--
 arch/loongarch/net/bpf_jit.c    |  6 ++++--
 arch/powerpc/net/bpf_jit_comp.c |  6 ++++--
 arch/riscv/net/bpf_jit_core.c   |  6 ++++--
 arch/s390/net/bpf_jit_comp.c    |  7 ++++---
 arch/x86/net/bpf_jit_comp.c     | 14 ++++++++------
 include/linux/bpf.h             |  2 ++
 include/linux/bpf_verifier.h    |  2 ++
 include/linux/filter.h          | 11 +++++++++++
 kernel/bpf/fixups.c             |  1 +
 kernel/bpf/verifier.c           | 18 ++++++++++++++++++
 11 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 506c4201fec8..1d5f4cf88d33 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2284,8 +2284,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	if (ctx.offset == NULL)
 		goto out_off;
 
-	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
-	ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
+	if (bpf_prog_uses_arena_insns(prog)) {
+		ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
+		ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
+	}
 
 	out_cnt = bpf_out_stack_arg_cnt(env, prog);
 	if (out_cnt) {
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index e78eb582c300..9393e4b0db8e 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2245,8 +2245,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 
 	memset(&ctx, 0, sizeof(ctx));
 	ctx.prog = prog;
-	ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
-	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
+	if (bpf_prog_uses_arena_insns(prog)) {
+		ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
+		ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
+	}
 
 	ctx.offset = kvcalloc(prog->len + 1, sizeof(u32), GFP_KERNEL);
 	if (ctx.offset == NULL)
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7a612688e7a2..0d6ea6df0106 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -241,8 +241,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 
 	/* Make sure that the stack is quadword aligned. */
 	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
-	cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
-	cgctx.user_vm_start = bpf_arena_get_user_vm_start(fp->aux->arena);
+	if (bpf_prog_uses_arena_insns(fp)) {
+		cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
+		cgctx.user_vm_start = bpf_arena_get_user_vm_start(fp->aux->arena);
+	}
 	cgctx.is_subprog = bpf_is_subprog(fp);
 	cgctx.exception_boundary = fp->aux->exception_boundary;
 	cgctx.exception_cb = fp->aux->exception_cb;
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 5265dd5bd39e..f2497ec7d378 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -73,8 +73,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		goto skip_init_ctx;
 	}
 
-	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
-	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
+	if (bpf_prog_uses_arena_insns(prog)) {
+		ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
+		ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
+	}
 
 	stack_arg_cnt = bpf_out_stack_arg_cnt(env, prog);
 	/* First 3 stack args in regs, rest on stack */
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 1b2566012b63..0fe629f0b66f 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2293,10 +2293,11 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	else
 		jit->frame_off = 0;
 
-	kern_arena = bpf_arena_get_kern_vm_start(fp->aux->arena);
-	if (kern_arena)
+	if (bpf_prog_uses_arena_insns(fp)) {
+		kern_arena = bpf_arena_get_kern_vm_start(fp->aux->arena);
 		jit->kern_arena = _EMIT_CONST_U64(kern_arena);
-	jit->user_arena = bpf_arena_get_user_vm_start(fp->aux->arena);
+		jit->user_arena = bpf_arena_get_user_vm_start(fp->aux->arena);
+	}
 
 	bpf_jit_prologue(jit, fp);
 	if (bpf_set_addr(jit, 0) < 0)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 3975a94ac812..ff6abbbffc2f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -881,7 +881,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 		pop_r12(&prog);
 	} else {
 		pop_callee_regs(&prog, callee_regs_used);
-		if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
+		if (bpf_prog_uses_arena_insns(bpf_prog))
 			pop_r12(&prog);
 	}
 
@@ -947,7 +947,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 		pop_r12(&prog);
 	} else {
 		pop_callee_regs(&prog, callee_regs_used);
-		if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
+		if (bpf_prog_uses_arena_insns(bpf_prog))
 			pop_r12(&prog);
 	}
 
@@ -2296,7 +2296,7 @@ static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
 
 		if (!(flags & BTF_FMODEL_ARENA_ARG))
 			continue;
-		if (WARN_ON_ONCE(!bpf_prog->aux->arena))
+		if (WARN_ON_ONCE(!bpf_prog_uses_arena_insns(bpf_prog)))
 			return -EINVAL;
 
 		/* mov eN, eN: truncate and clear the upper 32 bits */
@@ -2375,7 +2375,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
 	void __percpu *priv_frame_ptr = NULL;
 	u16 out_stack_arg_cnt, outgoing_rsp;
-	u64 arena_vm_start, user_vm_start;
+	u64 arena_vm_start = 0, user_vm_start = 0;
 	void __percpu *priv_stack_ptr;
 	int i, excnt = 0;
 	int ilen, proglen = 0;
@@ -2415,8 +2415,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	 *   [below]             callee-saved regs
 	 *   [below]             outgoing args 7+ (= rsp)
 	 */
-	arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
-	user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
+	if (bpf_prog_uses_arena_insns(bpf_prog)) {
+		arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
+		user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
+	}
 
 	detect_reg_usage(insn, insn_cnt, callee_regs_used);
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54144372281c..b0a5b2d5b756 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1883,6 +1883,8 @@ struct bpf_prog_aux {
 	bool changes_pkt_data;
 	bool might_sleep;
 	bool kprobe_write_ctx;
+	/* has insns that work with the arena base, see bpf_prog_uses_arena_insns() */
+	bool uses_arena_insns;
 	struct {
 		s32 keyring_serial;
 		u8 keyring_type;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index af59166a3b27..6ce141e014c0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -963,6 +963,8 @@ struct bpf_subprog_info {
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
 	bool might_sleep: 1;
+	/* true if an insn works with the arena base, see mark_uses_arena_insn() */
+	bool uses_arena_insns: 1;
 	u8 arg_slot_cnt:4;
 
 	enum priv_stack_mode priv_stack_mode;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9339c6131f8f..f5518bae4855 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1110,6 +1110,17 @@ static inline unsigned int bpf_prog_size(unsigned int proglen)
 		   offsetof(struct bpf_prog, insns[proglen]));
 }
 
+/*
+ * Whether a JIT has to set up the arena base for @prog. A program bound to
+ * an arena need not touch it, libbpf binds the arena of an object to every
+ * program in it. The verifier sets the flag for every function with an insn
+ * that works with the base, and only in a program that has an arena.
+ */
+static inline bool bpf_prog_uses_arena_insns(const struct bpf_prog *prog)
+{
+	return prog->aux->uses_arena_insns;
+}
+
 static inline bool bpf_prog_was_classic(const struct bpf_prog *prog)
 {
 	/* When classic BPF programs have been loaded and the arch
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index dcc4111343ca..dc0a77fd2f36 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1409,6 +1409,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
 		func[i]->aux->arena = prog->aux->arena;
+		func[i]->aux->uses_arena_insns = env->subprog_info[i].uses_arena_insns;
 		func[i]->aux->used_maps = env->used_maps;
 		func[i]->aux->used_map_cnt = env->used_map_cnt;
 		num_exentries = 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7199674f6a46..38d0e9720604 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5438,6 +5438,18 @@ static bool is_arena_scalar(struct bpf_verifier_env *env, int regno)
 	return reg->type == SCALAR_VALUE && env->arena_scalar && env->prog->aux->arena;
 }
 
+/*
+ * The insn being verified works with the arena base, which a JIT sets up in
+ * the prologue of the function the insn belongs to, see
+ * bpf_prog_uses_arena_insns(). Every caller checked that the program has an
+ * arena, so uses_arena_insns implies one.
+ */
+static void mark_uses_arena_insn(struct bpf_verifier_env *env)
+{
+	bpf_find_containing_subprog(env, env->insn_idx)->uses_arena_insns = true;
+	env->prog->aux->uses_arena_insns = true;
+}
+
 static bool is_load_acq_unsafe(struct bpf_verifier_env *env, int regno,
 			       struct bpf_insn *insn)
 {
@@ -7371,6 +7383,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_ARENA) {
+		mark_uses_arena_insn(env);
 		if (t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else {
@@ -7430,6 +7443,7 @@ static struct bpf_reg_state *mem_access_reg(struct bpf_verifier_env *env, int re
 	memset(arena, 0, sizeof(*arena));
 	arena->type = PTR_TO_ARENA;
 	env->insn_aux_data[env->insn_idx].arena_scalar = true;
+	mark_uses_arena_insn(env);
 	return arena;
 }
 
@@ -9919,6 +9933,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		}
 		break;
 	case ARG_PTR_TO_ARENA:
+		/* the JIT rebases the __arena argument of a kfunc on the arena base */
+		if (is_kfunc(meta))
+			mark_uses_arena_insn(env);
 		break;
 	case ARG_PTR_TO_ALLOC_BTF_ID:
 		if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
@@ -17534,6 +17551,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					verbose(env, "addr_space_cast insn can only be used in a program that has an associated arena\n");
 					return -EINVAL;
 				}
+				mark_uses_arena_insn(env);
 			}
 
 			/* check src operand */
-- 
2.53.0-Meta

