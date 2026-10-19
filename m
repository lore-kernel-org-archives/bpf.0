Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902A3DEAD6
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792381562; cv=none; b=JLUEWyFN40rJcBqYZ7FRXP4fOzlIx1K98Xe7cBSZK8ayA8tS/Dy1ObZ+4U5zLZqg7dxtB0HRT1PPToROLfJfS2qh6riKwAZlniMhYuCmp6QRbx+KYXa8alDVOMn8KkvmWoSFwanfQauTa44nST9Q2Xoo91HlkHOVbsTs3MSgxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792381562; c=relaxed/simple;
	bh=tNdy5ih4muwKr3iYz9iKoLB841JeFccr1a98aq5B2OU=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=LAesQUQ3BdeghhKT1dynWeeMjnyJxacZZ8nRx3zT26zgF512y0ounRhEJ+wVQGVXCffjBByYuI8vf2pxz0echvjqpDXb23y1CK/wlQ+NZPSKDuFM9bh9thmCzG9gUoo+oDmxsYLhSdfMtQaP/MfeMlL+ihac37Meq92cEnNzVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ+Ot4b0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ+Ot4b0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838F41F000C4;
	Mon, 19 Oct 2026 03:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792381560;
	bh=84eO0RoS3n0x8e5KnMrkdJ2OGjch+Doh/PhkNnF8UI8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SJ+Ot4b0q5p7ovNLAaXShB3zuh9LuGOP4sncjHGm8SI4o+dqe2nOWAKPydrTtfgQR
	 qKkQwhVEpQMDBizneuDzFOFmMzSAHUvfarjBanLnjkA5DakFMW319tf8buQwz7/x5p
	 JaFeqoIJIat0yQe1tjdIo7rjm0IpuEYiNGbTmxdmcGTgTfbze1BDBfQK5ja08uPTo1
	 aVJal/LfR1EVirP8uTchaljbReHSz89ptk/5qBOb5fYQ+pQccBkgfsoCn2n5u/yt13
	 u53cqeWq2APlt1HyEfaMmhwn6XG7osDo01lJFdyTjQL3yZndr89JvK9Aw+LNMV/ZPZ
	 J47Z8FnostuDg==
Message-ID: <sashiko-outbox-176588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 01/16] bpf: Check exclusive maps once the
 program digest is final
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261019032401.2302823-2-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
 <20261019032401.2302823-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 03:46:00 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: __add_used_map() claims exclusive maps before check_excl_maps=
() runs
- [High] bpf: unauthenticated CO-RE relocations on signed progs in bpf_chec=
k()
--

commit 8772d7da5dbe0ad0dc32abd5edb328e0e62a1dbe
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Check exclusive maps once the program digest is final

