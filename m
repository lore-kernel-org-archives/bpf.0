Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108232D0FC
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763811; cv=none; b=NLXnjroZ0Yejx9yvvwN2nINLi6nxNSS1inCXmThLVdAKTUJ6daVdpE0Oj+C+JjgIAzOsOLzJl6bjSYoxgfQiqp5yWRf/BbDkxsZYIO6hmpA3UImVrdQF4CVrdh3ILI1UIZC2OBy8411XsiebxRcFPa68IfUDTBbfou/ZWkB2JcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763811; c=relaxed/simple;
	bh=W8ygCA+3Ku7eBoEW7vBScsQC3u8Jgp8OerUoxFtz/tQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JkcK1NjFXd/O7G1JwXaLL0soMM+rYZR9AgtsukmftHycXRMVnisGfFnNQ9aMgYCZN2YU1naEXDPq1aOpfHFTRdLm9SY9rS/f9DK+6X5gBt4GhVOaFjUD/no2zFJNl4w0gu3Pp4mUHf60tsltS5o9ZztjWZM7s3hdlDkXxGtxVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKQdp3ao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKQdp3ao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02111F00A3A;
	Tue, 26 May 2026 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779763808;
	bh=sq6kyfBe4cglVLw7UCDkg98Gwpo/wgIJrG9+nfI4ZNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MKQdp3aoVgTSonc+28TZabVV6XDbMwiBd3eMI8awEzhi6FlyR6Kepza2UvcFPbe4z
	 a5JexWodUsQXPU29012ZggkI7FpfCLfvLmIxwi80X/klNv99PMtQKk4ybDELx4jwzU
	 jYRC5D9gwu/V8HPmjsYhHW5ziE4Nlrh5PSE+wl8kH9rMPukJI+JO8NhgLyGHs0CgaZ
	 kDNWC1Q+KIKJeovTNslMnwpHDAW4m9N2VkvZ14w37hNPjIr/73ApkNzQu+uaPeXRlL
	 4DqMsYGwdGo3GZ9JlAt3XF4Eu7wKV13ttSe0DfpUJKNCTHji81QDhaHbRgTBmRvWYE
	 wnxcstH4ts21g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v7 08/11] selftests/bpf: Add tests for
 memcg_bpf_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, tj@kernel.org
In-Reply-To: <722df14b403dfbb123f1a1df3c72fbbfb998a31f.1779760876.git.zhuhui@kylinos.cn>
References: <722df14b403dfbb123f1a1df3c72fbbfb998a31f.1779760876.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 02:50:07 +0000
Message-Id: <20260526025007.C02111F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The inline assembly in `read_file` fails to actually trigger memor=
y access and page faults.
- [Medium] Error paths in `real_test_memcg_ops` leave child processes orpha=
ned, preventing cgroup cleanup.
- [Medium] The commit message references a `get_high_delay_ms` hook, but th=
e implemented hook is `memcg_charged`.
- [Low] Missing file descriptor validation after manual map lookup using `b=
pf_map__fd()`.
- [Low] TOCTOU race condition from closing temporary file descriptors gener=
ated by `mkstemp()`.
--

commit 239c9254e915ce7f13738ad4bc04054bec8bf86e
Author: Hui Zhu <zhuhui@kylinos.cn>

selftests/bpf: Add tests for memcg_bpf_ops

Add a comprehensive selftest suite for the memcg_bpf_ops functionality. The=
se
tests validate that BPF programs can correctly influence memory cgroup
throttling behavior by implementing the new hooks.

>     The test suite is added in `prog_tests/memcg_ops.c` and covers
>     several key scenarios:
>    =20
>     1. `test_memcg_ops_over_high`:
>        Verifies that a BPF program can trigger throttling on a low-priori=
ty
>        cgroup by returning a delay from the `get_high_delay_ms` hook when=
 a
