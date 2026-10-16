Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F33769E6
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135018; cv=none; b=AN7Vp2Gx1SCYBu/eZjfIChofWIBtRTqoekzeDWojMVsTQ5zFYAwY26e82tTdBzZE+e34FXinWoWJ8Y4zBIe5IVChpayhAf4/EMZS3j9EcVu8xk6FV/PWPghcuHSI5YuETuFtLw+gJDemV5/+ocN47rD8nHiOhwVbn6EpcnlOofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135018; c=relaxed/simple;
	bh=+NlLw1Ghj65xPjFw1QKggkrdFjDNzBTO723hm62yiE4=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=oxEJuskUmzcouIs71Tdn5tDBChjs6ZtlW2i78pLt93xtzoSbPi3CY2afo9yKa/4vB18ZzcIEXcQTi/rg88TrdNtLPJeKBzUtTeCP8UGxP/oTu2qofLfBonRO1A1uv5HNx5/Cbb9uhPxJiqhIwSP9qqetbotMnJ3ACovIS6LN9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cahx+w6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cahx+w6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE861F000C4;
	Fri, 16 Oct 2026 07:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792135017;
	bh=d883N0VaezexToukPrjhdPN1Z1xLEY4I7dtY2L8wbTI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Cahx+w6rFQGgfxAiVEsEVlKpJRET3Q/WbDu+uxsigPlIGDcK+X+K+kEKNaU1jcz/r
	 TAJLLlV6B2h5wrV6u3qINJ+Uzz+sNCdodpvoOnXE6aoMp76maQZvx2Ve5mPt7mULrA
	 tDSgNJfJQdkhiL4nAslJUGnIUrkL+eA3sdwUD1SXX5nvkqC34FmiHprZRqARkWQLmG
	 jxdYtF+01CCTeo9XQ8EjfmaWosFxpr13AM5GbvBWqBee8HwSlIKw7+NuQV7Zw9p2J+
	 uOapPFtWV+KrtE1uT3VkvMUyQll5PiSmd36qt8eV8zpLTHvGEYKaJzq16hgzGhvk/u
	 itkesqZvqTbqg==
Message-ID: <sashiko-outbox-173907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 03/16] arm64/delay: move, fixup usecs_to_cycles()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
In-Reply-To: <20261016070837.440748-4-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <20261016070837.440748-4-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:16:56 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] qcom/rpmh: integer overflow in rpmh_xloops_to_cycles() causes prem=
ature wakeups
--

commit cfe9540cf38fefd87b6b20f22814052cba488f5d
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64/delay: move, fixup usecs_to_cycles()

Updates xloops_to_cycles() to use mul_u64_u64_shr() instead of 32-bit fixed
point arithmetic to avoid truncation for delay values larger than ~10s. Also
moves delay constants and functions to a new header and renames colliding
macros in qcom/rpmh-rsc.c.

> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index f881af35ecfc5..dabe0ccba3706 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c

[ ... ]

> @@ -146,14 +146,16 @@ enum {
>   *  +---------------------------------------------------+
>   */
> =20
> -#define USECS_TO_CYCLES(time_usecs)			\
> -	xloops_to_cycles((time_usecs) * 0x10C7UL)
> -
> -static inline unsigned long xloops_to_cycles(u64 xloops)
> +static inline u64 rpmh_xloops_to_cycles(u64 xloops)
>  {
>  	return (xloops * loops_per_jiffy * HZ) >> 32;
>  }

[Severity: High]
Does this code overflow the 64-bit bounds for sleep delays longer than ~224
seconds?

The core arm64 delay code in this patch was updated to use 128-bit arithmet=
ic
(mul_u64_u64_shr) to avoid overflow for delays larger than ~10s. However, it
looks like the old fixed-point math was preserved here during the rename to
rpmh_xloops_to_cycles().

> =20
> +static inline u64 rpmh_usecs_to_cycles(u64 time_usecs)
> +{
> +	return rpmh_xloops_to_cycles((time_usecs) * 0x10C7UL);
> +}
> +

[ ... ]

> @@ -828,7 +830,7 @@ void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
>  	wakeup_us =3D ktime_to_us(wakeup);
> =20
>  	/* Convert the wakeup to arch timer scale */
> -	wakeup_cycles =3D USECS_TO_CYCLES(wakeup_us);
> +	wakeup_cycles =3D rpmh_usecs_to_cycles(wakeup_us);

[Severity: High]
If wakeup_us is derived from the time to the next hrtimer, which could be
hours or days away during deep system idle/suspend, will passing this into
rpmh_usecs_to_cycles() program a prematurely small, corrupted cycle count
into the hardware due to the truncation mentioned above?

>  	wakeup_cycles +=3D arch_timer_read_counter();
> =20
>  exit:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016070837.4407=
48-1-ankur.a.arora@oracle.com?part=3D3
