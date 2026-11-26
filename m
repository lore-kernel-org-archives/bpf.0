Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686253;
	b=Zom/7HIEZ7YDu2cVIL+w0+hp5929a2iqRS0mWZ9xj30s3+H/e+/FgrvYdafAEfM709wY
	 wt62wFAKRCvf8BrE54XHFLi4FjNGjk9ykfF74tI5Q0QzW0B+eBhGRoZApEjzrJplWTV6n
	 USZ4l/cS1wrB7yCeJRSj6XlI4tfbQ5NXAvFllKjqHWYLZqwfqle1OcOWZ5/NiTIV2280+
	 B8CNiCPwmCQJpO1vX/N3o/WUrdXp94I+JD4WZFnYMvEJszwh/9xpi31THZn3hs8Tu4OPJ
	 hBopvVq0SasJ5C6CD2n7V3axlzOg5Q8t65ptjwzS9fME2DLKM08rks7vorYGSwaDHRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686253;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=5VJC6n1hJwExr4EuZxRtgDyPGN93jbJ5pGv3/LKWlIo=;
	b=Jlb+qFSE78RuWfU5lepYskmpl9W0zNrhZiEIrGdvQAQp+XUElBKIxyXImjS6I+Eo0Lpd
	 oxyWEE1YnI0N/iLYMJzXjprreGrufISZsEGbBFGI707HgyXB0lYHtPBdV/yut2mXMuMiy
	 w2dKNt5g6J7s/zG6qpvklJ5t65BfkDm9VrxmgztSzwPynXRIdBElgurVuokyzDXaXMSUN
	 YTMVFzTZq7igNuFB4Malc1J+zeO7KhR6zwAMS2omaTr8r+kqHiTDVkauoHpZaRgPveY92
	 UiKfjQAZL6ucprWxEXUnpibJL/YY7N0DrsrHDKLUe24wsbVP61uM6WrnDdcXrcNnCNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=mYfWrggO;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B0606A326;
	Thu, 26 Nov 2026 09:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA3B0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=mYfWrggO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5VJC6n1hJwExr4EuZxRtgDyPGN93jbJ5pGv3/LKWlIo=; b=mYfWrggOtGDgLQkraxk8jwrHB9
	I0YDFhk6XT5etnPyoX7WtgS/UG7Y5XbpzoWR3LOGdonMJL6mlPpFRrsmoLV/k8taYMZpY+Pa3aAvV
	6ONbVWf3P1iUw7L76jKLpH9pX+NQr/HDb54L4qzairth1l7jYLEXFjS4TjwAD1jyxYAQDESMcFuvD
	iJtGYxRCQeuauFaP0vlRuko+VUg0KLUOXMNo0CH0Tch0ZCy2UtzXG1jR7E/HLKtyrh9c9glWXBWPM
	J60mFEEn5NaM2khTXcsaRRwJTjIVyBN4pS1nwgG3EBhoRHkYj8nBFUEMb3sxB1aN3Xgu3zL9Rc7bP
	kQpRBbkQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWW1M-00000000Ch3-3rUU;
	Thu, 26 Nov 2026 09:44:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C61DA300446; Thu, 26 Nov 2026 10:44:03 +0100 (CET)
Date: Thu, 26 Nov 2026 10:44:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Harry Yoo <harry@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, daniel@iogearbox.net,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Vlastimil Babka <vbabka@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
Message-ID: <20261126094403.GA49833@noisy.programming.kicks-ass.net>
References: <20261124060357.11700-1-emil@etsalapatis.com>
 <20261124060357.11700-2-emil@etsalapatis.com>
 <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com>
 <awWRZ9xCzWLnj_R6@thinkstation>
 <20261125140902.GE2668804@noisy.programming.kicks-ass.net>
 <DN4QLI2XAGO1.2DDIFJ49PNRPS@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DN4QLI2XAGO1.2DDIFJ49PNRPS@gmail.com>

On Thu, Nov 26, 2026 at 01:04:27AM +0000, Alexei Starovoitov wrote:
> On Wed, Nov 25, 2026 at 06:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > This is absolute atrocious shite. You cannot attempt a spin_trylock from
> > NMI context. That thing might be a mutex.
> 
> cannot spin_trylock from NMI _on PREEMPT_RT_ ... correct.
> And the patch guard against that.
> 
> On RT the nolock path doesn't reach zone->lock in NMI or hardirq:
> 
>   __alloc_frozen_pages_noprof()     alloc_flags has ALLOC_NOLOCK
>     alloc_nolock_allowed()
>       can_spin_trylock()
>         if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
>                 return false;
> 
> fwiw kmalloc_nolock() has the same check.
> 
> > This should not work; if it does, that is an accident we need to fix.
> 
> It's not an accident.
> In NMI only !RT SMP kernels reach the trylock.

Allowing this on !RT makes people think this is 'OK' and then the RT
people get to fix endless crap again :-(

Locking constructs should behave identical across the configurations to
avoid divergence and create problems.

You're actively creating something that doesn't and cannot work on RT.
That is not cool.
