Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956B449B35
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380298; cv=none; b=GYhRV7WozADguItMKgC1KwWgUHdQm7lPpYFOrj1jdX8srSHrt/xlV7m1w10WCFKEANGPUFGqZDK6oAVLfvlMOcMhWv37g3z1yFrMaRZsPHJN14nML+8lew+RvHKfYNCw6pk0Xl83qUf1mG0X86pHBqpjP3wQArwCvzKwG5duwI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380298; c=relaxed/simple;
	bh=fzaOdnIU5gySqiLaz5MVBY5OLv7lqXLlBw6TSmU0KKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnyhRdzJqANm/3ahvxXvPWnSc/bdJMcHlkQ98/VotEUS/6SaQd3fEmgFdW0WWItcK7ZJkiaRW5VRnPiKGunWwMb70P/vyuQ3H/Gfs5B6uLOjBYra5MO8Mtzsp9w2IWyiawJ4qRTqkntuOpejA8ZgOxUO/XRUGjt/6f49Q5bwMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnhNp3aV; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnhNp3aV"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-4a76f63b243so1045443fac.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380295; x=1792985095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PDInxVn1YzIZ+n8ZX6j/2yYJ0lIraQnqX1r6taH2B8E=;
        b=pnhNp3aV8AjUoMHeNaNR7dEoHl/BbxO82eLK37YyfPHslYQL5pWtoq+f1W8eT8yASy
         LvpBQNWofyk9lO63OaXpsyb9qU08+eqBRBbjeaKDEPH7/ng9LLYjDCok5EnJbHcTmzQ4
         z0aL7VVkQhi8ENaF7J6uonZijBujO8CYogrXlKy9pLtOpTqbYU44j30qDd96fXGYXmD9
         dA3A8lART79Rzx4fLeIkPW/j6lDnyNZE1j+eAWwYU1FQeQpwCktAsKhUXPyIQYy255Ps
         xhjaQOpuQjyByaU9GvNXPhjQU22QH3sueViq2LvAkl66/inGJ3sBO1il2wckrZ4cixBi
         nD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380295; x=1792985095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PDInxVn1YzIZ+n8ZX6j/2yYJ0lIraQnqX1r6taH2B8E=;
        b=WX5PvX86TuQkdAg89GKEpyFxEs01dvEaQGP872M8v4vR4+5WpqLDwvspLiTBAQZXD6
         8aVjbW3gD/koPrbqVbcsVGN0wubICcEH5TiZc7I/rYyI6JRWatPZsEemFOtgVBxU6lD2
         SAR0so3tAQ1wRBkWPfyYwyPjBYA/M4E7xZ7RLL/DnXh0T0UQHqS2eHP/kclj2CtUQcY3
         NcAz2z9wjxDUDAjZ60aToT/bhXw2XkH0sYLuHSohzURfkGQnPYpaMUPiMhyWZR64+6x9
         qxZhUgd/8I3SpgkS9P6U+mCm03Kzv5TqBQFmFjykjNzr6/yAs1QMM4CWRg/0zncNf0SW
         4XeA==
X-Gm-Message-State: AFq9FYL0yxBeBSeRuLklvtdplr1Z+SDQ3gqchlw3aSZEBbDPQIQHePS2
	gnc2CpYonszDcPksRGKjNjqWYSkKikK74nUNOHV81TN6IzAfnx22UrUfra63bNJg7ds=
X-Gm-Gg: AYBFou0Z5IsXzCQVm1d2pevHzugPLwe5MKPfhxbA7xa6cpKZHZl29lWw9GyXFiI9Uhd
	bNTBFJFl1jFuDH/CWhKpSoCFLOmR4lSAmMgBFj/xntSOU0OJ7p5qX3FyOLBRC3XlCRDPdFs2Xde
	RdhII+pXc28AJ7k6t1XhT2k5vygyrxUvqFZYd8KHnLxe+uCclxslczq4NCwwyrrILoweiYLRf8z
	h4Cnz2d43V00iMYd62ou2Ibha43/LgtGMmsMt1okjBvHHYajX92WNvh/XpkfpYraRGCI5p9pzkZ
	KBzT2La0ncSbuaPv63o/VAq3hMkKG08WH/AnOWeuQbY7GZT7wkFfgnhyPztRfzv+x4sZDkGCICx
	zqwqWx9HsbYoB2iyBP3UWbmEHRHEdEu5f9OkiL+sqWwyOevTIqTxI+EI0lMATC3PvWeKz16RHHl
	NN9KXsKPKa8hv7TPoTVJTPhDr7xom2wd0JxQoiatwYPJT0G/WiC5HUB/RqPJB6Lhj34xt6tivcV
	ZrwSC/jD0YBPvkZGD3dq0QPVMnUF2tqn7ZAc5ZaYOcEBRIIOklDbKZWbb1g3KO4TLxotuTY7A3j
	Dec2Hw==
