Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406232772D
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501605; cv=none; b=jMRsP9PpFF74hcZQom04GlqXV/fcbk/Oo7HG/JsWQgyziVfkow2e1BR7eMrd+vKwgCIv2ge2m6ZjrnGEWltbVeZqmaZF8UgmWsxT0nMNkPBWdhrt691D/mOluWmtjHtkhc3G32lukt2mWf5Zw8Jl7Ybla5W1qYdIy+Y/JJgdg1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501605; c=relaxed/simple;
	bh=/QLfw+E5odwpY+WkiwlyboSDPhGnUmINAuAUfO2FQI4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oo0VS+JVm6LtTk8e+uQAlGapp0TfUdK2RKd/6swd4vF4/uTNjXMzLu8jRmzfKUFysbEbGjGl7Y8fK3nix4w54IwNcGq8KvDukM4/FyfSl5gBDtrVQf4sWCKRQ+7kBN9n/1IjXm6j6X4ymv8p9tou/Xt79goGnTu6uh+VZdWYF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H49LFumh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H49LFumh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD5C1F000FF;
	Tue, 15 Sep 2026 19:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789501601;
	bh=U28UAzVZeTlmqda1ntoD5UBgiOak619h7EikANOPMCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H49LFumhLYaQUxx8iFHnxl2jTdyT6Lcd/B33lp4NMekNRiCmQCcjf6QATQkMTkbsd
	 6pt9FZazHJRLfOPI/me+3NlBX6r9uggVxLUoLdDLG42Yt2+2AijTqAv7dOAEyfw1bL
	 dnPN04iCArvhBNUnwaL41S/o8H9r3I6CC51q5JpbrScWIYdhQ4cMEHvMruXEVcLXNT
	 GqRfKMlElETz0RwNhYyTsSlVVpB3OX0GzAqoJQ+sZY/OVtACuHEFXV/5YEkFr8vxjj
	 zCR88FhY6mmOL2xFsVHQB2ZDn3FdP8KbHGrLU5fkDMU+Sn7+3KC1VJkZJVVj8yCYgR
	 veqpgRB5jvk7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] x86/shstk: support via prctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Roberts" <bill.roberts@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260916095224.1533971-5-bill.roberts@arm.com>
References: <20260916095224.1533971-1-bill.roberts@arm.com>
 <20260916095224.1533971-5-bill.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 19:46:40 +0000
Message-Id: <20260915194641.2BD5C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] x86/shstk: arch_set_shadow_stack_status() evaluates current inst=
ead of target task t
- [Low] x86/shstk: unreachable rollback logic in arch_set_shadow_stack_stat=
us()
--

commit ed012132e6df19703869995c7c9b00ea27466792
Author: Bill Roberts <bill.roberts@arm.com>

x86/shstk: support via prctl
   =20
This commit wires up the generic prctl handlers for shadow stack on x86,
mapping PR_SET_SHADOW_STACK_STATUS and related operations to the internal
CET helper routines. This allows userspace to manage shadow stacks via a
cross-architecture interface while maintaining compatibility with arch_prct=
l.

> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 0ca64900192f8..249c4998732ac 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
[ ... ]
> @@ -630,3 +631,85 @@ bool shstk_is_enabled(void)
>  {
>  	return features_enabled(ARCH_SHSTK_SHSTK);
>  }
> +
> +/* Handles the generic prctl interface for PR_SET_SHADOW_STACK_STATUS an=
d its feature bits */
> +int arch_set_shadow_stack_status(struct task_struct *t, unsigned long st=
atus)
> +{
> +	int rc;
> +	bool shstk_was_enabled =3D features_enabled(ARCH_SHSTK_SHSTK);

[Severity: Medium]
Does this code incorrectly evaluate the shadow stack status of current inst=
ead
of the target task t?

The features_enabled() helper strictly evaluates the features of the current
task via current->thread.features. If arch_set_shadow_stack_status() is ever
called to configure a remote task's shadow stack where t !=3D current, it w=
ill
evaluate the caller's state rather than the target's state. This could
potentially short-circuit and silently fail to configure the target task.

> +
> +	/*
> +	 * One must explicitly perform enable/disable calls for the whole featu=
re set so
> +	 * that the locked bits are checked. It is also important to capture en=
try state
> +	 * for roll-back if needed. However, we must NOT try to enable or disab=
le a feature
> +	 * unless there is a change in feature status from old to new state. Th=
is is
> +	 * because shstk_prctl(), correctly, checks locked bits before feature =
enabled/disabled
> +	 * short circuit.
> +	 */
> +	switch (status) {
[ ... ]
> +	case PR_SHADOW_STACK_ENABLE:
> +		if (!shstk_was_enabled) {
> +			rc =3D shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		if (features_enabled(ARCH_SHSTK_WRSS)) {

[Severity: Medium]
Will this again erroneously evaluate the WRSS feature state of current
instead of the target task t?

> +			rc =3D shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_WRSS);
> +			if (rc && !shstk_was_enabled)
> +				shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);

[Severity: Low]
Is this rollback for ARCH_SHSTK_SHSTK unreachable?

ARCH_SHSTK_WRSS can only be enabled if ARCH_SHSTK_SHSTK is already enabled.
Because of this, if features_enabled(ARCH_SHSTK_WRSS) evaluates to true
allowing entry into this block, shstk_was_enabled must also be true.
Therefore, !shstk_was_enabled is always false in this context, making this
rollback structurally dead code.

> +			return rc;
> +		}
> +
> +		return 0;
> +
> +	case PR_SHADOW_STACK_ENABLE|PR_SHADOW_STACK_WRITE:
> +		if (!shstk_was_enabled) {
> +			rc =3D shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		if (!features_enabled(ARCH_SHSTK_WRSS)) {

[Severity: Medium]
Will this also erroneously evaluate the WRSS feature state of current
instead of the target task t?

> +			rc =3D shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_WRSS);
> +			if (rc && !shstk_was_enabled)
> +				shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
> +
> +			return rc;
> +		}
> +
> +		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916095224.1533=
971-1-bill.roberts@arm.com?part=3D4
