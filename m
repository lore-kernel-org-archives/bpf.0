Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6734B43F
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572778; cv=none; b=XWCgc8iMPlftKJnwd+ceRRxASIKSvPwAbA3syLXS6QTR01GMFhvFVgJFKKLhT5XFnw+LXwI9jc0fkk0EGcRVu1isgjabn+qqj9tWUNpeDOVFSdSzlaOx0SHiL/4ICohVG+N+JqsHynhxpMentTnPhFjHq2/55K4jqmVTsBPPmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572778; c=relaxed/simple;
	bh=Uob80kUr9wEHyjLUjlOLuNFhCIJCLkT48Zrj0XOBAzE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sXtv8XtwUncoySesh+0ftzFrphyvYWb+HxzMx+a1eA1p6wewd/fAWk4SDL73NVsLBFmqQMwYQ0ULcEL2thhXyTiCIvivS8wiG6rgwME0Q2PCxqXcpT+kfwnNoHcPgs+3dRaXOacuzvoZTP9haAumfiIw4s1XcYW9iu65LHGPD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoSMj33t; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoSMj33t"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1510468a91.2
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786572776; x=1787177576; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=K42ZtyqRxqIE4BrP/xXiTAmysA7aimWjA4lj8iepfIw=;
        b=BoSMj33tbwCKV2gCZ8I8k5EqjJ5WmAPiB+qPLuPpB7g6NY2O89XGrm2V1+cZHnZojM
         GsOFpy8SfBfcyIRNPIHTbe32oR3IHDmWGQ1z5Adu5nEbfQyyTaMDIey3BUc8P1Xwhut7
         edIrVFQJuQNp2Ob71tHeMehSL2FduAPa5qhcPhfZWZkiP0vsTt8DDK5v0Rkb48R/RaqN
         bmIxyjKb3CSCqBWwYylmvBk7tac6kv5Jg8uPrKNcYufYugSEXcNjgyDIMDvPMPaFox9d
         2Z9PN358ccYx9hTQE1mhpn7b0U78kdTlKoTF70r0fu+TVsp6K9K2J4JoYIH0HwIiXesI
         igzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786572776; x=1787177576;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K42ZtyqRxqIE4BrP/xXiTAmysA7aimWjA4lj8iepfIw=;
        b=jzlom5eGsesi+RYCZXUOAFtkOtzWGDYWkCHeaSOO19tNcmkBdud0MkBkES+pyoOoE6
         2//AjuBpCMr+KV7tpOK1MjPd772IhL0xRtUUHMfYhLySj9aIT/ihAgix8zGUgHBfw4+f
         cbMFXMir9nFerYCrRgH+C8I2qW1z2MF+6K95PcU5gnXyReKoYtMqlaFnTNjLsVO0Se75
         FXvHRi/5XtSu0Pw8DEA32/Ri5kOAJgLXrb3y5sf6g7GKGotnMtA45Os2ugOQRYRKSH7f
         sDUrmc+K6Qb2THeJ+B59eDUSGdJbUZKzQLIeADsGUkM+0jEL126wWi0vX4zV8c1cdG5x
         r2ZQ==
X-Forwarded-Encrypted: i=1; AHgh+RociLfA5/3ZMJ+xfIOGc0UBef8iTwZtWnpl6FVTqQCVo9J1MXzL6iDr3C80757C9gKsMfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6fp9XmzHHxYvENcW3RGjlnJ/jsOKteNtNsVVYUux0cm33dqf
	jNCIHsikxTU0gugVVKSPo4Hd3tofZKOridyKDMemVfjEqFQlXPwqf46x
X-Gm-Gg: AR+sD10PBWI/ACF1txuL/pc1x8oldb8Ht0VkmWAlJ0Dqths3rrGJ2FtQ04oj5vZxsjC
	R24e7K3dBtnBf2M+WnYk3lShAaC8o8xgMbkvpatLISFYLUtGzxawirr1iJj7rplbmBSuloXs6y6
	pu/3Y0mlrlDwVh5EhoEuoeuIbGpYkBJps2t39tBmQrNMGCsujSiHdNoW0W8F6mUSk1jq+MnIICA
	gzZrSDrR9x+1Rbb89Kj2jXSG/cDcF/NdDV49lxjmAxdDd28xZ6dUeJxn+KeiwuMc9S3iwjUqjXF
	C2mVxSgABltMzsYZdhZPN98TnLrw98WoYCUry8urG6TOSjx30Cmwmn2G8tmg4Z0oL+SjggfirgS
	/vk9fSByZ1n5BoPmVfsBcNVE5xEiGZszLehip0mTWtg2cUvF+B7X+i3cYeRgHqINnb2UZo4OdbU
	rZ5wlaG36+tpVUhkgx3m7aJVYGZz04jlhk3sCuH5r/0qVDbCJvPv7gcFUgiSxJDaHqD1PgGsnrt
	oqATK4tx6hRrUQMzKDdSvaPjFEOOAX1
X-Received: by 2002:a17:90b:2ccd:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-3931e04a98amr1762185a91.7.1786572775891;
        Wed, 12 Aug 2026 15:12:55 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f41ce3fsm420509a91.10.2026.08.12.15.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:12:55 -0700 (PDT)
Message-ID: <e6f6247b319dde9f055092cd337a61292887b141.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/13] bpf: Add verifier support for 16-byte
 returns in R0:R2
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 12 Aug 2026 15:12:52 -0700
In-Reply-To: <20260811000947.2381981-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
	 <20260811000947.2381981-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:

...

