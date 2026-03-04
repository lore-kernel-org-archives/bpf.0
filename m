Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDC17B43F;
	Wed,  4 Mar 2026 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628118; cv=none; b=erOd63ySroW2BKe8CtC3WHH+Fm48OxyrejZOcn6BHtt5AcPnt+UalsOl1zNAOujGg3ya08yuqw+k5Ym3wLhsNfspFkkmzr9sTiLbXV7uN2fgRnBnHaXmzzaYBLAArY60YSykZHPPAJFDKwxKdUmgiYKUxCygEc5LqrMd6mjp+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628118; c=relaxed/simple;
	bh=OpTnhPrIdc8xXxeDIfNqc4Sq56owvvf6f99Wphyqmq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBYxSUDTFdSHbF/wchY6xaTjnyrSJ3xIxUDHUH4CEXODgep36RKwm486sGydBUcZ2g0ZIFeSTsgxfuTe+aVowicGXKwFatWl5GnNsITbrdDxRQpJj9YZigqPTTzh6EXc7tF+a/L5azo5qGIsJ7Yq6Yl0aD0WOTc3L8oeYL6fHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BDMcbJvb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BDMcbJvb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=CcCwKTcMnUgLpwRIH8rS+OizEgnkuQcgCPu1pst7Rcw=; b=BDMcbJvbrY2dQssz2LJlf26Tnh
	9TBnXOKDj8OyPB9cDh0O0MtamCrBiE5S8Oa2c4ex+saBAyOzwv3zU9K86DNAB215PJSxWoKCOBfDA
	kAPoX8yls0/BqohrFqsVj0Ib2zWOa6yTIyZkiKdzPk16nME0YitTLwGWyL3CP6dOmcjJyWkWg+0hn
	ymtlJ9Vcc2aw4rpkpz0CIYj/wVlEYAQQd/HT0JaRViqwVb+V6RREQw3wbZHL4r4XvpYP22nFKxEVQ
	Cd6X/X0FR9pGz8nMxuv+L6sz/9DyibGoo9TbpvqPRsVCVNJbBQGdJe8jq0Uj6KeTPT4oEifupVhrU
	gyGZaJqA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxlXx-00000004YYM-46yG;
	Wed, 04 Mar 2026 12:41:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 93874300666; Wed, 04 Mar 2026 13:41:48 +0100 (CET)
Date: Wed, 4 Mar 2026 13:41:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260304124148.GA2277644@noisy.programming.kicks-ass.net>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
 <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net>
 <CALOAHbC1AHc2eZrzafz7ynrW7NFPrVmervCY_jjWsRTo0gBwQQ@mail.gmail.com>
 <20260304101111.GQ606826@noisy.programming.kicks-ass.net>
 <CALOAHbDmmbcK-0mG=44rw3wbaTwS8drzYD-s2gg8g+rPQZNLCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDmmbcK-0mG=44rw3wbaTwS8drzYD-s2gg8g+rPQZNLCg@mail.gmail.com>

On Wed, Mar 04, 2026 at 07:52:06PM +0800, Yafang Shao wrote:
> On Wed, Mar 4, 2026 at 6:11 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Mar 04, 2026 at 05:37:31PM +0800, Yafang Shao wrote:
> > > On Wed, Mar 4, 2026 at 5:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Wed, Mar 04, 2026 at 03:46:49PM +0800, Yafang Shao wrote:
> > > > > Introduce mutex_lock_nospin(), a helper that disables optimistic spinning
> > > > > on the owner for specific heavy locks. This prevents long spinning times
> > > > > that can lead to latency spikes for other tasks on the same runqueue.
> > > >
> > > > This makes no sense; spinning stops on need_resched().
> > >
> > > Hello Peter,
> > >
> > > The condition to stop spinning on need_resched() relies on the mutex
> > > owner remaining unchanged. However, when multiple tasks contend for
> > > the same lock, the owner can change frequently. This creates a
> > > potential TOCTOU (Time of Check to Time of Use) issue.
> > >
> > >   mutex_optimistic_spin
> > >       owner = __mutex_trylock_or_owner(lock);
> > >       mutex_spin_on_owner
> > >           // the __mutex_owner(lock) might get a new owner.
> > >           while (__mutex_owner(lock) == owner)
> > >
> >
> > How do these new owners become the owner? Are they succeeding the
> > __mutex_trylock() that sits before mutex_optimistic_spin() and
> > effectively starving the spinner?
> >
> > Something like the below would make a difference if that were so.
> 
> The following change made no difference; concurrent runs still result
> in prolonged system time.
> 
> real 0m5.265s user 0m0.000s sys 0m4.921s
> real 0m5.295s user 0m0.002s sys 0m4.697s
> real 0m5.293s user 0m0.003s sys 0m4.844s
> real 0m5.303s user 0m0.001s sys 0m4.511s
> real 0m5.303s user 0m0.000s sys 0m4.694s
> real 0m5.302s user 0m0.002s sys 0m4.677s
> real 0m5.313s user 0m0.000s sys 0m4.837s
> real 0m5.327s user 0m0.000s sys 0m4.808s
> real 0m5.330s user 0m0.001s sys 0m4.893s
> real 0m5.358s user 0m0.005s sys 0m4.919s
> 
> Our kernel is not built with CONFIG_PREEMPT enabled, so prolonged
> system time can lead to CPU pressure and potential latency spikes.
> Since we can reliably reproduce this unnecessary spinning, why not
> improve it to reduce the overhead?

If you cannot explain what the problem is (you haven't), there is
nothing to fix.

Also, current kernels cannot be build without PREEMPT; and if you care
about latency running a PREEMPT=n kernel is daft. That said,
TIF_NEED_RESCHED should work irrespective of PREEMPT settings, the
PREEMPT settings just affect when and how you end up in schedule().

Even without PREEMPT, if there is a task waiting either the wakeup or
the tick will set TIF_NEED_RESCHED and it should stop spinning. If there
is no task waiting, there is no actual latency, just burning CPU time,
and that isn't a problem per-se.

What should happen is that the first spinner gets the lock next, the
next spinner is then promoted to first spinner and so on.

This chain continues, which means the lock owner is always
on-cpu and good progress is being made and there is no CPU contention,
or the spinner gets marked for preemption (as said, this does not
require PREEMPT=y) and will stop spinning and go sleep, or the owner
goes to sleep and all the spinners stop and also go sleep.

Again, you have not said anything specific enough to figure out what
happens on your end. You said the owner changes, this means there is
progress made. What isn't clear is if any one particular spinner is
starved (that would be a problem) or if this latency spike you observe
is worse than would be from running a while(1) loop, in which case,
that's just how it is.

What is not sane, is marking random locks with random properties just
because random workload.
