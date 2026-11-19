Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051777;
	b=mo32gv1twsOtZiskaIos5EkgKI0htxFVw+sNL08tq3d1C4DAiar50pGRvzP2OgDdotga
	 L4mfxO4IFKmYn5uzTBlWJl04EXc6wkz753eRUKbTd95LObA2osIEZwddCyb507Kc2PojX
	 TndR5MOT3hvYiJpjLyMJ5mxsHub1pS2AVJ5hv+sNwpE8hCvSxrLO047YMSWM7YhozpycH
	 BCANQZ6324V4IdTgiQv6qusVeWq4qx7SzPwi4dfg+x8j4fmsjn7zSY9CwriqNoykkrii7
	 u+odInRAQuDQs/875f+zifjpJCpnv26C9J2tLKLJHmHcvyerfm5eO0EA+pNjlvf/z8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mPkIcszleH4UqVzMuyGFNOe9d+Bx16Jai6iLZ61iQ2Q=;
	b=vec/sSUvP0jD7klAenjN44Z1Q5jxP6oE9fuSHrmxARsEOmNm6G5Fw90TCrZKepTwm+HP
	 quFqXQK31Ao2tJbIfQAk+E6ly7bV6enRHxCpFjj3ReSfBS/CUfneBvDXJQfvzTots6oDH
	 KCoipeFwqdMWiDdX1W17TEL3T1VcZr7c0r06eCjlrLUT7hv+ImQm5IfwVBS0MUl0iJdNl
	 LbE2Rmv6Irsp5g9saCDk/hT8IEb+PCPgxy9x87Ez4DpiEp1FgOGQDKu1tjPylUOW2qtP7
	 ufBeNhtX5PyCj52TlqBXmGJvWK8UfhU+ZxB8ZB2DxpsheD4mqLxIFqERYUnFNJgfVPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGVMgr4D;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D6606A31C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D7D6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGVMgr4D
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1063516a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795051777; x=1795656577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mPkIcszleH4UqVzMuyGFNOe9d+Bx16Jai6iLZ61iQ2Q=;
        b=FGVMgr4DUKiOLGp8hPGJ9wfyl/Q8b4eLsVNqRGGUxYKd1wpz0nLf8nlAdCxw2/0L5B
         YVF3OVWikbnTU69uUAvpTgfBgRFDckv1QWiUPUAYRcCVHbsaFkxgFfMYeIKn5JgzGtd9
         5aA3oO4lddxpknQ6kDCBvr/bi5KSBl//Kbc76V04KFc/M7I+CSMSIg6SxQREBfFfR5yU
         5iJ/NZ6eK7Nx4iX0wI2OBF658NxJWXHnzrxbwE0UjtCd6Xu83RjofLzNeBDFZEie6xR7
         pJ1ykoR0jMxpK3P8+est998WHKMXwbC4gpJ8Elvz2EJcNsGuVMjtHWZlACFNaAAZhBw4
         UsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795051777; x=1795656577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mPkIcszleH4UqVzMuyGFNOe9d+Bx16Jai6iLZ61iQ2Q=;
        b=CGy+od+IJEU0XUWgiVRDfvWK1pp4dctshCSQn7gl9zYxj7amo4vmEnUH2IXPElXa3n
         tf/0ud+pgILxoiWo5yDMKXMbC/76//rtNCo+e+arg4EFcU2nw9JwmpQfKqO3Vk2P/DCJ
         PJQy0LEGxhnOJe7IVxKKffOUOxv7oRPmsRQKRqxZIO71Rvd3ZAna4F0XiqecKtpQgS6w
         y6gXZxOeoiom9YlEPD6a9FNfpwtFKiYSw9L4nnWnYP1gBo6xVGYGBzvq7cI0jgKKQ2W9
         nLv6syx/VRvWP+mBph5qJIZviFRj0kgm94OORPyZGyg00LNHDOxfdqME6PSCKiZm7ZNH
         CrbA==
X-Gm-Message-State: APuU4Z/617P98vYfFO7OEl28LRTI2f0z8xkfZ5RKVTsq12g1onAC5U0N
	5MRQvQc/RikAgVyoAAtFt8VNu3DUsbHgcsb4iPhJ4z67tG8qgjugdpjEIEHqXQ==
