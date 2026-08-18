Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6B2561A2;
	Tue, 18 Aug 2026 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063647; cv=none; b=p/RC1Ez4QkT1Z2tQ8Xk9EMIf14JZV975dkA9JjVfdXrl64R80oFKFpBNVNyjzAmdRQScqXo+p8/8kmusRaFP1UVXOaZSTr69DsC2Xn/iyvQTzarvbVbDEqjkpiAHThkZkqwCXIl9sJ34O2VftiAYLS/WXrfmEZ/4R06cBudAg8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063647; c=relaxed/simple;
	bh=rVKtpVqLc11/bslXNSGYgugY1jfuCHBdjuxVIXKkQ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXrcDviB1bvkZ0k6NzuUiv5hcbpA8L0jOTVgRW5wBSctY+UFxmrSzVJA675Li36R3jhWRco9tcQjR+CHgg1DZtS/0iM6TIZ/HgpTqbyxOZ30ZyZ3Eamj4VRhhfzfV7R9FBW41Y73S8rh6rVsSNwsOiJ3foiAl/hTMtCkjknOsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhGeoaoh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhGeoaoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA871F000E9;
	Tue, 18 Aug 2026 14:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787063645;
	bh=5o59A+iUFyU+31kYkokmEB51xD/MimpJJEfveQW/Usw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JhGeoaohI/G+QkNhEO8WhJsLjSEb99kxRI07DwXVljsOzC8bWSYW+Un3eLGngrkOE
	 yuagroV1ZxBYVVEjDdhsft0MTk4GKGkD+1qshw8yoRmCnzhHfRF2cUbC0ImoDZJR2n
	 ydvSNeckFrVeepxoEWrG9GF8PzFUlIHPc1exetk0wJHXVctTR9oYJPbQUcHBTQNPp2
	 HzGfG6l6k5c3wzOhjh+NlaTiALRN/PSEo9QUicLT+u3ycoiQkdYCicTyBgaJ8WURdb
	 xfUec6UMt094VaNCpDCBIzPgXSE0GiVWPM2G5pnIXECz/zCO/q5mio3oY0PDA9BMOK
	 cN/keMp8JTxjA==
Date: Tue, 18 Aug 2026 15:33:42 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org, 
	nico.pache@linux.dev, baolin.wang@linux.alibaba.com, baohua@kernel.org, 
	dev.jain@arm.com, hughd@google.com, lance.yang@linux.dev, liam@infradead.org, 
	mhocko@suse.com, rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, 
	surenb@google.com, usama.arif@linux.dev, vbabka@kernel.org, ziy@nvidia.com, 
	usama.anjum@arm.com, agordeev@linux.ibm.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, jannh@google.com, 
	willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 00/57] mm/collapse: rebuild collapse on migration
 primitives
Message-ID: <aoRqByutFcW61Vag@lucifer>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <aoLAly-oL2OAa4n8@lucifer>
 <aoLkMUtmzRVuv2Hx@thinkstation>
 <aoQ77EcD3M2kjeya@lucifer>
 <0153303d-f9d6-45ea-a276-fbf2e5625ef9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0153303d-f9d6-45ea-a276-fbf2e5625ef9@kernel.org>

