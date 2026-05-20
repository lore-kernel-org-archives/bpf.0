Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1993438B3
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779236779; cv=none; b=VzbtmbvE5k01yEoqEaYijUHjWPPV29vaEryEdxjzIGzRzh4JyZWOqDMP69AFyVBXT0X6uXjSYDjPpwqb5Icbg0cNOOqN6JLtgNi7M0x3dxD6w08H5+2uPAaLQsKPfkHnflRQB2T/lgRzJuoisR1FWw77WeklAYIAmqCKjzjcn8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779236779; c=relaxed/simple;
	bh=Q+peTABWxM1cV1Eu78eIvumQeHvhw0on1PjZ2G8dQGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxXKHueysuAufWp6qSuzDeGrwORiKD/L+A2ud0ckcD76Aep/N5s7HNCK6MPC+gWCyUEONmzBFQxTo9FtMOBQNYmhuobtlzXJcl91CwIGnNp/N7it+/Q1RHv+kvufBSX540ZMGnAsqpeA+92R27hWpxAe55HplJoSaP53MU6P9BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OLrF7KMt; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OLrF7KMt"
Date: Tue, 19 May 2026 17:25:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779236775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXDU6B2AA3RB0txN0ki89n2lvFpNNO8zaLnzqeinUg8=;
	b=OLrF7KMtj50veG643eNyr2lzRQOg7JsIG8srMCf4tY455E1OmvwlHpXzWONg5v+uH5B5R2
	OZBnFJoQtWCvlneEjfR+SUadvDufF+4pVfEsj4EElQQLmX/M+1R/AXRynCAKxJC1G/FR+I
	ltMpMacaE/nar2QGE8P1wkSG8GovLQQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Amery Hung <ameryhung@gmail.com>
Subject: Re: [RFC PATCH bpf-next 02/12] bpf: Make struct_ops tasks_rcu grace
 period optional
Message-ID: <2026520006.6Mm9.martin.lau@linux.dev>
References: <20260519215841.2984970-3-martin.lau@linux.dev>
 <20260519225421.3CBCC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519225421.3CBCC1F000E9@smtp.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, May 19, 2026 at 10:54:20PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] The patch incorrectly skips the Tasks RCU grace period (`synchronize_rcu_tasks()`) before freeing executable trampoline memory for all `struct_ops` except `tcp_congestion_ops`, leading to Use-After-Free of executable memory.
> - [High] RCU-001 violation: `bpf_struct_ops_map_dissoc_progs()` removes the map from `prog->aux->st_ops_assoc` after the regular RCU grace period has already completed, leading to a Use-After-Free.
> --
> 
> commit 85a451ad8aefbb364a1840344e08d2f34596b96c
> Author: Martin KaFai Lau <martin.lau@kernel.org>
> 
> bpf: Make struct_ops tasks_rcu grace period optional
> 
> This commit makes the tasks RCU grace period optional during struct_ops map
> freeing. It introduces a map_free_pre_rcu callback to remove ksyms before the
> regular RCU grace period. The tasks RCU grace period is now only explicitly
> requested by tcp_congestion_ops.
> 
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index 08791180d71d9..28eab24ef0ed0 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
> > @@ -996,24 +1005,8 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
> >  
> >  	bpf_struct_ops_map_dissoc_progs(st_map);
> 
> [Severity: High]
> Does this violate the RCU remove-before-reclaim rule?
> 
> Because map->free_after_rcu_gp is set to true in bpf_struct_ops_map_alloc(),
> the regular RCU grace period occurs before bpf_struct_ops_map_free() is called.
> Leaving bpf_struct_ops_map_dissoc_progs() here means the map is removed
> from prog->aux->st_ops_assoc after the grace period has already finished.

After the grace period finished, all struct_ops's bpf prog has
finished running

> 
> Could a concurrent execution of the BPF program acquire the RCU read lock, read
> the still-valid aux->st_ops_assoc pointer, and then access the map after it is
> freed?

so this cannot happen.

afaik, for non struct_ops's prog, the st_ops_assoc has a refcnt.
[I could be wrong here. CC Amery.]

Overall, moving bpf_struct_ops_map_dissoc_progs to map_free_pre_rcu
could be a simpler read but don't think it is needed.

> 
> Should bpf_struct_ops_map_dissoc_progs() be moved to the new
> bpf_struct_ops_map_free_pre_rcu() callback instead?
> 
> > -	/* The struct_ops's function may switch to another struct_ops.
> > -	 *
> > -	 * For example, bpf_tcp_cc_x->init() may switch to
> > -	 * another tcp_cc_y by calling
> > -	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> > -	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> > -	 * and its refcount may reach 0 which then free its
> > -	 * trampoline image while tcp_cc_x is still running.
> > -	 *
> > -	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
> > -	 * to finish. bpf-tcp-cc prog is non sleepable.
> > -	 * A rcu_tasks gp is to wait for the last few insn
> > -	 * in the tramopline image to finish before releasing
> > -	 * the trampoline image.
> > -	 */
> > -	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
> > +	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
> > +		synchronize_rcu_tasks();
> >  
> >  	__bpf_struct_ops_map_free(map);
> >  }
> 
> [Severity: Critical]
> Does skipping the Tasks RCU grace period for other struct_ops cause a
> use-after-free of executable trampoline memory?

I don't think so. Other subsystems using struct_ops wait for
the bpf prog finished running in unreg().

Note that in general this should only matter to the bpf-tcp-cc's struct_ops prog
that does a bpf_setsockopt(TCP_CONGESTION) which triggers a bpf_map_put() on
its own running struct_ops's map refcnt.

> 
> All struct_ops programs are executed via dynamically generated trampolines. When
> the program returns, the RCU read lock is dropped and preemption is re-enabled.
> If a task is preempted while still executing the trampoline epilogue, the
> regular RCU grace period will not wait for it.
> 
> Without the Tasks RCU wait, could the executable trampoline image be freed
> prematurely, causing preempted tasks to execute freed memory when they resume?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260519215841.2984970-1-martin.lau@linux.dev?part=2
