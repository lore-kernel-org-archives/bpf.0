Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C9192B75
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197746; cv=none; b=svEK4YrwgS+fwgD4w1Dgl/5BfOinS/5gvRWjCb07sQ7UjHP3Lh8EFVOMbfReXOcu/6AJ+a/yggrFhQ4xFwGFbSqymoD0ShwPH+UW/5zRDV/PapwoSqJ00CdtgaJUFY73/BdvmnN2nzZLyfmn8IZlyuU30Nt0GnuAil6f4hRgBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197746; c=relaxed/simple;
	bh=age7IRVMQN1rv0qTk1lEnOaESlGTV7tvkD3o4ev5NGw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=UV8RF+8lAPAjnxAqKklqEZRLPhwSa61xXWsSaLccejKoRhfB0XnEaYwQNUuZtFW2BbFeGL32Vn5W8WtD0Ok1Db+M23gwNl8m0qqUshaLJGXCZ1caP48id6D/wW0kbM0sC8GjdQ29HC1s2vlSSq6FTisL5LKn/NmfavjowOGTBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNA+XE7L; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNA+XE7L"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc50ad2d650so338879a12.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792197744; x=1792802544; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LcTzuZkithM63DgwT2ZigPKz+85tq8z4s8ewgIOqK9I=;
        b=RNA+XE7LYHiL61TfoE+HD4NWrE5Z/889ZMaXzNx/pWi3R1l0jPvMibJXy9yJw7rP0F
         XVLh1Sn6j7RyHKjbM3+qQSLXD81HZiXakCwWp7tCbOb+dDhI5HPO+oiuhC5dVVhh+CUW
         ZbPWbi6qWHH7zTKnNwFjvu5SfXIPUZvRhOsS4xzS/Jc0YYiV/aHX/bKerkgpWMeLOl/0
         nT8XNpqblkGm83vaX3ZDs71ajdjftVYGqWTszmPjH3Eh4audtSOJn0mutjt42TGdWC74
         +zX8krG9w1pbxHtXoZ4qwKE8pUPU+c8V4vc6aVO6HutHQYokNT0bvJjdUTvL/f9Yit3n
         LOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792197744; x=1792802544;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LcTzuZkithM63DgwT2ZigPKz+85tq8z4s8ewgIOqK9I=;
        b=gUgtR94o1+NliQS5ovf77F0UypFbcG+oYpTLhag28DQD8ciSsalRjmZOizlK9DQ4DC
         U0nhZAH/6UHEOMMoK0JZ8mgSZWKnGenYJwdgcObbLIqFlgTWfH4YzYmDZbI+V76/EJJB
         9S/FTW10l51OsiJ/2Z10mriw0F9Hf3PADdGLG364V1lb86OIRDhSExMNeN5rgin2UtRN
         k+gizdf2WU0Micfqcarmx6wmXhx0wg//SNgY3/MZBBAEDwwDkSX6oAQvT02SRhYhSnI9
         m4EkVflniTanZ4EUB5ctAuPQdP3cNX7a0gnCdpIwPh59Un4iIcV3XOGnawGhU8x7aoMk
         FIBg==
X-Forwarded-Encrypted: i=1; AKwUvBybR9Omc9YV3vqKSwqRUKzZUnsNe6wKmNzwwokp3eP/IVgZApn0637+soEsM8yWQz9m6s0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZl2kq4ecPGTAXCnCMrz8ZVVs07dl0I8pyp2bQbgbuAXYoLioN
	C/Y+Kdc6iYG9HvbW/7V/DAknUVWigxEPkexI7ZFJP3+3BMKTRRT/BKAc
