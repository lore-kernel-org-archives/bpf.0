Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708623E3156
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420006; cv=none; b=d2I4CkAV0KEN7/uQMP/x+ovryatcqyIv/FjKm+L+cnFMYAJP4zH3sUfGPfp3+OeHrgQV24wEhxfFY0AYMms7VhdkiuAXPCe2jcvjm4K/tFvIFcMlYDQAgAAmsywE0tlRg97QGK8ByFU5MBHzCvt5LWmjWL9kDWPVOWCtY+kYBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420006; c=relaxed/simple;
	bh=P1kj2Vu9P6SS/tz4jR8CTq+OuE/6c25550Plw4ezev8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dgz2t1lIOeQukC1PPwC8SNQ8MZyFpl4HvrkIg6mRZaVJTmfB3vXTXSp4K3oq1XPG5U1XeUYh/9c0cNW4EzYsSasOYcsyE8X7AJ4IUPN8qe+wdLmNqU1QHaBrCNXqG4yQgZNTSZmXc4tNI1FGNKqyJqqGq+yAawmuXtiIQGKjlas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwpsdCrR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwpsdCrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF191F000E9;
	Tue,  7 Jul 2026 10:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420002;
	bh=a0f9hz8Ifldd8xjWrGusqUs6TmOISZbp3uDW/b4eJGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jwpsdCrRXXObSa5gkpW6gaHYQF/j8erUi2k4SabJOU3qd8sa1hUmNE2Zg5xzmYx/O
	 oIUa+rFgQhD6jg3snKsgWjLcqw+RseIPDJxv/LT0Wdi7Gb9yhP9MGqX+AX5aYG94eS
	 tlHMss7J+eb5TGOsCeKyHxmmTzLO2BP1csCc7TAt+DH9MV8VG+8MHX3Iof7mVh6Cb/
	 jfm+/H0Z4O7/kN0pJfYPxtioYhsWuW70lTagIE7LuXPXxzwKVDhRvKjw9T1IPfeBPM
	 k7vSR9fncd+VHzmNmWLI0v4BbmNO+cGpRxTPLNalORZOPC82vyUm89YuPGvVujsrVq
	 zerTMQaCnn2VQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] LoongArch: BPF: Optimize redundant TCC loads in
 epilogue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260707101508.32283-2-yangtiezhu@loongson.cn>
References: <20260707101508.32283-1-yangtiezhu@loongson.cn>
 <20260707101508.32283-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:26:42 +0000
Message-Id: <20260707102642.AEF191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The macro BPF_TAIL_CALL_CNT_PTR_STACK_OFF does not account for the=
 BPF Arena register, leading to an incorrect stack offset calculation and a=
 deterministic kernel panic on tail calls when arena is used.
--

--- Patch [1]: [PATCH v3 1/4] LoongArch: BPF: Optimize redundant TCC loads =
in epilogue ---
commit eabfba52164a1855119336bb138d22f9f54aedfe
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

    LoongArch: BPF: Optimize redundant TCC loads in epilogue
   =20
    The legacy epilogue implementation pops the tail call counter (TCC)
    context via a redundant double-load pattern. It first decrements the
    load_offset by 2 slots to fetch 'tcc_ptr', and then immediately bumps
    it back up by 1 slot to load the original 'tcc' value into REG_TCC,
    unnecessarily overwriting the register.
   =20
    Optimize this sequence by adjusting the load_offset by only 1 slot.
    This aligns the offset directly with the higher stack slot containing
    the entry TCC counter (or caller state), allowing us to restore the
    REG_TCC register safely with a single load.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 2738b4db11653..93a1813122564 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -246,14 +246,8 @@ static void __build_epilogue(struct jit_ctx *ctx, bo=
ol is_tail_call)
>  		emit_insn(ctx, ldd, REG_ARENA, LOONGARCH_GPR_SP, load_offset);
>  	}
> =20
> -	/*
> -	 * When push into the stack, follow the order of tcc then tcc_ptr.
> -	 * When pop from the stack, first pop tcc_ptr then followed by tcc.
> -	 */
> -	load_offset -=3D 2 * sizeof(long);
> -	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
> -
> -	load_offset +=3D sizeof(long);
> +	/* Only restore the TCC state into REG_TCC from the higher slot */
> +	load_offset -=3D sizeof(long);
>  	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the dynamic
stack offset handling for REG_ARENA here, I noticed an issue in how the sta=
ck
offset is calculated for the tail call counter pointer.

While the prologue and epilogue dynamically adjust load_offset for REG_ARENA
(shifting the offsets down by 8 bytes when ctx->arena_vm_start is true),
the macro BPF_TAIL_CALL_CNT_PTR_STACK_OFF uses a hardcoded subtraction:

arch/loongarch/net/bpf_jit.c:
#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)

When a BPF program using the BPF arena makes a tail call, emit_bpf_tail_cal=
l()
uses this macro to calculate tcc_ptr_off:

arch/loongarch/net/bpf_jit.c:emit_bpf_tail_call() {
    ...
    int tcc_ptr_off =3D BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
    ...
    emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
    emit_insn(ctx, ldd, t3, REG_TCC, 0);
    ...
}

Because the hardcoded macro doesn't account for the 8-byte shift from
REG_ARENA, it will evaluate to the offset of the integer tail call count (t=
cc)
instead of tcc_ptr.

Could this lead to the JIT loading the integer count (often 0) into REG_TCC
and dereferencing it as a pointer, resulting in a kernel panic?

> =20
>  	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707101508.3228=
3-1-yangtiezhu@loongson.cn?part=3D1
