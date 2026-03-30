Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EB3BFE41
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865854; cv=none; b=ZUFVjF78n+dfXOBSaYpfA+fE0YPnri3ScA0cwNObL9hTfB38np4YFtGXOK1+ZABAcRI9tf3kOxldRh/poc2U2a1vgYf0Lgf8uMiPsGgiDtZOwWE9iqzLPNL8gtL67XQyRoRBTLfKYUHfvfBn3tAJIF3S+PGjd3gh1P6krUsBGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865854; c=relaxed/simple;
	bh=OtfA84Zj/lq2aOKKMUUoWBMSb65SaBxUhvRV8QaH+WI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFBBRU70ac9kWPF6NDLuQAgaTewcbNNRipMmIoONxiK5zJxl76NHJaKereY/OMNVoFdSlZuqZBQvUXwnA7wFPAhCwdzO8REOACsARh63MmKo6T1lDeIjIv3W7miP9U0EcHSPvSb8RHP5GWBozQ49NIrp8b1288SXS7Xne8bOXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1IskXkj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1IskXkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5DDC4CEF7;
	Mon, 30 Mar 2026 10:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774865854;
	bh=OtfA84Zj/lq2aOKKMUUoWBMSb65SaBxUhvRV8QaH+WI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=r1IskXkjoK1WLiUJfwMc5A4NXEtxnJ7DX7nlnI+rCD93nFZaVb9xrzknG4yeRBSaO
	 xPpTGoJBUcWgRCg7bmHMP/GWCMy1FeZ1OjXV1uFqFDC6HJf2XQ8IGFkauk3QmLllVa
	 /ptuK2Lmpzb04uCAJT5rnsRslcc5jetgQWQPtmHRz9zdY09hctz5BDFJc07tnWqMhp
	 XoBeC4xFXR/tlaBAUbHVbaw1hZ/1G9rF8yethinU6mKLfKVDe8QI4SXWAPcKQIiHAp
	 OK1pwOj+Rm9DSKMle/7pOaPqqZbqYwqyNL/X5duAfWosJXbrdFED6LV0eQwII27voM
	 mTOSodlZ4AYIQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf v1 2/2] bpf: Retire rcu_trace_implies_rcu_gp()
In-Reply-To: <20260330032124.3141001-3-memxor@gmail.com>
References: <20260330032124.3141001-1-memxor@gmail.com>
 <20260330032124.3141001-3-memxor@gmail.com>
Date: Mon, 30 Mar 2026 11:17:29 +0100
Message-ID: <m2341h1v0m.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> RCU Tasks Trace grace period implies RCU grace period, and this
> guarantee is expected to remain in the future. Only BPF is the user of
> this predicate, hence retire the API and clean up all in-tree users.

RCU Tasks Trace is now implemented on SRCU-fast and its grace period
mechanism always has atleast one call to synchronize_rcu() as it is
required for SRCU-fast's correctness (it replaces the smp_mb() that
SRCU-fast readers skip). So, RCU-tt GP will always imply RCU GP.

> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

A nit below about a stale comment.

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

> ---
>  include/linux/rcupdate.h | 12 ------------
>  kernel/bpf/core.c        | 10 ++++------
>  kernel/bpf/memalloc.c    | 33 ++++++++++-----------------------
>  kernel/bpf/syscall.c     | 24 ++++++------------------
>  4 files changed, 20 insertions(+), 59 deletions(-)
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 04f3f86a4145..bfa765132de8 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -205,18 +205,6 @@ static inline void exit_tasks_rcu_start(void) { }
>  static inline void exit_tasks_rcu_finish(void) { }
>  #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
>  
> -/**
> - * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply an RCU grace period?
> - *
> - * As an accident of implementation, an RCU Tasks Trace grace period also
> - * acts as an RCU grace period.  However, this could change at any time.
> - * Code relying on this accident must call this function to verify that
> - * this accident is still happening.
> - *
> - * You have been warned!
> - */
> -static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
> -

There is comment in helpers.c that needs to be dropped/updated:

kernel/bpf/helpers.c:1275:      /* rcu_trace_implies_rcu_gp() is true and will remain so */


