Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88CC285CB9;
	Tue, 15 Sep 2026 03:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789441957; cv=none; b=VCdGz5j3+yKJvSC3LZZbVNPCbtLnq6qzs1YtFwbHcCcpo4103avO2rrMLrfOhkVujmymrmz8gLWmbRNvvQfMTrHjrROJXhublCmuCFM20Fu+3pUqxtqA4rCV5xrR8p1NpycqJuVLI0v56xENQcUpTREPNx3V84g4tLvj7Mq+vLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789441957; c=relaxed/simple;
	bh=BkrX7tCyHaZRn2p5slHgrnDv4Q5l86TmPGLNEBQy+vg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K3prBmFd4lHKQqIbr0AEoxNuJlMGfuLNZ2u9hjPyi/qDzgF+j2aPSBJCaxk5OXyvTxArAqcIvJO0KMtj1TNihK5he0O0DD2uPOK9YYV+kEePrrGaq7Kdo9NKyk3TCClGEiR9gFeYwLIDvzj+WEMgEzh8m0R3/Yylee49W76abss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWNV1MqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWNV1MqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032DF1F000FF;
	Tue, 15 Sep 2026 03:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789441955;
	bh=mJCrBbO/pVUgOy4/TQl5VYILy3tqiITtuJ+pm8NrVuE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PWNV1MqLO/NphqGblfk4DjktMfbmYdK/UGI3KqvDLmmp9geDWAZ+YRiR3sPVTJYYI
	 mb2ZiDbqW9RIXlt0/OrQAQSLJIK5J9W/VKyTERbcZqmcL4rY+Cy1N6wmXRCzXzs7/G
	 UXftInyUk5Qwh9XDTZ7oMS3C4ji4VfSQXsOx1bZW+XO4A5SwgJilmLOC/rH0FmGsD7
	 EVxA28ZC7/A1ERxWh8nt+Yh2nqlxsD7ikEgDrYBLFRL0YUnAtvRfCfMBp9va8XVkDP
	 aFbVFJ6YtJ7xBBxAaea7+kgN7trqzqhqCH//UZ0pQujhl3A3qgMgOQjlROyI7Q5OQi
	 HDkJGKOXXNzZw==
Content-Type: multipart/mixed; boundary="===============7247730682841356413=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <53eafa0eb20cf72bbfbd0e94fb7771a160d90de18bd8d3e21b7278f0bab149f5@mail.kernel.org>
In-Reply-To: <20260915021338.1520964-3-main.kalliope@gmail.com>
References: <20260915021338.1520964-3-main.kalliope@gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf, x86: Extract the i386 JIT load emitter
From: bot+bpf-ci@kernel.org
To: main.kalliope@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,udknight@gmail.com,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,hpa@zytor.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,visitorckw@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 03:12:33 +0000 (UTC)

--===============7247730682841356413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, x86: Extract the i386 JIT load emitter
>
> Move ordinary LDX lowering into an instruction-owned helper. Keep address
> staging, displacement encoding and register-pair completion together,
> including verifier-managed zero extension for narrow loads.
>
> Use the helper for the existing BPF_MEM cases before adding signed loads.
> This separates the code movement from the MEMSX instruction handling.
> The emitted instructions are preserved.

This isn't a bug, but could the middle paragraph be trimmed?  It
enumerates what the moved block contains rather than adding rationale
beyond what the diff already shows.  Would it read more clearly if the
changelog led with why the helper is being split out ahead of the MEMSX
patch, and used "No functional change intended" instead of "The emitted
instructions are preserved"?

> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
> index 9cbeabac4f27f..6839c233cb734 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c

[ ... ]

> @@ -1214,6 +1214,89 @@ static inline void emit_ia32_mul_i64(const u8 dst[], const u32 val,
>  	*pprog = prog;
>  }
>
> +static void emit_ia32_ldx(const struct bpf_insn *insn, u8 **pprog,
> +			  const struct bpf_prog_aux *aux)
> +{
> +	const u8 *dst = bpf2ia32[insn->dst_reg];
> +	const u8 *src = bpf2ia32[insn->src_reg];
> +	bool dstk = insn->dst_reg != BPF_REG_AX;
> +	bool sstk = insn->src_reg != BPF_REG_AX;
> +	u8 *prog = *pprog;
> +	int cnt = 0;
> +
> +	/* Stage the address in EAX; dst may alias src. */
> +	if (sstk)
> +		/* mov eax,dword ptr [ebp+off] */
> +		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
> +		      STACK_VAR(src_lo));
> +	else
> +		/* mov eax,src_lo */
> +		EMIT2(0x8B, add_2reg(0xC0, src_lo, IA32_EAX));
> +
> +	switch (BPF_SIZE(insn->code)) {
> +	case BPF_B:
> +		/* movzx edx,byte ptr [eax+off] */
> +		EMIT2(0x0F, 0xB6);
> +		break;
> +	case BPF_H:
> +		/* movzx edx,word ptr [eax+off] */
> +		EMIT2(0x0F, 0xB7);
> +		break;
> +	case BPF_W:
> +	case BPF_DW:
> +		/* mov edx,dword ptr [eax+off] */
> +		EMIT1(0x8B);
> +		break;
> +	}

This isn't a bug, but since the patch is meant to be a pure move, would
it read more easily as a verbatim move plus a separate follow-up for the
cosmetic changes?  The moved block is reworked here: the three case arms
are reflowed from the original one-line form, EMIT(0x8B, 1) becomes
EMIT1(0x8B), several EMITs gain new mnemonic comments, and the
pre-existing comment is corrected from "mov eax,dword ptr [ebp+off]" to
"mov eax,src_lo".  Each edit is an improvement, but folding them into
the movement makes "emission is unchanged" harder to confirm by reading
the diff.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34921540254
--===============7247730682841356413==--
