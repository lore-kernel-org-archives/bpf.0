Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004B3D9DAA;
	Fri, 24 Jul 2026 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887119; cv=none; b=C1mW8Z4kcvKznhKdBcoI1Odi18VaT9Rur4aq5D6ShLCFhZsThzNw8edCUBV5xYqFeD12npeHN5Bp8hj9Sfw/o+sDGyHFORSf1dr+9vCR47z3Ovod5rftHF5WuUSW6dws+mwZaggdZ9B1zYxBrFg/rzfSHunZexJYKF9CT4y6x/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887119; c=relaxed/simple;
	bh=XrWHgpSHBMBhlwbI3YVxs2W+Uc6ztGG/X698Csn/2fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbBwix5dU3N49f7ujmczicop8sLos8O3YfDnE0HY9ZNfs15x74VOA+KMZ2zXvKR7nYB1ZSIzr7KR1cpUzzv1uq80jd1zN7pxFq1Nxfr79NM9xdKtbxtpp4+Ja8wvFsavfWWsqh+VUheMFbITRD9bdx6tppjbjohe8yqhWJsN5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=obJNvxuD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="obJNvxuD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L541VKiqXeegrdDBGEbQltr0E3niQlPmGsrvV1AIcQA=; b=obJNvxuDYRmXOhnzrCkICh5HBw
	BXHtwOW/lFdNmrivFjCW3TMe27FdHA/ZFw40SMfexgW0SzeNpNXg9Vns/alM6TRrqkI9GEuwGqrog
	GXQJYl0SW8+E3+u/ls9rsMqVhetAUsFrqJfH6sVY4EZkDcaCkxVjvqD5Ib7AHiB6x+eUVahrcHS/T
	UumxVay4PbaY2CqkBaW4Qcnox1s5wV03aLZm4tHtLzn5Dtfi7AEH4466GdG0H85HUndhHUbPLjRm1
	0uugn6XPyPxOhkpEFFXms+rmHdGNSuuqNC/p2DiUMU+3xWvPBYGPtCVbSnQEFzkOMJRuLdlpd7hHz
	M0Z1hSBg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnCfl-004TYP-07;
	Fri, 24 Jul 2026 09:58:29 +0000
Date: Fri, 24 Jul 2026 02:58:24 -0700
From: Breno Leitao <leitao@debian.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, puranjay@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Message-ID: <amM1xUOhcpGpqIpe@gmail.com>
References: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
 <20260720153917.2e428e489cd0873ac6d4e6da@linux-foundation.org>
 <5b83b0a0-708a-458a-bdbd-41c6d4610349@paulmck-laptop>
 <amCT9QEgJRsLIb_y@gmail.com>
 <ffa5d8d2-1157-4a30-995c-ddae3566e3a4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa5d8d2-1157-4a30-995c-ddae3566e3a4@paulmck-laptop>
X-Debian-User: leitao

