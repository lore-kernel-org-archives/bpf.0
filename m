Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF9331EC0;
	Thu, 20 Aug 2026 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209522; cv=none; b=QMTwURgy+1sF+bzhS7/fseqoTg1F2TvoseoBBV3BfmWnZttkU/8t/kc4E3zH3ovas1T/BVMYMgq6+W9FiWBE37AIzXSXHep/JPJBY3QceN6xKlDoJJT0DkKZH3y0ONGogvuvKirRZ55G+VoLs89HCFHydhAzFkbZSF9swpdD2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209522; c=relaxed/simple;
	bh=vj3K7yDydl1XYU+zd+Lft15kv6UALnTsl8LRTAY7Iag=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RmYnTcKPJ9+SweeYtm2JJ5HLzI14AI+lsEIlSl01/bYXPj3wlTz3cbKfr8OvU247G9QBNl9ltFZXbj43tmDeg39diB6SWACWoyNvZ947YDsHBCIvro2GBeK6U+D/EnBv4HAIhI8fmxu1lCs0hNnWBdMa4xne1Qd3xVU90ccIJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oxz7uuCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oxz7uuCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE65B1F000E9;
	Thu, 20 Aug 2026 07:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787209521;
	bh=4C4ZMUR5H8zP5phSMEeaZLLChga4fEuuYPg/hQGsKQ4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Oxz7uuCdKuBg4JDl2r5Ud4goEYYL6kYA0c7Ifg1NBixxeYNYii8XMmWfpKFJreNws
	 2Y1yY3zGntWMDU/74/JEJa+Svg0edsrPFPciEi22PZBUy7EXjUK0R3h+poqHi3nhbV
	 HrZF0zih5fmHFEkt5x5JovFaVz3EbVq86imPCnwcXGdGqXpbgns9pTxY9zKNV+SviL
	 YJtonnHluBnZfKNFF71RXnqLfO9XpYtI9jOVL37symJmdlazvbLE5dUIkfJMM9GPC1
	 GVPIJW/XcBXj7IE4bbtNqwlFb6ML0NauTauWckwS1hlR0jq0UigNZGE3BlRTp4fFFa
	 k0OI3mqLe0PRA==
Content-Type: multipart/mixed; boundary="===============3588420820797333624=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <046d6c5701bd2b2cd5c5e7c2bc631a114adc20842f9a0c27a273b56fc1014a55@mail.kernel.org>
In-Reply-To: <53762e3403fe8e8c263cf685cea5d55377ec5204.1787205002.git.zhuhui@kylinos.cn>
References: <53762e3403fe8e8c263cf685cea5d55377ec5204.1787205002.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: add memcg async reclaim test
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,baohua@kernel.org,geliang@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 07:05:20 +0000 (UTC)

--===============3588420820797333624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> index 000000000000..ece7bceaab3c
> --- /dev/null
> +++ tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> @@ -0,0 +1,480 @@

[ ... ]

> +/*
> + * The workload files must sit on a regular filesystem: with swap
> + * disabled for the cgroup, tmpfs/ramfs pages are unevictable and would
> + * OOM the cgroup instead of exercising reclaim; they are also charged
> + * as anonymous memory, so they never raise the WORKINGSET_REFAULT_FILE
> + * events the BPF program monitors. Fall back to the current directory
> + * when /tmp is backed by such a filesystem.
> + */

The comment states that tmpfs/ramfs pages "are also charged as anonymous
memory." Is this accurate?

Looking at the page cache charge path (mm/filemap.c __filemap_add_folio()),
tmpfs/shmem folios go through folio_memcg_charge() and land in
NR_FILE_PAGES/NR_SHMEM, which shows up in memory.stat's file/shmem
counters, not as anonymous memory.

The reason they don't trigger WORKINGSET_REFAULT_FILE is different:
shmem folios are swap-backed, so folio_is_file_lru() returns false
(include/linux/mm_inline.h), and workingset_refault() accounts them at
WORKINGSET_REFAULT_ANON instead (mm/workingset.c).

The conclusion the comment draws is correct, but the stated reason is
not. For a patch aimed at the mm/memcg audience, could the wording be
adjusted to reflect that they sit on the anon LRU because they are
swap-backed?

> +static const char *workload_files_dir(void)
> +{
> +	struct statfs st;
> +
> +	if (!statfs("/tmp", &st) &&
> +	    (st.f_type == TMPFS_MAGIC || st.f_type == RAMFS_MAGIC))
> +		return ".";
> +	return "/tmp";
> +}

[ ... ]

