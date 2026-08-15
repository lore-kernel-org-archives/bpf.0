Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB94B04A0
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786752803; cv=none; b=sshaGGmGiWFBfoWeBEXRfo0q3b+8aYLqpPYMY3RBBQiSn5hePhXZ9E8eSryosY/lpmuuXsAzFaFSKqvtayQ+UDQbNdOrAcitB8Bw7NEUujLr8m9DAwGDzqmdrvSGmlfqS0RRmn3kKcv1d5ywo4muSRPxhnFqkEfeVu4/63fqB0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786752803; c=relaxed/simple;
	bh=DnSeyMSD0rzo0WOl3epffo3cDD4HUSRKkcyCX+Mm4Fs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lfcxHO/TnQgAfYqaMXJJ89rMB8avLXqiaeROoatZ0pAZKu2exK/fWrqCSTMl05CiZ48c4RuTneSsw7CBXuKMG5li9YgF4Iykf026mDsAPLhK6wMTWQaCAmEZ9qwG9wZwZmiDd7WLYHreEyIHF37SQk695mIOtUaOikhYoi5+IL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5HxEC1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5HxEC1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4231F000E9;
	Sat, 15 Aug 2026 00:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786752802;
	bh=NCuO/eNOM6OQi50FdqCrAU0bwxD2zj1sF7WVmgZL2yY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g5HxEC1tDp3nFJpIMYpIFL/3FLQ+DkxSMnHhZePiXRn9KFBQ0t1IqPOyOUEgnRXcF
	 JFPKlgLLkndv3BecOkvO6re3LOEmphqylZSxYHKFCCh33mnY4SWKTf59u0ZungzMvI
	 Ng0biKIReNzW2H0lP6WqLWSmvgo1byVzqX7WIa9DOOycaHjSpg0GRVNO/SHRNuPZoa
	 REK8TYaIZ77I2uBzeFiFvZ5hM6zfbBooGE1i68tokAipkynBTXCM4iL674j2zQDeJa
	 fFBX/QgprSpzPdKBRxtytVxNkokVDWSX2YyrpUlaz+w4fdtqVgUbNEFFmT75BRazJ7
	 QHhpYrML50SuQ==
Content-Type: multipart/mixed; boundary="===============3798828678189222425=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f378de7112ea0f57deb3cfd220bdde8af20918ab931d4d520195f04912924c55@mail.kernel.org>
In-Reply-To: <20260814232017.2839959-1-andrii@kernel.org>
References: <20260814232017.2839959-1-andrii@kernel.org>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Retry stat generation in cgroup_iter_memcg
From: bot+bpf-ci@kernel.org
To: andrii@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 00:13:21 +0000 (UTC)

--===============3798828678189222425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> index b7c18d590b99..5a1e08d39a06 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c

[ ... ]

> @@ -100,6 +128,7 @@ static void test_file(struct bpf_link *link, struct memcg_query *memcg_query)
>
>  static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
>  {
> +	int retries = 0;
>  	size_t len;
>  	int fd;
>
> @@ -113,12 +142,18 @@ static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
>  	if (!ASSERT_OK_FD(fd, "memfd_create"))
>  		return;
>
> +retry:
>  	if (!ASSERT_OK(fallocate(fd, 0, 0, len), "fallocate"))
>  		goto cleanup;
>
>  	if (!ASSERT_OK(read_stats(link), "read stats"))
>  		goto cleanup;
>
> +	if (!memcg_query->nr_shmem && ++retries < MEMCG_STAT_RETRIES) {
> +		usleep(MEMCG_STAT_RETRY_DELAY_US);
> +		goto retry;
> +	}
> +
>  	ASSERT_GT(memcg_query->nr_shmem, 0, "final shmem value");
>
>  cleanup:

Does the retry loop in test_shmem actually regenerate stat updates the way
test_anon, test_file, and test_pgfault do?

The retry: label sits above the fallocate() call, and nothing inside the
loop tears down the allocation. From the second iteration on, the range is
already populated. shmem_fallocate() in mm/shmem.c (mode 0 path) walks
each index with shmem_get_folio(..., SGP_FALLOC), every index becomes a
page-cache hit, and no new charge or NR_SHMEM/NR_FILE_PAGES delta gets
posted to vmstats->stats_updates.

So vmstats->stats_updates stays where the first pass left it (around 1-4k
units on the 128-CPU host the commit message mentions), which is well
under the 64 * 128 = 8192 threshold. That leaves
memcg_vmstats_needs_flush() returning false, and
bpf_mem_cgroup_flush_stats() exiting without flushing.

test_anon, test_file, and test_pgfault all munmap and then remap+refault
1024 pages on each iteration, posting a fresh ~2k abs() worth of deltas,
so they can reach both mechanism (a) the periodic flusher and mechanism
(b) crossing MEMCG_CHARGE_BATCH * num_online_cpus(). test_shmem appears
to depend entirely on stats_flush_dwork landing inside the 15 x 250ms =
3.75s window.

That is still better than the original single-pass behavior, but on a
large, mostly-idle host with NOHZ, deferrable timers (which
stats_flush_dwork is, per mm/memcontrol.c DECLARE_DEFERRABLE_WORK) may
not fire reliably while the machine is idle.

Would moving retry: above memfd_create(), or punching a hole with
FALLOC_FL_PUNCH_HOLE after the usleep() and before re-fallocating, give
test_shmem the same regeneration the other three subtests have? As the
commit message notes for nr_anon_mapped, the hole punch would need to come
after the sleep so the flusher observes the allocated state.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31851044465
--===============3798828678189222425==--