X-Received: by 2002:a05:6870:171b:b0:4a7:232c:2b67 with SMTP id 586e51a60fabf-4a730a76795mr6723497fac.22.1792380295405;
        Sun, 18 Oct 2026 20:24:55 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b2dc362sm7904690fac.2.2026.10.18.20.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:24:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 13/16] bpf: Set up the arena base only in functions that use it
Date: Mon, 19 Oct 2026 05:23:53 +0200
Message-ID: <20261019032401.2302823-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13585; h=from:subject; bh=fzaOdnIU5gySqiLaz5MVBY5OLv7lqXLlBw6TSmU0KKg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqr55K2UXz7es3qbnPvdfz825Pu8V3Na1vBZNe7eTM+ryQ aeWjjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkpD0jw6PXKi73WFdc+RUZqrB+d8 THWc4LDj640HyqfKLj/V0bz/YxMlxIu3/C1iRB8+XdXake9bsL1Ey1YjjXP9ixS7KKK1tYjhUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A JIT sets up the arena base in the prologue of every function of a
program that has an arena, a callee-saved register loaded with a 64-bit
immediate and spilled around the function on x86. That is paid for by
every program with an arena, whether it touches the arena or not, and
now that libbpf binds the arena of an object to every program in it, by
every program of an object that happens to contain an arena.

Decide per function, on its final insns, right before it is JITed.
bpf_prog_has_arena_insns() looks for an insn that works with the base:
an access through an arena pointer, or through a number in a program
loaded with BPF_F_ARENA_SCALAR, has been rewritten to a BPF_PROBE_MEM32
form by then, a cast to the user address space keeps
BPF_ADDR_SPACE_CAST, and a kfunc call with an __arena argument, which
the JIT rebases, has a function model that says so. A load of an
__arena struct member is rewritten with an immediate and needs none;
dereferencing the result does.

Looking at the final insns rather than recording the uses during
verification keeps the answer in step with what the JIT sees. A
constant NULL passed to a nullable __arena kfunc argument takes the
early exit for NULL arguments in the verifier, and the JIT rebases the
call all the same; an insn that is dead code has disappeared by then.

bpf_prog_jit_compile() caches the answer in bpf_prog_aux for a single
function program, jit_subprogs() for each subprogram once it has its
kfunc table and arena. It implies that the program has an arena, as the
scan says no without one. The JITs with arena support pick up the arena
base and user address only when bpf_prog_uses_arena_insns() says so,
and so generate the prologue and epilogue of a program bound to an
arena it never touches as if it had none.

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
 arch/arm64/net/bpf_jit_comp.c   |  6 ++--
 arch/loongarch/net/bpf_jit.c    |  6 ++--
 arch/powerpc/net/bpf_jit_comp.c |  6 ++--
 arch/riscv/net/bpf_jit_core.c   |  6 ++--
 arch/s390/net/bpf_jit_comp.c    |  7 ++--
 arch/x86/net/bpf_jit_comp.c     | 14 ++++----
 include/linux/bpf.h             |  2 ++
 include/linux/filter.h          | 13 ++++++++
 kernel/bpf/core.c               | 57 +++++++++++++++++++++++++++++++++
 kernel/bpf/fixups.c             |  1 +
 10 files changed, 101 insertions(+), 17 deletions(-)

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
index 14c905697352..8eaaac7028a1 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2304,10 +2304,11 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
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
index d3843045dc71..72a2a0a89e03 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -888,7 +888,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 		pop_r12(&prog);
 	} else {
 		pop_callee_regs(&prog, callee_regs_used);
-		if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
+		if (bpf_prog_uses_arena_insns(bpf_prog))
 			pop_r12(&prog);
 	}
 
@@ -954,7 +954,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 		pop_r12(&prog);
 	} else {
 		pop_callee_regs(&prog, callee_regs_used);
-		if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
+		if (bpf_prog_uses_arena_insns(bpf_prog))
 			pop_r12(&prog);
 	}
 
@@ -2443,7 +2443,7 @@ static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
 
 		if (!(flags & BTF_FMODEL_ARENA_ARG))
 			continue;
-		if (WARN_ON_ONCE(!bpf_prog->aux->arena))
+		if (WARN_ON_ONCE(!bpf_prog_uses_arena_insns(bpf_prog)))
 			return -EINVAL;
 
 		/* mov eN, eN: truncate and clear the upper 32 bits */
@@ -2522,7 +2522,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
 	void __percpu *priv_frame_ptr = NULL;
 	u16 out_stack_arg_cnt, outgoing_rsp;
