Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D42489894
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785431412; cv=none; b=Ok2rlpfQ7tNdqhUbSWki9OA+iA1hdK9Is/K8Y9m2hHV49gTbWHPxTzD5ziQO5jlkjb+12uKIUFEY5Ld8vC/xpmD7DRtXQ5+6q+hCxLM6XJ+mwYtH4sur5TSj6KERfv+XtyjMmJXkKCJYs8QorkBuA72MSsOe9tIEpMr9A9XQjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785431412; c=relaxed/simple;
	bh=HursokCewXSsUhonRHxwvg7GpIShdtqTgaPmx6HMGjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RZvCEEgM6XxC5FTbr3SuxVnYi1nu6GF3K+zZkUAXhJQrFKzJWjnqe9Lkf43BUbpsgG7ojyIncpwAiOK/PZRK9pA0SwNIllkneOSsZyXNJq5e56wMZTAUQ8G40BVrF5qPQpJEtUTDzWWL05g6zC2QmSwq6G7NNp0I5Q+eF9IlTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZRr9FE0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZRr9FE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5A91F000E9;
	Thu, 30 Jul 2026 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785431410;
	bh=WvwvoWD3bqSTwFIQlMRHU1K4baSoGNn+x5jP0cnEb3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HZRr9FE0LFyNgZjR0r5lZIYSw2aRJScTvNbJgJUiaLLWTC94WXxxlOykYf5/yoc5f
	 MVjg+Rlttq2Nka484+DaprTXgsNlEuyhESt0ZtUV/4LtqBtgrhE4NRDOvK0CLgjX+0
	 yuVyo6LwfXUMWv6GDUzDydq/8+0fkz/vjESKZzoIwRGOP8RYmPidhrk+uczC3U77pG
	 xg/KlsJCApnpgAkx8L4RFzobDj3V+qo2KbptO4IpklGHz9BOT+j98bbIo0/iwjngm5
	 WdhcCs1rWb8D0AfXD3IVNIcg4JAUos3cLS9oBzoDNJHkAVmlxyw1PuTuagAVJykJlh
	 +3Y+y10Mem+9w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260730163544.2042327-2-andrey.grodzovsky@crowdstrike.com>
References: <20260730163544.2042327-1-andrey.grodzovsky@crowdstrike.com>
 <20260730163544.2042327-2-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 17:10:09 +0000
Message-Id: <20260730171010.3E5A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The livepatch ftrace selftest is broken because it explicitly te=
sts the deprecated `kernel.ftrace_enabled` sysctl behavior.
- [Low] The functions `ftrace_shutdown_sysctl` and `is_permanent_ops_regist=
ered` are now completely unused but are left in the codebase.
--

--- Patch [1]: [RFC PATCH bpf-next 1/2] ftrace: deprecate disabling via ftr=
ace_enabled sysctl ---
commit b118500ef9b6245b16b7bddf0a01d982bf5b52ce
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

ftrace: deprecate disabling via ftrace_enabled sysctl

This commit deprecates disabling ftrace via the kernel.ftrace_enabled
sysctl. Writing 0 to the sysctl now returns -EOPNOTSUPP and logs a warning
instead of attempting to disable ftrace.

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
Since the only caller in ftrace_enable_sysctl() has been removed, should th=
is
function be deleted entirely instead of keeping it around as dead code with
the __maybe_unused attribute?

[ ... ]

> -static bool is_permanent_ops_registered(void)
> +static bool __maybe_unused is_permanent_ops_registered(void)
[Severity: Low]
Similarly, should this function be removed entirely since it is no longer
called anywhere?

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
Will this break the livepatch selftests?

The script tools/testing/selftests/livepatch/test-ftrace.sh explicitly atte=
mpts
to write 0 to the sysctl on line 18:

tools/testing/selftests/livepatch/test-ftrace.sh:
    set_ftrace_enabled 0

Because this is now refused, the helper function in functions.sh detects the
failure and skips:

tools/testing/selftests/livepatch/functions.sh:set_ftrace_enabled() {
    ...
    if [[ $(cat /proc/sys/kernel/ftrace_enabled) !=3D "$1" ]]; then
        skip "failed to set kernel.ftrace_enabled =3D $1"
    ...
}

This skip call unconditionally exits the script, preventing the remaining t=
ests
in the file from running. Should the selftests be updated to reflect this
change in behavior?

>  	}
> =20
>  	last_ftrace_enabled =3D !!ftrace_enabled;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730163544.2042=
327-1-andrey.grodzovsky@crowdstrike.com?part=3D1
