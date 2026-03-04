Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD1386451;
	Wed,  4 Mar 2026 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657833; cv=none; b=T06z1M9dwKw/B13AymwBGoTuQChPHIzf7lbdLz7OLUWyJEn21OXbQkXrlIurd01pw90wS3t25z5kpfdRzE1XCd8HQOGTj6v2pMmCLsMp+HvneVt1E+Y3RMmT1wK5bT+PZPXi1buaZ41lMO519nAddJ7GD6PoFqtQb7+u1mfbmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657833; c=relaxed/simple;
	bh=goleG5xEh9nKIj/CH15s94AJrWb6tZHcVBkd+Icywzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/JsUT0URPMyq3/XpTazeu1Y3+cuMokUXq5TnLWyYwQw/x5UENoStll0wLw6gxTXMna2LD5fX313Ihc1+9y4G7jFxV9dq2J9bS+dGBauMfjdZP6qTdetmo+d+VDAufeEuq78cE+8iLq4oJDgmLjFb4lp11xDGYLVdp04aygtfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8B86D1B86C6;
	Wed,  4 Mar 2026 20:57:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id EB6E26000F;
	Wed,  4 Mar 2026 20:57:05 +0000 (UTC)
Date: Wed, 4 Mar 2026 15:57:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Yafang Shao
 <laoar.shao@gmail.com>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260304155742.7b4de2d1@gandalf.local.home>
In-Reply-To: <20260304095415.4d5f2528@pumpkin>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
	<20260304074650.58165-2-laoar.shao@gmail.com>
	<20260304090249.GN606826@noisy.programming.kicks-ass.net>
	<20260304095415.4d5f2528@pumpkin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9cwb6pkfm3p6od6b979sj3waf9j43c4o
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: EB6E26000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/CmPXryFRYe46xRLZRPDgcG/rznNPPP/E=
X-HE-Tag: 1772657825-638681
X-HE-Meta: U2FsdGVkX1/x7VlKeu6WkOIhLiPgdiQkn3q9+28mOEy7yeN7IjGyZJWLwk5UUog36mxfdZYjw3FCVbhLQOKkX1XWCMvBzIgkBB8CuUxvheZlTgagoLfWGSzw9DIcoXevweR5/EHAABYG58W3bA4rw00PiCvOJfvm+2Uvn+j8Ncp/ybEWaVkZiX6844QbYbI8AwuodNeLyA3N0hG+dl05yqUci6eo7JDFs2ZMM4fTh0+vlXhV30D26JeGBHgF/cVl/MhMjB+EqVL0im2FfKB7uoADwyfWfBxqp63CHjgVUFsHMZBjWXLKnVR1zok88WgLIh+JpFlsxlnpZP9teKz0p6dhvEpO2how

On Wed, 4 Mar 2026 09:54:15 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> That might still be an issue if a high priority process is spinning.
> But a %sys spike doesn't imply a latency spike.
> 
> Is this using the osq_lock.c code?
> That will have problems on overprovisioned VMs, it tries to find out
> whether the hypervisor has switched out - but ISTR that is flawed.
> 
> In reality a spin lock shouldn't be held for long enough to cause
> any kind latency issue.
> So something in the code that reads the list of filter functions
> needs to be done differently so that the lock isn't held for as long.

It's not a spinlock, it's an adaptive mutex which spins while the owner of
the mutex is also still running on the CPU. If the spinner CPU triggers a
NEED_RESCHED or the owner goes to sleep, the spinner stops spinning and
goes to sleep too.

Honestly, this still looks like a non-issue or a corner case that I don't
think requires these changes.

This looks like one of those "Patient: Doctor it hurts me when I do this.
Doctor: Then don't do that." cases.

Why is a production system having multiple users cat
avaliable_filter_functions to begin with?

-- Steve
