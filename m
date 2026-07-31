Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B73B6BE5
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521186; cv=none; b=kaf69U9qjsLpkGSo9H9hLoknocdo7+mdfT9cUmXEcOZYlCsSnj3WvdXwjvabcXCm8uy0fYV41HIPw6w3SFO04allQC1Bly1Oyj288EdPO6Va/PPWrfGySixuLWC2E4G6boyE+mjtTH3NcRAyHW74SzVef9xFxxqbOUdERmkLTLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521186; c=relaxed/simple;
	bh=2+3JAuvszekYzKs56NS5OWqeT1M212o0etixKNUv4Po=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ObHoyx4sXP3bxSIFTyd/6+gr4Za/CNpu8dGxPD8Nff892KvNEJ9CMK0v6nxeIlAxmixhOGglE46i4HEeVR+7Lih6TMS3YOl67I0w6wqWC8jH6P+MjO5F6Cov+FF5i5YdMy4mQGlH6alWTdLjSJaXjMeJgKpgQL5XIKRzibw8od0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMQDGpO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMQDGpO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F84B1F00AC4;
	Fri, 31 Jul 2026 18:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785521185;
	bh=hXQYFz2mdcW+vibUqlxnolGajcbBaKmpIUB5MtJhN/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WMQDGpO6q2PU+h27IoYIdFKI7b0kSuU0ElwqBVeeIvx/Ypyp6gH+UrxM8NZ6ZIUjV
	 424A2shcXjwOOU+TYEK4QtsOZaI9F25gbGqFMR3cZY2eroJF4vCIaSZvdDCGZKhuwE
	 W0sGkCZlYEiwi0obbG3Li243yFlSN3zzkU64Kmz6GiBU1Yb6tD573kFz3DQr4Q72rd
	 JpdvlAK1J8WnO3fQK+wubcvC2gN7DCCF5/KedALxAutODhqyHsuj/VgxOdreerL+Nb
	 tP8V9bsrp+DvkUhNv8NY/FG1hiCXow95hrPTTtyNmbOnXazxjQbJIXc3eJh3NIE2IE
	 BU1e0ZsN8EBnw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v2 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731175358.3542156-2-andrey.grodzovsky@crowdstrike.com>
References: <20260731175358.3542156-1-andrey.grodzovsky@crowdstrike.com>
 <20260731175358.3542156-2-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:06:24 +0000
Message-Id: <20260731180625.4F84B1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch breaks livepatch kselftests by deprecating and rejecti=
ng writes to kernel.ftrace_enabled without updating the corresponding tests.
- [Low] Unused static functions `ftrace_shutdown_sysctl` and `is_permanent_=
ops_registered` were retained and marked with `__maybe_unused` instead of b=
eing properly removed.
--

--- Patch [1]: [RFC PATCH bpf-next v2 1/2] ftrace: deprecate disabling via =
ftrace_enabled sysctl ---
commit 6675b51e1176bc76210101b0a6a9da0c7a32dc59
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

ftrace: deprecate disabling via ftrace_enabled sysctl

This commit deprecates disabling ftrace via the kernel.ftrace_enabled
sysctl. It refuses writes of 0 by returning -EOPNOTSUPP and logging a
warning, rather than leaving the system in an inconsistent state.

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f93e34dd23288..82bb7356ccce5 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -9357,7 +9357,7 @@ static void ftrace_startup_sysctl(void)
>  	}
>  }
> =20
> -static void ftrace_shutdown_sysctl(void)
> +static void __maybe_unused ftrace_shutdown_sysctl(void)

[Severity: Low]
Since the only caller of ftrace_shutdown_sysctl() has been removed by this
patch, should this function be deleted entirely rather than kept around with
a __maybe_unused annotation?

>  {
>  	int command;

[ ... ]

> @@ -9377,7 +9377,7 @@ static void ftrace_shutdown_sysctl(void)
>  # define ftrace_shutdown_sysctl()      do { } while (0)
>  #endif /* CONFIG_DYNAMIC_FTRACE */
> =20
> -static bool is_permanent_ops_registered(void)
> +static bool __maybe_unused is_permanent_ops_registered(void)

[Severity: Low]
Similarly, is_permanent_ops_registered() appears to be completely dead code
now. Can this be safely removed instead of marking it __maybe_unused?

>  {
>  	struct ftrace_ops *op;

[ ... ]

> @@ -9415,15 +9415,12 @@ ftrace_enable_sysctl(const struct ctl_table *tabl=
e, int write,
>  		ftrace_startup_sysctl();
> =20
>  	} else {
> -		if (is_permanent_ops_registered()) {
> -			ftrace_enabled =3D true;
> -			return -EBUSY;
> -		}
> -
> -		/* stopping ftrace calls (just send to ftrace_stub) */
> -		ftrace_trace_function =3D ftrace_stub;
> -
> -		ftrace_shutdown_sysctl();
> +		/*
> +		 * Disabling ftrace at runtime via this knob is deprecated.
> +		 */
> +		ftrace_enabled =3D true;
> +		pr_warn_once("The ftrace_enabled file is deprecated and no longer disa=
bles ftrace\n");
> +		return -EOPNOTSUPP;

[Severity: Medium]
Will rejecting writes of 0 here break the livepatch kselftests?

Looking at tools/testing/selftests/livepatch/test-ftrace.sh, the scripts
explicitly toggle this sysctl and expect either success or an -EBUSY error
when a livepatch is active:

tools/testing/selftests/livepatch/test-ftrace.sh:
    set_ftrace_enabled 0
    load_failing_mod $MOD_LIVEPATCH
    ...
    # Check that ftrace could not get disabled when a livepatch is enabled
    set_ftrace_enabled --fail 0

Now that this returns -EOPNOTSUPP unconditionally, it looks like these
tests will fail or be skipped. Do the livepatch kselftests need to be
updated alongside this change?

>  	}
> =20
>  	last_ftrace_enabled =3D !!ftrace_enabled;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731175358.3542=
156-1-andrey.grodzovsky@crowdstrike.com?part=3D1
