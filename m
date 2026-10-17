Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41E33A6B9D
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273273; cv=none; b=FVzdbY1uXn3ZujEoK7bfx8wVRTj+xWo5Nw5Q333U1nSY0wF6ASbIwOl7Ju0LbK6qjSjJrHb5TQBTnsXAqwiqY6ft4PlRlisWQBlgHs1TU6HKaitTH69HSJigNQxeMtgL4K0wpiRT/OLF4PKl2IGrP5tbd64mt/GvoH9t8ycom2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273273; c=relaxed/simple;
	bh=zsTgdN7ITw6Uv1voDzDZ7NOOUkn+Fc5s1YiRztNnMZA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=EKRzVtLZJkL2uldc50D+S8muSuAemxS3IQEdn1FTdV8GfM1+keZbFDOwg407GDHX6i/8fb3HdFO4XQOFnvES5J1FDtC0GyItK0qJyy0v/qz2VmP51Upj/TJ/xIsBCwr8Jr7/PEQVkox0jDvy0IDonP37leLlra2zh/XgkCq7+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGGCXGZX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGGCXGZX"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so946301a12.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 14:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792273271; x=1792878071; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csKj0eMgd2Ov4hRemAPZtQYtTWr9l0RQkPEyBJ+cRUg=;
        b=CGGCXGZXpwEKoDeepBR1D2p8zs1codGP3psem99uMk1bep4ZHlrqLodLRdxcuWHkyX
         5J+FQgJGyxztVIe8E8pqfJmvocTiugprjUKmboZbT2bxRCTv2icjVFrQla3JLjQYySlS
         W1hJvYIsFWcVCrvxAH83IiALIrzU+u4+sGskwDsesbCS1BbEw+sbTJ/PBwKsEem7Zn5C
         2HQErh+OM8X/qlheoz3eU+Kb43u/MtqX8nqr2uqxU9lf7jL1cFWR3yixq6RL0rXlY4S9
         W+gN4A9iY29KBseptZ8lKDLbquvTgNAa40E+T5zYseXU2xxRGBvmz4rAhNP4NrKLC+7D
         PQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273271; x=1792878071;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csKj0eMgd2Ov4hRemAPZtQYtTWr9l0RQkPEyBJ+cRUg=;
        b=bOnNsbCklC+EQ4P11fcWFkvHrA8q5oiOk0zfXfuzFtuWl1MhyV/uXBkarql+0rnsft
         4W40RmruBmXuMJ0Tm2i/g1UG55nt7F+SqrwRp+sT5zs5EaBLnBg2Y85VsYa+9iAQHi0/
         mnw/AAq8MoxhKV6QUdarwRuZi0u17y1ewcUxMfnlmHOmj0KviDu/KoNtKG92+bqXwyJo
         Z3Mbh+Z0zlKFj2ljvwLKjQWmmej5ARoQshv2BnEjMskL5/4VWQ2lztVJQgjTsF9R6neh
         pRekeqrl2+iWGQ8Qmn5lDyUHyN/7q+bP+LRvdVraFy+5SmOOaA1tN0NLOWMBPg+uRbYh
         LENw==
X-Forwarded-Encrypted: i=1; AKwUvByvcEMu8VgeeAXGHqiOn63riDFPhippak3UCZ2GtM7FwtWfOH9GBQgQiG4ygXJ9IrYg7qs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU5rVWomF8taVOzAfJ9S9NQv4rFiXPVKk/oTtdWzKptEy4atD3
	jTXhWZMU0PEwZxc5zduNRopGK+M2PJkvFWzk6JbdjLc1l2+JcRiyrgCp
