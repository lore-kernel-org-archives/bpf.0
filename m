Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E15455629
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468785; cv=none; b=hXRwiwhihOVlj36zNQG2OoIg11q4GyUqi6831lxzwsOm9UQPoOsEcJGIcnf0PJmMFiaApQH51DcY1FUZeK92EaoBgi8H9G2KHevMWQ9L8Vzwf9MouhCULREy0xwq2/8lSAwjV3HTbOp+nREaaBiZvqjCpxXh3vT/nwhUoGI22S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468785; c=relaxed/simple;
	bh=+g/q2RETCc2FCW0CjWM4NsVieur9HfA0eDDu1nOaBNM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DeTivmgOMlsdgJChMnMK5/UhgdxCwFAJiz18RLhLB+aPCxDKYIf6xEVsnzHXH+RBO7+z8CtEmfyT9vx29fLYJWst/OypY8usLRpSyghRmW4RLQ0wYZFCoUddKBZ9BiP85lCYdb2ij0drAgLeeGy7kcErA+RhZn9eclrvst/AKc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei89TKUR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei89TKUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DC11F000FF;
	Thu,  8 Oct 2026 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791468784;
	bh=hgvMzyRXOWBWP9l4Oz+oYPfbEWRHu88Z/n+2KML9EAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ei89TKURD0AbLHOG6N7Vzxtqe0znKd3Plh4S46yaIdqrSc75CdPWUyRUTSTTvEVak
	 6/cc/RTcW9ecqDsjvV3hgXHbVZnQlQ+R22y0HjE/lezJLsVjyDhZ9j7z6hFo732gRF
	 4t7+jVeNKhx2LWeQ4/hQYAXKV6jU4YlPUSCQEehulVGwEETzG7GHTpDunnlykkdKmI
	 S+Kei5zsSV1nW1pSS0WRSU4gcI6kaQaRCebWbEox9hPurZ6GsZmgRQ8KoRXOkFQPdy
	 sgmXP53pFGO+wtRtL4N6MbtSpSA8BtT0Kn//GwJbF3E3Dc5+kRcGb/I3hOzhwa+2b+
	 VzAtPcJcXH5bg==
Message-ID: <sashiko-outbox-164267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Don't stack a bpffs in
 cgroup_hierarchical_stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008-selftests-bpf-cgroup-stats-bpffs-v1-2-76b9a6d1be34@gmail.com>
References: <20261008-selftests-bpf-cgroup-stats-bpffs-v1-0-76b9a6d1be34@gmail.com>
 <20261008-selftests-bpf-cgroup-stats-bpffs-v1-2-76b9a6d1be34@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:13:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] selftests/bpf: stale mounted_bpffs flag causes unintended unmoun=
t of shared bpffs
- [Medium] selftests/bpf: uninitialized fds close stdin on setup error path
- [Low] bpf: selftests: spurious test failure due to unhandled EEXIST on mk=
dir
--

commit 73ba1f06cd40bfa82a4b5df33520980276eaa88f
Author: Qiliang Yuan <odys.yuan@gmail.com>

selftests/bpf: Don't stack a bpffs in cgroup_hierarchical_stats

This commit changes the test to only mount a new BPF filesystem if one is
not already present at /sys/fs/bpf. It avoids hiding an existing mount,
which would cause parallel tests to lose access to their pinned objects.

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_s=
tats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> index a93b16ed629e9..8e0b67df700bf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c

[ ... ]

> @@ -88,13 +90,22 @@ static int read_from_file(const char *path, char *buf=
, size_t size)
>  /* mounts bpffs and mkdir for reading stats, returns 0 on success. */
>  static int setup_bpffs(void)
>  {
> +	struct statfs st;
>  	int err;
> =20
> -	/* Mount bpffs */
> -	err =3D mount("bpf", BPFFS_ROOT, "bpf", 0, NULL);
> -	mounted_bpffs =3D !err;
> -	if (ASSERT_FALSE(err && errno !=3D EBUSY, "mount"))
> +	/*
> +	 * Mount bpffs unless it is already there. Mounting another one on top
> +	 * would hide what other tests running in parallel pin in it.
> +	 */
> +	err =3D statfs(BPFFS_ROOT, &st);
> +	if (!ASSERT_OK(err, "statfs " BPFFS_ROOT))
>  		return err;

[Severity: Medium]
If this statfs() check fails, does the subsequent error handling close stdi=
n?

Looking at the error path, if setup_bpffs() returns an error here,
destroy_hierarchy() calls cleanup_cgroups(), which iterates over the
cgroups array and calls close(cgroups[i].fd) and close(root_cgroup_fd):

cleanup_cgroups() {
	close(root_cgroup_fd);
	for (int i =3D 0; i < N_CGROUPS; i++)
		close(cgroups[i].fd);
	...
}

Since these are static variables without explicit initialization, they
are implicitly initialized to 0. If setup_cgroups() hasn't been called
yet, wouldn't this call close(0) (stdin) multiple times?

In a parallel test runner environment, closing file descriptor 0 can lead
to subsequent opens unexpectedly getting file descriptor 0, which would then
be inadvertently closed by the remaining loop iterations, potentially
corrupting concurrent test operations.

> +	if (st.f_type !=3D BPF_FS_MAGIC) {
> +		err =3D mount("bpf", BPFFS_ROOT, "bpf", 0, NULL);
> +		if (!ASSERT_OK(err, "mount"))
> +			return err;
> +		mounted_bpffs =3D true;
> +	}

[Severity: Medium]
Is it possible for the mounted_bpffs flag to remain true from a previous
test run and cause an unintended unmount?

The test runner executes tests sequentially in a single process, so BSS
variables like mounted_bpffs persist across iterations. On the first run,
if the BPFFS is not already mounted, setup_bpffs() mounts it and sets
mounted_bpffs =3D true.

If cleanup_bpffs() unmounts it but fails to reset mounted_bpffs to false,
on a subsequent run where BPFFS is already mounted, st.f_type =3D=3D
BPF_FS_MAGIC is true, and the block above is skipped.

Since mounted_bpffs is still true from the previous run, will
cleanup_bpffs() erroneously unmount the shared BPFFS that it did not mount,
destroying objects pinned by parallel tests?

> =20
>  	/* Create a directory to contain stat files in bpffs */
>  	err =3D mkdir(BPFFS_ATTACH_COUNTERS, 0755);
>  	if (!ASSERT_OK(err, "mkdir"))
>  		return err;

[Severity: Low]
Does this strict ASSERT_OK() check cause spurious test failures if the
directory already exists?

Since the test now reuses an existing BPFFS instead of shadowing it with
a new empty mount, if a previous test run crashes or is aborted, it leaves
behind the BPFFS_ATTACH_COUNTERS directory.

On the next run, mkdir() would return -1 with errno =3D=3D EEXIST, causing
this check to fail and abort the test. Any pinned files left inside the
directory would also cause subsequent bpf_link__pin() calls to fail with
EEXIST.

Should this gracefully handle the EEXIST case and cleanup leftover state
when reusing a shared filesystem?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-selftests-=
bpf-cgroup-stats-bpffs-v1-0-76b9a6d1be34@gmail.com?part=3D2
