Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF731E850
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907496; cv=none; b=pJH0ITXHmNddbtIXXctzbCLLC4Ok1fWtcIFW4g7mmvtAnVgIHF3iRv79Ia18yRrMOL1dqcF3kHws8mPC0k9+bet6zyl+U7juZv/ppV+RSU/q+VKVi8RwH4LXYz7lrEm3PMEby78PFVhRxS8YZ4JKkn7GJy4+Ug2/pImXlOXB3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907496; c=relaxed/simple;
	bh=kHueoHBiVl6RAbc2Hb9D79YQO7gNE7iaqTHY4hTGS1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OK8BBdqs5zoEHv+bDf2BKEKzMofYfVVADPeqncJqMxwD0urvYmjI9DToo3illNMfnZBI1Y6TVn3D/uSedvMO5JjZ2XH89B+A3eYrQ806NHp9bI2W7QNVYEzCUmXvURnfYgwqpwnscx/QL0cjY23kdIPvo2Nae3NLOHuMJKTGaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn50OTiX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn50OTiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0C81F00893;
	Mon,  8 Jun 2026 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907495;
	bh=D8NItsj86tz8Pvh/iq4Lc4Sh0cHHY9vjtSKZkheiUp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qn50OTiXqEYWJKlUVadwjp+BlwMVGWLyuBaodNULMqSNy+WnuRfa96jUcYU3dKieF
	 z/Njl7BMEjrRVVwHTWU6EKg8V6LGg0f13nnRia5FqtTCUwxLmEDnNrk0thoEBV/vr3
	 pccpIwLlJUH8MTcSgwPz15Vudo/9SgDuY6YEmPZteY8xdYZ30O4DusVFrEMPzo83TR
	 T2EsRmWLoaZDwChrVdA0di2HYtCu+6dzG5iPRJkTIO75Qo5Db+cKm6JFx2GfmL4lI5
	 LDvY09L2OoPIvw+8rsYydCE37HA8D9R2RAbtFMKHb1o+ftMrC5u2o3a5Tomy0rK47z
	 lTPd+Ouo49p3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/15] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608080440.127491-3-ankur.a.arora@oracle.com>
References: <20260608080440.127491-3-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:31:34 +0000
Message-Id: <20260608083135.6C0C81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Zero or negative timeout requests incorrectly block in WFE/WFET.
- [Low] The macro `cpu_poll_relax` references `arch_timer_evtstrm_available=
`, which is not exported, causing link errors for loadable modules.
--

commit aa12eab164f56555b3ffac8b49cd2f96ce88e36c
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64: barrier: Support smp_cond_load_relaxed_timeout()

This commit supports waiting in smp_cond_load_relaxed_timeout via
__cmpwait_relaxed on ARM64 when the event-stream is enabled.

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
> +
> +#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
> +	if (arch_timer_evtstrm_available())				\

[Severity: Low]
Will this regression cause undefined symbol errors for loadable modules?

Since smp_cond_load_relaxed_timeout is a generic synchronization API, it wi=
ll
be expanded in caller modules and rely on cpu_poll_relax.

However, arch_timer_evtstrm_available is currently only exported for KUnit
testing in drivers/clocksource/arm_arch_timer.c:

    EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);

Does this need a general EXPORT_SYMBOL to prevent linking failures when use=
d in
standard loadable modules?

> +		__cmpwait_relaxed(ptr, val);				\

[Severity: High]
Could this inadvertently block when given a zero or negative timeout?

When looking at the generic wrapper in include/asm-generic/barrier.h,
smp_cond_load_relaxed_timeout executes cpu_poll_relax on the first iteration
before evaluating if the timeout has expired:

        cpu_poll_relax(__PTR, VAL, (u64)__timeout);
        if (++__count < __spin)
                continue;

If a caller provides a zero or negative timeout expecting an immediate
non-blocking poll, this falls through to __cmpwait_relaxed.

For negative timeouts, casting to u64 results in a huge unsigned value
(U64_MAX). Might this cause WFET to block indefinitely?

Even if WFET is unsupported, __cmpwait_relaxed uses WFE, which ignores the
timeout and blocks the CPU until the variable changes or an event stream
interrupt occurs. Does this introduce unintended latency for what should be=
 a
zero-latency fast-path failure?

> +	else								\
> +		cpu_relax();						\
> +} while (0)
> +
>  #include <asm-generic/barrier.h>
> =20
>  #endif	/* __ASSEMBLER__ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608080440.1274=
91-1-ankur.a.arora@oracle.com?part=3D2