X-Gm-Gg: AZFdTZdl3JLMNH7lzFBdwr8MTomd2XutR9XvjWV6nHgL9UvpOkvjZ7nnRIZVKiXUA6t
	lX6vmXvQDSNDM3afJ4CgypBqrtTvFyVu8qlLV6g9Kz6YH1XS6NMjSxG8vZyuE0uB193Yr3ofgTd
	Ogok3iYyZVytLIRFG5rmfRtQuhJohXueeixprXh0u4sdT60Sn/qPttGDDqATVwO0alOEGSiTyel
	rqSPy22g7cGyifaq0Av1yKq2o+Jeo7Ya8t4vhLdM9yviQQRE41l6ag7TARc5Pj05cg6Yjb/UDNT
	FNrA7mUTllbLcZxNr7CFdyKEnStem1IHVLNsheP28BAm1XzYWXiIcB+MFXt7XhGvTUaPjZQAEYE
	Ot1abyOcQXRGHDi0Lp9J23L+j58FZDLqHpCWLt8SKjQBFc6HCu917dAeOrJ/v1XnCqVxxy8BmiO
	fWHi/DmOtCWkXUStCkwoANdSwudyyDPJz76G9athHhxE5fYjzrNPXsvxOLDCENfqqHU6HpE8sly
	I+2HCiQT8Z++QBfysZlm7s6CoZtCv+GEFxav7Ri/1TM/lDvYNbW/mdWnyCjLTvHlKYDidTC4JCg
	wJIcYqUvfUhJnY8YKBzgqtEaKCQZghd/CCITdzaCOoCNEtsqpBy2CwaxVLiZhbLkPpwylH9PR5J
	MMvYVvbsK212o4+sahhqT5j7gSjeQdJ0AdcG+KMoaI13CX/x4syCMAnk4lXPjFP5UayZreZvrFw
	==
X-Received: by 2002:a17:90b:2643:b0:3ac:9e5e:d195 with SMTP id 98e67ed59e1d1-3b3d07cd4b0mr4236322a91.61.1795051776364;
        Wed, 18 Nov 2026 17:29:36 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde5349fbe5sm715969a12.17.2026.11.18.17.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 17:29:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 4/5] bpf, x86, arm64: Fit the return value of a prog to the return type
Date: Thu, 19 Nov 2026 01:29:08 +0000
Message-ID: <20261119012909.3657417-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
References: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A program returns 64 bits. The x86-64 and arm64 trampolines hand them to
a caller that was compiled for a function that returns int or bool.

An fmod_ret program skips the traced function if the 64 bits are not 0.
The caller of a function that returns int reads the low 32 bits only. So
the trampoline can skip the function on a value that the caller reads as
0:

	program             trampoline        caller
	r0 = 1 << 32        not 0: skip       eax == 0: success

That is no fault of the program. Compilers leave the high half of r0
open for int: "return x >> 8;" is a 64-bit shift. BPF LSM programs go
through the same code, and the verifier checks only the low 32 bits of
what they return.

A compiler may also assume that a function which returns bool leaves 0 or
1 in the low byte. This is what clang makes of "return f() ? 5 : 7;":

	x86-64    xor al, 1; movzx eax, al; lea eax, [rax * 2 + 5]
	arm64     tst w0, #1; csel ..

If the byte is 2, the first returns 11 and the second takes it for false.
An fmod_ret program on a function like should_fail_alloc_page() and
a struct_ops program behind a member like sched_ext_ops::yield() can
return any number.

Before the trampoline stores the value, extend its low ret_size bytes to
64 bits, with or without the sign, as the return type says. The s390
trampoline does that already. Make a bool 1 if its low byte is not 0.
struct btf_func_model does not tell bool from u8, hence
BTF_FMODEL_BOOL_RET. The trampoline tests, fexit programs read and the
caller gets the same value.

An fexit program still reads -EINVAL if the fmod_ret program returns it,
and now reads -EINVAL after "w0 = -22" too. Nothing but bool changes for
the callers of struct_ops programs: they read the low bytes only.

The price is one instruction behind the call of such a program, three for
bool. Fewer fmod_ret programs fit into an image: 33 instead of 35 on
arm64, 31 for bool. The trampolines of the other architectures are not
changed.

