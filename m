Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955F1624D5
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098858; cv=none; b=X2XC/TsI4GGisb/hcHOsSaFNDaDmimjeWlkqkdGOJdkoH0Pfk1W9UHjrtx2gM/Fbzi+GKL8KAheQyYMFoP3ejqAwubH+m9fwn9M9uyjPetaZm1mZ/EWIkm1fZ4E3t2CcdHhtrRtRe5tUmMVAGIlgIl21YVBM5Gfq/SC7KGjjyHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098858; c=relaxed/simple;
	bh=mCjT+rTorVfmR7V2nwCHREP7zGZHUtVYLTQwFNGL4Zo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r6mHiO2SADQhwtX0aWLNZ3fk2P4tFzrVubRjX9PIf77kRB2kBGFL3yJRK1XOddVJfzEihyPc5EryBPT0kDyW7uFYdNDU79BKVueyeQ4C4ByohZJ97vg8V31BMubmjjcuq/bkaC7RdiWrJiaorNXONyA3ICBjrFFYWJznjGB4z/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvQG67Kh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvQG67Kh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8451F000E9;
	Wed, 15 Jul 2026 07:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784098856;
	bh=Xg7zIKfEQfyCJhwtrRM23wceWmzXph79ObEIeCTCDoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dvQG67KhHewvEQbnE4BLbu1EBfgaVcUYsRzRhihhUXHP13qL0J/81hiN8OcRK4t5W
	 xnXMwMkQ2s8E2967EcAzUxaGNAJYqOe4dTPzyeA+x6MBmQkZbD3ZTezLIEdRDxGlFN
	 MPi2vhgPXhaQblhiNzBzJDybB0VexaOx7/oy/fvGn6YIps1vIpXiewxNeL6WCqP+0Q
	 UsFQccAr6rid6lYAeNJXvipVp0lp1B+3cDw3TUzu+futIlELOKdvYDa0UnXT1GfIt4
	 IGApTZ5IxljNrdQL7ZB4cGXhyB0/KB3EjBjCM1pxkEEGHUAixDG8tSfW+M7atx+MR8
	 8HFmdIm2p3yVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 7/7] bpf: Unify helper and kfunc call
 argument meta
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715064047.1793790-8-ameryhung@gmail.com>
References: <20260715064047.1793790-1-ameryhung@gmail.com>
 <20260715064047.1793790-8-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 07:00:55 +0000
Message-Id: <20260715070056.6B8451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized stack variable `meta.func_name` dereferenced on erro=
r path, leading to kernel panic.
--

--- Patch [7]: [PATCH bpf-next v2 7/7] bpf: Unify helper and kfunc call arg=
ument meta ---
commit ca91a3b2fc7adc980912af895a2a5840eb94b51f
Author: Amery Hung <ameryhung@gmail.com>

bpf: Unify helper and kfunc call argument meta
   =20
This commit merges bpf_call_arg_meta and bpf_kfunc_call_arg_meta into a sin=
gle
struct. The unused btf_id field is dropped from the helper meta as groundwo=
rk
for sharing argument checking logic.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12953,11 +12953,11 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
>  	struct bpf_reg_state *regs =3D cur_regs(env);
>  	const char *func_name, *ptr_type_name;
>  	const struct btf_type *t, *ptr_type;
> -	struct bpf_kfunc_call_arg_meta meta;
> +	struct bpf_call_arg_meta meta;
>  	struct bpf_insn_aux_data *insn_aux;
>  	int err, insn_idx =3D *insn_idx_p;
>  	const struct btf_param *args;

[ ... ]

>  	/* skip for now, but return error when we find this in fixup_kfunc_call=
 */
>  	if (!insn->imm)
>  		return 0;
> =20
>  	err =3D bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
>  	if (err =3D=3D -EACCES && meta.func_name)
>  		verbose(env, "calling kernel function %s is not allowed\n", meta.func_=
name);

[Severity: High]
This is a pre-existing issue, but does this error path dereference an
uninitialized stack variable?

Looking at bpf_fetch_kfunc_arg_meta() in kernel/bpf/verifier.c, if
fetch_kfunc_meta() returns an error like -EACCES, it returns early without
initializing the struct:

int bpf_fetch_kfunc_arg_meta(...)
{
        ...
        err =3D fetch_kfunc_meta(env, func_id, offset, &kfunc);
        if (err)
                return err;
       =20
        memset(meta, 0, sizeof(*meta));
        ...
}

When this early return happens, the meta struct on the stack in
check_kfunc_call() remains uninitialized. The check here for
err =3D=3D -EACCES && meta.func_name will then evaluate garbage memory for
meta.func_name.

If the uninitialized memory evaluates to true, verbose() will dereference
that garbage pointer, which could lead to a kernel panic. Could we initiali=
ze
the meta struct earlier, or zero it in check_kfunc_call() before passing it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715064047.1793=
790-1-ameryhung@gmail.com?part=3D7
