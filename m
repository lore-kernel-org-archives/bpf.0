Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447D3B47D9
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087194; cv=none; b=Oihk4FDpWJjtqCJ6+uept8eHWXL9PyLsTP67DTIitXZ1bOrAuHJABdaViTN+hJV5EXxRyjgknDG7AK8WYEohw8Vzw5MvxAk3yxbDJb7Yl+tZos+puUq1BjTpGAAziEWCQg3iJIR7JMPhW9hBOP/J8sfnUQ47SG08bAZ5vcKADV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087194; c=relaxed/simple;
	bh=oFVjrQR90MYdWE9Vjlxagwau8seNNwpG5fs4HKwaAus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fAQo5/DpACPwx7C9NgikYvdfYNJM/bKV/xYCNJJ35pvFL1QUjrSfHMankDZw1GZ61EH4aFq33if0+Ca9KtS3DI0fJ8iMiyp05/5LpmeZOAxMFGzdfoRkdyH4vOtRTgpaYxKUaXqG2l0uuLrmc3+wt71YZQI88F3o7dKHv+1r7D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3MOVzZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3MOVzZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE2E1F000E9;
	Fri,  7 Aug 2026 07:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786087192;
	bh=rHs7hZ5BW3sxVfe1PDKjzoxwybTSbppP+A9xaJ/EdZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O3MOVzZ1BzlRN7JFYmhTqm1/WVqm1Gv5p5yC3HjUbdn9bgCmo1EU2Uvx8nNEZWSxU
	 7WwK1NkFXT5Jyeqm2337p6w/Za2d4PjEDp23IWChrDjOqKnzRH0hCEr7g23n0j6fVd
	 h5RkJbkb4RxjgtTwNL+EN+o9FZspXVDIaT/0nEwWAef1woann/EHYuwilCM/AcKC7C
	 a2sy+ys04dNm2c/0od0LwmWqPRRy8reVq/bC/qsjbHmwCXhWPIF8a4oj/y81gK6KMv
	 BLp6LasR068vpzPk4wSagKMeP3CErVOw/xDJi8A4zc+nRw3pFe4AW233TI/Yj1URSO
	 lTNnl5ijkP9qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: add thread_wq cgroup test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, bpf@vger.kernel.org
In-Reply-To: <dbc676924bb41d1e943df252460e5068a4cf71ad.1786086076.git.zhuhui@kylinos.cn>
References: <cover.1786086076.git.zhuhui@kylinos.cn>
 <dbc676924bb41d1e943df252460e5068a4cf71ad.1786086076.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 07:19:51 +0000
Message-Id: <20260807071952.0EE2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing memory barriers between the worker kthread and userspace=
 polling can cause test flakiness on weakly-ordered architectures.
- [Medium] The test uses an arbitrary `sleep(2)` to wait for asynchronous m=
ap destruction, creating a race condition that can leak the cgroup.
--

--- Patch [3]: [PATCH bpf-next 3/4] selftests/bpf: add thread_wq cgroup tes=
t ---
commit 0a433d40343251b2dbfb625551f8882c1faf6d99
Author: Hui Zhu <zhuhui@kylinos.cn>

selftests/bpf: add thread_wq cgroup test

This commit adds test cases for bpf_thread_wq with cgroup attachment.
It tests execution both within a specified cgroup and without cgroup
attachment, verifying that callbacks run in the appropriate context.

> diff --git a/tools/testing/selftests/bpf/prog_tests/thread_wq_cgroup.c b/=
tools/testing/selftests/bpf/prog_tests/thread_wq_cgroup.c
> new file mode 100644
> index 0000000000000..7537b03f17e2a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/thread_wq_cgroup.c
> @@ -0,0 +1,87 @@
[ ... ]
> +	for (waited_secs =3D 0; waited_secs < WAIT_TIMEOUT_SECS; waited_secs++)=
 {
> +		if (skel->bss->twq_done)
> +			break;
> +		sleep(1);
> +	}
> +	if (!ASSERT_TRUE(skel->bss->twq_done, "twq_done in cgroup"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(skel->bss->callback_cgroup_id, cg_id,
> +		       "callback_cgroup_id in cgroup"))

[Severity: Medium]
Could this result in spurious test failures on architectures with weak memo=
ry
ordering?

Since the userspace reader loops and polls the twq_done flag without an
acquire memory barrier, might it observe twq_done =3D=3D 1 but read a stale
callback_cgroup_id of 0, thus failing the check in test_thread_wq_cgroup()?

> +		goto cleanup;
> +
> +	/* Run bpf_thread_wq without cgroup attachment (cgroup_id =3D 0). */
[ ... ]
> +cleanup:
> +	if (skel) {
> +		thread_wq_cgroup__destroy(skel);
> +		/* Wait thread_wq kthread quit. */
> +		sleep(2);
> +	}
> +	if (cg_fd >=3D 0)
> +		close(cg_fd);
> +	cleanup_cgroup_environment();
> +}

[Severity: Medium]
Is it possible for the test cgroup to leak if the map destruction takes
longer than 2 seconds?

The cleanup path relies on an arbitrary sleep(2) to wait for asynchronous m=
ap
destruction. When thread_wq_cgroup__destroy() closes the map file descripto=
r,
it triggers deferred map destruction via a system workqueue.

If the system is under heavy load and this takes longer than 2 seconds,
could cleanup_cgroup_environment() attempt to remove the test cgroup while
the kthread is still attached, causing the removal to fail with -EBUSY?

> diff --git a/tools/testing/selftests/bpf/progs/thread_wq_cgroup.c b/tools=
/testing/selftests/bpf/progs/thread_wq_cgroup.c
> new file mode 100644
> index 0000000000000..c70a37f55397d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/thread_wq_cgroup.c
> @@ -0,0 +1,56 @@
[ ... ]
> +__u64 target_cgroup_id;
> +__u64 callback_cgroup_id;
> +int twq_done;
> +int test_key;
> +
> +static int twq_callback(void *map, int *key, void *value)
> +{
> +	callback_cgroup_id =3D bpf_get_current_cgroup_id();
> +	twq_done =3D 1;
> +	return 0;
> +}

[Severity: Medium]
Can this write ordering lead to stale payload reads in userspace on weakly
ordered architectures?

The BPF worker kthread stores callback_cgroup_id and then sets twq_done =3D=
 1
without a release memory barrier. Can the CPU or compiler reorder these
operations in twq_callback(), allowing userspace to see twq_done =3D=3D 1
before the payload is visible?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786086076.gi=
t.zhuhui@kylinos.cn?part=3D3
