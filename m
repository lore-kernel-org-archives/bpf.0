Received: from mta1.migadu.com (out-36.mta1.migadu.com [95.215.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBAF33F5BC
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786794972; cv=none; b=F+IfBosTjWHKLpjNh4ST+guaAFsvoLqZTEP1ieSbCYFWWpmnRDehdQfFHvdvDJjFkOJIm4hI/l6uOJ38NXHKoHGM5k9N26/OvmMvOuXvhwmRZCmcz3QsR1EXPqwG0L6RFez9rZVn4YcOTQaQPTrbOvechZ6Sb/YayZSAJ8IkAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786794972; c=relaxed/simple;
	bh=YkLmU1NxiWB/vciVK99wUc8NOQwVA9xq2ClSCkxrLdg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ISFu+2kSw/yyfpNeoOG/HTTao4l+0p99a637uS+qZzmjP6PKHUTm1lvOiz8LLmQX99mnbkkRX2dOxJcamUMk4wksoY+AidODu0KcwIC6OOh507Bs6LgFgB/x+vN+74My29uMMIwmbD8hALH6f8KSSWP5rX5YVjHeXIXrLZUiEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DILQYcgL; arc=none smtp.client-ip=95.215.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DILQYcgL"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YkLmU1NxiWB/vciVK99wUc8NOQwVA9xq2ClSCkxrLdg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786794967; v=1; x=1787399767;
 b=DILQYcgLc7V1r9wYIblCS9C9niCRcXbzsLh3kxLfZlu03VGI6rAiB7kyse9oUp2y7vSJy9CI
 w1sONtfJgUwkDui1INLe3dfLZ4HOI7VUh2VKdahEDrwScUGJc+yYHgBCb4ANper1BJFdOjy5F8c
 Sj6C+SI4VH/aG9UhQyzvkh7E=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.1.116] (111.162.215.50)
	by smtp.migadu.com with ESMTPS id c2dba12a5636e28d;
	Sat, 15 Aug 2026 11:55:56 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <e707deeb-6253-4ea0-92de-ebd87f0da707@linux.dev>
Date: Sat, 15 Aug 2026 19:55:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, Tao Cui <cuitao@kylinos.cn>, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, suzhidao@xiaomi.com,
 yphbchou0911@gmail.com, zhaomengmeng@kylinos.cn, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext/scx_flatcg: expire cached hweights on weight
 changes
To: Tejun Heo <tj@kernel.org>
References: <20260814144116.2767304-1-cui.tao@linux.dev>
 <80d78aac-7fc8-4c14-a2ae-419297d953f7@linux.dev>
 <3432f79f1d8195a56a0b4fea53ceb099@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <3432f79f1d8195a56a0b4fea53ceb099@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/15 06:23, Tejun Heo 写道:
> Hello,
> 
> On Fri, Aug 14, 2026 at 10:48:35PM +0800, Tao Cui wrote:
>> Is this the intended behavior of the budget clamping, or should the
>> steady-state distribution converge to the compounded shares over time?
>> The header comment's model doesn't seem to hold in this scenario.
> 
> The clamp isn't the culprit. I reproduced your setup (3 busy tasks per
> leaf, 4 CPUs) and dug in.
> 
> The dominant factor is that D is runnable-task limited. At weight 800
> its compounded share is 3.55 CPUs but it only has 3 tasks, so 75% is
> the best it can do. Below that cap, the window granting loses more:
> whenever all three of D's tasks are already running and another CPU
> picks D, the pop from D's DSQ comes up empty, the cgv_node gets
> stashed and that CPU grants a full cgrp_slice_ns window to another
> cgroup. The loss scales with the window size. Measured D shares at
> weight 800:
> 
> 	3 tasks/leaf			55-59%
> 	3 tasks/leaf, 100ms slices	52%
> 	5 tasks/leaf			84-86%
> 
> Disabling the clamp entirely is the 59% above, so it barely matters.
> With enough runnable tasks per cgroup, the distribution converges to
> the documented compounding. The model holds, but only when no cgroup
> is runnable-task limited, and the window granting degrades sooner than
> per-task fair queueing would as that limit is approached. That's an
> inherent simplification of this example scheduler.
> 
> Separately, while digging into this, I found that the true-up in
> fcg_dispatch() is broken:
> 
> 	__sync_fetch_and_add(&cgc->cvtime_delta,
> 			     (cpuc->cur_at + cgrp_slice_ns - now) *
> 			     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));
> 
> In the CNS_EXPIRE case, now is past cur_at + cgrp_slice_ns, so the u64
> subexpression wraps. The multiplication preserves the two's complement
> encoding but the unsigned division by hweight destroys it, adding about
> 2^64 / hweight per expiry instead of a small correction. The sign is
> also inverted. The true-up should be actual minus charged, so the
> expiry overrun should be added and the CNS_EMPTY unused portion
> subtracted. Under saturation the budget clamp mostly masks the garbage,
> which is why the numbers above barely move with it fixed (the 86% in
> the 5 tasks/leaf row), but the accounting is broken all the same. The
> following fixes it and tests fine (BPF division is unsigned, keep the
> dividends positive):
> 
> 	s64 delta = now - cpuc->cur_at - cgrp_slice_ns;
> 
> 	if (delta >= 0)
> 		__sync_fetch_and_add(&cgc->cvtime_delta,
> 				     (u64)delta * FCG_HWEIGHT_ONE /
> 				     (cgc->hweight ?: 1));
> 	else
> 		__sync_fetch_and_sub(&cgc->cvtime_delta,
> 				     (u64)-delta * FCG_HWEIGHT_ONE /
> 				     (cgc->hweight ?: 1));
> 
> Care to send a patch?
> 
Hi, tejun

Thanks for the detailed walkthrough. I was chasing the clamp, but the
runnable-task limit and the window granting behavior explain it much
better, learned a lot from your analysis.

I sent a fix based on your suggestion, and saw it's been applied to
your tree:

  sched_ext/scx_flatcg: Fix cvtime true-up on slice overrun

  https://lore.kernel.org/all/20260815045905.3431991-1-cui.tao@linux.dev/

Kept your approach (s64 delta, keep dividends positive) and added
A/B numbers from the same VM setup in the commit message.

Looking forward to more of this while digging through sched_ext.

Thanks,
Tao

> Thanks.
> 
> --
> tejun

