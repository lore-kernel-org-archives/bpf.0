Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF73AE6F7;
	Tue,  7 Apr 2026 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561807; cv=none; b=oFG9CJlSy+eVPRgHlUFImUVPWc/zmZF6M/kata1xnJkgAVILbkW8XSveuy3BIqgL7/ZD4b699beQglbP47TBQG4NdW/+s9Abi3Jq53FVrcW248W+4dMJErDRFT0fkv+YYZwu5+pvdMA4UqMJ5NRFkRzsp1qu0vMW/HIsP3+0hhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561807; c=relaxed/simple;
	bh=mq6EZwQXNC40lYUPwXXBKytXrBuKjYAwSmfDKtal1AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQ4s6z+at2nUZ33BY5Q+tU/d48TI1iqk0Vs+We5ap6uREzyypHXvPMmI32RChHD/nD3TBEiKVOQ1m6wCFdyFc4BmJ3vzbzCz6Hgkry8EvmHdYFfIFT3Ov0w1xmk4CcQF5cQL+JLCxCWQrOpXUj+1reUJGjl68p/UZ0uzHRRvz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv4oTdIt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv4oTdIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A9BC116C6;
	Tue,  7 Apr 2026 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775561806;
	bh=mq6EZwQXNC40lYUPwXXBKytXrBuKjYAwSmfDKtal1AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lv4oTdItGcdg1G3q9FXl6rO6GLjDawSjVBvn+0Lu0JwqEGjW9ySiTWsJMDz9DG+1F
	 dPNP+AqFPB5P8jcPFBzMejf/NssG061LZyMZBje6acVtKZDjKpCWUjoO0N5FgufuNK
	 fqisU34nptsmutBTGX1Mbwi8NudIUtpNc4faVNAdSsz1CeOj2q1OD1nziTst1izfWi
	 sERQOxgoMpZu/D86wEGnAUj3OQJ7mOUHmjMKZ3T77WNsJUZdfGLQKK/NOy/bEqNUHX
	 PjX3va909N6i3zq/butG088OB6hJm4JtXVtEAJtob1wWv11IxejeBcEHVIMyYHeZAL
	 p+fdMdJMurq0g==
Date: Tue, 7 Apr 2026 12:36:36 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Gregory Price <gourry@gourry.net>, 
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
Message-ID: <adTonuzmUc2AzUhp@lucifer>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
 <acVPrEyfcE4Naz5b@gourry-fedora-PF4VCD3F>
 <248a126c-43e7-4320-b4bb-282e0b6da9c4@lucifer.local>
 <acbgIKuwDsPvPjdF@cmpxchg.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acbgIKuwDsPvPjdF@cmpxchg.org>

(sorry my mail is a disaster totally missed this)

On Fri, Mar 27, 2026 at 03:53:04PM -0400, Johannes Weiner wrote:
> On Thu, Mar 26, 2026 at 03:35:28PM +0000, Lorenzo Stoakes (Oracle) wrote:
> > On Thu, Mar 26, 2026 at 10:24:28AM -0500, Gregory Price wrote:
> > > ... snip snip snip ...
> > >
> > > > >
> > > > > How Do We Get There
> > > > > -------------------
> > > > >
> > > > > Do we merge the two mechanisms feature by feature, or do we prioritize
> > > > > moving MGLRU to the pluggable model then follow with LRU once we are
> > > > > happy with the result?
> > > >
> > > > Absolutely by a distance the first is preferable. The pluggability is
> > > > controversial here and needs careful consideration.
> > > >
> > >
> > > Pluggability asside - I do not think merging these two things "feature
> > > by feature" is actually feasible (I would be delighted to be wrong).
> > >
> > > Many MGLRU "features" solve problems that MGLRU invents for itself.
> > >
> > > Take MGLRU's PID controller - its entire purpose is to try to smooth out
> > > refault rates and "learn" from prior mistakes - but it's fundamentally
> > > tied to MGLRU's aging system, and the aging systems differ greatly.
> > >
> > >   - LRU:   actual lists - active/inactive - that maintain ordering
> > >   - MGLRU: "generations", "inter-generation tiers", aging-in-place
> > >
> > > "Merging" this is essentially inventing something completely new - or
> > > more reasonably just migrating everyone to MGLRU.
> > >
> > > In terms of managing risk, it seems far more reasonable to either split
> > > MGLRU off into its own file and formalize the interface (ops), or simply
> > > rip it out and let each individual feature fight its way back in.
> >
> > But _surely_ (and Shakeel can come back on this I guess) there are things that
> > are commonalities.
>
> There are some commonalities, but MGLRU was almost maximalist in its
> approach to finding parallel solutions and reinventing various wheels
> with little commentary, explanations or isolated testing.
>
> For example, MGLRU took a totally different, ad-hoc approach to
> dealing with dirty and writeback pages. It's been converging on the
> LRU mechanism. This process has been stretching out for years, with
> users eventually running into all the same problems that shaped the
> LRU implementation to begin with. Yes, you need to wake flushers from
> reclaim. Yes, you will OOM if you don't throttle on writeback.