-	u64 arena_vm_start, user_vm_start;
+	u64 arena_vm_start = 0, user_vm_start = 0;
 	void __percpu *priv_stack_ptr;
 	int i, excnt = 0;
 	int ilen, proglen = 0;
@@ -2562,8 +2562,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
index aeb8b9b97052..7fbcfb4fd47c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1896,6 +1896,8 @@ struct bpf_prog_aux {
 	bool changes_pkt_data;
 	bool might_sleep;
 	bool kprobe_write_ctx;
+	/* has insns that work with the arena base, see bpf_prog_has_arena_insns() */
+	bool uses_arena_insns;
 	struct {
 		s32 keyring_serial;
 		u8 keyring_type;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9339c6131f8f..6f4c9bd024a0 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1110,6 +1110,19 @@ static inline unsigned int bpf_prog_size(unsigned int proglen)
 		   offsetof(struct bpf_prog, insns[proglen]));
 }
 
+bool bpf_prog_has_arena_insns(const struct bpf_prog *prog);
+
+/*
+ * Whether a JIT has to set up the arena base for @prog. A program bound to
+ * an arena need not touch it, libbpf binds the arena of an object to every
+ * program in it. The flag caches bpf_prog_has_arena_insns() for the function
+ * about to be JITed, see bpf_prog_jit_compile() and jit_subprogs().
+ */
+static inline bool bpf_prog_uses_arena_insns(const struct bpf_prog *prog)
+{
+	return prog->aux->uses_arena_insns;
+}
+
 static inline bool bpf_prog_was_classic(const struct bpf_prog *prog)
 {
 	/* When classic BPF programs have been loaded and the arch
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6e32db9777c2..fc22d66d194a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2637,11 +2637,68 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 	return select_interpreter;
 }
 
+/*
+ * Whether a function has an insn that works with the arena base, which a JIT
+ * sets up in the prologue when bpf_prog_uses_arena_insns() says so. Decided on
+ * the final insns of the function: an access through an arena pointer, or
+ * through a number in a program loaded with BPF_F_ARENA_SCALAR, has been
+ * rewritten to a BPF_PROBE_MEM32 form by then, a cast to the user address
+ * space keeps BPF_ADDR_SPACE_CAST, and a kfunc call with an __arena argument,
+ * which the JIT rebases, has a function model that says so. A load of an
+ * __arena struct member is rewritten with an immediate and needs none;
+ * dereferencing the result does.
+ */
+bool bpf_prog_has_arena_insns(const struct bpf_prog *prog)
+{
+	const struct bpf_insn *insn = prog->insnsi;
+	const struct btf_func_model *m;
+	int i, j;
+
+	if (!prog->aux->arena)
+		return false;
+
+	for (i = 0; i < prog->len; i++, insn++) {
+		switch (BPF_CLASS(insn->code)) {
+		case BPF_LDX:
+			if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
+			    BPF_MODE(insn->code) == BPF_PROBE_MEM32SX)
+				return true;
+			break;
+		case BPF_ST:
+			if (BPF_MODE(insn->code) == BPF_PROBE_MEM32)
+				return true;
+			break;
+		case BPF_STX:
+			if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
+			    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC)
+				return true;
+			break;
+		case BPF_ALU64:
+			if (BPF_OP(insn->code) == BPF_MOV && BPF_SRC(insn->code) == BPF_X &&
+			    insn->off == BPF_ADDR_SPACE_CAST)
+				return true;
+			break;
+		case BPF_JMP:
+			if (!bpf_pseudo_kfunc_call(insn))
+				break;
+			m = bpf_jit_find_kfunc_model(prog, insn);
+			if (!m)
+				break;
+			for (j = 0; j < m->nr_args; j++)
+				if (m->arg_flags[j] & BTF_FMODEL_ARENA_ARG)
+					return true;
+			break;
+		}
+	}
+	return false;
+}
+
 static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 #ifdef CONFIG_BPF_JIT
 	struct bpf_prog *orig_prog;
 
+	prog->aux->uses_arena_insns = bpf_prog_has_arena_insns(prog);
 	if (!bpf_prog_need_blind(prog))
 		return bpf_int_jit_compile(env, prog);
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index c7f266760ca3..e7514742bccd 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1442,6 +1442,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
 		func[i]->aux->arena = prog->aux->arena;
+		func[i]->aux->uses_arena_insns = bpf_prog_has_arena_insns(func[i]);
 		func[i]->aux->used_maps = env->used_maps;
 		func[i]->aux->used_map_cnt = env->used_map_cnt;
 		num_exentries = 0;
-- 
2.53.0-Meta

