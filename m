Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110578F3A;
	Wed, 30 Sep 2026 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732010; cv=none; b=kg+LpSw5Q1HMq5O5f370cQFwwi0VOUXcArWJNWpLVi6Nt9mEBBx7vlnkmiqh9hVzEB9grMVh2WR+1zDKPtEI8acBEDgCFapFHKlQPLWxO2ntb+0U2/quZb4rmcxenN/Pco6oRkkFMqFilBZnfrPbiTW4kUOzQFZhjB+B8czOXM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732010; c=relaxed/simple;
	bh=YSVmkmi1ikpMMqEeXfU+2dZ+SR2KUO762Kq7vjBBdwc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FUdi8YAbbr8SKMQ2p4YV2J6yhn7U3N2IrCFBYM/yBNGjjsWeL5xn5bI5JeNTOtnS0tlUyxicNIddWyAxGcM0mTZoEkZrzX0nIxEgyC/uoJz2l2fJf6czeJSkQDLmE5SX0T6q9thfAyFocbaY2YB7Zd7wFdv8I56EL2fMZv78GFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVOqrf4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVOqrf4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171E71F000FF;
	Wed, 30 Sep 2026 01:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790732009;
	bh=1KjwthvQCbBo4aisL7sqZxIkYiI+s62XYB1p6NJwq20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nVOqrf4OKdZfXyOB+vwp0Tv2jghDegwxSZcUM0flltH5rfizzW+kc9HcAOVHQL1z+
	 nzBTwigLgzljpUEMCRxzHKfM06IlgK4vgtBfU88mBRcaXWfDp9xev4xrWUGWnq6qBc
	 fJW4shOz3iCoD2KjL0C4Mf7sYVfwtnzOlFNSxvocA+f8KgO0uatMvhqoJM3+Sfc39V
	 Ju3YMdeYEAwLjATZ1E8shmu1xDDsYgPk2wwhFp/ilTAOcJbSCFS0zXxC9+d5hRxItI
	 iiMMVFgDDz2tYcjilpT4pMOCKvAc3XDF5dQi0RHokBvoe59LLuLNGO1bg5psTA6zCJ
	 p3VJ/4PniEFsg==
Date: Wed, 30 Sep 2026 10:33:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] kprobes: Make optprobe optimizer
 multi-generational and asynchronous
Message-Id: <20260930103326.161812f00774be79848248ab@kernel.org>
In-Reply-To: <20260930001024.4F2371F00893@smtp.kernel.org>
References: <179072636063.409480.10967951178575355535.stgit@devnote2>
	<20260930001024.4F2371F00893@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 00:10:23 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] kprobes: 100% CPU busy-loop livelock when flushing optimizer
> - [High] kprobes: memory leak of optinsn slots during async unoptimization
> --
> 
> commit 9f64df8dc4c148639fefa4dcd4859438e335848a
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> kprobes: Make optprobe optimizer multi-generational and asynchronous
> 
> This patch decouples kprobe jump optimization from synchronous waiting by
> moving to an asynchronous, multi-generational model using call_rcu_tasks().
> 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 4edd8ca5c6578..377fa9bfa0291 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> [ ... ]
> > @@ -588,17 +653,25 @@ static void do_unoptimize_kprobes(void)
> [ ... ]
> > -/* Reclaim all kprobes on the 'freeing_list' */
> > -static void do_free_cleaned_kprobes(void)
> > +/* Reclaim all kprobes on the 'free_list' */
> > +static void do_free_cleaned_kprobes(struct list_head *free_list)
> >  {
> >  	struct optimized_kprobe *op, *tmp;
> >  
> > -	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
> > +	list_for_each_entry_safe(op, tmp, free_list, list) {
> > +		struct kprobe *_p;
> > +
> >  		list_del_init(&op->list);
> [ ... ]
> > -		struct kprobe *_p = get_optimized_kprobe(op->kp.addr);
> > +		_p = get_optimized_kprobe(op->kp.addr);
> >  		if (unlikely(_p))
> >  			optimize_kprobe(_p);
> >  
> > -		free_aggr_kprobe(&op->kp);
> > +		free_aggr_kprobe(&op->kp);
> >  	}
> >  }
> 
> [Severity: High]
> Does this leak the dynamically allocated optinsn memory slots?
> 
> Later in the patch, kill_optimized_kprobe() is modified to intentionally
> defer calling arch_remove_optimized_kprobe(op) if the probe is queued,
> leaving the optimizer to reclaim it after the quiescence period.
> 
> However, when do_free_cleaned_kprobes() runs to reclaim the probe after the
> grace period, free_aggr_kprobe() only frees the kprobe struct. Without a
> call to arch_remove_optimized_kprobe(op) here, the executable memory slots
> allocated for the optimized kprobes appear to be permanently leaked.

This is false positive. There are 2 implementations of free_aggr_kprobe(),
with CONFIG_OPTPROBES=y, it frees optinsn correctly.

(Hmm, this is interesting failure pattern. Maybe I should not make
 configure-selectable implementation except for empty alternatives.)

> 
> [ ... ]
> > @@ -624,67 +696,138 @@ static void do_free_cleaned_kprobes(void)
> [ ... ]
> > +/* Kprobe jump optimizer */
> > +static void kprobe_optimizer(void)
> > +{
> [ ... ]
> > +	/* Step 3: Wake up flushers and kick optimizer again if needed */
> >  	optimizer_passes++;
> >  	wake_up_var_locked(&optimizer_passes, &kprobe_mutex);
> 
> [Severity: High]
> Does unconditionally incrementing optimizer_passes here cause a 100% CPU
> busy-loop livelock?
> 
> When wait_for_kprobe_optimizer_locked() is called while a Tasks RCU grace
> period is in flight, it sees optprobe_optimizer_busy() is true and wakes the
> optimizer thread.
> 
> The optimizer thread wakes up, clears its flushing state, and calls
> kprobe_optimizer(). Since the RCU callback hasn't fired yet, it makes no
> progress but unconditionally increments optimizer_passes here.
> 
> This wakes wait_for_kprobe_optimizer_locked(), which loops, wakes the
> optimizer again, and waits for another optimizer_passes change. Both threads
> could spin in this tight loop until the Tasks RCU grace period completes.

Ah, good catch!
OK, to avoid that, wakeup flushers only if any progress has been made.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
