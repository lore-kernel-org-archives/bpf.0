Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81E219E8
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555974; cv=none; b=Lx1OxCL+TT58P98AI7zDO86aYfwqVP0XCYbwwWvR++bDUt92ZvetH45zdD3ZIcnYZliQM0bODGUGjSFxEIjktFVKFPUXwj8ISwuKhIHbX6Pl5UncMuRclreqfCIhxsaPbnaMy6AWAyYjnlhDTnIX0x6Cqb5cIf6ug1JY+G9g2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555974; c=relaxed/simple;
	bh=zK/zEmXEsjW/GpsySoXIJrrpiYnIBG3rX7CJUlYMoBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BnDat1Cdx4JRAX/9hXayinhTx2vSF0WO2Im8Ev+N+xLJwAyu/6ebESYO13+yEvCBPnGsNw7QxztFhnSGNTe0PFP6KxyXRm6jLRg6AQnfmDp9vWrvWY3qSrSC3JSULAd83UgNgsfq/eMyR1Na5Iemwf4pc2riFbn90eHmLj8PL+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPrUjKnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPrUjKnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1A41F000E9;
	Wed, 12 Aug 2026 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555972;
	bh=Q/HaG20tSjZcYAS9SIXrdL20MvyqnDsNiwE1rEnGVAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YPrUjKnTSb3FYJbtYhtn4MCMokA3evm1PaM2BhoscrkAcYIFm8Ol5J/N3R8Ld5dr6
	 HfmXwAJDSM0dVRhNnpEWKi4wefxnUuNcolOdp4i3qthhbAJ+9b4tWidsg2DYRrfzbm
	 gHSL4EtaJHBUWR5VLfcoQC9wHlhS0jlZn3dlnA9/0CItq09nRdgP/GBsP54HqvYpge
	 jjLavYr7DKg3MuS1PSNvQ8o6QrVQiHadfVsNcvHYuIGYps6gue82LPPBtO9ktGXZs4
	 WkUyhzXPUHfRu2Hgwc3rDqEri1FFGozfucVlXCjkUoTI7WXAh1b+cKDKEXYL+dZ9T6
	 iDKJth2tKRDgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] x86/shstk: support via prctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Roberts" <bill.roberts@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812171940.1046116-1-bill.roberts@arm.com>
References: <20260812171940.1046116-1-bill.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:32:51 +0000
Message-Id: <20260812173252.6C1A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Operator precedence bug in `!status & PR_SHADOW_STACK_ENABLE` comp=
letely breaks the generic shadow stack configuration.
- [High] Non-atomic updates and redundant `shstk_prctl` calls cause spuriou=
s `-EPERM` failures when setting status.
- [Medium] `PR_SHADOW_STACK_PUSH` is advertised in the supported mask but c=
ompletely ignored, causing API state drift.
- [Medium] Missing validation in `arch_lock_shadow_stack_status` allows use=
rspace to lock arbitrary undefined bits.
- [Medium] `arch_get_shadow_stack_status` leaks internal x86-specific `ARCH=
_SHSTK_*` flags into the generic API.
--

--- Patch [1]: [PATCH v2 1/2] x86/shstk: support via prctl ---
commit 4cf523bcec8bfd8fcae95b19efb75978b5323431
Author: Bill Roberts <bill.roberts@arm.com>

x86/shstk: support via prctl

This commit wires up the generic prctl handlers for shadow stack on x86,
mapping generic PR_SHADOW_STACK_* operations to internal CET routines.

> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 0ca64900192f8..c34ba3701dd06 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
[ ... ]
> @@ -630,3 +631,39 @@ bool shstk_is_enabled(void)
>  {
>  	return features_enabled(ARCH_SHSTK_SHSTK);
>  }
> +
> +#define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK \
> +		(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE | PR_SHADOW_STACK_PUSH)

[Severity: Medium]
Is PR_SHADOW_STACK_PUSH fully supported here? The flag is included in this
supported mask, but arch_set_shadow_stack_status() below doesn't appear
to map or apply it, meaning attempts to set it will be silently ignored.

> +
> +/* Handles the generic prctl interface for PR_SET_SHADOW_STACK_STATUS an=
d its feature bits */
> +int arch_set_shadow_stack_status(struct task_struct *t, unsigned long st=
atus)
> +{
> +	int rc;
> +
> +	if (status & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
> +		return -EINVAL;
> +
> +	/* x86 arch_prctl is single bit at a time, so handle these one at time =
*/
> +	if (!status & PR_SHADOW_STACK_ENABLE)

[Severity: High]
Does this condition evaluate correctly? Because of operator precedence,
!status is evaluated before the bitwise AND.

If a user passes 0 to disable all features, (!0) & 1 evaluates to 1,
causing it to erroneously call shstk_prctl() to disable ARCH_SHSTK_SHSTK
and return early, skipping ARCH_SHSTK_WRSS disablement.

> +		return shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
> +
> +	rc =3D shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
> +	if (rc)
> +		return rc;
> +
> +	if (status & PR_SHADOW_STACK_WRITE)
> +		return shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_WRSS);

[Severity: High]
Will this sequence of shstk_prctl() calls fail if features are already lock=
ed?

If userspace has already enabled and locked PR_SHADOW_STACK_ENABLE, and
later calls this function to add PR_SHADOW_STACK_WRITE, the first
shstk_prctl() call for ARCH_SHSTK_SHSTK will return -EPERM because the
feature is locked. This would cause the set operation to abort without
ever enabling the write feature.

> +
> +	return shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_WRSS);
> +}
> +
> +/* Handles the generic prctl interface for PR_LOCK_SHADOW_STACK_STATUS a=
nd its feature bits */
> +int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long s=
tatus)
> +{
> +	return shstk_prctl(t, ARCH_SHSTK_LOCK, status);
> +}

[Severity: Medium]
Should the status mask be validated here before passing it to shstk_prctl()?

Without validation, userspace can pass arbitrary bits into the internal
lock handler. If x86 adds new internal ARCH_SHSTK_ features later, legacy
applications might accidentally lock those future features.

> +
> +int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __=
user *status)
> +{
> +	return shstk_prctl(t, ARCH_SHSTK_STATUS, (unsigned long)status);
> +}

[Severity: Medium]
Is it safe to directly leak the internal x86-specific ARCH_SHSTK_* flags
into this generic API?

Currently, ARCH_SHSTK_SHSTK (bit 0) and ARCH_SHSTK_WRSS (bit 1) happen to
align with PR_SHADOW_STACK_ENABLE and PR_SHADOW_STACK_WRITE, but relying
on this 1:1 mapping seems fragile. Any new internal ARCH_SHSTK_* flag
added in the future could be exposed to generic userspace directly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812171940.1046=
116-1-bill.roberts@arm.com?part=3D1
