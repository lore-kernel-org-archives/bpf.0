Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65794377015
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030921; cv=none; b=cuk66cIunDEw10X5TC0M26inBSDH23R5UjcVTVIJgIS22icqUVF3Zs8gw0bRYeGWqdk05sefB2Y6stVf3j8HVLVxsc0U+lWu5lrqHZXcOsUvOD4oG/98kGeVCwzDHL7Hf9lzQMF3RZEZ9ss7AI2E0HrZFpwTwhdPNPxu3+CiOsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030921; c=relaxed/simple;
	bh=7oeS/G6HxZiSsHPacH1pt1nyPJV94MEU6QMoruXIizQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mznw1feg/8RPQOMOhUZkIl8/rILoJd60h+bt6iR1gE6UBVf1N0vZ3iqBf2qBVeWuGwgniTnqCnz4oFVvdFGiGNJICkHXqMvVu5PH1Yo+sqlKmJr1YB0CTpL8S0zZj3CZ4mNHRDNLhUhzGtkV8ue+KJg+uisiGgSml26Pqgfywkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwvRUSyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwvRUSyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BB01F000E9;
	Thu,  6 Aug 2026 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786030918;
	bh=9nKQlrHWQODoimi2oo27G3n+ZnDqFL+Td5OIxXgAlzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LwvRUSyRmtdMpgxKjC2zzT4j87pnlHnZUDLRnHhoQFmzaQTQGVaoLLYRlMpmSOeoW
	 Lq1CaJTL5BlcajBhzs1EoOQ1kA3gKJEIYkNxxpcjtjNfVxqvC8XcWNLwpBkOiOlqTj
	 1tL3MbjRArfywTyUPzblPKBdcKNjAnDMb5hJxqDvrv0Hh4BAqoJREtNRJBeEBzebEZ
	 C7HArjKjcp2u8Zftl1zSB7v09Yw6DtKkb5tx7SCnCIdN9CicMqhM1vEL9k2OkTbjJ8
	 M67Nd+YV0vOebXc1XgeyOiY8/WSGuhF8iMIEaFIdHImYmLH76ngZVwFCXV+aZiSSfj
	 y9wJrVkaTC2bw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 15:41:57 +0000
Message-Id: <20260806154158.47BB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `kernel.ftrace_enabled` sysctl now returns `-EOPNOTSUPP` on =
writes of 0, but the livepatch kselftest was not updated to reflect this, c=
ausing the test suite to unconditionally abort.
- [Low] The `FTRACE_DISABLE_CALLS` macro and its handling branch are now de=
ad code due to the removal of `ftrace_shutdown_sysctl()`.
--

--- Patch [1]: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via =
ftrace_enabled sysctl ---
commit 97db09d0e1892d04fd743e6e22b088914ffd3dd6
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Subject: ftrace: deprecate disabling via ftrace_enabled sysctl

Writing 0 to kernel.ftrace_enabled is now deprecated and returns -EOPNOTSUP=
P,
as it has not reliably disabled ftrace for years. The patch updates the
sysctl handler to refuse the write, log a warning, and leaves reads and
enabling unaffected.

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -9357,38 +9357,10 @@ static void ftrace_startup_sysctl(void)
>  	}
>  }
> =20
> -static void ftrace_shutdown_sysctl(void)
> -{
> -	int command;
> -
> -	if (unlikely(ftrace_disabled))
> -		return;
> -
> -	/* ftrace_start_up is true if ftrace is running */
> -	if (ftrace_start_up) {
> -		command =3D FTRACE_DISABLE_CALLS;
> -		if (ftrace_graph_active)
> -			command |=3D FTRACE_STOP_FUNC_RET;
> -		ftrace_run_update_code(command);
> -	}
> -}

[Severity: Low]
Is FTRACE_DISABLE_CALLS now unused dead code?

The removed ftrace_shutdown_sysctl() function appears to be the only caller
that passes FTRACE_DISABLE_CALLS to ftrace_run_update_code().

Without it, the FTRACE_DISABLE_CALLS macro in include/linux/ftrace.h and
its corresponding handling branch in kernel/trace/ftrace.c might never be
executed:

kernel/trace/ftrace.c:ftrace_modify_all_code() {
    ...
    else if (command & FTRACE_DISABLE_CALLS)
        ftrace_replace_code(mod_flags);
    ...
}

Could we also clean up this macro and the dead branch?

[ ... ]

> @@ -9415,15 +9387,12 @@ ftrace_enable_sysctl(const struct ctl_table *tabl=
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
>  	}

[Severity: Medium]
Will this cause the livepatch kselftests to unconditionally fail?

The test script tools/testing/selftests/livepatch/test-ftrace.sh calls
set_ftrace_enabled() to disable ftrace:

tools/testing/selftests/livepatch/test-ftrace.sh:
    set_ftrace_enabled 0

Since writing 0 now returns -EOPNOTSUPP, the helper in functions.sh catches
the failure and aborts the entire test script:

tools/testing/selftests/livepatch/functions.sh:set_ftrace_enabled() {
    ...
    if ! echo "$1" > /proc/sys/kernel/ftrace_enabled; then
        skip "failed to set kernel.ftrace_enabled =3D $1"
    fi
    ...
}

Does the kselftest suite need to be updated alongside this change to avoid
breaking the tests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806153000.4184=
871-1-andrey.grodzovsky@crowdstrike.com?part=3D1
