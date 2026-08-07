Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3B3DEAF6
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087853; cv=none; b=QQk9fEVEsMWxgyc7Z72jn8WfLpstXKicWYtlVIZJfB2Rk0Rlb8bwTuO+u4ryJWMWTnW1C0Hed7X4eN1R/SW7RS30ESCw672SGUw0//PYuveqfIc4FzGItewGt3Atwq6mBOSNXvIehZc9sAQsB0ZNB9Pm5snqg1yd8Im4lcgqEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087853; c=relaxed/simple;
	bh=t20dwq2mhl9jRkT9bREh4bVd+WsBwtJKdoODe9hXZHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sjeO0QbpnaTSxKQKFh0beKuDStSEmjTJPTE+kXyIWgqXQTq/FS7BsjVHtZQ3GMQeD0+oDCiCY/kZSPI/tb+JskjwWbNrwbcWGdbLmVEYBhCHk8WwpHRwvL/eczHU4ZpDuzOpIk6uKlFXcmrl+NpCOfc/opQhAYFt/GoZnevuRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l75bok64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l75bok64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A821F000E9;
	Fri,  7 Aug 2026 07:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786087840;
	bh=XsgwPpy6oPTcvuLv1GcIvS6+B91RGDHeNZ4kS6Qu3sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l75bok64cAO6P1t/L98sIFNyKB/kiOjMNqrKKJAsld2IuOCtAUPQJqcMh3dz+/Dno
	 /1srH2QCh18JnVfEZz46Xzb8tupOadP1zSSkxJEl6aXQ4eFjdHKlF6tyBbxNj7oO44
	 BBDbiJG7cji+da7G3uVN0+W+U4F3U8tfZHLZl4BxytVWn0scaEvzbtvNxeBbBqY0Np
	 YvUwdF5ow6K/u++jptCAre2dt4NG7Co3Is2rY0ju/7mH0N8vXeYqKHGMyur+FZKCyf
	 g+xi2jg74LXVd/80br/u8dcvrYL0wwIYl3/Fv1v5i4wRv8+gCMXKsQSSryU58wws2/
	 mbYmn9bZZoKrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: add memcg async reclaim
 test for bpf_wq/bpf_thread_wq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, bpf@vger.kernel.org
In-Reply-To: <8c34a7f2ad826054c7e3ae88276614415755e3bc.1786086076.git.zhuhui@kylinos.cn>
References: <cover.1786086076.git.zhuhui@kylinos.cn>
 <8c34a7f2ad826054c7e3ae88276614415755e3bc.1786086076.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 07:30:39 +0000
Message-Id: <20260807073039.C8A821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] Invalid assertion check for `low_cgroup_id`.
- [Medium] Error paths in run_high_low_workload() return incorrect status a=
nd leak a child process.
- [Medium] Hardcoded sleep(1) is used to synchronize with asynchronous BPF =
teardown, leading to flaky tests.
- [Low] Unnecessary file descriptor validation on BPF program obtained from=
 a successfully loaded skeleton.

Pre-existing issues:
- [High] The kfunc `bpf_mem_cgroup_memory_events` fails to properly bounds =
check negative enum values.
- [High] The kfunc `bpf_mem_cgroup_vm_events` fails to properly bounds chec=
k negative enum values.
--

--- Patch [4]: [PATCH bpf-next 4/4] selftests/bpf: add memcg async reclaim =
test for bpf_wq/bpf_thread_wq ---
commit d37a321d7d40c100863512bb9f49b6ebc1834d5e
Author: Hui Zhu <zhuhui@kylinos.cn>

selftests/bpf: add memcg async reclaim test for bpf_wq/bpf_thread_wq

Add memcg_async_reclaim selftest that verifies BPF-driven async
proactive reclaim can mitigate refault-induced slowdown under memory
pressure.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c=
 b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
