Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D863F44C8
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015939; cv=none; b=Z9HO9szmsMk+uiGMwlIe0qrJxffC0CV1OHbb1vHD6E+SsCo2FpQlPxzYKjQ0wBflSGSuL6OswmDhX/N2D0xvJfS4BT8oqFY4yWoypoQqn9LW27VAYwxYudvMi48dO4nQQH4ccHphrPNqxRV05IbSFU4RPrd5ZT3ia4LO064o4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015939; c=relaxed/simple;
	bh=IHYuLzsJLWbXwX/7ChGR69PEWr/11XQBOkWFtyBa5Xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tVqt5DH4Ohfkf5Y4CFSyti+b5qZZHy9pn54mULswSQtnPHTD2HTpvZQ2f4ByX+1JR6REr0n8vuESp0jSmRtKRTXAImNxDi8aAbUqvSGQNqUtD7MqDA7Av09U/s8u6B4DyAEIfRrqKebxy9gmCSY1eXxyb1eKa675pKitwIDn+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUJeFaEL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUJeFaEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971F71F000E9;
	Tue, 14 Jul 2026 07:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015937;
	bh=QkCdP8iwZqJ3ChdtLpAzr9c/wPzruAvW26ouiTXRsMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fUJeFaELSy1QOxC8PAknDnpSVPCn3EaZ5bvupHuv5F7BVGywynpCd81zakzem6kKG
	 9XhjM1XwkUXRAOCRKVdQ+sijA82q5vVbfaiaupBR3F+IcXrHkpsflNfNx9n9mr+kG5
	 ghcBUApJbmj3KHAXL22dCT1FAYQ1Rn3nqrPAUEMjwJd5Hr63J+RfTlyOitWxNAl+R5
	 0nJZPQEMh+srHFQIq+PENw9NBrGZ/oPEI7aCz8uj7HMaQEGO36qRd49k+YMlipiSq4
	 ffeX5zzlF1dTzQBK14MUqVMT9aspcbY/gJfScqoVGby+2vlqXSG6D+tWHrkCLfMWdO
	 SL72TuL0VdVdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 13/15] arm64/delay: enable testing
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714073041.40250-14-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-14-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:58:56 +0000
Message-Id: <20260714075857.971F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Conditionally exporting `__delay_cycles` and `arch_timer_evtstrm=
_available` only for KUnit prevents standard kernel modules from using gene=
ric atomic timeout APIs on arm64.
--

--- Patch [13]: [PATCH v14 13/15] arm64/delay: enable testing smp_cond_load=
_relaxed_timeout() ---
commit 66ad403e3794b9907fdbe044468423d2877131a1
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64/delay: enable testing smp_cond_load_relaxed_timeout()

This commit exports __delay_cycles() and arch_timer_evtstrm_available()
using EXPORT_SYMBOL_IF_KUNIT() to allow testing barrier timeout functions
as a module.

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
Will this cause linking errors for standard kernel modules that use generic
atomic timeout APIs when CONFIG_KUNIT is disabled?

If a module uses macros like smp_cond_load_relaxed_timeout(), they expand
inline into the compilation unit, which relies on __delay_cycles().
Restricting this export to KUnit could prevent non-test modules from
building on arm64.

> =20
>  void __delay(unsigned long cycles)
>  {
[ ... ]
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
Could this also cause modpost failures for standard modules?

Like __delay_cycles(), arch_timer_evtstrm_available() may be called by the
inline expansion of generic barrier macros. Exporting it only for KUnit
restricts these generic APIs from being used in standard modules.

> =20
>  static struct arch_timer_kvm_info arch_timer_kvm_info;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714073041.4025=
0-1-ankur.a.arora@oracle.com?part=3D13