Yeah this is a real concern. And it's a pity we put ourselves in this
position.

>
> There are many other divergences like this that complicate the picture:
> - Cgroup tree iteration, per-zone lists to implement node reclaim.
> - Divergent anon/file balancing policies.
> - A notably different approach to scan resistance.
>
> Many of these were not part of the main pitch at the time, but they’ve
> created sizable technical debt that we’re now forced to reconcile.
>
> I think MGLRU's NIH-attitude towards the problem space set it up for
> running into past lessons again and learning the hard way, just like
> with writeback.

Yeah :( we should never have allowed this series to land the way it did,
it's an important lesson in how mm should address changes like this moving
forwards.

But, given the great response on the thread here, and around the recent
MGLRU entry update in MAINTAINERS, I think this is widely recognised.

>
> The good thing is that there are some integration efforts now, even if
> they don't come from the people that promised them. And some of them
> do exactly the targeted, rigorous tests on a per-component basis that
> is needed to sort it out (and was asked for back then).

And this is exactly what we need, and it's the ability to do this kind of
thing (minus the BPF, minus the pluggable bits, of which I have concerns,
perhaps not _fatal_ concerns but concerns anyway) that made me rather
pleased with Shakeel's proposal here :)

>
> But there are many workloads, many hardware configurations, and many
> cornercases to cover, so this will take time. The end result doesn't
> just need to be fast for some workloads, it also needs to be
> universal, robust, easy to reason about and predictable.

Yes, we shouldn't rush this, and should be conservative in how we approach
this.

>
> Based on the current differences and how unification has been going so
> far, I think it's premature to claim that we're close to deleting one.

Yeah. I think people _really want_ this to be true, but it doesn't make it
so.

Reclaim is a really difficult problem I think simply because there are so
many corner cases and so many ways in which things can be broken in
different circumstances.

I've recently heard complaints about really poor reclaim behaviour on
laptops + firefox-eating-all-my-ram which makes me think in general, it'd
be good to see a broader improvement in testing, code quality and
documentation and separation of the various heuristics.

When writing the book it did strike me just how heuristic so much of it is,
which makes the code necessarily delicate. I think we can do better in
separating out these bits in general.

But that kind of steps outside of the scope of the proposed changes here.

>
> And the current code structure makes it difficult to whittle down the
> differences methodically.
>
> IMO modularization is the best path forward. Giving people the ability
> to experiment with a la carte combinations of features would make it
> much easier to actually production test and prove individual ideas.

Yes agreed.

I guess one aspect of testing that's tricky here is that it's _so_
dependent on workload and hardware and software and etc. etc. that writing
a bunch of self-tests or similar would possibly be semi-useless.

I wonder if we need some way of storing specific test results/having
specific tests for specific workloads within the kernel tree?

I know, super nebulous, but if we had some way of expressing 'we expect
behaviour X in setup Y' it'd be super helpful. But I realise that quickly
becomes a combinatorial explosion.

In a possibly, fantasy ideal world scenario *puffs on dream pipe*, it'd be
amazing to somehow isolate the reclaim code in such a way that we could
instrument it for testing purposes.

E.g. if it could be invoked from userland, or UML, or _something_ and then
faked out to have a certain configuration of X NUMA nodes and Y GB of RAM
with Z processes competing with total observability of what's happening in
the algorithm that could allow for really robust controllable testing and
regression tests, as well as possibly some form of fuzzing for broken
reclaim scenarios.

*Puts dream pipe down*

>
> A nice side effect of this is that entirely new ideas would also be
> easier to try out.
>
> I think a good start would be to keep the common bits - "library" code
> like shrink_folio_list() list and shared facilities like kswapd - in
> vmscan.c. Move LRU and MGLRU specifics to their own files.

Yes this would be a great (and simple) start!

Maybe worth keeping the mglru.c file or whatever-it-will-be also under the
reclaim entry in MAINTAINERS while we're figuring out who should eventually
maintain MGLRU however.

>
> Then as much as possible extract and generalize functionality into the
> common code so it can plug into both. For example, collecting accessed
> bits from page tables instead of rmap chains should really not have to
> be specific to one. Nor how the cgroup tree is iterated.

Yes, we should aggressively reduce duplication. Since this is a lot more
'obvious' in terms of value and correctness, maybe also a good starting
point?

>
> It might be possible to make N lists a natural extension of 2 lists,
> so that the tracking datastructures themselves can be shared. With
> minimal parameterization from the policy engines.

That'd be nice!

>
> If we can get to a place where the only difference is how reference
> data is interpreted and causes the lists to be sorted - you know, the
> actual replacement policy - that is a much more manageable gap to
> evaluate and argue about. Or swap out to try entirely new ones.

Yes absolutely agreed.

This is a fantastic reply, am annoyed my not knowing how to do mail
(apparently) prevented me from seeing it earlier!

Cheers, Lorenzo