> +static int setup_high_low_cgroups(u64 *high_cgroup_id, u64 *low_cgroup_id)
> +{
> +	int ret;
> +	char limit_buf[20];
> +
> +	ret = setup_cgroup_environment();
> +	if (!ASSERT_OK(ret, "setup_cgroup_environment"))
> +		goto cleanup;
> +
> +	ret = create_and_get_cgroup(CG_DIR);
> +	if (!ASSERT_GE(ret, 0, "create_and_get_cgroup " CG_DIR))
> +		goto cleanup;
> +	close(ret);
> +
> +	ret = enable_controllers(CG_DIR, "memory");
> +	if (!ASSERT_OK(ret, "enable_controllers"))
> +		goto cleanup;

A subsystem pattern flags this as potentially concerning: the test
treats an absent memory controller as a test failure rather than a skip.

enable_controllers() ends up in __enable_controllers() which writes to
cgroup.subtree_control and returns 1 when that write fails. On a kernel
built with CONFIG_MEMCG=n or booted with cgroup_disable=memory, the
memory controller does not exist, the write is rejected, and the test
reports FAIL.

The feature being tested is CONFIG_MEMCG-gated: mm/Makefile builds
bpf_memcontrol.o as obj-$(CONFIG_MEMCG), so on such a kernel there is
nothing to test. Note that 123 other prog_tests use test__skip() with
a reason string for missing capabilities.

However, CONFIG_MEMCG=y is present in every per-arch BPF selftest config
(config.x86_64, config.aarch64, config.s390x, etc.), so BPF CI will
never hit this path. It is only reachable with a hand-rolled kernel
config that omits it. Given this context, is the ASSERT_OK() treatment
acceptable?

[ ... ]

> +void test_memcg_wq_async_reclaim(void)
> +{
> +	u64 high_cgroup_id, low_cgroup_id;
> +	int err;
> +	double high_time = 0.0, low_time = 0.0;
> +	struct memcg_async_reclaim *skel = NULL;
> +
> +	err = setup_high_low_cgroups(&high_cgroup_id, &low_cgroup_id);
> +	if (!ASSERT_OK(err, "setup_high_low_cgroups reclaim"))
> +		return;
> +
> +	err = setup_bpf(high_cgroup_id, low_cgroup_id, &skel);
> +	if (!ASSERT_OK(err, "setup_bpf"))
> +		goto out;
> +
> +	err = run_high_low_workload(&high_time, &low_time, READ_TIMES);
> +	if (!ASSERT_OK(err, "run_high_low_workload reclaim"))
> +		goto out;
> +
> +	/*
> +	 * The timing comparison below alone cannot distinguish a working
> +	 * reclaim from a no-op one, so require that the BPF program
> +	 * actually reclaimed memory from the low cgroup.
> +	 */
> +	if (!ASSERT_GT(skel->bss->reclaim_calls, 0, "reclaim_calls"))
> +		goto out;
> +	if (!ASSERT_GT(skel->bss->reclaimed_bytes, 0, "reclaimed_bytes"))
> +		goto out;
> +
> +	if (high_time >= low_time)
> +		PRINT_FAIL("high cgroup not improved with async reclaim: high_time=%f low_time=%f",
> +			   high_time, low_time);

Does the zero-margin wall-clock comparison make the test brittle?

The test's final pass/fail criterion is a single-run timing comparison
between two symmetric workloads with no baseline. PRINT_FAIL() expands to
test__fail(), so this marks the whole test FAILED whenever high_time >=
low_time, including on a tie or a 1-microsecond inversion.

The two children are symmetric by construction: run_high_low_workload()
forks them within microseconds of each other and both run the identical
real_test_child_work() body (write a 32 MB file, then read-fault it 50
times) inside sibling cgroups under one shared memory.max of 32 MB.

Which one finishes first is decided by page-reclaim ordering, disk service
order, CPU scheduling, and host load. The test pins only memory.max and
memory.swap.max but does not pin the reclaim implementation (classic LRU
vs MGLRU, selected at runtime), the dirty-ratio sysctls, the CPU count, or
the backing device.

On a machine where the BPF-driven reclaim of the low cgroup does not
translate into a measurable ordering advantage, a fully correct kernel
reports FAIL.

The comment just above acknowledges that the timing signal is weak. The two
ASSERT_GT checks on reclaim_calls and reclaimed_bytes are deterministic and
verify that bpf_proactive_reclaim() actually ran. The timing comparison
adds no deterministic coverage on top of them, only a nondeterministic
failure mode.

For comparison, prog_tests/test_overhead.c is the only other prog_test that
uses clock_gettime(CLOCK_MONOTONIC, ...), and it only prints its
measurements. Could the comparison either require a substantial margin, be
bounded with retry logic, or report the ratio informationally with
fprintf(stdout, ...) instead of PRINT_FAIL()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32339450346
--===============3588420820797333624==--
