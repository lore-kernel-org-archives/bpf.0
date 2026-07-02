Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9029D26B
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957149; cv=none; b=B7EtXDVZkTtda07rY6glhyTinsn1YzyOuhPEPeP2a/MZ4e9082DNP8TrCA0KPalNT2Tn8YI0cgFbJEDI+qhqBkFA0rymr1geZFl9/JYFeg2BubJLVbhvoNLkChyoi70qG2BVUVjXU20Y1H0IewkuFmbIrIElX8kfKI4oRwVKSaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957149; c=relaxed/simple;
	bh=0aLxTByskC/7agikAGaIYYobdseIZ77UsATbG0hF1Ag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ppTiVyHOl84hs4VxwyszSd9p7S00ua/uaOUXbqadWAzzgHdwAqa40AxDz73kXGto1DoUNdYz2Woqr05YnzCgItUDXRoNfY93xddxZlwxCUE2/PI4hH6jxY+SCYSRkAeRI9ppFsjgDjCvfpUeEphi0rPKB9cQRzONgrPCriRT0CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmbX92Du; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmbX92Du"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DE91F000E9;
	Thu,  2 Jul 2026 01:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782957147;
	bh=NEtQa14PX34bPH8CDnZMmQtDPeiwKaaW4rZtJZJkpNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZmbX92DuAJ/xOeF7ntXA3g/UISzjHWR/eQZMxXbqorADSh+G15ckolwTQbf+XxiYE
	 Lxlo5mHaEfpVwaFju9WUsUajsbnhtreq9cprzjoWfTCEuJPU9DlmkBI09dx3CfMqEx
	 YSx3Pj+BArkrHIbTcXQTO1vhkL13Cxt0c11BshifNTbqJFDFMXTfUZjVhIbvxohg7N
	 bZ9VJDOQaOv24DSN0d1xqhh2bn4ta4N7pIg2pPQ2L4oX2aA1pY/LRCNSYnILNFClv0
	 UOfdjM93LxfGDyg6+6ui0GMyYUWMiYJs/zzbm8vyV22/bV/Wf0FX83SL7zAvmqcDXo
	 yyjrLSMCSFI5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/15] arm64: support WFET in
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702013334.140905-5-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
 <20260702013334.140905-5-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 01:52:27 +0000
Message-Id: <20260702015227.83DE91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Double timeout duration due to late deadline initialization in smp=
_cond_load_relaxed_timeout().
- [Medium] Linker errors for loadable kernel modules using generic barrier =
timeout APIs.
- [Medium] Integer overflow in NSECS_TO_CYCLES() degrades WFET to a busy-wa=
it loop for large timeouts.
--

commit e5b7a3dd71128bb8e09cbcac08762647dcc92dd1
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64: support WFET in smp_cond_load_relaxed_timeout()
   =20
To handle WFET use __cmpwait_timeout() similarly to __cmpwait(). These
call out to the respective __cmpwait_case_timeout_##sz(),
__cmpwait_case_##sz() functions.

> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/ba=
rrier.h
> index 6190e178db51f..fbd71cd4ef4e5 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h

[ ... ]

> @@ -234,7 +234,9 @@ extern bool arch_timer_evtstrm_available(void);
>  #define SMP_TIMEOUT_POLL_COUNT	1
> =20
>  #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
> -	if (arch_timer_evtstrm_available())				\
> +	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
> +		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\

[Severity: High]
Does this sequence double the intended timeout duration?

Looking at how the generic smp_cond_load_relaxed_timeout() is implemented
in include/asm-generic/barrier.h, it calculates the absolute deadline
(__time_end =3D __time_now + __timeout) only after the first iteration of t=
he
loop.=20

Because SMP_TIMEOUT_POLL_COUNT is 1, the very first iteration immediately
invokes cpu_poll_relax(), which will block natively via WFET for the full
timeout_ns. When it wakes up, __time_end is calculated as now + timeout_ns,
effectively adding the timeout again and allowing the wait to last up to
twice the requested duration.

> +	else if (arch_timer_evtstrm_available())			\
>  		__cmpwait_relaxed(ptr, val);				\
>  	else								\
>  		cpu_relax();						\
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cm=
pxchg.h
> index 6cf3cd6873f5f..9e4cdc9e41d1b 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h

[ ... ]

> @@ -235,20 +237,52 @@ __CMPWAIT_CASE( ,  , 64);
> =20
>  #undef __CMPWAIT_CASE
> =20
> +#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
> +static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
> +					       unsigned long val,	\
> +					       u64 timeout_ns)		\
> +{									\
> +	unsigned long tmp;						\
> +	u64 ecycles =3D __delay_cycles() +				\

[Severity: Medium]
Will loadable kernel modules using the generic barrier timeout APIs fail to
link here?

The inline function __cmpwait_case_timeout_##sz() unconditionally calls
__delay_cycles(). If __delay_cycles() is not exported to normal modules
(e.g., if it is only exported via EXPORT_SYMBOL_IF_KUNIT), any module using
smp_cond_load_relaxed_timeout() will hit undefined symbol linker errors.

> +			NSECS_TO_CYCLES(timeout_ns);			\

[Severity: Medium]
Could a large timeout_ns value overflow here, causing WFET to degrade to a
busy-wait loop?

If NSECS_TO_CYCLES() is called with a large timeout_ns (for example, greater
than 153 seconds on a standard 24MHz generic timer), the 64-bit unsigned
calculation could wrap around. This would pass a very small cycle increment
to WFET, causing it to wake immediately and consume excess power by spinnin=
g.

> +	asm volatile(							\
> +	"	sevl\n"							\
> +	"	wfe\n"							\
> +	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
> +	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
> +	"	cbnz	%" #w "[tmp], 2f\n"				\
> +	"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
> +	"2:"								\
> +	: [tmp] "=3D&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
> +	: [val] "r" (val), [ecycles] "r" (ecycles));			\
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702013334.1409=
05-1-ankur.a.arora@oracle.com?part=3D4
