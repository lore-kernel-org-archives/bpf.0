Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165B396D03
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605406; cv=none; b=tfyAuz7RwC/3Jf/wCxYHZoIlOhhqoj7J3q08+wv3HRn0D8MLRmQLFat2TPrf11JWtBeP9rScV9Dg3rnn0DRo+lon9BjhzrG8BplIze1ROoXTM6jEJ8xx7dkHdf/IBSDlO0hrEPT3eqs1MHR6YF2YeBdNZjfuhGV2SDHNJYmF8vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605406; c=relaxed/simple;
	bh=1v5rp3W57K17ygDrNERaeot+6bSef/RUT93zVNZDe8A=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovcDhSRi4Xiu2ti9yskXRplNGjXFXNXsuZTTomPp/H2/Q1Vxql60GJQRcoL7TnyBv5P5QT0+o/HmmyyHAYHmgEGrhxYdPMoxSkkPyu2EN5UeXwFWH01TxZfjqvafcHZ7TxsA2ZYE49KzPJ/+1cqDOSCq0NvQRKMdIQc1KOcgs4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/yacGo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/yacGo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EF51F00893
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605404;
	bh=/9fbsMCsMGod3jMNpuor3cjopoJqn4hHYjTdk5fNnFQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=S/yacGo+a7Hs2MVXYarV5VhL+9szK/U8EP8/coRXJE4m9M/D/NlFvLDkSz4tHdzgB
	 CpqiQ8t2CKTOVE+jnHtxREMM8ZJ1uUefMDhkHYW4Zk0qjETp/SBJuq0xBpxAziqazk
	 cyyPJYOeh4qQBhTCaZDJbgT3NKQGYjq5wgPClskN8A6jsJ46vm4F+BD4btUJq6W4tf
	 HZ4X/acaBygJyaasN8v7RztN/Ty8ra15SK/tNMal3C3mogxBgbt1OyNYsdZUVLtqfo
	 JwdqwKJPuI2y0vjGf6ilSwHqd66G2tAT0i6aAONyK+dhPHo7DE1JtpCcwFbJlKr2G0
	 PmMJJQ26ZchqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/8] bpf: mark instructions accessing
 program stack
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604-kasan-v2-1-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-1-c066e627fda8@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:36:44 +0000
Message-Id: <20260604203644.81EF51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Patched instructions incorrectly lose their `non_stack_access` mar=
king, causing JITs to erroneously skip KASAN instrumentation for actual mem=
ory accesses.
- [Medium] Out-of-bounds pointer arithmetic in `bpf_insn_accesses_stack_onl=
y` when JIT compiling eBPF subprograms.
--

commit ae20410c7f06315eaa729fac3ff9e9abfe3062e2
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf: mark instructions accessing program stack

This patch introduces functionality to mark BPF instructions that access the
program stack. The verifier tracks non-stack memory accesses, allowing JIT
compilers to skip emitting KASAN instrumentation for stack accesses while
enforcing it for other memory types.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index a656a8572bdbe..393d9eacd2156 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1583,6 +1583,22 @@ bool bpf_insn_is_indirect_target(const struct bpf_=
verifier_env *env, const struc
>  	return env->insn_aux_data[insn_idx].indirect_target;
>  }
> =20
> +bool bpf_insn_accesses_stack_only(const struct bpf_verifier_env *env,
> +				  const struct bpf_prog *prog, int insn_idx)
> +{
> +	struct bpf_insn *insn;
> +
> +	/* cBPF: we have no verifier state, do a best-effort check based on
> +	 * dst/src reg
> +	 */
> +	insn_idx +=3D prog->aux->subprog_start;
> +	insn =3D (struct bpf_insn *)prog->insnsi + insn_idx;
> +	if (!env)

[Severity: Medium]
When JIT compiling an eBPF subprogram, prog points to the subprogram and
prog->insnsi only spans the subprogram's instructions. By adding
prog->aux->subprog_start to insn_idx, doesn't this result in an
out-of-bounds pointer arithmetic for insn?

Even though the pointer is not dereferenced here because of the if (!env)
check, could this trigger UBSAN bounds-checking traps? Should the insn
pointer calculation be deferred until inside the !env block where it is
genuinely needed for cBPF?

> +		return insn->dst_reg =3D=3D BPF_REG_FP ||
> +		       insn->src_reg =3D=3D BPF_REG_FP;
> +	return !env->insn_aux_data[insn_idx].non_stack_access;
> +}
> +

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 5aa3f7d99ac92..5228c910fbf56 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -185,16 +185,22 @@ static void adjust_insn_aux_data(struct bpf_verifie=
r_env *env,
[ ... ]
>  	if (data[off + cnt - 1].indirect_target) {
>  		data[off].indirect_target =3D 1;
>  		data[off + cnt - 1].indirect_target =3D 0;
>  	}
> +
> +	if (data[off + cnt - 1].non_stack_access) {
> +		data[off].non_stack_access =3D 1;
> +		data[off + cnt - 1].non_stack_access =3D 0;
> +	}

[Severity: High]
When bpf_patch_insn_data() expands a single instruction into multiple
instructions, this logic restricts the non_stack_access flag to only the
first instruction of the patched sequence and clears it for the rest.

Since the actual memory load or store in a patched sequence often occurs on
subsequent instructions rather than the first, wouldn't they lose this flag
and incorrectly bypass KASAN checks during JIT compilation?

>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-kasan-v2-0=
-c066e627fda8@bootlin.com?part=3D1
