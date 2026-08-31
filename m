Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7286025228D
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176108; cv=none; b=ZrSRtFlQlozieo0pgPAoGVGCPqseRaI2GuLM0ZcBeE1t26y305jDJGuSs/LX9GwOaB2mcWuxJPoCUbvhUYygQkOxJFfPwLO1wkcNsbkyR1RCrUwayPV3nO4ZbdQP5BgpOHFNwghwAr/DawJfnZZQUID1h/tBQ05R5gYvSk45KtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176108; c=relaxed/simple;
	bh=movMFHi8Wa3n3IR5x5En6DZoiIvKy25Mj3w+ACbuxS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d5UfxLMbn5TeBnmo2eMIcxtqWugKkkoWS3yrevSgB4LqGF5rVJcQtYghf3aiSNDslHyahEhXQDO25V1Nh/0PzMDWgCOeFsOrMJslef31rjceTUh9k3lL5iAsQQN6uLZ5iIyQj0TsWH5X9QXAG9FWXf1HuYuSFHKlCUf4+UAN4y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3ZUfXaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3ZUfXaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C561F000E9;
	Mon, 31 Aug 2026 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788176107;
	bh=0dq4qqCWTn69kgoNt9Xsn5BHcC5yf1R69wnnPHDaHbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3ZUfXaDe9IoH9GffYUC29XbJ3m2aD2vx4q/OGxD0Bwc+5OEMXdhdt5l3Bb590fh/
	 hZ0uGLJGi3XgKCbacLhbyJ9nZDrvibSDN/7+LugDM4RNzc6AeWGhgrbaymVeAYSWj4
	 BNq36x4+FCR1Pmvnst7UW+4LnMAvT+jcRWlFMBx6mKcaeSk+MwLgxAKL7ivQc1TX/Z
	 UtLgB+U2u/rweFssZpvRo5PSO06qEbfDkH69Hb5aRmcFOJdfLmb+3NUAnI97kg3G/W
	 HYQJm7Jh8bfi95Y78087OfIme8PDUpZRbfr28VipCwYc35V/waVolvGbqJC8dgVHuG
	 KOkD411xhz8NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/5] bpf: Fix NULL-ptr-deref when showing a void
 BTF type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831110314.150870-3-jiayuan.chen@linux.dev>
References: <20260831110314.150870-1-jiayuan.chen@linux.dev>
 <20260831110314.150870-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 11:35:06 +0000
Message-Id: <20260831113506.D1C561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] btf_var_show() unconditionally dereferences btf_type_ops(t) which =
can be NULL if a VAR resolves to the void type.
--

commit e40701f4e16b364aff9e3327fa4cdff79bc39336
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: Fix NULL-ptr-deref when showing a void BTF type

btf_modifier_show() resolves the modifier and then calls
btf_type_ops(t)->show() unconditionally. For the void type (type_id 0,
BTF_KIND_UNKN) kind_ops[] has no entry, so ->show is NULL.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index da36d4b9d31ab..81506cbb9f9ae 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -2911,7 +2911,15 @@ static void btf_modifier_show(const struct btf *bt=
f,
>  	else
>  		t =3D btf_type_skip_modifiers(btf, type_id, NULL);
> =20
> -	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
> +	/*
> +	 * A modifier can resolve to the void type (e.g. "const void"), which
> +	 * has no show op (kind_ops[BTF_KIND_UNKN] is NULL). Print a placeholder
> +	 * instead of dereferencing NULL.
> +	 */
> +	if (!btf_type_ops(t))
> +		btf_df_show(btf, t, type_id, data, bits_offset, show);
> +	else
> +		btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
>  }
> =20
>  static void btf_var_show(const struct btf *btf, const struct btf_type *t,

[Severity: High]
This isn't a bug introduced by this patch, but does btf_var_show() have the
same problem where btf_type_ops(t) can be NULL if a VAR resolves to the void
type?

Looking at btf_var_show() in kernel/bpf/btf.c, it also unconditionally
dereferences btf_type_ops(t):

kernel/bpf/btf.c:btf_var_show() {
	...
	t =3D btf_type_id_resolve(btf, &type_id);

	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
}

If a BPF program calls the bpf_snprintf_btf helper with the type ID of a
BTF_KIND_VAR that resolves to void (e.g., __nosave_begin in vmlinux, which =
is
declared as extern const void), could this result in a NULL pointer
dereference?

While later patches in this series address a different NULL pointer
dereference involving btf->resolved_ids within btf_var_show(), it appears
they miss adding this same if (!btf_type_ops(t)) safeguard that was added
here to btf_modifier_show().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831110314.1508=
70-1-jiayuan.chen@linux.dev?part=3D2
