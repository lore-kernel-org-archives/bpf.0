Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD40064
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786280; cv=none; b=MUTqE4JyHTNel27joiwxpZ8/hXLpSL1s5YyOlSIrPTru3MDKLd4wi5DSG1G4f0LwC7yacTvq0e+Hg35d8gera13f9LTFeuzT3A2uyutpK07rtWhKyAYWAzUs5eE9QRFchpzNcVezA35rEcj783pKHzGajZ/lEfdfd+ze7/CUXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786280; c=relaxed/simple;
	bh=OFfRdr1v1ELGYQtaCXx1WGrV9kyUyIQFSDUxeLnYCYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KXOFWpQnwHUFIT9no8sl3sXYN3G0V3EAFTYPM8Yjy3nkPct5kaheSn9RYkvXf9OHPpiSal3ErvvnaCVsw9C69yGT8G0odxiMJ76aC6ajA9Dchh3IyV/a1At0I0uERVpMQtcrI7mJK4rfZHMB0S7wtng2wqueGTZ8Jl5Q3JBTcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmov8LST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmov8LST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7201F000E9;
	Thu, 23 Jul 2026 05:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784786278;
	bh=adoch+g9JRABPk8ICP08gycAZpDqyEiPPWjYDQMZs58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pmov8LSTCRxxcmLdBoh538yxZICWSZkG4bilJcaDFOehb5YEKKPP338sdJBBtVLvL
	 CWmCHMXRvT5zr8uUN5pz5PGAiXm98rkAy8ccGyfqy7zDa7mXF6g8DLbl/6Q2K0a6p/
	 DREQoJ4zCxzi8K4bBm9Ft0PU7/pMRq4suge1RV2CWCrRE0rEUeDcJazi8hBCVU1ebv
	 5BZUHJWgyQojvelBvmGneG9M59ZsUrXzS+4QlFbaRh50CSK/f5e/GFu4JWwHj+E2Ft
	 cBXEDVCVtrQsg2osW7EXh42GmkDN4jNAc/MHi9T9lWAmZd3dl0jXdwqj3ZB0wKZKEW
	 tIfN23T1XFVGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 07/18] bpf: Check fixed-size mem args of
 helpers and kfuncs the same way
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723050806.1158442-8-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
 <20260723050806.1158442-8-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 05:57:58 +0000
Message-Id: <20260723055758.5F7201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Global subprograms incorrectly accept NULL pointers for non-nullab=
le ARG_PTR_TO_MEM arguments, leading to kernel NULL pointer dereference.
--

--- Patch [7]: [PATCH bpf-next v1 07/18] bpf: Check fixed-size mem args of =
helpers and kfuncs the same way ---
commit 878ed5f4f87b10a9bf04aa450c46f6f99550d430
Author: Amery Hung <ameryhung@gmail.com>

bpf: Check fixed-size mem args of helpers and kfuncs the same way

This commit consolidates the fixed-size memory argument checking for helper=
s,
kfuncs, and global subprograms by routing the helper MEM_FIXED_SIZE case
through check_mem_reg. It also resolves a bug where passing a NULL to an
argument marked PTR_MAYBE_NULL | ARG_PTR_TO_FIXED_SIZE_MEM would falsely
reject the program.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6520742d51b58..be5d93c0da813 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6941,11 +6941,14 @@ static int check_mem_size_reg(struct bpf_verifier=
_env *env,
>  }
> =20
>  static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_st=
ate *reg,
> -			 argno_t argno, u32 mem_size, struct bpf_call_arg_meta *meta)
> +			 argno_t argno, u32 mem_size, enum bpf_access_type access_type,
> +			 struct bpf_call_arg_meta *meta)
>  {
> +	/* meta->btf is set only for kfuncs; a NULL meta means a global subprog=
. */
> +	bool helper =3D meta && !meta->btf;
>  	bool may_be_null =3D type_may_be_null(reg->type);
>  	struct bpf_reg_state saved_reg;
> -	int err;
> +	int size, err =3D 0;
> =20
>  	if (bpf_register_is_null(reg))
>  		return 0;

[Severity: High]
This isn't a bug introduced by this patch, but does this early return allow=
 a
NULL pointer to bypass memory access bounds checks and type validations when
the register is a constant 0?

[ ... ]

> @@ -9257,7 +9261,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env, int subprog,
>  			ret =3D check_func_arg_reg_off(env, reg, argno, ARG_DONTCARE);
>  			if (ret < 0)
>  				return ret;
> -			if (check_mem_reg(env, reg, argno, arg->mem_size, NULL))
> +			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRIT=
E, NULL))
>  				return -EINVAL;
>  			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)=
) {
>  				bpf_log(log, "%s is expected to be non-NULL\n",

[Severity: High]
This is a pre-existing issue, but if a caller passes a hardcoded NULL
(SCALAR_VALUE of 0) to a global subprogram expecting a non-nullable
ARG_PTR_TO_MEM, check_mem_reg returns 0 immediately.=20

Because the SCALAR_VALUE type does not have the PTR_MAYBE_NULL flag set,
this subsequent bitwise check in btf_check_func_arg_match:

!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)

will fail to catch the NULL. Could this allow a global subprogram to
incorrectly accept and dereference a NULL pointer at runtime, resulting
in a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.1158=
442-1-ameryhung@gmail.com?part=3D7
