Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275B3BD635;
	Tue, 15 Sep 2026 03:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789441964; cv=none; b=X0ayv6h+2g/T3udWeP/xFot47TeYokF6iEtCcnj6SIRNeFQ71oDOG4s0HedP3ENYiVKo+Sl2m2uKIGUIX5ngsfwR1aD/IjM0pMQ2twaLocYjs3+Y1dwZ+IxAfmM+TIEsbHeV4c2fTQ8U8/+AswvFpy2MPyZu8TeKRbifkFa0xTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789441964; c=relaxed/simple;
	bh=q5QXWd4boEAkOUTWeXX/mOi8bo/fIUiGcY7d/k7+0Ic=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GR8bSOr+nIAtjWxiB4QjrbBklw5hHfIJCJYWb9aTMwnNs3EqKbTwXr5kvuYpNQRGuMY3Y3fr1bdGlWu1SytoFSEu0Y5RlkgP2MK8OilalKAu7MApgXZdZrsviQaAI23Uy9QeYzFe7JMTIhv8vCe74FIRHurcBbCIA1LVKlvq74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU3jTeIn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU3jTeIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0301F00893;
	Tue, 15 Sep 2026 03:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789441962;
	bh=+Zl47g2R6o1OVLSTyzoYesvANcsvAS9tSGsX9FLPppU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AU3jTeInrqdrNYPaeaJpBxGz5rn/B40ECequ2GAivV0sHA9Htj11LDbW/5T+5UAWw
	 +eFNLC+N6UPDIRTSj7lxAbCZsYIVzUw03k7Ft4HCeyS2cqoCbfP3JOmjbMlyH/2+vh
	 gPRrhZujUzW3zTjh7M6XXv+vLLMBw9jwh7xbgRJ5SBTwudYthvAKJ2yBpkKvLRefOT
	 wu7wrprgW5U9SvxuE/pThf1fDWg1PI7nfD+x5z6QykmLtrYhGVPd8DrMcpm0AoAxok
	 ITHAZRfOMsOXKr0px+YjUh9fFHpiqnDKQ9fZXcFLd4TvbIi7ejr8c5fFIiShKlTkI7
	 00ejRlWEP/S0A==
Content-Type: multipart/mixed; boundary="===============5992561744920142260=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <985634fd50a8b724077daae136d12c432f2f306e59b8bd5e730678aad10eb4f6@mail.kernel.org>
In-Reply-To: <20260915021338.1520964-2-main.kalliope@gmail.com>
References: <20260915021338.1520964-2-main.kalliope@gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf, x86: Add support for BPF_MOVSX in the i386 JIT
From: bot+bpf-ci@kernel.org
To: main.kalliope@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,udknight@gmail.com,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,hpa@zytor.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,visitorckw@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 03:12:41 +0000 (UTC)

--===============5992561744920142260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf, x86: Add support for BPF_MOVSX in the i386 JIT
>
>     The i386 JIT lowers register BPF_MOVSX as an ordinary move because
>     do_jit() does not inspect insn->off. The generated code therefore copies
>     the source instead of sign-extending the selected low bits. Context-access
>     conversion can also introduce MOVSX while lowering signed loads, so
>     rejecting BPF_MEMSX does not protect those paths.
>
>     Stage the source low word in EAX and use the native byte and word
>     sign-extension instructions. Derive the high word from the sign bit for
>     ALU64 and retain verifier-managed zero extension for ALU32.
>
>     Assisted-by: Codex:gpt-6
>     Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>

This looks like a bug fix for MOVSX support that was added to x86_64 but
not i386. Should this include:

  Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")

> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
> index 852baf2e4db4d..9cbeabac4f27f 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -266,6 +266,51 @@ static inline void emit_ia32_mov_r64(const bool is64, const u8 dst[],
>  		emit_ia32_mov_i(dst_hi, 0, dstk, pprog);
>  }
>
> +/* dst = sign_extend(src, insn->off) */
> +static inline void emit_ia32_movsx_r64(const struct bpf_insn *insn, u8 **pprog,
> +				       const struct bpf_prog_aux *aux)
> +{
> +	const u8 *dst = bpf2ia32[insn->dst_reg];
> +	const u8 *src = bpf2ia32[insn->src_reg];
> +	bool dstk = insn->dst_reg != BPF_REG_AX;
> +	bool sstk = insn->src_reg != BPF_REG_AX;
> +	bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;

This isn't a bug, but would it read more consistently with the
neighbouring emitters to pass is64/dst/src/dstk/sstk as parameters?

Looking at the other ALU emitters in this file, they take the
already-decoded operands directly:

  emit_ia32_mov_r64(is64, dst, src, dstk, sstk, pprog, aux)
  emit_ia32_alu_r64(...)
  emit_ia32_mul_r64(...)

The new helper re-derives these five values from insn, even though
do_jit already has them in scope at the call site (lines 1719-1724).
The insn->off validation also happens twice: once in the do_jit gate
and again in the helper's switch.

> +	u8 *prog = *pprog;
> +	int cnt = 0;
> +
> +	if (sstk)
> +		/* mov eax,dword ptr [ebp+off] */
> +		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
> +		      STACK_VAR(src_lo));
> +	else
> +		/* mov eax,src_lo */
> +		EMIT2(0x89, add_2reg(0xC0, IA32_EAX, src_lo));
> +
> +	switch (insn->off) {
> +	case 8:
> +		/* movsx eax,al */
> +		EMIT3(0x0F, 0xBE, 0xC0);
> +		break;
> +	case 16:
> +		/* movsx eax,ax */
> +		EMIT3(0x0F, 0xBF, 0xC0);
> +		break;
> +	case 32:
> +		/* EAX already holds the low word; CDQ supplies the high word. */
> +		break;
> +	}
> +
> +	emit_ia32_mov_r(dst_lo, IA32_EAX, dstk, false, &prog);
> +	if (is64) {
> +		EMIT1(0x99); /* cdq */
> +		emit_ia32_mov_r(dst_hi, IA32_EDX, dstk, false, &prog);
> +	} else if (!aux->verifier_zext) {
> +		emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
> +	}
> +
> +	*pprog = prog;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34921540254
--===============5992561744920142260==--
