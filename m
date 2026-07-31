Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1E339365
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 02:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785466001; cv=none; b=tIOVM7TLXVy/5hwqhwXMdpkGvZGT73pjG3SFgqUQdK8voDQw8bIy7BmlVOXZCse7OSXFauijJJJXq5Q7aqaFWt0z+jw8sKrmCoD9mSGzS3ePIhIyMwX62dtBIvI1WgLU+AjwAtbGUH4ns1EBiNypLEjLQWUVr7iM1bWvjuDvsbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785466001; c=relaxed/simple;
	bh=r8JLon9eYkDbYUDfjBHInNXaTj7ATOvM6DiBeXwz8Z0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K/STwMbdXUMg/EzhHsUOfPAYrK7YE5Rr4QUuxl6aHwaqeSFrF3W9DjY3LfnNhpYsbPSlXB7hQhb/qACOhjiPyHniMGjk38Eow1KXJ57F1hYp4qXy5+SGmwgMBHYKsLEjVDCUmQXSeaQ0jwH/5uEZlDtRovqOAXN1rIUI3J+Eqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeYylR5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeYylR5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4E81F000E9;
	Fri, 31 Jul 2026 02:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465997;
	bh=EIi8BCRNe9ysleBx96qxGp5p8qtKdJgraaOyKuA8l0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PeYylR5GvS7343DbCsSxTzd6fozcUAmeCvGmH1dp+QycF6/Nmx0bAL09jEws2AzT2
	 3jb9sC7jDxt6ZZGn2KKyRxgYnx0mVrj6tvAeV9A4TIDXHIwLwQz92U1SZc8WaWhtLi
	 6xSi9Xm0DVMeUbHFY3P/NrheLDfFSQ9mgj9n03hlKVog9xyU16nc1VPHdsoIse6nLU
	 UYP2FfYCsJ1rnGf6xDduh+YbGZqvRzxSSZQ4Ep886JsLji5lA4v3Tm7ltomJZcoHoy
	 CisflQHQjvZahrM0xorFSeggctuRFQ2K5LllvtViRzfjGiJnPJTQ0JqMRUiKLZIB5k
	 zgcSGNEKJXgqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 10/13] bpf: Add the
 bpf_landlock_restrict_binprm kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731022047.189137-11-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <20260731022047.189137-11-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 02:46:37 +0000
Message-Id: <20260731024637.9D4E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Multiple calls to bpf_landlock_restrict_binprm() do not compose; a=
 later call replaces a previously staged restriction instead of intersectin=
g it, violating BPF LSM composition principles.
- [Medium] bpf_landlock_kfunc_filter incorrectly restricts the release kfun=
c bpf_landlock_put_ruleset to only the two bprm sleepable hooks, violating =
the stated design and preventing valid reference cleanup in other LSM hooks.
--

--- Patch [10]: [PATCH bpf-next 10/13] bpf: Add the bpf_landlock_restrict_b=
inprm kfunc ---
commit fe3f43b90a0bd65c9f7f90c67126bdf361901840
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Add the bpf_landlock_restrict_binprm kfunc

This commit adds the bpf_landlock_restrict_binprm kfunc to enforce Landlock
rulesets on execution credentials. The restriction is staged and committed =
at
the execution's point of no return. It also limits the enforcement to speci=
fic
LSM hooks.

> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 9ff1c35fcd6e5..67aa902f12570 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c

[ ... ]

> @@ -535,6 +535,42 @@ __bpf_kfunc void bpf_landlock_put_ruleset(struct bpf=
_landlock_ruleset *ruleset)
>  	security_policy_kptr_put(LSM_ID_LANDLOCK, &policy);
>  }
> =20
> +/**
> + * bpf_landlock_restrict_binprm - Enforce a Landlock ruleset on exec
> + *                                credentials
> + * @bprm: execution context providing the prepared credentials to
> + *        restrict
> + * @ruleset: Landlock ruleset to enforce
> + * @flags: landlock_restrict_self(2) flags, except
> + *         %LANDLOCK_RESTRICT_SELF_TSYNC
> + *
> + * Restrict the credentials prepared in @bprm with @ruleset, so that
> + * the executed task starts confined by it, following the same domain
> + * composition rules as landlock_restrict_self(2).  The restriction is
> + * staged and only committed at the execution's point of no return: an
> + * execution that fails before that point is unaffected, and a later
> + * call on the same execution replaces a previously staged
> + * restriction.  @ruleset is only borrowed: the caller keeps its
> + * reference.
> + *
> + * The landlock_restrict_self(2) flags apply with their usual
> + * semantics.  Only %LANDLOCK_RESTRICT_SELF_TSYNC is rejected, as it
> + * targets the calling threads rather than the execution.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the Landlock LSM is not
> + * enabled, -EINVAL if @flags contains an unsupported flag, other
> + * negative values on failure as for landlock_restrict_self(2).
> + */
> +__bpf_kfunc int bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
> +					     struct bpf_landlock_ruleset *ruleset,
> +					     u32 flags)
> +{
> +	union lsm_policy_kptr policy =3D { .landlock.ruleset =3D ruleset };
> +
> +	return security_bprm_enforce_policy_kptr(LSM_ID_LANDLOCK, bprm,
> +						 &policy, flags);

[Severity: High]
Does replacing instead of intersecting the ruleset break the BPF LSM
composition principles?

If multiple BPF LSM programs are attached to the same hook, a later call to
bpf_landlock_restrict_binprm() replaces a previously staged restriction
rather than layering or intersecting it.

This allows a subsequent program to completely bypass and discard the secur=
ity
policy enforced by an earlier program.

> +}
> +

[ ... ]

> @@ -566,7 +605,10 @@ BTF_ID_LIST_SINGLE(bpf_landlock_get_ruleset_ids, fun=
c,
>   * in the fd table of the task that set the ruleset up, so
>   * bpf_landlock_get_ruleset_from_fd() is exclusive to syscall
>   * programs, which run in that task's context; an LSM program runs in
> - * the context of the task it mediates.
> + * the context of the task it mediates.  Enforcement is exclusive to
> + * the sleepable bprm LSM hooks the policy operation is specified
> + * for, and the release kfunc is allowed wherever a reference can be
> + * held.
>   */
>  static int bpf_landlock_kfunc_filter(const struct bpf_prog *prog, u32 kf=
unc_id)
>  {
> @@ -575,6 +617,8 @@ static int bpf_landlock_kfunc_filter(const struct bpf=
_prog *prog, u32 kfunc_id)
> =20
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_SYSCALL:
> +		if (kfunc_id =3D=3D bpf_landlock_restrict_binprm_ids[0])
> +			return -EACCES;
>  		return 0;
>  	case BPF_PROG_TYPE_LSM:
>  		if (kfunc_id =3D=3D bpf_landlock_get_ruleset_ids[0])

[Severity: Medium]
Does the bpf_landlock_kfunc_filter() logic inadvertently restrict the relea=
se
kfunc as well?

The updated comment states that the release kfunc (bpf_landlock_put_ruleset)
is allowed wherever a reference can be held.

However, in the BPF_PROG_TYPE_LSM case, the filter still applies this check
to all kfuncs (including the release kfunc) instead of isolating it to the
restriction kfunc:

	if (!btf_id_set_contains(&bpf_landlock_kfunc_hooks,
				 prog->aux->attach_btf_id))
		return -EACCES;

This prevents BPF LSM programs attached to non-bprm hooks from calling
bpf_landlock_put_ruleset() to release acquired ruleset references.

Should there be an exemption for the release kfunc here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731022047.1891=
37-1-utilityemal77@gmail.com?part=3D10
