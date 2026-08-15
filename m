Received: from mta0.migadu.com (out-155.mta0.migadu.com [91.218.175.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A66F305E1F
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 05:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786773005; cv=none; b=LjvUQMk7rtJJlUbayFik5ENtgYCbI5BiP8kifxEY2rfGi14BiEG26u8fo2J0n+xQoFKccYovLWxR2DaKUjT9MFNtE4frxeKWWfZhNKW1rXV8nu6ESjsrb/6vshpkwRK1dXw4YHsiWE2aZU7cNqWbBcx5qTGK7elfY3ziHQ/aQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786773005; c=relaxed/simple;
	bh=S2DaLHJtGrxg+rAnTMD2ZN89R+9nnovpVGWwJdu9V20=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cWD4W0QqgRCgD2EbjqvA+3A6BgcpHnX2apdN2nM9El/MESMU9kC6f8eVzAiZpUtKEwc1oOxHMSoK1dRbW4yCK4NRE0aTDtF23+641HL6BUnhuYdb8UbkTX+nE6xVa1QvM0Ro4FcL6pTGiMKdMdFTYujlOogmdkTT3h/etOR/fo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tUMYG3NM; arc=none smtp.client-ip=91.218.175.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tUMYG3NM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=S2DaLHJtGrxg+rAnTMD2ZN89R+9nnovpVGWwJdu9V20=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786773001; v=1; x=1787377801;
 b=tUMYG3NMzedYZKM4Nr6+umU9EjNl9NQPB1FR8e7J/7voD8Lm5cNkEhj6Wl1fwe+DBQEhvGzw
 5ZHrtvAyK3LK6JP7h059RnXEH2d+23XcFrmgkQU4V1LEjdTrCKUl1pD6lnfCftMJhh7o9ZOpdH7
 kCByDtgTuEYQD9aFg2i1KKvg=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.1.116] (111.162.215.50)
	by smtp.migadu.com with ESMTPS id 3ecc13c41b46260c;
	Sat, 15 Aug 2026 05:50:00 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <3f1ce004-e259-4e72-a5f7-14a5050053bd@linux.dev>
Date: Sat, 15 Aug 2026 13:49:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, bpf@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext/scx_flatcg: Fix cvtime true-up on slice expiry
To: sashiko-reviews@lists.linux.dev
References: <20260815045905.3431991-1-cui.tao@linux.dev>
 <20260815051412.C8DA91F000E9@smtp.kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260815051412.C8DA91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/15 13:14, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Priority inversion in RB-tree due to unprotected cvtime wraparound in cgv_node_less().
> --
> 
> --- Patch [1]: [PATCH] sched_ext/scx_flatcg: Fix cvtime true-up on slice expiry ---
> commit c84c79d28fee1a17412c6846489091841b03f293
> Author: Tao Cui <cuitao@kylinos.cn>
> Date:   Sat Aug 15 04:59:05 2026 +0000
> 
>     sched_ext/scx_flatcg: Fix cvtime true-up on slice expiry
> 
> This commit fixes the cvtime true-up calculation in fcg_dispatch() when a
> cgroup's slice expires or its DSQ runs empty. It addresses a bug where the
> unsigned division by hweight was inverting the sign of the delta, causing
> massive jumps in cvtime_delta instead of minor corrections. The fix properly
> computes the delta as a signed value and uses fetch_and_add()/fetch_and_sub()
> to keep dividends positive.
> 
>> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
>> index 0fd214cc61dae..ddcf6bc03b11c 100644
>> --- a/tools/sched_ext/scx_flatcg.bpf.c
>> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> 
> [Severity: High]
> This is a pre-existing issue, but was not introduced by the patch under
> review. Since this file handles cvtime accounting, could the red-black tree
> comparison in cgv_node_less() suffer from priority inversion due to cvtime
> wraparound?
> 
> Looking at tools/sched_ext/scx_flatcg.bpf.c:cgv_node_less():
> 
> static bool cgv_node_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
> {
>         struct cgv_node *cgc_a, *cgc_b;
> 
>         cgc_a = container_of(a, struct cgv_node, rb_node);
>         cgc_b = container_of(b, struct cgv_node, rb_node);
> 
>         return cgc_a->cvtime < cgc_b->cvtime;
> }
> 
> If a cgroup with the lowest possible weight (1) advances its cvtime rapidly,
> a 64-bit nanosecond counter could wrap around in approximately 3.25 days of
> continuous execution.
> 
> When a cgroup's cvtime wraps to a small value (e.g., 100) while other cgroups
> are near the 64-bit maximum, the standard < operator will evaluate
> 100 < (2^64 - 1000) as true.
> 
> Would this place the wrapped cgroup permanently at the front of the tree and
> completely starve other cgroups? Should this use a wraparound-safe comparison
> like time_before64() instead, similar to the time_before() usage elsewhere
> in the scheduler?
> 
Right, the comparison is not wraparound-safe, and CFS compares
vruntimes with (s64)(a - b) < 0 for the same reason. Hard to reach in
practice though: cgrp_cap_budget() clamps each node's cvtime to within
cvtime_now - max_budget, so wrapping needs an extreme weight ratio held
for days. Pre-existing either way, and with the true-up fixed cvtime
no longer collects garbage, so this patch only makes it less likely.

If we want to close it, (s64)(a->cvtime - b->cvtime) < 0 would do it,
as a separate patch.

> [ ... ]
> 

