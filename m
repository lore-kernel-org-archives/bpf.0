Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1031EFF8D
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785572242; cv=none; b=I+sH3xm6BGGC+fQYh18srOfQfImf9d4yhHJSsPqeKA3E+kVbdbATWl/0GhI7eMFcrf228uSadm0Zi+4zux5kLm6OCB6KHVh/sHVtqAOhwgNAY5kjD0LzRRBvtMCJ3RAWSNcnrKp4hEe3OkHkSbkLGq2RxyrpXForDFvy2WtNnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785572242; c=relaxed/simple;
	bh=QI9nLXTa9zvtQCDmxHqwWFh301i4Br6mvV/vttiHjPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JLnhFDUmDlK2m8EtzKy+2kLGObM24cXNXXqIKyUszcnKSajaFVeEffvm01yWAjVhcib5YFk0E5eF5C8kGVSvBHXMfyBM0R0ZcIKRbGNrkBYiqvi11KNtCgdzdbYECQlg84QfyCZY6bS76ug9ey1GC+WPnrQpiOfEs1/GXzQEs1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gABBMQV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gABBMQV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132401F00AC4;
	Sat,  1 Aug 2026 08:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785572241;
	bh=WPfHahc3m3oDauoQf9pvRdz+UEOc5J/9eUJZ55Wnd80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gABBMQV7Nbz96IjT+FbIDPAZYF8yb/Rf4QEPCsfB9+/NAHa1sxxfKa+aXez3xmEqr
	 x06wDgALf3x1FYFzR5sIeuRRGuVzYPZL0maaIojOdNUwaZgI7LnA206B22n9a6MDqu
	 KG8JRHxK5HBvOAYBOIDIIN0HrtR6TVl+HduMh1Xnl7CHuVLNgh917PXsKlM4uLwc4p
	 wk/fGQew0BegK8Yig1hFe1UkiIpZPv622B3qKMDHWPryEuaOPh9WHsENVVi8rQUGvb
	 yuSgnfh9+QQdYnmphVwz/orxg7IgIOGW/u5dfBhtN0YjMxJwxHEWHOI+jLxh3ELSS9
	 a9nbxsaZorbpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 08/18] bpf: Check fixed-size mem args of
 helpers and kfuncs the same way
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260801074633.1595644-9-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
 <20260801074633.1595644-9-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 08:17:20 +0000
Message-Id: <20260801081721.132401F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Kfuncs taking uninitialized memory arguments via the `__uninit` an=
notation are falsely rejected when passed uninitialized stack slots.

Pre-existing issues:
- [Critical] The verifier fails to check if the size argument for `KF_ARG_P=
TR_TO_MEM_SIZE` kfuncs is a scalar, allowing BPF programs to pass kernel po=
inters as size arguments, leading to an out-of-bounds access.
--

--- Patch [8]: [PATCH bpf-next v3 08/18] bpf: Check fixed-size mem args of =
helpers and kfuncs the same way ---
commit bcee13ba62b78a9328164e2486f3c31a7fddb8a0
Author: Amery Hung <ameryhung@gmail.com>

bpf: Check fixed-size mem args of helpers and kfuncs the same way

Fixed-size memory arguments went through two paths: helpers called
check_helper_mem_access() directly, while kfuncs and global subprogs
used check_mem_reg(). Route the helper MEM_FIXED_SIZE case through
check_mem_reg() too so all three share the same check.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f61771e2a8b27..9e0c7f0a15c15 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12379,7 +12385,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_call_arg_me
>  					ref_tname, PTR_ERR(resolve_ret));
>  				return -EINVAL;
>  			}
> -			ret =3D check_mem_reg(env, reg, argno, type_size, meta);
> +			ret =3D check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRIT=
E, meta);

[Severity: High]
Does this change break BPF programs that pass uninitialized stack slots to
kfuncs using the __uninit annotation?

Because check_mem_reg() is now unconditionally called with
BPF_READ | BPF_WRITE here, it seems to mandate initialization for __uninit
kfunc arguments as well, which should only require BPF_WRITE.

>  			if (ret < 0)
>  				return ret;
>  			break;
>  		case KF_ARG_PTR_TO_MEM_SIZE:
>  		{
>  			struct bpf_reg_state *buff_reg =3D reg;
>  			const struct btf_param *buff_arg =3D &args[i];
>  			struct bpf_reg_state *size_reg =3D get_func_arg_reg(caller, regs, i +=
 1);
>  			const struct btf_param *size_arg =3D &args[i + 1];
>  			argno_t next_argno =3D argno_from_arg(i + 2);
> =20
>  			if (!bpf_register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->b=
tf, buff_arg)) {
>  				ret =3D check_mem_size_reg(env, buff_reg, size_reg, argno, next_argn=
o,
>  							 BPF_READ | BPF_WRITE, true, meta);
>  				if (ret < 0) {
[ ... ]
>  			}
> =20
>  			/* Skip next '__sz' or '__szk' argument */
>  			i++;
>  			break;

[Severity: Critical]
This isn't a bug introduced by this patch, but does the verifier fail to
enforce that the size argument is a scalar for KF_ARG_PTR_TO_MEM_SIZE?

The loop uses i++ to skip the next iteration, which completely bypasses the
btf_type_is_scalar validation for the size argument. check_mem_size_reg()
also assumes the register is a SCALAR_VALUE without verifying it.

If a BPF program passes a pointer register (like PTR_TO_STACK with a zero
offset) as the size argument, reg_umax evaluates to 0, which passes the
verifier's size checks. At runtime, the full kernel pointer address could be
used as the size, potentially allowing an out-of-bounds memory access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801074633.1595=
644-1-ameryhung@gmail.com?part=3D8
