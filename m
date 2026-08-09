Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0E34F46F
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786288864; cv=none; b=Rbhoo344+weFwdKUew3MkFWgeJ6sG/LF8HSDJRyUDByL+yPOjegQoGj9E+wCfHeFmQRUJvliwiEBtrmj9TpymGUciJQzRjSvVLIc44OqhtEf7sGzCiWafd8YAE7elFgCI0ykLJHGX1q1UIQsKIkSGgiiirC6mO5fL7QkGURGdUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786288864; c=relaxed/simple;
	bh=nnyxONYwvU99lVd5iv1jHPUgOa+DrF+qfhhEaYdcddI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b54/qu+boNVrO14CkJYWTk5SklCq9HMQHPh2N3J4h0kpglE5mUa5RWdHquOl9o7/1pxNmJXDsC5GrAp8bZahxLdLDE7xhjpi3eSLGd1Cnjr1WYmpBFRPgUb7eKTu6yavvInkTDY/o6jvPoIy3eDr7ZjzmEwlHmlWhUMninlXhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhJLnGRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhJLnGRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB1D1F000E9;
	Sun,  9 Aug 2026 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786288862;
	bh=sI4LomijXUQgSFoCSgjpKbU6MI1LrLrG3NKqWI2PHCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JhJLnGRlq87JDrH1cq2smZd5VTxs7xsFbSK2q/oFtAFmz4h4t6Qdo9CwRT+ZhalkS
	 +Z0Ea6XjHJdW5VWE6zTT+1rDYyj4+reqvflw5SmPwdnLa+wTgqZVgDbxknLq/YhkF2
	 MLr8QFD0+Mt8jrk6Ext/KNwa9drymyBLm0LQ+BPda0hpM5JVP08cdFTtSmU1YMEkIo
	 iq/fDj2CNYKFORZBFNkJKv+5TA070392wrrMQs+GdxCLma1/JTz5DCquU5rQnXqIsr
	 7SCUOK0derZO6rMG/Z9SL8uXxNX7a3bCc5ZsnKwMkdjZZ8K5s3WzQKDXHAZ3WmqE8D
	 dQR9epJvDmC6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 11/13] selftests/bpf: Add tracing_multi bpf
 prog rollback test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260809150111.45000-12-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-12-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 15:21:01 +0000
Message-Id: <20260809152102.5AB1D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `test_rollback_bpf_prog` test hardcodes executing `target_1`=
 to verify rollback behavior, leading to spurious test failures if `target_=
2` happens to have a lower file descriptor.
--

--- Patch [11]: [PATCH bpf-next 11/13] selftests/bpf: Add tracing_multi bpf=
 prog rollback test ---
commit b065372f3722241a5632ef72df356c018b778825
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tracing_multi bpf prog rollback test

This commit adds a test to verify that prepared trampolines are correctly
reverted when a BPF program multi-attach fails and triggers a rollback.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/too=
ls/testing/selftests/bpf/prog_tests/tracing_multi.c
> index 070266a864d4f..a4d9934ad1dc3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
[ ... ]
> @@ -377,6 +377,65 @@ static void test_cookies_bpf_prog(void)
[ ... ]
> +static void test_rollback_bpf_prog(void)
> +{
> +	int token_fd, prog_fd, fd =3D -1, pre_fd =3D -1;
[ ... ]
> +	first =3D target_fds[0] < target_fds[1] ? 0 : 1;
[ ... ]
> +	fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_FENTRY_MULTI, &lopts);
> +	if (!ASSERT_EQ(fd, -EBUSY, "bpf_link_create"))
> +		goto cleanup;
> +
> +	if (run_bpf_target(skel->progs.target_1, first + 1, "rollback_target"))

[Severity: Medium]
Does this test accidentally hardcode the execution of target_1 while expect=
ing
a dynamic return value based on file descriptor ordering?

If the file descriptors are assigned such that target_fds[1] < target_fds[0=
],
the variable first becomes 1. The test then executes target_1 but expects a
return value of first + 1 (which is 2).

Since target_1 always returns 1, will this cause a spurious test failure?

Additionally, if first =3D=3D 1, target_1 would still have a trampoline att=
ached
via pre_fd. This would cause test_result_fentry to increment and fail the
subsequent ASSERT_EQ() check.

> +		goto cleanup;
> +	ASSERT_EQ(skel->bss->test_result_fentry, 0, "test_result_fentry");
> +
> +cleanup:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809150111.4500=
0-1-leon.hwang@linux.dev?part=3D11
