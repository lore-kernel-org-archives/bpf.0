Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5C3B6BE3
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660887; cv=none; b=gm+n+gPapYSWtxMvlpDnlhwd8eC2fiOk82F6GjjwuqF9EFznnlmktkY3ON1rE1XAMtEvOqE4A5XWsvzilmlPRRhmM1acxxqIFGoUsfVn8Fl7crNqCcl/pTvrkbHnLb1sjkqW/YMwaUH3hzuqhZO3rkSFYKucOUYBVoQyaRmKcsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660887; c=relaxed/simple;
	bh=R2eBjJd7XGE4LSwt6ozZWk2pu8uqmNJJje5iQLPkgT4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HfkGQf9df5d42pEWWwLF6k4hozAQLkH3Ng0jH3+4BT0eoDwF9D1v5KJQuF6FQ6AP1Tcc/hpfXaZ2EyDqVCTltG3RfEiuRyj9NS5/s27GC6vgDYSRtHJrLl+/Uc1m9bCVvBGbhfPfMRRdgw2JokNU7uu402WoyosfTdKSl+0hZ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQXwO/sU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQXwO/sU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBF71F000E9;
	Thu, 13 Aug 2026 22:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786660885;
	bh=kygdAYZiEQicm9Zt5ImGwMMq7ARBGLelpb9fl4oeufo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PQXwO/sU7Re6waR6TTd91hctHQV2SnKbPM2QPLV7SPSiLFsOTVsdDgG9QXlsT9Psx
	 a3lWWwQYwvenBiZYNTaE+x2rP1N+qIEEhwyj1UlEUKmCyDoEylf0r6y0iBcygqIhmX
	 Vxhr0sm7mga+ntAzAcy1vs5K/Q+UiUCRP8jLv+fJC2dYj3fFprtHuTPhIh15f8oisy
	 I62gSQymqhWxeb5aZz++r+2x5DehySclqy+Ttm5P2NaJVQaTaevyv7f1MZhRKa4Pad
	 kHcwkbhTJV8ieFRnP2yjZt+4YsPB8oZnnpaTgNqobB1JUnXy5J3ktelv+PkSTJQJCN
	 9GgcubPUEhgRw==
Content-Type: multipart/mixed; boundary="===============3707216507657304471=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ebb663cb6d9f7ca359febac62c335a7ca04ab8dd4bde7592b7968c9f5723e1b4@mail.kernel.org>
In-Reply-To: <20260813213701.3116369-1-andrii@kernel.org>
References: <20260813213701.3116369-1-andrii@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Retry stat generation in cgroup_iter_memcg
From: bot+bpf-ci@kernel.org
To: andrii@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 22:41:25 +0000 (UTC)