X-Gm-Gg: AYBFou00X8TgmYAFWXo/ZrWkZcbrtfzfJmsbgQ/I/Cdi59hcUiM3k0V7TKVwSjKtEJ8
	1zAso7OVAbVjft0h9zxAkPHCAzDgZAoBhBmadw5ASmrCjfRdmot0VbfyJ2yv1uAL0toWNitA7pj
	jKvdfSNoRRo5E0FKagSKk5mSxUtYTA9Km/X3so3LG1ZgAYH2Sv/mn1AmWX4h4/xptF1mMSQymYi
	70fJTecMzacNE1vosXo5bR6VOK7LqKCrPnRpEWJvPGa/VwiD8cveI8E0v0Vgrux+NJdnKYIbCq4
	MmDhmtuf7c6a+8COrc5Ao40TvZoax+1nPOJuoOLD8b4LnaSvR2v9b7lPDETo4vS0qVa6xfVXFny
	CzsPcNDHg7vGm11UHl6D2FcxNkBNEZjgyjmQxtM2mcVSFZ92Mg/j9LEbpP4WU5kqQlKr3qkkGOG
	c4+Q2ZX+upvEA7/qtMHlu/9xwOT6pq80q90gvcxrobxP/LziZDEfi4OQ8V7PFMB/mXeIkyFiplr
	yTRqEmcCS3LxSemVF4jtZ/eHlZ9Ww6O2OmPLuf/FfLBcZsy1uzQzNt/YldLSONDgdexSYitMjKV
	JLdn
X-Received: by 2002:a05:6a21:ae11:b0:3e1:b625:7400 with SMTP id adf61e73a8af0-3e202086c75mr3021519637.15.1792273270563;
        Sat, 17 Oct 2026 14:41:10 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65497df08sm2434697a12.6.2026.10.17.14.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 14:41:09 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 21:41:09 +0000
Message-Id: <DM7FULA7L0GQ.R21A648X547X@gmail.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v12 00/25] bpf: Run exception cleanup landing
 pads when bpf_unwind() unwinds
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <CAP01T75Ldbsew4rarQynmbpOvBxaRM7Lxk_1GsZL_rJFOzv-CQ@mail.gmail.com>
References: <20261017025129.1914859-1-yonghong.song@linux.dev> <DM7A976G9OGW.ZR7PNBUP083C@gmail.com> <CAP01T75Ldbsew4rarQynmbpOvBxaRM7Lxk_1GsZL_rJFOzv-CQ@mail.gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 10:03 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> still favor this approach over adding a runtime calling convention
> that requires checks everywhere in the normal path.

I suspect you're concerned by run-time overhead.
I was as well until I actually benchmarked it.

JIT can drop the branch and remember it in extable instead.

  bpf                         x86 as-is                   x86 with extable
  call check                  call check                  call check
  if r3 != 0 goto pad         test rdx, rdx               call bpf_rcu_read_unlock
  call bpf_rcu_read_unlock    jne pad
                              call bpf_rcu_read_unlock

The idea:

  at 'call foo; if r3 != 0 goto pad':
	emit(call foo)
	extable[n++] = { ret_addr -> pad }

  at 'r3 = 1; exit':
	my_ret_addr = bpf_unwind_target(my_ret_addr)
	epilogue

  bpf_unwind_target(ra)
  {
	e = search_extable(ra);
	return e ? e->pad : ra;
  }

Every frame fixes only its own return address.
No stack walk, no ORC. catch still works.

When JIT cannot drop the branch (private stack, constant blinding)
there is no entry. The callee returns as usual and the branch does the job.

The verifier doesn't know about any of that.

That said, I couldn't measure the branch.
N call sites in a row, user space, Zen 5, cycles per call:

  N       nothing   test+jne
  8192     4.04      4.06
  12288    5.57      4.49
  16384    6.60     10.57
  32768   24.89     24.39

Up to 8k call sites it's 4 cycles with or without the branch.
Above 16k the calls don't fit into BTB and it's 24 cycles either way.
In between it goes both ways.

I also tried to keep the distance to the pad in a nop:
  call foo
  nopl dist(%rax)
'r3 = 1; exit' reads it via its return address. No lookup.
It works, but the numbers are the same as for test+jne.
No measurable difference in a microbenchmark.

I don't think we need the below diff from day one. I think we should
start with plain branches
and then measure benefits of above diff on real rust prog.

The kernel and llvm diffs are so simple.
It's a huge difference vs everything we discussed before.

