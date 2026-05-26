Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144D3E0C59
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813891; cv=none; b=iVVYNGKmTZHA5yLxMpzAWdOWEoRp75JKjTVIbYqWcNdBo4ODKhiggiJajKnKlhIp3N27aHiq4atF+CI/mTtd6ABEsQ+XEeVC/vG+5THGPbNymuiEc3f5/75sNSDrr9pt2jDeOKWfgE2qcdCwYoyfF+WTPjbQj6h7HMMB2MyY0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813891; c=relaxed/simple;
	bh=O64DPGPz5nh/Y6ItVdywSqDvSJoAY9nQkdsiGzyOjfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KrPttVS9x1+fvC6Les9DRoJEKIN3QyQ8h6VkIJSLp6AVjlyUXRB1t69dH0yFThpo6FPQu31C91UwFt/cqcnB/pX9d3YP+hbLpa44UlR1F3Ja+bmT5MxmatTQ5dgUMotnGuSjXmVo4P2WnPJ0Jz9LYQAwyXFFLno/nSHM1H89d1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ/JvXw5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ/JvXw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853601F000E9;
	Tue, 26 May 2026 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779813888;
	bh=Gzcjrj6f8gaiFxH5qNEg6KadXFHbfAVI1uibPdOVae0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZ/JvXw5Do7LnoBkIlz/Owf1Whm7hR7xMyMSFEDj6O6BiWoolGWfKxKacTJbYrxzd
	 m5fCgQaml/zPAgLd2pEtfPoMzhZ176ype+4tl1HBDKF+4ilKx4wtA5cQBjGGnlaxvY
	 rswSKOh9mpgLaY6cyAP0r7Eyb1Vu4/XyUx2VGC7trGYZqf3SHnmHtVUeeCzuhwHAxS
	 ouzLbDR6NJD/fwRKimuOmHnO2sjnDWehbo191VQ4mJl5bsaRBYGqThduWHy1vHZwnq
	 pA3xJyGqVT2QHbUkEedQ+s2hu5qWzhVYOAQzQxrFRwQnLZdRhtySbNW9IcEZhTedeZ
	 QaHTIk8tBf8Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 2/2] selftest: seccomp: Adjust test for using
 both `STRICT` and `FILTER`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamie Hill-Daniel" <clubby789@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526-seccomp-combined-v1-2-304b1cc3ad24@hill-daniel.co.uk>
References: <20260526-seccomp-combined-v1-2-304b1cc3ad24@hill-daniel.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 16:44:48 +0000
Message-Id: <20260526164448.853601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The updated selftests crash with SIGKILL due to unhandled strict=
 seccomp constraints.

Pre-existing issues:
- [Critical] The internal kernel mode `SECCOMP_MODE_COMBINED` is leaked to =
userspace via `prctl` and `/proc/pid/status`, causing ABI breakage.
--

commit fb241f2f33856c48dd4d8cab04014fc026770de7
Author: Jamie Hill-Daniel <clubby789@gmail.com>

selftest: seccomp: Adjust test for using both STRICT and FILTER

This patch updates the seccomp selftests to expect a successful transition
to STRICT mode after FILTER mode is already applied, renaming the test
to mode_filter_combined.

> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
[ ... ]
> -TEST(mode_filter_cannot_move_to_strict)
> +TEST(mode_filter_combined)
>  {
>  	struct sock_filter filter[] =3D {
>  		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> @@ -534,8 +534,7 @@ TEST(mode_filter_cannot_move_to_strict)
>  	ASSERT_EQ(0, ret);
> =20
>  	ret =3D prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, NULL, 0, 0);
> -	EXPECT_EQ(-1, ret);
> -	EXPECT_EQ(EINVAL, errno);
> +	ASSERT_EQ(0, ret);

[Severity: Medium]
When this test finishes, the kselftest framework attempts to exit the proce=
ss
by calling glibc's _exit(), which invokes the exit_group syscall.

Since strict seccomp mode only permits read, write, _exit (__NR_exit),
and sigreturn, won't the forbidden exit_group syscall cause the test process
to be immediately killed with SIGKILL?

It appears the test must manually exit via syscall(__NR_exit, 0) to avoid
falsely reporting a failure, similar to how TEST(mode_strict_support)
handles it.

Additionally, does this patch also need to update
TEST(seccomp_syscall_mode_lock)?

With the new kernel behavior, that test's transition to strict mode will now
succeed, causing it to execute the seccomp() syscall while in strict mode,
which will result in another immediate SIGKILL.

[Severity: Critical]
This is a pre-existing issue, but the underlying kernel patch appears to le=
ak
the internal SECCOMP_MODE_COMBINED (4) state to userspace.

When a process successfully transitions to strict mode after a filter is
installed, its internal state becomes 4.

If this value is directly exposed to userspace via prctl(PR_GET_SECCOMP)
and the /proc/pid/status file's Seccomp: field, could this break ABI
contracts?

The UAPI headers only define SECCOMP_MODE_DISABLED (0),=20
SECCOMP_MODE_STRICT (1), and SECCOMP_MODE_FILTER (2).=20

Exposing an undocumented internal mode to userspace might cause sandbox
monitoring tools, init systems, or security daemons that expect standard
UAPI values to malfunction or crash.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-seccomp-co=
mbined-v1-0-304b1cc3ad24@hill-daniel.co.uk?part=3D2
