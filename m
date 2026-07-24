Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F2387378
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921322; cv=none; b=fe4C6/zMmMijr4OQC5ztv0bUJvoLsky2zGfC4ZKQzfueXle5nIenEprG8Ho2YCRPtirvBm250GH5JQJHDhRltmjwdsnLZJSUe1qScxtWGNTXJ3pRK+BMuVXkjtAwRVVP3Wg41/LlLClyPPhcY/MkiSvmJ5bTq2mK+4dfdXmnqO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921322; c=relaxed/simple;
	bh=9MJIVhx8pUMMMVOaXljTsHA+NxxIfp2bDwMyGgUhmoo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pO9eTsZ2BS1L4//pXm7aU6O1B+749Bj18hPcIZR3CGJqeI4npJWNstIx+nUIOahUXbO4q5JH41xM/YtXKmzUy8tgAqyYDv21FicPHF+/Nn57KwQkwSjHggr0z3gCLdr1OVf5RO4nh7rs/nI5ZdZDQG8W06v4yVzcTDcdu0GZhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpCaekqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpCaekqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB2D1F000E9;
	Fri, 24 Jul 2026 19:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784921320;
	bh=FPgfBLIseC0UoJci7RuHTrEEqhfQhBJ1zxo9jNz+xKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RpCaekqfoIJdASEokzMeF1+ym7wJMrL2CHsgQZs08w1nyTPn2sUVpt4zUqs5+jr6u
	 a8JUETvx/x2wUMs+H8uUUaB6ZfeQTeYadxjQK956quyd460Bv5yUhuUkim2RIsG2vW
	 oB0toWZPXQW8Jp6NoHTLzvHzumo38mGCSmqit62nM2LKAa7Xc6mkbYFu000+u7NnbW
	 de413EQUSKnZKuZxMNQ3Ug9s3t8Ai6vbEHYSTuYWeYi0qJldQw80m7crEmHSjOj314
	 EFpTkjJDgJuFHGRz6HIcFp1tt5Fx+giom3Oguc9MWs90lQiENo7LoycBWvLmwkxM6J
	 7Faz8BNCnmAlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 02/18] bpf: Unify const map ptr argument
 checking for helpers and kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260724190813.1458271-3-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
 <20260724190813.1458271-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 19:28:39 +0000
Message-Id: <20260724192840.1BB2D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Multi-line comment does not follow the required BPF subsystem comme=
nt style.

Pre-existing issues:
- [Critical] Pre-existing verifier panic when an array map is passed to kfu=
ncs like `bpf_wq_init`.
- [High] Pre-existing logic bug allows mismatching maps to bypass safety ch=
ecks in kfuncs.
--

--- Patch [2]: [PATCH bpf-next v2 02/18] bpf: Unify const map ptr argument =
checking for helpers and kfuncs ---
commit 08bfe87a36be7126ec3db2d3ab4783e72b62e453
Author: Amery Hung <ameryhung@gmail.com>

bpf: Unify const map ptr argument checking for helpers and kfuncs
   =20
Both the helper ARG_CONST_MAP_PTR and the kfunc KF_ARG_PTR_TO_MAP
recorded the map pointer in meta->map and, when a map was already
bound by a preceding timer/workqueue/task_work argument, rejected a
mismatching map. This logic is factored into a single process_map_ptr_arg()
used by both paths.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e8c76abbf76a2..a3429610b426e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8274,6 +8274,44 @@ static int get_constant_map_key(struct bpf_verifie=
r_env *env,
> =20
>  static bool can_elide_value_nullness(const struct bpf_map *map);
> =20
> +static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg,
> +			       argno_t argno, struct bpf_call_arg_meta *meta)
> +{
> +	/* Use map_uid (which is unique id of inner map) to reject:

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem formatting?

According to the subsystem guidelines, multi-line comments should have the
opening /* on its own line:

/*
 * Use map_uid (which is unique id of inner map) to reject:
 * ...
 */

[ ... ]

> @@ -12122,36 +12140,9 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
>  					reg_arg_name(env, argno));
>  				return -EINVAL;
>  			}
> -			if (meta->map.ptr && (reg->map_ptr->record->wq_off >=3D 0 ||
> -					      reg->map_ptr->record->task_work_off >=3D 0)) {

[Severity: Critical]
This is a pre-existing issue that was not introduced by this patch (in fact,
the patch appears to fix it!), but could the old code crash the verifier he=
re
if a BPF program called bpf_wq_init(wq, map, 0) and passed an array map
without BTF for the map argument?

Since an array map without BTF has a NULL record, evaluating
reg->map_ptr->record->wq_off would result in an unconditional NULL pointer
dereference, leading to a panic. This could be triggered by any user with
privileges to load BPF programs.

[Severity: High]
This is also a pre-existing issue that was not introduced by this patch, but
did this original condition allow mismatching maps to bypass safety checks?

If a BPF program called bpf_wq_init(wq, map, 0) with a valid workqueue but
passed a mismatched map (like a map containing only a bpf_timer), the
mismatched map would lack both wq_off and task_work_off. This would make the
condition evaluate to false, bypassing the mismatch rejection and potential=
ly
leading to type confusion or memory corruption during runtime callbacks.

> -				/* Use map_uid (which is unique id of inner map) to reject:
> -				 * inner_map1 =3D bpf_map_lookup_elem(outer_map, key1)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724190813.1458=
271-1-ameryhung@gmail.com?part=3D2