[ ... ]
> +static int setup_high_low_cgroups(u64 *high_cgroup_id, u64 *low_cgroup_i=
d)
> +{
[ ... ]
> +	*high_cgroup_id =3D get_cgroup_id(CG_HIGH_DIR);
> +	if (!ASSERT_GT(*high_cgroup_id, 0, "get_cgroup_id"))
> +		goto cleanup;
> +
> +	ret =3D create_and_get_cgroup(CG_LOW_DIR);
> +	if (!ASSERT_GE(ret, 0, "create_and_get_cgroup " CG_LOW_DIR))
> +		goto cleanup;
> +	close(ret);
> +
> +	*low_cgroup_id =3D get_cgroup_id(CG_LOW_DIR);
> +	if (!ASSERT_GT(*high_cgroup_id, 0, "get_cgroup_id"))
> +		goto cleanup;

[Severity: Medium]
Is it intentional to check *high_cgroup_id here instead of the newly
assigned *low_cgroup_id?

> +
> +	return 0;
> +
> +cleanup:
> +	cleanup_cgroup_environment();
> +	return -1;
> +}
[ ... ]
> +static int
> +run_high_low_workload(double *high_elapsed, double *low_elapsed, int rea=
d_times)
> +{
[ ... ]
> +	low_pid =3D fork();
> +	if (!ASSERT_GE(low_pid, 0, "fork low"))
> +		goto cleanup_low_time;
> +	if (low_pid =3D=3D 0)
> +		exit(real_test_child_work(CG_LOW_DIR, low_data_file,
> +					  low_time_file, read_times));
> +
> +	high_pid =3D fork();
> +	if (!ASSERT_GE(high_pid, 0, "fork high")) {
> +		(void)waitpid(low_pid, NULL, 0);
> +		goto cleanup_low_time;
> +	}
> +	if (high_pid =3D=3D 0)
> +		exit(real_test_child_work(CG_HIGH_DIR, high_data_file,
> +					  high_time_file, read_times));
> +
> +	ret =3D waitpid(low_pid, &status, 0);
> +	if (!ASSERT_GT(ret, 0, "low waitpid"))
> +		goto cleanup_low_time;

[Severity: Medium]
If this assertion or the subsequent status checks fail, we jump to
cleanup_low_time. Does this leave the concurrently running high_pid as an
orphaned process?=20

> +	if (!ASSERT_TRUE(WIFEXITED(status), "low exited"))
> +		goto cleanup_low_time;
[ ... ]
> +static int
> +setup_bpf(u64 high_cgroup_id, u64 low_cgroup_id,
> +	  struct memcg_async_reclaim **skel_ptr, bool use_thread_wq)
> +{
[ ... ]
> +	skel =3D memcg_async_reclaim__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "memcg_async_reclaim__open_and_load"))
> +		return -1;
> +
> +	if (use_thread_wq)
> +		prog_init_fd =3D bpf_program__fd(skel->progs.thread_wq_prog_init);
> +	else
> +		prog_init_fd =3D bpf_program__fd(skel->progs.wq_prog_init);
> +	if (!ASSERT_GE(prog_init_fd, 0, "bpf_program__fd"))
> +		goto error_out;

[Severity: Low]
Is this file descriptor check necessary? The skeleton API guarantees that a=
ll
programs have valid file descriptors after a successful __open_and_load().

> +
> +	err =3D bpf_prog_test_run_opts(prog_init_fd, &run_opts);
[ ... ]
> +void test_memcg_wq_async_reclaim(void)
> +{
[ ... ]
> +out:
> +	if (skel)
> +		memcg_async_reclaim__destroy(skel);
> +	/*
> +	 * Wait for bpf_wq to release the reference to cgroup
> +	 * to ensure the successful deletion of cgroup.
> +	 */
> +	sleep(1);
> +	cleanup_cgroup_environment();
> +}

[Severity: Medium]
Could this hardcoded sleep(1) lead to test flakiness if the asynchronous BPF
workqueue takes longer than one second to release its cgroup references
under load?

> +
> +void test_memcg_thread_wq_async_reclaim(void)
> +{
[ ... ]
> +out:
> +	if (skel)
> +		memcg_async_reclaim__destroy(skel);
> +	/*
> +	 * Wait for bpf_thread_wq to release the reference to cgroup
> +	 * to ensure the successful deletion of cgroup.
> +	 */
> +	sleep(1);
> +	cleanup_cgroup_environment();
> +}

[Severity: Medium]
Similarly, could this hardcoded sleep(1) cause intermittent test failures
if the thread_wq callback is delayed?


[Severity: High]
This isn't a bug introduced by this patch, but does the bounds check in
bpf_mem_cgroup_memory_events() correctly handle negative values?=20

mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events() {
    ...
    if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
        return (unsigned long)-1;

    return atomic_long_read(&memcg->memory_events[event]);
}

Since the parameter is signed, a BPF program passing a negative value=20
(like -1) could bypass the check and cause an out-of-bounds memory read.


[Severity: High]
This is also a pre-existing issue, but does memcg_vm_event_item_valid()
protect against negative values when called by bpf_mem_cgroup_vm_events()?

mm/bpf_memcontrol.c:bpf_mem_cgroup_vm_events() {
    ...
    if (unlikely(!memcg_vm_event_item_valid(event)))
        return (unsigned long)-1;
    ...
}

mm/memcontrol.c:memcg_vm_event_item_valid() {
    if (idx >=3D NR_VM_EVENT_ITEMS)
        return false;
    ...
}

Similar to the previous issue, a negative enum value bypasses the upper-bou=
nd
check due to signed comparison, allowing out-of-bounds memory access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786086076.gi=
t.zhuhui@kylinos.cn?part=3D4
