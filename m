Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D369379C5E
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812267; cv=none; b=VMiViqgYzWlJ2Q/bis+ReYClSe3hMrvtAtMcAiFxiN2a+HBe0jAhirEYKxdxppzzNmAyuqZj3yRTzBPa4NvrBvUQ4b+P7bsdeAdYWU83vLdFtcKpKDOvzPKfQWi5oBzP0uuvCyxyQ3/EKk5jnA3uE5vsEf9O9wJKoQVVqojdUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812267; c=relaxed/simple;
	bh=Olut2q5NzBD/S+m1U9KceiQvXUWCaR+tG/zc4tJiamk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUkthH+Z+8orQqKSdT3i8xAMYnqyjAXjMo9Ikczeuprrf52jdZw3pKfXw7Nbr1oJPqQu2Lk7XaA5ZcyYyfu+Q42vbN5NibYr0NqekrGokMh8J1ZxftkzQfezwIgzxswrzq0mIinR5yCMbF3cHJN4XQPl7wCa7jXo0qeCB7fBHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyNn1Y03; arc=none smtp.client-ip=74.125.231.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyNn1Y03"
Received: by mail-oo2-f0.google.com with SMTP id 46e09a7af769-824040a3379so784418a34.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812265; x=1792417065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CGd9fjoGPxQJYGGyhsK0/myy3DUKzUyI6ZLWh4ztXpE=;
        b=nyNn1Y038LvPjZgLmOm+p6LcMKR7DkyMpcWIDpm9ZruDSxyIgWfKDwpFjOBdwzeCgh
         TrgNneT//nIRXXiOYoC+Y54GgFQzDAl/QGNWcKa2YZGQBrFxVYkPUrPTfsU9jq1r9Nnc
         Jzb2ojbXm5ULqmJTj5XZPTUpDbE1aqNwF/xkmP/D1OoaA5sdmsc82e8Zin/Ol1cT/TwU
         XZZkWNto6hXrheKLYcWbCOH0AaBub1c08sOL7IXPaNvyIL8CtHzyNHWfq7ioYpqtCq0W
         QXtVTYji8lVyTd7zi8jWTbE1PLcr6bR23+c678EdGXmsES1Z+eLOCH3m/2fF+hdl+WKm
         7i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812265; x=1792417065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CGd9fjoGPxQJYGGyhsK0/myy3DUKzUyI6ZLWh4ztXpE=;
        b=zcSrZhifkej+Bib9lM4Bc15CQuWwJXgFG72WAbANOqzBcNNlNnbsnKaXpZnVo4aNpO
         XjdhWPmVbb90icFUn6RKPxr1YLuAVOHhnGllt+r3f7u3Dt4PeiDqtauxCjE4njpMx24u
         9P3Ffzv8OReZkRnRT4aoLkRRSHFb/pvvrUFh6uki/f0YQpP1jfxhI4LfkLJPGD5h1A4P
         6An1LEC2XR9IcQTi+y2DHk7uRFc2DEUsaxYsc2QRJ7y0idbeGsnUcWLSLzuSXibgNAhq
         /qIpBzkvRRjvDcSqIzAXEc5Axscb7S8jrmqz2GnB6lkUQESjQnYJoOcfx9TscF3SRuSZ
         HyAQ==
X-Gm-Message-State: AFq9FYJzuCR715upHGEmwmQXBKzIDcb7uOj9IPFFivhzMUTFUD3Tihx9
	js2MWNy2b1x/4e7PoiQ68swTA85dry34CfEqEHQG9cm85Jf15/Jhzhrnwk45R4yXHlY=
X-Gm-Gg: AYBFou3rxnt3e+v8CBJB96BqggZoZBXHhasuhnBtsPa83OWdHvZVIK6K6DEoHRCbEMx
	zCyhtCzYiq2raxLkd7mDboeweB3rQD4x1sojdNhUyD3SM62B2UaK+UYF5xFUbobBG9+lEncrrXH
	fr5tVPVn4U9JS7hamQkKyUGXiAgRZqMsE9N7X8whEto5rcxW2rFqT5sBoriObhy62nrpsUDSuac
	EoVvav1uRzqKUd7ZIiyJkSjFko1RriOoXlwJ/PA5hW1acfXT6o81stllHAPkW3G5D81W/vhXYhf
	BNzcjPVVSUKDLVmHtRPr6IVyAPzRyT5cVrKDyop9Q80MRlFtRW8oCAKIXJo1Hnp85+TxcDSgSw6
	b8cfb1XUMgt34vOFHdRDXjYj0FboCdCqsunHz+Lk8f88H20JhOzMUwgUrI9VyY32OjTWFlUyd2i
	+A2eq4M9Vo587ttT/ghdzMXbR11B4MDcZfGrpcso1WnUTOlyIMl1CxB6aQheAdFQXZVWv6Z0z3b
	484o+e81b5a89OmTa27SnjgZLyw22x6eOoGC3DOG0pSOmXyG2DP5PmGP/euccuq4YEFn9Qwfb3G
	tPgBnA==
