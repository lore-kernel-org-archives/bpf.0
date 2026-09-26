Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EB033D6ED
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790434002; cv=none; b=Brs/lyZ9o9dM6thhZCW4NFDucXbE81Zh6Y9vcVhyRqlUP7Q78xjY558Z30iiiQnb9/ytahSil2KHNbNQSNCMfigddX8cVWQrl7LPwKKf/6u0G98qOORJX4vHItd955vgnTZNm6ExKSmZ7cKsfDuUX1fk06ILJ2OnTfa2Ei8meAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790434002; c=relaxed/simple;
	bh=ErWTIsYJuOYuiL6Ag2OQxXj6t+P8bGcbq7kY+Re+ufo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IYxRLoZXBjYjzYfSrw5mrsoMWW0QDN4deooytzLLE5CbUSwl7fy8wwPspriBvaJOOZM6JQFFZ68ek+qnG9KhhvQuDypZMP4IZldWWsJG3DemB4FBhzyAfxwOxX3l3hNazh+kx4Ha6hiPczWkiUvWhvoBRJPy9+Q+JIx99f0AojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc9Ek5xX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc9Ek5xX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AFE1F000FF;
	Sat, 26 Sep 2026 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790434001;
	bh=OEZoYFSQr0Axh5iOdt9y374HSA/cNeJ4WTQLbYtSnTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jc9Ek5xXsuowx86OS8zj5pgu4RnRV8rqohlCqtPXMdlUegemp+Tw9kWWn/SC1igGM
	 GSfkKxuHzCS794sfB/W28FHZLgKBt2TzkocJeB0dPyVl2Cyf4kQoCFy8X4R5cyNL2k
	 zagSwajtIFyg0QGSB1+2dSWA3X1eeBG44tE37OOt+JZTHZrT8ZlhEQyrwVp1ZY7jFh
	 Zn608DzpJtLrQP+DTj4YXqJSltpRURoqzl6VTqxqIGV/1UBgmXER2TUuGbbI1zerkX
	 uzquRb3o22M+48he+vgDgCucG1LUOGS5RMwfAM2SSUVjhseijM7XmAH4KZ3aq4xshG
	 3E+uOpS2TNMRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 26/36] bpf: avoid widening registers that
 hinder exact stack-slot tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926-scev-minimal-rebase-v1-26-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
 <20260926-scev-minimal-rebase-v1-26-c8e5ab5ba79f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:46:40 +0000
Message-Id: <20260926144640.C4AFE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: bpf_needs_fixed_stack_off misses dynptr consumers, rejectin=
g valid loops
--

commit a3ca958d64fafcbcf31deb9929c54958bdb72868
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: avoid widening registers that hinder exact stack-slot tracking

This commit adds logic to prevent loop-widening for registers that are
used as base addresses for stack access instructions that require exact
tracking (such as spills, fills, and calls constructing stack objects).

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9f56ffe09ebac..327bfc00da5f5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14087,6 +14087,46 @@ static bool kfunc_spin_allowed(struct bpf_verifi=
er_env *env, s32 func_id, s16 of
[ ... ]
> +bool bpf_needs_fixed_stack_off(struct bpf_verifier_env *env, int insn_id=
x)
> +{
> +	const struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
> +	u32 *flags, btf_id;
> +
> +	if (bpf_helper_call(insn)) {
> +		return insn->imm =3D=3D BPF_FUNC_dynptr_from_mem ||
> +		       insn->imm =3D=3D BPF_FUNC_ringbuf_reserve_dynptr;
> +	}

[Severity: Medium]
Does this logic miss helper functions that consume dynptrs (like
BPF_FUNC_dynptr_read, BPF_FUNC_dynptr_write, or BPF_FUNC_ringbuf_submit_dyn=
ptr)?

Since process_dynptr_func() relies on dynptr_get_spi(), which in turn
requires constant stack offsets via stack_slot_obj_get_spi(), wouldn't
omitting these dynptr consumers here cause a regression? If the verifier
widens the loop variable used for a dynptr array index, the stack offset
becomes non-constant and the verifier will erroneously reject valid programs
that read or write stack-based dynptrs in a loop.

> +
> +	/* vmlinux kfuncs only */
> +	if (!bpf_pseudo_kfunc_call(insn) || insn->off !=3D 0)
> +		return false;
> +	btf_id =3D insn->imm;
[ ... ]
> +	if (btf_id =3D=3D special_kfunc_list[KF_bpf_dynptr_from_skb] ||
> +	    btf_id =3D=3D special_kfunc_list[KF_bpf_dynptr_from_xdp] ||
> +	    btf_id =3D=3D special_kfunc_list[KF_bpf_dynptr_from_skb_meta] ||
> +	    btf_id =3D=3D special_kfunc_list[KF_bpf_dynptr_from_file])
> +		return true;

[Severity: Medium]
Similarly, does this miss kfuncs that consume or clone dynptrs (such as
KF_bpf_dynptr_clone and KF_bpf_dynptr_slice)?

If a loop variable is used to compute a dynptr address passed to these
kfuncs, the loop variable will be widened, leading to the same verification
regression when stack_slot_obj_get_spi() is called with a non-constant stack
offset.

> +
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-scev-minim=
al-rebase-v1-0-c8e5ab5ba79f@gmail.com?part=3D26
