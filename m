Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B514B3D813A
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218934; cv=none; b=fq1yKtQJCeQVk90h2b5WTnn+eFGZMaNu2v1v6ZvN+wesFpfxdeLXBMCMQq9wpr420GKv/AS35lzIR9wksca+8a5tDXYu6N3K1mytth+YDLFsTsMu825JOOHUqslPmbP9O3WE+xhs4z5aIw3gM2VQowcnDC1ApbB06lpEXwlXHP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218934; c=relaxed/simple;
	bh=87FUE1SxhRk2wj/WTCe2r3HlhKy1p1TzWEBDeBH2IAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UusYw7PlU4lxb1xw/m4XRPPLUJnHzgJhUheUc92+WxfSLSNPKrhVj8pfaQuWGz74wKe06fnELscb9D395xg8FDnH97Jel9CMRjg54IqYGlUfywRgnbqv/PX0RWxHC1J7UBCa6Rf2sox4J9JlL36TnEaeYX+374Vqgn++xQHsHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N012S1mG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N012S1mG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ECF1F000E9;
	Mon, 31 Aug 2026 23:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788218933;
	bh=5UvCkfFMjiAFYGwKiRxX+keeF/kB8qwoPVjsvMfHz4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N012S1mGN3U3vl+Grc77yLoC+x4IFjawUvPSCNdAxiFNhFqbrc/tdzHWcEpnFSd9y
	 TXyUR8czvJdTDd4MUsssV7Yu/qhYIPvO8PaVY3mvDbsd8ZaTXHecI59WZBanfGuJyW
	 rKAMwh/QmBldbRL2dN+DrPFPECxPlqWBJdgIN2rE9gW1GQY1mG8qEBEZwj4iTRz6zx
	 ZvZgv3wpqS7wWaSNuQjtiieO4hwRBkJuSm9moNNGEhJ4VMTG9jzaNzhFtLqXXv+rNz
	 JOanNHv+RwKSSKtBhqNJveug0E8PULjED95A2vLr5nUxFpcW4P96pSWmbcFpCQf77t
	 LD2WR/jYhYx3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 13/16] arm64/delay: enable testing
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831202251.305046-14-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-14-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:28:52 +0000
Message-Id: <20260831232853.24ECF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Conditional export of symbols used by generic inline macros brea=
ks standard module usage.
--

commit 062222b285463a87a0b87a1f19a5112a409a0599
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64/delay: enable testing smp_cond_load_relaxed_timeout()

This enables the barrier tests to be built as a module by exporting the=20
internal delay and timer functions for KUnit.

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
Since smp_cond_load_relaxed_timeout() is an inline macro that expands to ca=
ll
cpu_poll_relax() and __cmpwait_relaxed_timeout(), and those rely on
__delay_cycles(), does restricting this export to KUnit builds break standa=
rd
loadable modules?

If a standard kernel module (built without CONFIG_KUNIT) tries to use the
generic smp_cond_load_relaxed_timeout() API, it seems it will fail to link
with a modpost error because this mandatory symbol isn't exported. Would a
standard EXPORT_SYMBOL_GPL() be more appropriate here to ensure the generic
barrier API remains usable by all modules?

> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/a=
rm_arch_timer.c
> index 4adf756423de9..91ab8552ead83 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c

[ ... ]

> @@ -897,6 +898,7 @@ bool arch_timer_evtstrm_available(void)
>  	 */
>  	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);

[Severity: Medium]
Similar to __delay_cycles() above, arch_timer_evtstrm_available() is called
by the inline expansion of smp_cond_load_relaxed_timeout(). Does this
conditional export render the generic synchronization API unusable for
non-KUnit modules that might want to use it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831202251.3050=
46-1-ankur.a.arora@oracle.com?part=3D13
