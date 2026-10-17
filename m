Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE81F3D7D8E;
	Sat, 17 Oct 2026 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792235864; cv=none; b=eEQg1vyxAt09J8hZOeCB4MwK3fpe+VJnU2+L53UtwqVfb5LmsgmeTnGIIPTTqaRz4JkY2OTPirhg7win4L1LcHStoAuSnKP0b0KpL0otOmZhhOSfyqlm3lfE3NjJTkIzPdZAZ9M8mVUWDBhAixZPMTC2FqUO6J+8lOf92CITSGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792235864; c=relaxed/simple;
	bh=k3FM22zDkHap+N8F3RxBrHgRtYpGz4dK3UkG79DhDcs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dMkFHxfmcf+WFWqPKufi14fWQrCmlO6p+FMzsbzqqHYhP7yPviGRwvYRbzomjgZiaoDQ6A43Eah689+QhDJCXk8Rp+aQWSoLh1+t2qey5tpsFD4lBM5Kn/7aKZk11I4ktNv7YNLla9n43Jhmum5YHvpqGV7Rwgn5hDQpP5TgQhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCMZdBIB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCMZdBIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238B61F000C4;
	Sat, 17 Oct 2026 11:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792235862;
	bh=pPMe2Opo6fjDewIKn7ke9cdwpVzZnQOrXf6ccSI+AEo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CCMZdBIBDfXhLaLV1szk2DRzBsAklMKhxXe0OVfay02waqgENJv2J6lf9jNn/Qqke
	 vhPng4jxrua5FpzHXUWz0BvwLjaScX4FzHyjOjtwgB76/l0+NQgXzsGJKUss21ax4Y
	 ed60fIqSKQJJd6SItB0TxDmtiD6v14puYRJmX2d71nDLIWabKf/d+4Ds6QkjQZhio3
	 unYIzoKjKMwnFUrvMsMdUrj6vvGwpqIlblI12ECq3SB9aFwOK5mmj7FrGSxIyAl43t
	 ULz7GoO6ulRI2ZLLghoWAWCV+yhFcVrFCN/we7e6DQIx2LpNRFd4lQVDWpDo6hCuqa
	 XU4ru3ILxwygg==
Content-Type: multipart/mixed; boundary="===============2532615691938715252=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f31fe652948105d0fc4887a00ab8b883e3dea4693f4a9428bbbfe2a1301ac347@mail.kernel.org>
In-Reply-To: <20261017105128.18537-1-yangtiezhu@loongson.cn>
References: <20261017105128.18537-1-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2] LoongArch: BPF: Fix stack arguments for indirect trampolines
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com,memxor@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 11:17:41 +0000 (UTC)

--===============2532615691938715252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> LoongArch: BPF: Fix stack arguments for indirect trampolines

TL;DR: Nits only: the new store_args() comment in the LoongArch trampoline
names the wrong slots (T0/FP of traced function rather than parent RA/FP
skipped by FP + 16), and there's a stray blank line.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index e78eb582c300..37c51488fc8f 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1674,17 +1674,23 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
>  	return ret;
>  }
>  
> -static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off)
> +static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off, bool is_struct_ops)
>  {
> +

This isn't a bug, but is the blank line right after the opening brace of
store_args() intended?

> +	/*
> +	 * Regular fentry trampolines need to skip the 16-byte saved T0 and FP
> +	 * slots of the traced function. Indirect struct_ops trampolines place
> +	 * incoming stack arguments directly at FP.
> +	 */
> +	int stack_args_off = is_struct_ops ? 0 : 16;

The new comment says the fentry path skips "the 16-byte saved T0 and FP
slots of the traced function".  Are those the slots that FP + 16 steps
over?

In __arch_prepare_bpf_trampoline() the fentry prologue is:

    /* RA and FP for parent function */
    emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -16);
    emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
    emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
    emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 16);

    /* RA and FP for traced function */
    emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_size);
    emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
    emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
    emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size);

If E is the SP at trampoline entry, the final FP is E - 16, so the bytes
skipped by FP + 16, [FP + 0, FP + 16), are the RA and entry FP stored by
the first block, which the code labels "RA and FP for parent function".
The frame layout diagram at the top of the function also places them at
FP + 8 "[ RA to parent func ]" and FP + 0 "[ FP of parent func ]".

The T0 and FP of the traced function are stored by the second block at
FP - 8 and FP - 16, below FP, so a positive offset from FP never reaches
them.

Could the comment name the right slots, for example "skip the 16-byte
RA/FP frame record saved for the parent function"?  The old one-line
comment ("Skip slots for T0 and FP of traced function") used the same
wording, but this patch rewrites and expands it.  The commit message's
"after accounting for the saved parent and traced-function frames" is
closer to what the code does.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39026938538
--===============2532615691938715252==--
