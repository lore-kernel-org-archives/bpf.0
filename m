Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED030E0EE
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135497; cv=none; b=siu22wrHYpDyV9oN3aGJB7PdhwHLCFA2joAzLbsfTYz7Y60t88MfoSKm1EPopRTwxfKufVC5Tn94o4st6fYkDn4Cy0w7xkCVghlDon3ifrRsi3T9QgOv9GhwbDQhlokz1Bk7scuK76NJn2uutqyTQfk3DRMp6DWCyGt4po71xRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135497; c=relaxed/simple;
	bh=6o4jR2LVaZagMAd2FCjnMNzNJ8mZoAXMqR1OEBiTOH0=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=S1sifASI2rwyVbEBEKOBI003mGE4tQswzB++qSSfEmAzgEqnWJg6iyqG4zxpp/TN6jVKHoC8tGpO/YxrNGWNz/UzrxoJqlJhRdR2aic4OGcNBmUtis+67oLFoJDeZ5p40hMzpXNk4oQDgAvRebh1Jv9KZSYug3UKAXoeomWkInw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjY1YaKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjY1YaKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774AC1F000C4;
	Fri, 16 Oct 2026 07:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792135494;
	bh=U112tfd14obUqCDSiuBDX+uIoNPCKKr+ESXS9uZWsOI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DjY1YaKCVdXaM1iAecowGyDZRTnEhY8UdyH3MSxRh+zapNF4xgggaKw47AyJMV5AB
	 kM6M67zMbuHANoWr7SYblpWkjLlxRjHazLZMV2Kfbm6jjZyQ2S+7whALhJmBP/PfUc
	 4oObd0sb8kTXN3vLmhZL2vDPl5R/bLGPtLjVyIQYMGLyD23t1AuU9IP3OkGBUiEq1j
	 vZSctGgyOwnXtmG8fBLreXXTlyIxy6OpkTVKXFN+VL67vniAuMPWtnHn1jqfvuWizx
	 DmiaHbGIiTmlVZGArCT1vmzc0n+wtKFGR0HcxOREDpGI3rxQ0Rsd1IWPficRFpSyzB
	 hPUUQYNY7ZvCw==
Message-ID: <sashiko-outbox-173922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 02/16] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
In-Reply-To: <20261016070837.440748-3-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <20261016070837.440748-3-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:24:53 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] arm64/barrier: massive timekeeping contention in spin loops withou=
t event stream
- [Medium] arm64: barrier: missing export of arch_timer_evtstrm_available()=
 breaks modules
- [Medium] arm64: noinstr violation in cpuidle via cpu_poll_relax()
--

commit 7a1bb257570118eb8f711a76f172539e20eeaac8
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64: barrier: Support smp_cond_load_relaxed_timeout()

This commit supports waiting in smp_cond_load_relaxed_timeout() via
__cmpwait_relaxed() when the event-stream is available, falling back to
cpu_relax() otherwise. It defines CPU_POLL_RELAX_WAITS to indicate that
there is an optimized wait implementation.

> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/ba=
rrier.h
> index 9495c4441a46b..e2263c754a550 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h

[ ... ]

> @@ -219,6 +220,27 @@ do {									\
>  	(typeof(*ptr))VAL;						\
>  })
> =20
> +/* Re-declared here to avoid include dependency. */
> +extern bool arch_timer_evtstrm_available(void);
> +
> +/*
> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxe=
d()
> + * for @ptr value to change.
> + *
> + * State this by defining CPU_POLL_RELAX_WAITS. This enables a time-check
> + * optimization in smp_cond_load_{relaxed,acquire}_timeout(). Note that =
this
> + * is not ideal for the cpu_relax() fallback but that's not a production
> + * configuration.
> + */
> +#define CPU_POLL_RELAX_WAITS

[Severity: High]
Does defining CPU_POLL_RELAX_WAITS here cause massive timekeeping contention
when the event stream is disabled?

When CPU_POLL_RELAX_WAITS is defined, include/asm-generic/barrier.h sets
SMP_TIMEOUT_POLL_COUNT to 1. This causes the loop in
__smp_cond_load_relaxed_timeout() to evaluate the expensive time_expr_ns
on every single iteration.

If the event stream is disabled, cpu_poll_relax() drops back to a fast
cpu_relax() yield. Evaluating the time expression (e.g. reading timer hardw=
are
or seqcounts) on every fast spin loop iteration across multiple CPUs can ca=
use
massive lock contention and interconnect flooding.

Is it accurate that disabling the event stream is "not a production
configuration"? It can be disabled via Kconfig
(CONFIG_ARM_ARCH_TIMER_EVTSTREAM=3Dn), kernel command line
(clocksource.arm_arch_timer.evtstrm=3D0), or under hypervisors that lack
virtual event stream support.

> +
> +#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
> +	if (arch_timer_evtstrm_available())				\

[Severity: Medium]
Does this break the build for loadable kernel modules that use the new
smp_cond_load_relaxed_timeout() or smp_cond_load_acquire_timeout() macros?

This macro injects a direct call to arch_timer_evtstrm_available() into the
caller's context. However, arch_timer_evtstrm_available() is defined in
drivers/clocksource/arm_arch_timer.c and lacks an EXPORT_SYMBOL_GPL directi=
ve.

Without the export, standard loadable modules using the generic barrier
timeout API will fail to build with undefined symbol errors.

[Severity: Medium]
Can this introduce a noinstr violation in the idle entry path?

arch_timer_evtstrm_available() is an out-of-line, instrumentable function
since it is not marked noinstr.

When smp_cond_load_relaxed_timeout() is used in poll_idle()
(in drivers/cpuidle/poll_state.c), it is executed in a noinstr context
because poll_idle() is marked __cpuidle, which places it in the
.cpuidle.text section. Objtool strictly validates .cpuidle.text as noinstr.

Calling an instrumentable function directly from the idle spin-loop macro
risks tracing recursion and objtool validation errors.

> +		__cmpwait_relaxed(ptr, val);				\
> +	else								\
> +		cpu_relax();						\
> +} while (0)
> +
>  #include <asm-generic/barrier.h>
> =20
>  #endif	/* __ASSEMBLER__ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016070837.4407=
48-1-ankur.a.arora@oracle.com?part=3D2
