Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025191;
	b=HwV+gTRL1CLSPRdYTMQl1wIO1YQEFNl8FQ3ha+Npj2VmOq2c0Kk7cEMmMs+IbigCBH1a
	 5w1zTVFP13QYqkyQdBWqf2LsWpntyqUhv6rdDoCVsWZZVPufW6lHiVS5MeUb22rPCllpl
	 LXBAC4Yp5zL71sBNNixWI32b56rfompnSwcZD7ODRn6mdSGKa0T0Qn7X6F79mGk+j9xIC
	 Zl/hIwAjDydFDZVMcCd3IXa3oCZsdMEW1VtyE4CGXXSaWxXOgNVtsN239wep00mwLaHer
	 UCtzb8aL3V3ZZdMpWYuCZO6hkRE9XHGVL1n/hiYyXPU1QVSSdepbzKdb0bpynFNi3yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025191;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=LpoYeX1ZOnSWzxA9T8Is7xUj6P5sERnfo+uCIm3SR4E=;
	b=n39EGKdH9WpWTtd6OLb8kOdAHqjaqgN+6zTJBM+1oC+eObry1lNDsmg+gd0o529U5P29
	 +0jPTJ/mJqtuh98t1v565/lBDNtBnX447WYg1pmafW+OjaMkYHVkUOEMMZZPKtfqxdx78
	 irJ+RPnK+BaxegNYP+M+pnRrTjGMgamm3Wt/4TMqXy9V+KEKWSNImT8vEgeei4zyBVwNV
	 YkewejAM8pgLG2SMy2IVg/KNNmSFcMY+JoKdyU2j8PCdlg7KvnJHd5G65KPP2D1YZ6v15
	 jxZKOvSpkT/uKOqP6l/F2uFPRYFyQubQoEOHwXWKhgbZoOcK3s8MfuNsGYOEp3RrSpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhGfQtgn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF893606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhGfQtgn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D051F0089F;
	Sat,  7 Nov 2026 04:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025190;
	bh=LpoYeX1ZOnSWzxA9T8Is7xUj6P5sERnfo+uCIm3SR4E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FhGfQtgnu7XwM3qC41Y9tgb98uncs0NUrxM2vb4Bwtq0h+mH9hA+flq8FqEaFvSJb
	 NpgEIWrczHhhlT8UhYKiKI1nilPCjHFJK/ae0AoFlcIogpIyEqQL7tgk9cfigGzIKx
	 GZ3yn56aEKw1/btgpcSNSjIpNyOtmHykvX/2sRQ+Yhupo2l9GxsatRbE5/toJlRQPK
	 7YZQnnuLfiNVEs6mqbmxqLe9KpHUqv3ElMBGloGBiCDBtg5wN/3IZSf4jEQe8Sf3xa
	 iLeqMfNA3KmDc0ROJDX/QojJsncDmfrAmjlhdc58c55RIE/n2dNqAt54jcR7sJsuOs
	 FYLRnjhfIr2Vg==
Content-Type: multipart/mixed; boundary="===============8323629463649473276=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <edee5aacb1b472eb4130a443aef2252d4882b9dc52c6bf55f5b25964002418dd@mail.kernel.org>
In-Reply-To: <20261107033758.1547725-4-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v4 03/46] bpf: Add union and widening of the range of a register
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  7 Nov 2026 04:19:50 +0000 (UTC)

--===============8323629463649473276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add union and widening of the range of a register

TL;DR: Not a bug, but bpf_reg_union_range() duplicates the union lines of
bpf_reg_union() and computes the step differently; the review asks whether
bpf_reg_union() could reuse it so the step logic lives in one place.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +void bpf_reg_union_range(struct bpf_reg_state *acc, const struct bpf_reg_state *src)
> +{
> +	bool acc_const = cnum64_is_const(acc->r64), src_const = cnum64_is_const(src->r64);
> +	/* A constant is its own base. Its step is 0: every number divides 0. */
> +	s64 a = acc_const ? cnum64_smin(acc->r64) : acc->base;
> +	s64 b = src_const ? cnum64_smin(src->r64) : src->base;
> +	u16 step = gcd(acc_const ? 0 : acc->step, src_const ? 0 : src->step);
> +	s64 diff;
> +
> +	acc->r64 = cnum64_union(acc->r64, src->r64);
> +	acc->r32 = cnum32_union(acc->r32, src->r32);
> +	acc->var_off = tnum_union(acc->var_off, src->var_off);

this isn't a bug, but these three union lines repeat the ones in
bpf_reg_union() word for word, and the step is then computed with a
different rule (gcd(s, t, a - b) here, versus gcd(s, t) with a fallback to
step 1 when the bases disagree in bpf_reg_union()).

Could bpf_reg_union() be written as the compatibility check plus
bpf_reg_union_range() plus reg_bounds_sync() and the sanity check, so the
step-union logic lives in one place?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42335829855
--===============8323629463649473276==--