X-Gm-Gg: AYBFou1RIljkJFfNBLB2KT5/Okt36iCGv/cawaNGmBf2SPbUD9Z4V2rdF7Hjv8Ms4pQ
	57jB9GyKetayCrtQAd65JEXv7fg4fmfXuZX5MhzRwvTnMv5Xwoj3fTA/bTJiQdQ3UjWCkdlBLbe
	wZz6wuiXN/XSFISTMnPsyrjEHynkG+fukmeNRTIs7pRONAkslN7OvNbACRYHgT0fmvakefaiUqQ
	ZmKmFzy8+w4mfFVw1mvCI9H3apounBXRUz40sdcZksdJB96S0+SZ817WsTotjwP1NqFbeAdudU0
	Om7XxCFaxo6RtOPoAsI1yolSX0G6tmL3SDmH9QytgQ1nnVAFEQtKjvwU2YrRzejiv0g2rAQH2iB
	L7QptSiNdKOwuuqQH66qna8ks9YE2vh4DZs58cjHuvn4AaPYYSCQ6oOWxfso5VzIo+LD71yURET
	3oNbx56Dz4S9p+oibv5aYrqbsHMcvIYzOPWIv/9WfEEtlIIfaw7aRIE8Iojua9Cefu8mT9NTZSR
	YNabFH/UdlUfkEFyCxxgg4a/rr33dW9HV6Iv9xUCL3VBIUSUajEmLIwQbDOxCBQ+sphcV5ID4kG
	71edKepRTHyYmA==
X-Received: by 2002:a17:90b:5745:b0:3ac:c03a:38b0 with SMTP id 98e67ed59e1d1-3acee27798dmr1358403a91.8.1792197743580;
        Fri, 16 Oct 2026 17:42:23 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1f0asm16663445ad.68.2026.10.16.17.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 17:42:22 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 00:42:21 +0000
Message-Id: <DM6P2S5E5F3M.3RB3ECL75G1PJ@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, <x86@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov"
 <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, "Leon Hwang" <leon.hwang@linux.dev>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Hao Sun" <sunhao.th@gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/7] bpf: Inline kfuncs that have a BPF
 body
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yusheng Zheng" <yunwei356@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261005142219.33451-1-yunwei356@gmail.com>
References: <20261005142219.33451-1-yunwei356@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Oct 05, 2026 at 07:22 AM Yusheng Zheng <yunwei356@gmail.com> wrote:
>   1. Is it acceptable that the verifier replaces calls with their
>      bodies before the analysis and restores them afterwards?

yes.

>   2. Should kfuncs bring native code through an emit callback, or
>      should the JIT only copy compiled kfuncs? The table shows what
>      copying alone costs.

Copy only.

>   3. Native code is trusted like the rest of the JIT, and the selftests
>      compare it with the bodies on random inputs. Is that enough?
>   4. The bodies are written by hand. Should they rather be compiled from
>      the kfunc's C source, as in the inlinable kfuncs RFC [3]?

Both questions go away when C is the only implementation.

As I suggested to Leon: keep C as the fallback, let KF_FASTCALL be
the signal, check the compiled kfunc with the insn decoder and copy it
without 'ret'.
llvm keeps r1-r5 that are not arguments live across bpf_fastcall.
When JIT can inline, the verifier removes spill/fill. When it cannot,
they stay and C is called. That works on all archs from day one.
The arguments are in rdi, rsi, rdx already, so memcpy is enough.
No need to re-encode the insns.
clang compiles bpf_rol64() into
  mov %esi,%ecx; mov %rdi,%rax; rol %cl,%rax
rcx is R4 and it's not an argument, hence push/pop around it.
Then no need for bodies, emit, capture of __k constants, kfunc_bind(),
register renaming, body table in btf, hooks in do_check() and
const_fold, insn_kfuncs/ with two Kconfigs, etc.
What is missing: arm64, byte ops like setcc, selftests,
no push/pop when the register is dead.
Something like this (compile tested only):

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 004e2dd..7a5667f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -15,8 +15,11 @@
 #include <linux/memory.h>
 #include <linux/sort.h>
 #include <linux/execmem.h>
