Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4D383C7B
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214780; cv=none; b=UdYCBcWQekG5ynFcq2mHc/zwgdu62TvQrkWZubcXGf4DCLVyXypTqgexD7ZRvlSjrpJbTt/L1SoV/48u5u1cj9CApdh53Mul0O3K/CqLYfX9yJg89PHVpinrhXZEqnQH5u+8NM9EfvaBSKNtboKim+ZK0hrDA32Zqo8Gj1KSUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214780; c=relaxed/simple;
	bh=Bhimj3y2UTTjoNjDUzsy5GOSmUFDpPfHXNAyLaboJSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hN8daUmB8hqbRINt5hxP619pkc7pVahLhbV+LZhh19Rhn4yLqlXsIWaxyUcioJUtR6Q0vJtLOxwP4lONF6AB/u9Wq3/gXDAyVNnqY46b8pv8DNyEZhXObrAlYPEYKODgFnsZqX2vqHfFofM7bMZP087T2qxq3LaJzcVrYYgFWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcf+Sb+6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcf+Sb+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0DF1F000E9;
	Mon, 31 Aug 2026 22:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214779;
	bh=aDXzdmD6W1xZAligiaTDiHakgRF6+zyw8mYKek1b6zY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kcf+Sb+6yZQ4MLbEnebFsBroNHSLJHGkKc1NsZMwrdGdAFKx3u1F3sNF8PKYYNfd0
	 BfWRsbC7+sjZQzJmdIuF0bunu5J0vVjMGS+NKIJ7E4bfiavrk5DK7ptlf5SQ26RQRQ
	 K7G18jDUu97paua4VtSLgkikCsSsEeTIF75RccMAHVU0nAu9efzLCeMfn1BISbD7+y
	 ey0C2VNG29uHhSDaCYw1CAZrHb/ro4c/SiXXqeoNkqlLhfdI1mFMsnxmmjpOR2SJpR
	 2+c2aWLOe+D85n+g8T0uBqEJCsTMHi5T2selp10RoE4dHUox0VTQT0XTpz6CQYLigV
	 VQVwnWOf0tbIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 04/16] arm64: support WFET in
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831202251.305046-5-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-5-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:19:38 +0000
Message-Id: <20260831221939.0E0DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] WFET can miss wakeups and cause large latency spikes if the event =
stream is disabled, because cpu_poll_relax() bypasses the event stream chec=
k.
- [Medium] Missing EXPORT_SYMBOL for __delay_cycles breaks loadable modules=
 using smp_cond_load_relaxed_timeout().
--

commit df5daf2c3238cb4af3e080baa4e7cbf435ca18c7
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64: support WFET in smp_cond_load_relaxed_timeout()

This commit introduces support for using the WFET instruction when a timeout
is provided to smp_cond_load_relaxed_timeout(). It achieves this by adding a
new __cmpwait_relaxed_timeout() helper and underlying
__cmpwait_case_timeout_##sz macros.

> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/ba=
rrier.h
> index d186a45587766..d1f4f571adaa8 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h

[ ... ]

> @@ -233,7 +233,9 @@ extern bool arch_timer_evtstrm_available(void);
>  #define CPU_POLL_RELAX_WAITS
> =20
>  #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
> -	if (arch_timer_evtstrm_available())				\
> +	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
> +		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
> +	else if (arch_timer_evtstrm_available())			\

[Severity: High]
Does bypassing the arch_timer_evtstrm_available() check for WFET risk missed
wakeups and large latency spikes if the event stream is disabled?

If a task executes ldxr in __cmpwait_case_timeout_##sz(), is preempted
by an interrupt that clears the exclusive monitor, and then another task
executes WFE (clearing the Event register), the original task resuming and
executing WFET could sleep for the entire timeout duration.

Since the monitor is Open (cleared), a store to the lock word by another CPU
would not generate an event. The arch_timer_evtstrm_available() check helps
prevent this exact issue by providing periodic wakeups.

>  		__cmpwait_relaxed(ptr, val);				\
>  	else								\
>  		cpu_relax();						\

> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cm=
pxchg.h
> index 6cf3cd6873f5f..7985ae5ceb0f9 100644
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

[Severity: Medium]
Will this break the build for loadable modules using this API?

Since __delay_cycles() lacks an EXPORT_SYMBOL() declaration, any loadable
module calling smp_cond_load_relaxed_timeout() will expand this inline
function and encounter linker errors.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831202251.3050=
46-1-ankur.a.arora@oracle.com?part=3D4