On Thu, Jul 23, 2026 at 08:56:58AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 23, 2026 at 06:26:11AM -0700, Breno Leitao wrote:
> > Hello Paul,
> > 
> > On Mon, Jul 20, 2026 at 09:21:17PM -0700, Paul E. McKenney wrote:
> > > On Mon, Jul 20, 2026 at 03:39:17PM -0700, Andrew Morton wrote:
> > > > On Mon, 20 Jul 2026 06:23:45 -0700 Breno Leitao <leitao@debian.org> wrote:
> > > > 
> > > > > kmemleak_scan() can run for ages on large debug kernels. It was
> > > > > causing some soft-lockups which I got fixed with commit
> > > > > 3175fcfec8b16baeb ("mm/kmemleak: avoid soft lockup when scanning task
> > > > > stacks") with our beloved cond_resched().
> > > > > 
> > > > > I've got the fix above deployed in the Meta fleet, and now I am seeing:
> > > > > 
> > > > >   INFO: rcu_tasks detected stalls on tasks:
> > > > >     task:kmemleak state:R ... nvcsw: 274/274 holdout: 1 idle_cpu: -1/3
> > > > >      scan_block
> > > > >      scan_gray_list
> > > > >      kmemleak_scan
> > > > > 
> > > > > and, worse, blocks the callers waiting on that grace period. Here a BPF
> > > > > struct_ops map free, which waits via synchronize_rcu_mult(call_rcu,
> > > > > call_rcu_tasks), is stuck long enough to also trip the hung task check:
> > > > > 
> > > > >   INFO: task kworker/...:bpf_map_free_deferred blocked for 122 seconds
> > > > >      __wait_rcu_gp
> > > > >      bpf_struct_ops_map_free
> > > > > 
> > > > > Then I've learned that cond_resched() is not an RCU-tasks quiescent
> > > > > state, so, we need to use stronger primitives.
> > > > > 
> > > > > Use cond_resched_tasks_rcu_qs() at the scan reschedule points so the scan
> > > > > reports an RCU-tasks quiescent state as it proceeds.
> > > > > 
> > > > > Inspired by commit b96285e10aad ("tracing: Have osnoise_main() add a
> > > > > quiescent state for task rcu").
> > > > 
> > > > I'll add
> > > > 
> > > > Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
> > > > Cc: <stable@vger.kernel.org>
> > > G
> > > Thanks to all three of you!
> > > 
> > > This adds fewer than ten calls to cond_resched_tasks_rcu_qs(), but still
> > > more than doubles the number of such calls outside of the RCU subsystem.
> > > 
> > > Which is most likely just fine, and in any case absolutely should not
> > > get in the way of Breno's patch, which after all solves a real problem
> > > in the here and now.
> > > 
> > > Nevertheless, on the off-chance that over the next few months or years
> > > we start playing cond_resched_tasks_rcu_qs() whack-a-mole, I figured it
> > > would be good to get a head start on writing up alternatives.  An initial
> > > draft may be found here:
> > > 
> > > https://docs.google.com/document/d/1s3fn29SCTYVw9jak4iraNIVQR59Wk5C6_I-_eu-MfQA/edit?usp=sharing
> > > 
> > > TL;DR:  Should we get into a rousing game of whack-a-mole, alternatives
> > > include continuing as we are, making the existing calls to cond_resched()
> > > in turn call cond_resched_tasks_rcu_qs(), decoupling mutex-induced
> > > hung-task warnings from synchronize_rcu_tasks(), and various
> > > not-so-practical alternatives to RCU Tasks for trampoline synchronization.
> > > 
> > > Thoughts?  Especially thoughts on other schemes?
> > 
> > While debugging this issue, I was surprised to discover that cond_resched()
> > doesn't provide RCU-tasks quiescent states. That led me to
> > cond_resched_tasks_rcu_qs(), which is the stronger primitive needed for
> > long-running kernel threads like kmemleak_scan(). Is this the common
> > case for cond_resched()? I got the impression that kmemleak is the
> > extreme side, but, I have no data on this.
> 
> And that discovery did in fact lead you correctly, and hence my
> giving you a Reviewed-by.
> 
> > Worth noting that commit 7dadeaa6e851e7 ("sched: Further restrict the
> > preemption modes") continues to narrow PREEMPT_NONE, so the future of
> > cond_resched() itself may be uncertain, no?
> 
> Especially given that one of the explicitly stated goals of lazy
> preemption was in fact to eliminate cond_resched().  ;-)
> 
> Getting back to your point about kmemleak possibly being extreme, as far
> as I know, none of us have data on how many conversions of cond_resched()
> to cond_resched_tasks_rcu_qs() will be required, or, for that matter,
> how many additions of cond_resched_tasks_rcu_qs() above and beyond
> current cond_resched() instances will be required.

I've searched for "rcu_tasks detected stalls on tasks" on Meta's
fleet "dmesg depot" and I was suprised to see we have many of them, in
which seems to be on hypervisor workloads (running VMs).

> There were concerns raised off-list, so I figured that it was time
> to lay out what we do know, hence the above gdoc.  I very much hope
> that we don't need many more calls to cond_resched_tasks_rcu_qs(), and
> thus that the time I spent writing that turns out to be wasted time.
> But better safe than sorry!

The document was not a waste of time. it helped people like me to
understand what the issue is, and what are the decisions we have ahead
of us.

Back to what is the best decision/design, I honestly don't have an
opinion, but I am happy to get more data about Meta production servers
to help with the decision.
