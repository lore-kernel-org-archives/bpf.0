Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F8538D8D;
	Tue, 13 Oct 2026 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906817; cv=none; b=mAgEmqBCR4KA+DqArH0eJ1uTOdV/Dj9i/mlK9ynQQ5JF2IQMjD1LurZsip28SrSoliA68jEGEDzPOGf1KbTKV2BnUggcdZgp4BxmxuuhYWDmoL4m0f1lkD5UerthjxkAsfycP6+jbnVqIVmGj7gZsgDrPjmHvqwfkA0daeVgCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906817; c=relaxed/simple;
	bh=qfQUZEh2sESHeWPUpY1F+k772DD7PHkI75Pcv53unAM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ofWuWCYx1VOWiasl+FOpi+qnGBGFVg15+3A1LlPzmb5Q2MAx2S1GZaT6/kiAzpxYGc//hrVl4RRmAoiSTiOMjc6ASw7AYXb3gcXnlTUPOIp1YKRsbBWjxoTOdVC8iONvRNwUDKML0YwChXwMlU7i2wccYK8/ChmbAjkdy7FX0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwDprXnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwDprXnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931D41F000FF;
	Tue, 13 Oct 2026 15:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906815;
	bh=KKFRKnJNA4e6WTvE4Eo00GGQSiYEZUvNZDEkd+4NwMI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fwDprXnl1rwOp0YkIrxkz9CzlNGWAFNPzmG2cuvNq4viZzrZCGsGOCUI2SYHtxb03
	 hY7qZYrc8mAVnKp7FKvM/p2RHk0g5lQ7IQ/SBqjroN3JRWWfsiChOO4498J3o3OO+3
	 vUTuH5agHWyqdNA7HY6u4DPyl9klONOMQP/DdmBm4hBDfNVNYFptD5XUhnUfGYqQL1
	 Q2HbL0+kiAh8h65hko+IbxzsDzW+nFAS1FClj7gtj3+Suw/1V3hBaoIqMLKGm+zcDO
	 p2YH4wpPYEkmfUFRtx9LuQ47gUBee+yJOsvCWbMYK7aOLy43IohDUN2r+1SvkPyZXR
	 AJrVr3ZceAWcQ==
Content-Type: multipart/mixed; boundary="===============6757246679941720198=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ba00839fdba6a3a8c0f6061d38f6036efdcc806b21c73c2a78c750d4f4a2cbd3@mail.kernel.org>
In-Reply-To: <20261013151621.1526699-1-listout@listout.xyz>
References: <20261013151621.1526699-1-listout@listout.xyz>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Add tests for memcg kfuncs
From: bot+bpf-ci@kernel.org
To: listout@listout.xyz,bpf@vger.kernel.org
Cc: bdas@suse.de,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,jp.kobryn@linux.dev,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 13 Oct 2026 15:53:33 +0000 (UTC)

--===============6757246679941720198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for memcg kfuncs

TL;DR:
- Test issue: the "reclaim clamped" upper-bound assertion in test_reclaim()
  likely fails, since only the reclaim request is clamped, not the result;
  commit message is also inaccurate
- Minor: silent test__skip() with no message

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/memcg_kfuncs.c
> new file mode 100644
> index 000000000000..4022d97dc1a9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_kfuncs.c

[ ... ]

