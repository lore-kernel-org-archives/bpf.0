Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A893E49C2
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135211; cv=none; b=tFZ9CDFcBL05J/VcqwmCw/PXxtZTk6yU0IDRE4L1Tb0jwQNyi3XUaaVP5gP7M9XLBJU0mDsGIkytQCk5KgcOLPIJgIHrzlvtwtoTeOB1Etle4XkoIhXZijz0/MF90hDQoDZkyiqK/K2x5xVSz6qmopTEwJxAU7DKLJEHPQ7IN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135211; c=relaxed/simple;
	bh=9blzoTeMYKqG95vlNDau/AgTg0P4djDxPOx2iOabccA=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=JvMZfNlgA9Byjj0gWymU8ojknIEQe+87hQuVWOwcz7UkU2WazvUjRxPDQTIv2I1d2sNRdUkfothnYHgwesj+Yk2s9/65feYyEeLAAHwWcpCr6S6IiEN/NcbYa9cFrICayk5yqzzxlEqJxMn9Jaspid+c9EYqMrtGKe8X3i/B1+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRDT7bTA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRDT7bTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8091F000C4;
	Fri, 16 Oct 2026 07:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792135210;
	bh=+P+yeM3IXRUbxUnNtk9SRhf7h72SwyPhJ0s0t9CLfLM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JRDT7bTA22lwRG2wHJMpv8LxqfLafNFa92KdJ8atixQ0uW8JfM9FxuFkh7mENBHZU
	 6RaEaNRk6MJPYZxQz1lSfTctp9hk8lhpGvXpiWiEM5kWsjMGDnnhTHTu8ZcA2067BL
	 kR9f0hHtQp/HX1gtUddPXGA8IHBE5AQTRdEwHz4J7dJoan32yYbYHEVyqvSNyFVVMb
	 udne8roFpXlnXyRBvDEKbwm8qQHQAxS/wwy0LKLQU0VagaOOWO3v6V4maw5wRvQOcz
	 bvWRn0R/rEGfb+ZbyvBNAl/yU7uSIMVw1dgxAATumZYp3hARYs+YWHWRtqFY8c0VBC
	 0iUp4DaHuPtFw==
Message-ID: <sashiko-outbox-173916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 13/16] arm64/delay: enable testing
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
In-Reply-To: <20261016070837.440748-14-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <20261016070837.440748-14-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:20:09 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: barrier: missing exports for smp_cond_load_*_timeout() ba=
ckends
--

commit bfc8166431acdeebcd1866a53cbd230aa1bcd738
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64/delay: enable testing smp_cond_load_relaxed_timeout()

This commit enables the barrier tests to be built as a module by exporting
the underlying delay and timer functions when KUnit is enabled.

> diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
> index f08eacef2f0a4..20bc2894b65b9 100644
> --- a/arch/arm64/lib/delay.c
> +++ b/arch/arm64/lib/delay.c
[ ... ]
> @@ -30,6 +31,7 @@ u64 notrace __delay_cycles(void)
>  	guard(preempt_notrace)();
>  	return __arch_counter_get_cntvct_stable();
>  }
> +EXPORT_SYMBOL_IF_KUNIT(__delay_cycles);

[Severity: Medium]
Does exporting __delay_cycles() only for KUnit cause unresolved symbol erro=
rs
for standard loadable modules?

If a standard non-test module uses atomic_cond_read_acquire_timeout() or
smp_cond_load_relaxed_timeout() on ARM64, the macros expand to inline barri=
er
functions like __cmpwait_relaxed_timeout(), which call __delay_cycles().

Since this symbol is only exported when CONFIG_KUNIT is enabled, will stand=
ard
production builds fail to build or load modules using these APIs?

> =20
>  void __delay(unsigned long cycles)
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/a=
rm_arch_timer.c
> index cc9a8b399004d..227447b19b143 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
[ ... ]
> @@ -893,6 +894,7 @@ bool arch_timer_evtstrm_available(void)
>  	 */
>  	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);

[Severity: Medium]
Similarly, does restricting the export of arch_timer_evtstrm_available() to
KUnit builds break standard modules?

The inline cpu_poll_relax() backend relies on this function. Standard modul=
es
using the new timeout APIs might fail to resolve this symbol when compiled
without CONFIG_KUNIT. Should these be exported unconditionally using standa=
rd
EXPORT_SYMBOL_GPL() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016070837.4407=
48-1-ankur.a.arora@oracle.com?part=3D13
