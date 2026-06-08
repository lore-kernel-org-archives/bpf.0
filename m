Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D625B0B5;
	Mon,  8 Jun 2026 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924098; cv=none; b=Ls3TDBh6AGB4M7cY96A3G5bRq8+ZCnjdNC5MMLKQ9RHWclclMMJ/Sx3aCA9g6hweuJouhW9Q9PsDOxEF0ixmNMccCIHrwUvZP4ybnnaeTW1GxNGWUcpsbNhKZdHCAHHnXwFb5AKT7Dc9S/CNTG2mw8PdqYt3fI4Mx9UG3Li2GxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924098; c=relaxed/simple;
	bh=yBeu7x0HLfDYB6aE4TZympchPHPdEH2T5dCuyN5mEnQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U7FCPOpdXJg8wYju43WRIKbtG7c65tsfOdiKzOXCjNYorfoPLJ0qUi0FyrZBzgY/SXc7OC8Fnhand9pjtnmIeDBI7P5gNRQIYAaUkGExMU4jHACl1L5GF1cjxFzRZhs3Bdgi2jhKhX6JLNt7leRC1pXP+Hu/JA5zQ05SN0RVu3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0mheIZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0mheIZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B411E1F00893;
	Mon,  8 Jun 2026 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780924096;
	bh=Zd0+jNvPkXeWN0Z847elvpT2TNqm09oVmWqgBxiuXWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k0mheIZMVr1L5L8fXXJL35Us7mMFXkw1dgOh+pLa69q4GDs51DZegI3QEvH6DA25O
	 EkwltIfDsUQJYt7sm/sJOhLb6GTl+xu4OGJxGPMwZ2mvIPqm4QEXZZpZeWOGR7S4Eq
	 T7KyQ/y6dDJvDPNkZnGmvVvm6QkSyFosqIVU3TR2cXG1pfx0ONmolmK3bm+jhSxKL+
	 SJ8Am/sXRBvBFpoHEU11aOVHklqCOU+Dl1/8QLdhGk4PUy5On4AaSBEOqp2TlujOKB
	 69vx5A1FG+riQWbywdSH5mVsACSh4HgaHwDSiJLGtzmIWm1bf0LtnzSA5J+27SPS2c
	 xHwaJMSCZMDnw==
Date: Mon, 8 Jun 2026 22:08:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Cc: Tengda Wu <wutengda@huaweicloud.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Alexei Starovoitov
 <ast@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
 jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
Message-Id: <20260608220811.d4a0b58961cfb9eeb6bbbccb@kernel.org>
In-Reply-To: <20260608102326.GB3161497@noisy.programming.kicks-ass.net>
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
	<20260526123719.482f07a3843e207e22d95378@kernel.org>
	<94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
	<20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
	<20260604093445.GF3126523@noisy.programming.kicks-ass.net>
	<20260605224341.c926299d613b6102912c9a3f@kernel.org>
	<679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com>
	<20260608093449.GH4149641@noisy.programming.kicks-ass.net>
	<20260608102326.GB3161497@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 12:23:26 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jun 08, 2026 at 11:34:49AM +0200, Peter Zijlstra wrote:
