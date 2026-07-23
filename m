Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BFA2E717B
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785927; cv=none; b=ot19kzwvp2C1ZsjkpjseqmHwtX5Q9Iq8BLkkRGDnAtGBosWmxz1HyJSjJwsJCvF6n7wTFj6f3QtM+OOmBTBDgVtRGYjhShhKhmsv/0EVviudf3/Hs0aRg7WryGsW40fUDIbEgT9vlmZuTaJhGg+Ch+vpaUjjQ+XTIPyGPRNejJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785927; c=relaxed/simple;
	bh=P5lQTJiIvFdym8xknpesusmwvJ3IoH6dgXImZr7fAsE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sCD66dE/nnB4IqzwdPU941sfkv5rIpKxZsVJcUQCNIhDgu8QJ1Gt41+I4qyAGJ5Yc9bKCEuVtWapGw5f0/Dt9F4Kah6erNPz/8LUfBKTufZxlxxZXrcciXiXrIiF7NfDf2hE+Cq8oGVAgGOB+ScurSQ8ym/BXQYZJZTgv6jmE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0defVyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0defVyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984761F000E9;
	Thu, 23 Jul 2026 05:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784785922;
	bh=ZI0cXoMYfXz2qkQ7WgPNWL+0BJS9M7Bt1yYBLn0d6tE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z0defVyYM9SiI8cgTNsGwBwxx/3dwJUhhsZm1x6bkuUwhDZPPmD8ZXQObu2oGcqij
	 Pok9SCfUeCHcMIvKu4AZk52sP6TJumOq40xNLNJ9t/ItyTDmLfwCTHHAror9RoHOfV
	 XTF5eb9liJVU8GEifTf72iOW8Mp60Wzik1pFfwpijXJ7uZmikEvDoKInhORFud6KIB
	 R6stEzoNPOka5Fx6nxkM5OVV86wiHSD9tdSu1QZEejNCzucpHVbIQ7dWiaWmzqJpYr
	 S573Iv/A23WA3BDwFxyBvfhz5MdCj2N7rvShHU14IRpEIvjPWAWOA8gJAVCCiKv2hI
	 f3kHyqPQaKZ7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 05/18] bpf: Check helper and kfunc mem+size
 arguments identically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723050806.1158442-6-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
 <20260723050806.1158442-6-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 05:52:01 +0000
Message-Id: <20260723055202.984761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked nullable pointers passed to helpers with `size > 0` can =
cause a kernel panic, as the verifier does not enforce a strict correlation=
 between the pointer's runtime NULL state and a zero-size constraint.
--

--- Patch [5]: [PATCH bpf-next v1 05/18] bpf: Check helper and kfunc mem+si=
ze arguments identically ---
commit 209f89ec76658f4c319cb2f0b37557c6e39026aa
Author: Amery Hung <ameryhung@gmail.com>

bpf: Check helper and kfunc mem+size arguments identically

This patch unifies the memory and size argument checking between helpers
and kfuncs. By moving the may_be_null handling into check_mem_size_reg(),
it prevents an issue where an un-narrowed map-of-maps value could be
passed to a nullable helper memory argument and leak kernel pointers.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 29d45636c28b8..6520742d51b58 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6873,7 +6873,14 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
>  			      bool zero_size_allowed,
>  			      struct bpf_call_arg_meta *meta)
>  {
> -	int err;
> +	bool may_be_null =3D type_may_be_null(mem_reg->type);
> +	struct bpf_reg_state saved_reg;
> +	int err =3D 0;
> +
> +	if (may_be_null) {
> +		saved_reg =3D *mem_reg;
> +		mark_ptr_not_null_reg(mem_reg);
> +	}

[ ... ]

> -	err =3D check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size_=
reg),
> -				      access_type, zero_size_allowed, meta);
> +
> +	if (access_type & BPF_READ)
> +		err =3D check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size=
_reg),
> +					      BPF_READ, zero_size_allowed, meta);
> +	if (!err && access_type & BPF_WRITE)
> +		err =3D check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size=
_reg),
> +					      BPF_WRITE, zero_size_allowed, meta);
> +
>  	if (!err) {
>  		int regno =3D reg_from_argno(size_argno);
> =20
> @@ -6920,6 +6933,10 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
>  		else
>  			err =3D mark_stack_arg_precision(env, arg_idx_from_argno(size_argno));
>  	}
> +
> +	if (may_be_null)
> +		*mem_reg =3D saved_reg;
> +
>  	return err;
>  }

[Severity: High]
This is a pre-existing issue, but by clearing the PTR_MAYBE_NULL flag=20
temporarily, does this bypass the verifier's check to ensure the size=20
evaluates to 0 when the pointer is NULL at runtime?

If a BPF program obtains a nullable pointer (for instance, from
bpf_map_lookup_elem) and passes it to a helper with a size greater than 0
without a NULL check, the verifier permits this because it verifies the
bounds as if the pointer is valid.

At runtime, if the pointer is NULL, wouldn't the helper execute and=20
dereference the NULL pointer? For example, in net/core/filter.c:bpf_csum_di=
ff(),
if from_size or to_size > 0, the pointer is dereferenced by csum_partial():

    if (from_size && to_size)
        ret =3D csum_sub(csum_partial(to, to_size, ret),
                       csum_partial(from, from_size, 0));
    else if (to_size)
        ret =3D csum_partial(to, to_size, ret);
    else if (from_size)
        ret =3D ~csum_partial(from, from_size, ~ret);

Similarly, in kernel/bpf/helpers.c:bpf_snprintf(), bstr_printf() could be
called without checking if str is NULL when str_size > 0:

    err =3D bstr_printf(str, str_size, fmt, data.bin_args);

Should the verifier emit a runtime check or enforce a constraint to ensure=
=20
the size is 0 if a nullable pointer is passed to prevent a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.1158=
442-1-ameryhung@gmail.com?part=3D5
