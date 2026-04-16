Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC663E51F3
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368005; cv=none; b=uI3RJ3Ipcf+A+YORqmPes5tgx/e49z9ERjuOxr8riM5PIIcn4Ugedp/bN9mupMeV7Mz4f7fcz/Od4WR7HPJ0i/vZmKSgmsGvm7QAWSeiosEuh4OvjHbluf8Vxdg/AvpHGWyi1C492XEhdHLSFVBuGwsmUCLe9k7GqDjWtuOWvSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368005; c=relaxed/simple;
	bh=+Adh9PgpGwbkO+gG3lCF7j8rlc/ihjDoWqM29RWO88M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fT1uuTfl7C9oLWq8M9ZdHK09dMToD6aiX21Pe+x9/InRVWzW4oYk9w2uM7V/FWgDeAoL+9cphsEX9RzO6He3OaPvusxVCeOIWqtfbzxPWuDXwc1sZdbUajnAjAXkjQVFVU6jbdsqMhp4U4I+nHZi5/Vje1pak0M9ml5ibbN5480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPeFC3wE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPeFC3wE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED9DC2BCAF;
	Thu, 16 Apr 2026 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776368005;
	bh=+Adh9PgpGwbkO+gG3lCF7j8rlc/ihjDoWqM29RWO88M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pPeFC3wEPpWrEHhGU/oOoGSMeso+BthYZ7Q06EFtbyBg94bUsdOmu7m/pVAmlkHY5
	 2dOnVvmyk664DJ1bk5g3Ny5fVYTGHtElUBU5XiasJw0uIuYbsfqeK/zXsJ2mWTCr/k
	 cAyz8p5vbgk2isMKMAdMmLH5yeb3etOt9UUcE+3I4vUsf9eMLWx/Z+ujQXEBE0Bbf2
	 FyodpekbpqY2s7q67nx7SFHFakiYz3aeoD9lLA16n57gAonRIUeg1MqkSuS/jp57+4
	 h+AuMFtCQnZXIRjvI9kY6hnXVtv3tDk1B24E/VFDcvBscJT1/HkE3eO9yMgpqk06VX
	 A2VgZaLDkBZ3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/7] bpf: Improve 64bits bounds refinement
 from u32 bounds
Reply-To: sashiko@lists.linux.dev
To: "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <b2a0346a5b0818008503b721c62621918d84ad0a.1776344897.git.paul.chaignon@gmail.com>
References: <b2a0346a5b0818008503b721c62621918d84ad0a.1776344897.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 19:33:24 +0000
Message-Id: <20260416193325.2ED9DC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The test framework simulator `prog_tests/reg_bounds.c` introduce=
s unconditional early returns, preventing simultaneous refinement of bounda=
ries and causing divergence from the verifier.
--

commit 12b1f0ea2a161fbaa54af860eb0602fc32004fbd
Author: Paul Chaignon <paul.chaignon@gmail.com>

bpf: Improve 64bits bounds refinement from u32 bounds

This commit improves the refinement of 64-bit bounds from u32 bounds in the
BPF verifier, tightening the umin64/umax64 and smin64/smax64 values when
their lower 32 bits fall outside the known u32 range. It also updates the
selftests bounding simulator to match this logic.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1d5d2b7e5140b..bcf8a38a4d720 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -2273,17 +2273,51 @@ static void deduce_bounds_64_from_32(struct bpf_r=
eg_state *reg)
[ ... ]
> +	umin_32lower =3D reg->umin_value & 0xffffffffULL;
> +	if (umin_32lower < reg->u32_min_value || umin_32lower > reg->u32_max_va=
lue) {
> +		new_umin =3D (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
[ ... ]
> +		reg->umin_value =3D new_umin;
> +	}
> +	umax_32lower =3D reg->umax_value & 0xffffffffULL;
> +	if (umax_32lower < reg->u32_min_value || umax_32lower > reg->u32_max_va=
lue) {
> +		new_umax =3D (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
[ ... ]
> +		reg->umax_value =3D new_umax;
> +	}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index c0b3a357a0f4c..d38550fc16240 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
[ ... ]
> @@ -518,8 +518,8 @@ static struct range range_refine(enum num_t x_t, stru=
ct range x, enum num_t y_t,
>  			 */
>  			if (xmin_swap < x.a)
>  				xmin_swap +=3D 0x100000000;
> -			if (xmin_swap =3D=3D x.b)
> -				return range(x_t, x.b, x.b);
> +			if (xmin_swap !=3D x.a)
> +				return range(x_t, xmin_swap, x.b);
>  		} else if (xmax_lower32 < y.a || xmax_lower32 > y.b) {
>  			/* Same for the umax64, but we want to *decrease*
>  			 * umax64 to the *maximum* value that matches the u32
> @@ -528,8 +528,8 @@ static struct range range_refine(enum num_t x_t, stru=
ct range x, enum num_t y_t,
>  			xmax_swap =3D swap_low32(x.b, y.b);
>  			if (xmax_swap > x.b)
>  				xmax_swap -=3D 0x100000000;
> -			if (xmax_swap =3D=3D x.a)
> -				return range(x_t, x.a, x.a);
> +			if (xmax_swap !=3D x.b)
> +				return range(x_t, x.a, xmax_swap);
>  		}
>  	}

Since the actual verifier logic in deduce_bounds_64_from_32() evaluates and
updates umin and umax sequentially, should the simulation logic here allow
both bounds to be refined simultaneously?

By using an "else if" and immediately returning when the lower bound is
refined, won't the simulator skip upper bound refinement entirely and produ=
ce
looser expected bounds than the verifier's actual output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1776344897.gi=
t.paul.chaignon@gmail.com?part=3D4
