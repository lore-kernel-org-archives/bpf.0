Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17532B110;
	Tue,  9 Jun 2026 04:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980120; cv=none; b=uObW8wILnRV+FvCgeUYhvZxk5QseyySMPchQllh0dZZ7jN4a0AphZyjunbmdO4kuo0ldvubAE0naCtgCCHp4GAlig9J8CYI1/OVOYUxpGQVOaHPAVRv5AcaggDz78iMZt8KAXQT+V9K6sZ/SLJjgF0tSnOa93Lq1lmHcR0Eju5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980120; c=relaxed/simple;
	bh=ODTgco8lQgyeZF0iLEKh8rsmikQ/7p4bPbPINfUkBbc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hntOBGuP24daObiBx5s6/lIDfzldVt00SlywKW+yErGyD9MrQQPrpeAyPXhkNxNyO9xbF47hu/U1RJIXxy02Rc/Ult/pE5mdu6Kfjs0JRIjTnyL5PvLdGbXrG+291wbUEkCjBV/RPJ/9FXQxB3LBDw/3uj7LpZiAay6HSizoHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XknvzGb7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XknvzGb7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4443D1F00893;
	Tue,  9 Jun 2026 04:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780980119;
	bh=DLDc4HxqREBDDt3hVXVOTqiMnbSOgshyTeK20M4+cd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XknvzGb7XLqIUt0PUwebvatHXmiGs+RasSizR/qDGNhKcscOEKUuIygjGhTwLIzdF
	 tQG6X0bNRI2N79lIikJjfjeO/lPqpcjEoNwg66K/uTrCdUitbBOTpsDtY71A5RowW6
	 383DQAe+oxpIopeNWEQsqngETkQAm5iqV4BhREs1HT9xHh/ljM9nn17rgu5rVOFSvB
	 NaZjuAW38OTtMT+mDCX1qbq1oVvvHx9oM4ZOts4D/Phpv0GLJa7Leq28plGqewsskq
	 1gH4+MN9eTzBZD/7+vfVA5hMGHyycu1eOq+tgTQ2CEIoogHtyQgtDr+01n4ciMt/Rt
	 6M19H6GRmE+Kw==
Date: Tue, 9 Jun 2026 13:41:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org, Tengda Wu <wutengda@huaweicloud.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@redhat.com>, jikos@kernel.org, mbenes@suse.cz,
 pmladek@suse.com
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
Message-Id: <20260609134153.d06aef367a366e5d976cba62@kernel.org>
In-Reply-To: <20260608140654.GE3102624@noisy.programming.kicks-ass.net>
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
	<20260526123719.482f07a3843e207e22d95378@kernel.org>
	<94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
	<20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
	<20260604093445.GF3126523@noisy.programming.kicks-ass.net>
	<20260605224341.c926299d613b6102912c9a3f@kernel.org>
	<679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com>
	<20260608093449.GH4149641@noisy.programming.kicks-ass.net>
	<20260608102326.GB3161497@noisy.programming.kicks-ass.net>
	<20260608220811.d4a0b58961cfb9eeb6bbbccb@kernel.org>
	<20260608140654.GE3102624@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 16:06:54 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jun 08, 2026 at 10:08:11PM +0900, Masami Hiramatsu wrote:
> 
> > > > Anyway, I'm wondering what the purpose of this check here is, there is
> > > > no real comment, and commit 5120d167e21c ("rethook: Remove warning
> > > > messages printed for finding return address of a frame.") is just pure
> > > > voodoo as well.
> > > 
> > > FWIW, you should have had this discussion then.
> > 
> > Indeed. The rethook is making a shadow stack by list, thus caller must
> > guarantee the target process is blocked at least during this function.
> > 
> > The commit messages suggest that when BPF takes a backtrace, it also
> > includes other running tasks. Is that safe?
> 
> Well, you get to keep the pieces. At this point safe only pertains to
> 'doesn't-crash', all correctness is out the window.
> 
> I always forget the crazy BPF does ;-)
> 
> > > > Also, note the comment that goes with the usage of
> > > > task_on_another_cpu(); that thing is racy as all heck.
> > > > 
> > > > So it really comes down to what the purpose of this check is.
> > 
> > This check has been introduced when it is copied from
> > kretprobe_find_ret_addr(). It has the comment:
> > 
> >  * The @tsk must be 'current' or a task which is not running. @fp is a hint
> > 
> > IIRC, I added this check to explicitly verify this condition.
> 
> Right, but it is a prescriptive comment, not an explanatory one. That
> is, it doesn't explain the condition.
> 
> > > > I suspect the issue at hand is that tsk->rethook elements, such as
> > > > iterated by __rethook_find_ret_addr() are not safe to be accessed for a
> > > > running task.
> > > > 
> > > > Notably while rethook_recycle() has some RCU thing on, that objpool
> > > > thing (and the recycle name itself) seems to strongly suggest iterating
> > > > these things is not sound (you could start with things from this task,
> > > > hit a recycled entry and continue iterating rethooks from another task).
> > > > 
> > > > Also note that the current check is also racy, nothing really prevents a
> > > > wakeup from happening right after you observe task_is_running() being
> > > > false. The task can then get scheduled in on another CPU and tear down
> > > > its rethooks concurrent with __rethook_find_ret_addr().
> > 
> > Yeah, but is there any way to ensure the task is blocked? Even if it is
> > blocked, like TASK_UNINTERRUPTIBLE, unless holding the actual lock in
> > the rethook, it may not be possible to ensure it?
> > 
> > Of course, we could give up on checking within this function and leave
> > everything to the caller to guarantee - as kretprobe does.
> > 
> > BTW, the reason why we made it possible to pass tasks other than current
> >  is that the stack unwinding code itself supported unwinding tasks other
> > than current, so we had no choice but to create this interface.
> > 
> > However, it is a bad idea to check this in deep inside of unwinding.
> 
> This, you cannot take locks in unwinding. The only thing you can do is
> try to do the best you can without crashing.
> 
> Typically unwind only happens on self -- this is natural, a task crashes
> and unwinds itself, or a task does something (takes a lock, hits a
> tracepoint, etc) and takes a snapshot of its own stack, and this is
> safe.
> 
> Things like live-patch use task_call_func(), which ensures the callback
> function is done while holding sufficient locks for the task to not
> change state.

Hmm, is there any way to ensure the function is called from task_call_func()?
(Maybe checking p->pi_lock, but this is not sure the lock owner is this
context?) If not, I need to make this available only for current task
(anyway it just return kretprobe trampoline address, no critical issue)
or, introduce a spinlock.

Or, eventually it may be better to replace kretprobe/rethook with
fprobe return handler.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
