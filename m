Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209295;
	b=IxJyNNeYU1Xt7BffTFhuiGcXJVjWmsKAmsnL+SeG+7qnl1J9JpKiryR1or5uzPN3B8zr
	 MoQE0vV+m2vV2uAxoYH4S3/P3/3NzjvnaYUkZaKIamEB2X+TmMDeMsTFzaphFcDDu8wBM
	 +K43OukhETVMBjfc2kFFf4PIzbc+flTcn9IMFPp4U9NYLm++mYi76cd0uShLBqnXO2IpU
	 JYsKwwNL8JnObNsqk4zc9kJdn1JQYMwIrnWuh2p2HL8xvxjs7N0axCPq3pglDBunMmk3c
	 xxQLnvYuP1cOpYw8T07GZbizO1CgbycE3mEwQ1/bARfEYylWbVq5DoCbH6s3Fh/mEmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209295;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VVsYCYrKEZW2atSI32Feitfi1mPp9G8rT8AcAN4FOj0=;
	b=5k+wXFDs/CLkgpbScQbpcAoCswxWhVlJXx0dUnAgzQe/pLWxKNWixDB52IozgnptBTZo
	 oGEVqJ/C1wydPNCp/BHCZ+3hnIZFRAT4tzm8UWiAl8EQU0234Mxe9Ydfi9xbprvL5tPOA
	 5jnIZzvPEILwnGjKscckD9ezf8IgswNZ65yJT3bvgWfHQraVjxs+TVhoFtMsLBL3jYVrJ
	 KohrogIFK64/1vQzU9hvMrED4vwOZhAIcXi/vvU8f2T4aIOf/B9JKpqSFLui7wBy7qPPs
	 UFWjG397h8+Y5JfiQBgRrIzoNpqMJ+cwNzaX0JKyvbapjyHJFyJyVlEhCrFLoqUZ5Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M/tomOMH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5AD606A323;
	Mon,  9 Nov 2026 07:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/tomOMH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0F81F008A2;
	Mon,  9 Nov 2026 07:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209294;
	bh=VVsYCYrKEZW2atSI32Feitfi1mPp9G8rT8AcAN4FOj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M/tomOMHog4GGKxJ+581YgMBrs69OSeBH5UPTro8cLUzr2JcFvPAq+7OBcf3RKc1L
	 vNpqRUUE+vp+BHHevRvuLmv+VgnxWPmy1EXiW0fB47n+xi4785Rd4HWpxFMxJinE8c
	 OJS2NackjuDUP1mKlNxPI7Wch821PZoMNSQmAa7+RtOEzBNjPHdKFWg6HqLYIv4n6S
	 2IA+OUisofdtIKG8fl/QtfqEQrcL8g6Sqi/uJQ6UhNUWYWbjfTcsqQTPWCSZdwnP6u
	 52/GebuUniUJLZVL5atMMn2/LFSHi45kg5BgM7jFL/f+Z5qv2NxIpkWF3aCokiO+Lr
	 B9GavNgBxy7LA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org, peterz@infradead.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 1/2] tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT
