Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DFA20FAAB;
	Thu, 26 Mar 2026 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532762; cv=none; b=OneMsH8E1j8XLrFL36ydCknJrg20iGE18tJwHKdhBehxrsiSFGAeXm2YElZ4pr41fwmIyvNS4LlR6V4mRn2XgAAqjepVuvCTLt92+B7EKrTCUVKd4eoGsBxqxjkHVyv0QIvybzsXZjW/1WJOq0/2UiZbLwLeC6HR+XsfYTzOT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532762; c=relaxed/simple;
	bh=RudqkoNqPBUX98fLz0+P5t9+ze0SEqpsNjTsusgfFDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOiadD2/6ABLSoIhslwSYXZ8cfqkN+x+PlhJXh85sRibjeStDmlcHTE4tYixm0G0Sm90Z9lR3g9ltbuyWoGB2AtI/xksF0JDVWdDGFKOoKZGQYLwBhOM6Gc/CONbKcSojbLfS39BXvlmjLmznXRnioYAs5HjKRVQMpszG4lOzmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSj5r7P6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSj5r7P6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29739C19423;
	Thu, 26 Mar 2026 13:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774532762;
	bh=RudqkoNqPBUX98fLz0+P5t9+ze0SEqpsNjTsusgfFDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSj5r7P6tvWg8RDoOKSFcjrp9BYauvtEROZVgJiSzZYIWSHC9NJzKB5elnZv2CQyD
	 w5r7LNhlCSoxpMC8Y3sVod1Gzem24Hk4m1u6j5DeVLY52ME3LPfs0YUEmnxX6flBeE
	 um8x1lyhyriKeZyyXOzLqhz3N2USlUZifloXHQ9ah2BNtaS1AiouYoX+1xPCQOoYmm
	 tG0ifLHmyTSqhizKG/n8f/RdNJu79Gd9WjXG5VqHkTZS3iDJWL+MWYDVxyFZUvQz7r
	 JxWs8pGnjifgIxDJIVYCps553/2g5VXg/h8VCAF2eiEhGbABeUZY0Vuce9P29BjXxS
	 TtMaX7iqRZm9g==
Date: Thu, 26 Mar 2026 13:45:54 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	lsf-pc@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, Gregory Price <gourry@gourry.net>, 
	Barry Song <21cnbao@gmail.com>, David Stevens <stevensd@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, David Rientjes <rientjes@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, wangzicheng <wangzicheng@honor.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Suren Baghdasaryan <surenb@google.com>, Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
Message-ID: <4eb3bd28-f9d1-46a4-b794-fdeabad92158@lucifer.local>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka>
 <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
 <CAMgjq7B_twv3xhd5VmMJxngAknf9YaLAiwGYpdi6H2n1cXD3-A@mail.gmail.com>
 <67f1588e-a094-413c-9746-9c28bdf6cc56@lucifer.local>
 <b340e43f-2e08-4a77-8176-e49667387e85@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b340e43f-2e08-4a77-8176-e49667387e85@kernel.org>

On Thu, Mar 26, 2026 at 02:42:35PM +0100, David Hildenbrand (Arm) wrote:
> On 3/26/26 14:13, Lorenzo Stoakes (Oracle) wrote:
> > On Thu, Mar 26, 2026 at 08:37:06PM +0800, Kairui Song wrote:
> >> On Thu, Mar 26, 2026 at 4:02 PM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> >>>
> >>>
> >>> I'm quite concerned about maintainership, as it seems the MGLRU maintainers have
> >>> not been all that active, and the MGLRU to me at least is currently a black box.
> >>>
> >>> I'm not the only one who's raised this (see [0]).
> >>>
> >>> That'd very much have to be resolved and the community reassured that MGLRU is
> >>> _actively_ maintained before we could even contemplate it replacing the
> >>> 'classic' reclaim approach IMO.
> >>>
> >>> I hope that Kairu, Barry, Zicheng and others who are interested int it resolve
> >>> this, however!
> >>
> >> Hi everyone,
> >>
> >> Right, I think we are starting to make good progress on improving
> >> MGLRU recently. For the last few years we already have some commits
> >> stashed downstream to enable that on our fleet, most of my effort in
> >> upstream is spent on other parts like SWAP, really looking forward to
> >> making MGLRU better upstreamly.
> >>
> >> Yesterday I was still discussing with CachyOS folks about their usage
> >> while working on that series for MGLRU cleanup and dirty flush
> >> optimization, and got some nice feedback later from their chat server
> >> that MGLRU's TTL resolved their thrashing issue very well. With
> >> classic LRU they needed a le9 patch downtreamly.
> >>
> >> For many other typical workloads under stress, MGLRU performs
> >> significantly better too (e.g. database, build kernel could be more
> >> than twice as fast), it would be a huge loss to leave it unmaintained.
> >>
> >> Barry also provided some really helpful ideas about MGLRU like
> >> readahead handling. We are also seeing other vendors and people
> >> contributing to MGLRU like Leno and Baolin recently. Things are
> >> looking promising.
> >
> > Guys, can I please make a plea then for you guys to AT LEAST become
> > reviewers in MAINTAINERS please:
> >
> > MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)
> > M:	Andrew Morton <akpm@linux-foundation.org>
> >
> > Well Andrew is Andrew :)
> >
> > M:	Axel Rasmussen <axelrasmussen@google.com>
> >
> > git log mm/vmscan.c has 0 results.
> >
> > Axel has however engaged in discussion on
> > https://lore.kernel.org/linux-mm/20260318-mglru-reclaim-v1-0-2c46f9eb0508@tencent.com/
> > recently for example, but not much in 2025 afaict.
> >
> > M:	Yuanchu Xie <yuanchu@google.com>
> >
> > git log mm/vmscan.c shows 1 result from August 13th 2024.
> >
> > Yuanchu has engaged in some MGLRU discussion also recently, here and there.
> >
> > R:	Wei Xu <weixugc@google.com>
> >
> > git log mm/vmscan.c shows 2 results from October 2024.
> >
> > Wei doesn't look to have engaged in discussion on MGLRU recently.
> >
> > L:	linux-mm@kvack.org
> > S:	Maintained
> > W:	http://www.linux-mm.org
> > T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > F:	Documentation/admin-guide/mm/multigen_lru.rst
> > F:	Documentation/mm/multigen_lru.rst
> > F:	include/linux/mm_inline.h
> > F:	include/linux/mmzone.h
> > F:	mm/swap.c
> > F:	mm/vmscan.c
> > F:	mm/workingset.c
> >
> > It doesn't really feel like MGLRU is currently maintained at all, quite
> > honestly.
> >
> > So I think we need people to step up here.
>
>
> Ans some serious cleanup of the entry to reflect who is actually
> involved nowadays, if at all.
>
> Master of MAINTAINER updates, I assume you'll take care of that?

Ack of course :)

I mean I can suggest a change and cc the various people and we can do it
that way :)

Obviously will want some Acked-by's from those invovled on that though! :)

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
