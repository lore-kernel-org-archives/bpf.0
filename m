Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23FF3093DD
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548110; cv=none; b=fbMD6voe6hr92nxx6MS95ab/Pg0uTzjrCKJDJx3LGTfYTD2KIZvT3gAoMRaP74ko1eip8xV0BkQtb3GRe+div4J8NrdWEcTNIZqKHJvDxDtWvnpVBMwoVo9sEPS7EinJXOE7MSvqTlkeq1riZWB9PMF+lvk3XmfB2cuvcehDjf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548110; c=relaxed/simple;
	bh=ZdVecc/pf8nrNJXn3qEW5LwqCsgev6TQIvVEngktD/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zyp7bHRz6grdiMcci/D9NNOEbInXvMtgE1EODJPNlYzaLEf3eW+JysIiU573F5NYEsgajnIlHgzkWCilhwglFi3PfuGZ+TMe6wJma1cYr457vmjnyL+dzYeUlqVZSSqHZIOwgCfsVfd1a0yvDpY5AguMDuJM2zKCPnEXT43NrQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ7Sm2Nm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ7Sm2Nm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C781F00AC4;
	Sat,  1 Aug 2026 01:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548109;
	bh=vuYo5/NZg2JYq6ekB52l1vreSvhhA2Q3LbOrFohhlhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EZ7Sm2NmKGNIwNsORtDx8yo9lIp8Bb+HyUDoVTLF6r+qWyWkq3cMe/vrnwojPm20N
	 OJiCrTeHYLBjIr5TJT3Nudrud/C6+tJiMM9QqxhsjlQO2jjmfbgNSIexoxSZqk1URo
	 pHV4KXu6zV22kDnNnOYc3pmw6sbYqMa3jnpd14hpUBGwLdK5IjhJO/ywZxFNksVrGh
	 ILFq4ouC1B6+ilmN4XsjuuBwLyzj8UX56gimI75OPCQ2bWA68t5rLMQLFq9BM3IZEv
	 stRnHkAmw43F8hHsKni1enwudEUQvk4TFMcYu2DjmNwtrm7wdw0J1FkLbCuD0/G+Uk
	 gOGXMHcK1rK9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/5] bpf: track upper 32-bit register
 halves' liveness in compute_live_registers()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731-static-zext-v2-2-da4aa161e8c5@gmail.com>
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
 <20260731-static-zext-v2-2-da4aa161e8c5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 01:35:08 +0000
Message-Id: <20260801013509.50C781F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Skipping zero-extension for 32-bit kfunc arguments causes ABI viol=
ations on architectures that require the caller to extend 32-bit parameters.
--

--- Patch [2]: [PATCH bpf-next v2 2/5] bpf: track upper 32-bit register hal=
ves' liveness in compute_live_registers() ---
commit 2a034896228b7579bf93bf8ae2024cee100ebcba
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: track upper 32-bit register halves' liveness in compute_live_registers=
()

This commit extends compute_live_registers() to track the upper and lower=20
register halves' liveness separately. It updates compute_insn_live_regs()=20
to track these bits and infers whether the upper half of a parameter=20
register is used by a kfunc call based on its BTF type size.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index ff1e68cc4bd1c..d0bd94c60fee2 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> +static u32 call_use_mask(struct bpf_verifier_env *env, struct bpf_insn *=
insn)
> +{
> +	u32 i, use, size, reg_params_num;
> +	struct bpf_call_summary cs;
> +	const struct btf_param *p;
> +	const struct btf_type *t;
> +
> +	if (!bpf_get_call_summary(env, insn, &cs))
> +		/* e.g. a bpf-to-bpf call, assume that calls use full 64-bit for each =
param */
> +		return mask_widen(ALL_CALLER_SAVED_REGS & ~BIT(BPF_REG_0));
> +
> +	if (cs.func_proto) {
> +		use =3D 0;
> +		p =3D btf_params(cs.func_proto);
> +		reg_params_num =3D min(btf_type_vlen(cs.func_proto), MAX_BPF_FUNC_REG_=
ARGS);
> +		for (i =3D 0; i < reg_params_num; i++) {
> +			t =3D btf_type_by_id(cs.btf, p[i].type);
> +			if (IS_ERR(btf_resolve_size(cs.btf, t, &size)))
> +				goto fallback;
> +			use |=3D size <=3D sizeof(u32) ? reg32_mask(i + 1) : reg64_mask(i + 1=
);

[Severity: High]
Does this break the C ABI on architectures that require the caller to
zero-extend or sign-extend 32-bit parameters passed in 64-bit registers?

By only marking the lower 32 bits as used for smaller parameters with
reg32_mask, the upper 32 bits are marked as dead before the kfunc call.
Consequently, the verifier computes zext_dst =3D false for the instruction
that previously defined the argument.

This causes the JIT to skip inserting a BPF_ZEXT_REG instruction to clear
the upper 32 bits on architectures where bpf_jit_needs_zext() is true,
such as s390x and PowerPC64.

If a BPF program computes a 32-bit value and passes it to a kfunc expecting
a 32-bit parameter, the kfunc might operate on garbage data in the upper
32 bits.

> +		}
> +		return use;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-static-zex=
t-v2-0-da4aa161e8c5@gmail.com?part=3D2
