Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578373148C2
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102655; cv=none; b=BUTV2Pyvfz+EfcO3rPMsYWcYrsoMV4hviE90b4LZD/UFm3vy9d+Q0V4wqCKVe7PIvjy5PBkuSGgiv0U50UZPTV7wu3qs5rgnEAZjxIE8PNV+5bKguApNNfrR3jLfx6inhgFZNW5pk4fXVYrf1t3Y+qdtuDtT2XQtv4N3aV7TgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102655; c=relaxed/simple;
	bh=2ZSmL+nmtfO2Q7wFInt/mN1fJAz6Ttl9qttx7gjN97A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JRfPzj0DE9tLAe+g0Co8oneHXhTkOA5XHGFewOvxQi+/6DoN7eW1HxVrDN9mCLH/BXWkdxTo2h9TQ2JbYIlwFGy9asIHiqSx1bp+Kh4AFFWkrx0QAlOiZP0vK2JiFyt4Pj7mqTZAGtgiKP90a6MxBVssl9+QJsUkLXwEXGpbB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omtMHDLs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omtMHDLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3DCC2BCB0;
	Wed,  6 May 2026 21:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778102654;
	bh=2ZSmL+nmtfO2Q7wFInt/mN1fJAz6Ttl9qttx7gjN97A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=omtMHDLsrR9o5ytO7ssp+GRlMbHxpr4QN76CsxCt87W8Na/ZHPOZ6TYe/VN3VZAgo
	 mDPHqNRhGOZlIOyc/STKN1JjiqixmA6i8fA4DvHX7sAGC8KVw7zXl1V/RDTXZy93Gp
	 RcwdAmYeNW7TXUQlGyHE6ax0Woh7HgLSl16C6RGcsfncSqz8NezDTdJpExkO60VVtb
	 /fU3IvGPFrn3xTW5eijtU2Jf0aD1FTEoV3MfPDUNpTcZDShILBeyrkJDYU6LTHSWXw
	 iKDtvFbbx7uHkAFmCVVG63EBw7bzsztuMoJ+QhjZb7EEKxUsf8ql3RWU7kbmEjY3ig
	 IfRf1TB1aDRPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] selftests/bpf: add tests to verify the
 enforcement of CONFIG_CGROUP_LSM_NUM
Reply-To: sashiko@lists.linux.dev
To: "Paul Houssel" <paulhoussel2@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506150547.767315-3-paulhoussel2@gmail.com>
References: <20260506150547.767315-3-paulhoussel2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:24:14 +0000
Message-Id: <20260506212414.CF3DCC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The test leaks `struct bpf_link *` objects, leading to memory and =
file descriptor leaks that permanently exhaust global LSM cgroup slots.
- [Medium] The test assumes any attachment failure is strictly due to the `=
CONFIG_CGROUP_LSM_NUM` limit, which masks genuine bugs.
- [Medium] The test is flaky when run in parallel because it assumes exclus=
ive access to the global `cgroup_lsm_atype` array.
- [Medium] The test hardcodes `CONFIG_CGROUP_LSM_NUM=3D10`, making it britt=
le on non-default kernel configurations.
- [Low] The message provided to the `ASSERT_EQ` macro for the attached coun=
t is misleading.
--

commit c964298fd80079f668d77b4f5c169d14d01bc9e0
Author: Paul Houssel <paulhoussel2@gmail.com>

selftests/bpf: add tests to verify the enforcement of CONFIG_CGROUP_LSM_NUM

This commit adds a selftest to verify that the kernel enforces
CONFIG_CGROUP_LSM_NUM as the maximum number of concurrently attachable
per-cgroup LSM hook slots.

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c b/to=
ols/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
> new file mode 100644
> index 0000000000000..1c5825c6c3d07
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c

[ ... ]

> @@ -0,0 +1,60 @@

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

Should this check if errno is specifically E2BIG?

If the attachment fails for an unrelated reason, such as an invalid hook
configuration (EINVAL) or memory exhaustion (ENOMEM), this will still
increment the failure count and might falsely pass the test.

> +		} else {
> +			attached++;

Does this code leak the struct bpf_link objects?

The link pointer returned by bpf_program__attach_cgroup() is dynamically
allocated, but bpf_link__destroy() is never called to free it during or
after the loop.

Because these leaked file descriptors keep the BPF links active in the
kernel, they will indefinitely occupy the slots in the global
cgroup_lsm_atype array. Could this exhaust the available slots and cause
subsequent tests in the suite that use BPF_LSM_CGROUP hooks to
spuriously fail with -E2BIG?

> +		}
> +	}
> +
> +	// CONFIG_CGROUP_LSM_NUM set to 10
> +	// -> 10 programs shall be attached
> +	ASSERT_EQ(attached, 10, "at least one attached");

Since CONFIG_CGROUP_LSM_NUM limits the number of distinct per-cgroup
LSM hooks globally across the entire system, could this test fail when
run in parallel?

If the test suite is executed concurrently (e.g., test_progs -j) and another
running test utilizes lsm_cgroup hooks, some slots will already be occupied.
This would cause the limit to be exhausted prematurely and fail the asserti=
on.

Will this test fail on custom or distribution kernels where the limit is
configured to a higher value?

While the selftest Kconfig fragment sets the limit to 10, selftests are
often executed against pre-built kernels. If the limit is greater than 12,
all 12 BPF programs will successfully attach, causing the hardcoded
assertion to fail unconditionally.

Could the test dynamically read the limit via
extern int CONFIG_CGROUP_LSM_NUM __kconfig instead?

This isn't a bug, but the assertion message says "at least one attached"
when it actually verifies that exactly 10 are attached.

> +	// -> 2 programs shall be rejected
> +	ASSERT_EQ(failed, 2, "limit was enforced");
> +
> +out:
> +	close(cgroup_fd);
> +	cgroup_lsm_num__destroy(skel);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506150547.7673=
15-1-paulhoussel2@gmail.com?part=3D2
