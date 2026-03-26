Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B6402440;
	Thu, 26 Mar 2026 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539336; cv=none; b=HMlsS/unEBebLz9y1ttEVEOf61YpBiB5Ci6BQXZrGuw56pbXf7azIuWplW26jvHKvaDbX9hpnvMV2pl//VHXR6xiFl7F0YFMrbYWTOrWa1W1XEdOHSwSAbyz+hR6L7i19ZE81vGrfR8ScoCXuZqp80aQ1MY7QS0RkiuiKsv+UXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539336; c=relaxed/simple;
	bh=J+BrV9gtq0qIc5uH8RmrzCSQsDGfxVkuOgtcGS9wqRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQBYkolkZgfU6qQgKM01q9NbygeelW1wwuuAdONzKJjvsxD+QrPE4lxSD9jsIoBWMcsKmIvXyXDsqUzGpvBneHwdU1RWqWjfiF3V2aUKl5nMvsg/MAULIfSa7wNf1xevUdz8Q6NAbAIhjv4U3DEwmzZ/LMi2fBU90YXW9M5pk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEQ3/8kr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEQ3/8kr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D2AC19424;
	Thu, 26 Mar 2026 15:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774539336;
	bh=J+BrV9gtq0qIc5uH8RmrzCSQsDGfxVkuOgtcGS9wqRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEQ3/8kr7AXvTNifmkqXHgsSJYVLQy4oJZmUz6qvpVtujrx8Hkaz7jbuW5FqksPtB
	 iVmeZVRnO03XSgMjf1z4oK17lKBtHlzFzEA2DLI6mBjx6QyDOXvv78NDgFHSfYiYxs
	 +ebXSf1w32TibjJsohEsZoBGSUotwT/kSQWLeKkr8bFEpsQLBIi39j29JBKRDa2XM2
	 gOYVaQo7cTYKr/tg+wmfv8WOqDQwgwtLQc04/ejN7tvwTO3PJpdgNmHtX0rg85s/Qt
	 dtbyymDStrYDeMITbR+lHuxkhM8MBxFDxtrm9w9OS1lNaSRyNboAeF877khbazBSqC
	 hRh7Im2JCKRYQ==
Date: Thu, 26 Mar 2026 15:35:28 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
	lsf-pc@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
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
Message-ID: <248a126c-43e7-4320-b4bb-282e0b6da9c4@lucifer.local>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
 <acVPrEyfcE4Naz5b@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acVPrEyfcE4Naz5b@gourry-fedora-PF4VCD3F>

On Thu, Mar 26, 2026 at 10:24:28AM -0500, Gregory Price wrote:
> ... snip snip snip ...
>
> > >
> > > How Do We Get There
> > > -------------------
> > >
> > > Do we merge the two mechanisms feature by feature, or do we prioritize
> > > moving MGLRU to the pluggable model then follow with LRU once we are
> > > happy with the result?
> >
> > Absolutely by a distance the first is preferable. The pluggability is
> > controversial here and needs careful consideration.
> >
>
> Pluggability asside - I do not think merging these two things "feature
> by feature" is actually feasible (I would be delighted to be wrong).
>
> Many MGLRU "features" solve problems that MGLRU invents for itself.
>
> Take MGLRU's PID controller - its entire purpose is to try to smooth out
> refault rates and "learn" from prior mistakes - but it's fundamentally
> tied to MGLRU's aging system, and the aging systems differ greatly.
>
>   - LRU:   actual lists - active/inactive - that maintain ordering
>   - MGLRU: "generations", "inter-generation tiers", aging-in-place
>
> "Merging" this is essentially inventing something completely new - or
> more reasonably just migrating everyone to MGLRU.
>
> In terms of managing risk, it seems far more reasonable to either split
> MGLRU off into its own file and formalize the interface (ops), or simply
> rip it out and let each individual feature fight its way back in.

But _surely_ (and Shakeel can come back on this I guess) there are things that
are commonalities.

In any case we can all agree that MGLRU cohabiting with classical reclaim is not
a happy household one way or another.

Maybe a stage 1 can be to separate stuff into another file, because that'd
actually be pretty easy to do for a fair bit of it, surely?

Can use mm/internal.h to handle stuff that has to link one with other?

>
> ~Gregory

Cheers, Lorenzo
