Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD015A864;
	Thu, 16 Jul 2026 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171840; cv=none; b=DMo9ius+b+EBCSQHNEB9oMn4yFoxe/A9+v/WTDPdbBnzwJaElfuMOqbjgME31mANuulmm47V5mZFEpsP82xhsR1X0lfauXilbJiZCaCu10HMJQla14OiNR4t1uYqnfaVpYf3OwRQlSaFK9VRgYeyuFwKX4CwiriS2KOrXyKtm+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171840; c=relaxed/simple;
	bh=SqzfH1qCOywfpLCOrGrJKwJuyejIgn0UgLhLIK0CaEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCnCZglpDKz+P1GtLhFPEiFw+i4PQE4J0h8EX3LypV2OIuWw3O7nci3ewWfvyJdO8xUZgqi2eJAaOpvDBPoYWHnavZ6WzEXV7D/UJXVt9YJAsMQrXirgLNXEIPihE/xTNizRelL01s1Or1+DGw6l7w869oqPmJmv5CET1AzymkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgETNmRR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgETNmRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41F81F000E9;
	Thu, 16 Jul 2026 03:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784171838;
	bh=KUevKX9fA12h9MSH/VdapJePMervVux/tM6Muqf/go8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=GgETNmRRccsxbunohcQxi129rkDYAweN0xVDMS7Oat/GxhK/KWFlWDIvdQ9ZtwlO4
	 yh6gIT6r+06GIKa9378riMJ8pXWNmSo27uzg1BfdsBQkufiIJhZQE2pE8E8nLCDbjd
	 I1a4ZfotrpZHkN8lfZZSQpFCfTB3fIH4myrRZKhL91aqNbmWMy0oUHYK9yAlRZb7aM
	 0AlPy63roeTKt3XuK2VmLs+Y4fn2c9ia5YGftvQurH+dSkS3vR5qkNtamxs67iAWwQ
	 WEsvTB4uCgP8HHVSCQd/Ap8Ph4Ynqkgc+sI7AR73O3ZILf2+uon/gjKf8HG3HUQNFA
	 p5HrVAX2iI2Xg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 86B45CE0569; Wed, 15 Jul 2026 20:17:18 -0700 (PDT)
Date: Wed, 15 Jul 2026 20:17:18 -0700
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
Message-ID: <0e7a80ea-2051-4aff-9d94-fd0a16a99bfa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260715215314.44423f47@fangorn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715215314.44423f47@fangorn>

On Wed, Jul 15, 2026 at 09:53:13PM -0400, Rik van Riel wrote:
> syzkaller creates a PROG_ARRAY with huge max_entries and triggers perf
> tracepoint open close in parallel. The hung task detector reports
> "INFO: task hung in perf_tp_event_init" with event_mutex held waiting
> for synchronize_rcu_tasks().
> 
> bpf_fd_array_map_clear walks max_entries under RCU read lock on a
> workqueue kworker. Commit 4406942e65ca added cond_resched for classic
> RCU, but under PREEMPT it is a no-op and a preempted kworker never
> reports RCU-tasks QS. The loop then blocks the grace period while
> event_mutex is held in ftrace_shutdown, stalling perf_event_open().
> 
> Use cond_resched_tasks_rcu_qs to report RCU-tasks QS independent of
> preemption model. The grace period completes and event_mutex is
> released normally.
> 
> Fixes: da765a2f5993 ("bpf: Add poke dependency tracking for prog array maps")
> Fixes: 4406942e65ca ("bpf: Fix RCU stall in bpf_fd_array_map_clear()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Assisted-by: Claude:claude-opus-4-8
> ---
> QUESTION: should we change cond_resched() instead, so it unblocks RCU
> in any preempt configuration where cond_resched() is a noop?
> 
> That would take care of every bug of this shape with one change,
> and rcu_tasks_qs() looks cheap enough?

Just confirming that rcu_tasks_qs() is quite cheap:  Check a constant,
check a flag in the task_struct structure, and, if set, set another flag
in this same structure.  If there is no RCU Tasks grace period in effect,
the first flag will always be zero.

							Thanx, Paul

>  kernel/bpf/arraymap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 248b4818178c..55fd97375130 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -1015,7 +1015,8 @@ static void bpf_fd_array_map_clear(struct bpf_map *map, bool need_defer)
>  
>  	for (i = 0; i < array->map.max_entries; i++) {
>  		__fd_array_map_delete_elem(map, &i, need_defer);
> -		cond_resched();
> +		/* cond_resched() is a noop with preempt; unblock RCU */
> +		cond_resched_tasks_rcu_qs();
>  	}
>  }
>  
> -- 
> 2.53.0-Meta
> 
> 
