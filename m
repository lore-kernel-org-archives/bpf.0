Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815440BCD8
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541255; cv=none; b=oC78UnEA83DpHLpGIQ6NnZGnanBc5NftbX0/SsnY8/xhgDpE7qzegxxpEhEp6CaZBJNTYY2uxeL0aMIlTqTX1ZW8yIClhkXaGclbucwsr8MFzRvr7ANBDcip9zdCsQWVJcissUNmDZyohaXv2+xQ2Qbct0m+MF429BA1+/rPBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541255; c=relaxed/simple;
	bh=ikBUh3+oO5pnFDy21J7cz7ZKP551h8kN2rES9eAKFQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bb18jDEIBNO0lvK5pN/5C4fNa0W1dycc8jLtcv5wWc87yLKt7Ap7/fDjL7aj9VmyxMR2SUQurmKAs/PbofZ1gkOnixD0GTq35nyI7FuKSAmkyZJ9+a5XJ/dpfM2gy+yPOaW+FlyxCETEJe8532At9GR31CECCa1L8QZkpCBEaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgyguge5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgyguge5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648FA1F000E9;
	Mon, 15 Jun 2026 16:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781541253;
	bh=r8MiEiU3TRWfzuEypthgs786uZtL49k2HhISxhOPxfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fgyguge5f88SROVX2bM7lLQVbY3kal7s0JBX8gHptr7mJ4jljkhhSV+QDqMZrdFhC
	 oDFZL6xX6gbIaLITG8nfQyEZEwREG6OntiXjE0r1KfcE0oWAFZ488T+djWTCpPqlIh
	 lCPxNefSiDuN4DeJimwiCqEQ9x1mRtSfsFTEo0oCOM+W/SDtK2Ogpks3Z6+iXCrd0o
	 63oYzGjNFvF0/r5m5v5G8C1ECT1E7R8Debl7silDZg8rRNniEEQ/yYa+JVtXX47KNu
	 ZhLruxP1QYNRsSIt95ovHytTvyy0siJacCsDJBOdHfelOUUKI1sTDHnHwDDWDxt2sd
	 S+rezX5cDXPLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] seccomp: Store death as a separate field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamie Hill-Daniel" <clubby789@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615-seccomp-combined-v2-1-41687a943ae0@hill-daniel.co.uk>
References: <20260615-seccomp-combined-v2-1-41687a943ae0@hill-daniel.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 16:34:13 +0000
Message-Id: <20260615163413.648FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added defense `if (unlikely(current->seccomp.dead))` was=
 omitted from the non-BPF fallback implementation of `secure_computing_stri=
ct()`.
--

commit 17b53379696e6ea38281041129401658643c996d
Author: Jamie Hill-Daniel <clubby789@gmail.com>

seccomp: Store death as a separate field

This patch removes SECCOMP_MODE_DEAD and stores the death state in a new
bitfield within struct seccomp. This allows the mode field to strictly store
the current seccomp mode while exposing it to userspace.

> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 066909393c38f..2d21cb6bbd94d 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c

[ ... ]

> @@ -1396,17 +1393,19 @@ int __secure_computing(void)
> =20
>  	this_syscall =3D syscall_get_nr(current, current_pt_regs());
> =20
> +	/* Surviving SECCOMP_RET_KILL_* must be proactively impossible. */
> +	if (unlikely(current->seccomp.dead)) {
> +		WARN_ON_ONCE(1);
> +		do_exit(SIGKILL);
> +		return -1;
> +	}
> +

[Severity: High]
Is it possible we need this same check in the non-BPF fallback version of
secure_computing_strict()?

When CONFIG_HAVE_ARCH_SECCOMP_FILTER is disabled, secure_computing_strict()
evaluates current->seccomp.mode. Previously, if a killed process miraculous=
ly
survived do_exit() and issued another syscall, the mode would be
SECCOMP_MODE_DEAD and trigger a BUG() instead of executing
__secure_computing_strict():

kernel/seccomp.c:secure_computing_strict() {
    ...
    if (mode =3D=3D SECCOMP_MODE_DISABLED)
        return;
    else if (mode =3D=3D SECCOMP_MODE_STRICT)
        __secure_computing_strict(this_syscall);
    else
        BUG();
}

With the new dead bitfield, if the process survives and issues a valid
strict-mode syscall (e.g. exit), the mode remains SECCOMP_MODE_STRICT.
It appears we'll simply execute __secure_computing_strict() again and
return successfully without killing the process, neutralizing the fail-safe.

>  	switch (mode) {
>  	case SECCOMP_MODE_STRICT:
>  		__secure_computing_strict(this_syscall);  /* may call do_exit */
>  		return 0;
>  	case SECCOMP_MODE_FILTER:
>  		return __seccomp_filter(this_syscall, false);
> -	/* Surviving SECCOMP_RET_KILL_* must be proactively impossible. */
> -	case SECCOMP_MODE_DEAD:
> -		WARN_ON_ONCE(1);
> -		do_exit(SIGKILL);
> -		return -1;
>  	default:
>  		BUG();
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-seccomp-co=
mbined-v2-0-41687a943ae0@hill-daniel.co.uk?part=3D1
