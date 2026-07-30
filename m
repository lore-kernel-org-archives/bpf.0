Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63CC432E94;
	Thu, 30 Jul 2026 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423443; cv=none; b=k34YEQ7xYgYpDRhRlzBUyOnAiVy/9t5qWz1h9MMyYtBD0xLDov65T0yhHHD0aH3XeLaQX4gzwcS8c3Kt8XXumz0jlNN10YMKsI44bC63Tl1dZkFxNQpIDpXSCutsjjeezNte7GQYK4oIoHhrrjOVj0BafTk9Ee2DSJZA/W6vdBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423443; c=relaxed/simple;
	bh=/6eL44vUU82DyKAD/kAe3o6MpNSDG9GtaHuMbgHi6fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=julvuRwbsavUaD8jkm/HDBur2iIAZAKksH8o+RP1Fj37ubYJ/Fi6vpSVtCl8ONRf5YKNr0iIIwm8BdbusWzdKLLfI88JzLVwo+5+4yvNzAgVxi6i17BgeZn+GCVz9Mqvn+3E9sioWSTmIg2l6MbldJUyrJ98zjWapTe6AaPdOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsQV55i0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsQV55i0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABCB1F000E9;
	Thu, 30 Jul 2026 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785423442;
	bh=WkKl3ci3MCuftUDDJxohW0fa4aHGCJW3D+bUpPt0I40=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=NsQV55i0BK3zViDbsYCSN5J+aJlNoLrty9bwn3E4zmMZY8zc30aqqmyB8ysg2yGiL
	 agXR0w0gi3Kc0fDAzHnRgO+CKgHHhcIDcUVMDSB3MsYOtYqGE3yBOnzIaJieAWVuC/
	 P6YrxRnLQiC4BY50DosJjF63bbIl9nQsc6E49JwDic5fyFqoeep5sWz0zLSNDEFCDT
	 tWabWzikFVGfqFucHHTUE1o1mQmM1Gy0s7JKeQdtXANPpBfasR24mydA5y+3IRWbLg
	 mpFS8F0mzP8PmuJIFqFh6L9l060CLLHLyKh1i7iwXY0RpQyffnr1pq2L8QQ9hpOxaX
	 QVg/U66UTMS7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6D043CE0B67; Thu, 30 Jul 2026 07:57:22 -0700 (PDT)
Date: Thu, 30 Jul 2026 07:57:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: rostedt@goodmis.org, pjaroszynski@nvidia.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>, puranjay@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com, dcostantino@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Message-ID: <743bf971-b4aa-416b-b72b-88b538be727a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
 <20260720153917.2e428e489cd0873ac6d4e6da@linux-foundation.org>
 <5b83b0a0-708a-458a-bdbd-41c6d4610349@paulmck-laptop>
 <amCT9QEgJRsLIb_y@gmail.com>
 <ffa5d8d2-1157-4a30-995c-ddae3566e3a4@paulmck-laptop>
 <amM1xUOhcpGpqIpe@gmail.com>
 <39c90e82-f785-4b47-9571-dd4b1339d685@paulmck-laptop>
 <amdWVTs0WKOxguxP@gmail.com>
 <amtZNwxZ3gpOsPER@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amtZNwxZ3gpOsPER@gmail.com>

On Thu, Jul 30, 2026 at 07:06:44AM -0700, Breno Leitao wrote:
> On Mon, Jul 27, 2026 at 06:04:37AM -0700, Breno Leitao wrote:
> > I found 3 different cases on Meta fleet, where rcu task stalls show up:
> ...
> > 3) Nvidia driver
> >   * stuck in nv_procfs_read_lock_params
> 
> I've investigated this issue. The nvidia driver contains the following
> locking pattern:
> 
>         static inline int nv_down_read_interruptible(struct rw_semaphore *lock)
>         {
>                 while (!down_read_trylock(lock))
>                 {
>                         if (signal_pending(current))
>                         return -EINTR;
>                         cond_resched();
>                 }
>                 return 0;
>         }
> 
> Code at: https://github.com/NVIDIA/open-gpu-kernel-modules/blob/452cec62d827034798072827d3866d1881662b77/kernel-open/common/inc/nv-lock.h#L54
> 
> The lock is never acquired, and cond_resched() provides insufficient
> scheduling relief.
> 
> This triggers a more severe issue with ftrace, which holds ftrace_lock
> across RCU synchronization:
> 
>         mutex_lock(&ftrace_lock);
>                 ftrace_shutdown(struct ftrace_ops *ops, int command) {
>                         synchronize_rcu_tasks_rude();
>                         synchronize_rcu_tasks();
>                 }
>         mutex_unlock(&ftrace_lock);
> 
> Since nv_down_read_interruptible() spins indefinitely, ftrace_lock
> now becomes completely wedged.
> 
> I suppose we want two things:
> 
> 1) change cond_resched() with cond_resched_tasks_rcu_qs()
> 2) Avoiding holding the ftrace lock while calling
>    synchronize_rcu_tasks()? It can take up to 10 minutes on a healthy
>    system to be releasd, right?

I do very much like both of those options.  ;-)

If #2 is impossible, would it make sense to have a mutex_lock_idle() or
similar in order to sanctify the lock synchronize_rcu_tasks() latencies?

							Thanx, Paul
