Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B28335F60A
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786579142; cv=none; b=vF9/Eh9ldvhLzNczkD2dseb3eMm/b1g71eUNp4CSrWMl3UagDNrbb9JMNgItsr9R7Wu3B2NmO3PjB8BLDuT1ECDOkzMzDwbCis9PDnvQaKw+hbdEpAH1QQOWMXuCfofETyfg+wGIec8GcpfpYf/RyIykYj/B4Ew3hIbNZvoIbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786579142; c=relaxed/simple;
	bh=0B9Yc0naEnKFqRoL4pnnFhzNouoecAmSP1aOMpY+kzU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZqZPcaA8HC/HXQefEM33q1HUlRziQd0uVh8rD/6tlk6Akc1d9FiRIZ0r3a4vRqnV8bGqNcvsNJ2Uo5n+qF3Ro3Q0ijUEuD0UVzZyzKYLgm1dqhONhrlOlw7j6XFnfcWUnKD+8nF85LCkN3JB3xbLtdjdK2pT3Px2V3Fgo92RSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmHBB8/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmHBB8/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789091F000E9;
	Wed, 12 Aug 2026 23:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786579140;
	bh=2ONvILSBqjNkEA0FOegzObgafJzi5n23zEjvz6oWdOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TmHBB8/36Vf5LDw8yEKR+L7VugS4vYD+W2JYhq7TYzK8Q3gxC+Zh+6YJZD/uzbJPi
	 vzDbMC7fgSrO5fQE4dYM/GCoHSZnuc4T0DTiXfrJu8XqnhJPJP7IJDuWpKaeAH5fIG
	 KECQPdPEpCLlYHS91TGyfX7yR4csZcSiwi0yg7zAhyNVaMpkQbPrQp0n39pQiIP0fJ
	 izuCHPBqLIheEZH7fXKqk8JRG6fzsRQIekxLiP5OY+xgU6wf5EGLcI1vVKEkHe6Lmw
	 EVQz7gfVQkUli3hp4raRto5DUTmMyFSZPDPHumZZ1oln1rs8XeqjPKbDWkUEjF8iZV
	 N18CokARnkLMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 11/16] bpf: Report Call Type Safety argument
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812233326.3575958-12-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
 <20260812233326.3575958-12-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:58:59 +0000
Message-Id: <20260812235900.789091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Uninitialized variable `ref_id` used in `check_kfunc_args` for n=
on-pointer release kfunc arguments.
- [Low] Incorrect diagnostic message for kfunc fixed-size memory arguments =
failing bounds checks.
--

--- Patch [11]: [PATCH bpf-next v4 11/16] bpf: Report Call Type Safety argu=
ment errors ---
commit ea19a04c0e142c86cd13b8e8524d76e024167249
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Call Type Safety argument errors

Augment selected helper and kfunc argument-contract failures with Call Type
Safety reports. Keep the existing terse verifier messages and add reason,
source context, causal register or stack-argument history, and targeted
suggestions.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 24ae3cb38f6d8..7e28f4d9f5c4d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12361,29 +12437,43 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
> =20
>  		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> =20
> -		if (btf_type_is_ptr(t) && (bpf_register_is_null(reg) || type_may_be_nu=
ll(reg->type)) &&
> +		if (btf_type_is_ptr(t)) {
> +			ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
> +			ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
> +		}
> +
> +		if (btf_type_is_ptr(t) &&
> +		    (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
>  		    !type_may_be_null(kf_arg_type)) {

[ ... ]

>  		}
> =20
>  		if (regno =3D=3D meta->release_regno && !is_kfunc_arg_dynptr(meta->btf=
, &args[i]) &&
>  		    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
> +			const char *expected_type;
> +
> +			expected_type =3D diag_btf_type_name(env, btf, ref_id);

[Severity: Medium]
Could this result in using an uninitialized ref_id? If a module registers a
kfunc with KF_RELEASE that takes a non-pointer argument, btf_type_is_ptr(t)
would be false, skipping the initialization of ref_id.

Then, on the release argument mismatch path here, diag_btf_type_name() would
read uninitialized stack memory from ref_id, which might lead to out-of-bou=
nds
reads in btf_type_by_id() or leak stack contents into the verifier log.

[ ... ]

> @@ -12706,8 +12863,17 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
>  					return -EINVAL;
>  				}
>  				ret =3D check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRI=
TE, meta);
> -				if (ret < 0)
> +				if (ret < 0) {
> +					const char *expected_type;
> +
> +					expected_type =3D diag_btf_type_name(env, btf, ref_id);
> +					diag_call_arg_fmt(env, insn_idx, argno, func_name,
> +							  "Pass stack, map, context, or other verifier-known memory of th=
e expected type and size, not an integer cast to a pointer.",
> +							  "the kfunc expects %u bytes of memory for %s, but it is %s and =
not verifier-known memory",
> +							  type_size, expected_type,
> +							  bpf_diag_reg_type_plain(env, reg->type));

[Severity: Low]
Does this emit a misleading diagnostic when the bounds check fails? If a kf=
unc
takes a fixed-size memory argument and the BPF program passes a valid
verifier-known memory pointer (like PTR_TO_STACK) but the buffer is too sma=
ll,
check_mem_reg() returns an error.

This diagnostic would then unconditionally claim the argument is "not
verifier-known memory" and advise not to pass an "integer cast to a pointer=
",
which obscures the actual bounds-check issue.

>  					return ret;
> +				}
>  			}
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812233326.3575=
958-1-memxor@gmail.com?part=3D11
