Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591F342160;
	Wed, 21 Jan 2026 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010778; cv=none; b=my9KOBHlhbmPHZpxXX6NWVaszyvS0Ga2+3zzK1DmtDPGTQ4G5un3fmFSsiZAlVMt6uFtlfbg4Fb3lM2HPENdNtL5L0G89JYuzeb5upMydu+pPidIa1ZlBDparSKW+NSZzy3r9rXUNMDKHWTfEVBJAOVUl5gIVBoRsPm8v/6LRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010778; c=relaxed/simple;
	bh=B7+18QsP3veBxvAAtERrqukqJoU1/a0NGZY1fvasvbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ub/6s8iXZPpXfYedqaAoyrdGpLsi7LbQequ6ZipDvmVjrKtURqvSBjRPo+rsyw5IpxLeMqVNYjLClfSXnyyQrb0wqPoVq6Y7o/P89/NlCG9rn79bvtTUdCvjvw8JuIV7g+ofUrXO+baC/UQ+oaN9EGieg0+8ClpOYNO7f8AfI5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OjZ/wIIK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OjZ/wIIK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CguewfHFiRxF5YFLsOMX0TcS/+YsoSfUST61pt01c8A=; b=OjZ/wIIKihVpabDa4O3+yICFlj
	HV1YI9b0sLfzN33TVQaFBGOtsYBBD84v0K042ig/HFNuwyrBJ6w3fifKAcUVl9UhRNtEzNO/fMKjW
	PFv5ZKOBVTmWlL+WwsQ8ZIbbUWilUUc09SJFCUIwes+EK6wsAWDVqoHaNPODNs6DdixIzhAx4XqfK
	XL80aN9z9rfZtYiT9/QLyY43gqT/LJNXHb7pkZ9M3jfQcstb+ztk7V0J62wmj4AIZ7P+BDB42CXU2
	lptbODF+ITIN59VfCyS4msR9u9EbF7D1Am0IpLrNs3ZsE4QBY3Mx2CyyALkkv5rJDPzdmf4VX1ZPj
	EJe+NN5g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viaVi-0000000GYhS-3kCq;
	Wed, 21 Jan 2026 15:52:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C616E300329; Wed, 21 Jan 2026 16:52:45 +0100 (CET)
Date: Wed, 21 Jan 2026 16:52:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <20260121155245.GG166857@noisy.programming.kicks-ass.net>
References: <20260120215808.188032-1-arighi@nvidia.com>
 <20260120215808.188032-5-arighi@nvidia.com>
 <20260121122901.GA166857@noisy.programming.kicks-ass.net>
 <aXDLYj0_VnbVZkJE@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDLYj0_VnbVZkJE@gpd4>

On Wed, Jan 21, 2026 at 01:49:38PM +0100, Andrea Righi wrote:
> On Wed, Jan 21, 2026 at 01:29:01PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 20, 2026 at 10:50:35PM +0100, Andrea Righi wrote:
> > 
> > > @@ -1813,6 +1813,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
> > >  	hrtimer_try_to_cancel(&dl_se->dl_timer);
> > >  	dl_se->dl_defer_armed = 0;
> > >  	dl_se->dl_throttled = 0;
> > > +	dl_se->dl_defer_running = 0;
> > >  	dl_se->dl_defer_idle = 0;
> > >  	dl_se->dl_server_active = 0;
> > >  }
> > 
> > This should definitely not be in this patch. Why was this added? Were
> > you trying to do the same as:
> > 
> >   ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable tasks")
> > 
> 
> The problem is that if remove this, RT can completely stall EXT tasks, also
> with ca1e8eede4fc applied.

But that's not something ext specific, right? Can you pull this change
out and write a sane Changelog for it, describing the problem and so?