> +static int alloc_pagecache_or_skip(size_t size)
> +{
> +	int fd;
> +
> +	fd = alloc_pagecache(size);
> +	if (fd == -EOPNOTSUPP) {
> +		test__skip();
> +		return -1;
> +	}

A subsystem pattern flags this as potentially concerning: a test that skips
silently with no message should be reported.

When the working directory cannot back a reclaimable O_TMPFILE (no O_TMPFILE
support, or the cwd is on tmpfs), the memory_events and reclaim subtests are
marked skipped through test__skip() and nothing is printed.  test__skip()
only sets the skipped flag:

    void test__skip(void)
    {
        if (env.subtest_state)
            env.subtest_state->skipped = true;
        else
            env.test_state->skip_cnt++;
    }

So someone reading a SKIP for memcg_kfuncs/memory_events or
memcg_kfuncs/reclaim cannot tell why it was skipped.  The arena_memcg test
that this helper resembles prints "%s:SKIP:no disk-backed O_TMPFILE in cwd"
before calling test__skip().

On the other side, this is minor: the skip is correctly a skip rather than a
failure, and the commit message documents the skip condition.

Could a similar message be printed here before test__skip()?

[ ... ]

> +static void test_reclaim(struct memcg_kfuncs *skel)
> +{
> +	long ret = 0;
> +	int fd, i;
> +
> +	fd = alloc_pagecache_or_skip(PAGECACHE_SIZE);
> +	if (fd < 0)
> +		return;
> +
> +	/* Ask for more than one batch to check the clamp. */
> +	for (i = 0; i < RECLAIM_RETRIES && ret <= 0; i++)
> +		ret = do_reclaim(skel, 4 * MEMCG_CHARGE_BATCH * page_size, 0);
> +
> +	ASSERT_GT(ret, 0, "reclaimed");
> +	ASSERT_LE(ret, MEMCG_CHARGE_BATCH * page_size, "reclaim clamped");
                    ^^^^

Does the "reclaim clamped" assertion hold?  bpf_proactive_reclaim() only
clamps the reclaim target:

    nr_pages = min(size / PAGE_SIZE, (unsigned long)MEMCG_CHARGE_BATCH);
    nr_reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages, ...);
    return nr_reclaimed * PAGE_SIZE;

Nothing limits what try_to_free_mem_cgroup_pages() actually returns to that
target.  do_try_to_free_pages() checks sc->nr_reclaimed >= sc->nr_to_reclaim
only after each full priority pass:

    do {
        ...
        shrink_zones(zonelist, sc);
        if (sc->nr_reclaimed >= sc->nr_to_reclaim)
            break;
        ...
    } while (--sc->priority >= 0);

In the classic LRU path, shrink_lruvec() checks a local nr_reclaimed
(starting at 0) against the full sc->nr_to_reclaim, so one pass can add up
to the whole target on top of what earlier passes already reclaimed.

The MGLRU path is the same: try_to_shrink_lruvec() calls should_abort_scan()
only after each evict_folios() batch of up to MIN_LRU_BATCH (64) pages.
Both paths compute the per-pass scan target as lruvec_size >> priority.

With the 32MB (8192 x 4K pages) of clean page cache that test_reclaim()
creates, and swappiness 0 (SCAN_FILE), priorities 12 through 8 reclaim
2 + 4 + 8 + 16 + 32 = 62 pages.  That is below nr_to_reclaim = 64, so the
loop drops to priority 7.  There, nr[LRU_INACTIVE_FILE] = 64 and the pass
reclaims another 64 pages, for a total of about 126 pages (~504KB).
ASSERT_LE(ret, 64 * page_size) then fails.

For any page cache size around 32MB, the running total jumps from at most 63
pages straight past 64, so this is not a rare edge case.  Large page cache
folios make it worse: isolate_lru_folios() takes a whole folio even when
nr_to_scan is smaller, so a single folio bigger than 64 pages already
exceeds the bound in the first pass.  The same arithmetic applies with 64K
pages.

The commit message says "bpf_proactive_reclaim() reclaims clean page cache
and the result is clamped to MEMCG_CHARGE_BATCH pages", but only the request
is clamped, not the result.  The kfunc's own kernel-doc describes @size as
the amount to reclaim (clamped), not as an upper bound on the return value.

Should the upper-bound assertion be dropped or relaxed, and the commit
message fixed?

> +	ASSERT_EQ(ret % page_size, 0, "reclaim page aligned");
> +
> +	close(fd);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38421980805
--===============6757246679941720198==--