Fixes: ae24082331d9 ("bpf: Introduce BPF_MODIFY_RETURN")
Fixes: 13fac1d851e0 ("bpf: Fix trampoline generation for fmod_ret programs")
Fixes: efc9909fdce0 ("bpf, arm64: Add bpf trampoline for arm64")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++++++++++-----
 arch/x86/net/bpf_jit_comp.c   | 33 ++++++++++++++++++++++++++++-
 include/linux/bpf.h           |  3 +++
 kernel/bpf/btf.c              |  2 ++
 kernel/bpf/verifier.c         | 12 +++++------
 5 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b8d765d6ab07..a9a22a2f3d91 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2980,7 +2980,33 @@ bool bpf_jit_supports_large_stack(void)
 	return true;
 }
 
+/*
+ * A program returns 64 bits. The caller of the traced function, or of the
+ * struct_ops member, reads only the low ret_size bytes of x0. Extend them to
+ * 64 bits as the return type says. That is the value which the trampoline
+ * tests, which fexit programs read and which the caller gets.
+ */
+static void emit_narrow_ret(struct jit_ctx *ctx, const struct btf_func_model *m)
+{
+	int msb = m->ret_size * 8 - 1;
+
+	if (!m->ret_size || m->ret_size >= sizeof(u64))
+		return;
+
+	if (m->ret_flags & BTF_FMODEL_SIGNED_ARG)
+		emit(A64_SBFM(1, A64_R(0), A64_R(0), 0, msb), ctx);
+	else
+		emit(A64_UBFM(1, A64_R(0), A64_R(0), 0, msb), ctx);
+
+	if (m->ret_flags & BTF_FMODEL_BOOL_RET) {
+		/* The caller may assume that a bool is 0 or 1 */
+		emit(A64_CBZ(1, A64_R(0), 2), ctx);
+		emit(A64_MOVZ(1, A64_R(0), 1, 0), ctx);
+	}
+}
+
 static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image *im,
