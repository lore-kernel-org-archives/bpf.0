Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB675695
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 00:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790467410; cv=none; b=a6VXEWRl28IdIw1aWi133KeEMf4Vs2WW8cB0IpwLNbftEAk8DUibkFyHKKPF3geJYftz9ClLfqEtKxFtXZYct3i8cfjbbUKwbczu00s4LbrOXpTmaYtmZbcQUqjnzgVKtNIzDPZ/F6aMRnxyJBulSPW7oY3E4wr+vDCe39IDpX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790467410; c=relaxed/simple;
	bh=IzhPlvNU9Cs3HWAX2+bQujgI1fvNjcca2jvzsJZyl7U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p8oh/Ugew+Yp+CsfunYp329a948kRBi0Xy7d8j9NOhQezjHPg5I0CdhCLkRNMw0vizKORoFKL22PtH+6tA6+Z0b1/3u9ipvMcIDQAd29pFB23JCSReSAMV9veBnzRKYcH2bTlyTVpZ60MMUt9ImvobKkcaStwPyeB/9NaPNtdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEZazKRC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEZazKRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676401F000FF;
	Sun, 27 Sep 2026 00:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790467408;
	bh=7gBZ4ULwhWQe6YlSMsjl+kJ0Jv7kT9nyN3XPEfJP9H8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oEZazKRC+rl8dotc77Iayey3FqJiigNkEWpEXkOyYDGqr2hKvGBewTKcYTKWlqKxc
	 GGQMu1OmjSp3xBLaV+hm1lqafuVPFPZy5CjgmBYM6hwW5oILUqakkq7MLKOsBs4l4J
	 24kc6lOTLMVRWEa7SGKS7YNULSbsXiqqJXoHSE7xlWrzaY40WUVCsGn2eKzZOB+Iuu
	 ssOmLwnSzG810AovwGcEVg9bw/1UP/hqBGDXBFgfQFEDB8P1kxuFY/Fiksrvrqv2QG
	 5yPhiKWsEaLtZhpFqf/j9+tuSCKkoC55fgK+YIy/shBESyxaEaHy0Gqsg5642XxQHC
	 s6lW1aOPWgZHQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 07/16] bpf: Trust typed pointer fields
 of typed arena objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926233503.3114147-8-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
 <20260926233503.3114147-8-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 00:03:26 +0000
Message-Id: <20260927000328.676401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: refcount leak in bpf_typed_arena causes saturation and WARN
--

commit 824870737e5e6082cced029879731300754bd906
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: bpf: Trust typed pointer fields of typed arena objects

This commit introduces logic to track and trust typed pointer fields
within typed arena objects. A load from these fields returns an
unsanitized pointer which is considered trustworthy without additional
checks, and writes ensure only valid typed arena pointers or null are
stored.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -6328,6 +6348,61 @@ static bool type_is_trusted_or_null(struct bpf_ver=
ifier_env *env,
[ ... ]
> +static int check_typed_ptr_field_access(struct bpf_verifier_env *env, st=
ruct bpf_reg_state *regs,
> +					struct bpf_reg_state *reg, const char *tname, u32 btf_id,
> +					enum bpf_access_type atype, int value_regno)
> +{
> +	struct bpf_insn *insn =3D &env->prog->insnsi[env->insn_idx];
> +	u8 class =3D BPF_CLASS(insn->code);
> +	struct bpf_reg_state *val;
> +	struct bpf_typed_arena *ta;
> +
> +	if (BPF_MODE(insn->code) !=3D BPF_MEM || BPF_SIZE(insn->code) !=3D BPF_=
DW ||
> +	    (class !=3D BPF_LDX && class !=3D BPF_STX && class !=3D BPF_ST)) {
> +		verbose(env, "typed pointer field of struct %s must be accessed with a=
 64-bit load or store\n",
> +			tname);
> +		return -EACCES;
> +	}
> +	if (atype =3D=3D BPF_READ) {
> +		/*
> +		 * The pointer leads into the pointee's typed arena, which the
> +		 * program may never cast to or allocate from: register it here,
> +		 * as a cast would, so that the sanitization has a slice to mask
> +		 * into and the slice exists for the map's lifetime.
> +		 */
> +		ta =3D typed_arena_register(env, btf_id);

[Severity: Medium]
Could this lead to a refcount leak for the typed arena when the program
is unloaded?

When typed_arena_register() is called here, it acquires a reference to
the typed arena via bpf_typed_arena_get() which increments ta->refcnt.
However, the program unload path in bpf_prog_free_deferred() skips
releasing the reference acquired during load:

kernel/bpf/core.c:bpf_prog_free_deferred() {
    ...
    /* The typed arenas outlive the program; only the load's failure retrac=
ts them. */
    kfree(aux->typed_arenas);
    ...
}

Because the reference is never decremented after a successful load, the
refcount will monotonically increase by one per load and unload cycle.

Since this path is reachable by any user capable of loading BPF programs,
is it possible for a user to repeatedly load and unload a program to
saturate the refcount and trigger a kernel WARN?

> +		if (IS_ERR(ta))
> +			return PTR_ERR(ta);
> +		return mark_btf_ld_reg(env, regs, value_regno, PTR_TO_BTF_ID, reg->btf=
, btf_id,
> +				       MEM_ARENA | PTR_UNSANITIZED);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926233503.3114=
147-1-memxor@gmail.com?part=3D7
