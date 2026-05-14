Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274591FD4
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799799; cv=none; b=grzQZOMYwd7xBO0OnNG6djf/v46y4ZY4gl2N+UIkTzxiOcvEzftv7WqLSQ895wRYJO9SWUJurpLtC+2eBY3Azgif8IUpOep6FLKaGGqxQFIy3Tx0d8ZRy+F6Y35ogSRU/3nrb9MJAsR+WyNceAeYTc/j45wFW3AfJr3a8gHfO9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799799; c=relaxed/simple;
	bh=m+sn2JtBKkC28f4RBUg3uYcLXymKiPvSA8wKSHyhhNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq5ll8plYHeFQup6CGWaESZas/PoFwX1rH/PdWtEWYI68p4hwCYhZc7Y33MgeMTq/csvhhhf7Kdz07Nz3Xdn/b1QeE9GmXFFJueDLm3eNYY1Fj5qcEc7mH6I1YMY0d9LJd/T+kgxbrknbef0NPCLwAgYvxqSkao5BJ0n8iSzo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KMuc7ngL; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KMuc7ngL"
Date: Thu, 14 May 2026 16:02:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778799786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oH4Qvu6N7umz2nBzonTWb7hy46KBTpa0v6uIVVL0L4=;
	b=KMuc7ngLnliucGWnSPtJ4K6wAKvvNzwa2cWLrF4jSgqSKlxotrPpNhZSsE3faNB+0Gg6h5
	dUMuSN3r7szT/LhyCGGBqsrpL4ktW2729zOksTc2it+MA3DsxnWp2D4Mro51QZNiQj369Q
	4xI266IYRSV+AlI0i+lK8cDoRegTuz0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf v4 2/3] bpf: Avoid faultable build ID reads under mm
 locks
Message-ID: <agZTy44AgVB4zxut@linux.dev>
References: <20260514184727.1067141-1-ihor.solodrai@linux.dev>
 <20260514184727.1067141-3-ihor.solodrai@linux.dev>
 <agYzuDIJszA_7rp3@linux.dev>
 <8b83f690-c962-48e5-a557-dea03e4cdf2d@linux.dev>
 <agZG6XF41paiPjgm@linux.dev>
 <2895ecd8-df1e-4cc0-b9f9-aef893dc2360@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2895ecd8-df1e-4cc0-b9f9-aef893dc2360@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, May 14, 2026 at 03:49:27PM -0700, Ihor Solodrai wrote:
> On 5/14/26 3:14 PM, Shakeel Butt wrote:
> > On Thu, May 14, 2026 at 02:31:58PM -0700, Ihor Solodrai wrote:
> >> On 5/14/26 1:47 PM, Shakeel Butt wrote:
> >>> On Thu, May 14, 2026 at 11:47:26AM -0700, Ihor Solodrai wrote:
> >>>> Sleepable build ID parsing can block in __kernel_read() [1], so the
> >>>> stackmap sleepable path must not call it while holding mmap_lock or a
> >>>> per-VMA read lock.
> >>>>
> >>>> The issue and the fix are conceptually similar to a recent procfs
> >>>> patch [2].
> >>>>
> >>>> Resolve each covered VMA with a stable read-side reference, preferring
> >>>> lock_vma_under_rcu() and falling back to mmap_read_trylock()
> >>>
> >>> Why trylock()? Why not just reuse the mechanism introduced in [2]? That is
> >>> abstract out the mechanism introduced in [2] in mm core and reuse it.
> >>
> >> v1 used mmap_read_lock() as the fallback, but Puranjay pointed out [1]
> >> that stackmap can be called when the caller already holds
> >> mmap_lock. 
> > 
> > Can you exapnd on the scenario where caller already holds mmap_lock? Is this
> > code path can be taken from bpf programs and bpf programs can be attached at
> > functions/code-paths already holding the mmap_lock?
> 
> Exactly. For example, tracing BPF programs may attach to mm internals, and
> there are also BPF iterators over VMAs (i.e. SEC("iter/task_vma")). And
> probably other use-cases.
> 
> Bottom line is we can't assume it's safe to take mmap_lock in a code path
> reachable from a BPF program.

Sounds good. Let's add a comment in code amd also explanation in commit message.

> 
> > 
> >> So I changed to trylock since v2, similar to non-sleepable
> >> path.
> >>
> >> AFAIU this means that the common mechanism needs to support trylock
> >> behavior as in stack_map_lock_vma() in this patch.
> >>
> >> Do you think this is worth factoring out of stackmap.c?
> > 
> > Do you think we will need similar handling at more places in future
> > (particularly in bpf world) then it makes sense to factoring out now? Otherwise
> > we can wait until we are sure.
> 
> Honestly, I don't know. IMO we shouldn't prematurely generalize a piece of
> code with a single user. But I just may be unaware of the others.
> 

So, we have two somewhat similar users with trylock being the difference. I
think we can continue as is for now and let's punt the decision to refactoring
and common code when next use-case arise.