--===============3707216507657304471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> index b7c18d590b993..37e2cf249be8a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> @@ -10,6 +10,17 @@
>  #include "cgroup_iter_memcg.h"
>  #include "cgroup_iter_memcg.skel.h"
>
> +/*
> + * memcg stats are cached per-cpu and only become visible once the periodic
> + * flusher runs (FLUSH_TIME, 2s), or once pending updates cross
> + * MEMCG_CHARGE_BATCH * num_online_cpus(). That threshold grows with the CPU
> + * count, so on a large machine a single pass does not reach it and
> + * bpf_mem_cgroup_flush_stats() returns without flushing anything. Retry for
> + * long enough to cover a flusher cycle.
> + */
> +#define MEMCG_STAT_RETRIES		16
> +#define MEMCG_STAT_RETRY_DELAY_US	(250 * 1000)
> +
>  static int read_stats(struct bpf_link *link)
>  {
>  	int fd, ret = 0;
> @@ -35,11 +46,13 @@ static int read_stats(struct bpf_link *link)
>
>  static void test_anon(struct bpf_link *link, struct memcg_query *memcg_query)
>  {
> +	int retries = 0;
>  	void *map;
>  	size_t len;
>
>  	len = sysconf(_SC_PAGESIZE) * 1024;
>
> +retry:
>  	/*
>  	 * Increase memcg anon usage by mapping and writing
>  	 * to a new anon region.
> @@ -53,6 +66,12 @@ static void test_anon(struct bpf_link *link, struct memcg_query *memcg_query)
>  	if (!ASSERT_OK(read_stats(link), "read stats"))
>  		goto cleanup;
>
> +	if (!memcg_query->nr_anon_mapped && ++retries < MEMCG_STAT_RETRIES) {
> +		munmap(map, len);
> +		usleep(MEMCG_STAT_RETRY_DELAY_US);
> +		goto retry;
> +	}
> +

Does unmapping before the sleep undermine the retry mechanism for gauge
counters?

Looking at NR_ANON_MAPPED behavior: page_remove_rmap() posts -1024 when
munmap() runs, cancelling the +1024 from the memset. Any flush that lands
during the 250 ms sleep sees 0 mapped pages. The region is only mapped for
the brief mmap+memset+read_stats window but unmapped for the full sleep.

The commit message says "sleeping in between, so that a flusher cycle is
always covered." But if the 2s periodic flusher fires while the region is
unmapped, won't mem_cgroup_stat_aggregate() fold the net zero into
memcg->vmstats->state and reset stats_updates to 0?

That would leave only the threshold path (stats_updates >
MEMCG_CHARGE_BATCH * num_online_cpus()), which relies on memcg_rstat_updated()
accumulating abs(val). Each pass contributes ~2048 (1024 for faults + 1024
for unmap), bounded by the 2s flush interval: ~8 passes = ~16k, versus a
threshold of 64 * num_online_cpus(). Could this still read 0 at 256+ CPUs?

Would keeping the mapping alive across the sleep and unmapping once at
cleanup ensure the periodic flusher sees +1024 instead?


>  	ASSERT_GT(memcg_query->nr_anon_mapped, 0, "final anon mapped val");
>
>  cleanup:
> @@ -61,6 +80,7 @@ static void test_anon(struct bpf_link *link, struct memcg_query *memcg_query)
>
>  static void test_file(struct bpf_link *link, struct memcg_query *memcg_query)
>  {
> +	int retries = 0;
>  	void *map;
>  	size_t len;
>  	char *path;
> @@ -76,6 +96,7 @@ static void test_file(struct bpf_link *link, struct memcg_query *memcg_query)
>  	fd = open(path, O_CREAT | O_RDWR, 0644);
>  	if (!ASSERT_OK_FD(fd, "open fd"))
>  		return;
> +retry:
>  	if (!ASSERT_OK(ftruncate(fd, len), "ftruncate"))
>  		goto cleanup_fd;
>
> @@ -88,6 +109,13 @@ static void test_file(struct bpf_link *link, struct memcg_query *memcg_query)
>  	if (!ASSERT_OK(read_stats(link), "read stats"))
>  		goto cleanup_map;
>
> +	if (!memcg_query->nr_file_pages && !memcg_query->nr_file_mapped &&
> +	    ++retries < MEMCG_STAT_RETRIES) {
> +		munmap(map, len);
> +		usleep(MEMCG_STAT_RETRY_DELAY_US);
> +		goto retry;
> +	}
> +

Does this retry condition allow early exit when only one counter is flushed?

The loop retries while BOTH nr_file_pages AND nr_file_mapped are zero, but
the assertions below expect BOTH to be non-zero. The two counters have
different lifetimes:

When munmap() runs, NR_FILE_MAPPED drops back to 0 (rmap gauge) but the
pages stay in the page cache so NR_FILE_PAGES keeps its +1024.

If the 2s periodic flusher fires during the 250 ms sleep between passes:

  mem_cgroup_stat_aggregate() folds the net per-cpu deltas
  -> memcg->vmstats->state: NR_FILE_PAGES = 1024, NR_FILE_MAPPED = 0
  -> stats_updates reset to 0

Then pass 2 does ftruncate at the same length (no-op), mmap+memset of
already-cached pages -> only NR_FILE_MAPPED +1024 pending, still below the
8192 threshold at 128 CPUs.

So memcg_page_state() returns nr_file_pages = 1024 (non-zero) and
nr_file_mapped = 0. The predicate `!nr_file_pages && !nr_file_mapped` is
false, loop exits, and ASSERT_GT(memcg_query->nr_file_mapped, 0) fails.

Since the unmapped window is 250 ms while the mapped window is just
mmap+memset+read_stats, won't the flusher land in the unmapped state with
high probability? Should this use || instead of && to retry while either
counter is zero?


>  	ASSERT_GT(memcg_query->nr_file_pages, 0, "final file value");
>  	ASSERT_GT(memcg_query->nr_file_mapped, 0, "final file mapped value");
>

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31747930892
--===============3707216507657304471==--
