Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55540415B74;
	Fri, 25 Sep 2026 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333265; cv=none; b=i/vqCxAf8EoMf8uk2Ky5BNMqOYuaQW7v2AiXsxDD1f/P35rzjOat1OqIWsO+jOTDL2kY1HBRpS4ozc6QxbrQHXAjdfu07Div6cN+UUTVPLfL2f/p841b6qP9mn1+lvG/l1zaEwAot4isOUlDh9T96/WaWZIDtnj6leArtnFPeWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333265; c=relaxed/simple;
	bh=LyEuHn3KlnwjqulSbH5iaFMsT09cxLqyu4HXzyEfwKk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NeKOXzqxDfr0QN+dsDNFsqoj5ImQQ7PHqrD9H/fnoRGsZuv6B2nI337ytcoZI+WugvI+M7xTDo80JCejfCLajLtwjOZ9uL1yTrJ7xOYdSpMk0059jBHyY3+TQu+ATR8sk+PaZGPJgyT4ZWWOs1JjVkWDtGbyaEOOqQYRXF1nvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io148/FX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io148/FX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26411F00893;
	Fri, 25 Sep 2026 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790333258;
	bh=/jLPdO6eY2hzlCipnlYSCZ1sblhtsGU4F3/zuZzdHas=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=io148/FXwJcBjqLBbjfo5s9CtCjo3WAtM3WFMCwdmVdYgnIuFvqYtuJru28w8z2ZC
	 wx1uKr91ywU1UryTEzWyO7DV5g/LG2Y/4w52O4QGeY6EIQW57L+qbHtgcMYOY/jKtc
	 YbE3JxPVdAbNjNwqfhtN0oWdSObQrKXazngAnwyQsln4cLwPNyJbjmOquj8TFbg0dE
	 K+Vh6PQ6UQP9VCLdxKVixAciJyFKjN/M8aThCohi79fzdYY/GdXomKu85q1uNTgq9a
	 xMtMfT6z5FYyXwKhfYQCxRaJoZTO8Xyk5DOfN8h2Ch7lJbv18sJAJ275YYkEeLXhyV
	 r8MDLkD5HAMkA==
Content-Type: multipart/mixed; boundary="===============8050495519131120412=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6a6d43e6bada7a1433cd525c9ec31780ed9b2401c8834894defdf671601b2f1d@mail.kernel.org>
In-Reply-To: <20260925100342.481242-3-florent.revest@linux.dev>
References: <20260925100342.481242-3-florent.revest@linux.dev>
Subject: Re: [PATCH bpf v4 2/3] bpf: Skip detached progs in trampoline images that are still in use
From: bot+bpf-ci@kernel.org
To: florent.revest@linux.dev,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: florent.revest@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,john.fastabend@gmail.com,leon.hwang@linux.dev,zirajs7@gmail.com,rhkrqnwk98@gmail.com,puranjay@kernel.org,xukuohai@huaweicloud.com,iii@linux.ibm.com,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,bjorn@kernel.org,pulehui@huawei.com,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 10:47:34 +0000 (UTC)

--===============8050495519131120412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index c5f55d6161fe..bd73179c00ec 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -2431,6 +2432,10 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *node,
>  	enter_prog = (u64)bpf_trampoline_enter(p);
>  	exit_prog = (u64)bpf_trampoline_exit(p);
>
> +	/* nop, patched to skip this prog when it is detached */
> +	skip = ctx->ro_image + ctx->idx;
> +	emit(A64_NOP, ctx);
> +

Is a context synchronization event needed on the other CPUs after the skip
NOP is patched?

A subsystem pattern flags this as potentially concerning: the new per-prog
NOP becomes a B when the prog is detached. bpf_trampoline_skip_prog() ->
bpf_arch_text_poke() -> aarch64_insn_patch_text_nosync() does:

    ret = aarch64_insn_write(tp, insn);
    if (ret == 0)
        caches_clean_inval_pou((uintptr_t)tp,
                               (uintptr_t)tp + AARCH64_INSN_SIZE);

Nothing forces an isb or exception on the other CPUs. Jump label patching
of the same NOP<->B kind does this through
arch_jump_label_transform_apply() -> kick_all_cpus_sync().

The new site is a correctness point: after the detach, the trampoline
relies on this jump so that a task still in the image does not call into
the prog, which is freed after the grace periods. A CPU that has not taken
a CSE may still execute the old NOP and call the prog.

The existing comment in bpf_arch_text_poke() justifies the missing sync
only for trampoline images, by pointing at bpf_tramp_image_put(). It does
not cover the progs called from a live image.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 4da278900938..df8abfa055d1 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c

