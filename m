Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8AB2D73B6
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 01:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957450; cv=none; b=WSCTDhCyqZgL3L+ZkbOFrhF5noVmssxKraPnh/OXmCg2tNKHPBkbzvow4mEGvx4k5Gw+Tva44Jax2baonFQIIoLa06r5gJv5NctzLxW4zxJhkKmap6ulbyHQM4HAlZYEaeUf0Sl5TJdiJl5XZEq2EhnGPtUbrExJJnv7V9PTXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957450; c=relaxed/simple;
	bh=PsrLpH2uN7uTOQduX8q45El0WwS57qzmWn4Tb2LGkxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V7p4VhjRDg/LU+9xHavW9+f/2AnWQwUFTiKg56avll8GZY7n+ZGLhrfjtTFlBcRqTJ9vUVueV/U3v3eC/rpBvm+0Dz9SASAA36VRvdFdkc8f2eeRSWToQupU2DUMh88+J1KCeGQrNOmEGQJ394XpSQ2QCdT0KnxZ/U6iIvdZZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv19F82L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv19F82L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D353F1F000E9;
	Thu,  2 Jul 2026 01:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782957449;
	bh=q/JaeRwFLa7XU1rWUx19/V9W/QqmUfeqetdci8zPMKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dv19F82LjHgovszGwbVGvWKJAEpetlGk1coXKe0NlBoViirNDoVCWI0u/Vv060fm4
	 KmQ8W37rg9ZgPlxafawrwGQ5LV6IScAaxxg1VM+f6lMLz/EotPdAhh6pUhb9Yr8yGD
	 +KSmChI+jU1mAuxY5NIqIf0ioAvWV4/UJmYOnu6kGT5XhJtnjkLdRBBIXMt4pHMCVq
	 1odqi9mPoIjGwa/gL0OjEtMnxe4tA2gs9mff1d1XTHroEYvVzcHp5XalBlc6zfky9x
	 B7DJpHhx8/5ORSyohhUAa69K+0/K1/w6Fy1y4y8TGMjy8Dk1XBKNKTgwoFmG3E9B2/
	 pmFXKDcMKUMkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 13/15] arm64/delay: enable testing
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702013334.140905-14-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
 <20260702013334.140905-14-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 01:57:28 +0000
Message-Id: <20260702015728.D353F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The generic synchronization macros `smp_cond_load_relaxed_timeou=
t()` and `smp_cond_load_acquire_timeout()` (defined in `include/asm-generic=
/barrier.h`) are standard kernel APIs. On ARM64, these macros expand to use=
 `cpu_poll_relax()`, which evaluates `arch_timer_evtstrm_available()` and c=
alls `__cmpwait_relaxed_timeout()`. The latter then calls `__delay_cycles()=
`. Any loadable module using these generic timeout-based wait macros inhere=
ntly requires both `arch_timer_evtstrm_available` and `__delay_cycles` to b=
e exported.

However, these backend symbols are conditionally exported using `EXPORT_SYM=
BOL_IF_KUNIT`. If a standard non-KUnit loadable module uses these generic A=
PIs while `CONFIG_KUNIT=3Dn`, it will encounter 'undefined symbol' linker e=
rrors during modpost. Because these symbols satisfy a generic architecture-=
independent API exposed as inline macros, they must be exported uncondition=
ally (e.g., via `EXPORT_SYMBOL_GPL`).
--

commit f9d079be600d568480e3e1fb1f712a02babf0680
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64/delay: enable testing smp_cond_load_relaxed_timeout()

This commit conditionally exports __delay_cycles and
arch_timer_evtstrm_available to KUnit to enable barrier tests to be built a=
s a
module.

> diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
> index c660a7ea26dd6..dfb102ce30098 100644
> --- a/arch/arm64/lib/delay.c
> +++ b/arch/arm64/lib/delay.c
[ ... ]
> @@ -30,6 +31,7 @@ u64 notrace __delay_cycles(void)
>  	guard(preempt_notrace)();
>  	return __arch_counter_get_cntvct_stable();
>  }
> +EXPORT_SYMBOL_IF_KUNIT(__delay_cycles);

[Severity: Medium]
Will standard loadable modules encounter undefined symbol errors during mod=
post
if they use the generic timeout-based wait macros when CONFIG_KUNIT=3Dn?

On ARM64, the generic synchronization macros smp_cond_load_relaxed_timeout()
and smp_cond_load_acquire_timeout() expand to use cpu_poll_relax(), which
evaluates arch_timer_evtstrm_available() and calls __cmpwait_relaxed_timeou=
t(),
which in turn calls __delay_cycles().

Should this be exported unconditionally (e.g., via EXPORT_SYMBOL_GPL) so th=
at
normal modules can use this architecture-independent API?

> =20
>  void __delay(unsigned long cycles)
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/a=
rm_arch_timer.c
> index 90aeff44a2764..1de63e1a2cd2f 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
[ ... ]
> @@ -896,6 +897,7 @@ bool arch_timer_evtstrm_available(void)
>  	 */
>  	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);

[Severity: Medium]
Could this similarly break standard modules that use the generic API?

As mentioned above, arch_timer_evtstrm_available() is evaluated during the
expansion of the generic smp_cond_load_*_timeout macros. An unconditional
export might be needed here as well to prevent module linking errors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702013334.1409=
05-1-ankur.a.arora@oracle.com?part=3D13
