Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3871B4223
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120275; cv=none; b=ZStgoAc1DS5vw1JCbpsXH53lnkafHxBzVS1WI2XwEecIwzcOrY+3ZuBsJ0YRWfzfAptWk55gnsFDvjEXgPiZQSjIPlA4yUwby4RyyQiItg8jS8CyLU5hOfzuMLLj8x/Rt2yom9QKJJTKW7MeSf6COGdNxuxnPbcHoCoha//1HOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120275; c=relaxed/simple;
	bh=p+O1pu1C97yJyetEBF+WB2x43+JvXFbwigY27k0uZJM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QHthtHC2uaY31eJOxzW42LM+hbZrCaGbswnfj9VkXw183ZukU8/7ZRkHHwpqHxylrSdMTvp+6tUzFrLu2pm2LoS+R5zaFf69OKmwT0tNKuYWhjQCoZ5xA7qRKPxucCnpXWLedBykBZERkJuRh/OJQhTP6HCbgUFK8uRrCsuMpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHD3WRC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHD3WRC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D421F000C4;
	Fri, 16 Oct 2026 03:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792120274;
	bh=37U0QQMCWzEakknJ0i3pQZGn3NkpD+d7GQL1hxj6ZKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bHD3WRC01gVcoYFlktQDXsbOiGRTUqJLtNsrrj9fko8dNADgRPyQyouNe1JasEtw+
	 hxvTjfjtZn2DfOFinIK0O7+Oc6ZWDLBzp0BAhsI+dk0MUncy0I6CBRvXJVh2Sx9LVJ
	 XuDUqr2hWGlwm8+C655zIP/lvTq0z9UMdGh7N0KmZwOtr+orKGpChS6KjvkHaVrRVu
	 G315bY3db1IEGldox+fojbzQbEGfTdGhB5wjVnco7AbjAKHqMby+B4bCAJYnVmPWim
	 cVAUkh4HpfriqtzPVb1sSQ+yrGlyLTWsTKn8QGJe08IBKHq44/n95MBbCtlJ0mwSZX
	 k0FIaV6sOF39w==
Message-ID: <sashiko-outbox-173655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/4] selftests/bpf: Test freeing a
 struct_ops map under a running prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-3-9ad31c21220c@gmail.com>
References: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-0-9ad31c21220c@gmail.com>
 <20261016-selftests-bpf-struct-ops-assoc-timer-v4-3-9ad31c21220c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 03:11:13 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: Missing error path abort leads to test timeout or ca=
scading failures
--

commit 920a79a19e26a9e6930a47b303037de287f29b6a
Author: Qiliang Yuan <odys.yuan@gmail.com>

selftests/bpf: Test freeing a struct_ops map under a running prog
   =20
This commit adds a new test to verify that a struct_ops map is not freed
under a running program. It refactors existing timer tests to use a shared
helper function.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc=
.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> index 461ded7223515..9d56e8cb5675a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> @@ -157,12 +158,18 @@ static void test_st_ops_assoc_in_timer_no_uref(void)
>  	/*
>  	 * Run .test_1 by calling kfunc bpf_kfunc_multi_st_ops_test_1_prog_arg(=
) and checks
>  	 * the return value. .test_1 will also schedule timer_cb that runs .tes=
t_1 again.
[ ... ]
>  	err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog=
), NULL);
> -	ASSERT_OK(err, "bpf_prog_test_run_opts");
> +	if (!ASSERT_OK(err, "bpf_prog_test_run_opts")) {
> +		bpf_link__destroy(link);
> +		goto out;
> +	}

[Severity: Low]
Adding an abort on failure here is a nice improvement, as it prevents an
infinite loop waiting for the timer callback.

However, there are a couple of other places missing an error abort. In this
same function (run_st_ops_assoc_in_timer_no_uref), if
bpf_program__assoc_struct_ops() fails:

    err =3D bpf_program__assoc_struct_ops(skel->progs.syscall_prog,
                                        skel->maps.st_ops_map, NULL);
    ASSERT_OK(err, "bpf_program__assoc_struct_ops");
   =20
    link =3D bpf_map__attach_struct_ops(skel->maps.st_ops_map);

Will this cascade into failures on the subsequent attach? Should we add an
abort there as well?

Additionally, in the unmodified test_st_ops_assoc_in_timer() function in
this same file, bpf_prog_test_run_opts() is still checked with just
ASSERT_OK() and does not abort. If it fails, won't the test hang
indefinitely in its sched_yield() loop waiting for the timer callback
since the callback never runs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-selftests-=
bpf-struct-ops-assoc-timer-v4-0-9ad31c21220c@gmail.com?part=3D3