[ ... ]

> @@ -1696,13 +1696,19 @@ static void restore_stk_args(struct jit_ctx *ctx, int nr_stk_args, int args_off,
>  	}
>  }
>
> -static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *n,
> -			   int args_off, int retval_off, int run_ctx_off, bool save_ret)
> +static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image *im,
> +			   struct bpf_tramp_node *n, int args_off, int retval_off,
> +			   int run_ctx_off, bool save_ret)
>  {
> -	int ret;
> +	int i, ret;
>  	u32 *branch;
>  	struct bpf_prog *p = n->link->prog;
>  	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
> +	void *skip = ctx->ro_image + ctx->idx;
> +
> +	/* nops for move_imm+jirl, patched to skip this prog when it is detached */
> +	for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> +		emit_insn(ctx, nop);

Can a task preempted inside the skip sled resume into half of the new jump
sequence and jump to a garbage address?

The skip site is a 5-instruction nop sled. bpf_trampoline_skip_prog() turns
it into a multi-instruction sequence with bpf_arch_text_poke(skip->nop,
BPF_MOD_NOP, BPF_MOD_JUMP, NULL, skip->target). That call goes through
emit_jump_or_nops() -> move_imm(T1, target) + 'jirl zero, t1, 0' and
writes the result with:

    ret = larch_insn_text_copy(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES);

This runs on detach, while the current image and any older images still on
tr->images are live. Every call of the traced function runs through the
sled. larch_insn_text_copy() uses stop_machine_cpuslocked(), which only
parks CPUs that are running. It cannot help a task that was preempted
between two sled instructions.

The trampoline does not disable preemption before __bpf_prog_enter*(). With
CONFIG_PREEMPT, PREEMPT_LAZY (ARCH_HAS_PREEMPT_LAZY is selected in
arch/loongarch/Kconfig) or PREEMPT_RT, waking the stopper thread preempts
whatever is running on each CPU at IPI return. That includes a task that
has executed only some of the nops.

Concrete path:

  CPU0 (task A): traced func -> trampoline -> sled nop0, nop1
                 | IPI, preempted
  CPU1: bpf_link release -> bpf_trampoline_remove_prog()
        -> bpf_trampoline_skip_prog() -> bpf_arch_text_poke()
        -> larch_insn_text_copy() writes
           lu12i.w t1 / ori t1 / lu32i.d t1 / jirl zero,t1,0 / nop
  CPU0: A resumes at sled+8 and executes 'lu32i.d t1; jirl zero, t1, 0'

Bits 31:0 of t1 still hold whatever the register contained before, for
example a value left behind by the previous prog's __bpf_prog_exit call.
The indirect jump goes to an arbitrary kernel address, causing an oops or
running unintended code.

Before this change, only the prog-entry sled and ip_after_call had this
5-instruction live poke. fentry-only trampolines had no patched site inside
the image at all. Now every detach patches one sled per image on the
hottest path. The x86, arm64 and s390 skip sites are patched with a single
atomic instruction change, so they don't have this problem.

Could the LoongArch skip site use a single instruction instead? For
example, a 'b' to the skip target, which is always within the +/-128MB
range of the same image, patched from nop to 'b'. The rest of the sled
would then be unnecessary.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 9d69c066a817..ea8e67a38919 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -1246,11 +1289,8 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
>  		if (WARN_ON_ONCE(!hlist_empty(&tr->progs_hlist[i])))
>  			goto out;
>
> -	/* This code will be executed even when the last bpf_tramp_image
> -	 * is alive. All progs are detached from the trampoline and the
> -	 * trampoline image is patched with jmp into epilogue to skip
> -	 * fexit progs. The fentry-only trampoline will be freed via
> -	 * multiple rcu callbacks.
> +	/* All progs are detached and the last image has been freed, images
> +	 * hold a reference on the trampoline until then.
>  	 */

This isn't a bug, but the rewritten comment puts its text on the same line
as the opening /*:

	/* All progs are detached and the last image has been freed, images
	 * hold a reference on the trampoline until then.
	 */

The BPF subsystem's comment style asks for the opening /* of a multi-line
comment to be on its own line in kernel/bpf/, even where nearby code still
uses the old style. The patch replaces this comment's text, so the line
counts as modified. The other new multi-line comment in this file, above
bpf_trampoline_skip_prog(), already uses the preferred style. The same
comment in that style would be:

	/*
	 * All progs are detached and the last image has been freed, images
	 * hold a reference on the trampoline until then.
	 */


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36122863248
--===============8050495519131120412==--