This commit moves the exclusive map hash comparison out of
check_map_prog_compatibility() into check_excl_maps() at the end of
check_and_resolve_insns(), after the final program digest is computed.
It also removes the early bpf_prog_calc_tag() call for signed programs
in bpf_check().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5958425e9a2a5..14dacc5d202f7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20775,12 +20775,6 @@ static int check_map_prog_compatibility(struct b=
pf_verifier_env *env,
>  {
>  	enum bpf_prog_type prog_type =3D resolve_prog_type(prog);
> =20
> -	if (map->excl_prog_sha &&
> -	    memcmp(map->excl_prog_sha, prog->digest, SHA256_DIGEST_SIZE)) {
> -		verbose(env, "program's hash doesn't match map's excl_prog_hash\n");
> -		return -EACCES;
> -	}
> -
>  	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
>  	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
>  		if (is_tracing_prog_type(prog_type)) {
> @@ -20878,6 +20872,29 @@ static int bpf_map_claim(struct bpf_verifier_env=
 *env, struct bpf_map *map)
>  	}
>  }
> =20
> +/*
> + * An exclusive map is bound to the digest of its program. The digest co=
vers
> + * the insns as they are verified, after the CO-RE relocations the kernel
> + * applies, so it exists only once check_and_resolve_insns() has compute=
d it,
> + * and the maps are checked against it there, whether an insn referred to
> + * them or a continuous fd_array bound them before.
> + */
> +static int check_excl_maps(struct bpf_verifier_env *env)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < env->used_map_cnt; i++) {
> +		struct bpf_map *map =3D env->used_maps[i];
> +
> +		if (map->excl_prog_sha &&
> +		    memcmp(map->excl_prog_sha, env->prog->digest, SHA256_DIGEST_SIZE))=
 {
> +			verbose(env, "program's hash doesn't match map's excl_prog_hash\n");
> +			return -EACCES;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *=
map)
>  {
>  	int i, err;

[Severity: High]
By moving the map->excl_prog_sha check out of check_map_prog_compatibility()
and deferring it to check_excl_maps() at the end of
check_and_resolve_insns(), can an unauthorized program with a non-matching
digest mutate map->user or BPF_MAP_TYPE_INSN_ARRAY state in __add_used_map()
before check_excl_maps() rejects it?

In kernel/bpf/verifier.c:__add_used_map(), bpf_map_claim() and
bpf_insn_array_init() now run before the exclusive hash check:

	err =3D check_map_prog_compatibility(env, map, env->prog);
	if (err)
		return err;
	...
	err =3D bpf_map_claim(env, map);
	if (err)
		return err;

	if (map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY) {
		err =3D bpf_insn_array_init(map, env->prog);
		...
	}

If the legitimate owner program P1 has already claimed the exclusive map
(so map->user =3D=3D (unsigned long)P1->aux) and a second program P2 with a
non-matching digest references the map via process_fd_array_continuous() or
a BPF_LD_IMM64 instruction, P2's call to bpf_map_claim() transitions
map->user to BPF_MAP_USER_MANY:

	if (cmpxchg(&map->user, old, old ? BPF_MAP_USER_MANY : me) =3D=3D old)
		return 0;

When P2 is later rejected by check_excl_maps() with -EACCES,
release_maps() -> __bpf_free_used_maps() in kernel/bpf/core.c only resets
map->user if it still matches P2's aux:

	cmpxchg(&map->user, (unsigned long)aux, 0);

This leaves map->user permanently set to BPF_MAP_USER_MANY, causing
resolve_func_ptrs() in kernel/bpf/verifier.c to skip the map and
resolve_func_ptrs() in kernel/bpf/fixups.c to fail with -EBUSY for the
legitimate owner program. Similarly, if the exclusive map is a
BPF_MAP_TYPE_INSN_ARRAY, P2 will invoke bpf_insn_array_init() and claim
insn_array->used or reset its state before check_excl_maps() runs.

[ ... ]

> @@ -23564,11 +23581,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
>  		ret =3D -EINVAL;
>  		goto err_prep;
>  	}
> -	if (env->signature) {
> -		ret =3D bpf_prog_calc_tag(env->prog);
> -		if (ret < 0)
> -			goto err_prep;
> -	}
> =20
>  	ret =3D process_fd_array(env, attr, uattr);
>  	if (ret)

[Severity: High]
Does removing the early digest check for signed programs allow
unauthenticated CO-RE relocations to modify env->prog->insnsi after
signature verification?

The commit message notes that the maps of a signed program are now checked
against the digest of the final instructions in check_excl_maps(), which
covers the relocations the kernel applies and the signature does not.

However, in kernel/bpf/verifier.c:bpf_check(), bpf_prog_verify_signature()
and security_bpf_prog_load() run on the initial unrelocated instructions
before bpf_prepare_btf_info() and bpf_check_core_relo():

	if (env->signature) {
		ret =3D bpf_prog_verify_signature(env, attr, uattr.is_kernel);
		if (ret)
			goto err_prep;
	}

	ret =3D security_bpf_prog_load(env->prog, attr, env->prog->aux->token,
				     uattr.is_kernel);
	if (ret)
		goto err_prep;
	...
	/* Prepare BTF and func_info needed to discover all subprograms. */
	ret =3D bpf_prepare_btf_info(env, attr, uattr);
	if (ret < 0)
		goto skip_full_check;

	/* Apply CO-RE before validating the program's instruction layout. */
	ret =3D bpf_check_core_relo(env, attr, uattr);
	if (ret < 0)
		goto skip_full_check;

In bpf_prog_verify_signature(), the PKCS#7 signature is verified only over
the initial prog->insnsi and the frozen map values, not over
map->excl_prog_sha (which is user-supplied via attr->excl_prog_hash during
BPF_MAP_CREATE), and a signed program with fd_array_cnt =3D=3D 0 has no maps
checked in check_excl_maps() at all.

Because neither bpf_prepare_btf_info() nor bpf_check_core_relo() rejects
attr->prog_btf_fd or attr->core_relo_cnt when env->signature is set, could
a caller supply a validly signed program along with custom BTF and CO-RE
relocations (and maps created with attr->excl_prog_hash matching the
post-CO-RE digest) to mutate instructions in env->prog->insnsi after
bpf_prog_verify_signature() has already marked the program BPF_SIG_VERIFIED?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019032401.2302=
823-1-memxor@gmail.com?part=3D1
