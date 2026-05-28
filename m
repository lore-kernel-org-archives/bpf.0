Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440F3314D2
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994775; cv=none; b=GC+6AenCXytqljMT8jfBs1bs+D6+4QuMQl1GordxxdsdG3Y6NnDdmEjSYA279b6/SuLLzJongRn0G935wavbh4+4j7y4yVPMjb93Bevxm9xYTrK0qd6jWLdAP/aOawbRZ6Nlbb8ZQNspgK2twY8JXPI0nWscJbcp4XlPHKjvEjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994775; c=relaxed/simple;
	bh=urhOZhdA3am7Vc8J+EHULU9i/4f2nw9X1MriqzKDsbs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=n4e9+AlMtooAnU1k+d4muCB73CuwL435ScO56F5kxOibhuf0GPOMCTpRDmVUZsFWkhp0TkC0Sf0nenJeezLif0dnGTUXckWfyWHGazHJ4/emPYkgSsWPEyBk+h4sARVr92XkxZwRpykQPnYE0MOcxJ0USJC2wdqlJbO8u00tFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuvxWfSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuvxWfSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6CD1F000E9;
	Thu, 28 May 2026 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779994774;
	bh=uqVPIqPvsYxUJme1pHFdqlw/LIOPZGeEcKVtkjJpUnU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UuvxWfSQqtN855aqgLibWsKiUbQPDDizkpB5M8BY2pLWP4S1c97qK6riXZMDnzT6Z
	 VZwzqGYrWPMYux2KxRfCIMP7L8x8PpqAv+PiGPQEAKFTNWZl6nHsxtHn1re7WYZLl5
	 3QBq396KdDJuiMqpjMGgFz7QFTwJ97aU9grxQdm7fDLJXXw3h0e+nNi2Zi+i91Eylz
	 vsyAY3jW7YUeqF+0bzrQIMEFyhipoc9SWNaayI2qWENV6vCqbwnuqEMFBVhADRMbtt
	 xZp//5/VaGknGg1eATHJNckBWWvvI+LA9hnDjs7TR07GfzS9qS1s9MbwHVsqO0tgBy
	 MfygswUpDYFZQ==
Content-Type: multipart/mixed; boundary="===============6132720174162550939=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6c1d35a0f52ae9bad90b65487a251c0cd0482d032920cfaf6f5790b104baa486@mail.kernel.org>
In-Reply-To: <20260528-lru_map_spin-v1-1-4f52223170cf@meta.com>
References: <20260528-lru_map_spin-v1-1-4f52223170cf@meta.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: Fix NMI/tracepoint re-entry deadlock on lru locks
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com
Cc: yatsenko@meta.com,syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com,syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 28 May 2026 18:59:34 +0000 (UTC)

--===============6132720174162550939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c

[ ... ]

> @@ -466,24 +478,36 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
>  	do {
>  		steal_loc_l = per_cpu_ptr(clru->local_list, steal);
>
> -		raw_spin_lock_irqsave(&steal_loc_l->lock, flags);
> -
> -		node = __local_list_pop_free(steal_loc_l);
> -		if (!node)
> -			node = __local_list_pop_pending(lru, steal_loc_l);
> -
> -		raw_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
> +		if (!raw_res_spin_lock_irqsave(&steal_loc_l->lock, flags)) {
> +			node = __local_list_pop_free(steal_loc_l);
> +			if (!node)
> +				node = __local_list_pop_pending(lru, steal_loc_l);
> +			raw_res_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
> +		}
>
>  		steal = cpumask_next_wrap(steal, cpu_possible_mask);
>  	} while (!node && steal != first_steal);
>
>  	loc_l->next_steal = steal;
>
> -	if (node) {
> -		raw_spin_lock_irqsave(&loc_l->lock, flags);
> -		__local_list_add_pending(lru, loc_l, cpu, node, hash);
> -		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
> +	if (!node)
> +		return NULL;
> +
> +	if (raw_res_spin_lock_irqsave(&loc_l->lock, flags)) {
> +		/*
> +		 * The local pending lock can't be acquired (rqspinlock AA
> +		 * or timeout). Return the stolen node to the per-CPU
> +		 * free_llist instead of orphaning it; the next pop_free on
> +		 * this CPU will pick it up.
> +		 */
> +		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
> +		bpf_lru_node_clear_ref(node);
> +		WRITE_ONCE(node->pending_free, 0);
> +		llist_add(&node->llist, &loc_l->free_llist);
> +		return NULL;
>  	}
> +	__local_list_add_pending(lru, loc_l, cpu, node, hash);
> +	raw_res_spin_unlock_irqrestore(&loc_l->lock, flags);

This implementation adds the free_llist recovery mechanism to handle
post-steal lock failures. The stolen node is published to the lockless
per-CPU free_llist when the local pending lock cannot be acquired, which
prevents the node leak that plagued Menglong's version.

Can you confirm that this recovery path covers all the node leak scenarios
identified in the October 2025 review? The commit message describes the
recovery mechanism, and the code shows nodes being added to free_llist on
post-steal lock failure, which should be picked up by subsequent
__local_list_pop_free calls.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26594280936
--===============6132720174162550939==--
