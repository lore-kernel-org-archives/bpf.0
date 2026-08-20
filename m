Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1A488DAE
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240666; cv=none; b=sbla8jZ59pcxe+1KtJsSv770dM9UcA/H3USLMBtphCdpfYUpaacF8/ChON2hKMQBisiaHUZLRHtq4tco1gHzN2nHSEzD+IJsam8xk52SIP+WaIPaECRRdUQjgaFQWKnwmFxItP9cvZ/dab1xoxU96FIzXKlGyySXwsvvSedHaJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240666; c=relaxed/simple;
	bh=g2v+tlbQI3sTKlTGRuzEcUSo/x6AIqKXvUP+YX2m7wA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HEeYO8Xg5GzRX9/Vel+gxDvjyDd9plckRGx0Jjlj3nUEA8X59ga0dsXV7Cld+TYYNE35740607MvmtQlm1LwPPITCKjdDcQcakDbUSEWPSxei2mIotnpl0ThAEVEsBMrWs8xyeiz3PHJsugzNlDX1HtgT20LDYhQblTTGNokuc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXYM287+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXYM287+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0B01F01559;
	Thu, 20 Aug 2026 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787240658;
	bh=HQRoL237DmR2u7P1eXzgoaf2mKwxetKZHaS3f8cGGsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HXYM287+O1gQPCO/W3yDI5bnTCuaN3Z0jnuGFdE+WSX3upgG7q+e8x9Qh/1sX7j6Y
	 27YUVa2g5k7yUENvFUSmB78vp8knGxf6LWxPsIyIqqjMzjwf67oiO+QbFYSkzehtPg
	 Kvpt1dv54vcZXh7zSXE5SJdWKkQDT9UStVrACby/pcmBudgAtv8f/E/Hg3g0+fMEaK
	 /74BCZ9oiByu65LQjw+GkFTQpUykccREBc0oKI/eB+4bi1fcuRg1/nEF/ABG+Z/mok
	 4Tzx0jep9xpvg5DiLwHvw1qK6vRYDhwhHhCC8jNBSY9QMWp6t3BDZlH4v1g5H+DQiS
	 BNN8J2ykVve8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] x86/shstk: support via prctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Roberts" <bill.roberts@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260818225428.1983328-5-bill.roberts@arm.com>
References: <20260818225428.1983328-1-bill.roberts@arm.com>
 <20260818225428.1983328-5-bill.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 15:44:17 +0000
Message-Id: <20260820154417.EE0B01F01559@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Flawed rollback logic destroys an already-enabled shadow stack if =
enabling WRSS fails.
- [High] Unconditional toggling of WRSS causes spurious failures and partia=
l state application when features are locked.
- [Medium] Setting PR_SHADOW_STACK_WRITE without PR_SHADOW_STACK_ENABLE sil=
ently disables the shadow stack.
--

--- Patch [4]: [PATCH v3 4/5] x86/shstk: support via prctl ---
commit b3742dadd5cde35b115774fa09769c5a44a81e76
Author: Bill Roberts <bill.roberts@arm.com>
Subject: x86/shstk: support via prctl

This commit wires up the generic prctl handlers for shadow stack on x86,
mapping PR_SHADOW_STACK_ENABLE, PR_SHADOW_STACK_DISABLE, and
PR_SHADOW_STACK_LOCK to the internal CET helper routines. This provides a
consistent cross-architecture interface for user-space applications to
manage control-flow integrity.

> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 0ca64900192f8..2c2a96b2d9367 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c

[ ... ]

> @@ -630,3 +631,58 @@ bool shstk_is_enabled(void)
>  {
>  	return features_enabled(ARCH_SHSTK_SHSTK);
>  }
> +
> +#define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK \
> +		(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE)
> +
> +/* Handles the generic prctl interface for PR_SET_SHADOW_STACK_STATUS an=
d its feature bits */
> +int arch_set_shadow_stack_status(struct task_struct *t, unsigned long st=
atus)
> +{
> +	int rc;
> +	int tmp_rc;
> +
> +	if (status & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
> +		return -EINVAL;
> +
> +	/*
> +	 * x86 arch_prctl is single bit at a time, so handle these one at time
> +	 * If anything fails, rollback state.
> +	 */
> +	if (!(status & PR_SHADOW_STACK_ENABLE))
> +		return shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);

[Severity: Medium]
Does this silently ignore a request for PR_SHADOW_STACK_WRITE without
PR_SHADOW_STACK_ENABLE?

If an application calls prctl(PR_SET_SHADOW_STACK_STATUS,
PR_SHADOW_STACK_WRITE), the condition (!(status & PR_SHADOW_STACK_ENABLE))
evaluates to true.

It appears this will call shstk_prctl() to disable the shadow stack and
return 0 for success, instead of returning an error like -EINVAL for the
unsupported configuration.

> +
> +	rc =3D shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
> +	if (rc)
> +		return rc;
> +
> +	if (status & PR_SHADOW_STACK_WRITE) {
> +		rc =3D shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_WRSS);
> +		/* rollback, best attempt, if we actually enabled shadow stack in feat=
ure bits */
> +		if (rc && (status & PR_SHADOW_STACK_ENABLE)) {
> +			tmp_rc =3D shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
> +			WARN(tmp_rc, "Could not rollback shadow stack enabled: %d\n", tmp_rc);
> +		}

[Severity: High]
Can this rollback logic unintentionally destroy an already-enabled shadow
stack?

If an application already has its shadow stack enabled, but WRSS is locked
to disabled, a call to prctl(PR_SET_SHADOW_STACK_STATUS,
PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE) will process the SHSTK
enable as a no-op (returning 0).

When it attempts to enable WRSS, shstk_prctl() will return -EPERM due to
the lock. The rollback condition checks (status & PR_SHADOW_STACK_ENABLE)
from the user request rather than checking if SHSTK was actually toggled
during this specific call. Could this cause the pre-existing shadow stack
to be disabled?

Additionally, a concurrent thread locking the shadow stack during the
rollback window could trigger a user-controllable kernel WARN, potentially
leading to a denial of service if panic_on_warn is set.

> +
> +		return rc;
> +
> +	}
> +
> +	return shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_WRSS);
> +}

[Severity: High]
Will this unconditional disablement return spurious errors when features
are locked?

If an application locks WRSS to disabled, and later calls
prctl(PR_SET_SHADOW_STACK_STATUS, PR_SHADOW_STACK_ENABLE) without the
WRITE flag, the shadow stack is successfully enabled.

However, the code falls through to unconditionally call shstk_prctl(t,
ARCH_SHSTK_DISABLE, ARCH_SHSTK_WRSS). Because WRSS is locked,
shstk_prctl() will fail with -EPERM, even though the target state matches
the current disabled state.

Could this return an error to user space after partially applying the
state, potentially leaking the allocation if the application aborts based
on the error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818225428.1983=
328-1-bill.roberts@arm.com?part=3D4
