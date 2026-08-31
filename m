Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936CC37D13D
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206008; cv=none; b=K1oKZiB0PvGGsRTteVHmXiua3LW0t4yfO3qhd1hit+Om3hPIptuuvHslsymmzuTNnEBEZw2QYbxFg4ntuVwoQpGpx9o4pkR/2ic+eJJKiVyrYdWyKZdCidJbaDEA7Op8hGp1FAyLtuGLuDQTxOCn+KJ5Vg/Asy7LuZ7PxENk+uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206008; c=relaxed/simple;
	bh=8aW4LjgVWYAKY2HVJCEQeXMMSONhmzjtFZQYc+i9Zhw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GaErDJu1OFd+rcYztR1sf+24XDiLlTfl1uE6nyU+FfVFm99tP+iNzYOCqTkokwdP6r3FvjsEkZIul5iCPENlQ531yJFXhoqHB15jZ6SgnO8oDSNsck4KHPxvUMV7snuIooXZfIRBaQjP96cmpI9v/XJnu4kC0C5c44Uktb1Injw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Icnf87zo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Icnf87zo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1282C1F000E9;
	Mon, 31 Aug 2026 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788206007;
	bh=uPfwtglM7vERSO3TGtKLYUajZFmvA9NFzyExCyrZViM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Icnf87zokpSSqkZ6Ep0p5uZ18t0rB4f96KFAXZI/MaqYOgFBAz0JZtUGmH8HxtW1f
	 7fgNsvGpf7V0uo5VMwfsa4s8Wv2G98Ucswn4LCzmSI3xQ8wVk9IVbBVQZ/knqGVAzD
	 3VMurKtT2ttNrCZy6fCIFVOjX71t/d2xFxGzRpZxjGZY+KusxqpaX8ZL/ofGRyuyUZ
	 +sixSF91KHMgP62kD/WWLy3RYtOLBH1lC258VqNOH+csC6AcGcTNAzfVmTYPLlAMrz
	 8iMqus6em3R8FRPOmdmHs8t/tspYv6FKQ9I5q9gHkdMBv8NdsIt+zNcLgYoGYxHfGI
	 GDHml46aC2ptA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/15] selftests/bpf: Test the LSM policy object
 kfuncs with Landlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831145858.3869191-15-utilityemal77@gmail.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
 <20260831145858.3869191-15-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:53:26 +0000
Message-Id: <20260831195327.1282C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] File descriptors leak on the error path in test_restrict_binprm_dis=
card().
--

commit 7fa3010dd885254cc82b6aa2f6f254ee83a13717
Author: Justin Suess <utilityemal77@gmail.com>

selftests/bpf: Test the LSM policy object kfuncs with Landlock

This commit adds tests for LSM policy object kfuncs interacting with Landlo=
ck.
It tests execution confinement, audit log flags, and concurrent application
using a syscall program and BPF RCU lock management.

> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c=
 b/tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c
> new file mode 100644
> index 0000000000000..9270b39f5e3a7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c
[ ... ]
> +static void test_restrict_binprm_discard(void)
> +{
> +	struct policy_test_env env;
> +	char garbage_path[] =3D "/tmp/lsm_policy_garbage_XXXXXX";
> +	int garbage_fd, pipe_fds[2];
> +	char buf =3D 0;
> +	pid_t pid;
> +
> +	if (setup_env(&env))
> +		goto out;
[ ... ]
> +	if (!ASSERT_OK(pipe(pipe_fds), "pipe"))
> +		goto out_unlink;
> +
> +	/*
> +	 * Cannot use spawn_exec_child(): the same process must test its
> +	 * write access after the failed exec.
> +	 */
> +	pid =3D fork();
> +	if (!ASSERT_GE(pid, 0, "fork"))
> +		goto out_unlink;

[Severity: Low]
Does this code leak the file descriptors created by pipe() if fork() fails?=
=20

If fork() fails here, the code jumps directly to the out_unlink label, and =
it=20
appears neither pipe_fds[0] nor pipe_fds[1] are closed before exiting the
function.=20

The spawn_exec_child() helper function introduced in this same commit prope=
rly=20
closes both descriptors on fork failure. Should similar cleanup be added he=
re?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145858.3869=
191-1-utilityemal77@gmail.com?part=3D14
