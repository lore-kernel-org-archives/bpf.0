Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374288;
	b=Q8VL2i2nDrV5DEo1EdDelOSDccz+Md/2U4tilcnNjESl+nJ+bfS+DOi4WaSScnWAp93d
	 jTl7Cfho4vAyNToDgU8b/ODOPAKq/IuUWyzsfhdER5SojueqeBfZNaOuailHzcds2qZT/
	 fk8xtikzvidcnFMYJZBZh6QN0FC2M2eImhs4bra2gH7MuKiN09o5tDCch+yTtvcNn2hCl
	 4dL1TdcPrTboDgFaAApLAwKJJMmrz1xwzz+TlGhy5NewGjlSp0NYwT+MPCWRJ9IN8aWMF
	 FubtPZ7kMFSTAPuuCDR0f/YHf5tbE0/GwIxgvECKaGxzEdU3iMDGxLdH7o5naWhu+4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374288;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4E6KxAhNlFzENhgeIInuOXhEw9H++Tb+DYqZlBVUXzc=;
	b=h3M941qCSvdMUl9DIaKT6cf9mveIEcZwSC4ZXbRQji+01d3uTpkzRvqrrzFQB8KShTZs
	 KTfK9ptnbG5iW3QWTMeiNwRAgoqTXe17ZXu7z7UjwlIk5E1W5Wg+DRlQGO7HYXSLi7IKU
	 hub1h/fe63iHiNtqRpZ+5ChmBDdzZAPEgOAJuQqQvB8FCTB9RHDbbxUlBfieT8MAq+JMA
	 NShZldS979iBl1mf8x+B5CJsP6gl82VL74KKP/Po8NM/OrkigB/foMw+eU0WvVbydoGOj
	 BSyHd91ZasQ4SsABHHXj3ZgjGfR+IFdy96Y4tCdxJc6VgpzxDK1bINL1UBIRxkMr2gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XZHfbLZI;
	arc=none smtp.remote-ip=91.218.175.203
Received: from mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC8606A320
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16BC8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XZHfbLZI
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YWujpAd2POSHBZxj/UGItw4ULXL9YbFbrRMqy5m6l6A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794374282; v=1; x=1794979082;
 b=XZHfbLZI6xJ67cIrTmKahjhqrj9RX/I53nXXBC+DUHGpmm8/ix3WA02/xL2TsJAe3cDhnRmZ
 dCtUub/o5p6vPPlTI6QXEUnryTFfxKwh3blSvZiUa2tV+GewXSY0lXACzW9ra7S1sGPYvUZ7uVE
 WDeB564PSsvk5qEEOC0lrm+M=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 42174d712a9758ba;
	Wed, 11 Nov 2026 05:18:02 +0000
X-Mizu-Trace-ID: 42174d712a9758ba
X-Migadu-Flow: FLOW_OUT
Message-ID: <d7846fef-ba62-4c3e-9498-d3d685536df1@linux.dev>
Date: Wed, 11 Nov 2026 13:17:52 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, tj@kernel.org, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, liwanwu@kylinos.cn, zhaomengmeng@kylinos.cn,
 emil@etsalapatis.com, yphbchou0911@gmail.com, mingo@redhat.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 0/9] tools/sched_ext: robustness fixes from cold review
To: David CARLIER <devnexen@gmail.com>
References: <20261110125001.4167503-1-cui.tao@linux.dev>
 <CA+XhMqzQXn4r57b+CP-mryhat3rtg3bD2BaRLqjjqwEj1eJ-EA@mail.gmail.com>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <CA+XhMqzQXn4r57b+CP-mryhat3rtg3bD2BaRLqjjqwEj1eJ-EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, David,

