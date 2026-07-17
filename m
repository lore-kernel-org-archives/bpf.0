Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6B2F691D;
	Fri, 17 Jul 2026 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784262092; cv=none; b=hmtubrBtspxkrEUAG9Gqlo2H5Sp6QE/g9I4DMM5ZC7oyLEG9gK3XKFFTTKI5LS+v3GqnA6IVwJizEKh699z/CaGwLQFJE33y/zurrPQLMbvu4SxZKJOWfRDAftu2mbT9Z4o6iQiNqM+Uj+di0szV0UYKgZT7Ah4aY/tsjHTH8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784262092; c=relaxed/simple;
	bh=IjFnXi8Zx09XPkRYr/r03WZAkkKUxqRPRo4BMmjbWNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvgpz8bKbRRFjUv6Fs01iyLWJ+2K8iDjbwJC6IiNpikEX3lNM/BZLRiQFR+mRg8obtVoAY/tIfiJrgZIPS+cqq/8syIYd2z3v0epd9TWOB6jgt/+XByYMCKkODlJlobKt2/fBH6N7bGbLlkKlGNX7mCGG1eCKirz7/F2ikFcApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWWjTeX7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWWjTeX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD421F000E9;
	Fri, 17 Jul 2026 04:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784262090;
	bh=PkJ5UCoOYLPnm22/3vGMIIC9C0VK1SyoRr1+c7A/zVs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=LWWjTeX79eMqVJjsd9N5pkGiwWknM20Xh3IelxYo+li6MvujaKauKAHw2WVgzp3BM
	 VVKy/GZ4Wi+3mn16v/wt8UcCKeOXS/pFeKFnK1hwK4rXByYAFFv8dsbaLhznyOPK1M
	 zuUlr9RNNO52b4ztBWaZlS6tU84xZ1gBfXP6H3EmmyXyUgBldDWurqHgcwrP1JTGEg
	 PnDH+TB3s/YVbB27mi5SDK76O/V7Xv2qKyLYr2vDt2SfSbLhFZdNnNs18dUyyYguqu
	 8n44jrTWLTWMlQIN7xpbpil2ecBMo7r35TYo5MlG31x9Rg8rxElwTUMKWeyw1m92Rl
	 sVaZUFRft4PLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 40252CE0E5D; Thu, 16 Jul 2026 21:21:30 -0700 (PDT)
Date: Thu, 16 Jul 2026 21:21:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH + QUESTION] bpf: use cond_resched_tasks_rcu_qs in
 bpf_fd_array_map_clear() loop
Message-ID: <9d444098-7c03-4163-af12-bd0a79a51443@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260715215314.44423f47@fangorn>
 <be9c5707e2d83090de28e4b0ce3bc43c67f423af.camel@surriel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be9c5707e2d83090de28e4b0ce3bc43c67f423af.camel@surriel.com>

On Thu, Jul 16, 2026 at 10:04:47PM -0400, Rik van Riel wrote:
> On Wed, 2026-07-15 at 21:53 -0400, Rik van Riel wrote:
> > syzkaller creates a PROG_ARRAY with huge max_entries and triggers
> > perf
> > tracepoint open close in parallel. The hung task detector reports
> > "INFO: task hung in perf_tp_event_init" with event_mutex held waiting
> > for synchronize_rcu_tasks().
> > 
> OK, this is more interesting than it looked at first,
> and this patch does not look like the right approach,
> but I'm also not sure what other approach would work :(
> 
> The actual error being thrown is a hung task:
> 
> 
> 
> The syzkaller kernel failure is a tragedy in 3 parts.
> 
> First, we have perf_event_open() waiting on the event_mutex:
> 
>    syz.7.35551 (pid 31354, state D): perf_event_open 
>   -> perf_tp_event_init
>    -> perf_trace_init
>     -> __mutex_lock
>      -> blocked on event_mutex.
> 
> 
> Second, we have perf_trace_destroy() indirectly
> waiting in synchronize_rcu_tasks(), with the
> event_mutex held.
> 
>     syz.5.35491 (state:I)  do_exit 
>   -> task_work_run 
>    -> __fput 
>     -> perf_release
>      -> perf_event_release_kernel
>       -> __free_event
>        -> perf_trace_destroy
>         -> perf_trace_event_close
>          -> reg(TRACE_REG_PERF_CLOSE)
>           -> perf_ftrace_event_register
>            -> perf_ftrace_function_unregister
>             -> unregister_ftrace_function 
>              -> ftrace_shutdown
>               -> synchronize_rcu_tasks()   <-- BLOCKS HERE, forever,
> holding event_mutex
> 
> Tasks RCU waits for every task to have gone through
> a voluntary reschedule, before the grace period can
> be advanced. A preemption does not count.
> 
> 
> Third, we have a kworker looping for a very long time:
>  
>   kworker/0:0 (pid 9, TASK_RUNNING, on CPU0): process_one_work
>   -> prog_array_map_clear_deferred
>    -> bpf_fd_array_map_clear
>     -> __fd_array_map_delete_elem. Looping over a huge PROG_ARRAY
> max_entries.
> 
> With CONFIG_PREEMPT_LAZY=y this gets preempted,
> but since involuntary preemptions do not count
> for tasks RCU, that does nothnig to help
> ftrace_shutdown() get unstuck.
> 
> 
> How do we solve this?
> 
> Do we actually need to have cond_resched() points
> quiesce the task RCU state when running with lazy
> preempt, since those are points where we could
> preempt voluntarily?
> 
> Do we need to prohibit calling synchronize_rcu_tasks()
> while holding a mutex?
> 
> Do we need to do something else?

The traditional approach is cond_resched_tasks_rcu_qs(), which is to
synchronize_rcu_tasks() as cond_resched() is to synchronize_rcu().

But if we can avoid holding mutexes across synchronize_rcu_tasks(), that
would be a very good thing.  The synchronize_rcu_tasks() latency can be
many minutes, which isn't usually what you want when blocking on a mutex.

Or maybe we want a way of sleeping on a mutex at TASK_IDLE.

> What is the best way forward here?

Excellent question!!!

							Thanx, Paul
