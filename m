Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57F299929
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956823; cv=none; b=E3QGF2udQ9292AX/fker6OJ5pZf5SWOOoP1hyj6JOBugEl/giy0uiSizynPXauxr3ZZGH4LpXlmWyNjTVP1x2ZH9ihnY04fJuyRzhGJsbKNxtYoFOb3Asg2VGPViaf1/+cU0A1/XQ3ACQvdKsO5l4kEAmhqqD8d//4A8yloYrhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956823; c=relaxed/simple;
	bh=xmG0BWfc+1+Y2O9NK7PSCgJYD94GOkR9EU6Bnm+1gi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Borf+VirIz28+uun+zFqoxyfrDJL+Ng6+VsWM4CxlfhyOSNPUppqZWv45V12ArxVZxkzqC5VDvvbzrmi7JNwmSjHu4mxa712NvvOuQYAhn6/fmhRVLDKvE0iNpOwqXb4sL1okmzRCZBxVueXedTdZtE9vaF330gYrnkfp9CEm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy6rbG1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy6rbG1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818DA1F000E9;
	Thu,  2 Jul 2026 01:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782956822;
	bh=t+791ZnTgGCjgTqkxrdJhE3YLGU/Bn2XgK/N3eG3fog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gy6rbG1+q5qpHXdbKT/OntPs9FOWEWT77fOOhEeI5SWQbShV21sykL8uETOgxtfH3
	 xB76z6po5zx3fMBrA4CmsAfEI8ofpS70xrf/tLj3blJEnxRRU80iiGojNUb+ksnbV1
	 /UmMHgl1f3SzJtea9hlHWJ0z6YcSYeAF1s0qFMbIrt0aY9s6vEY5OQeUiRurRw51Go
	 iv2rLicK/kx4IhlzC9f0hrxtvjK6Jeq4f03yu415NXqnb01v2vIZ6oGcDCHZayhVza
	 rKXffyLv272CWaTF3cB5A0T0u7tH2M44b2IbNl2n3RBBtlwnjzZ2BSlN5A4PsA2Eha
	 SOS543fw8SwfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/15] arm64/delay: move some constants out to a
 separate header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702013334.140905-4-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
 <20260702013334.140905-4-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 01:47:02 +0000
Message-Id: <20260702014702.818DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in `USECS_TO_CYCLES()` and `RPMH_USECS_TO_CYCLES(=
)` causes incorrect timer cycle calculations for durations in the seconds r=
ange.
--

commit 0184d882315b35a4fce3d21dea0ae947ba4b1d29
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64/delay: move some constants out to a separate header
   =20
Moves some constants and functions related to xloops, cycles computation
out to a new header. Also make __delay_cycles() available outside of
arch/arm64/lib/delay.c. Rename some macros in qcom/rpmh-rsc.c which were
occupying the same namespace. No functional change.

> diff --git a/arch/arm64/include/asm/delay-const.h b/arch/arm64/include/as=
m/delay-const.h
> new file mode 100644
> index 0000000000000..2a5acfb7bff17
> --- /dev/null
> +++ b/arch/arm64/include/asm/delay-const.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

[ ... ]

> +static inline unsigned long xloops_to_cycles(unsigned long xloops)
> +{
> +	return (xloops * loops_per_jiffy * HZ) >> 32;
> +}
> +
> +#define USECS_TO_CYCLES(time_usecs) \
> +	xloops_to_cycles((time_usecs) * __usecs_to_xloops_mult)
> +

[ ... ]

> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index c6f7d5c9c493d..ad5ec5c0de0a3 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -146,10 +146,10 @@ enum {
>   *  +---------------------------------------------------+
>   */
> =20
> -#define USECS_TO_CYCLES(time_usecs)			\
> -	xloops_to_cycles((time_usecs) * 0x10C7UL)
> +#define RPMH_USECS_TO_CYCLES(time_usecs)		\
> +	rpmh_xloops_to_cycles((time_usecs) * 0x10C7UL)
> =20
> -static inline unsigned long xloops_to_cycles(u64 xloops)
> +static inline unsigned long rpmh_xloops_to_cycles(u64 xloops)
>  {
>  	return (xloops * loops_per_jiffy * HZ) >> 32;
>  }

[Severity: High]
This is a pre-existing issue, but does this calculation silently overflow f=
or
durations exceeding a few minutes?

In rpmh_rsc_write_next_wakeup(), the wakeup_us value is derived from the
next hrtimer. During system suspend, the next timer can be hours away, or
even KTIME_MAX if no timers are pending.

The RPMH_USECS_TO_CYCLES() macro multiplies wakeup_us by 0x10C7UL (4295),
and then rpmh_xloops_to_cycles() multiplies that further by
loops_per_jiffy * HZ.=20

On arm64, loops_per_jiffy * HZ represents the arch timer frequency (e.g.,
19.2 MHz on QCOM). This means the intermediate value grows by roughly
4295 * 19,200,000 =3D ~8.24e10 per microsecond. A 64-bit unsigned integer
maxes out at 1.84e19, which means this multiplication wraps around when
wakeup_us exceeds approximately 224 seconds.

This overflow produces a severely truncated timer cycle count, which can
cause the device to wake up almost immediately from deep sleep instead of
sleeping for the requested duration, draining the battery.

Does promoting this flawed logic to a global header via the new generic
USECS_TO_CYCLES() macro in asm/delay-const.h also introduce an
architectural hazard for large timeouts?

> @@ -819,7 +819,7 @@ void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
>  	wakeup_us =3D ktime_to_us(wakeup);
> =20
>  	/* Convert the wakeup to arch timer scale */
> -	wakeup_cycles =3D USECS_TO_CYCLES(wakeup_us);
> +	wakeup_cycles =3D RPMH_USECS_TO_CYCLES(wakeup_us);
>  	wakeup_cycles +=3D arch_timer_read_counter();
> =20
>  exit:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702013334.1409=
05-1-ankur.a.arora@oracle.com?part=3D3