在 2026/11/10 21:03, David CARLIER 写道:
> Hi Tao
> 
> On Tue, 10 Nov 2026 at 12:50, Tao Cui <cui.tao@linux.dev <mailto:cui.tao@linux.dev>> wrote:
> 
>     From: Tao Cui <cuitao@kylinos.cn <mailto:cuitao@kylinos.cn>>
> 
>     Hello,
> 
>     This series fixes nine robustness issues in the example schedulers
>     scx_pair, scx_flatcg, scx_qmap and scx_userland.
> 
>     scx_flatcg resets its stats baseline on restart (stale counters print
>     as u64 underflow garbage) and rejects a stats interval that puts
>     nanosleep in an error loop (a negative or non-finite -i busy-spins at
>     100% CPU). scx_pair stops aborting the scheduler when the dispatching
>     cgroup goes away mid-dispatch, gates attach on an interrupted
>     initialization instead of running with a half-built cgrp_q_arr, resets
>     pair_id on restart, and cleans up a dead busy-check whose fall-through
>     clears another cgroup's busy marker. scx_qmap documents the options it
>     actually accepts and resets its hier stats baseline on restart.
>     scx_userland bounds the batch against the dispatch buffer instead of
>     overflowing it 13ms in, and rejects batch size 0, which livelocks the
>     machine until the stall watchdog fires.
> 
>     Verified in qemu on tj/sched_ext for-next (5b740a72b55c), same
>     kernel and config with and without each patch, comparing stock and
>     patched binaries: a scx_flatcg restart prints six
>     u64-underflow garbage counters on stock and zeros with patch 1; a
>     non-finite -i busy-spins ~17k EINVAL lines in 3s on stock and is
>     rejected at parse time with patch 2; SIGINT storms abort 20/30
>     interrupted inits on stock with the scheduler never loading and exit
>     30/30 clean with patch 4; a scx_pair restart aborts 7ms in with a
>     stale pair_id on stock and runs clean for its full window with patch
>     5; an oversized scx_userland batch aborts 13ms in with "dispatch
>     buffer overflow" on stock and survives 25s with patch 9; and batch
>     size 0, which livelocks the machine until the stall watchdog fires
>     (spinner progress collapses to ~1%), is rejected immediately with
>     patch 8. Beyond the A/B pairs: the scx_pair cgid-cache churn window
>     is too narrow to drive (40 rounds clean on both binaries; patch 3 is
>     graded by inspection), the qmap synopsis diff shows exactly the three
>     added options (patch 6), and the hier stats baseline was verified with
>     a clang-23.1.5-built scx_qmap run through restart cycles (patch 7,
>     hier stats clean throughout).
> 
>     Based on sched_ext/for-next (5b740a72b55c).
> 
>     Tao Cui (9):
>       tools/sched_ext: scx_flatcg: Reset the stats baseline on restart
>       tools/sched_ext: scx_flatcg: Validate the stats interval
>       tools/sched_ext: scx_pair: Don't abort when the dispatching cgroup
>         goes away
>       tools/sched_ext: scx_pair: Don't attach after an interrupted
>         initialization
>       tools/sched_ext: scx_pair: Reset pair_id on restart
>       tools/sched_ext: scx_qmap: Add the missing options to the usage
>         synopsis
>       tools/sched_ext: scx_qmap: Reset the hier stats baseline on restart
>       tools/sched_ext: scx_userland: Check dispatch buffer slots before
>         inserting
>       tools/sched_ext: scx_userland: Reject batch size 0
> 
>      tools/sched_ext/scx_flatcg.c       |  7 ++++++-
>      tools/sched_ext/scx_pair.bpf.c     | 12 ++++++++++--
>      tools/sched_ext/scx_pair.c         | 14 ++++++++++++--
>      tools/sched_ext/scx_qmap.c         |  3 ++-
>      tools/sched_ext/scx_userland.bpf.c |  8 ++++++++
>      tools/sched_ext/scx_userland.c     |  5 +++++
>      6 files changed, 43 insertions(+), 6 deletions(-)
> 
>     -- 
>     2.53.0
> 
> 
> I might be missing something, but the cover letter mentions a scx_pair busy-check cleanup that isn't
> in the series, and the verification paragraph swaps patches 8 and 9 it seems.
> 
> hope it helps. 
You're right on both counts. Thanks for the careful read.

The busy-check sentence is a leftover. The series originally included
that cleanup, but I dropped it before posting because it became clear
the path it removed has no observable behavioral difference (the
would-be hijacking update always fails with -EBUSY anyway). I neglected
to update the cover letter accordingly.

The patch 8/9 swap is also just an editing mistake from the same late
rewrite of the verification paragraph.

Thanks,
Tao

