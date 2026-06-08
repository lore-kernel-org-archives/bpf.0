Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32FF3B7769;
	Mon,  8 Jun 2026 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927657; cv=none; b=pRBU0Nhb8mrkAAJD0T/8GFLoOTBR0zGRC7wkcLJh2EsJ5eKmBh6BVaoPOFbZ3igLj43hCWsX5EtE2SJb8G+HJ77O1DfEP/G3queqkvDqWhLFmkIGnWoV7VBvXR99NETGrOFhrbsan/8WK3OLJh5Y3Kl99nhkpKJtECEzD6VsNDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927657; c=relaxed/simple;
	bh=0e3Xl3yjrHcFlMvjOK1Kqj7/x9MCgopzq0b/wQ1QQ9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fk7jDSVAOElGx1pK/ksh+EqX0sbeqzXHfk6a9cAo1q4urRACn/7o8BabHiodUsA7rj0qkTu5CRayitV97ldLhcCIP1nf2AuO/gHcgC4tcQO6YGn5kql1Fy2WPym4XwqsiPIJeDaymf6QNmY85GQPgIoehRw9J1hqKxuvZpDr26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O5c0AqbW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O5c0AqbW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OGkQSvLtArZajcsynm70hHIEzVSivdden6PGwjoo+b0=; b=O5c0AqbWpYmPB8p+XlyKWv2WlR
	ro1otrdZGLf4tvn5X0XoOW76zSdneaP7uo1K8SNBUxyY4s6OS1wX//hmxiWC1lLFoqvko/lrH/25Q
	QZ4Wis/NyzS8z+YhXD8HUzLPR0AVTZbXkjc5jHb+EEs6mLZb8/TaYYZqDEoasBg9x1JbmN2frMZ03
	Pu9ZOt223OsMiXxxusNeGb0TmXKCexztbO0Mv6qKESgL5xUc6ejZs5d4Dfq9SPz2VgkwgbLT+w9ua
	2jNr731ujFfbdVBoxwAwwGRf9Dy+6xhV8LGJTd7R+TTAziWI1U2BKeBeBQCD3AVkVYvDbbevmIBN8
	iiGuZ3Cg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWadT-000000015mN-01OU;
	Mon, 08 Jun 2026 14:07:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 43CBC30044E; Mon, 08 Jun 2026 16:06:54 +0200 (CEST)
Date: Mon, 8 Jun 2026 16:06:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org, Tengda Wu <wutengda@huaweicloud.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>, jikos@kernel.org,
	mbenes@suse.cz, pmladek@suse.com
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
Message-ID: <20260608140654.GE3102624@noisy.programming.kicks-ass.net>
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
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608220811.d4a0b58961cfb9eeb6bbbccb@kernel.org>

On Mon, Jun 08, 2026 at 10:08:11PM +0900, Masami Hiramatsu wrote:

> > > Anyway, I'm wondering what the purpose of this check here is, there is
> > > no real comment, and commit 5120d167e21c ("rethook: Remove warning
> > > messages printed for finding return address of a frame.") is just pure
> > > voodoo as well.
> > 
> > FWIW, you should have had this discussion then.
> 
> Indeed. The rethook is making a shadow stack by list, thus caller must
> guarantee the target process is blocked at least during this function.
> 
> The commit messages suggest that when BPF takes a backtrace, it also
> includes other running tasks. Is that safe?

Well, you get to keep the pieces. At this point safe only pertains to
'doesn't-crash', all correctness is out the window.

I always forget the crazy BPF does ;-)

> > > Also, note the comment that goes with the usage of
> > > task_on_another_cpu(); that thing is racy as all heck.
> > > 
> > > So it really comes down to what the purpose of this check is.
> 
> This check has been introduced when it is copied from
> kretprobe_find_ret_addr(). It has the comment:
> 
>  * The @tsk must be 'current' or a task which is not running. @fp is a hint
> 
> IIRC, I added this check to explicitly verify this condition.

Right, but it is a prescriptive comment, not an explanatory one. That
is, it doesn't explain the condition.

> > > I suspect the issue at hand is that tsk->rethook elements, such as
> > > iterated by __rethook_find_ret_addr() are not safe to be accessed for a
> > > running task.
> > > 
> > > Notably while rethook_recycle() has some RCU thing on, that objpool
> > > thing (and the recycle name itself) seems to strongly suggest iterating
> > > these things is not sound (you could start with things from this task,
> > > hit a recycled entry and continue iterating rethooks from another task).
> > > 
> > > Also note that the current check is also racy, nothing really prevents a
> > > wakeup from happening right after you observe task_is_running() being
> > > false. The task can then get scheduled in on another CPU and tear down
> > > its rethooks concurrent with __rethook_find_ret_addr().
> 
> Yeah, but is there any way to ensure the task is blocked? Even if it is
> blocked, like TASK_UNINTERRUPTIBLE, unless holding the actual lock in
> the rethook, it may not be possible to ensure it?
> 
> Of course, we could give up on checking within this function and leave
> everything to the caller to guarantee - as kretprobe does.
> 
> BTW, the reason why we made it possible to pass tasks other than current
>  is that the stack unwinding code itself supported unwinding tasks other
> than current, so we had no choice but to create this interface.
> 
> However, it is a bad idea to check this in deep inside of unwinding.

This, you cannot take locks in unwinding. The only thing you can do is
try to do the best you can without crashing.

Typically unwind only happens on self -- this is natural, a task crashes
and unwinds itself, or a task does something (takes a lock, hits a
tracepoint, etc) and takes a snapshot of its own stack, and this is
safe.

Things like live-patch use task_call_func(), which ensures the callback
function is done while holding sufficient locks for the task to not
change state.
