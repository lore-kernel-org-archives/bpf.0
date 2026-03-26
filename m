Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46245370D7B
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551004; cv=none; b=T78jKGaOrRVQl13kDpl7CMiw5ZTABD1+iJvlRZiAH0vfVwvTYbWvaqejrzlFBOhLir6VNc74MoG8Q3Sj08ee8X6FJYk3Jira+D4EeywIyjlYJezaT+q7Y2Gz2vNOuJGkH++ORCZ1CXa/WMxZnCJe06bPEti3gcYCO0DPV5EoCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551004; c=relaxed/simple;
	bh=1fPzjWE9WnkthEspr1zyu1ehxIimEFos5AQNAlS8XxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5gve9SsflJYdLAIBbIrpzmN9VIrefLIY/bAIMD+XWB5XGfvxQjJK13QOWCbF6AFzmFWfQQf1E0bYXnvUcXL06K0yiOPWTktBej/4QCbBTlcHvHTI+uzpbNYQhYQzcTamBQXMtcv0gXqJZh2aUWNzjQXtxPXFT3Oin8wi8P8Ex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ocb5rEa4; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ocb5rEa4"
Date: Thu, 26 Mar 2026 11:49:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774550999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hfFEqSk7MC3gXpsizNtYg3OJej5GD4C2LciSFQWJMH4=;
	b=ocb5rEa4Vhf7dQDm6mOVJ7Q5U9qVntdAcRctK9BW1rf/KGQ9xL1MKFqhwDKXRm7T/yMipq
	G4ymDDV5NeiDv9zIsQf4PInLagFK3TFtd0xlCoWwJuX9ijYGmOogJMLoTFPqS8vD/3azmp
	zePXiGS6hiJn10PTMsJnKraFH8fsipo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Kairui Song <ryncsn@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Nhat Pham <nphamcs@gmail.com>, Gregory Price <gourry@gourry.net>, 
	Barry Song <21cnbao@gmail.com>, David Stevens <stevensd@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, David Rientjes <rientjes@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, wangzicheng <wangzicheng@honor.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Suren Baghdasaryan <surenb@google.com>, Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
Message-ID: <acV5d7D7wsoN2aa4@linux.dev>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 26, 2026 at 11:43:46AM +0000, Lorenzo Stoakes (Oracle) wrote:
> On Wed, Mar 25, 2026 at 02:06:37PM -0700, Shakeel Butt wrote:
[...]
> >
> > The Fix: One Reclaim, Pluggable and Extensible
> > -----------------------------------------------
> >
> > We need one reclaim system, not two. One code path that everyone
> > maintains, everyone tests, and everyone benefits from. But it needs to
> > be pluggable as there will always be cases where someone wants some
> > customization for their specialized workload or wants to explore some
> > new techniques/ideas, and we do not want to get into the current mess
> > again.
> 
> OK so I was with you up until the pluggable bit :) it's like you're
> combining two things here, obviously - unification and pluggability.
> 
> I think we should consider both separately.

Yes, I should be more explicit that these are two different steps. First
unification and then provide a framework for extensibility.

[...]

> 
> > New ideas get implemented as new policies, not as 3,000-line forks. Good
> > mechanisms from MGLRU (page table scanning, Bloom filters, lookaround)
> > become shared infrastructure available to any policy. And if someone
> > comes up with a better eviction algorithm tomorrow, they plug it in
> > without touching the core.
> >
> > Making reclaim pluggable implies we define it as a set of function
> > methods (let's call them reclaim_ops) hooking into a stable codebase we
> > rarely modify. We then have two big questions to answer: how do these
> > reclaim ops look, and how do we move the existing code to the new model?
> 
> Hmm, I'm not so sure about that. But it depends really on who has access to
> these operations.
> 
> The issue with operations in general is that they eliminate the possibility
> of the general code being able to make assumptions about what's happening.
> 
> For instance, the .mmap f_op callback meant that we had to account for any
> possible thing being done by a driver. You couldn't make assumptions about
> vma state, page table state, etc. and of course things happened that we
> didn't anticipate, leading to bugs.
> 
> So I guess it's less 'no ops' more so 'what do we actually expose to the
> ops', 'what assumptions do we bake in about how the ops are used' and very
> importantly - 'who gets to populate them'.
> 
> If they're _exclusively_ mm-internal then that's fine.
> 
> Reclaim is a _very_ _very_ sensitive part of mm. At the point it's being
> activated you may be under extreme memory pressure, so a hook even
> allocating at all may either fail or enter infinite loops.
> 
> We are also very sensitive on things like rmap locks and also, of course, -
> timing.
> 
> It's not just a perf concern, if we are too slow, we might end up thrashing
> when we could otherwise not have.
> 
> Also there ends up being a question of how much now-internal functionality
> we end up exposing to users.
> 
> So we really need a good definition of who we intend should use this stuff,
> and how any such interface should be designed.
> 
> I mean, if sufficiently abstracted, and with very carefully restricted
> constrainst perhaps we could work around a lot of this but we have to tread
> _very_ carefully here.

Good points and I think we are still at the early stage of defining what
operations these would be. One of the complain during MGLRU upstream effort was
that the traditional LRU is too rigid and is very hard to experiment new ideas.
I want to eliminate such future complains. If you want to experiment some new
algorithm or new heuristic, experiment using the new framework.

I think once we start unifying the reclaim mechanisms, these operations will
start becoming more clear.
