Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC61F78E6;
	Thu,  4 Jun 2026 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607598; cv=none; b=i8K/Puo/vp85o5kTwJtwYSP+GvEzQlnKaAmiD7e/SJmQ0IBfm+vnfm7HH+XQV+qhSN5yVMhZNuvxUrw+Gf5Je8IBaRS4HnwN9TmAXIgn3V6odLs/quC9GiPxp+FqmyAtbmO32aOqgjSE3676ewww4u3fbtCzq8LqaAac/fkAOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607598; c=relaxed/simple;
	bh=MWme06rMbiwCEkN6np194nZoNOXuAPJwN6T7MIcFDEQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=U8XEv34qXwJGZX1zVHZ1auQGmfftQr54AvkbmwuwuCzLuMIlLviVfPSHyA4RreBqi6juxj17sXsyphwN1o4zcVVxiiXLwFWVbqRBvZqFgyXInZWgpmDDqnFPvc34Wz+3LPPKDXYk6LOVvloCSnRMvPZaAt48hzFNh/fOy24xtTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiwgBurV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiwgBurV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26711F00893;
	Thu,  4 Jun 2026 21:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780607597;
	bh=MpZ3QvNzyLq6MCDStBRoFi5pI56pBgPE12+T/xtOUmg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DiwgBurVitMzJUb2m1D70814eZtSeLV6fzWGh1T2qAO3fIHYGN7fF6kO/SrAKQjvX
	 8KwBI4Slif3WPLWLLG+H0ocAbC5Bq1YGBsxs6YxCzrETQKxKe3rlGXXsTN/y3MXau+
	 F9BwpD8Quj3la/DeROcj+6ufk01ZCIBIe73AK/sNC8YmGSt76noC5is2RVBvBg/s8U
	 HZiKleQmM9wlj/qZeVAS0qg/RG32HNoU16vexEx2IEStUJnwoma57gmiVl+bLNTPib
	 +VTcLHOBALlAYOiKOypCREXI/to5P1Lw4xGpsPCy5b5Fr5o9uzIeOPVRuX9afv3Dz0
	 zydMNdGWcdnhA==
Content-Type: multipart/mixed; boundary="===============4379291998619388122=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0e5fcc7f26d096479c14eda3b51a238cecfdeff065ab6f33c50f71e54eee0ff0@mail.kernel.org>
In-Reply-To: <20260604-kasan-v2-1-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-1-c066e627fda8@bootlin.com>
Subject: Re: [PATCH bpf-next v2 1/8] bpf: mark instructions accessing program stack
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mcoquelin.stm32@gmail.com,alexandre.torgue@foss.st.com,ihor.solodrai@linux.dev
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-stm32@st-md-mailman.stormreply.com,linux-arm-kernel@lists.infradead.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 21:13:16 +0000 (UTC)

--===============4379291998619388122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index a656a8572bdb..393d9eacd215 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -1583,6 +1583,22 @@ bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struc
>  	return env->insn_aux_data[insn_idx].indirect_target;
>  }
>
> +bool bpf_insn_accesses_stack_only(const struct bpf_verifier_env *env,
> +				  const struct bpf_prog *prog, int insn_idx)
> +{
> +	struct bpf_insn *insn;
> +
> +	/* cBPF: we have no verifier state, do a best-effort check based on
> +	 * dst/src reg
> +	 */
> +	insn_idx += prog->aux->subprog_start;
> +	insn = (struct bpf_insn *)prog->insnsi + insn_idx;
> +	if (!env)
> +		return insn->dst_reg == BPF_REG_FP ||
> +		       insn->src_reg == BPF_REG_FP;
> +	return !env->insn_aux_data[insn_idx].non_stack_access;
> +}
> +

Sashiko bot raised a concern about this code in v2 review: When JIT
compiling an eBPF subprogram, prog points to the subprogram and
prog->insnsi only spans the subprogram's instructions.

By adding prog->aux->subprog_start to insn_idx, doesn't this result in
out-of-bounds pointer arithmetic for insn? Even though the pointer is not
dereferenced here because of the if (!env) check, could this trigger UBSAN
bounds-checking traps?

Should the insn pointer calculation be deferred until inside the !env block
where it is genuinely needed for cBPF?

Reference: https://lore.kernel.org/bpf/20260604203644.81EF51F00893@smtp.kernel.org/

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 5aa3f7d99ac9..5228c910fbf5 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -185,16 +185,22 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>  	}
>
>  	/*
> -	 * The indirect_target flag of the original instruction was moved to the last of the
> -	 * new instructions by the above memmove and memset, but the indirect jump target is
> -	 * actually the first instruction, so move it back. This also matches with the behavior
> -	 * of bpf_insn_array_adjust(), which preserves xlated_off to point to the first new
> -	 * instruction.
> +	 * The indirect_target and non_stack_access flags of the original
> +	 * instruction were moved to the last of the new instructions by the
> +	 * above memmove and memset, but those actually match the first
> +	 * instruction, so move them back. This also matches with the behavior
> +	 * of bpf_insn_array_adjust(), which preserves xlated_off to point to
> +	 * the first new instruction.
>  	 */
>  	if (data[off + cnt - 1].indirect_target) {
>  		data[off].indirect_target = 1;
>  		data[off + cnt - 1].indirect_target = 0;
>  	}
> +
> +	if (data[off + cnt - 1].non_stack_access) {
> +		data[off].non_stack_access = 1;
> +		data[off + cnt - 1].non_stack_access = 0;
> +	}
>  }

Sashiko bot raised a concern about this logic in v2 review: When
bpf_patch_insn_data() expands a single instruction into multiple
instructions, this logic restricts the non_stack_access flag to only the
first instruction of the patched sequence and clears it for the rest.

Since the actual memory load or store in a patched sequence often occurs on
subsequent instructions rather than the first, wouldn't they lose this flag
and incorrectly bypass KASAN checks during JIT compilation?

Reference: https://lore.kernel.org/bpf/20260604203644.81EF51F00893@smtp.kernel.org/



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26978380520
--===============4379291998619388122==--
