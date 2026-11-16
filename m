Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818782;
	b=NPfeCE5oCO/oJ3NquCb544E4TPzuhKvt/rFi/UdfQyyijV2YBwOqbtnDK0aiGK5FucWQ
	 QfUkzWnkGRJsUvQm/ceZTecfiJdFtj0srEfvD+OlXfqXF2pkIReQOQ4yfHhzdFoW7QFCU
	 rQI10DCYodyB8FiOAszRhyIt27yk2XZJzNAklP9/G9g9t8/owphH19k0oKz+149Ngws2h
	 s6HgcItb3xtaqpy+Nty4bFWq0gnwGYEg1CCS/GdDvSHHQYTFjCCjsMfjKIobsEq+UrIv4
	 aTFlfFhmAenCZoM23o0gTj+2UVXdob2/5H3yeZf1ZtzMOL6O9yTADosHogKxALmQjZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818782;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pxDZA4ojriuGuOa9Ix3TUwrDjuRdqtIKM2CJ3nEMrcE=;
	b=z+Sw8h0wSH1cstLsj3HCJEpJCzFpjHEoJzXVjv7k/PlNil7JYexOhhRl6xQOIMW955mr
	 5ZrfGPUSzEAusbnx53g6ame1BqN+wBuBccDRaq/qjdlLqwTHi4orlviUDgkFe5v3STIMv
	 SVbUtUMNJxO3X/vC0GHLILy9mK6gDbpqw78V8k7NqcYMnBT8kVFplK9+eCxpP9xS2EmNh
	 dXRYL9bzOU3Vn0Gh0CmzpNyNCXfIyHuQhxqHMAkUFBLc7IG9sdlDlqaGUik2Tq/Cj6072
	 7g4irlwpOchnArYYwP/SAIvpj3ep1vK5CyGnV7YAYs+M4RP+niG3WF2Bs6FylJGqG4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdzWzqg7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCA606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdzWzqg7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E291F000C4;
	Mon, 16 Nov 2026 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794818782;
	bh=pxDZA4ojriuGuOa9Ix3TUwrDjuRdqtIKM2CJ3nEMrcE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CdzWzqg7yILazdr6pjuw6Ifdj7a+ZxUjoZz7hppHNbAN8gdsghJa/Ib8ozAgFPU7A
	 SY4XpVJGkMkc7ThOpaksV7n7YTqGgIqgYjrnfnvJ16KTzTvoFMk4LWNzuEzjAu8bVp
	 6Jy8sm949gmAJBhmId3aCkbzCvkH+aGgtFw8oR9rEyERETOovAEe2pEXVsRJMZQmse
	 wbH1TE9sweX5bjZ0+kacO10rLHpeTiZsukk37cFpQkdEtWDuxGjd7HeByE7Ed72FQF
	 ILZKbNMcVjFrhNQLHcC2DW+xLAVhJJViDMZDGkiACfPcM4xpAGlyv3Tn7JiY1FNXXJ
	 E8SLF+gB56C7w==
Message-ID: <sashiko-outbox-216562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 04/16] arm64: support WFET in
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
In-Reply-To: <20261116082437.66739-5-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
 <20261116082437.66739-5-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:46:21 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] arm64: cpu_poll_relax() calls non-noinstr
  arm64_wfet_deadline()
- [Low] arm64: unexported arch_timer_evtstrm_available() in
  cpu_poll_relax()
--

commit 0bd9d96e9ca449b0fa90386c0f9dafaac6bd9c03
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64: support WFET in smp_cond_load_relaxed_timeout()

This commit adds WFET support to cpu_poll_relax() on arm64 via
__cmpwait_relaxed_timeout() and __cmpwait_case_timeout_##sz(), using
arm64_wfet_deadline() to compute the wait deadline when ARM64_HAS_WFXT is
present.

> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/ba=
rrier.h
> index e2263c754a550..3b024058cf2f6 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -224,8 +224,8 @@ do {									\
>  extern bool arch_timer_evtstrm_available(void);
> =20
>  /*
> - * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxe=
d()
> - * for @ptr value to change.
> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxe=
d()/
> + * __cmpwait_relaxed_timeout() for the ptr value to change.
>   *
>   * State this by defining CPU_POLL_RELAX_WAITS. This enables a time-check
>   * optimization in smp_cond_load_{relaxed,acquire}_timeout(). Note that =
this
> @@ -235,7 +235,9 @@ extern bool arch_timer_evtstrm_available(void);
>  #define CPU_POLL_RELAX_WAITS
> =20
>  #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
> -	if (arch_timer_evtstrm_available())				\
> +	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
> +		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
> +	else if (arch_timer_evtstrm_available())			\
>  		__cmpwait_relaxed(ptr, val);				\
>  	else								\
>  		cpu_relax();						\

[Severity: Low]
Should arch_timer_evtstrm_available() be exported with EXPORT_SYMBOL_GPL()
like arm64_wfet_deadline()?

Commit "arm64/delay: define arm64_wfet_deadline()" exports
arm64_wfet_deadline() via EXPORT_SYMBOL_GPL(), while commit "arm64/delay:
enable testing smp_cond_load_relaxed_timeout()" later in the series only
exports arch_timer_evtstrm_available() via EXPORT_SYMBOL_IF_KUNIT().
Because cpu_poll_relax() expands at each call site to both the
__cmpwait_relaxed_timeout() branch and the arch_timer_evtstrm_available()
fallback branch, any non-KUnit loadable module using
smp_cond_load_relaxed_timeout() or smp_cond_load_acquire_timeout() will
fail to link with an unresolved reference to
arch_timer_evtstrm_available().

> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cm=
pxchg.h
> index 6cf3cd6873f5f..e543366801ce4 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
[ ... ]
> @@ -235,20 +236,55 @@ __CMPWAIT_CASE( ,  , 64);
> =20
>  #undef __CMPWAIT_CASE
> =20
> -#define __CMPWAIT_GEN(sfx)						\
> -static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
> -				  unsigned long val,			\
> -				  int size)				\
> +/* Declared locally to avoid recursive include dependency */
> +u64 arm64_wfet_deadline(u64 timeout_ns);
> +
> +#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
> +static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
> +					       unsigned long val,	\
> +					       u64 timeout_ns)		\
> +{									\
> +	unsigned long tmp;						\
> +	u64 ecycles =3D arm64_wfet_deadline(timeout_ns);			\

[Severity: Medium]
Does calling arm64_wfet_deadline() from cpu_poll_relax() ->
__cmpwait_relaxed_timeout() -> __cmpwait_case_timeout_##sz() violate
noinstr constraints when smp_cond_load_relaxed_timeout() is used from
cpuidle?

Commit "arm64: barrier: Support smp_cond_load_relaxed_timeout()" marked
arch_timer_evtstrm_available() noinstr so cpu_poll_relax() can be called
from .cpuidle.text while RCU is not watching.  On systems with
ARM64_HAS_WFXT, cpu_poll_relax() instead calls __cmpwait_case_timeout_##sz()
(marked static inline rather than __always_inline) and the out-of-line
arm64_wfet_deadline() in arch/arm64/lib/delay.c:

arch/arm64/lib/delay.c:arm64_wfet_deadline() {
	return __delay_cycles() + nsecs_to_cycles(timeout_ns);
}

Neither arm64_wfet_deadline() nor nsecs_to_cycles() is marked noinstr, and
__delay_cycles() uses guard(preempt_notrace)() (which can invoke
__preempt_schedule_notrace()) and __arch_counter_get_cntvct_stable()
(which uses __this_cpu_read() and non-noinstr erratum callbacks under
CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND).  Calling this path from an RCU
extended quiescent state can trigger RCU and lockdep warnings or execute
ftrace, kprobe, or sanitizer instrumentation while RCU is not watching.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116082437.6673=
9-1-ankur.a.arora@oracle.com?part=3D4
