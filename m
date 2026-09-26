Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B9547063
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466573; cv=none; b=B3rgwBiiHYvwZn+Sq8kbfC0EVfvZ4rHxF03YU4+DyVDWDNItv0Jkx7kuu4FF5xFWnNoEqRimvAx8M4agJCNwRGIrt5443EAI7B7NHE7Gt+gwtLIyWeF/NoqMrZJs1uKDqMwbq4Qw940WfZF/S195h4jlSQOG3iwdSEEKogeY8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466573; c=relaxed/simple;
	bh=krbu/xcKKzq5eDFCUnQvC4G6dWc38uaihYzpFKfDvFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JnGjMpg0BTVEL35xQe+6b89wDq7pQxozw8DT9rsXEJVgmwp4VY3hiFz7OdQFzL/P7f1AjuD7Z6aJzhQUo4v5A+R6E6E8HPhdUuK8cTT+RPxNLgyIuYaV5eqCpHKj1MdywEGwazBBL1vJYqJjC6H9SuphPxVpFDhwl8MmW1h9Dww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwqzK9Oa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwqzK9Oa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB321F000FF;
	Sat, 26 Sep 2026 23:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790466572;
	bh=0z5eCECKha5t7dRVRRHx7g+HfmBunFGknKsLX6umZac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RwqzK9OaVd8VLzPC9njpFFPM622h9KJO2xyqMDlcDEXGi3TkX4PIBJqq5Fw4FckTf
	 2oGhUhbj/C8i/KOo6t5ElfhlKv6rGNntvF1mVthnisaNZ7Gd+C1y8CsCWl/Pg1yWkQ
	 Ta14x0T4SJ6SVXPi/Gm6iSUnXEZ2KFOoHryqvsS5z7o3sm0WuTVeockjV42TBntSgo
	 V9EIlLZIu/tXge74yWUO2kMOrgeuBheWjDfeTj+kKjIIlqMBwhe4tmzRNCvVGgbHx9
	 tKgCxz7MDpdzt9ELVdhr38mEWfXai8MPKtvHizOL5H+3+fZBVa0REaHsyLUF9CiOtB
	 BSDk5eykBGbBQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 10/16] bpf: Let typed_arena_cast copy
 pointers the verifier already trusts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926233503.3114147-11-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
 <20260926233503.3114147-11-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 23:49:31 +0000
Message-Id: <20260926234932.1EB321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: check_typed_arena_cast() misses src->off check causing state =
mismatch
--

commit e8c7f600f2244019888ad241fa81b63bc3bccf3d
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Let typed_arena_cast copy pointers the verifier already trusts

The compiler inserts the cast at every use of a pointer to a struct with
special fields, so that programs never write one, and it cannot tell what
the pointer is: the same struct lives in typed arenas, in allocated objects,
in map values and on the stack. So the verifier decides per path what the
cast takes.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b85d99f81ef54..aceb17e629481 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -17320,6 +17358,18 @@ static int check_typed_arena_cast(struct bpf_ver=
ifier_env *env, struct bpf_insn
>  		return PTR_ERR(ta);
>  	aux->typed_arena =3D ta;
> =20
> +	if (src->type =3D=3D (PTR_TO_BTF_ID | MEM_ARENA) && src->btf_id =3D=3D =
ta->btf_id &&
> +	    tnum_is_const(src->var_off) && !src->var_off.value) {

[Severity: High]
Does check_typed_arena_cast() need to ensure src->off =3D=3D 0 here?

If a BPF program uses typed_arena_cast on a control flow path where one bra=
nch
provides a SCALAR_VALUE (setting aux->sanitize_needed =3D true) and the oth=
er
branch provides a PTR_TO_BTF_ID | MEM_ARENA with a non-zero fixed offset
(src->off > 0), the runtime sanitization sequence drops the offset by maski=
ng
it to 0, but the verifier retains the non-zero offset.

Could this state mismatch allow a program to subtract the offset and access
memory before the arena object, bypassing verifier bounds checks?

> +		*dst =3D *src;
> +		return 0;
> +	}
> +	if (aux->sanitize_plain) {
> +		verbose(env, "insn %d casts values that need different treatment on di=
fferent paths\n",
> +			env->insn_idx);
> +		return -EINVAL;
> +	}
> +	aux->sanitize_needed =3D true;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926233503.3114=
147-1-memxor@gmail.com?part=3D10