On top of the kernel part from the previous email
(x86 only, in qemu, the same tests pass with and without bpf_jit_harden=2):

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 11a4e4f87aac..abe942631486 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -15,6 +15,7 @@
 #include <linux/memory.h>
 #include <linux/sort.h>
 #include <linux/execmem.h>
+#include <linux/extable.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
@@ -2511,6 +2512,89 @@ static void adjust_cmp_imm(u32 *op, s32 *imm)
 	}
 }
 
+/*
+ * A subprog that can unwind says so in r3 and its caller does
+ * 'if r3 != 0 goto pad' after the call. Keep that off the normal path:
+ * the branch is not emitted, it becomes an extable entry
+ *   return address of the call -> pad
+ * An exit with r3 != 0 looks its own return address up and returns to the pad.
+ * When there is no entry it returns as usual and the branch is there.
+ */
+static bool unwind_site(struct bpf_verifier_env *env, struct bpf_prog *prog, int i)
+{
+	const struct bpf_insn *insn = &prog->insnsi[i];
+
+	/* 'pop r9' after the call has to run on the way to the pad too */
+	if (!env || i + 1 >= prog->len || prog->aux->priv_stack_ptr)
+		return false;
+	if (!bpf_pseudo_call(insn) && !bpf_is_callx(insn))
+		return false;
+	/*
+	 * No need to know the callee: the verifier lets r3 be read after
+	 * a call only when every callee seen there says something in it.
+	 */
+	return insn[1].code == (BPF_JMP | BPF_JNE | BPF_K) && !insn[1].imm &&
+	       insn[1].dst_reg == BPF_REG_UNWIND &&
+	       !bpf_is_jump_target(env, prog->aux->subprog_start + i + 1);
+}
+
+static u64 bpf_unwind_target(const struct bpf_prog_aux *aux, u64 ra)
+{
+	const struct exception_table_entry *e;
+	u32 i;
+
+	for (i = 0; i < aux->real_func_cnt; i++) {
+		struct bpf_prog *p = aux->func[i];
+		u64 start = (u64)p->bpf_func;
+
+		if (ra <= start || ra > start + p->jited_len)
+			continue;
+		/* - 1: what follows the call can have an entry of its own */
+		e = search_extable(p->aux->extable, p->aux->num_exentries, ra - 1);
+		return e ? ra + e->fixup : ra;
+	}
+	return ra;
+}
+
+enum { EXIT_RETURNS, EXIT_UNWINDS, EXIT_LOOK_AT_R3 };
+
+static int unwind_exit(struct bpf_verifier_env *env, struct bpf_prog *prog, int i)
+{
+	const struct bpf_insn *insn = &prog->insnsi[i];
+
+	if (!env || !prog->aux->ret_unwind)
+		return EXIT_RETURNS;
+	if (!i || bpf_is_jump_target(env, prog->aux->subprog_start + i) ||
+	    insn[-1].code != (BPF_ALU64 | BPF_MOV | BPF_K) ||
+	    insn[-1].dst_reg != BPF_REG_UNWIND)
+		return EXIT_LOOK_AT_R3;
+	return insn[-1].imm ? EXIT_UNWINDS : EXIT_RETURNS;
+}
+
+static int emit_unwind_ret_addr(u8 **pprog, struct bpf_prog *bpf_prog, u8 *ip, bool look_at_r3)
+{
+	u8 *prog = *pprog, *start = prog, *jmp = NULL;
+
+	if (look_at_r3) {
+		EMIT3(0x48, 0x85, 0xD2);	/* test rdx, rdx */
+		EMIT2(X86_JE, 0);
+		jmp = prog;
+	}
+	EMIT3(0x50, 0x56, 0x52);		/* push rax; push rsi; push rdx */
+	emit_mov_imm64(&prog, BPF_REG_1, (long)bpf_prog->aux >> 32, (u32)(long)bpf_prog->aux);
+	EMIT4(0x48, 0x8B, 0x75, 0x08);		/* mov rsi, [rbp + 8] */
+	ip += prog - start;
+	ip += x86_call_depth_emit_accounting(&prog, bpf_unwind_target, ip);
+	if (emit_call(&prog, bpf_unwind_target, ip))
+		return -EINVAL;
+	EMIT4(0x48, 0x89, 0x45, 0x08);		/* mov [rbp + 8], rax */
+	EMIT3(0x5A, 0x5E, 0x58);		/* pop rdx; pop rsi; pop rax */
+	if (jmp)
+		jmp[-1] = prog - jmp;
+	*pprog = prog;
+	return 0;
+}
+
 static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -2518,7 +2602,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	struct bpf_insn *insn = bpf_prog->insnsi;
 	bool callee_regs_used[4] = {};
 	int insn_cnt = bpf_prog->len;
