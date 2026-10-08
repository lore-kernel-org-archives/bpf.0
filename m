Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21C1F30BB
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468714; cv=none; b=Es0FneQ/a99oDDaIZvZkAAiT1rBPwvcCLZdLFHSHd/qMr275rSYQ2FRNop30F0rrkA61N6fkxdfKnCT8PkOzenuSL1rJFbil39rfQtOwiLn3/3YCfpxCcnXY5oPino9KcF/aYdWmxXHT8UVAZe7rVNGz0SrtKT9w6asTzRKXuZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468714; c=relaxed/simple;
	bh=IwGtPuf8bkIZb9oPUe1qnD0efR+WqMkSe6HhHGWImeg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=I4a+1/QR8Vki712y7x0PmIxy24/T4Ze8rnp+eDtXleJPkJMWTasDFrDxJdVbzZc+hoZCbHU81AZiPalCMig+IO1OnX58HgZhRLZQmG5qdBTIq03eH7tWWcpkA+JpTGLQd1TAWREaBx07S6RRIJQwABjhGba29LYr2k7oKh+E9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4Haku/0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4Haku/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082531F000FF;
	Thu,  8 Oct 2026 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791468713;
	bh=OsApkzLRn6G0X5eHWSg6AmUzvIfCyFFKtLIeieVn444=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O4Haku/0erk5VO5dsIB+ooS+VyT1u6AFb8Cy6YtImVjXdmD+wcGpYE0A6x1IOHmD6
	 AFMujDBTCT9JTzwUCvQag3c4nZBo/cFP9yvQqTqZ+u2TiyknH1fDu4hgv8rqBdCdWH
	 ni1gdJq6HPgA6Y4bV6s0SdsCXIb0caA2s8sKwBlV8BEcPrUeuFP6IOtPjXWzl7sZq5
	 vFxoZhg1wx0AmM8Nwegx3+JV9R9kYOzpMKJnjRlTD/AEZRxMtqf/KQnc8aPcxDRYLT
	 SFoqC5iaVt/t4t8PGo0AZ6ZcIFoukjKTkCJ00qPnBCegxQbvSscqo+H5mow4eXR/Cf
	 MLTHQop/f15nw==
Message-ID: <sashiko-outbox-164266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Run the enable_stats program
 with BPF_PROG_TEST_RUN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008-selftests-bpf-enable-stats-inflight-v1-1-0cb92ee2c6d3@gmail.com>
References: <20261008-selftests-bpf-enable-stats-inflight-v1-1-0cb92ee2c6d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:11:52 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: test flakiness due to single execution resulting in 0 run_t=
ime_ns
- [Low] selftests: use of deprecated CHECK() macro instead of ASSERT_OK()
--

commit 19aafe6fa22911d0395cafeff0b58fb78265e72f
Author: Qiliang Yuan <odys.yuan@gmail.com>

selftests/bpf: Run the enable_stats program with BPF_PROG_TEST_RUN

This commit changes the enable_stats test to execute the BPF program
directly via BPF_PROG_TEST_RUN rather than attaching it to sys_enter.
This prevents parallel syscalls from other tests from skewing the run count=
s.

> diff --git a/tools/testing/selftests/bpf/prog_tests/enable_stats.c b/tool=
s/testing/selftests/bpf/prog_tests/enable_stats.c
> --- a/tools/testing/selftests/bpf/prog_tests/enable_stats.c
> +++ b/tools/testing/selftests/bpf/prog_tests/enable_stats.c
[ ... ]
> @@ -20,13 +21,11 @@ void test_enable_stats(void)
>  		return;
>  	}
> =20
> -	err =3D test_enable_stats__attach(skel);
> -	if (CHECK(err, "attach_raw_tp", "err %d\n", err))
> +	prog_fd =3D bpf_program__fd(skel->progs.test_enable_stats);
> +	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +	if (CHECK(err, "test_run", "err %d\n", err))

[Severity: Low]
This isn't a bug, but the BPF selftest guidelines mandate using the modern
ASSERT_* macros for new code or patches. Should this new error check use
ASSERT_OK() instead of the deprecated CHECK() macro?

>  		goto cleanup;
> =20
> -	test_enable_stats__detach(skel);
> -
> -	prog_fd =3D bpf_program__fd(skel->progs.test_enable_stats);
>  	memset(&info, 0, info_len);
>  	err =3D bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
>  	if (CHECK(err, "get_prog_info",
> @@ -34,6 +33,6 @@ void test_enable_stats(void)
>  		goto cleanup;
>  	if (CHECK(info.run_time_ns =3D=3D 0, "check_stats_enabled",
>  		  "failed to enable run_time_ns stats\n"))

[Severity: Medium]
Will this test become flaky because the single execution finishes too
quickly?

The program is a raw_tp which executes exactly once (the repeat option is
rejected for raw_tp programs during test runs). Since the program only
performs a single atomic operation, the execution time might be faster than
the system sched_clock() resolution, resulting in a duration of zero and
failing this assertion.

Could the test manually loop the execution from userspace to accumulate
measurable time before checking the run_time_ns?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-selftests-=
bpf-enable-stats-inflight-v1-1-0cb92ee2c6d3@gmail.com?part=3D1