+#include <linux/ftrace.h>
+#include <linux/kallsyms.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
+#include <asm/insn.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/text-patching.h>
@@ -2501,6 +2504,154 @@ static void adjust_cmp_imm(u32 *op, s32 *imm)
 	}
 }
 
+/* The longest kfunc to inline, in bytes */
+#define KFUNC_INLINE_MAX	64
+
+static u32 x86_reg_bit(u32 bpf_reg)
+{
+	return BIT(reg2hex[bpf_reg] | is_ereg(bpf_reg) << 3);
+}
+
+/*
+ * Return the mask of x86 registers named by an insn of a kfunc or -EINVAL if
+ * the insn cannot be copied. Only 32 and 64-bit moves and ALU ops can be:
+ * no control flow, prefixes, rip-relative addressing or implicit destination.
+ */
+static int kfunc_insn_regs(struct insn *insn)
+{
+	u8 rex = insn->rex_prefix.bytes[0], modrm = insn->modrm.bytes[0], sib = insn->sib.bytes[0];
+	u8 ext = X86_MODRM_REG(modrm), idx = X86_SIB_INDEX(sib) | X86_REX_X(rex) << 2;
+	u32 op = insn->opcode.bytes[0];
+	int regs = 0;
+
+	if (insn->prefixes.nbytes || insn->rex_prefix.nbytes > 1 || insn->opcode.nbytes > 2 ||
+	    insn_is_avx_or_xop(insn) || insn_rip_relative(insn))
+		return -EINVAL;
+	if (insn->opcode.nbytes == 2)
+		op = op << 8 | insn->opcode.bytes[1];
+
+	switch (op) {
+	case 0x01: case 0x03:			/* add */
+	case 0x09: case 0x0b:			/* or */
+	case 0x21: case 0x23:			/* and */
+	case 0x29: case 0x2b:			/* sub */
+	case 0x31: case 0x33:			/* xor */
+	case 0x39: case 0x3b:			/* cmp */
+	case 0x63:				/* movsxd */
+	case 0x69: case 0x6b: case 0x0faf:	/* imul */
+	case 0x85:				/* test */
+	case 0x89: case 0x8b:			/* mov */
+	case 0x8d:				/* lea */
+	case 0x0f40 ... 0x0f4f:			/* cmovcc */
+	case 0x0fb7: case 0x0fbf:		/* movzx, movsx */
+		regs = BIT(ext | X86_REX_R(rex) << 1);
+		break;
+	case 0x81: case 0x83:			/* ALU ops with imm */
+	case 0xc1: case 0xd1: case 0xd3:	/* shifts and rotates */
+		break;
+	case 0xc7:				/* mov imm */
+		if (ext)
+			return -EINVAL;
+		break;
+	case 0xf7:				/* test, not, neg */
+		if (ext > 3)
+			return -EINVAL;
+		break;
+	case 0xb8 ... 0xbf:			/* mov imm */
+	case 0x0fc8 ... 0x0fcf:			/* bswap */
+		return BIT((op & 7) | X86_REX_B(rex) << 3);
+	default:
+		return -EINVAL;
+	}
+	if (!insn->sib.nbytes)
+		return regs | BIT(X86_MODRM_RM(modrm) | X86_REX_B(rex) << 3);
+	if (idx != 4)
+		regs |= BIT(idx);
+	return regs | BIT(X86_SIB_BASE(sib) | X86_REX_B(rex) << 3);
+}
+
+/* @op is 0x50 for push and 0x58 for pop of x86 register @reg */
+static void emit_push_pop(u8 **pprog, u8 op, int reg)
+{
+	u8 *prog = *pprog;
+
+	if (reg > 7)
+		EMIT1(0x41);
+	EMIT1(op | (reg & 7));
+	*pprog = prog;
+}
+
+/*
+ * Inline a KF_FASTCALL kfunc: copy what the compiler generated for it without
+ * ENDBR, fentry and 'ret'. bpf_fastcall lets it clobber only R0 and the
+ * arguments. Push/pop the other caller saved registers that it uses.
+ */
+static int emit_kfunc_inline(u8 **pprog, unsigned long addr, const struct btf_func_model *m)
+{
+	/* a call clobbers r10 and r11, hence nothing is live there */
+	u32 scratch = x86_reg_bit(BPF_REG_AX) | x86_reg_bit(AUX_REG);
+	u32 save = x86_reg_bit(X86_REG_R9), used = 0;
+	u8 *p = (u8 *)addr, *start, *prog = *pprog;
+	unsigned long size, off;
+	struct insn insn;
+	int i, regs;
+
+	if (m->nr_args > MAX_BPF_FUNC_REG_ARGS)
+		return -EINVAL;
+	for (i = 0; i < m->nr_args; i++)
+		if (m->arg_size[i] > 8 || (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG))
+			return -EINVAL;
+	for (i = BPF_REG_0; i <= BPF_REG_5; i++) {
+		if (i ? i <= m->nr_args : m->ret_size)
+			scratch |= x86_reg_bit(i);
+		else
+			save |= x86_reg_bit(i);
+	}
+
+	if (!kallsyms_lookup_size_offset(addr, &size, &off) || off)
+		return -EINVAL;
+	if (is_endbr((u32 *)p))
+		p += ENDBR_INSN_SIZE;
+	if (ftrace_location(addr) == (unsigned long)p)
+		p += MCOUNT_INSN_SIZE;
+
+	for (start = p;; p += insn.length) {
+		if (p - start > KFUNC_INLINE_MAX || p >= (u8 *)addr + size ||
+		    insn_decode_kernel(&insn, p))
+			return -EINVAL;
+		if (insn.opcode.bytes[0] == RET_INSN_OPCODE ||
+		    (insn.opcode.bytes[0] == JMP32_INSN_OPCODE &&
+		     p + insn.length + insn.immediate.value == (u8 *)x86_return_thunk))
+			break;
+		regs = kfunc_insn_regs(&insn);
+		if (regs < 0)
+			return regs;
+		used |= regs;
+	}
+	if (used & ~(scratch | save))
+		return -EINVAL;
+	save &= used;
+
+	for (i = 0; i < 16; i++)
+		if (save & BIT(i))
+			emit_push_pop(&prog, 0x50, i);
+	memcpy(prog, start, p - start);
+	prog += p - start;
+	for (i = 15; i >= 0; i--)
+		if (save & BIT(i))
+			emit_push_pop(&prog, 0x58, i);
+
+	*pprog = prog;
+	return 0;
+}
+
+bool bpf_jit_inlines_kfunc_call(unsigned long addr, const struct btf_func_model *m)
+{
+	u8 buf[BPF_MAX_INSN_SIZE], *prog = buf;
+
+	return !emit_kfunc_inline(&prog, addr, m);
+}
+
 static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -3424,6 +3575,12 @@ populate_extable:
 				fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
 				if (!fm)
 					return -EINVAL;
