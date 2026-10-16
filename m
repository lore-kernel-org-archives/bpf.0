Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6241A57D
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135629; cv=none; b=BreqUtTDw4FrVHwc/VGs3Jfhjqo6H/UOJV0/JFi59xExHZqyOoGxRpJzeRCOXTQy4ttJaR+aQ8tWZRSo4pOni0n1VByxu3NEiCyAzfqVPPidZpgNxn7utgf8qsk3r4wlDi25SVeTn8ehMTNIDRNGvrWWmDE2IsBHn8SLsfhwmus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135629; c=relaxed/simple;
	bh=f3LUunTx9rRIka4ExPxAHndct1AAYJorNE23VZLuMgE=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=qs370GENJeOiOBfUcRgrmFGiYueIM+5Y4eM7rK1wpn80iagmHov7SdWbXae2SjRTRuPWJcRXnQ/IfOGSoMoo2VqPOW7jTQ3Aq0dT/4pp/S/z5f16ejSK5HpjptJ7Q2ZbzUalhvg/kc8KpwipjngcAQFz/DhaysKow6lxOPrrakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2W3YtZp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2W3YtZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F441F000C4;
	Fri, 16 Oct 2026 07:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792135622;
	bh=D4+/JNP7FUuG/fQFz0SzkMFT0jOLuxF3yGjpNTAPnHc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=m2W3YtZp0Plbyv+gQqLz8GQ2MrpzA1XepKnBOYy3J9ZR2kUWIqpxHhGa8v55Vopig
	 BLXYkTK4V48Ze+POkNFUQKrssK5R33kGLnGCUqnGengJt1uh64mCadRp94D4LqZaxq
	 zt/3rghnE6tAmmvgj1lP/Ldm8M//uG2iycCUr/uafAeGAAFoyOb9N/Gt8RVT1hO8mY
	 xbhfdYgz4l7MGks32aBMXWZKh0oGZ5vCCe3Lj5zf3MjMHIVh5U9rcR4/rMOPSwVkhf
	 Pc6yESOBzpslj8CrYIicibsfou7St2Gb2T7r2+uBjgLI+mGUMjsa8kBYDaOn3RfXzI
	 SNQxZF5AMHHfA==
Message-ID: <sashiko-outbox-173927@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 04/16] arm64: support WFET in
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
In-Reply-To: <20261016070837.440748-5-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <20261016070837.440748-5-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:27:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] arm64: missing EXPORT_SYMBOL for cpu_poll_relax() dependencies
--

commit 763c188baf64d23043b0ab18c53d5eb2722c766e
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64: support WFET in smp_cond_load_relaxed_timeout()

This patch adds support for WFET in smp_cond_load_relaxed_timeout() and
smp_cond_load_acquire_timeout() by introducing timeout-aware variants of
__cmpwait() and cpu_poll_relax().

> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/ba=
rrier.h
> index e2263c754a550..3b024058cf2f6 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
[ ... ]
> @@ -235,7 +235,9 @@ extern bool arch_timer_evtstrm_available(void);
>  #define CPU_POLL_RELAX_WAITS
> =20
>  #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
> -	if (arch_timer_evtstrm_available())				\
> +	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
> +		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
> +	else if (arch_timer_evtstrm_available())			\

[Severity: Low]
Does this lack an EXPORT_SYMBOL for loadable modules?=20

Like __delay_cycles() below, arch_timer_evtstrm_available() is called within
a macro that can be expanded by loadable modules. If it isn't exported to
general modules, will modules using smp_cond_load_relaxed_timeout() fail to
link?

>  		__cmpwait_relaxed(ptr, val);				\
>  	else								\
>  		cpu_relax();						\
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cm=
pxchg.h
> index 6cf3cd6873f5f..30dca19c9a7b5 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
[ ... ]
> @@ -235,20 +237,52 @@ __CMPWAIT_CASE( ,  , 64);
> =20
>  #undef __CMPWAIT_CASE
> =20
> -#define __CMPWAIT_GEN(sfx)						\
> -static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
> -				  unsigned long val,			\
> -				  int size)				\
> +#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
> +static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
> +					       unsigned long val,	\
> +					       u64 timeout_ns)		\
> +{									\
> +	unsigned long tmp;						\
> +	u64 ecycles =3D __delay_cycles() +				\
> +			nsecs_to_cycles(timeout_ns);			\

[Severity: Low]
Will this cause linker errors for loadable modules?

Since __cmpwait_case_timeout_##sz() is an inline function instantiated by
generic barrier APIs like smp_cond_load_relaxed_timeout(), it injects a call
to __delay_cycles() into the caller.=20

Is __delay_cycles() exported for use by loadable modules, or will this break
out-of-tree or standard kernel modules that include these headers and use t=
he
timeout macros?

> +	asm volatile(							\
> +	"	sevl\n"							\
> +	"	wfe\n"							\
> +	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016070837.4407=
48-1-ankur.a.arora@oracle.com?part=3D4
