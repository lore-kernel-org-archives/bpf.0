Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A13C37FF79;
	Wed,  4 Mar 2026 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619082; cv=none; b=uGkjd7jzvNkPhl2gSvwo03/hPkORJAfqIlYa+SWHIk+YSIwQPJ8oPqmkIwAVLj5mhwGDokIDIY74ckRoHLLzOBQFsbg5AbwLFtn4y0/zcP72gDo2XMpftTxj7YVfovgO2ovF6DE+Pe/Y109wA7R5QZQGYW5f6WrlOUznXZj5ENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619082; c=relaxed/simple;
	bh=JQb85VHaICruah/Qdpes4o76dLFKahkK2tO0kdC0Zes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWpgR5LFvxfvfmnMAWhjBFI/vDz5sp4sc5M6yilGiKEMbn3hhlrdmZBeL4xICgzROarQK4KKC/DGS1VjC+ZcAzSikfsFVDUymS71tgESFbfCkazp81GyRFg6f0yDw7bFRw6L/i+AkOtWiaRuSOzpMaqYshPCceR2u9jgFNELIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rUeaCfku; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rUeaCfku"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mJ2CiEyAFUElfaXb6N8aGN32kS3DPoLsnA9tyI9dOKo=; b=rUeaCfkud2aiYXkPwCcJPWE/Vk
	5rCfxeOOOsPCyP3EiNQET/HAIoe2iR1s1jU/f3+3rmcBxFgQeCuM+8mqqL4lpJYZBtM3NNuAPSKB/
	vNRHhOUBrOdImQklwGpT9k3IDJT+Hn8vTlUPHRGPbEJkEZhl6Adf8w7s3+ngy7jQVHyvLmCyVypPY
	P5LMlC2b6bcihJ9xUsyrXcCCo1c+CaPfnMSHwSGTAo60oXhG3GBuFpiEzniCC+RNBDCYXZhBk0oOD
	mXF9tVdAynM1BfrAUul741D8VdCKV0CTcq6+ghfHHR7tzLn8wXG3evoV7EsDr9LF4Ix/NYZ8lSXjm
	tGKdG0LA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxjCC-0000000D65V-0Ugp;
	Wed, 04 Mar 2026 10:11:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5FFE1300B40; Wed, 04 Mar 2026 11:11:11 +0100 (CET)
Date: Wed, 4 Mar 2026 11:11:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260304101111.GQ606826@noisy.programming.kicks-ass.net>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
 <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net>
 <CALOAHbC1AHc2eZrzafz7ynrW7NFPrVmervCY_jjWsRTo0gBwQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbC1AHc2eZrzafz7ynrW7NFPrVmervCY_jjWsRTo0gBwQQ@mail.gmail.com>

On Wed, Mar 04, 2026 at 05:37:31PM +0800, Yafang Shao wrote:
> On Wed, Mar 4, 2026 at 5:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Mar 04, 2026 at 03:46:49PM +0800, Yafang Shao wrote:
> > > Introduce mutex_lock_nospin(), a helper that disables optimistic spinning
> > > on the owner for specific heavy locks. This prevents long spinning times
> > > that can lead to latency spikes for other tasks on the same runqueue.
> >
> > This makes no sense; spinning stops on need_resched().
> 
> Hello Peter,
> 
> The condition to stop spinning on need_resched() relies on the mutex
> owner remaining unchanged. However, when multiple tasks contend for
> the same lock, the owner can change frequently. This creates a
> potential TOCTOU (Time of Check to Time of Use) issue.
> 
>   mutex_optimistic_spin
>       owner = __mutex_trylock_or_owner(lock);
>       mutex_spin_on_owner
>           // the __mutex_owner(lock) might get a new owner.
>           while (__mutex_owner(lock) == owner)
> 

How do these new owners become the owner? Are they succeeding the
__mutex_trylock() that sits before mutex_optimistic_spin() and
effectively starving the spinner?

Something like the below would make a difference if that were so.

---
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index c867f6c15530..0796e77a8c3b 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -521,7 +521,7 @@ static __always_inline bool
 mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
 		      struct mutex_waiter *waiter)
 {
-	return false;
+	return __mutex_trylock(lock);
 }
 #endif
 
@@ -614,8 +614,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
 
 	trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
-	if (__mutex_trylock(lock) ||
-	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
+	if (mutex_optimistic_spin(lock, ww_ctx, NULL)) {
 		/* got the lock, yay! */
 		lock_acquired(&lock->dep_map, ip);
 		if (ww_ctx)

