Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7893812FB;
	Tue, 18 Aug 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064126; cv=none; b=InXuZjh7u7nx9UrFr7eGpRvDGAlmqfrv908kv4usqmMr2DC0wUD0ifvYEPAkiv1eV4tRHhrz5TFrZCDLKzjUjELpo1zxQk96uO5Q10Dlvhhg0qg2c2mM7nzwj7EIDyNmZVavIC0szr8Q2MNBaArv5JiJWfjERHnfGVmhqYppY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064126; c=relaxed/simple;
	bh=8bHO7dMJiHXvIoMvb7YLuOXiYkeDw930A2e0yHp6ZJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYRx6QU8LlTUNtuTBA6vxyfNMvvCWlP206Mav2QDQGKR2+/y9gL0luhF4Z4yKOg9hs7y4FzACqMIR/VGnRN6SfwBq0Or3vmJO1J6TepAzo/lLn0CdY418s7QNaCxBUoFuCb7b8FV7ScKhY4ollG4qvdJBSGd9rg6pWIsj9p23CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDQc3TbX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDQc3TbX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2261F000E9;
	Tue, 18 Aug 2026 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787064123;
	bh=fIgroO17cxW3StOu7FtwzJ0p4BsPX3URbvdP5tpra2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CDQc3TbXHMGHuOVnFhO/NrVr0MqkyFFMgQaU1KZKGPZQbiFQsjLNVGsur+cfMnnZO
	 UQPUWRzDS08US+P2dtx0QNBWWrenfUHoeJRTJTyWT+xDVcdAGiYgnODJzYbteqNI/1
	 LPdnZLcxdLysRPBDgdvowJ0y9rqygjW/gvqdAu64/kzb8UYZL9wzLY5hk0+SdEOfhB
	 J6s/JFVnqkhVvCOsSIb85qhuHJ/fUPElB2yxQ3YNC7EpiSHIEt4WOqosvz1N8aWpLm
	 qUIT+6t6QlJNDUnSwUmtIWnwtHjPiDoi7fk9PBqGmwtkC9fD//KBG8JCJDhpCu4PG8
	 vAgGurOJhSoHQ==
Date: Tue, 18 Aug 2026 15:41:40 +0100
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
Message-ID: <aoRuqbgFAPyZtUli@lucifer>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <aoLAly-oL2OAa4n8@lucifer>
 <aoLkMUtmzRVuv2Hx@thinkstation>
 <99138bda-55ba-4c58-9b79-b76e9daecdde@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99138bda-55ba-4c58-9b79-b76e9daecdde@kernel.org>

On Tue, Aug 18, 2026 at 04:15:27PM +0200, David Hildenbrand (Arm) wrote:
> On 8/17/26 15:38, Kiryl Shutsemau wrote:
> > On Mon, Aug 17, 2026 at 09:52:13AM +0100, Lorenzo Stoakes (ARM) wrote:
> >> We have a THP cabal meeting every couple of weeks where it would have been
> >> useful for you to raise this first.
> >
> > Fair -- though my invite is on my old @linux.intel.com address.  Could
> > you forward it to kas@kernel.org?
> >
> >> In any case - this series is not something we'd consider at the moment,
> >> even broken into parts.
> >>
> >> David and I have put THP into feature freeze - until the codebase is
> >> subtantially improved we're not really interested in seeing significant
> >> development.
> >>
> >> The technical debt is substantial and has to be paid down first.
> >>
> >> See [0] for a rough list of TODOs in this regard.
> >
> > I read the TODO list and I'll pick from it -- though I notice the
> > technical debt section includes "Literally all of the code in
> > mm/huge_memory.c and mm/khugepaged.c", which I'd argue this series is a
> > fairly committed attempt at :)
> >
> > One clean up I wanted to do is consolidate code by functionality, not by
> > the THP/non-THP split.  Move all page fault handler code into mm/fault.c,
> > unmap code into mm/zap.c, fork's copying into mm/fork.c -- mirroring
> > kernel/fork.c, so the mm half of a subsystem sits under the same name.
> > Large folios are an integral part of mm nowadays and I don't think we
> > benefit from keeping THP in a separate file.  It is also an opportunity to
> > shift away from mm/memory.c being a kitchen sink.
> >
> > David and I talked about this at LSF/MM.
>
> Ah, I missed the context in my other reply. Lorenzo already had some patches at
> some point to split up mm/memory.c into better chunks that will also better help
> our subcomponent maintenance model.

Ah yeah I kinda lost those but indeed doing this is a good idea.

I should try to dig those out again or look again when I have a chance...

>
> I think the challenge is how to handle huge_memory.c, because ideally, we'd not
> have these stupid callbacks into huge_memory.c once we make PMDs just a
> first-class citizen.

Yes and another point and I think it's one that Kiryl also gets at is - can we
_please_ stop pretending huge folios == THP == what the page cache does == page
special cases like DAX? :)

I think Matthew had ideas (TM) about separating out CONFIG_THP from that stuff
but that's another way in which we can unwend some of the horrors.

>
> This is, unfortunately, also something that needs more thought, because we don't
> want to end up moving stuff back and forth.

Yeah annoyingly it's not all straightforward. I wonder if actually gauging off
of what series often touch in patches might be a good way of figuring out how to
separate, funnily enough (certainly for mm-next conflict resolution purposes
anyway).

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
