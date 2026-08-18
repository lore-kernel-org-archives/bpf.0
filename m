Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7BF225788;
	Tue, 18 Aug 2026 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787077847; cv=none; b=jI2ehUWZKoVQrpMoxETAif30dHnUMMWW/90AcTOruFDEVFiEYk7tuOn/j1wao15hxlSl+PMSIzPMcj37bjFEtJPGdpxn4hgMjevNY/0h4oC5tmnub1JClIXFlYod7171BAZyg5AZ8Wnv3e6oSLoOaXPoCQ1Z5SngzWNFG8GLW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787077847; c=relaxed/simple;
	bh=mG2o0lFlmMp/+FyKVsD6UAeTM56GvIEqJZjNGx6KdqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgSfqzHJwlv4yE5ttHzXjBnk5xWcyCPSEAUvJ6wEQWP6dbVipMPG6IPAgN7EUPjlNurfjOyNlOUSmhOBYPzzh9mnbaMypXNcQZMMTRf9XxfDXe3CXR+q6+73bdyTgm7CcxWui/rPLx8XD31PIa8quECxbcN5COBpuG4IQyjx7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8374aHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8374aHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18681F000E9;
	Tue, 18 Aug 2026 18:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787077844;
	bh=eSXj30Cc4bmvN5zj0El/x/FOhUHkxKr00UzqKxKBUTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O8374aHWwEIpB8vv/xQ0m1FNeDAEKwlQw84Lo7RO26aHb7Xkv6sMyt0AFUrdVi4Rm
	 tO4QoAB/9x/IVsbdh9XhzSMFY/ByTQVzQ4PT8NIsRKLbzSYvB0bSFN3IzDaoQjuW5X
	 YmpRYejAZqxKJJZWMnu9Jphxjj7+/bJDgmdLuGXRdBFy6z39EM6+6zZvVSsDawJIdl
	 5/O+1Km9e9sfPWZk05mSKMRXq/kKgMZ4lDeruxxyKAfuYsbicybncvqifQkYmvguYm
	 8vEhpn5b//iiuT/v19he/sjcqBpQLJAtEm3lEZmpkutCo2hwIs0XIMiKaVDzwrAvg7
	 Kpy89eo19Y2zg==
Date: Tue, 18 Aug 2026 19:30:34 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org, 
	nico.pache@linux.dev, baolin.wang@linux.alibaba.com, baohua@kernel.org, 
	dev.jain@arm.com, hughd@google.com, lance.yang@linux.dev, liam@infradead.org, 
	mhocko@suse.com, rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, 
	surenb@google.com, usama.arif@linux.dev, vbabka@kernel.org, ziy@nvidia.com, 
	usama.anjum@arm.com, agordeev@linux.ibm.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kas@kernel.org, jannh@google.com, 
	willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 01/57] mm: add pte_folio()
Message-ID: <aoSj1bxg8zR_grwQ@gremlin>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-2-kirill@shutemov.name>
 <7e40cdfe-67d2-4ddf-a048-f33b2d590371@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e40cdfe-67d2-4ddf-a048-f33b2d590371@kernel.org>

On Tue, Aug 18, 2026 at 07:09:48PM +0200, David Hildenbrand (Arm) wrote:
> On 8/17/26 00:45, Kiryl Shutsemau wrote:
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> >
> > Callers that want the folio behind a present PTE spell it out as
> > page_folio(pte_page(pte)).
> >
> > Add pte_folio() as the folio companion to pte_page(), and convert the
> > callers in fs/proc/task_mmu.c and mm/hugetlb.c.
> >
> > Preparation for the anonymous collapse engine, which reads the folio
> > behind a PTE in several places.
>
> [...]
>
> >
> > +/**
> > + * pte_folio - Return the folio mapped by a present PTE.
> > + * @pte: A present page table entry.
> > + *
> > + * The folio companion to pte_page(); only meaningful for a present PTE
> > + * that maps a struct-page-backed folio.
> > + *
> > + * Return: The folio containing the page @pte maps.
> > + */
> > +static inline struct folio *pte_folio(pte_t pte)
> > +{
> > +	return page_folio(pte_page(pte));
> > +}
>
> There is a reason why most code doesn't need that: because they should be using
> vm_normal_page() / vm_normal_folio(), or need the exact page and handle special
> ptes differently (see gup.c that uses pte_page()).
>
> And other code that uses pte_page() doesn't really operate on folios AFAIKs.
>
> That's also why you are only touching hugetlb code here.
>
> IOW, there must be a pretty good reason for us to add a non-hugetlb helper when
> that looks like a good fit for common code when it's really only hugetlb that
> does weird things (and doesn't need the exact page!).
>
> If we really *need* this helper, we should spell out clearly that it is very
> likely the wrong thing to use outside hugetlb code.

I'm also a bit concerned about softleaves here. Kinda implying every pte
has a folio is problematic in general especially if there is nothing
guarding against that being used incorrectly.

pte_page() is more of an low-level arch-helper it seems to me (let's go
look up a PFN from the vmemmap modulo arch stuff around the pte).

So yeah I'm a little iffy about it too! :)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
