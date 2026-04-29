Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65194334374
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470759; cv=none; b=ZxpXkth5wAWf6yKHGoVPOwPMwLnpm541PoXDup+bnsMY0Nb89VRHp11fFQfWF4jndR/LPYsmaD73X2jHfFbZLvi0n9HImAn7jVcYHpej00MCV3qrgGn1N2h40iHNlw0OeOb9EwWTRJChklNP6dnlaqrqZeozZHkzTzduevy5NMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470759; c=relaxed/simple;
	bh=QMtTK6iug2FWIYFRndlzUDcVs8GKNDniLG6kOrnGQtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYvPakXJ1/O9wNivR5nwFAi03Pp2J6Hl8GRAmcomt0j27oGkhEGos5OjAr9Zm5qtewcPELWKgD+9xMnxt0uEF4y3SeTQhcGnFDqD2OlbOmTl3Hg1MJJnCPE0q4pDrVDuIK2Ddf0tj8ciWVvUSLiTa4LevZXRM+FTkpjswtWIBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=AMugM8Ie; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="AMugM8Ie"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44509921fbcso2186566f8f.3
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1777470753; x=1778075553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xppRCqAQC4xKx5jzTnW41eBchdpaLIr292ff3JfaZWA=;
        b=AMugM8Ie0bzuQhWotsBaD3IMZ88OslWRuW8edF0SQgNao/spFlDaxxPNL8CwQitprw
         VDcH5/2lhdCoE1RxZY3qzuHOJkLMUSwamHMrllId1TwZOiAoSWZhuXm4YKj68wBwdeM4
         JXojIMEfjrgh8HjavSGdI8FSvu76uJrcOxLv2PGsSHhesMn6Kpe2zCTNHps9YZjpAcMw
         8ldcnZE5KvSxeGOD7L57hseZSaBwV7hlASea1HRpwLG1zjW2m0RW96lVAiRwC6HvCNpQ
         6lZxqDdT3WmBtfoVaVemI9iOIzS8GxY4FukIuam/Io/t0ZLY5Kn+cLOZpTmi+iUemt2m
         jeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777470753; x=1778075553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xppRCqAQC4xKx5jzTnW41eBchdpaLIr292ff3JfaZWA=;
        b=eFlZpHvPeJ0ShT4H4g98t4F+QfjMxRw3WO1CB4CMFLmy/ExyznpGSQmYXkXXFzFbHV
         tB7JSoxF3MuTNgtlUcG8fTlWPZ258XF4pk01ZnGdFgX0wKhhfRAvDwGqTBsC6cZ6Tnkr
         v/uRQaxZCWzSE1eCUu/kf6RbBwK3XbdDWswILXvYhF0DdcLBYw3htDHkXs2RyIBbKduF
         5oeppGM2w0E7uKFelrWhucmgHAlvjDWFqreddayR9/F2WgMaO9uuKAxWQTC45/I+ORxR
         mdCHO1mjG+3iqoDHcU9HxAQLbJaI7Vm0BjauFIzrqvZFi13pBWhfTeg2ST+RXz5tTKKg
         sHjA==
X-Forwarded-Encrypted: i=1; AFNElJ8torSN4MnmRgfL3X7H7nIYc3zs/QQkebIwfBi30C/clb2zUodr8pvkbfnUGv/i9nS6BrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZaH6O/571Uf9mwK0BFLbGbBVJI/5rHbLswIREwepWlTJMfP8K
	kh6cd09q/gSbvy8/n7+RqESa2gAkCrLg7jir2KSrAPNUSqY9zckNOIWaqqErntxoPUY=
X-Gm-Gg: AeBDietnpksQU5agFT+xLDqz63XKjeJj5i6NXUfyCVDaP66kjdLYC6tvVei7Hxtvp+0
	oTbS7C7yOqm1LQehuVHRTf5QFhucKrgYicHwjqcm970yX1k4d7gVV9dPFNS50H66FqKS3IgLF/0
	DP7FpF6TptASebt+gNTKHLOKB4USVBMwKRUTTooefi2HvsbPPbEJPoH8duC+R0xzRYneqOGXgTC
	xWmIBdpE/Sp1SAudVy4j7P6GckJI1RiUIPm5QEt53CQTbzgdd8l5T1iQzVKs+ZdEBJOMl+eIyO2
	eyQMeLfP9j3EgfBPprSvOmguozEINBthJGPT2HgDSeryPFUKrxLEin+4KBIotrMwFv9QJ5tYURc
	nMvtf4gBmUWI4Ia+47HSppcNYPKzbHcFnE3g7D63dXTac2b0irsB+289Chn3H8lonHvYg+VHHWi
	F/yQ3YglNZVNGUGZUn3gi7/L1EiDerTQ==
