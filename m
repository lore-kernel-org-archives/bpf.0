Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C393ACA75
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906931; cv=none; b=pXKg3Rv1ZNRHVZJ0u6R8nazO94R4FCeEWdlHbtlDqmPe7p5k17AjRUiAgSVDRrw7QdaQi9BjtzE9dtqH/VhsP37GHvdW3W4QY5vz2Znbm4rY1YEwd0Qqw7n7O0qwtmZyiCQNeb+ibyTu/DWTdMTwfxeTmMZKv+/T7b28iEoLOi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906931; c=relaxed/simple;
	bh=9EatgNzRlrzvOCg6toTqMXh0hZ5O+OyeMIYbIZdHtyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZfeZN1VXIGmTboKkAu2Cq+W7g1JarWEm/RdykfV5q6DimXDaDQYE1+wlg3aUqjhwCETFWXUKnyLckACpU3cUmvi6HOJHOQShn6/c3Y9nQ27VBYDGy2zQRtUuOqpvXGKpDeNXPFhsc2losRVOPJr7sDa+wXpKEgdh2KlafvjLz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQr8PTFO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQr8PTFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4151F00898;
	Mon,  8 Jun 2026 08:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780906928;
	bh=/3Os5gXhiIDUvDuL+5vagjPaDAGFNCYZN1P5+ZZpd0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RQr8PTFOUCbZL9tiSP1YlPoLe6CaWN48VFYaNk7Rz2GF38t0SW2joUp7nLlnIoJAg
	 uDqqOpLnrdnlEkzBVXZkUHEZ7/BJAl5HV9vwlFy3AWhCNBo+tkaGL/TMHFV7aGt+Ni
	 L/FPC0WVtQy4Sgas63akbm9g8lds1mk8p770XYVEaIqZoyOmxslQN1sdcq6kgwqJKA
	 5EVERoFIQjQBRFJyagNceW5dJXCo5FSORtqQFs2JklwHZfal9wPyg4gbssQAqg6F/z
	 ZP7ojxDHqYdGYWCdc5N2UqXputgNWyCNQ+RfofUNoL80A2oadCL/SQ4kFr4O1U7zvI
	 Xnzfc7yNu8gOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/15] arm64/delay: move some constants out to a
 separate header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608080440.127491-4-ankur.a.arora@oracle.com>
References: <20260608080440.127491-4-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:22:08 +0000
Message-Id: <20260608082208.8B4151F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in RPMH_USECS_TO_CYCLES causing premature wakeup =
from cpuidle for sleep durations > 223 seconds.
--

commit 9dcd4c7ce0611e9eee2b5361157ecadfee51f77d
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64/delay: move some constants out to a separate header

Moves some constants and functions related to xloops, cycles computation
out to a new header. Also make __delay_cycles() available outside of
arch/arm64/lib/delay.c.

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
This isn't a bug introduced by this patch, but does the multiplication
in rpmh_xloops_to_cycles() overflow for large sleep durations?

On Qualcomm ARM64 SoCs, loops_per_jiffy * HZ evaluates to the arch timer
rate, typically 19.2 MHz. The intermediate 64-bit multiplication will
overflow the 64-bit boundary if wakeup_us exceeds approximately 223
seconds.

[ ... ]

> @@ -819,7 +819,7 @@ void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
>  	wakeup_us =3D ktime_to_us(wakeup);
> =20
>  	/* Convert the wakeup to arch timer scale */
> -	wakeup_cycles =3D USECS_TO_CYCLES(wakeup_us);
> +	wakeup_cycles =3D RPMH_USECS_TO_CYCLES(wakeup_us);
>  	wakeup_cycles +=3D arch_timer_read_counter();

[Severity: High]
This is a pre-existing issue, but what happens in rpmh_rsc_write_next_wakeu=
p()
when there are no pending timers?

If dev_pm_genpd_get_next_hrtimer() returns a maximum timeout value,
wakeup_us would severely overflow the 64-bit bounds in RPMH_USECS_TO_CYCLES=
()
multiple times.

Could this overflow cause the macro to return a wrapped, drastically
smaller cycle count, which is then added to arch_timer_read_counter()
and written to the RSC timer registers, causing the SoC to wake up
prematurely from cpuidle instead of remaining in deep sleep?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608080440.1274=
91-1-ankur.a.arora@oracle.com?part=3D3
