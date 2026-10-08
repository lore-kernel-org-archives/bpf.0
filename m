Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF34CEE49;
	Thu,  8 Oct 2026 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470926; cv=none; b=FnXyQ9at3Rv3Qf6gMZn0LL8LaiMgor9lf9oaO0Zt+tq/wQbntu3CcLZ6rQlHokvRlLNLW4MURXi/U0CioiwBeWRoFUzUnXjL9wIhyIeGMvs1IbLbUtMWtR3CFPp+BwhdGINyVge62OcWSNczqVNYSzUFOInXaW4IrPHkt0PxW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470926; c=relaxed/simple;
	bh=zcrtJxpGwPvO6znnEoDATns333KcWtpWLnR9+E1tdmE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=soCz2WA/jlHqXeM1TiM4D8sH1Mu9XstNODiynt0d7Jpnb5O/n6zpU6PrEDAqnro45ASDAge5GT9Wx/Gn3m3ORLb1wNDcW+TBIwMZHXWbeVht51uIn1ehHgkBFD1KCH0wqAIAM7WG+WlosaRlmR1GYMmkBeisgHhcSCHsBcADpDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTcxmFvo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTcxmFvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC351F000FF;
	Thu,  8 Oct 2026 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470907;
	bh=hhg87ZvJs973gY+K3g4YqzZQ00kR5hanhFZoI6UIECQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YTcxmFvo4nIazgPGB+S7FCP8BffoJvVUq0q8cSifChVCRLpp6nQNnYfA/zjqcIZ1y
	 0sUX12X5FfsVZIkz3Z/05Ws06XG4HLn6YwMp3oQ4F4woOW0CxGF0to6clmHAE1eCsV
	 LCKFed7czRQYCM0XOuzTgSmJViHhqktGu59FN71bvARI6+9waeP4zmfXJBtNLe53TT
	 z3GMjCG4+xzuHxN8VQM7NJSScaBJomOJ3RuynQgk7nj7nCE01rl8NRqu6wTSrOEJ6e
	 W2GoowABmQg6BoQvqEcwLEDhmUqK4Jy9Vi9v5cSjxDrSc8JEmHyyZJkbojdXK/pyx2
	 Cz219DC3eHFnQ==
Content-Type: multipart/mixed; boundary="===============7558581794726513330=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2d7ad17f07f7077431987fe4de72f17d1e87937bacc4250ec4f51586c4ca2a58@mail.kernel.org>
In-Reply-To: <20261008-selftests-bpf-cgroup-stats-bpffs-v1-2-76b9a6d1be34@gmail.com>
References: <20261008-selftests-bpf-cgroup-stats-bpffs-v1-2-76b9a6d1be34@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Don't stack a bpffs in cgroup_hierarchical_stats
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,yosry@kernel.org,haoluo@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  8 Oct 2026 14:48:25 +0000 (UTC)

--===============7558581794726513330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Don't stack a bpffs in cgroup_hierarchical_stats

TL;DR:
- Commit message may be inaccurate: bpffs mounted before the cgroup
  mount-namespace unshare seems never unmounted afterwards
- Unanswered v1 question: drop the mounting code or add a common helper?

> selftests/bpf: Don't stack a bpffs in cgroup_hierarchical_stats
>
> setup_bpffs() mounts a bpffs on /sys/fs/bpf even when one is already
> there, while test_progs runs other tests that pin objects in /sys/fs/bpf
> in parallel.
>
> The new, empty bpffs hides the old one until the test ends, so those
> tests lose what they pinned or the directories they pin into.
> bpftool_maps_access then fails to pin an iterator because
> /sys/fs/bpf/test_bpftool_map doesn't exist anymore, and bpftool_metadata
> can't find the program it pinned in /sys/fs/bpf/test_metadata.
>
> Mount a bpffs only if /sys/fs/bpf isn't one already.
>
> Fixes: 88886309d2e8 ("selftests/bpf: add a selftest for cgroup hierarchical stats collection")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

The changelog says the new bpffs hides the old one "until the test ends".
Is that accurate?

setup_hierarchy() calls setup_bpffs() first and setup_cgroups() second:

    static int setup_hierarchy(void)
    {
        return setup_bpffs() || setup_cgroups();
    }

setup_cgroups() goes through setup_cgroup_environment(), which moves the
process into a private mount namespace:

    tools/testing/selftests/bpf/cgroup_helpers.c:setup_cgroup_environment() {
        ...
        if (unshare(CLONE_NEWNS)) {
        ...
        if (mount("none", "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
        ...
    }

So a bpffs mounted by setup_bpffs() lands in the original mount namespace,
and the test then continues in a private copy and never switches back
(cgroup_helpers.c has no setns()).

cleanup_bpffs() runs after cleanup_cgroups() from destroy_hierarchy(), so
its umount(BPFFS_ROOT) only removes the private copy.  The empty bpffs in
the original namespace seems to stay on top of the real one after the test
ends, and other processes in that namespace would keep losing their pins.

The same applies to the mounted_bpffs = true path that this patch keeps:
the umount in cleanup_bpffs() does not undo the mount done in
setup_bpffs().

The check for an existing bpffs avoids the stacking, but should the
changelog be reworded to describe this accurately?  Alternatively, could the
bpffs setup be done after setup_cgroup_environment(), or the unmount be done
in the original namespace?

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> index a93b16ed629e..8e0b67df700b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c

[ ... ]

> @@ -88,13 +90,22 @@ static int read_from_file(const char *path, char *buf, size_t size)
>  /* mounts bpffs and mkdir for reading stats, returns 0 on success. */
>  static int setup_bpffs(void)
>  {
> +	struct statfs st;
>  	int err;
>
> -	/* Mount bpffs */
> -	err = mount("bpf", BPFFS_ROOT, "bpf", 0, NULL);
> -	mounted_bpffs = !err;
> -	if (ASSERT_FALSE(err && errno != EBUSY, "mount"))
> +	/*
> +	 * Mount bpffs unless it is already there. Mounting another one on top
> +	 * would hide what other tests running in parallel pin in it.
> +	 */
> +	err = statfs(BPFFS_ROOT, &st);
> +	if (!ASSERT_OK(err, "statfs " BPFFS_ROOT))
>  		return err;
> +	if (st.f_type != BPF_FS_MAGIC) {
> +		err = mount("bpf", BPFFS_ROOT, "bpf", 0, NULL);
> +		if (!ASSERT_OK(err, "mount"))
> +			return err;
> +		mounted_bpffs = true;
> +	}

Yosry Ahmed raised a design question on v1 that does not appear to have
been answered.  The other tests that break (bpftool_maps_access and
bpftool_metadata) do not mount bpffs themselves, they rely on it already
existing:

> Seems like both of these tests do not mount bpffs, but rely on its
> existence. If it's generally expected that bpffs is mounted when the tests
> are run, should we drop the mounting code here instead? Alternatively,
> should we have a common helper for creating directories in bpffs that
> mounts it if it isn't already there?

Since this patch keeps the conditional mount in setup_bpffs(), should the
mounting code be dropped here, or should a common helper that creates
directories in bpffs and mounts it only when missing be introduced?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37792241939
--===============7558581794726513330==--
