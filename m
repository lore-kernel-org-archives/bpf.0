Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E52F9D85
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532670; cv=none; b=T4cz6BW5BC8YPwBQAtJtDKVX0HnG3KIVTMi6WobUV0W4R0sGfSMdEDWg4WZ7t8FrKGKPaLY7XxeKM1wxXkxKyTJVSturqyf4M+FBLpUwhpSRaOgQ02qm85U2HSqNAyOXH+jZhLa1rxeYF3F+ZNfSy5h/MBmvkB1+cla/CbhUk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532670; c=relaxed/simple;
	bh=qItOzyG57FH2aTGJPT/8dpCMDkYd8UM/PwFk8ao3cnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av3qWzQHJvnrL0iCXWkl0L5DOWiu6lCuggN0k+3rUNelZJhxQxDj0wgdnQhCZHsITlr47m9l8on5lW6bCJmvmvz7JUW2SsANpr6FZrxaOvn9HagZiHpCgR8p/BMDtJ829NKMix7UMdart5OialHxy+7seLkdOjjW3kk6WRojYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JKnh8UbE; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JKnh8UbE"
Date: Thu, 26 Mar 2026 06:44:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774532667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FHs1nX261KI0Bcg1Nf//oeXdKIr+A9JzQ6d3yV5ghDQ=;
	b=JKnh8UbE2TxNQo7XZDsJ3d18TsjVhK3/RocXZOnwJCCpGvOzWmX4GWO+GfqBWTHmHdWXKY
	v5IQUm1sFyGvotbOTuYWFXW20cz5O5tTB2CG6XsZzB1SDtPaplNpmaa2A9eClfS4FF/P5Y
	vvTcQVQy9uinU12Qeg9RpNfAlh29z/s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>, 
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
Message-ID: <acUzMdxCDfbuyv9J@linux.dev>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <acTcStxrTCWAN6Dt@tiehlicka>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acTcStxrTCWAN6Dt@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 26, 2026 at 08:12:10AM +0100, Michal Hocko wrote:
> On Wed 25-03-26 14:06:37, Shakeel Butt wrote:
> > The Problem
> > -----------
> > 
> > Memory reclaim in the kernel is a mess. We ship two completely separate
> > eviction algorithms -- traditional LRU and MGLRU -- in the same file.
> > mm/vmscan.c is over 8,000 lines. 40% of it is MGLRU-specific code that
> > duplicates functionality already present in the traditional path. Every
> > bug fix, every optimization, every feature has to be done twice or it
> > only works for half the users. This is not sustainable. It has to stop.
> 
> While I do agree that having 2 implementations available and to maintain
> them is not long term sustainable I would disagree with your above line
> of argumentation. We are not aiming to have the two in feature parity
> nor they are overlapping in bug space all that much.

There is definitely basic set of features which we want from a reclaim
mechanism (e.g. writeback and writeback throttling which MGLRU lacked for a long
time) and it does not mean we should aim for feature parity.

For the bugs/debugging, we always need to answer if it is impacting one or the
other or both.

> 
> > We should unify both algorithms into a single code path. In this path,
> > both algorithms are a set of hooks called from that path.
> 
> Isn't this the case from a large part? MGRLU tends to have couple of
> entry points in the shared code base (node/memcg scanning code).

Most of the code is diverged at the reclaim entry point and from what I see the
code at the lowest layer (shrink_folio_list) is shared.

> 
> > Everyone
> > maintains, understands, and evolves a single codebase. Optimizations are
> > now evaluated against -- and available to -- both algorithms. And the
> > next time someone develops a new LRU algorithm, they can do so in a way
> > that does not add churn to existing code.
> 
> I think we should focus to make a single canonical reclaim
> implementation work well. I.e. we deal with most (or ideally all) known
> regressions of MGLRU. 

Here we disagree on the approach or steps to reach the single canonical reclaim
implementation. MGLRU is a plethora of different mechanisms and policies and it
never went through rigorous evaluation for each of those mechanisms and
policies individually. To me that needs to be done to have one solution. 

> In the initial presentation of the MGRLU framework
> we were told that the implemenation should be extensible to provide more
> creative aging algorithms etc.
> 
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
> I would go that way only if/after we are done with MGLRU unification and
> after we will have depleted the potential of that approach and hit cases
> where we cannot implement new extensions without going $foo_ext way. TBH
> I am not convinced "make it pluginable to solve hard problems" is the
> best way forward.

The reason I have added pluggable/extensible part in this proposal is that I
want to avoid the same scenario all over again in the future. There will always
be some users with very specialized workloads needing some fancy/weird
heuristic. Rather than polluting the core reclaim, letting such users to do
fancy policies should be part of our long term strategy. In addition, we will
want to explore different algorithms and techniques, providing a way to easily
do that without changing the core is definitely needed for future proofing the
reclaim.