> @@ -9810,10 +9827,14 @@ static int prepare_func_exit(struct bpf_verifier_=
env *env, int *insn_idx)
> =C2=A0	struct bpf_func_state *caller, *callee;
> =C2=A0	struct bpf_reg_state *r0;
> =C2=A0	bool in_callback_fn;
> +	u32 i, nregs;
> =C2=A0	int err;
> =C2=A0
> =C2=A0	callee =3D state->frame[state->curframe];
> =C2=A0	r0 =3D &callee->regs[BPF_REG_0];
> +	nregs =3D bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
> +	if (nregs > 1)
> +		env->prog->jit_required =3D 1;

Definitely let's move this to bpf_compute_subprog_ret_regs()
instead of setting it in multiple places.

> =C2=A0	if (r0->type =3D=3D PTR_TO_STACK) {
> =C2=A0		/* technically it's ok to return caller's stack pointer
> =C2=A0		 * (or caller's caller's pointer) back to the caller,
> @@ -9849,8 +9870,23 @@ static int prepare_func_exit(struct bpf_verifier_e=
nv *env, int *insn_idx)
> =C2=A0			return -EFAULT;
> =C2=A0		}
> =C2=A0	} else {
> -		/* return to the caller whatever r0 had in the callee */
> -		caller->regs[BPF_REG_0] =3D *r0;
> +		/*
> +		 * return to the caller whatever the callee had in the
> +		 * return register(s)
> +		 */
> +		for (i =3D 0; i < nregs; i++)
> +			caller->regs[ret_regs[i]] =3D callee->regs[ret_regs[i]];
> +
> +		/*
> +		 * R2 carries only the upper half of a register pair return
> +		 * value. A stack pointer must not escape the callee (see the
> +		 * R0 case above), but there is no need to reject the whole
> +		 * program for it: hand the caller an uninitialized R2 instead,
> +		 * so that only a caller actually using the returned pointer
> +		 * fails.
> +		 */
> +		if (nregs > 1 && caller->regs[BPF_REG_2].type =3D=3D PTR_TO_STACK)
> +			bpf_mark_reg_not_init(env, &caller->regs[BPF_REG_2]);

Why special casing this? What if caller does not use r0,
should r0 be reset in such a case as well?
Let's handle both r0 and r2 in one place.

> =C2=A0	}
> =C2=A0
> =C2=A0	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to=
 callsite,

...

> @@ -16710,11 +16775,26 @@ static int check_global_subprog_return_code(str=
uct bpf_verifier_env *env)
> =C2=A0{
> =C2=A0	struct bpf_func_state *cur_frame =3D cur_func(env);
> =C2=A0	u32 subprog =3D cur_frame->subprogno;
> +	u32 i, nregs;
> +	int err;
> =C2=A0
> =C2=A0	if (subprog_returns_void(env, subprog))
> =C2=A0		return 0;
> =C2=A0
> -	return check_global_ret_scalar_reg(env, BPF_REG_0);
> +	/*
> +	 * An arena pointer is only a legitimate return value when it is the
> +	 * whole of it, that is when it is returned in R0 alone. Both halves of
> +	 * a register pair carry a piece of a >8 byte scalar, so an arena
> +	 * pointer in either of them is a leak.
> +	 */

Why forbidding returning two arena pointers?

> +	nregs =3D bpf_ret_reg_pair(env, subprog) ? 2 : 1;
> +	for (i =3D 0; i < nregs; i++) {
> +		err =3D check_global_ret_scalar_reg(env, ret_regs[i], nregs =3D=3D 1);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0/* Bitmask with 1s for all caller saved registers */
> @@ -17203,10 +17283,16 @@ static int process_bpf_exit_full(struct bpf_ver=
ifier_env *env,
> =C2=A0	 */
> =C2=A0	if (cur_frame->subprogno &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 !cur_frame->in_async_callback_fn &&
> -	=C2=A0=C2=A0=C2=A0 !cur_frame->in_exception_callback_fn)
> +	=C2=A0=C2=A0=C2=A0 !cur_frame->in_exception_callback_fn) {
> =C2=A0		err =3D check_global_subprog_return_code(env);
> -	else
> +	} else {
> +		if (!cur_frame->subprogno && bpf_ret_reg_pair(env, 0)) {
> +			verbose(env,
> +				"return value larger than 8 bytes is not supported at program exit\n=
");
> +			return -EINVAL;
> +		}

Same as with callbacks, I don't see a reason to check this.
The purpose of the verifier is to avoid loading a program
that would accidentally bring down the kernel, this check
does not contribute towards this goal.

> =C2=A0		err =3D check_return_code(env, BPF_REG_0, "R0");
> +	}
> =C2=A0	if (err)
> =C2=A0		return err;
> =C2=A0	return PROCESS_BPF_EXIT;
> @@ -19366,6 +19452,22 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
> =C2=A0			return -EOPNOTSUPP;
> =C2=A0		}
> =C2=A0
> +		/*
> +		 * An extension replaces the target outright, so it has to match
> +		 * the target's return convention. Its own return value is capped
> +		 * at 8 bytes (a >8 byte program return is rejected at BPF_EXIT),
> +		 * so it can never fill the R0:R2 pair the target's callers read.
> +		 * This cannot be left to btf_check_type_match() above, which
> +		 * compares return types by btf_type->info only: an int carries no
> +		 * vlen, so a 16-byte __int128 and an 8-byte long compare equal.
> +		 */

Should the btf_check_type_match() be fixed?

> +		if (prog_extension && tgt_info->fmodel.ret_size > 8) {
> +			bpf_log(log,
> +				"Cannot replace function %s with a >8 byte return value\n",
> +				tname);
> +			return -EOPNOTSUPP;
> +		}
> +
> =C2=A0		/*
> =C2=A0		 * *.multi programs don't need an address during program
> =C2=A0		 * verification, we just take the module ref if needed.
