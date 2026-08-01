Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54B30D418
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785572567; cv=none; b=Ua0VMsY9NaUXI61L3z4KmeYpdPqv0qSPAh5suOyFA3jPS+xs0iQPBWnw9dB75K5WgzHsECjxrekdL4ataeAsxzjj5eNW4NNW92Fmuza+Ln8HTP8zgcv1dc30Ca45KnUGb9dAPaSSLX4s/nn5kOy11veRWmciHlGMFWX/5XuJOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785572567; c=relaxed/simple;
	bh=AnbVpZkqyR8h+kWxc2FOql+eeEgyklGJeaIL1Z2vTwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lmy5WNV/HuOVblLCaJWlfl4H+6ptRthHBJmUu1hQYIrnCENsHZFeRxteKRQDvTEQz/LpZB0sJczvsyKz1FEW3xL6A7Alip2uRwGrby6/Foe0Wv9qSGAcOZ2Bsdhc2CRB2To96rBVVmYsiCjUgTgN0rPVMxiVvkhHFV9lK2GiB9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2mTrjSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2mTrjSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FB41F00AC4;
	Sat,  1 Aug 2026 08:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785572566;
	bh=wllY/ovpHwf47UYHnBw4k/CL4JxdegD1mMGKxewYS84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n2mTrjSFplmaIZ17pRzLf6b3lpA5cgv8XZ01rxJv0BeQCLztqw2dZc4qyujFDqg/b
	 ThpEBu/LQ2vBXMXISO3ziiPL9195a0ivnY2W7OJedYbY7ylRZ1A3tAyqUSjjqdpwUT
	 xbALIN0TX4CV4mQIxM52cG7vQ6ZYgABAIfmthrz+XkneMgRbefseqg8girMUZHWx1l
	 phe9V9/McToHDMyO5h5d8aJvBZwfaQ//t8otf2KE52HoVJSkSfhlheSfn9mY6I4IQE
	 oQmqjb87WHnK3r9KcwLIZER78nKGGJT1DpQvWGBeMNQvIUiK+OvCMpKj7jqnAKyyf2
	 EuU6ByugCM0Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 15/18] bpf: Classify kfunc pointer arguments
 from BTF, resolve type against the register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260801074633.1595644-16-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
 <20260801074633.1595644-16-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 08:22:45 +0000
Message-Id: <20260801082246.17FB41F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Allowing PTR_TO_BTF_ID as a KF_ARG_PTR_TO_MEM argument is either=
 broken or fundamentally unsafe due to unvalidated access flags.
--

--- Patch [15]: [PATCH bpf-next v3 15/18] bpf: Classify kfunc pointer argum=
ents from BTF, resolve type against the register ---
commit d5adf1f80d7ac5827091492c5099bcb0c05e15d1
Author: Amery Hung <ameryhung@gmail.com>

bpf: Classify kfunc pointer arguments from BTF, resolve type against the re=
gister

This commit changes kfunc pointer argument classification to rely strictly
on BTF rather than register state. It introduces support for passing a
PTR_TO_BTF_ID as a fixed-size memory buffer when pointing to a scalar struc=
t.

>     The new design now accepts one previously rejected case: passing
>     PTR_TO_BTF_ID to a pointer to scalar w/o a following __sz/__szk. The
>     argument will be classified as KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE. The
>     PTR_TO_BTF_ID register will go through check_mem_reg() ->
>     check_helper_mem_access() -> check_ptr_to_btf_access(), and by defaul=
t only
>     read is allowed.

[Severity: Medium]
Will this newly accepted case always fail verification?

While the commit message states that "by default only read is allowed,"
the call to check_mem_reg() for KF_ARG_PTR_TO_MEM arguments
unconditionally demands BPF_READ | BPF_WRITE access. This causes
check_ptr_to_btf_access() to reject standard kernel pointers with -EACCES.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1ccf3b764c515..9045369ba5694 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11405,37 +11414,37 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env =
*env,
[ ... ]
> -	/* This is the catch all argument type of register types supported by
> -	 * check_helper_mem_access. However, we only allow when argument type is
> -	 * pointer to scalar, or struct composed (recursively) of scalars. When
> -	 * arg_mem_size is true, the pointer can be void *.
> +	/* A pointer to a struct without a size argument is classified as KF_AR=
G_PTR_TO_BTF_ID */
> +	if (btf_type_is_struct(ref_t))
> +		return KF_ARG_PTR_TO_BTF_ID;
> +
> +	/*
> +	 * Otherwise this is a fixed-size memory buffer supported by
> +	 * check_helper_mem_access(): a pointer to a scalar or a struct of
> +	 * scalars. The access size is derived from the pointed-to BTF type.
>  	 */
> -	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, met=
a->btf, ref_t, 0) &&
> -	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> -		verbose(env, "%s pointer type %s %s must point to %sscalar, or struct =
with scalar\n",
> -			reg_arg_name(env, argno),
> -			btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
> +	if (!btf_type_is_scalar(ref_t) &&
> +	    !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
> +		verbose(env, "%s pointer type %s %s must point to scalar, or struct wi=
th scalar\n",
> +			reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
>  		return -EINVAL;
>  	}
> -	return arg_mem_size ? KF_ARG_PTR_TO_MEM : KF_ARG_PTR_TO_MEM | MEM_FIXED=
_SIZE;
> +	return KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
>  }

[Severity: Medium]
When get_kfunc_ptr_arg_type() returns KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE for
a PTR_TO_BTF_ID, or when check_kfunc_args() falls through to KF_ARG_PTR_TO_=
MEM,
it verifies the argument as a memory buffer:

kernel/bpf/verifier.c:check_kfunc_args() {
    ...
		case KF_ARG_PTR_TO_MEM:
			if (kf_arg_type & MEM_FIXED_SIZE) {
				resolve_ret =3D btf_resolve_size(btf, ref_t, &type_size);
                ...
				ret =3D check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRITE,=
 meta);
    ...
}

Because check_mem_reg() is passed BPF_READ | BPF_WRITE, it requires write
access. When this goes through check_helper_mem_access() and reaches
check_ptr_to_btf_access(), it will be rejected because atype !=3D BPF_READ:

kernel/bpf/verifier.c:check_ptr_to_btf_access() {
    ...
		if (atype !=3D BPF_READ && !type_is_ptr_alloc_obj(reg->type)) {
			verbose(env, "only read is supported\n");
			return -EACCES;
		}
    ...
}

Could this unconditionally break the newly introduced feature for standard
(non-allocated) kernel pointers? Also, if the BPF_READ | BPF_WRITE flag were
simply changed to BPF_READ to pass verification, could it introduce a
vulnerability since the verifier cannot guarantee that the underlying kfunc
will not write to the buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801074633.1595=
644-1-ameryhung@gmail.com?part=3D15
