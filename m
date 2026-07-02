Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D652D6401
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957013; cv=none; b=urF1ZYjy/N0M+iPjVDOuYeHsbUpfwwo1sM3dz5s5LJnkiGsxX+BMBRrPi+J+pRvu4aqj94dsbPG9aasW9F8v95F3vBe/5B0Is9Lcrvn+bfN+1OqN2s1e0EHLBcgAammhCsBO7P0VwsZI3EgcPhvNOGUaU0WBkjMHszSwmzy3g6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957013; c=relaxed/simple;
	bh=mKlkIWuRP5bg3SP1UqX6bPyXHuuUis1/swOjhKFamig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iXJj0eaXF3lPNfHYKCs3U3juNBsVC53K3IrJFgtUSGYc6zyYF6bhbYblHS1XyGrH9aQyQa9l3SXvbHOcKwPq6zwVFPQlvWbHG9+r3/miWj4CHNTFbXGXumesArEifiG+SWFaC5iLunLgBXkDcoRLY82+UYwLg36ZKmRW1W4gFjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dedat3P/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dedat3P/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06211F000E9;
	Thu,  2 Jul 2026 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782957012;
	bh=Nj15cQakqMSoeHH+Ge3vNluFMf/3Ey5UL7BFeukMmRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dedat3P/63/635seaSrwOquSXkzDDm2Pl4vIURhBUjiY9NPqx7ls5EhtUFOpVgwLS
	 oM63fTNmW63ZfoUZzwHBEKZJgBkps8+dg7LAGwaEVt/OLRjqgked6bmWZ+YE3pgwMc
	 014t+FYPj7uFGO0eLtLDmWhP7XdFAPmE+RLP+Ax/8Fy/2vsMsLERnUFtqfiiSoQyUA
	 cT3sjDtTX2Wi0Whjt3dYaDgZ/5sxSvFX5y64VNViHLGUAWb4CAStjP+adCjZi9TSmR
	 Nf1pkZA7WxvsXdi4IDr+Wv55nw/P0PAMFdpCc8RwPKjKwvMrq8QE9bGLmlzr82itvS
	 paWY34OEIrRzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 02/15] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702013334.140905-3-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
 <20260702013334.140905-3-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 01:50:11 +0000
Message-Id: <20260702015011.F06211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The macro `cpu_poll_relax()` references `arch_timer_evtstrm_availa=
ble()`, which is not exported to loadable modules, causing module build fai=
lures.
- [Medium] Hardcoding `SMP_TIMEOUT_POLL_COUNT` to 1 severely degrades spin-=
wait performance in the fallback path when the event stream is disabled.
--

commit 906c27d3b9d6d75543755daf442e8912be30a6da
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64: barrier: Support smp_cond_load_relaxed_timeout()

This commit adds support for smp_cond_load_relaxed_timeout() on arm64 by
utilizing __cmpwait_relaxed(). It restricts this path to when the event-str=
eam
is enabled to prevent blocking indefinitely, falling back to cpu_relax()
otherwise. It also sets SMP_TIMEOUT_POLL_COUNT to 1.

> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/ba=
rrier.h
> index 9495c4441a46b..6190e178db51f 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h

[ ... ]

> @@ -219,6 +220,26 @@ do {									\
>  	(typeof(*ptr))VAL;						\
>  })
> =20
> +/* Re-declared here to avoid include dependency. */
> +extern bool arch_timer_evtstrm_available(void);
> +
> +/*
> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxe=
d()
> + * for the ptr value to change.
> + *
> + * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
> + * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
> + * time-check in each iteration.
> + */
> +#define SMP_TIMEOUT_POLL_COUNT	1

[Severity: Medium]
Does setting SMP_TIMEOUT_POLL_COUNT to 1 cause severe performance degradati=
on
when the event stream is disabled?

If arch_timer_evtstrm_available() returns false, cpu_poll_relax() falls back
to cpu_relax(), which spins very fast. With SMP_TIMEOUT_POLL_COUNT set to 1,
the generic loop in smp_cond_load_relaxed_timeout() bypasses any batching a=
nd
evaluates the time expression on every single iteration.

If the time expression accesses a clock like ktime_get_mono_fast_ns(), could
spinning CPUs repeatedly read the timekeeper seqcount and hardware clock
without backoff, causing cache-line contention and pipeline saturation?

> +
> +#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
> +	if (arch_timer_evtstrm_available())				\
> +		__cmpwait_relaxed(ptr, val);				\
> +	else								\
> +		cpu_relax();						\
> +} while (0)

[Severity: High]
Will this cause module build failures when loadable modules use
smp_cond_load_relaxed_timeout() or its atomic wrappers?

Because cpu_poll_relax() is an inline macro, it forces any caller, including
modules, to link against arch_timer_evtstrm_available():

drivers/clocksource/arm_arch_timer.c:arch_timer_evtstrm_available() {
    ...
    return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
}

Since arch_timer_evtstrm_available() lacks an EXPORT_SYMBOL() or
EXPORT_SYMBOL_GPL(), will standard modules fail to compile at the modpost
stage with an undefined symbol error?

> +
>  #include <asm-generic/barrier.h>
> =20
>  #endif	/* __ASSEMBLER__ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702013334.1409=
05-1-ankur.a.arora@oracle.com?part=3D2