On Tue, Aug 18, 2026 at 04:12:17PM +0200, David Hildenbrand (Arm) wrote:
> On 8/18/26 15:06, Lorenzo Stoakes (ARM) wrote:
> > (I'll reply to the rest of this later)
> >
> > On Mon, Aug 17, 2026 at 02:38:44PM +0100, Kiryl Shutsemau wrote:
> >> David and I talked about this at LSF/MM.  I can give it a try if it fits
> >> your idea of "feature freeze" -- and if it doesn't collide with the series
> >> you have in flight, in which case I'd rather go after yours than around it.
> >
> > Whether intended or not you sound rather like you are trying to override me
> > in favour of my co-maintainer here and it's... not helpful.
>
> I think Kiryl tried to say that we discussed at LSF/MM which areas of MM scream
> for an improvement, and we discussed that khugepaged is just horrible code.

Yes, and obviously I agree with that very much!

>
> I think we all agree that there is a lot of room for improvement, but the big
> question is:
>
> (a) When does it stop being a cleanup and is a new feature in disguise that
>     makes the code more complicated and even harder to maintain.
>
> (b) Can it just naturally be made looking like a cleanup.

Right and point (a) is exactly my pushback here.

And it's not always so easy to separate.

>
> Ideally, we'd get b), in small, nice-to-review chunks that incrementally improve
> the code without inflating it heavily or moving everything around.

Yep.

>
> The current locking is nasty, so anything that moves us one step closer into
> something that is not only simpler but also more scalable is nice. I am a bit
> concerned with the churn in the series as is.

Yes.

What I'm saying is, essentially, go read the code. Go see how coupled things
are. Go read the functions that require you to keep a giant stack of
state to even know what's going on.

Look at the bug rate, and how subtle the bugs are - essentially - 'behold the
horrors' :)

And rather than being opposed to fundamental reworks (actually - it's the exact
opposite - I think THP needs changing from top-to-bottom):

Based on experience of seeing work done in THP - we are _making it worse_ when
we add features without paying down this debt.

I think it's nuanced, because as part of reworking things (you say this below
too), patterns and approaches can fall out.

And you can naturally lead things towards a sensible rework.

>
> After this series, mm/collapse.c itself is way larger than just mm/khugepaged.c
> originally, which raises some eyebrows.

Yeah exactly.

>
> We should also be aware that people are proposing file/shmem mTHP collapse, so
> ideally what we refactor would naturally unify some of these code paths.

Right yes. There's no harm in _laying the foundations_ for future changes.

In fact a lot of reworks are about doing exactly that - you can often go one of
2 paths:

	a. push the feature in as some tacked-on thing that works but adds
	   complexity/maintainership overhhead/etc. or

	b. Change the architecture to suit the feature you intend.

So my opposition is to a, not b.

>
> I am wondering whether shmem mTHP collapse should come first. (I'm hoping that
> shmem mTHP collapse can unify some of the anon+file collapse code in a nice way,
> to similarly just look like a cleanup while enabling a new scenario. Which is
> really what I am hoping for because the current code is A MESS with weirdly
> named functions all over the place. I hope it can be unified somehow ... and
> that needs some proper thought)

Yes.

And to be clear and I am going to say this in my (proper) reply to Kiryl - I do
think moving away from the presumption of PMD collapse is _key_ to a more
general rework.

But it's about how we get there, how the rest of the code looks, what other work
we do around it.

>
> >
> > David and I co-maintain THP together, are in constant communication, and
> > have a great working relationship :)
>
> Yes! :)

:)

>
> >
> > IOW - if one of us states a position on the sub(sub?)system - then take
> > that to be the actual position.
> >
> > I have poured what must be hundreds of hours now into THP maintainership -
> > it's by far my biggest workload on the maintenance front, by far the most
> > painful and by far the most thankless.
> >
> > I do it because I care about mm a great deal and am, frankly, driven by a
> > desire to see THP turn from a flaming trash pile of a code base with
> > confusing semantics and many, many broken parts into something that serves
> > the community's needs with far less maintenance burden.
> >
> > Looking over your series it seems some of the patches works in this
> > direction (great!), but much else of it fundamentally changes key
> > behaviour.
>
> Agreed, I think we really should unify+cleanup the existing code first before
> doing more drastic changes.
>
> Having a series that throws all of khugepaged.c into a mixer and pours something
> new into collapse.c is ... concerning :)
>
> But I am sure there is a way to incrementally improve the code? At least that's
> what I hope.

Yes. And it does look like a lot of the early patches are along the right road.

I do plan to do some proper feedback on this series along the lines of figuring
out how we move this forwards.

>
> >
> > So it's just a question of deferring the latter until we get to a sane
> > point with the former.
> Thanks Lorenzo.
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