>        high-priority cgroup is under pressure.
>    =20
>     2. `test_memcg_ops_below_low_over_high`:
>        Tests the combination of the `below_low` and `get_high_delay_ms`
>        hooks, ensuring they work together as expected.
>    =20
>     3. `test_memcg_ops_below_min_over_high`:
>        Validates the interaction between the `below_min` and
>        `get_high_delay_ms` hooks.

[Severity: Medium]
The commit message mentions the get_high_delay_ms hook multiple times, but =
the
code implements memcg_charged_impl which attaches to struct_ops/memcg_charg=
ed.
Could the commit message be updated to reflect the actual hook name used?

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c b/tools/t=
esting/selftests/bpf/prog_tests/memcg_ops.c
> new file mode 100644
> index 0000000000000..19fd4fde22660
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
[ ... ]
> +int read_file(const char *filename, int iterations)
> +{
[ ... ]
> +	for (int iter =3D 0; iter < iterations; iter++) {
> +		for (i =3D 0; i < FILE_SIZE; i +=3D page_size) {
> +			/* access a byte to trigger page fault */
> +			p =3D &map[i];
> +			__asm__ __volatile__("" : : "r"(p) : "memory");
> +		}
> +
> +		if (env.verbosity >=3D VERBOSE_NORMAL)
> +			printf("%s %d %d done\n", __func__, getpid(), iter);
> +	}

[Severity: High]
Does this inline assembly actually trigger a memory access?

The "r"(p) constraint just loads the address into a general-purpose registe=
r,
but doesn't dereference it. The memory clobber also does not force a read of
the pointer's target memory.=20

Should this be dereferenced, such as "r"(*p) or explicitly via=20
(void)*(volatile char *)p, to ensure a page fault is triggered?

[ ... ]
> +static void real_test_memcg_ops(int read_times)
> +{
> +	int ret;
> +	char data_file1[] =3D "/tmp/test_data_1_XXXXXX";
> +	char data_file2[] =3D "/tmp/test_data_2_XXXXXX";
> +	char time_file1[] =3D "/tmp/test_time_1_XXXXXX";
> +	char time_file2[] =3D "/tmp/test_time_2_XXXXXX";
> +	pid_t pid1, pid2;
> +	double time1, time2;
> +	int status;
> +
> +	ret =3D mkstemp(data_file1);
> +	if (!ASSERT_GE(ret, 0, "mkstemp"))
> +		return;
> +	close(ret);

[Severity: Low]
By closing the file descriptor returned by mkstemp() immediately and then
having the child process reopen it later with fopen(), does this introduce a
time of check to time of use race condition?

Would it be safer to pass the file descriptor to the child process or use a
different mechanism for temporary file handling?

[ ... ]
> +	ret =3D waitpid(pid1, &status, 0);
> +	if (!ASSERT_GT(ret, 0, "child1 waitpid"))
> +		goto cleanup;
> +	if (!ASSERT_TRUE(WIFEXITED(status), "child1 exited normally"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(WEXITSTATUS(status), 0, "child1 exit status"))
> +		goto cleanup;
> +
> +	ret =3D waitpid(pid2, &status, 0);

[Severity: Medium]
If the waitpid for pid1 fails, or if pid1 exits abnormally or returns a
non-zero status, the code jumps to cleanup without waiting for or terminati=
ng
pid2.

Will this leave pid2 running in the background and attached to the
high-priority cgroup, preventing cgroup cleanup and affecting subsequent
tests?

[ ... ]
> +void test_memcg_ops_over_high(void)
> +{
[ ... ]
> +	map =3D bpf_object__find_map_by_name(skel->obj, ".bss");
> +	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name .bss"))
> +		goto out;
> +
> +	map_fd =3D bpf_map__fd(map);
> +	bss_data =3D calloc(1, bpf_map__value_size(map));

[Severity: Low]
Should map_fd be validated before being used?

The BPF subsystem selftest guidelines recommend checking file descriptors
returned after manual lookups, for example with ASSERT_GE(map_fd, 0, ...).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779760876.gi=
t.zhuhui@kylinos.cn?part=3D8
