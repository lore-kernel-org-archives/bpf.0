Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087BF4F796D
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416170; cv=none; b=oPKgJFPTzR1gAllck3SrlM5dE38jEPoSaM8A2KLXma65LFfGlEfUx6qmf6/CjJzvD6c9MlUdwfXAzE/vKnUQWWrXg3FJdpXuh2cmSV2VVkXtR2YEil3oBc/gAZ5QhKIAGcUM6qAZZpDTsvALV3NfJUr7bzkbmTF9wmhkusAfXyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416170; c=relaxed/simple;
	bh=BrE0txOZF+EONFVg2rNopE6GDYVKLWJlW4+1Q2F1ZzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCUPDjO7OmE8tbZZS83o15/piNoHHZWkpDegFwLc0a6ttop9G2+zVhT+sw0sI9aa3EPaeP5zzV+g7CK73smN+QOnOKP8ufyprnQjlOaKdF4gb9ylvPBzAWDUFfQDo8WhBEQIFcxjccp/sIT38RaH2dLeSpDYyZ16CmOgXUtZa84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxx0UoFe; arc=none smtp.client-ip=74.125.231.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxx0UoFe"
Received: by mail-oo2-f10.google.com with SMTP id 006d021491bc7-6dd3bb640bcso322376eaf.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416167; x=1793020967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkKXNROCX3oGeoomturnRZLSvsih8c0fKp9sWR+zclc=;
        b=Fxx0UoFeH0SCkdEN+K8XBjpS56c8BROEmxKBFuTyUpG8rCYR+9+IbILkGwTNVbUc04
         IS4Jwaesb4smkxF0fNBp5Xx/+DgEIIDhKloVwvVAx5HVHWXC6y3wkijkxFdZChDZ7Exi
         OmIh2Kw5QWmfq60cgX9vZiGhU/Mwe43IWch/s/ir6SKYWyBWfrz4vryAvMkq6kSyDUDJ
         gxUYd3nvU/VOvNHE0/10tCjQJbmQZutJa4gCs4zmTupEBcDpDfJ68bRkeOEwPB8yxMQ/
         n+n4bZcge0E1cUZWAhdhMUiUGAvKbpEB98GYfH7eK0XS1e5QOWKNf08EGILOupt5G083
         0baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416167; x=1793020967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkKXNROCX3oGeoomturnRZLSvsih8c0fKp9sWR+zclc=;
        b=QsTjSLpfyNc/NtIfZgquGOy71a6JfJ+gRJOdoYJ497NA2DhtrYu9aEZPnV54paMsj0
         57qI5DdHSwLrJ0C8TE2uGsxmQikZWhhwWXTf8ZJn/6dUlXEu5z/O0q9O1WDkVYREiEes
         2xOs/ER6/er8D5ORATFObQNvyP7LxhwbG4hkJykUsHrN+YCR1B89ykMZSFJ9ZA7uv/rw
         Z9CNlaHv4FR+nGyzqT3xkYCruf+z+2I6gDfyyiGrNsNrA1JcbfhmRoSUrfFn2b2c7+su
         XC158wyQ1vwXBaN5qs5pWBYIgYema4K27FHTX4LuWDbE3KF+6vFzilCCChhEhMKWReSo
         cs6w==
X-Gm-Message-State: AFq9FYKRrbqjvilvBC77I4sIy0FY7Sr5phFSNrmbuD2dMa8YKjcS3WAT
	WH1ma1BzIF5K2JwTKxBriPW75B0AokVr03y2Saw4w6Lhw4jhz9a9vw1rdKgtJeujMEI=
X-Gm-Gg: AYBFou1delJR7sdHdEVGoPKONjUkT93sorLL2eE3Qxdp209RB30Dwp2/WIQ1M5P+qPV
	oHCMCOq4NdwHc0PONO4FO33qSlsFQOi4inFg44dFYkTH/PJdAi5s8U2olRIJuyEErc43Ao/ajXM
	Qi5gwHCs51xG9jHRV8mFEHtdR+mkrJsj6cAlgqseqrDkgDYKCDV1nkcn5WGJ1IDj+D4tPw5fG9I
	hNO00jkMVmNUQmrFrfmsA0IgpGdgHoWS4e8WBfNfm6zHzR99lKAYV+zp5tutC/RMpNQ8+xqkAWl
	VWttCHa7KPi/H01F0fVo77injta6MQj5SfvZUAVu1VUQDPSHFFLYjcG77H5bgjkaxpwM74/bkQd
	ueWyFTXZ61gUyKKm6JLSt4vzEc29R1F2a10rYHXST3m0RWFr/CmhmNc0VR9u+/DGTpp1O6W8RjK
	3nlB3KPxb2hsX+tl0Ntp6PdFwolAWGrFM02tzZyX9zJnED1ngouaNRdNHGE6fwk+jtQUEzlLKLy
	2WqlpnlWhM+WVZgcUgUAbOKFyaljCp0wM8o6WuHCwfSgVtVs0fVNYa6j6wR8rZ13+Osl6GZaZIA
	0fkiPHdeL2qilRo=
X-Received: by 2002:a05:6820:3106:b0:6f4:fb85:5e42 with SMTP id 006d021491bc7-7035566d3b9mr4241114eaf.21.1792416166708;
        Mon, 19 Oct 2026 06:22:46 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8438ce16e37sm9477781a34.13.2026.10.19.06.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 13/16] bpf: Set up the arena base only in functions that use it
Date: Mon, 19 Oct 2026 15:21:55 +0200
Message-ID: <20261019132203.3034698-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13581; h=from:subject; bh=BrE0txOZF+EONFVg2rNopE6GDYVKLWJlW4+1Q2F1ZzI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxNFtP5jSau9f/il/0fCP37Qpnk+qflsuv9t2ZO6fbQ+f P4tw6yhlYRDjYpAVU2Qp+b+PyfhE5e9A22XcMHNYmUCGMHBxCsBErj1nZGjz5kzKjS75IJ3Pzz614c tPs9kdvZLfvc/P0nKawlV4qISR4XX8L/0fyoWHJmm83l6tpXtEc15uO2O3ppdqy9ccxh87OQE=
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
index dae33b1a7427..7750df973494 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1898,6 +1898,8 @@ struct bpf_prog_aux {
 	bool has_prologue;
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
index 34b53ebb5841..409b9104c723 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1448,6 +1448,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
 		func[i]->aux->arena = prog->aux->arena;
+		func[i]->aux->uses_arena_insns = bpf_prog_has_arena_insns(func[i]);
 		func[i]->aux->used_maps = env->used_maps;
 		func[i]->aux->used_map_cnt = env->used_map_cnt;
 		num_exentries = 0;
-- 
2.53.0-Meta

