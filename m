Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81882274641;
	Tue,  7 Apr 2026 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583064; cv=none; b=YwHQRjt1dbxsMF62d12eA871yPoOu8OgC8TMieJ9HEgH0vYcw6yOm9cm+yqzv16tq06j82dVYVQLYXYwv2dgpxJAbz+7E3JR2B+PJp+SJPcZRM6YgEmXfIi3nkbyZOZ46vx6YcCjL3MRmfwYJuEJqcH0GRxzvoGGU6RRmLU7VKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583064; c=relaxed/simple;
	bh=9UAvXMMrNqXTrDUMWeRlzPfgVWlg1yCmofk6uQ4sAWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEgAWICahkSTuTQ9NnEW5cVdMR+CUb+wy86WRfrdKWiZGDb+ufbhJnxXa3vsXwrzWlofk5vNGoVZBQPipHX0L/trwHpzpvbUjvS3y2vcnUgzhtFFcS7x+7+ARBSiwXv8JPCye7Go111FsQInnZ9T7DKIr7jiSA0z6qaMsVTEeLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvMycR5S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvMycR5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC102C116C6;
	Tue,  7 Apr 2026 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775583064;
	bh=9UAvXMMrNqXTrDUMWeRlzPfgVWlg1yCmofk6uQ4sAWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvMycR5SUvIjTLAwEDuh8RGK4jHzG3y00DReobjmFlfJ34ND91by7Bwk7Xe2BYw7Z
	 R17BPs8mIv4KgALr90d0mvREbxORfIklhY16OBwEVD/0TQ/IbDslpE/VMYb2DWbJx1
	 9YuXDwU/GiZQSOs7RUTWCWDhcrHFF4PdDgqbF2zn9gusDlWS9A2CH5u7qy7gh6SsZ9
	 LXiJUhcyRJmUhMy8SmoeQzYKw2AJwLAHkRmfvBio2x4r6vfywzfm99Q2EbYo1is2ZS
	 s7X0nGgGH2T34KJ/ehg96b+5DXj0hp+DnDyEi94lQlANXzE0slw4jrOlgOzXVnJKKQ
	 2ohrkEKfSnbuQ==
Date: Tue, 7 Apr 2026 18:30:55 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, lsf-pc@lists.linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Chen Ridong <chenridong@huaweicloud.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Kairui Song <ryncsn@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, Barry Song <21cnbao@gmail.com>, 
	David Stevens <stevensd@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	David Rientjes <rientjes@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	wangzicheng <wangzicheng@honor.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Suren Baghdasaryan <surenb@google.com>, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
Message-ID: <adU8VnzlLw9JUHB3@lucifer>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
 <acVPrEyfcE4Naz5b@gourry-fedora-PF4VCD3F>
 <248a126c-43e7-4320-b4bb-282e0b6da9c4@lucifer.local>
 <acbgIKuwDsPvPjdF@cmpxchg.org>
 <adTonuzmUc2AzUhp@lucifer>
 <adU3P9fk8h-AmEp4@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adU3P9fk8h-AmEp4@gourry-fedora-PF4VCD3F>

On Tue, Apr 07, 2026 at 12:56:31PM -0400, Gregory Price wrote:
> On Tue, Apr 07, 2026 at 12:36:36PM +0100, Lorenzo Stoakes wrote:
> > >
> > > And the current code structure makes it difficult to whittle down the
> > > differences methodically.
> > >
> > > IMO modularization is the best path forward. Giving people the ability
> > > to experiment with a la carte combinations of features would make it
> > > much easier to actually production test and prove individual ideas.
> >
>
> ...
>
> >
> > In a possibly, fantasy ideal world scenario *puffs on dream pipe*, it'd be
> > amazing to somehow isolate the reclaim code in such a way that we could
> > instrument it for testing purposes.
> >
> > E.g. if it could be invoked from userland, or UML, or _something_ and then
> > faked out to have a certain configuration of X NUMA nodes and Y GB of RAM
> > with Z processes competing with total observability of what's happening in
> > the algorithm that could allow for really robust controllable testing and
> > regression tests, as well as possibly some form of fuzzing for broken
> > reclaim scenarios.
> >
> > *Puts dream pipe down*
>
> *picks up the pipe*
>
> At risk of being shot - this kind of stubbing / functional testing is

*nukes entire site from orbit, it's the only way to be sure*

> somewhat trivial work these days via <pick your favorite LLM> with
> reasonably well designed interfaces.

Though to be honest, I did ask Claude to do this with some code before and was
really impressed with how quickly it came up with something.

Buuut I've generally found the code LLMs produce... terrible? Really terrible?
So I think you'd want there to be some level of human improvement there.

And in any case, maybe doing things this way will struggle to really represent
real world cases (lock contention etc.) but OTOH, being able to simulate a high
memory pressure environment with certain parameters even without [the rest of
the kernel] interacting might still be super super useful for diagnosing issues.x

>
>    ( read: probably not with the current api n_n;; ).

*gasp*! But yeah, also yes.

>
> So to get there, we'd need to agree on the refactor work and interfaces
> that make it possible to model the scenarios outside a running kernel.
>
> If we do actually want to move the core to look like:
>   - vmscan.c  : core library
>   - lru.c     : standard lru
>   - mglru.c   : mglru
>
> Might as well consider the functional testing question as well as we
> decide what those interfaces look like anyway.

Yes, adding unit-level tests would be hugely useful.

>
> *throws the pipe into the bikeshed*

*Dives in bikeshed to rescue*

>
> ~Gregory

Cheers, Lorenzo
