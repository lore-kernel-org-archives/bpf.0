Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F973DC4CB
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092894; cv=none; b=BMnVHJbkvxtLQS2sLnk45AAxpvh3JTcIMb8o48/PRmLZTz9TC9v4rviWkdT8h6tA4j39czxdAaxXUG0o8cqxB3IhFYiZ2T9VaJ1xeVcILgX2+6c/ulG0pAwnxXRwv9JokR7BE1b5IbbQ579yQLNIUCBfMAs6tOfMTDHE1k4HIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092894; c=relaxed/simple;
	bh=OCcmTwb4NfMXI9JDyuCQLZzpgPVQ+drj+1unsdRT1sY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jT7tN+ibkKBnnBx38M7R0s9Ld+4Ij5O64kcu98Y949cErnIj3LazQxbWK/oGllv0gCPMquLaoj+mxJe1gPR6/fIaM76i9SOTYGRS0E2W3yy1sRLZ+0kqIWqBgLi3ZetKMN/eEfwBr7wfUVxECFI/BuHUfdP/Gw8MtPtHZe4Ji9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFp2cTYS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFp2cTYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D37C2BCB8;
	Wed,  6 May 2026 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778092893;
	bh=OCcmTwb4NfMXI9JDyuCQLZzpgPVQ+drj+1unsdRT1sY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bFp2cTYScdYl0A9a+3DObjGQcqwt5h87sJI1CksARfk0xkNG7B9JZOXA4d6+yZ2Yb
	 YG/mqa3QNlHlm0XNwzVnUGCedyfBjnItDE2MVocV4HvzYk3HkOEk4nVqLIt4JEIurb
	 jxhzZjQM2t9b7+DabuiDBV/aNRLtgxHmWwfT4oxTICEfhOy9pA3+fy5D4KGwYxg0Rj
	 V6OYBDmJ0z2OxgCHZoWViAqnqup7SQl4er9uNQ+MoSRVL5usd0vK3DiYu0g5j5U4GP
	 diKIncXGIn1/t566hMbim2ubMmksLrp+moURorr2ls8oKq4fTCUas6ui1UYLnmIhnw
	 tUd5nZew5ll+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/bpf: add tests to verify the enforcement
 of CONFIG_CGROUP_LSM_NUM
Reply-To: sashiko@lists.linux.dev
To: "Paul Houssel" <paulhoussel2@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506065048.592474-3-paulhoussel2@gmail.com>
References: <20260506065048.592474-3-paulhoussel2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 18:41:32 +0000
Message-Id: <20260506184133.70D37C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Resource leak (Memory & File Descriptors) in test loop.
- [Medium] Missing verification of the actual rejection error code.
- [Medium] Test flakiness due to concurrent execution consuming global limi=
ts.
--

commit 643ce21be8f485f762f000339f8443301983ef08
Author: Paul Houssel <paulhoussel2@gmail.com>

selftests/bpf: add tests to verify the enforcement of CONFIG_CGROUP_LSM_NUM
   =20
Add a selftest that verifies the kernel correctly enforces
CONFIG_CGROUP_LSM_NUM as the maximum number of concurrently attachable
per-cgroup LSM hook slots.

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c b/to=
ols/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
> new file mode 100644
> index 0000000000000..1c5825c6c3d07
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
[ ... ]
> +void test_cgroup_lsm_num(void)

Should this test be forced to run sequentially by naming it
serial_test_cgroup_lsm_num()?

Since the kernel limits the maximum number of distinct, concurrently
attachable per-cgroup LSM hooks globally based on CONFIG_CGROUP_LSM_NUM,
if this test runs in parallel with other tests that attach to lsm_cgroup
hooks, could they exhaust the global limit and cause this test to fail
unpredictably?

> +{
> +	struct cgroup_lsm_num *skel =3D NULL;
> +	struct bpf_program *prog;
> +	int cgroup_fd =3D -1;
> +	int attached =3D 0;
> +	int failed =3D 0;
[ ... ]
> +	bpf_object__for_each_program(prog, skel->obj) {
> +		struct bpf_link *link;
> +
> +		link =3D bpf_program__attach_cgroup(prog, cgroup_fd);
> +		if (!link) {
> +			if (errno =3D=3D EOPNOTSUPP) {
> +				test__skip();
> +				goto out;
> +			}
> +			failed++;

When we expect attachment to fail because the slot limit is exhausted,
shouldn't we also check that the error code is exactly what we expect
(such as -E2BIG)?

If the attachment fails for an unrelated reason, the failure counter still
increments, which could obscure the true root cause.

> +		} else {
> +			attached++;
> +		}

Does this code leak the link memory and its file descriptor?

Since the attachment is done manually via bpf_program__attach_cgroup()
instead of using the skeleton's auto-attach method,
cgroup_lsm_num__destroy(skel) will not automatically clean up these links.

Should we store the returned link pointer and explicitly call
bpf_link__destroy() on it to prevent exhausting the file descriptor limit
during a test run?

> +	}
> +
> +	// CONFIG_CGROUP_LSM_NUM set to 10
> +	// -> 10 programs shall be attached
> +	ASSERT_EQ(attached, 10, "at least one attached");
> +	// -> 2 programs shall be rejected
> +	ASSERT_EQ(failed, 2, "limit was enforced");
> +
> +out:
> +	close(cgroup_fd);
> +	cgroup_lsm_num__destroy(skel);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506065048.5924=
74-1-paulhoussel2@gmail.com?part=3D2
