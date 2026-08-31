Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA8390987
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213983; cv=none; b=Ji3PBXxkvU3fambs3elanHXGHzC4s4HaAmayi4g9ZXPgnGIAl+8eznehl1Z/Jsjp7Vj1GtFsBdqP1Il8ggOWqEsPow2XGh1hLdv5lr7kZFmImXYRvO1TxlQHylw0LeZQG5WoB7svPR0/k3/USsj6AD2E3z0x88+82X3/Md7+9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213983; c=relaxed/simple;
	bh=Vz17DqeorHQrzI0/rmeUXX8+dAK9MQoSczAGvuUxSek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sLbENONNhU0QH8otvKfigmMbBUc+UxawVnoCmq2H/7wXznyDPcLxNn/Yd+a61NyUZzXmrMgnvngqk4x+usDUV2HculpkbA0t7k7P4WO26ZJixjU+Z0oXk2UWe1WeEnqN1RQi5MvXxOa5jQzkaAXpRquXb+btwJHYCDeSwYj8CEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGtLt9+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGtLt9+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DA61F000E9;
	Mon, 31 Aug 2026 22:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788213982;
	bh=NdXID5yQRnpXd5yrL1JU831qNGmJUUC4feKPewXfaQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lGtLt9+c8z0X8UbKAeGLM4fJrhrEeO/WhLdjDyDVClmY9sm6Gh+Js9e+Tw8xH/rmC
	 WUHJI5UVkOwZ6W0YpZ1qqHPV5y2zbebAd685hd3eRy2ejKrEvOpQMVPPNImeL+XChI
	 ZpOFHXhvF3R3me0I8bb3M4d9q+FeyViYnCzPCh6AXztDtK77ciI2Ewa6Kvu2ZYCjWJ
	 StLY+lVT5yJgD5IzaI/vSeUmDSjgIPks/sAnlmIT3FaMRe9sGdOcI2XGR9jZLr9GzK
	 FkjXBjzCAiH4dduqMEa9Fb7Fn1sC2ZPHNgCpA6t0prSrjUV6HsIm8N480Qaq/k2ev9
	 1m1DOoYvTX+pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 03/16] arm64/delay: move, fixup usecs_to_cycles()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831202251.305046-4-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-4-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:06:21 +0000
Message-Id: <20260831220621.D6DA61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch fixes =
a 64-bit integer overflow bug in arm64 delay calculations while deliberatel=
y leaving the exact same arithmetic bug unfixed in the duplicated code in `=
qcom/rpmh-rsc.c`, which causes hardware wakeup times to be incorrectly prog=
rammed for sleep durations exceeding ~224 seconds.
--

commit d104dae593c77167ffada79f1a496fa20b5c86dd
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64/delay: move, fixup usecs_to_cycles()

This patch updates xloops_to_cycles() to use mul_u64_u64_shr() instead of
32-bit fixed point arithmetic to avoid truncation for delay values larger
than ~10s. It also moves cycles computation out to a new header, makes=20
__delay_cycles() available outside delay.c, and renames some colliding=20
namespaces in qcom/rpmh-rsc.c.

> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index c6f7d5c9c493d..ad5ec5c0de0a3 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
[ ... ]
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
This isn't a bug introduced by this patch, but while renaming this function=
=20
and macro to avoid a namespace collision, does it make sense to also apply=
=20
the 128-bit math fix (mul_u64_u64_shr) here?=20

The 64-bit arithmetic in rpmh_xloops_to_cycles() still wraps around the=20
maximum limit for large xloops values, which appears to be the exact same=20
integer overflow bug this patch successfully resolves in arch/arm64/lib/del=
ay.c.

[ ... ]
> @@ -819,7 +819,7 @@ void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
>  	wakeup_us =3D ktime_to_us(wakeup);
> =20
>  	/* Convert the wakeup to arch timer scale */
> -	wakeup_cycles =3D USECS_TO_CYCLES(wakeup_us);
> +	wakeup_cycles =3D RPMH_USECS_TO_CYCLES(wakeup_us);
>  	wakeup_cycles +=3D arch_timer_read_counter();
> =20
>  exit:

[Severity: High]
This is also a pre-existing issue, but this seems to be the path where the=
=20
overflow described above causes problems for device power management.

During system suspend, rpmh_rsc_write_next_wakeup() queries the next=20
hrtimer. If the timer is roughly more than 224 seconds away (or if no=20
timer exists, returning KTIME_MAX), wakeup_us can exceed the 64-bit=20
mathematical limit of the inline calculation.

Does this cause an overflow of the u64 intermediate product, resulting=20
in a corrupted, wrapped wakeup time being programmed into the hardware TCS,=
=20
and leading to premature wakeups from deep sleep?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831202251.3050=
46-1-ankur.a.arora@oracle.com?part=3D3