X-Received: by 2002:a05:6830:264a:b0:826:b94f:8144 with SMTP id 46e09a7af769-830999cd51cmr8744148a34.31.1791812264865;
        Mon, 12 Oct 2026 06:37:44 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:14::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303494f79bsm10550887a34.1.2026.10.12.06.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:37:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 08/10] bpf: Set up the arena base only in functions that use it
Date: Mon, 12 Oct 2026 15:37:05 +0200
Message-ID: <20261012133711.4030594-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012133711.4030594-1-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13445; h=from:subject; bh=Olut2q5NzBD/S+m1U9KceiQvXUWCaR+tG/zc4tJiamk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevMw7XbU+8uuFbuk857vnZt0VetuRc0/P+ve6a16tP5PNnJ R/+kdJSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAikRGMDFP/bPzgtGFVhrK2oJb0vD d6F7bNrHab92/hirebfc94rNzP8L/4vez68OtbWbt4vH+vyvxu9y5hoVX95fk7Vwm9aKsOaOQBAA==
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
 kernel/bpf/verifier.c           | 17 +++++++++++++++++
 11 files changed, 61 insertions(+), 17 deletions(-)

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
index 083fcd6cf15b..3130d9ecbb99 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -878,7 +878,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 		pop_r12(&prog);
 	} else {
 		pop_callee_regs(&prog, callee_regs_used);
-		if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
+		if (bpf_prog_uses_arena_insns(bpf_prog))
 			pop_r12(&prog);
 	}
 
@@ -945,7 +945,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 		pop_r12(&prog);
 	} else {
 		pop_callee_regs(&prog, callee_regs_used);
-		if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
+		if (bpf_prog_uses_arena_insns(bpf_prog))
 			pop_r12(&prog);
 	}
 
@@ -1980,7 +1980,7 @@ static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
 
 		if (!(flags & BTF_FMODEL_ARENA_ARG))
 			continue;
-		if (WARN_ON_ONCE(!bpf_prog->aux->arena))
+		if (WARN_ON_ONCE(!bpf_prog_uses_arena_insns(bpf_prog)))
 			return -EINVAL;
 
 		/* mov eN, eN: truncate and clear the upper 32 bits */
@@ -2011,7 +2011,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
 	void __percpu *priv_frame_ptr = NULL;
 	u16 out_stack_arg_cnt, outgoing_rsp;
-	u64 arena_vm_start, user_vm_start;
+	u64 arena_vm_start = 0, user_vm_start = 0;
 	void __percpu *priv_stack_ptr;
 	int i, excnt = 0;
 	int ilen, proglen = 0;
@@ -2051,8 +2051,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
index fb949b58c231..bb1541fd6799 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -966,6 +966,8 @@ struct bpf_subprog_info {
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
index bbb653df6b6f..75aefa5813e2 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1408,6 +1408,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
 		func[i]->aux->arena = prog->aux->arena;
+		func[i]->aux->uses_arena_insns = env->subprog_info[i].uses_arena_insns;
 		func[i]->aux->used_maps = env->used_maps;
 		func[i]->aux->used_map_cnt = env->used_map_cnt;
 		num_exentries = 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a24a2bab802b..9e4aedab71ed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5436,6 +5436,18 @@ static bool is_arena_scalar(struct bpf_verifier_env *env, int regno)
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
@@ -7380,6 +7392,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_ARENA) {
+		mark_uses_arena_insn(env);
 		if (t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else {
@@ -7439,6 +7452,7 @@ static struct bpf_reg_state *mem_access_reg(struct bpf_verifier_env *env, int re
 	memset(arena, 0, sizeof(*arena));
 	arena->type = PTR_TO_ARENA;
 	env->insn_aux_data[env->insn_idx].arena_scalar = true;
+	mark_uses_arena_insn(env);
 	return arena;
 }
 
@@ -13848,6 +13862,8 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 				reg_arg_name(env, argno));
 			return -EINVAL;
 		}
+		/* the JIT rebases the argument on the arena base */
+		mark_uses_arena_insn(env);
 		if (reg_from_argno(argno) < 0) {
 			verbose(env, "%s arena pointer cannot be a stack argument\n",
 				reg_arg_name(env, argno));
@@ -17528,6 +17544,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					verbose(env, "addr_space_cast insn can only be used in a program that has an associated arena\n");
 					return -EINVAL;
 				}
+				mark_uses_arena_insn(env);
 			}
 
 			/* check src operand */
-- 
2.53.0-Meta

