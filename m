Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767EB23A564
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541144; cv=none; b=UuLFtXNnZSrNBA8h+6M4jUXi3uftbS1lOeDOGlShzowBc6ja4tf/4Ab5ztB5tftHK0BsJcoVFoaQNTM9uQf9BVxuBVteSOeejGmaPiz5LAeb9Gf/vgiWFywWp1U6YyxmPQ3EHpEMW9QN6kmTA4HezZFxQwjGDXvv5H6iy1Lr4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541144; c=relaxed/simple;
	bh=o4HKTRsp5OG7U8anBw4EC3vb4PeBM3KymKAdDBhExB0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iwdJLCGLZOzMuxR2gzw1ggtJOxIH4LkXsOiA1cB0P/EHcFePWT6568W5KCe3Uwk0pCwdMdc9XdzHmHOZTOkSUsqB/7ugUneDNMfXBmOUq2D+72VBuh0azgi9+wawRqMmF6tOl2GJVlHzOyQsgb0cN2r/plS5q8KVFiZdH2VkQ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+a1deyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+a1deyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112F61F00A3D;
	Mon, 15 Jun 2026 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781541143;
	bh=a7SMWWoNNEL1HtX6U7iTuFgbgR1b8QBKXnOUcqwNqLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+a1deyt3Sczqey2ai/VBAz7mLRAMaaVczIgiEwGccpDzil6sJjjLN+kx+AlNfxZf
	 nWD4Becmr5ssU2SR26u6XpPf6HtOzUzrNrch/Ehv9Zxs1MtfutydywmzRR77PeYHTe
	 U4ccrdp02m+1UDVtbQpqtijDAl4FF2aep1efiztSplvx5aXH8ORngwJpZLPYm01eV7
	 6S7Dc1N9sa1e6L+0YYGSeke3pG6A/UJAKHEY8tlv8jy2hxNDUp6bbWf19CJ7qqRlOl
	 65TcxD9TIERqCVWRKq6U/zkIcvmS3a20P3qtEUAz8T2XaMNggE8j4IVyfJgmu3m3RV
	 W+e1qc0ayLgmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] selftest: seccomp: Adjust tests for using both
 STRICT and FILTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamie Hill-Daniel" <clubby789@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615-seccomp-combined-v2-3-41687a943ae0@hill-daniel.co.uk>
References: <20260615-seccomp-combined-v2-3-41687a943ae0@hill-daniel.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 16:32:22 +0000
Message-Id: <20260615163223.112F61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `mode_strict_upgrade_violation` test has a logic flaw that c=
auses it to incorrectly pass even if the kernel mistakenly allows the forbi=
dden syscall.
- [Medium] The patch drops test coverage for upgrading to strict mode via t=
he `seccomp()` syscall.
--

commit 8c0b993065641d6398baa9878008c2ec51b13bef
Author: Jamie Hill-Daniel <clubby789@gmail.com>

selftest: seccomp: Adjust tests for using both STRICT and FILTER

Update tests to reflect that applying STRICT after FILTER is now possible.

> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testin=
g/selftests/seccomp/seccomp_bpf.c
> index 358b6c65e120e..17232591be590 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c

[ ... ]

> @@ -540,8 +540,34 @@ TEST(mode_filter_cannot_move_to_strict)
>  	ASSERT_EQ(0, ret);
> =20
>  	ret =3D prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, NULL, 0, 0);
> -	EXPECT_EQ(-1, ret);
> -	EXPECT_EQ(EINVAL, errno);
> +	ASSERT_EQ(0, ret);
> +	syscall(__NR_exit, 0);
> +}
> +
> +TEST_SIGNAL(mode_strict_upgrade_violation, SIGKILL)
> +{
> +	struct sock_filter filter[] =3D {
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> +	};
> +	struct sock_fprog prog =3D {
> +		.len =3D (unsigned short)ARRAY_SIZE(filter),
> +		.filter =3D filter,
> +	};
> +	long ret;
> +
> +	ret =3D prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +	ASSERT_EQ(0, ret);
> +
> +	ret =3D prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
> +	ASSERT_EQ(0, ret);
> +
> +	ret =3D prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, NULL, 0, 0);
> +	ASSERT_EQ(0, ret);
> +
> +	syscall(__NR_getpid);
> +	EXPECT_FALSE(true) {
> +		TH_LOG("Unreachable!");
> +	}
>  }

[Severity: Medium]
If the kernel mistakenly allows __NR_getpid, will the implicit return from =
this
test function mask the failure?

Returning from a kselftest function invokes the harness wrapper which calls
the standard library's _exit(), invoking the __NR_exit_group syscall. Becau=
se
__NR_exit_group is also forbidden in strict seccomp mode (only __NR_exit is
allowed), the kernel kills the test process with SIGKILL.

Since the parent harness expects a SIGKILL (due to the TEST_SIGNAL macro), =
it
matches the expected signal and overrides the test state to PASSED, hiding =
the
EXPECT_FALSE failure.

Should we explicitly call syscall(__NR_exit, 1); after the assertion fails =
to
ensure the test exits normally and the harness correctly fails it?

[ ... ]

> @@ -2376,42 +2402,6 @@ TEST(seccomp_syscall)
>  	}
>  }
> =20
> -TEST(seccomp_syscall_mode_lock)
> -{
> -	struct sock_filter filter[] =3D {
> -		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> -	};
> -	struct sock_fprog prog =3D {
> -		.len =3D (unsigned short)ARRAY_SIZE(filter),
> -		.filter =3D filter,
> -	};
> -	long ret;
> -
> -	ret =3D prctl(PR_SET_NO_NEW_PRIVS, 1, NULL, 0, 0);
> -	ASSERT_EQ(0, ret) {
> -		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> -	}
> -
> -	ret =3D seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog);
> -	ASSERT_NE(ENOSYS, errno) {
> -		TH_LOG("Kernel does not support seccomp syscall!");
> -	}
> -	EXPECT_EQ(0, ret) {
> -		TH_LOG("Could not install filter!");
> -	}
> -
> -	/* Make sure neither entry point will switch to strict. */
> -	ret =3D prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, 0, 0, 0);
> -	EXPECT_EQ(EINVAL, errno) {
> -		TH_LOG("Switched to mode strict!");
> -	}
> -
> -	ret =3D seccomp(SECCOMP_SET_MODE_STRICT, 0, NULL);
> -	EXPECT_EQ(EINVAL, errno) {
> -		TH_LOG("Switched to mode strict!");
> -	}
> -}

[Severity: Medium]
Does dropping this test also drop test coverage for upgrading to strict mode
via the seccomp() syscall?

The new replacement tests (mode_strict_upgrade and
mode_strict_upgrade_violation) only validate the prctl() interface, leaving=
 the
seccomp() syscall path untested for the newly allowed transition from
SECCOMP_MODE_FILTER to SECCOMP_MODE_STRICT.

Could we add tests to ensure the seccomp() syscall correctly enforces this =
ABI?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-seccomp-co=
mbined-v2-0-41687a943ae0@hill-daniel.co.uk?part=3D3
