Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA24499B4;
	Fri, 25 Sep 2026 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334355; cv=none; b=CcMra00HDel3chwOqArcHi51V8B2QQ7Trb6Uv/ErWY1/x2L1Rg0sTNqpt92qEJDMQhiPP9M4/mTqccUmLptbOPbalv0fHCSoN3eNgfoNfrhhbly8Bm1Pnf4vneDEHDqtZPMQ8cpfl+lEmb8gmsvXWJeabeZHRzdOxlXbRebrYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334355; c=relaxed/simple;
	bh=CUhCpdz8tt03eSKXk++H4u+G6MM/Tj3vR9rRryuBWLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8SPSimAwrnPmqAmERWJhPkz9/Hc28Birqir63TsIjAKf3KM27qkk7iJ3qUolzPdtyKrbGB0rcJsq4Ra67rcuj9RIxS2PEuGJBkmnNcSJg4eg2PAu50Ds6E+1s9yABHndh8waemihMdw1jTlZPTyueeaUIjauppJ/PZ2escpYSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meYS47Io; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meYS47Io"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCDF1F000FF;
	Fri, 25 Sep 2026 11:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790334352;
	bh=27mmdRe0c97tdgwqbWs0K9g6YrSbSDeo1umZRUDrFfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=meYS47IoTaFKQc6f4C/nVr4qaaju9aGhhYFXiJo0fHDir4+QAKlQsl+Egv4c7OSwd
	 umEFQlktLCJ9Mwq0ZCKOjdVV2tEzaNMeOHrMj+i547WlbrgYNnNVZy5JeWrcjz0qF3
	 M/N8n/arCSZHAzNQeG6baKscn3Ks/tPyCb8RSu41N3X+o/8SOnSqM/DabrT+iRJyrI
	 VmEWktPKlPeuRkJ9YQDThxJ/fa2OZW+ESpzcIQ5I0YT7ElW8xfsEWzR5dwRjTP0zdK
	 Rt3rY/Y4YAk09pJ7knDgd9SpSJDN3n3+J2w81RCNBkosK/8uPN1rq0P8PZSoG+Vf7N
	 O7epnMVRcYjgA==
Date: Fri, 25 Sep 2026 12:05:50 +0100
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Karl Mehltretter <kmehltretter@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Amery Hung <ameryhung@gmail.com>, 
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: restrict can_spin_trylock() to preemptible
 context on PREEMPT_RT
Message-ID: <arZVV6Vq-ZJuCyun@thinkstation>
References: <20260919171443.90512-1-kmehltretter@gmail.com>
 <DLJHZEZMLW0F.27OPPS218CX9Q@gmail.com>
 <arIY0wMQjCCsqidI@gmail.com>
 <DLO3RV3IQUOV.21BNLF4QS9T4W@gmail.com>
 <c2f8eb01-7a10-4ccb-92f1-eece29c06cd4@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2f8eb01-7a10-4ccb-92f1-eece29c06cd4@kernel.org>

On Fri, Sep 25, 2026 at 09:29:16AM +0200, Vlastimil Babka (SUSE) wrote:
> On 9/25/26 06:12, Alexei Starovoitov wrote:
> > On Tue, Sep 22, 2026 at 08:04 AM Karl Mehltretter <kmehltretter@gmail.com> wrote:
> >> a) Change MM so _nolock() allocation remains safe and can still succeed
> >>    while pi_lock or an rq lock is held. Existing BPF behavior would
> >>    remain unchanged. Is this feasible, or would it require substantial
> >>    allocator changes?
> > 
> > I don't think it's feasible. On RT the sheaves lock, n->list_lock and
> > zone->lock are all rtmutex based. When trylock succeeded and a waiter
> > showed up rt_spin_unlock() has to wake it.
> > 
> >> b) Restore BPF local storage's dedicated allocator, and document, with
> >>    debug checks if possible, that _nolock() must not be used in those
> >>    scheduler-lock contexts.
> > 
> > No. Local storage is not the only one. bpf_arena_alloc_pages(),
> > bpf_stream_vprintk(), bpf_task_work_schedule_*() call kmalloc_nolock()
> > as well and the same sched_waking prog can call them.
> > bpf_mem_alloc was removed from local storage, because it wastes memory
> > on preallocation. Same answer for d).
> > 
> >> c) Have MM detect those contexts and return NULL. This prevents the
> >>    deadlock while preserving ordinary raw-lock callers such as arena,
> >>    but task-storage creation from scheduler tracepoints then fails
> >>    deterministically.
> > 
> > This one.
> 
> Yeah, but how exactly to do that detection :)
> 
> > bpf_task_storage_get() with F_CREATE can return NULL and the progs
> > have to check for it anyway.
> 
> e) Introduce raw_local_trylock_t...

+1 on this :)

> >> Are these the right alternatives? In particular, what behavior is
> >> intended from the _nolock() API in these scheduler-lock contexts?
> > 
> > It can be called from any context and it can return NULL.
> > That's what it does from NMI and hardirq on RT already.

-- 
Cheers,
Harry / Hyeonggon