+				if (fm->ret_flags & BTF_FMODEL_JIT_INLINE) {
+					err = emit_kfunc_inline(&prog, (unsigned long)func, fm);
+					if (err)
+						return err;
+					break;
+				}
 				err = emit_kfunc_arena_args(bpf_prog, fm, &prog);
 				if (err < 0)
 					return err;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5414437..91b2c0e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1256,6 +1256,9 @@ struct bpf_prog_offload {
 /* The argument is nullable. */
 #define BTF_FMODEL_NULLABLE_ARG		BIT(3)
 
+/* In ret_flags: the JIT inlines calls of this kfunc. */
+#define BTF_FMODEL_JIT_INLINE		BIT(4)
+
 struct btf_func_model {
 	u8 ret_size;
 	u8 ret_flags;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9339c61..cd170bf 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1239,6 +1239,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
+bool bpf_jit_inlines_kfunc_call(unsigned long addr, const struct btf_func_model *m);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 642f0ab..49f331d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3295,6 +3295,15 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
 	return false;
 }
 
+/* Return TRUE if the JIT backend inlines the KF_FASTCALL kfunc at @addr
+ * without clobbering registers that bpf_fastcall contract doesn't allow.
+ * Otherwise the kfunc is called and spills/fills around the call stay.
+ */
+bool __weak bpf_jit_inlines_kfunc_call(unsigned long addr, const struct btf_func_model *m)
+{
+	return false;
+}
+
 /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool __weak bpf_jit_supports_subprog_tailcalls(void)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 439370d..4a1c08f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3383,6 +3383,16 @@ __bpf_kfunc void *bpf_rdonly_cast(const void *obj__ign, u32 btf_id__k)
 	return (void *)obj__ign;
 }
 
