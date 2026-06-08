Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F603AE1B8
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907528; cv=none; b=aKiu4WuIOmwXF5crImMA+s28doynH48MJcYTpM/6uCwkc1yx0k4mYJZ7wdL5PEkh08zW7827dmVrzr1BFwlgdCFj+AZMcLZkCO9f8EQjA4oV2yjZAqkNDsl8ZVWsFpRglbWguxngqA62F8fCJeG26RQ2sUdA6uHkmwvt2HILKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907528; c=relaxed/simple;
	bh=JBZyDYzmh5Cif494auRCh21aBXiJFX77rEtp4z3yQZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QOFPLD6AZIXN52qCbixxGLV3enIe1NmuyxeqDTr7mJNGtiKH2AeN7T6tPSF0qI1Vl+DA3uwuA52COIZVvRRroaD+bhvHCo8xMPZANGqKI5yz28GHlBzvB2JXFsCIIvVD2NkZQjwk3Wsbp9aaTxhn+DYads0Cnz5juIrwOeoWT2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/b7+832; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/b7+832"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8001F00893;
	Mon,  8 Jun 2026 08:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907527;
	bh=HZEQby5Uz9QmJVUWRms3J5x0s3EBQtkpXVuLs6jThX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/b7+832PJZKJ/taBKUNibARCHwuuWC84tl+Fo67QIyw5w1aFE/hkHnzuhnzQPCpV
	 M2ypo2MYjm3/WEK4+Xy4pjSMS3KTqsAAutK1bBss2ubV5cVZpC0NYqwHRVtOZ4yFsU
	 94QkMda0bqVMNUWdkOlTSJa+pmo8jocvHgOovGhD4Gi9nb6hA2Yk0Cj++huJ7gZjL4
	 wBdQmXgmf1ay4ejhwJw5nRDjwEyJ8eJhe6eX0S8jsGFAdrLmy/kpYJq2Obn573BAiG
	 PF3YyvMd1LfZcj1BOVyV1O99h7sxVKfEpOn0/e5354w59zJ6AJ/kUn+0MhfO2sXBt/
	 a5GMigVrYMXrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 13/15] arm64/delay: enable testing
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608080440.127491-14-ankur.a.arora@oracle.com>
References: <20260608080440.127491-14-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:32:06 +0000
Message-Id: <20260608083206.CA8001F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new generic smp_cond_load_relaxed_timeout() and atomic timeo=
ut APIs fail to link in loadable modules on ARM64 when KUnit is disabled du=
e to conditionally exported backend functions.
--

commit b5a10ff859d6e282c17d5ed23e24d2c5703beb7a
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64/delay: enable testing smp_cond_load_relaxed_timeout()

This commit enables the barrier tests to be built as a module by exporting
__delay_cycles and arch_timer_evtstrm_available specifically for KUnit
environments.

> diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
> --- a/arch/arm64/lib/delay.c
> +++ b/arch/arm64/lib/delay.c
[ ... ]
> @@ -30,6 +31,7 @@ u64 notrace __delay_cycles(void)
>  	guard(preempt_notrace)();
>  	return __arch_counter_get_cntvct_stable();
>  }
> +EXPORT_SYMBOL_IF_KUNIT(__delay_cycles);

[Severity: Medium]
Does exporting this only for KUnit prevent normal kernel modules from using
the generic smp_cond_load_relaxed_timeout() macro?

Since smp_cond_load_relaxed_timeout() expands into inline code that calls
__delay_cycles(), a loadable module using this generic API will fail to link
due to an undefined symbol in production kernels where KUnit is disabled.
Should this be unconditionally exported, perhaps via EXPORT_SYMBOL_GPL?

[ ... ]
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/a=
rm_arch_timer.c
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
[ ... ]
> @@ -896,6 +897,7 @@ bool arch_timer_evtstrm_available(void)
>  	 */
>  	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);

[Severity: Medium]
Similarly, does conditionally exporting this feature-check break the generic
barrier timeout primitives for modules?

Like __delay_cycles(), arch_timer_evtstrm_available() is called by the
inline implementations of the atomic timeout APIs. Leaving this unexported
for standard kernel configurations could cause link errors for any driver
that uses atomic_cond_read_acquire_timeout() or similar macros.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608080440.1274=
91-1-ankur.a.arora@oracle.com?part=3D13
