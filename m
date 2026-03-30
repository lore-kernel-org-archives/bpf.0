Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A6389E07
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864344; cv=none; b=h+IknlwvjPTRLBO5GgyoNrOBVQKfzysnYKpWqnJQwjLh2PWEk1bfKIf6W4CctTGRTEvX0SBebZdJhU8e7AoX1lbtzzuJGonobL4XCZlkUHtiUL6pZiYYw+liPZ6R67G4uhFXzxlX//gHNrL0BQBwNwlcPSM4KB5dCPZItxQ7NN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864344; c=relaxed/simple;
	bh=hiIoq9Ln9VsRL/ENqU3EeKKAg4WKxeHoaYBZUOcG68w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qV4KjUO0lSIkxbbCuxBlYS46SWg2PYe5zUdmojKBP5ydLQgyFkSJHftZXffGbXi+OX1T8KvBsFzoOQy6ecMO9Hzz4jMvh7BL9/RaPYKHr34Hi9zV0uX59dcyA+TnwivISVKxA0KmyPg7bPFoQw5nbkhI1TUkDGKk3QhdViLz8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsAxub5B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsAxub5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27F1C2BC9E;
	Mon, 30 Mar 2026 09:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774864344;
	bh=hiIoq9Ln9VsRL/ENqU3EeKKAg4WKxeHoaYBZUOcG68w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KsAxub5BM8O9v/ZxUaEcK7dY5ZKx8wmeriCJsLMz6V2BieM0BeFQOWtUuLeFtc+iP
	 1qbHD1NxOheTrG216IrRhJEzyZCgNd1kULdgCXHICU+zXS5xOiXIdmu/xxCyRLZmP6
	 f4283f9SEDjDylq0o6Uz+kZPruHvbzuu5tIvGcmEe3J2XksceH9eClp+1M9DD80Xj1
	 L1t//CV3AeUosT0bVdy9plzrz5OtQUnWl4lP8p2STVz3vYVUUoTr4gOhdT8p15m8yg
	 d6UMXw3iwjpeomYMzWPHobDPvedUb1/kOXCij8c9JQbxIAYRVyOS4AGhJ7PkLyjRTN
	 YtWPmdDCHTb8A==
From: Puranjay Mohan <puranjay@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix grace period wait for tracepoint
 bpf_link
In-Reply-To: <20260330032124.3141001-2-memxor@gmail.com>
References: <20260330032124.3141001-1-memxor@gmail.com>
 <20260330032124.3141001-2-memxor@gmail.com>
Date: Mon, 30 Mar 2026 10:52:12 +0100
Message-ID: <m28qb91w6r.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Recently, tracepoints were switched from using disabled preemption
> (which acts as RCU read section) to SRCU-fast when they are not
> faultable. This means that to do a proper grace period wait for programs
> running in such tracepoints, we must use SRCU's grace period wait.
> This is only for non-faultable tracepoints, faultable ones continue
> using RCU Tasks Trace.
>
> However, bpf_link_free() currently does call_rcu() for all cases when
> the link is non-sleepable (hence, for tracepoints, non-faultable). Fix
> this by doing a call_srcu() grace period wait.
>
> As far RCU Tasks Trace gp -> RCU gp chaining is concerned, it is deemed
> unnecessary for tracepoint programs. The link and program are either
> accessed under RCU Tasks Trace protection, or SRCU-fast protection now.
>
> The earlier logic of chaining both RCU Tasks Trace and RCU gp waits was
> to generalize the logic, even if it conceded an extra RCU gp wait,
> however that is unnecessary for tracepoints even before this change.
> In practice no cost was paid since rcu_trace_implies_rcu_gp() was always
> true.
>
> Hence we need not chain any SRCU gp waits after RCU Tasks Trace.
>
> Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

With a nit below which is mostly informational.

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

> ---
>  include/linux/tracepoint.h |  8 ++++++++
>  kernel/bpf/syscall.c       | 22 ++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 22ca1c8b54f3..8227102a771f 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -113,6 +113,10 @@ void for_each_tracepoint_in_module(struct module *mod,
>   */
>  #ifdef CONFIG_TRACEPOINTS
>  extern struct srcu_struct tracepoint_srcu;
> +static inline struct srcu_struct *tracepoint_srcu_ptr(void)
> +{
> +	return &tracepoint_srcu;
> +}
>  static inline void tracepoint_synchronize_unregister(void)
>  {
>  	synchronize_rcu_tasks_trace();
> @@ -123,6 +127,10 @@ static inline bool tracepoint_is_faultable(struct tracepoint *tp)
>  	return tp->ext && tp->ext->faultable;
>  }
>  #else
> +static inline struct srcu_struct *tracepoint_srcu_ptr(void)
> +{
> +	return NULL;
> +}
>  static inline void tracepoint_synchronize_unregister(void)
>  { }
>  static inline bool tracepoint_is_faultable(struct tracepoint *tp)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 274039e36465..ab61a5ce35af 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3261,6 +3261,13 @@ static void bpf_link_defer_dealloc_rcu_gp(struct rcu_head *rcu)
>  	bpf_link_dealloc(link);
>  }
>  
> +static bool bpf_link_is_tracepoint(struct bpf_link *link)
> +{
> +	/* Only these combinations support a tracepoint bpf_link. */
> +	return link->type == BPF_LINK_TYPE_RAW_TRACEPOINT ||
> +	       (link->type == BPF_LINK_TYPE_TRACING && link->attach_type == BPF_TRACE_RAW_TP);

nit: this second check is never true here, because BPF_LINK_TYPE_TRACING
uses bpf_tracing_link_lops, which has .dealloc (not .dealloc_deferred)
and this function is only called from dealloc_deferred() path.

> +}
> +
>  static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
>  {
>  	if (rcu_trace_implies_rcu_gp())
> @@ -3279,16 +3286,27 @@ static void bpf_link_free(struct bpf_link *link)
>  	if (link->prog)
>  		ops->release(link);
>  	if (ops->dealloc_deferred) {
> -		/* Schedule BPF link deallocation, which will only then
> +		struct srcu_struct *tp_srcu = tracepoint_srcu_ptr();
> +
> +		/*
> +		 * Schedule BPF link deallocation, which will only then
>  		 * trigger putting BPF program refcount.
>  		 * If underlying BPF program is sleepable or BPF link's target
>  		 * attach hookpoint is sleepable or otherwise requires RCU GPs
>  		 * to ensure link and its underlying BPF program is not
>  		 * reachable anymore, we need to first wait for RCU tasks
> -		 * trace sync, and then go through "classic" RCU grace period
> +		 * trace sync, and then go through "classic" RCU grace period.
> +		 *
> +		 * For tracepoint BPF links, we need to go through SRCU grace
> +		 * period wait instead when non-faultable tracepoint is used. We
> +		 * don't need to chain SRCU grace period waits, however, for the
> +		 * faultable case, since it exclusively uses RCU Tasks Trace.
>  		 */
>  		if (link->sleepable || (link->prog && link->prog->sleepable))
>  			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
> +		/* We need to do a SRCU grace period wait for tracepoint-based BPF links. */
> +		else if (bpf_link_is_tracepoint(link) && tp_srcu)
> +			call_srcu(tp_srcu, &link->rcu, bpf_link_defer_dealloc_rcu_gp);
>  		else
>  			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
>  	} else if (ops->dealloc) {
> -- 
> 2.52.0