+__bpf_kfunc u64 bpf_rol64(u64 x, u32 n)
+{
+	return rol64(x, n);
+}
+
+__bpf_kfunc u64 bpf_select64(u64 cond, u64 a, u64 b)
+{
+	return cond ? a : b;
+}
+
 __bpf_kfunc void bpf_rcu_read_lock(void)
 {
 	rcu_read_lock();
@@ -5147,6 +5157,8 @@ BTF_ID(func, bpf_cgroup_release_dtor)
 BTF_KFUNCS_START(common_btf_ids)
 BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx, KF_FASTCALL)
 BTF_ID_FLAGS(func, bpf_rdonly_cast, KF_FASTCALL | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_rol64, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_select64, KF_FASTCALL)
 BTF_ID_FLAGS(func, bpf_rcu_read_lock)
 BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
 BTF_ID_FLAGS(func, bpf_dynptr_slice, KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 62f8951..84b641d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3151,6 +3151,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	meta.func_proto = kfunc.proto;
 	meta.func_name = kfunc.name;
 	meta.kfunc_flags = kfunc.flags ? *kfunc.flags : 0;
+	if ((meta.kfunc_flags & KF_FASTCALL) && bpf_jit_inlines_kfunc_call(addr, &func_model))
+		func_model.ret_flags |= BTF_FMODEL_JIT_INLINE;
 
 	tab = krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1), GFP_KERNEL_ACCOUNT);
 	if (!tab)
@@ -19257,6 +19259,13 @@ bool bpf_verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	}
 }
 
+/* True if bpf_fixup_kfunc_call() replaces calls to the kfunc */
+static bool verifier_inlines_kfunc_call(u32 func_id)
+{
+	return func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	       func_id == special_kfunc_list[KF_bpf_rdonly_cast];
+}
+
 /* If @call is a kfunc or helper call, fills @cs and returns true,
  * otherwise returns false.
  */
@@ -19285,14 +19294,18 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 	}
 
 	if (bpf_pseudo_kfunc_call(call)) {
+		struct bpf_kfunc_desc *desc;
 		int err;
 
 		err = bpf_fetch_kfunc_arg_meta(env, call->imm, call->off, &meta);
 		if (err < 0)
 			/* error would be reported later */
 			return false;
+		desc = find_kfunc_desc(env->prog, call->imm, call->off);
 		cs->arg_slot_cnt = btf_proto_slots(meta.btf, meta.func_proto);
-		cs->fastcall = meta.kfunc_flags & KF_FASTCALL;
+		cs->fastcall = (meta.kfunc_flags & KF_FASTCALL) &&
+			       (verifier_inlines_kfunc_call(meta.func_id) ||
+				(desc && (desc->func_model.ret_flags & BTF_FMODEL_JIT_INLINE)));
 		cs->is_void = btf_type_is_void(btf_type_by_id(meta.btf, meta.func_proto->type));
 		return true;
 	}
@@ -22945,8 +22958,7 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 		__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
 						node_offset_reg, insn, insn_buf, cnt);
-	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
+	} else if (verifier_inlines_kfunc_call(desc->func_id)) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&