+			    const struct btf_func_model *m,
 			    struct bpf_tramp_node *node, int bargs_off,
 			    int retval_off, int run_ctx_off, bool save_ret)
 {
@@ -3034,8 +3060,10 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	emit_call((const u64)p->bpf_func, ctx);
 
-	if (save_ret)
+	if (save_ret) {
+		emit_narrow_ret(ctx, m);
 		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
+	}
 
 	if (ctx->image) {
 		int offset = &ctx->image[ctx->idx] - branch;
@@ -3055,6 +3083,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 }
 
 static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_image *im,
+			       const struct btf_func_model *m,
 			       struct bpf_tramp_nodes *tn, int bargs_off,
 			       int retval_off, int run_ctx_off, __le32 **branches)
 {
@@ -3065,7 +3094,7 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	 */
 	emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
 	for (i = 0; i < tn->nr_nodes; i++) {
-		invoke_bpf_prog(ctx, im, tn->nodes[i], bargs_off, retval_off,
+		invoke_bpf_prog(ctx, im, m, tn->nodes[i], bargs_off, retval_off,
 				run_ctx_off, true);
 		/* if (*(u64 *)(sp + retval_off) !=  0)
 		 *	goto do_fexit;
@@ -3459,7 +3488,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 			store_func_meta(ctx, meta, func_meta_off);
 			cookie_bargs_off--;
 		}
-		invoke_bpf_prog(ctx, im, fentry->nodes[i], bargs_off,
+		invoke_bpf_prog(ctx, im, m, fentry->nodes[i], bargs_off,
 				retval_off, run_ctx_off,
 				flags & BPF_TRAMP_F_RET_FENTRY_RET);
 	}
@@ -3470,7 +3499,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		if (!branches)
 			return -ENOMEM;
 
-		invoke_bpf_mod_ret(ctx, im, fmod_ret, bargs_off, retval_off,
+		invoke_bpf_mod_ret(ctx, im, m, fmod_ret, bargs_off, retval_off,
 				   run_ctx_off, branches);
 	}
 
@@ -3504,7 +3533,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 			store_func_meta(ctx, meta, func_meta_off);
 			cookie_bargs_off--;
 		}
-		invoke_bpf_prog(ctx, im, fexit->nodes[i], bargs_off, retval_off,
+		invoke_bpf_prog(ctx, im, m, fexit->nodes[i], bargs_off, retval_off,
 				run_ctx_off, false);
 	}
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d10a36daeeec..d51ae52fef71 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -4004,6 +4004,35 @@ static void restore_regs(u8 **prog, const u8 *pos_of_slot, int nr_slots,
 	}
 }
 
+/*
+ * A program returns 64 bits. The caller of the traced function, or of the
+ * struct_ops member, reads only the low ret_size bytes of rax. Extend them to
+ * 64 bits as the return type says. That is the value which the trampoline
+ * tests, which fexit programs read and which the caller gets.
+ */
+static void emit_narrow_ret(const struct btf_func_model *m, u8 **pprog)
+{
+	u8 *prog = *pprog;
+
+	if (m->ret_flags & BTF_FMODEL_BOOL_RET) {
+		/* The caller may assume that a bool is 0 or 1 */
+		EMIT2(0x84, 0xC0);       /* test al, al */
+		EMIT3(0x0F, 0x95, 0xC0); /* setne al */
+	}
+
+	/* movsx rax, al | ax | eax. Nothing for 8 bytes */
+	if (m->ret_flags & BTF_FMODEL_SIGNED_ARG)
+		emit_movsx_reg(&prog, m->ret_size * 8, true, BPF_REG_0, BPF_REG_0);
+	else if (m->ret_size == 1)
+		EMIT3(0x0F, 0xB6, 0xC0); /* movzx eax, al */
+	else if (m->ret_size == 2)
+		EMIT3(0x0F, 0xB7, 0xC0); /* movzx eax, ax */
+	else if (m->ret_size == 4)
+		EMIT2(0x89, 0xC0);       /* mov eax, eax */
+
+	*pprog = prog;
+}
+
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			   struct bpf_tramp_image *im,
 			   struct bpf_tramp_node *node, int stack_size,
@@ -4075,8 +4104,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	 * BPF_TRAMP_FENTRY trampoline may need to return the return
 	 * value of BPF_PROG_TYPE_STRUCT_OPS prog.
 	 */
-	if (save_ret)
+	if (save_ret) {
+		emit_narrow_ret(m, &prog);
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+	}
 
 	/* replace 2 nops with JE insn, since jmp target is known */
 	emit_code(jmp_insn, X86_JE + ((prog - jmp_insn - 2) << 8), 2);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 25704de9c4b2..971e584c6efc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1285,6 +1285,9 @@ struct bpf_prog_offload {
 /* The argument is nullable. */
 #define BTF_FMODEL_NULLABLE_ARG		BIT(3)
 
+/* The return value is a bool. */
+#define BTF_FMODEL_BOOL_RET		BIT(4)
+
 struct btf_func_model {
 	u8 ret_size;
 	u8 ret_flags;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e95ca39f990c..2f28b418a7fc 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8385,6 +8385,8 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 	}
 	m->ret_size = ret;
 	m->ret_flags = __get_type_fmodel_flags(t);
+	if (ret == 1 && btf_type_is_int(t) && (btf_int_encoding(t) & BTF_INT_BOOL))
+		m->ret_flags |= BTF_FMODEL_BOOL_RET;
 
 	for (i = 0; i < nargs; i++) {
 		if (i == nargs - 1 && args[i].type == 0) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1a8e5a108a68..39f1c6eb1131 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19983,14 +19983,12 @@ static int check_fmodret_retval(struct bpf_verifier_env *env, int regno,
 	}
 
 	/*
-	 * "w0 = -22" zero-extends, the caller of an int function sees -22. The
-	 * trampoline tests all 64 bits: 1 << 32 would skip the function, and the
-	 * caller would see 0. So the low 32 bits decide only if the high ones are 0.
+	 * "w0 = -22" zero-extends. The trampoline sign-extends the low 32 bits of
+	 * the value for an int function, so its caller sees -22. The low 32 bits
+	 * decide if the high ones are 0. Else the 64 bits have to be in the list.
 	 *
-	 * That is right where the ABI leaves the high 32 bits of an int in the
-	 * return value register open: x86-64, arm64. s390x, riscv64, ppc64 and
-	 * loongarch want it sign-extended: look here before one of them is added
-	 * to CONFIG_BPF_FMODRET_SCAN.
+	 * The trampolines of x86-64, arm64 and s390x do that: look here before
+	 * another architecture is added to CONFIG_BPF_FMODRET_SCAN.
 	 */
 	t = btf_type_skip_modifiers(aux->attach_btf, aux->attach_func_proto->type, NULL);
 	if (t->size == 4 && reg_umax(reg) <= U32_MAX) {
-- 
2.55.0