> > 
> > +Live patching folks
> > 
> > On Mon, Jun 08, 2026 at 09:52:37AM +0800, Tengda Wu wrote:
> > 
> > > Background: We are verifying the support of live patches for functions that
> > > have a kretprobe. The specific verification method is as follows:
> > > 
> > > We construct a function foo() that calls bar():
> > > 
> > > void bar(void)
> > > {
> > >     for (;;) {
> > >         schedule();
> > >     }
> > > }
> > > 
> > > void foo(void)
> > > {
> > >     bar();
> > > }
> > > 
> > > A kretprobe is attached to bar():
> > > 
> > > echo 'r:rp1 bar' > /sys/kernel/tracing/kprobe_events
> > > echo 1 > /sys/kernel/tracing/events/kprobes/rp1/enable
> > > 
> > > Then foo() is triggered. The expected behavior is that bar() will call
> > > schedule() and yield the CPU.
> > > 
> > > After that, the live patch is activated to attempt replacing the implementation
> > > of foo(). The expectation is that this should succeed.
> > 
> > This wholly depends on how foo() calls bar(), if it is a normal call,
> > then no, it should not succeed, because foo() is still on the stack.
> > 
> > If it is a tail-call, then yes, because foo() is no longer relevant.
> > 
> > > However, in reality, because the task that called schedule() is still in the
> > > RUNNING state,
> > 
> > So calling schedule() without setting state is dodgy in the first place.
> > Who is doing this? All wait primitives will set this to
> > TASK_UNINTERRUPTIBLE or something along those lines.
> > 
> > > the condition task_is_running(tsk) inside rethook_find_ret_addr()
> > > is not satisfied, causing the function to return early. This, in turn,
> > > prevents stack_trace_save_tsk_reliable() from determining the stack as
> > > reliable, leading to a failure in activating the live patch.
> > > 
> > > **Not sure if this is correct:**
> > > 
> > > We believe that after a task voluntarily calls schedule(), when the stack
> > > is expected to be reliable, it is a safe time to activate a live patch.
> > 
> > Calling schedule() without setting state is a no-op and really shouldn't
> > count much at all.
> > 
> > > Additionally, a similar tsk->on_cpu check can be found elsewhere in the
> > > kernel (See task_on_another_cpu() in arch/x86/include/asm/unwind.h).
> > > Therefore, we propose changing the task_is_running(tsk) condition to
> > > tsk->on_cpu.
> > 
> > Anyway, I'm wondering what the purpose of this check here is, there is
> > no real comment, and commit 5120d167e21c ("rethook: Remove warning
> > messages printed for finding return address of a frame.") is just pure
> > voodoo as well.
> 
> FWIW, you should have had this discussion then.

Indeed. The rethook is making a shadow stack by list, thus caller must
guarantee the target process is blocked at least during this function.

The commit messages suggest that when BPF takes a backtrace, it also
includes other running tasks. Is that safe?

> 
> > Also, note the comment that goes with the usage of
> > task_on_another_cpu(); that thing is racy as all heck.
> > 
> > So it really comes down to what the purpose of this check is.

This check has been introduced when it is copied from
kretprobe_find_ret_addr(). It has the comment:

 * The @tsk must be 'current' or a task which is not running. @fp is a hint

IIRC, I added this check to explicitly verify this condition.

> > 
> > I suspect the issue at hand is that tsk->rethook elements, such as
> > iterated by __rethook_find_ret_addr() are not safe to be accessed for a
> > running task.
> > 
> > Notably while rethook_recycle() has some RCU thing on, that objpool
> > thing (and the recycle name itself) seems to strongly suggest iterating
> > these things is not sound (you could start with things from this task,
> > hit a recycled entry and continue iterating rethooks from another task).
> > 
> > Also note that the current check is also racy, nothing really prevents a
> > wakeup from happening right after you observe task_is_running() being
> > false. The task can then get scheduled in on another CPU and tear down
> > its rethooks concurrent with __rethook_find_ret_addr().

Yeah, but is there any way to ensure the task is blocked? Even if it is
blocked, like TASK_UNINTERRUPTIBLE, unless holding the actual lock in
the rethook, it may not be possible to ensure it?

Of course, we could give up on checking within this function and leave
everything to the caller to guarantee - as kretprobe does.

BTW, the reason why we made it possible to pass tasks other than current
 is that the stack unwinding code itself supported unwinding tasks other
than current, so we had no choice but to create this interface.

However, it is a bad idea to check this in deep inside of unwinding.

> > Now, livepatch itself calls unwind from a proper context, but unwinds in
> > general are not. This rethook stuff doesn't seem to be sound in general.
> 
> I suspect just entirely removing the check is the sanest option at this
> point. Callers that do it right (livepatch) are guaranteed consistent
> data, and the rest gets whatever pieces.

Agreed.

> 
> Notably, unwind_next() holds rcu, so the iteration is protected from any
> of those rethook_node things getting freed. Its just that the iteration
> can go sideways and you might not get a sane answer.
> 
> The very worst possible option is getting stuck in an infinite loop when
> concurrent with agressive rethook re-use or something daft like that,
> but that seems extremely unlikely.


OK, thanks for your review!

Tengda, can you send a patch to just remove the check?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
