Received: from mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356EA3CF690
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718930; cv=none; b=koKTJzTVeiGCg6UmkfXbUoXzFsr0yKCr2Y5valG103qS0d99xY6tnrMDAp13xbnkAevrHMV0UCJvCj5AozuiNo/E8A6lJI2tzt7iLgLcetP4rdIu63Z/5CgjYy84g83vghrhld7bhsSCl7o2SIZihm7uABaa1A/DX1R5+9AbJiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718930; c=relaxed/simple;
	bh=GHIzj6BHIyXzI9iz97ChDhrFMa0zf+N9Qaq5cFwiLzc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ujVFutB7zY4NjmasBJnL5IH4itUq8ZTE0nJF/9hZqWzlI60tin9maBYX1d7GhSDumoQAv8jB15616H64QNtf3zyiIAOYGMHNWJSRpkSMcaqRhiX6pLNqK6dKNE0F6cWdZCXDpoQtUm7M+JQzOEGSni/XaODEUB3xsLW6fs+8qI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EA7Tcts5; arc=none smtp.client-ip=95.215.58.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EA7Tcts5"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GHIzj6BHIyXzI9iz97ChDhrFMa0zf+N9Qaq5cFwiLzc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786718925; v=1; x=1787323725;
 b=EA7Tcts56eIW65AuTXuo5bnfBrljT3kQ7X31sg8TiHmCD9gNHNLPryeVRKCvwCv9kIZIE+4B
 DMQX6v2Y3Ka5uXslHp3qLdwRzZQU9TCoJfZ1/CYCn931uMQIAQVa02voyCpnKzHTnAhT6p/yADe
 eZ70jEyiAjf2fGwaSfd+ntUs=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.1.116] (111.162.215.50)
	by smtp.migadu.com with ESMTPS id f9f3cc7728ab931f;
	Fri, 14 Aug 2026 14:48:45 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <80d78aac-7fc8-4c14-a2ae-419297d953f7@linux.dev>
Date: Fri, 14 Aug 2026 22:48:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, arighi@nvidia.com, changwoo@igalia.com,
 suzhidao@xiaomi.com, yphbchou0911@gmail.com, zhaomengmeng@kylinos.cn,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] sched_ext/scx_flatcg: expire cached hweights on weight
 changes
To: tj@kernel.org, void@manifault.com
References: <20260814144116.2767304-1-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260814144116.2767304-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/8/14 22:41, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> fcg_cgroup_set_weight() updates cgc->weight and the parent's
> child_weight_sum but doesn't bump hweight_gen, so the hweights cached by
> cgrp_refresh_hweight() stay stale until some task activation bumps the
> generation. For cgroups whose tasks never go through a 0->n runnable
> transition (e.g. persistently busy ones), a cpu.weight change never
> propagates to scheduling at all.
> 
> Bump hweight_gen on weight changes so the next refresh recomputes with
> the new weight.
> 
> Verified on a flatcg VM: a live cpu.weight 100->800 change on a busy
> cgroup leaves HWT update at 0 and the distribution unchanged; with it,
> hweight_gen increments and the refresh recomputes.
> 
Hello,

Some background on how I found this: I was running scx_flatcg in a VM
with a simple cgroup hierarchy to check how it distributes CPU under
different cpu.weight values --

    A (100) -> A1 (100), A2 (100)
    D (weight varies)

with 3 busy tasks in each leaf cgroup, 4 vCPUs, measuring cpu.stat
usage_usec deltas over 15 seconds.

D=200 gave D roughly 47%; D=800 gave 46% -- the distribution barely
responded to weight at all. That led me to the missing hweight_gen
bump, which this patch fixes.

But even with the fix applied, the distribution still doesn't follow
the documented compounding model. With D=800 (compounded share should
be 800/900 = 89%), D only gets around 49%. Removing the /2 in
cgrp_cap_budget()'s max_budget didn't help either (50%).

From what I can tell, the budget clamp is proportional to hweight, so
light cgroups get a very small budget and are clamped right behind the
cvtime leader, which keeps them competitive regardless of their
weight. Under saturation with persistently busy tasks, the
distribution compresses to near-equal no matter what the weights are.

Is this the intended behavior of the budget clamping, or should the
steady-state distribution converge to the compounded shares over time?
The header comment's model doesn't seem to hold in this scenario.

> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  tools/sched_ext/scx_flatcg.bpf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index 0fd214cc61da..2d178c2ecacc 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -605,6 +605,9 @@ void BPF_STRUCT_OPS(fcg_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
>  		pcgc->child_weight_sum += (s64)weight - cgc->weight;
>  	cgc->weight = weight;
>  	bpf_spin_unlock(&cgv_tree_lock);
> +
> +	/* expire cached hweights so the new weight propagates */
> +	__sync_fetch_and_add(&hweight_gen, 1);
>  }
> 
>  static bool try_pick_next_cgroup(u64 *cgidp)

