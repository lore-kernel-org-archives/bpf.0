Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6540BCB4
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541306; cv=none; b=V/IALkKluuIiUGUiOkj59ux7oA8XN9E9zlrZpd7ZYHZQ8n4KCIeiRnRJGrKOeVkRdoSYV+uRrpvxiMU/n+g4AQ0kqR2PuoXllN3VyZ4+f3rQCUxIleg8lDtws6DXoaMFV4/b+JTqLGTnAZzY8J1xQ/SRqeCAykA/RYTgGmm5ioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541306; c=relaxed/simple;
	bh=cCQt3XltxxinYN+HS5Em58q+pG9m+/7spm4ItUtunBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a26QQ2hZwN+mVyPFhqO0dUHp2jldXzYl/PFvHUiPy2gi4xd8D85/XtzPCVrlY6XdVPLQ9kwamXyO2c1bU7p8gM8W+8Ly5G1ppOAk5noIrwec0Nrcl5SgAFiAyhKB0N6kGad7UjXPlBhHwCTNmPYXTQMpGDWYZDq1BivTwLqDKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT0jCJ1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT0jCJ1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E451F000E9;
	Mon, 15 Jun 2026 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781541304;
	bh=6tEQJA4OR4Bf8DuoAfqaLluqky3Fsqzm1+tUBcrdQno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GT0jCJ1Pzks5+uKhSNQ2ZLe5tJLBdr7afGNOpgkJTHVQyGAk39G3/VRm0Mstrmfrf
	 x3I/H7Jf//HyNH9aMVCS6NE1CLweH76m6OI0sDoKRlu8LYQYcoUbuuoLQggdSKPgtR
	 NdUKwrtNhzFF2AwlLn05UgSpWvCJRYLgwBktEK478egABruddjZuVhvcYW0f+0OxIc
	 3EHSzBsX/1i+EKpvrLe6O23zi8Ka5e1NIHb9F1WltG3iLPGBC6iF4U7NVB4wpgT/l4
	 Yy8xHOP4qICP8E3iuClifVtB8MbF9wmF8XE5a1cveWrKeeSMgsEYVTuHDNE8cJ1Bga
	 blQIualRj7fdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] seccomp: Allow upgrading to strict mode after
 enabling filters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamie Hill-Daniel" <clubby789@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615-seccomp-combined-v2-2-41687a943ae0@hill-daniel.co.uk>
References: <20260615-seccomp-combined-v2-2-41687a943ae0@hill-daniel.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 16:35:04 +0000
Message-Id: <20260615163504.C4E451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Stale syscall number is evaluated in the strict mode check after a=
 ptracer modifies the syscall, potentially causing false positive kills.
- [High] Upgrading to strict mode from filter mode skips arch_seccomp_spec_=
mitigate, potentially leaving strict processes vulnerable to speculative ex=
ecution flaws.
- [Medium] Missing `strict_upgrade` check in `seccomp_set_mode_filter` allo=
ws bypassed filter installation and TSYNC when seccomp is suspended.
--

commit 586f767ffd81c4f0c9b3df714ec047c0eabb4c30
Author: Jamie Hill-Daniel <clubby789@gmail.com>

seccomp: Allow upgrading to strict mode after enabling filters

Add a strict_upgrade flag to seccomp, which is enabled when
SECCOMP_MODE_STRICT is set after filters have been installed. This
will run the strict mode checks after all filters have been run.

This flag blocks thread syncing, in keeping with regular
SECCOMP_MODE_STRICT.

[ ... ]

> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 2d21cb6bbd94d..57ca0c49ec062 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c

[ ... ]

> @@ -1405,7 +1402,10 @@ int __secure_computing(void)
>  		__secure_computing_strict(this_syscall);  /* may call do_exit */
>  		return 0;
>  	case SECCOMP_MODE_FILTER:
> -		return __seccomp_filter(this_syscall, false);
> +		filter_ret =3D __seccomp_filter(this_syscall, false);
> +		if (current->seccomp.strict_upgrade)
> +			__secure_computing_strict(this_syscall);
> +		return filter_ret;

[Severity: High]
If a filter returns SECCOMP_RET_TRACE, a ptracer can change the syscall num=
ber.
While __seccomp_filter() correctly handles this by fetching the new syscall=
 and
evaluating it against strict mode internally, this outer check in
__secure_computing() uses the original, unmodified this_syscall variable.

Does this redundant check use a stale this_syscall value, potentially killi=
ng
the process for a syscall that was already legitimately sanitized by the
ptracer?

>  	default:
>  		BUG();
>  	}

[ ... ]

> @@ -1420,30 +1420,23 @@ long prctl_get_seccomp(void)
>  /**
>   * seccomp_set_mode_strict: internal function for setting strict seccomp
>   *
> - * Once current->seccomp.mode is non-zero, it may not be changed.
> - *
> - * Returns 0 on success or -EINVAL on failure.
> + * If current->seccomp.mode is SECCOMP_MODE_FILTER, this will enable
> + * strict_upgrade.
>   */
> -static long seccomp_set_mode_strict(void)
> +static void seccomp_set_mode_strict(void)
>  {
>  	const unsigned long seccomp_mode =3D SECCOMP_MODE_STRICT;
> -	long ret =3D -EINVAL;
> -
>  	spin_lock_irq(&current->sighand->siglock);
> =20
> -	if (!seccomp_may_assign_mode(seccomp_mode))
> -		goto out;
> -
>  #ifdef TIF_NOTSC
>  	disable_TSC();
>  #endif
> -	seccomp_assign_mode(current, seccomp_mode, 0);
> -	ret =3D 0;
> +	if (current->seccomp.mode =3D=3D SECCOMP_MODE_FILTER)
> +		current->seccomp.strict_upgrade =3D 1;
> +	else
> +		seccomp_assign_mode(current, seccomp_mode, 0);

[Severity: High]
When a process enters filter mode using the SECCOMP_FILTER_FLAG_SPEC_ALLOW
flag, it opts out of speculative execution mitigations.

By skipping seccomp_assign_mode() when upgrading from filter mode, are we
failing to retroactively enforce these mitigations (like SSBD/STIBP) which =
are
normally enforced by strict mode?

> -out:
>  	spin_unlock_irq(&current->sighand->siglock);
> -
> -	return ret;
>  }

[ ... ]

> @@ -2015,7 +2006,8 @@ static long seccomp_set_mode_filter(unsigned int fl=
ags,
> =20
>  	spin_lock_irq(&current->sighand->siglock);
> =20
> -	if (!seccomp_may_assign_mode(seccomp_mode))
> +	/* Reachable if PTRACE_O_SUSPEND_SECCOMP has been used */
> +	if (current->seccomp.mode =3D=3D SECCOMP_MODE_STRICT)
>  		goto out;

[Severity: Medium]
When a process uses strict_upgrade, its mode remains SECCOMP_MODE_FILTER.

Since this check only verifies SECCOMP_MODE_STRICT, does it allow a suspend=
ed
process with strict_upgrade set to successfully append new filters or use
SECCOMP_FILTER_FLAG_TSYNC, violating the immutability of strict mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-seccomp-co=
mbined-v2-0-41687a943ae0@hill-daniel.co.uk?part=3D2
