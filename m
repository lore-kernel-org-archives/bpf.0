Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A852515987
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682050; cv=none; b=VRwFidP96q99ttZsF3yQmdVNFB+Us0q7k4yNFnlVR446HuGvd4te7f5VEicI5O39hbG9BY8pjxuKH9YW9B5PAwqjadgbwwNlhKNZmYx+AL7ydhucgmgvZRaMmtQgsh2KE2qBeRRHI72ZSnXnt190rOhJ1L5SAAzNelK+JnXejz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682050; c=relaxed/simple;
	bh=hfkw7fYPDQOzjgeH7LdcGs6CmE2bOjX3iEFbZltnuck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kxYYQ7m8QJ95kq+cipotlDojs1kQpb8uq97gJXeT0t9ZfuQE0/X3nxcf5ZVp3n79Huj6i7fuPLckEdTD5ZMKj0on+tsJMycMuk4g31miFXOu106/NDL+rkwgH0Q1JJiUMmaUVIS9qmIprrC5J3CrpZgiWc0OnmUtfaKr6jkA17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNGN25dC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNGN25dC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AE51F00893;
	Tue, 29 Sep 2026 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682048;
	bh=at8K9TmkcP6+I6Co1J16jFV6ou5AFY6xl2fSuzwE+AU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nNGN25dCkTAvjXTR9NgEEXUSHts4kbNYCEXl+d2lLPnYX1S54Wxktx4ZgjOA7rUUn
	 w4JO6iEsqNaoFNa/t5MTqU/7qikCZGB/ZDyXIJd2wZm0gG8RuzY3c4K3w3Rq4ZVeQi
	 t3XaY8YfT3vgnme4FrMfRzqBEOFH4hran6ApooBw9TDT8J37CgqTP1KFuy+Jle5Y9u
	 JKfRIHpGjl/4GLoz35zoyNg86rL69lqeoejlXwhr/IsGfx0+NAklwHb1TH1gBGnlUz
	 e7+f/Yt/lfh8Gqd9hFYdaq0QZ2A4wEMupFZSr1hwPzJTtGo/2hXXUV5DAG0rYF0S6Y
	 hRjUvdeuODYBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 03/15] bpf: Accept trusted pointers to kern ctx
 type for kfunc ctx args
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-3-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
 <20260928-bpf-meta-gated-tracepoints-v1-3-844dbf3e1edf@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:40:48 +0000
Message-Id: <20260929114048.D2AE51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: unvalidated PTR_TO_BTF_ID offset in kfunc ctx args leads to O=
OB access
- [Medium] bpf: premature loop exit in check_kfunc_args() leaves meta->ret_=
btf_id uninitialized
--

commit ea1588dd82a28e6c8256a75b8fbee8a46aedb584
Author: Jakub Sitnicki <jakub@cloudflare.com>

bpf: Accept trusted pointers to kern ctx type for kfunc ctx args

This commit updates kfunc argument handling to accept trusted PTR_TO_BTF_ID
pointers for KF_ARG_PTR_TO_CTX arguments, provided they match the expected
kernel context type. It allows passing derived kernel pointers, such as
those from bpf_skb_fclone_twin(), to kfuncs expecting a context pointer.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 41b49c56e1237..da5d6de58650f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12891,6 +12891,23 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
>  			break;
>  		case KF_ARG_PTR_TO_CTX:
>  			if (reg->type !=3D PTR_TO_CTX) {
> +				/* Only accept trusted kernel-context pointers from
> +				 * vmlinux BTF. reg->btf_id is scoped to reg->btf,
> +				 * so a module-local ID could otherwise alias the
> +				 * vmlinux context type ID.
> +				 */
> +				if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID &&
> +				    reg->btf =3D=3D btf_vmlinux &&
> +				    is_trusted_reg(env, reg) &&
> +				    !bpf_type_has_unsafe_modifiers(reg->type)) {
> +					ret =3D get_kern_ctx_btf_id(&env->log,
> +								  resolve_prog_type(env->prog));
> +					if (ret < 0)
> +						return -EINVAL;
> +					if (reg->btf_id =3D=3D ret)
> +						break;

[Severity: High]
Does this code allow a PTR_TO_BTF_ID with a non-zero fixed offset to be
passed to the kfunc?

Earlier in check_kfunc_args(), btf_id_fixed_off_ok defaults to true for
KF_ARG_PTR_TO_CTX. When __check_func_arg_reg_off() is called, it permits
the non-zero offset for PTR_TO_BTF_ID. The newly added explicit type check
here then breaks out of argument checking without verifying that
reg->off =3D=3D 0. Can this allow a user to shift a trusted kernel pointer =
by
an arbitrary offset before passing it to a kfunc, leading to out-of-bounds
memory reads or writes within the kernel?

[Severity: Medium]
Will this break statement prematurely exit the switch(base_type(kf_arg_type=
))
block instead of bypassing just the -EINVAL error condition?

If a BPF program calls bpf_cast_to_kern_ctx() and passes a trusted
PTR_TO_BTF_ID that matches the context type, hitting this break statement
completely skips the explicit initialization block of meta->ret_btf_id for
KF_bpf_cast_to_kern_ctx at the bottom of the case KF_ARG_PTR_TO_CTX block:

    if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
        ret =3D get_kern_ctx_btf_id(&env->log, resolve_prog_type(env->prog)=
);
        if (ret < 0)
            return -EINVAL;
        meta->ret_btf_id  =3D ret;
    }
    break;

Does this leave meta->ret_btf_id uninitialized as 0 (void type), corrupting
the verifier's type tracking and causing valid BPF programs to be rejected?

> +				}
> +
>  				verbose(env, "%s expected pointer to ctx, but got %s\n",
>  					reg_arg_name(env, argno), reg_type_str(env, reg->type));
>  				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-bpf-meta-g=
ated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com?part=3D3
