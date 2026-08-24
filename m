Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9742902E;
	Mon, 24 Aug 2026 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581331; cv=none; b=u4Z5KNbp+Dw2WfutCYDb/fAHp9XszqWBgsn8qKdQIo4KiOPhHOS7KQ3aUvkG6j0O/W9cPiEMcW/FXX9VzTYk9kkbH71km6pS5nVVrx3ip29B8+t8BbOfp3+LcRHYmpsU6A/Dumflq86r5jGyddQkKTij3MVK9+KhjvsXd74LImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581331; c=relaxed/simple;
	bh=KJAluXXdqui4zkMtLXpfXyj5UR3ic0BTN3h4iuzhLM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAC099lvohUULlkp7q6BGApztrZko3lbxa2FuFj2+7vDETE6PACsPAc1CyFt2j95ecaOzJGzumYcN9zTLxIw9px9DmYC99xcm4OB/HSidUnkaRMtd7ekXbI6U0tTwapRMW7XmiUXJDbk1SKiyRI5eVwpOecC6wiKpSyU0cX4XXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaO+iZO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaO+iZO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142241F00A3A;
	Mon, 24 Aug 2026 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787581330;
	bh=5j5DWKJN3cdhmHqdN8rCpFWNLqVKoHQJspSwWStoi7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KaO+iZO2NSk2Mb6Znp4wkLjU5Psq+sSLTkfTwe0+7WB9WPQgyt6fGHjYZV/zU3Ij4
	 jlJwIh1FB4tUanbeYBsel3kuT6oDpApt/nGc2A/jpsx8No/76t7v8SkSIGmFPCQZHq
	 x/stZ2CCZMEYIwBH2TMkf2I6Kb6U4Vb0qQpg+buiH2VOWmHgTwuJ7fLAW4vrSs/qqT
	 FFfr9sG3A9qW1t2+BBLBIHX/wpRTS0+mcevOWj9fdts3KEZ9zaJXvQwRkTw4iabRz2
	 MRD5fdodUOKKmoRUSt4jl6yvfX60M8VPs27KzmhOBhTfVgKE8xrxwTcZCVAJ/MhsjO
	 FxmiBGAPOYNOw==
Date: Mon, 24 Aug 2026 15:22:02 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	akpm@linux-foundation.org, nico.pache@linux.dev, baolin.wang@linux.alibaba.com, 
	baohua@kernel.org, dev.jain@arm.com, hughd@google.com, lance.yang@linux.dev, 
	liam@infradead.org, mhocko@suse.com, rppt@kernel.org, ryan.roberts@arm.com, 
	shuah@kernel.org, surenb@google.com, usama.arif@linux.dev, vbabka@kernel.org, 
	ziy@nvidia.com, usama.anjum@arm.com, agordeev@linux.ibm.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, jannh@google.com, 
	willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 00/57] mm/collapse: rebuild collapse on migration
 primitives
Message-ID: <aoxRs0mjyQnpO-IT@gremlin>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <aoLAly-oL2OAa4n8@lucifer>
 <aoLkMUtmzRVuv2Hx@thinkstation>
 <aoQ77EcD3M2kjeya@lucifer>
 <0153303d-f9d6-45ea-a276-fbf2e5625ef9@kernel.org>
 <aoXn1B7cPnPq7uxd@thinkstation>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoXn1B7cPnPq7uxd@thinkstation>

On Wed, Aug 19, 2026 at 07:08:07PM +0100, Kiryl Shutsemau wrote:
> On Tue, Aug 18, 2026 at 04:12:17PM +0200, David Hildenbrand (Arm) wrote:
> > I think we all agree that there is a lot of room for improvement, but the big
> > question is:
> >
> > (a) When does it stop being a cleanup and is a new feature in disguise that
> >     makes the code more complicated and even harder to maintain.
> >
> > (b) Can it just naturally be made looking like a cleanup.
> >
> > Ideally, we'd get b), in small, nice-to-review chunks that incrementally improve
> > the code without inflating it heavily or moving everything around.
>
> It is not a cleanup and I would rather not sell it as one.  It replaces a
> mechanism, so judged as (b) it fails by construction.
>
> I believe the end result is much cleaner. But I might be biased. :)
>
> > The current locking is nasty, so anything that moves us one step closer into
> > something that is not only simpler but also more scalable is nice. I am a bit
> > concerned with the churn in the series as is.
> >
> > After this series, mm/collapse.c itself is way larger than just mm/khugepaged.c
> > originally, which raises some eyebrows.
>
> Line count is a poor proxy for simplicity or scalability.  What the
> engine changes is the serialization model, and that is the part collapse
> needs changed: the PMD granularity and the exclusion both come out of
> the locking.
>
> Incremental does not reach it, though.  The old mechanism is correct
> because it holds mmap_write_lock, the anon_vma write lock and a reference
> from the LRU; the engine is correct because the sources are frozen behind
> migration entries.  There is no halfway state that is correct under both,
> so the switch lands as one patch.
>
> What can be incremental is everything around it: the engine goes in beside
> the old mechanism, patch 25 points the anon path at it, and 28 removes what
> it replaces.  Until 28 both are in the tree with only one of them
> reachable, so the switch can be reverted on its own.
>
> > We should also be aware that people are proposing file/shmem mTHP collapse, so
> > ideally what we refactor would naturally unify some of these code paths.
> >
> > I am wondering whether shmem mTHP collapse should come first. (I'm hoping that
> > shmem mTHP collapse can unify some of the anon+file collapse code in a nice way,
> > to similarly just look like a cleanup while enabling a new scenario.
>
> mTHP collapse as it stands has limited usability: PMD-aligned windows only,
> and one VMA has to own the PMD.  Bolting file collapse onto the same
> structure adds to the debt instead of paying it down.
>
> It would fit the new design.  The frame -- scan, candidate selection, the
> round and its passes -- has nothing anon-specific in it; what is
> anon-specific sits in the freeze (folio_test_anon(), PageAnonExclusive())
> and the unshare in the fault-in pass.  A file source would bring its own
> check, freeze, copy and install.
>
> I am not sure it should, though.
>
> Do we want to find file collapse candidates by walking the virtual
> address space at all?
>
> collapse_file() already works on the mapping -- it builds the folio in
> the page cache and then repairs every mapping through
> retract_page_tables() -- so the VMA walk only picks which inode range to
> try, and it reaches only what a registered mm maps right now.  Large
> folios buy more than TLB reach: fewer page cache entries, cheaper
> writeback, natural locking batch, etc.  Those apply whether the file is
> mapped or not, and going at the inode directly would reach them.
>
> > Agreed, I think we really should unify+cleanup the existing code first before
> > doing more drastic changes.
> >
> > Having a series that throws all of khugepaged.c into a mixer and pours something
> > new into collapse.c is ... concerning :)
>
> The moving around is patches 29-35 and the tracing after them.  None of it
> is needed for the engine: 1-28 add it, switch the anon path over and delete
> the old mechanism, without moving anything else out of khugepaged.c.  If
> the churn is the problem, v2 can stop there and the moves can come later as
> their own series.

This whole reply seems AI-generated...

You replying only to David twice in this sub-thread which isn't exactly giving
me warm fuzzy feelings about the working-around-me concerns I raised here.

So simple feedback - send a relatively small, no-functional-change series that
improves THP code and lays foundations for future changes. After the merge
window.

Can you explicitly ack this please?

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

--
Cheers, Lorenzo
