Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDE036E494;
	Mon, 11 May 2026 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498417; cv=none; b=gImvo9UD5pdK76Agmad8fsd1ue49jup9PnglbU5AG6yPvd2ek4EdCotI7Z9MjTlgRL6HJVsrN4n/4d354Rw8fi+0OUmstk7Zma1w2LtjxUEyNcYsREf8yMULpcjezuVTdVz1LnykooHJXalgpVXRsf42es7r4bfqDvupAm3NenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498417; c=relaxed/simple;
	bh=c1iN285AfyesN+CVeye90xit8+UukjhBJ2wEQ3aW/Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiMidMGD5ksXnftdVv/kXRK7nHZL3qvZ0fqem5aNLbDQr3vFJnILbUKlgoFL0dxFC8H/Zclp+dvWIxCluYyg/showllNU/uA91f+3yufp2yyX+1GltdrsLbnJKRKm9P+SlWlaNCaGwc4TBihFPa0Q0rhXSXp1pOORbW8AdbE88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcQg+hU/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcQg+hU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5F0C2BCC9;
	Mon, 11 May 2026 11:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498417;
	bh=c1iN285AfyesN+CVeye90xit8+UukjhBJ2wEQ3aW/Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcQg+hU/Pq47cHF3AHzRll3ksA8jiCmioAMiE2KKaQqajNu9TDnSVq/gtHmgJWoUA
	 5nB/g8NTcZKwMbxPC8yBBOrx4Kyu18EijQV1fqIcvW8TYk13nm2lORABuOVDsYcYFy
	 jXgvgs2o8wwfzGNqYYWeRiP+8qaxp3x7n2btdYuyZcISVCEWiP96ZSeAAQlK27w1bN
	 fK9Y1KCPpv6CZP/N+aPsMEK0yJ3ZsOdVsZsi7qOo/NqawlYLuBsQUDkoDbvjtitagz
	 TZ4o+tLBu7urXvdL6How7gDq5goFfZ/BIEI+KIA8ZmsrtufT5q0Gmziua1HJHAQcRQ
	 Oz6Uje7yFouxg==
Date: Mon, 11 May 2026 12:20:10 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, roman.gushchin@linux.dev, 
	inwardvessel@gmail.com, shakeel.butt@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	surenb@google.com, tz2294@columbia.edu, baohua@kernel.org, lance.yang@linux.dev, 
	dev.jain@arm.com, laoar.shao@gmail.com, gutierrez.asier@huawei-partners.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v2 0/4] mm: introduce mthp_ext via cgroup-bpf to make
 mTHP more transparent
Message-ID: <agGzD8K9EBMMkhEH@lucifer>
References: <20260508150055.680136-1-vernon2gm@gmail.com>
 <af376QFXC36uf7kp@lucifer>
 <af4IEwbAAIYUH0z9@lucifer>
 <CACZaFFNdk5EfBxCTT0WOPGLiG_01wNESem_DKAu9SK1hrzBhow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACZaFFNdk5EfBxCTT0WOPGLiG_01wNESem_DKAu9SK1hrzBhow@mail.gmail.com>

On Sat, May 09, 2026 at 12:53:35AM +0800, Vernon Yang wrote:
> On Sat, May 9, 2026 at 12:05 AM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > On Fri, May 08, 2026 at 04:15:04PM +0100, Lorenzo Stoakes wrote:
> > > Thanks for the series, but overall it's got to be no to this until THP and mTHP
> > > are in more stable shape.
> > >
> > > And this is an RFC, you're trying to make really fundamental changes here, it's
> > > almost... rude to do that out of the blue non-RFC'd (unless you're a maintainer
> > > perhaps).
> > >
> > > Right now the THP code base is a total mess and mTHP support is not even
> > > properly merged yet (khugepaged support outstanding).
> > >
> > > BPF interfaces are permanent, we've tried the 'experimental' thing before, it
> > > doesn't work and we'll not be able to yank it later.
> > >
> > > I've said it before, but we really truly need to get THP into better shape
> > > before we can tolerate large new changes, let alone an user-exported interface.
> > >
> > > So can we defer this until we're in better shape, and then send that as an RFC
> > > first please?
> >
> > Yeah on second thoughts, NACK and don't send this series again please.
> >
> > I was already annoyed you'd send something this invasive and massive without an
> > RFC, but you've also ignored the feedback we gave to the last THP BPF series
> > while ostensibly claiming to have taken it into account.
> >
> > And then... I mean seriously... _shamelessly_ trying to take control away from
> > THP maintainers and reviewers who work bloody hard for this community by parking
> > code that changes mTHP behaviour in an entirely distinct and unrelated
> > MAINTAINERS section...!
> >
> > There's a biweekly THP cabal meeting which you didn't raise this in, you didn't
> > bring this up at any conference, you didn't send an RFC.
> >
> > You've sent it too before we even have mTHP khugepaged support merged... or have
> > really stabilised on how mTHP is supposed to work overall.
> >
> > And also I have made it really abundantly clear that I want to see the technical
> > debt _paid down_ before we add anything else major.
> >
> > And as if that wasn't enough, AI review is finding endless problems with this
> > series on top of all that.
> >
> > This is NOT how to engage with upstream. Again, please don't send any more
> > revisions of this.
> >
> > And next time _engage with the community_ before proposing something this big. A
> > [DISCUSSION] email, or an RFC, or in a meeting or at a conference, or even
> > off-list or on-list mail, something.
>
> Firstly, before mTHP stabilizes and enters better shape, I will not
> submit any new version.
>
> Let me clarify a few issues:
> 1. This is an RFC. I forgot to add it. Sorry.
> 2. There is only one issue in the AI review; the rest are false
> positives (the AI did not find the dependent patch "mm: BPF OOM").
> 3. Regarding placing bpf_huge_memory.c under "MEMORY MANAGEMENT
> EXTENSIONS": I never intended to take control of THP away from
> maintainers and reviewers. However, it is still my fault for causing
> misunderstanding. Sorry.
>
> Also, I would like to ask: what work on mTHP still needs further
> refinement at present? I can help out.

Sorry maybe I overreacted here, long week...!

But in general - yes there's work to be done but what we need help with
above everything else is to pay down technical debt in the THP codebase.

Review also helps :) right now we are adding mTHP support to khugepaged
which is the next 'big thing' for mTHP.

As David has said elsewhere, the _interface_ is the challenge with
BPF. Because we truly want to be sure that interface is the right one and
won't impact our ability to make changes to the implementation of THP as a
whole.

Treating BPF as a de facto permanent uAPI is the way to go I think in
general.

Cheers, Lorenzo