X-Received: by 2002:a05:6000:2582:b0:43d:6787:9933 with SMTP id ffacd0b85a97d-4478e9931cbmr7296792f8f.13.1777470752934;
        Wed, 29 Apr 2026 06:52:32 -0700 (PDT)
Received: from localhost ([217.138.75.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7217afesm5980210f8f.23.2026.04.29.06.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:52:32 -0700 (PDT)
Date: Wed, 29 Apr 2026 09:52:28 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Vishal Moola <vishal.moola@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	david.hildenbrand@arm.com
Subject: Re: [PATCH v6 0/3] mm: Free contiguous order-0 pages efficiently
Message-ID: <20260429135228.GA1987@cmpxchg.org>
References: <20260401101634.2868165-1-usama.anjum@arm.com>
 <20260429103326.GA1743@cmpxchg.org>
 <20260429050430.d86f01dbe731edc9fa932add@linux-foundation.org>
 <9834200a-492c-4705-a2b2-e76cc0ba5392@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9834200a-492c-4705-a2b2-e76cc0ba5392@arm.com>

On Wed, Apr 29, 2026 at 01:31:10PM +0100, Ryan Roberts wrote:
> On 29/04/2026 13:04, Andrew Morton wrote:
> > On Wed, 29 Apr 2026 06:33:26 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> >> On Wed, Apr 01, 2026 at 11:16:18AM +0100, Muhammad Usama Anjum wrote:
> >>> Hi All,
> >>>
> >>> A recent change to vmalloc caused some performance benchmark regressions (see
> >>> [1]). I'm attempting to fix that (and at the same time significantly improve
> >>> beyond the baseline) by freeing a contiguous set of order-0 pages as a batch.
> >>
> >> I think we should revert the original patch.
> >>
> >> The premise is that we can save some allocator calls by requesting
> >> higher orders and splitting them up into singles. This is a frivolous
> >> and short-sighted use of a very coveted and expensive resource.
> 
> I'm not sure it's that simple. First off, vmalloc has preferred to allocate high
> order pages for quite a while, it's just that the patch you're referring to
> makes it try even harder. So reverting the patch doesn't completely revert the
> behaviour, it just reduces it.
> 
> Performance benefits because those high order pages are mapped appropriately in
> the page table - i.e. 1G PUD, 2M PMD, (or 64K CONTPTE on arm64). So it's not
> solely about the number of cycles spent in the allocator; the HW is used more
> efficiently. vmalloc only splits to order-0 for the benefit of the caller,
> because there are some places that assume they can access each returned struct page.

Sure, TLB benefits can offset the cost.

PTE mapped higher orders on systems without contpte (still many) are the problem.

> And all the order-0 pages of the original high order page are freed at the same
> time, so it's not like we are destroying the contiguous resource; it remains
> intact for the next user (well, ignoring that some will be freed to the pcpu
> list - this series solves that wrinkle). I've heard it argued that this approach
> is actually _better_ for conserving contiguous blocks because it's keeping the
> lifetime of all the constituent pages bound together and reducing fragmentation.

You're still consuming contiguity and increasing competition over
it. That needs to pay off in a closed system, not just in one small
part of it.

I'm a bit skeptical of that beneficial effect. Sure, if there aren't
any small fragments and most everybody is doing larger allocations,
then yes, this could make sense. Although in that case, even calling
the buddy allocator repeatedly from vmalloc would give you physically
adjacent pages due to the way splitting works (although I'm not sure
right now if you'd get the right exact PFN order for contpte).

But as long as there is a mix of allocation sizes with mixed
lifetimes, consuming contiguity that you don't need has a high cost
over vacuuming up holes and fragments. Because now you're competing
with somebody who has no choice but to *painstakingly move live pages
around to coalesce the holes*.

That's the whole reason for the __rmqueue_smallest()-first policy in
the page allocator. It's fine for somebody to challenge this. But it
feels pretty strange to make a unilateral decision in vmalloc that
works around and inverts established allocator policy, with very
little data to boot.

> I've never seen any data though...

Yes. Considering the possible externalities of this patch, IMO we
should have much more data on big picture behavior, under varying
pressure situations and workloads etc.

The reason for my email was that we see this hurting in experiments
with new code. The vmalloc higher-orders cause a sharp increase in
compaction activity, subsequent lock contention in zsmalloc migration
callbacks etc. I wasn't just making this up.
