Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCE43F8D9;
	Tue,  1 Sep 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278110; cv=none; b=vAAxos47xjOlUC3agxfegDp1fLnnuKRSXcV5TRRCfK6KrRL+VR3saA8By8fUpYO4R9s74BD76qrFzPQUTOftPFViJlD55vipQPnZLs72TBGzNF+iYgx8D63diCu/JBBWg7SqIjDlEspK1gj2+gLhXD+bWFJI4T10ktq9EsIgwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278110; c=relaxed/simple;
	bh=+cvSvCkkqP662yS/AR9AoUHdBIsRRO9+2MZ/BbHAYcI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=goz7/Jaf4ISmsYsuMcfHf7Eo9DZbVZ3OKRvRhswQR7qPuxZk02iWj5LF2tDV5ZSbQPFuITodo6+NHu/YWf8lJmg7IEYPPRj5S1Pfzk1wdMQJGE+Go2WLBAUsdXFIg5QY6cbmENFWrn/2KvAbvURB+U7kHHRAmoD0KtpmXJO6LHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgXYorBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgXYorBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886DF1F000E9;
	Tue,  1 Sep 2026 15:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788278108;
	bh=ftA9g+WU49btnuuvO1W5pBrsNdslwndWDFpC3e4w3L8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EgXYorBuQ5dXGLh1vd/XRPC3pwjmYclfmhgAiGCi1Lp/NctgkZF+fdovvhiui3EIT
	 vl4lC/DO6f72hbfwYAh+cPUZpVnUkla/8oOZz/US/foIgUfDtKCvKR8eqb8p7SuLI0
	 Zv747y6/5aBKzTraUuTWrfQOpVuWOuc5jedNDJKhm5KXZ2ikl25yREI2Uiwv29hBKl
	 rJOix2RhEZLxoSPczzOaoPd+ZDmXxObOLa/BksMUwYNd3hDmBPCWnM3eJsORYpFeVg
	 xAIT81bPmUWC4wrjhqqknZ04S+umWOslllW+0mOG18vsWeDuUi8Ri9NuXWqlz1xHKM
	 +AB+koY2XiGfQ==
Content-Type: multipart/mixed; boundary="===============6160038322550667007=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c846615ea25cf371f04302e136ce4b4dc50224fed1df1b1063afc94ecfc711db@mail.kernel.org>
In-Reply-To: <20260901150307.3474349-1-pulehui@huaweicloud.com>
References: <20260901150307.3474349-1-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf v3] bpf: Fix UAF due to concurrent consumption of ttrace lists in alloc_bulk
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,houtao@huaweicloud.com,leon.hwang@linux.dev
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,pulehui@huawei.com,pulehui@huaweicloud.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 15:55:07 +0000 (UTC)

--===============6160038322550667007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> This is expected because, as noted in commit 57b23c0f612d ("bpf: Retire
> rcu_trace_implies_rcu_gp()"), an RCU Tasks Trace GP currently implies
> (and will continue to imply in the future) a normal RCU GP. Since
> alloc_bulk() runs in an RCU read-side CS (!PREEMPT_RT runs in IRQ
> context, PREEMPT_RT runs with guard(rcu)), an RCU Tasks Trace GP cannot
> complete while alloc_bulk() is accessing the list.

Is this claim about the RCU Tasks Trace GP accurate? Looking at the SRCU
implementation, synchronize_rcu() sits in the middle of the SRCU scan
(kernel/rcu/srcutree.c srcu_readers_active_idx_check()), not at the end.

An RCU GP is only required to wait for read-side critical sections that
were already in progress when the GP started. Once a CPU reports its
quiescent state, a new hardirq handler on that CPU does not delay the GP.
So an alloc_bulk() that starts after the synchronize_rcu() call cannot
hold off the RCU Tasks Trace GP at all.

Even if the GP could not complete during alloc_bulk(), that would not
prevent the callback from running during alloc_bulk(). Callbacks are
invoked asynchronously after the GP ends (srcu_invoke_callbacks workqueue
in current kernels, or rcu_tasks_invoke_cbs in the 6.6 kernel that
produced the splat).

The race diagram three paragraphs later shows __free_rcu executing
concurrently with alloc_bulk's llist_del_first, which would not be
possible if the statement above were true.

Would it be more accurate to say that RCU read-side protection is not the
missing ingredient here, but rather mutual exclusion between the two
llist consumers?

> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index e9662db7198f..5927943c765a 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c

[ ... ]

> @@ -214,25 +215,25 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
>  	gfp = __GFP_NOWARN | __GFP_ACCOUNT;
>  	gfp |= atomic ? GFP_NOWAIT : GFP_KERNEL;
>
> -	for (i = 0; i < cnt; i++) {
> -		/*
> -		 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
> -		 * done only by one CPU == current CPU. Other CPUs might
> -		 * llist_add() and llist_del_all() in parallel.
> -		 */
> -		obj = llist_del_first(&c->free_by_rcu_ttrace);
> -		if (!obj)
> -			break;
> -		add_obj_to_free_list(c, obj);
> -	}
> -	if (i >= cnt)
> -		return;
> +	scoped_guard(raw_spinlock_irqsave, &c->lock) {
> +		for (i = 0; i < cnt; i++) {
> +			/*
> +			 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
> +			 * done only by one CPU == current CPU. Other CPUs might
> +			 * llist_add() and llist_del_all() in parallel.
> +			 */
> +			obj = llist_del_first(&c->free_by_rcu_ttrace);
> +			if (!obj)
> +				break;
> +			add_obj_to_free_list(c, obj);
> +		}
>
> -	for (; i < cnt; i++) {
> -		obj = llist_del_first(&c->waiting_for_gp_ttrace);
> -		if (!obj)
> -			break;
> -		add_obj_to_free_list(c, obj);
> +		for (; i < cnt; i++) {
> +			obj = llist_del_first(&c->waiting_for_gp_ttrace);
> +			if (!obj)
> +				break;
> +			add_obj_to_free_list(c, obj);
> +		}
>  	}
>  	if (i >= cnt)
>  		return;

The comment moved inside the new critical section still states the
lockless rationale:

    /*
     * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
     * done only by one CPU == current CPU. Other CPUs might
     * llist_add() and llist_del_all() in parallel.
     */

The last sentence asserts that concurrent llist_del_all() is fine.
According to include/linux/llist.h, the del_first x del_all combination
requires a lock, and the commit message's first race diagram shows exactly
this combination producing the KASAN splat.

Should this comment be updated to reflect that c->lock now serializes
against __free_rcu() and the draining branch of do_call_rcu_ttrace(),
rather than asserting that lockless operation is safe?

The related comments in enque_to_free() ("Nothing races to add to
free_by_rcu_ttrace list.") and drain_mem_cache() ("Except for
waiting_for_gp_ttrace list, there are no concurrent operations on these
lists") may also need updates, though they are outside this diff.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33525009657
--===============6160038322550667007==--