>  /**
>   * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
>   *
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 7b675a451ec8..1984f061dcf4 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2641,14 +2641,12 @@ static void __bpf_prog_array_free_sleepable_cb(struct rcu_head *rcu)
>  {
>  	struct bpf_prog_array *progs;
>  
> -	/* If RCU Tasks Trace grace period implies RCU grace period, there is
> -	 * no need to call kfree_rcu(), just call kfree() directly.
> +	/*
> +	 * RCU Tasks Trace grace period implies RCU grace period, there is no
> +	 * need to call kfree_rcu(), just call kfree() directly.
>  	 */
>  	progs = container_of(rcu, struct bpf_prog_array, rcu);
> -	if (rcu_trace_implies_rcu_gp())
> -		kfree(progs);
> -	else
> -		kfree_rcu(progs, rcu);
> +	kfree(progs);
>  }
>  
>  void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 682a9f34214b..e9662db7198f 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -284,17 +284,6 @@ static void __free_rcu(struct rcu_head *head)
>  	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
>  }
>  
> -static void __free_rcu_tasks_trace(struct rcu_head *head)
> -{
> -	/* If RCU Tasks Trace grace period implies RCU grace period,
> -	 * there is no need to invoke call_rcu().
> -	 */
> -	if (rcu_trace_implies_rcu_gp())
> -		__free_rcu(head);
> -	else
> -		call_rcu(head, __free_rcu);
> -}
> -
>  static void enque_to_free(struct bpf_mem_cache *c, void *obj)
>  {
>  	struct llist_node *llnode = obj;
> @@ -326,12 +315,12 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>  		return;
>  	}
>  
> -	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> -	 * If RCU Tasks Trace grace period implies RCU grace period, free
> -	 * these elements directly, else use call_rcu() to wait for normal
> -	 * progs to finish and finally do free_one() on each element.
> +	/*
> +	 * Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> +	 * RCU Tasks Trace grace period implies RCU grace period, so pass
> +	 * __free_rcu directly as the callback.
>  	 */
> -	call_rcu_tasks_trace(&c->rcu_ttrace, __free_rcu_tasks_trace);
> +	call_rcu_tasks_trace(&c->rcu_ttrace, __free_rcu);
>  }
>  
>  static void free_bulk(struct bpf_mem_cache *c)
> @@ -696,20 +685,18 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
>  
>  static void free_mem_alloc(struct bpf_mem_alloc *ma)
>  {
> -	/* waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
> +	/*
> +	 * waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
>  	 * might still execute. Wait for them.
>  	 *
>  	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
>  	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
> -	 * to wait for the pending __free_rcu_tasks_trace() and __free_rcu(),
> -	 * so if call_rcu(head, __free_rcu) is skipped due to
> -	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
> -	 * using rcu_trace_implies_rcu_gp() as well.
> +	 * to wait for the pending __free_by_rcu(), and __free_rcu(). RCU Tasks
> +	 * Trace grace period implies RCU grace period, so all __free_rcu don't
> +	 * need extra call_rcu() (and thus extra rcu_barrier() here).
>  	 */
>  	rcu_barrier(); /* wait for __free_by_rcu */
>  	rcu_barrier_tasks_trace(); /* wait for __free_rcu */
> -	if (!rcu_trace_implies_rcu_gp())
> -		rcu_barrier();
>  	free_mem_alloc_no_barrier(ma);
>  }
>  
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ab61a5ce35af..dbba0a5fa96e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -941,14 +941,6 @@ static void bpf_map_free_rcu_gp(struct rcu_head *rcu)
>  	bpf_map_free_in_work(container_of(rcu, struct bpf_map, rcu));
>  }
>  
> -static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
> -{
> -	if (rcu_trace_implies_rcu_gp())
> -		bpf_map_free_rcu_gp(rcu);
> -	else
> -		call_rcu(rcu, bpf_map_free_rcu_gp);
> -}
> -
>  /* decrement map refcnt and schedule it for freeing via workqueue
>   * (underlying map implementation ops->map_free() might sleep)
>   */
> @@ -959,8 +951,9 @@ void bpf_map_put(struct bpf_map *map)
>  		bpf_map_free_id(map);
>  
>  		WARN_ON_ONCE(atomic64_read(&map->sleepable_refcnt));
> +		/* RCU tasks trace grace period implies RCU grace period. */
>  		if (READ_ONCE(map->free_after_mult_rcu_gp))
> -			call_rcu_tasks_trace(&map->rcu, bpf_map_free_mult_rcu_gp);
> +			call_rcu_tasks_trace(&map->rcu, bpf_map_free_rcu_gp);
>  		else if (READ_ONCE(map->free_after_rcu_gp))
>  			call_rcu(&map->rcu, bpf_map_free_rcu_gp);
>  		else
> @@ -3268,14 +3261,6 @@ static bool bpf_link_is_tracepoint(struct bpf_link *link)
>  	       (link->type == BPF_LINK_TYPE_TRACING && link->attach_type == BPF_TRACE_RAW_TP);
>  }
>  
> -static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
> -{
> -	if (rcu_trace_implies_rcu_gp())
> -		bpf_link_defer_dealloc_rcu_gp(rcu);
> -	else
> -		call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
> -}
> -
>  /* bpf_link_free is guaranteed to be called from process context */
>  static void bpf_link_free(struct bpf_link *link)
>  {
> @@ -3301,9 +3286,12 @@ static void bpf_link_free(struct bpf_link *link)
>  		 * period wait instead when non-faultable tracepoint is used. We
>  		 * don't need to chain SRCU grace period waits, however, for the
>  		 * faultable case, since it exclusively uses RCU Tasks Trace.
> +		 *
> +		 * RCU Tasks Trace grace period implies RCU grace period, hence
> +		 * pass bpf_link_defer_dealloc_rcu_gp as callback directly.
>  		 */
>  		if (link->sleepable || (link->prog && link->prog->sleepable))
> -			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
> +			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
>  		/* We need to do a SRCU grace period wait for tracepoint-based BPF links. */
>  		else if (bpf_link_is_tracepoint(link) && tp_srcu)
>  			call_srcu(tp_srcu, &link->rcu, bpf_link_defer_dealloc_rcu_gp);
> -- 
> 2.52.0
