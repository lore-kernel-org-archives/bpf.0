Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E67A3AEB49
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907259; cv=none; b=DUMaHmHsl9Zh2BthidXGC0GOM7gu7UT5BGJdhnqp8J3TAp0h62qX4rEKDTc2a3aQQsbSeNOaLAm3dK0ENAgxfhgFmKuigWWaXKJDclwl9J81v9RZZYrKUzYyxiRkc4yCCWwv+9bwN2wNJ04qjPKlpXd/6e3b1GlP0u8M/l2z4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907259; c=relaxed/simple;
	bh=4gQjlWUWpDJoS8ltYLLH4NssUhEM+PUStLsiARqToyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VDaOMJ7h3+1xw8ENWXTnFdhTpv/7hTtMqsyyJEHDXDF6jv0iQaAX3z3KsVOyfYny0qbjBwcH4+E8aC8s1oWiMX6XqyAGzeY9JfBiIcjTkyJ7Y72XQw0CqNNFXH9pk70Nq7wFuKzTKLGzQWk+s6jDVaJZYSJ4Q+tTE9VhQmxg5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0s0AkL4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0s0AkL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830451F00899;
	Mon,  8 Jun 2026 08:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907255;
	bh=9+9WBWPwdETVS8EPIklML8VpValQYd/JcmzTyGol0PA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f0s0AkL4O8lIlkyQFOEko/DGZ6dYPOPivcYYijT6bdGq9z4O4yahMKqMeZgTcXY/y
	 eE9hlhb438IGCIRo0FgMORmIVHQb1vP5osbdC9g/si1uJrtghchYIJJEvHh0XcSwxv
	 L9jI5v2w4gRHX7sS5cHZVLhL91F8FbYEceOnS2iHqvJCWglrz4DgWxE7uzI3N7MbyZ
	 1JLpgbW1uREfTbMW46bWnrTMNkLG/Rxvmgpo4Y+MMr82fjXy9eb7zAjvIw1KIEMkOc
	 JB+YwaBv127vzK60jN+QL4n+Dc6wmUCL7RRC/O7d7h4AAd2sPKOWmetj9LDpoq9ORT
	 QXJ2dH+XUz7bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/15] arm64: support WFET in
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608080440.127491-5-ankur.a.arora@oracle.com>
References: <20260608080440.127491-5-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:27:35 +0000
Message-Id: <20260608082735.830451F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] smp_cond_load_relaxed_timeout() doubles the requested wait time wh=
en WFET is available.
- [High] Passing a negative timeout to smp_cond_load_relaxed_timeout() caus=
es a massive ~85-second stall.
- [Medium] Missing EXPORT_SYMBOL for __delay_cycles causes module build fai=
lures.
- [Medium] Integer overflow in NSECS_TO_CYCLES() degrades WFET low-power sl=
eep into a 100% CPU busy-spin for large timeouts.
--

commit 4ce1d0efe15be472dcb8f8d8e4e2200fdd9f078f
Author: Ankur Arora <ankur.a.arora@oracle.com>
Date:   Mon Jun 8 08:04:29 2026 +0000

    arm64: support WFET in smp_cond_load_relaxed_timeout()
   =20
    To handle WFET use __cmpwait_timeout() similarly to __cmpwait(). These
    call out to the respective __cmpwait_case_timeout_##sz(),
    __cmpwait_case_##sz() functions.

    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Catalin Marinas <catalin.marinas@arm.com>
    Cc: Will Deacon <will@kernel.org>
    Cc: linux-arm-kernel@lists.infradead.org
    Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
    Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

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
Does this double the requested wait time?

In include/asm-generic/barrier.h, smp_cond_load_relaxed_timeout() initializ=
es
the deadline __time_end lazily after the first execution of cpu_poll_relax(=
),
assuming the poll is brief:

cpu_poll_relax(__PTR, VAL, (u64)__timeout);
if (++__count < __spin)
        continue;
__time_now =3D (s64)(time_expr_ns);
if (unlikely(__time_end =3D=3D 0))
        __time_end =3D __time_now + __timeout;

Because the overridden cpu_poll_relax() uses WFET to sleep for the entire
timeout_ns duration on the first iteration, __time_now advances by timeout_=
ns
before __time_end is initialized. The new deadline effectively becomes
start + 2 * timeout_ns, causing a second full sleep.


[Severity: High]
What happens if a negative timeout is passed to
smp_cond_load_relaxed_timeout()?

The generic loop unconditionally invokes cpu_poll_relax() before checking if
the timeout is negative:

cpu_poll_relax(__PTR, VAL, (u64)__timeout);

A negative timeout casts to U64_MAX. In __cmpwait_case_timeout_##sz(),
NSECS_TO_CYCLES(U64_MAX) overflows and yields an ecycles offset of
4,294,967,295 cycles. For a 50MHz timer, this causes the WFET instruction to
sleep for ~85.89 seconds, completely blocking the CPU instead of returning
immediately.

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
> +			NSECS_TO_CYCLES(timeout_ns);			\

[Severity: Medium]
Does this cause build failures for loadable modules?

The inline function __cmpwait_case_timeout_##sz() explicitly calls
__delay_cycles(). However, __delay_cycles() is only exported via
EXPORT_SYMBOL_IF_KUNIT in arch/arm64/lib/delay.c.

Since smp_cond_load_relaxed_timeout() is an exported generic API, any
dynamically loadable kernel module that invokes it on ARM64 will fail to
link with an undefined symbol error for __delay_cycles.


[Severity: Medium]
Could an integer overflow in NSECS_TO_CYCLES() degrade the WFET low-power
sleep into a 100% CPU busy-spin for large timeouts?

The target wake cycle is computed via NSECS_TO_CYCLES(timeout_ns), which
evaluates to:

(timeout_ns * 5 * loops_per_jiffy * HZ) >> 32

For a 50MHz timer, the 64-bit multiplication overflows at timeouts greater
than ~73.78 seconds. When this overflow wraps around to a small value,
ecycles evaluates to a time in the past. The WFET instruction then behaves
as a NOP, returning immediately and causing the loop to continuously invoke
WFET without sleeping until the remaining timeout drops below the threshold.

> +	asm volatile(							\
> +	"	sevl\n"							\
> +	"	wfe\n"							\

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608080440.1274=
91-1-ankur.a.arora@oracle.com?part=3D4
