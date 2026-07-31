Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1FD47011E;
	Fri, 31 Jul 2026 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521944; cv=none; b=eHHzbKs8Ll5y/gwlq4JEqFg7zL49B7S9BkX/3f4eK6QiSXdm6v8IsnRnnKZpuHpN+TR8lvaLbGhqs6KIooZaJNmxESRxZaWfiwQFSHeCxdDu/Gp2zZ/QGYfUmmt6uySpce+rrMEXbtsqct/asXj31217aJdzPr+E7RB2SjGpWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521944; c=relaxed/simple;
	bh=So5VRdi36YGuQJ2KWUDBRq2zgH+ID8hJP0Zw+co7UmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/1XWGO7etP1eCo2zJdDrzGDFfKAfeF3vlKMqWDzbfJWVhJ9GpmuL/VLRbMvVN/sjmpdcEAZsqkkt6HGsA6qoqd1I7g/ZlVPgoOlpP++4MnoUmA1tXefD1SaBt2M27h+WVKhcA0lQbqaClD6gRJXnkBntk1Cdg178N08UDlzpMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0b7YZk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0b7YZk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353101F00AC4;
	Fri, 31 Jul 2026 18:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785521943;
	bh=nSWPqMz7Q6UQotLRcbGZUaRbsx3pPGFQF/kK6NROqrA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=J0b7YZk7aQZOrwvpJjnA8XFX5gO2kMBIu+uo7OflScYO/Ba8XfcsEAp1dXrZVYXLr
	 lOG7b3fk0d5WW2lmxsSS+d2CTBzpG5TYqXdnxUBy6MPBuz8lSJE31nfZIB2rbKRWJF
	 TqSinhyHjnMd8O7Uh9+CRQ/+A0pGGcPItg895F8TiG3I3qPuyCMRr28Kr/byrTypGS
	 e91TCJzVOCmpZjG01MvicwJQ38eTgg/a2ubLgUKeGw526Hig21KjDBkke28+J+hchJ
	 3AIF3z4FafdEvrnUVlQLQNXxkmKx1F9O7cxa8ASSngumXrVim+vw2B8lxH4DBVIuil
	 pPth+Z83pNiKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D7D73CE11BE; Fri, 31 Jul 2026 11:19:02 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:19:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: rostedt@goodmis.org, pjaroszynski@nvidia.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>, puranjay@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com, dcostantino@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Message-ID: <23a60deb-c73a-47da-bd5b-4bf3c1c1bc8a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260720153917.2e428e489cd0873ac6d4e6da@linux-foundation.org>
 <5b83b0a0-708a-458a-bdbd-41c6d4610349@paulmck-laptop>
 <amCT9QEgJRsLIb_y@gmail.com>
 <ffa5d8d2-1157-4a30-995c-ddae3566e3a4@paulmck-laptop>
 <amM1xUOhcpGpqIpe@gmail.com>
 <39c90e82-f785-4b47-9571-dd4b1339d685@paulmck-laptop>
 <amdWVTs0WKOxguxP@gmail.com>
 <amtZNwxZ3gpOsPER@gmail.com>
 <743bf971-b4aa-416b-b72b-88b538be727a@paulmck-laptop>
 <amzjjjZrseO-jMJL@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amzjjjZrseO-jMJL@gmail.com>

On Fri, Jul 31, 2026 at 11:07:44AM -0700, Breno Leitao wrote:
> On Thu, Jul 30, 2026 at 07:57:22AM -0700, Paul E. McKenney wrote:
> > > I suppose we want two things:
> > > 
> > > 1) change cond_resched() with cond_resched_tasks_rcu_qs()
> > > 2) Avoiding holding the ftrace lock while calling
> > >    synchronize_rcu_tasks()? It can take up to 10 minutes on a healthy
> > >    system to be releasd, right?
> > 
> > I do very much like both of those options.  ;-)
> > 
> > If #2 is impossible, would it make sense to have a mutex_lock_idle() or
> > similar in order to sanctify the lock synchronize_rcu_tasks() latencies?
> 
> How would mutex_lock_idle() differ from a regular mutex_lock() when
> sanctifying synchronize_rcu_tasks() latencies?

It would sleep at TASK_IDLE instead of TASK_UNINTERRUPTIBLE, as shown
below.  This would cause it to be ignored for hung-task purposes.

For a similar example, RCU uses swait_event_idle_exclusive() instead
of swait_event_exclusive() to avoid its grace-period kthread getting a
hung-task warning when the system doesn't need a grace period for more
than two minutes.

Yes, I did learn about this the hard way.  Why do you ask?  ;-)

The downside is that if some bug somewhere else under one of these mutexes
caused a too-long sleep, that too-long sleep would be silently ignored.
As always, choose wisely!

							Thanx, Paul

------------------------------------------------------------------------

static noinline void __sched
__mutex_lock_slowpath_idle(struct mutex *lock)
	__acquires(lock)
{
	__mutex_lock(lock, TASK_IDLE, 0, NULL, _RET_IP_);
	__acquire(lock);
}