Date: Mon, 09 Nov 2026 16:28:10 +0900
Message-ID: <undine-1794209290628913712-5c540874e8ce0b55@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261021174406.2891598-2-vineet.gupta@linux.dev>
References: <20261021174406.2891598-1-vineet.gupta@linux.dev> <20261021174406.2891598-2-vineet.gupta@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 21 Oct 2026 10:44:05 -0700, Vineet Gupta <vineet.gupta@linux.dev> wrote:
> When ftrace graphing is turned on, all tasks in the system missing
> return stack page are assigned one. This is done in a simplistic
> multi-sweep loop of FTRACE_RETSTACK_ALLOC_SIZE (currently 32) tasks
> at a time as follows:
> 
>    start_graph_tracing()
> 	do {
> 		alloc_retstack_tasklist
> 	} while (-EAGAIN);
> 
>    alloc_retstack_tasklist()
> 	alloc x32           # GFP_KERNEL, may sleep
> 	rcu_read_lock()     # preempt off
> 		for_each_process_thread    walk N_total, no cond_resched
>                      t->ret_stack = new_page
> 	rcu_read_unlock()   # preempt enable but no explicit yield
> 
> Each successive iteration of loop invokes for_each_process_thread()
> which doesn't support cursor based resume and always restarts from the
> init_task. Thus each successive loop needs to skip the tasks assigned
> ret_stack in prior sweeps and thus take longer and longer to find the
> candidate 32 tasks. And while the loop end calls rcu unlock,
> and re-enables preemption briefly, there is no explicit yield.
> 
> The total number of iterations turn out to be
> 
> 	N_total * N_null / (2 * FTRACE_RETSTACK_ALLOC_SIZE)
> 
> where N_total is the number of threads on the system and N_null the number
> of those whose ret_stack is still NULL. After boot with no fgraph user that
> is every thread.
> 
> This is not a tracing-only path. Since commit 4346ba160409 ("fprobe:
> Rewrite fprobe on function-graph tracer") fprobe is built on fgraph,
> so an ordinary kprobe_multi BPF attach that flips ftrace_graph_active
> from 0 to 1 pays the whole cost inside one bpf() syscall. Commit
> 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
> narrows that to return and session probes but does not remove it.
> 
> A host running hundreds of thousands of threads, with the current batch
> size of 32, turns the ftrace_graph_active 0 -> 1 transition into a
> multi-second, and eventually multi-minute, operation which showed up as
> RCU stall and softlockup_panic on heavily loaded Meta Fleet machines
> with preemption disabled.
> 
>     rcu: INFO: rcu_sched self-detected stall on CPU
>     rcu: 0-....: (20718 ticks this GP) (t=21000 jiffies g=913 q=8 ncpus=8)
>     CPU: 0 UID: 0 PID: 160141 Comm: bpftrace
>      ___slab_alloc+0x549/0xa20
>      kmem_cache_alloc_noprof+0x16c/0x340
>      register_ftrace_graph+0x3d7/0x6c0
>      register_fprobe_ips+0x2d5/0x310
>      bpf_kprobe_multi_link_attach+0x218/0x7e0
>      __sys_bpf+0x267a/0x27a0
> 
> Fix this by allocating inline with GFP_NOWAIT instead of pre-allocating
> a fixed batch. GFP_NOWAIT does not sleep, so it is legal inside the RCU
> read-side critical section.
> 
> A single sweep now serves every task, so the walk becomes O(N) rather
> than O(N_total * N_null), and the retry loop is no longer the normal
> path.
> 
> The pre-allocated array remains as the fallback when GFP_NOWAIT fails.
> The runs below never needed it, so it was exercised with failslab
> injection: at a 100% failure rate every task falls back and -EAGAIN
> retries ~1560 times for 50000 threads, with no stall or splat.
> 
> The open-coded rcu_read_lock() and the goto unwind are kept as-is so
> this stays easy to backport; converting them to scope-based cleanup is
> left to a follow-up.
> 
> smp_store_release() is a drop-in replacement for the smp_wmb() and
> plain store it replaces.
> 
> Measured on a 60-core Sapphire Rapids machine running a PREEMPT_LAZY
> kernel (CONFIG_PREEMPT_DYNAMIC=y, mode lazy), timing the write that
> drives the ftrace_graph_active 0 -> 1 transition. Threads are spawned
> while fgraph is inactive so every one of them has ret_stack == NULL,
> and the loop was instrumented to count sweeps:
> 
> 	threads   before              after
> 	          sweeps   time       sweeps   time
> 	100000     3126     15.3 s      1       0.019 s
> 	200000     6253     59.1 s      1       0.047 s
> 	400000    12503    227.8 s      1       0.092 s
> 
> The sweep count is 1 throughout. Time now scales linearly with the
> thread count at roughly 230 ns per task, which is the allocation and
> initialisation of one shadow stack.
> 
> Fixes: f201ae2356c7 ("tracing/function-return-tracer: store return stack into task_struct and allocate it dynamically")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> Tested-by: Vineet Gupta <vineet.gupta@linux.dev>
> Cc: stable@vger.kernel.org

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  kernel/trace/fgraph.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ed455b53513b..4c74f1a15ad4 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1033,13 +1033,16 @@ void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops,
>  trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
>  trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
>  
> -/* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
> +/*
> + * Loop thru all the tasks in the system and assign ret_stack.
> + * The @ret_stack_list is a small pre-allocated fallback, in case
> + * the GFP_NOWAIT allocations here fail.
> + */
>  static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  {
> -	int i;
> -	int ret = 0;
>  	int start = 0, end = FTRACE_RETSTACK_ALLOC_SIZE;
>  	struct task_struct *g, *t;
> +	int i, ret = 0;
>  
>  	if (WARN_ON_ONCE(!fgraph_stack_cachep))
>  		return -ENOMEM;
> @@ -1056,20 +1059,26 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  
>  	rcu_read_lock();
>  	for_each_process_thread(g, t) {
> -		if (start == end) {
> -			ret = -EAGAIN;
> -			goto unlock;
> -		}
> +		unsigned long *rs;
>  
> -		if (t->ret_stack == NULL) {
> -			atomic_set(&t->trace_overrun, 0);
> -			ret_stack_init_task_vars(ret_stack_list[start]);
> -			t->curr_ret_stack = 0;
> -			t->curr_ret_depth = -1;
> -			/* Make sure the tasks see the 0 first: */
> -			smp_wmb();
> -			t->ret_stack = ret_stack_list[start++];
> +		if (t->ret_stack)
> +			continue;
> +
> +		rs = kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
> +		if (!rs) {
> +			if (start == end) {
> +				ret = -EAGAIN;
> +				goto unlock;
> +			}
> +			rs = ret_stack_list[start++];
>  		}
> +
> +		atomic_set(&t->trace_overrun, 0);
> +		ret_stack_init_task_vars(rs);
> +		t->curr_ret_stack = 0;
> +		t->curr_ret_depth = -1;
> +		/* Make sure the tasks see the 0 first: */
> +		smp_store_release(&t->ret_stack, rs);
>  	}
>  
>  unlock:
> 
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> -- 
> 2.53.0-Meta
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
