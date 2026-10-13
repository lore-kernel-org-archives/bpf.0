Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D751EDFF;
	Tue, 13 Oct 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910758; cv=none; b=GdMCD/SNXqTcjjxaIsnTjqwyq8jrynwkkI/VLChemtXSMBM0VgHecrk4Y5Ysz7Km+eAkVZAgl23puq9PUwLcF0l2NeTrjWt7p6sbMQMFSk+g2OQz4kgaR7pTkaApR5a65hEWLKKtc+BhOYo/IFYL+2Lz9UtAYKoNQBEBDOxJ280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910758; c=relaxed/simple;
	bh=lEe7KbytEHzaEoCODO1wTdqBvTA4GasLhTbtZ7LMJfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4mRUrCpIWgOHDDTwesTEx2dlAv8ZwGRnmJkIJ7Qi3gU3ed7XUSq7rsW0naeRne+/5oGiviCZ8ulcVbgJv/A+mjRWJepfibi4AbwMCXbKvSxLA4nrRivcwmmvJy09tq/0/vE7J5aRhUAnClUYAVPIBmjkc3qgK6j4K8QW81yZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j40t64msCz8vLc;
	Tue, 13 Oct 2026 18:59:10 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=listout@listout.xyz
Date: Tue, 13 Oct 2026 22:29:00 +0530
From: Brahmajit Das <listout@listout.xyz>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, bdas@suse.de, andrii@kernel.org, 
	eddyz87@gmail.com, ihor.solodrai@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, jp.kobryn@linux.dev, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Add tests for memcg kfuncs
Message-ID: <as5irmeQHNMe6vzT@neptune>
References: <20261013151621.1526699-1-listout@listout.xyz>
 <ba00839fdba6a3a8c0f6061d38f6036efdcc806b21c73c2a78c750d4f4a2cbd3@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba00839fdba6a3a8c0f6061d38f6036efdcc806b21c73c2a78c750d4f4a2cbd3@mail.kernel.org>
X-Rspamd-Queue-Id: 4j40t64msCz8vLc

On 13.10.2026 15:53, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Add tests for memcg kfuncs
> 
> TL;DR:
> - Test issue: the "reclaim clamped" upper-bound assertion in test_reclaim()
>   likely fails, since only the reclaim request is clamped, not the result;
>   commit message is also inaccurate
> - Minor: silent test__skip() with no message
> 
...
> So someone reading a SKIP for memcg_kfuncs/memory_events or
> memcg_kfuncs/reclaim cannot tell why it was skipped.  The arena_memcg test
> that this helper resembles prints "%s:SKIP:no disk-backed O_TMPFILE in cwd"
> before calling test__skip().
> 
> On the other side, this is minor: the skip is correctly a skip rather than a
> failure, and the commit message documents the skip condition.
> 
> Could a similar message be printed here before test__skip()?
> 
> [ ... ]
> 
> > +static void test_reclaim(struct memcg_kfuncs *skel)
> > +{
> > +	long ret = 0;
> > +	int fd, i;
> > +
> > +	fd = alloc_pagecache_or_skip(PAGECACHE_SIZE);
> > +	if (fd < 0)
> > +		return;
> > +
> > +	/* Ask for more than one batch to check the clamp. */
> > +	for (i = 0; i < RECLAIM_RETRIES && ret <= 0; i++)
> > +		ret = do_reclaim(skel, 4 * MEMCG_CHARGE_BATCH * page_size, 0);
> > +
> > +	ASSERT_GT(ret, 0, "reclaimed");
> > +	ASSERT_LE(ret, MEMCG_CHARGE_BATCH * page_size, "reclaim clamped");
>                     ^^^^

Will do, for both the O_TMPFILE and the missing memory controller case.

> 
> Does the "reclaim clamped" assertion hold?  bpf_proactive_reclaim() only
> clamps the reclaim target:
> 
>     nr_pages = min(size / PAGE_SIZE, (unsigned long)MEMCG_CHARGE_BATCH);
>     nr_reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages, ...);
>     return nr_reclaimed * PAGE_SIZE;
> 
> Nothing limits what try_to_free_mem_cgroup_pages() actually returns to that
> target.  do_try_to_free_pages() checks sc->nr_reclaimed >= sc->nr_to_reclaim
> only after each full priority pass:
> 
>     do {
>         ...
>         shrink_zones(zonelist, sc);
>         if (sc->nr_reclaimed >= sc->nr_to_reclaim)
>             break;
>         ...
>     } while (--sc->priority >= 0);
> 
> In the classic LRU path, shrink_lruvec() checks a local nr_reclaimed
> (starting at 0) against the full sc->nr_to_reclaim, so one pass can add up
> to the whole target on top of what earlier passes already reclaimed.
> 
> The MGLRU path is the same: try_to_shrink_lruvec() calls should_abort_scan()
> only after each evict_folios() batch of up to MIN_LRU_BATCH (64) pages.
> Both paths compute the per-pass scan target as lruvec_size >> priority.
> 
> With the 32MB (8192 x 4K pages) of clean page cache that test_reclaim()
> creates, and swappiness 0 (SCAN_FILE), priorities 12 through 8 reclaim
> 2 + 4 + 8 + 16 + 32 = 62 pages.  That is below nr_to_reclaim = 64, so the
> loop drops to priority 7.  There, nr[LRU_INACTIVE_FILE] = 64 and the pass
> reclaims another 64 pages, for a total of about 126 pages (~504KB).
> ASSERT_LE(ret, 64 * page_size) then fails.
> 
> For any page cache size around 32MB, the running total jumps from at most 63
> pages straight past 64, so this is not a rare edge case.  Large page cache
> folios make it worse: isolate_lru_folios() takes a whole folio even when
> nr_to_scan is smaller, so a single folio bigger than 64 pages already
> exceeds the bound in the first pass.  The same arithmetic applies with 64K
> pages.
> 
> The commit message says "bpf_proactive_reclaim() reclaims clean page cache
> and the result is clamped to MEMCG_CHARGE_BATCH pages", but only the request
> is clamped, not the result.  The kfunc's own kernel-doc describes @size as
> the amount to reclaim (clamped), not as an upper bound on the return value.
> 
> Should the upper-bound assertion be dropped or relaxed, and the commit
> message fixed?
> 

Right, only the request is clamped, and reclaim can overshoot it
(cgroup-v2.rst says as much for memory.reclaim). I'll drop the upper
bound and fix the commit message in v3.

> > +	ASSERT_EQ(ret % page_size, 0, "reclaim page aligned");
> > +
> > +	close(fd);
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38421980805


-- 
Regards,
listout