-	bool seen_exit = false;
+	bool seen_exit = false, skip_branch = false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
 	void __percpu *priv_frame_ptr = NULL;
 	u16 out_stack_arg_cnt, outgoing_rsp;
@@ -2655,6 +2739,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		int nops;
 		u32 jmp_op = BPF_OP(insn->code);
 		s32 cmp_imm;
+		int unw;
+
+		if (skip_branch) {
+			skip_branch = false;
+			goto insn_done;
+		}
 
 		if (priv_frame_ptr) {
 			if (src_reg == BPF_REG_FP)
@@ -3460,6 +3550,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			ip += x86_call_depth_emit_accounting(&prog, func, ip);
 			if (emit_call(&prog, func, ip))
 				return -EINVAL;
+			if (unwind_site(env, bpf_prog, i - 1))
+				goto unwind_exentry;
 			if (priv_frame_ptr)
 				pop_r9(&prog);
 			/*
@@ -3487,6 +3579,27 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			}
 			if (emit_indirect_call(&prog, insn->dst_reg, ip))
 				return -EINVAL;
+			if (unwind_site(env, bpf_prog, i - 1)) {
+				struct exception_table_entry *ex;
+				int ra;
+unwind_exentry:
+				skip_branch = true;
+				if (!bpf_prog->aux->extable)
+					break;
+				if (excnt >= bpf_prog->aux->num_exentries) {
+					pr_err("unwind extable bug\n");
+					return -EFAULT;
+				}
+				ra = proglen + (prog - temp);
+				ex = &bpf_prog->aux->extable[excnt++];
+				jmp_offset = image + ra - 1 - (u8 *)&ex->insn;
+				/* switch ex to rw buffer for writes */
+				ex = (void *)rw_image + ((void *)ex - (void *)image);
+				ex->insn = jmp_offset;
+				ex->fixup = addrs[i + 1 + insn[1].off] - ra;
+				ex->data = EX_TYPE_BPF;
+				break;
+			}
 			if (priv_frame_ptr)
 				pop_r9(&prog);
 			break;
@@ -3772,13 +3885,17 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			break;
 
 		case BPF_JMP | BPF_EXIT:
+			unw = unwind_exit(env, bpf_prog, i - 1);
+			if (unw != EXIT_RETURNS &&
+			    emit_unwind_ret_addr(&prog, bpf_prog, ip, unw == EXIT_LOOK_AT_R3))
+				return -EINVAL;
 			if (seen_exit) {
 				jmp_offset = ctx->cleanup_addr - addrs[i];
 				goto emit_jmp;
 			}
 			seen_exit = true;
 			/* Update cleanup_addr */
-			ctx->cleanup_addr = proglen;
+			ctx->cleanup_addr = proglen + (prog - temp);
 			if (bpf_prog_was_classic(bpf_prog) &&
 			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
@@ -3811,6 +3928,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			return -EINVAL;
 		}
 
+insn_done:
 		ilen = prog - temp;
 		if (ilen > BPF_MAX_INSN_SIZE) {
 			pr_err("bpf_jit: fatal insn size error\n");
@@ -4864,6 +4982,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		    is_atomic_fetch_op(insn))
 			prog->aux->num_exentries++;
 	}
+	for (i = 0; i < prog->len; i++)
+		if (unwind_site(env, prog, i))
+			prog->aux->num_exentries++;
 
 	addrs = kvmalloc_objs(*addrs, prog->len + 1);
 	if (!addrs)

