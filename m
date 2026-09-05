Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E10246781
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788592436; cv=none; b=pyq4NRJoLdoXYsFrprJl19TBAyr7dfML8eK7KqnXNB2MFDjiFCp5afOiqnag40EDncQtYbhX3/JkarpAnFWyWtEq2jxHaF1FE2ep9k3VVGutTSTKNElna0FSv9V7p6vqKJX7s66QMUL0YSjgZ8vFqTs9N2MOBGpTj5RRIbH9JbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788592436; c=relaxed/simple;
	bh=AyB9u721jHvIVuLgXSY0ZxWQ1+CAqmyVKZtXHNcgR34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lrAVLiXsahnkHiaAsq4/16s+QSuh//vUG2hX7iCkveNhIB29SjHLFtOMqtoUZsLDkf4vHTxeWfuvR9cGmAs0yc6uQw+N2x1Sru0nAIJuRTqrj0yVeNS3t2Y4zF7yNMPvkXOefW7yoW5oCbsUUMVDszE0QV9DLKQm3tZ/TKejyG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWUnl1Bg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWUnl1Bg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9089C1F00A3D;
	Sat,  5 Sep 2026 07:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788592434;
	bh=huqV9D9d81Czy1B4trdueAzZlSVUQRYEW/RmSFhqJNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZWUnl1BgwUXtJxkfpsDDtNKn6/1lvgYB9RJkwMNs+CSo4f9yB4w2kbv29l22Qn08v
	 ZuL4funJ4UNdsvuUEEcF8Jr3EIptsYcJ1A/mAv9hcHabQg0mcC7t9Yx/0EFhDOxOP5
	 gY8D3JfidKlTAF3jb5paXEEF2thmaKcjBBPcxaZ7TLHv7hhsqHRhKjpsp4nonxbqfr
	 duszS76/TE3kKZn45iSdBzDiXXD4Dh1T7x2Ny/wi57HYadhabfXmlMzxPsSs8tbXxK
	 er+krCQk9eJfZksUgnyHWqxa85JUwVEetBN703p3EEFaA4UxWC/ku/7ktGxl27PUtt
	 q9bo1SKtaJ8mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 2/8] selftests/bpf: Test killing a loader during
 instruction rewrites
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260905070003.3193366-3-memxor@gmail.com>
References: <20260905070003.3193366-1-memxor@gmail.com>
 <20260905070003.3193366-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 07:13:54 +0000
Message-Id: <20260905071354.9089C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Race condition causing false test failures on extremely fast har=
dware or optimized verifiers.
--

commit e86296a4aae66b4d0778df9e0379e5e9bc8a6bff
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: selftests/bpf: Test killing a loader during instruction rewrites

This commit adds a selftest to verify that a child process stuck in the
verifier's quadratic instruction rewrite phase can be successfully terminat=
ed
by a fatal signal.

> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_load_signal.c b/=
tools/testing/selftests/bpf/prog_tests/prog_load_signal.c
> new file mode 100644
> index 0000000000000..0f78db3bccc76
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/prog_load_signal.c
[ ... ]
> +	if (!pid) {
> +		close(pipefd[0]);
> +		if (write(pipefd[1], "x", 1) !=3D 1)
> +			_exit(1);
> +		close(pipefd[1]);
> +		prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
> +					insns, NOP_CNT + 2, NULL);
> +		if (prog_fd >=3D 0)
> +			close(prog_fd);
> +		_exit(prog_fd < 0);
> +	}

[Severity: Medium]
Could the child process exit too quickly on very fast hardware or with an
optimized verifier? If the child completes the load before the parent sends
SIGKILL, it will exit normally and become a zombie.

[ ... ]
> +	/*
> +	 * Allow linear verification to finish before sending SIGKILL. The nop
> +	 * removal pass is quadratic, so four control-load times still leaves a
> +	 * wide window in which an affected kernel is rewriting instructions.
> +	 */
> +	kill_delay =3D MAX(control_time * 4, MIN_KILL_DELAY_NS);
> +	sleep_ns(kill_delay);

Here, kill_delay enforces a minimum delay of 100ms (MIN_KILL_DELAY_NS). Is =
it
possible that on modern CPUs with high cache bandwidth, the verifier's 32,7=
68
instruction rewrite could finish in under 100ms?

If control_time is very small, the parent will sleep for 100ms, which might
give the child ample time to finish bpf_prog_load() and exit.

[ ... ]
> +	start =3D monotonic_ns();
> +	ret =3D waitpid_timeout(pid, &status, REAP_TIMEOUT_NS);
> +	if (!ASSERT_EQ(ret, pid, "prog_load_killable")) {
> +		fprintf(stderr, "control load %llu us, child still alive %llu us after=
 SIGKILL\n",
> +			control_time / 1000, (monotonic_ns() - start) / 1000);
> +		goto cleanup;
> +	}
> +	pid =3D -1;
> +	ASSERT_TRUE(WIFSIGNALED(status) && WTERMSIG(status) =3D=3D SIGKILL,
> +		    "killed_by_sigkill");

If the child finished early and exited normally as described above, waitpid
will retrieve a normal exit status. This assertion will then incorrectly fa=
il
because the child wasn't killed by the signal.

Could this lead to flaky test failures on fast CI machines?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905070003.3193=
366-1-memxor@gmail.com?part=3D2
