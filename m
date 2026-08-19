Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD23A783F;
	Wed, 19 Aug 2026 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787162895; cv=none; b=C2CTUHOC09iMCOOwq7LvrV2v17ckt2O4zBlUhzQQKgy7UK2Clx7yjGpbH1Cu9RiqKqQCzMglmJ0VEYsCe4PztmGKP5oqSvLWLJaLm+m9vVcfqR3NyHKsedSQCN/il3C9fA7ihZK9jnMqrnsiSKndY4Y/Vzt8YVuAv2bKE3YcNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787162895; c=relaxed/simple;
	bh=NxRWT3YuLuxcyCM9JPBt79mgiyRMppnpNEGHh6ddUOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhBGT4hAKfg0QtyfaKV0pA3KphF9ist1w+JBvJ7V4OWOAvIhxcstW3pKf4p6E3CYGF3sG47UNi3QklLc1G8NpCSMT0erK+Wl15/f6wkwxXAh6uwbeHSSW8V4dsZcoO7Sbi5o7atLExs9gH7TNxXJp1rLmjxGvlZCr19UOheoWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=u5w5tF95; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSQq0HY7; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="u5w5tF95";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSQq0HY7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 6895E13000FB;
	Wed, 19 Aug 2026 14:08:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 19 Aug 2026 14:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1787162891; x=
	1787170091; bh=uaq+0fbwEcqKURx4TAQgKDlnoNt1749aqNbx25RhZlk=; b=u
	5w5tF95V3lXZcp5D0I0zfs+ecHlKfmPG2blkZY15q6J5+xaW1Kvt5Yd8bBDrCDNR
	1TUZq+FtPFEiXhbCY2aSYH1dR/0NqHHkX5bQMkzEzGy7ieH7z/G0h8DOW9FytuK1
	Z0qBTiwBH+6SY4MuJM9YdqsqbK7fZwxtLvUxbqGzacL9uW5l1FLiz/ZI8g/m6M1n
	qdI408wm3zB4vX7lDBrmwQfwH2w8zg9uc7Rp3VmO/IScTq9U6SHc+MEhvqArW49a
	fVfRWZMH4xcwsQwSU3GgMMxaEkKOq8WR+O0jMBPHaUqPLc+bOgLG5f1a0IRQInJv
	fkWrde0dQ7kB2ixaGv74g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787162891; x=1787170091; bh=uaq+0fbwEcqKURx4TAQgKDlnoNt1749aqNb
	x25RhZlk=; b=CSQq0HY76xdlaq5ZxlAH2Psixw7Fv1d5/+v1qDCxoWI+QLfvTKs
	+Wttv0ep25W/mCZm2VJ/dE6jiGBkKvtm2mwK+gMvJnnmMFk9uX6kCSRcwr8QwXe3
	BmO28VGnkGttLEnifmwulWQTZVmjUcgUW6yBkqpy2Ocr3ENhlKBTtEdYRuh0noi7
	Whsp1pCFfrz7eyv/b40wfxoM1U9nyiaxn2F36Uiv1z48NYnIvPF+Hv5N093ep17w
	vQRlrX/KZ7KM4LOMys8u568AR23idEmH9V3DydOp8IFpdUPhhbwRbS8ME2LOY6J/
	9xndGtqNVrl3ETwirElPUdJVsXHdpzMM5Ig==
X-ME-Sender: <xms:CfGFamBmv7jTcwHu4_7WZ1usDVB61LkbyCHTGj57imaS5Qs6Xn6NNg>
    <xme:CfGFag9PC1_VlT9T7ICg8IrFgyIt6_gfraXKG9Gx-Mxb9M9rnJWLX_7s0R1yEJFdl
    jSwOrwYFf9-GdaL5sezszorg4nEJgrkDV88fm4GNS2HiYFeRScAlR-k>
X-ME-Received: <xmr:CfGFarC5DjE8pq2NZguhLaP3hS2x8EltD2og72MELpSo5GwfSjVqtoTqdiY>
X-ME-Proxy-Cause: dmFkZTEgoTbh0p34SJ7+/0elPjJ1CCVFNDauFEce9e/PhqdeYc+K+ZgiTHZkYjWz6as8HW
    oQqR7eMJeilkJP6P1vcZe7H7THogp3+w/si1KyGhbFLyCmCZ3dPSp7xAHp9w9JVMzETRjH
    ZGi/BBtM8fbP2xEpT5MXNgJOPYusCj9icwG2R8r2iUSU/Af7shD7UHlpDl2FqwQISqGxrn
    4VHBTrLtusZogfLm1C7BWVIo+E+nsrpLj0jpAuYoyY+biRGqR6g19JzN77aqCq3myX5CqS
    Ub8VqStbhVuyo3lwlRqil4HhAefmg77OYfy+hvKjlo0cc4lJXUaWtMhIMsqxRKBY3dE9Ls
    EM7L17LM7uTf+mZo8Wl70TIRE0ptPYiP/tSP0az76p/Du9Z8wMv+ViEMNvMtIkWhMPlHwj
    GVP9xctd5omGc04HD83qAkNK25YjUu5tn6zQ4NkAWG/C9oBh/HZU3kbP3Y8cM4aK1fqXpb
    LqNz4vAtJFiqhGscoBf4snNRUbxuKWv16sb4TX3eoLDwCBEHTQ/B9WKLkXPdhUOUIgKIob
    Tvxkf2MrVd0T1Ro7nCtt5EPQRQ7gHD5h+IzboECIdC7ZZgl4+OMaUY+lJDQ40FwWSi35ZH
    NJvywTZIbRunZkGTSi4Nf9wcmV96zAG4Q9LJxGfSmcLsbTBh8jK/80HwU1tg
X-ME-Proxy: <xmx:CfGFakxXBBkjw866zcaxeAN8XwJoSukID1GcaW1PPLxULaKrnzrTHA>
    <xmx:CfGFaqrf5vjKwFGgHUgrf28PNDd_wKCxUZPhERsQu-IWsWP8mOBiGg>
    <xmx:CfGFanwyg8yvx0IqclLgrSuHWYJSG0qDArvdTj__rq8LDsP44ve51w>
    <xmx:CfGFakP5BQAMevJkef1rpMVWlvELiICBlM2tyKp7v78gWI6xejeRWA>
    <xmx:C_GFajaxphludb9eZOBP7B56bu181zvGOnr8Co02FXO0mHd60Etj6X7x>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 14:08:08 -0400 (EDT)
Date: Wed, 19 Aug 2026 19:08:07 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, akpm@linux-foundation.org, 
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
Message-ID: <aoXn1B7cPnPq7uxd@thinkstation>
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
> I think we all agree that there is a lot of room for improvement, but the big
> question is:
> 
> (a) When does it stop being a cleanup and is a new feature in disguise that
>     makes the code more complicated and even harder to maintain.
> 
> (b) Can it just naturally be made looking like a cleanup.
> 
> Ideally, we'd get b), in small, nice-to-review chunks that incrementally improve
> the code without inflating it heavily or moving everything around.

It is not a cleanup and I would rather not sell it as one.  It replaces a
mechanism, so judged as (b) it fails by construction.

I believe the end result is much cleaner. But I might be biased. :)

> The current locking is nasty, so anything that moves us one step closer into
> something that is not only simpler but also more scalable is nice. I am a bit
> concerned with the churn in the series as is.
> 
> After this series, mm/collapse.c itself is way larger than just mm/khugepaged.c
> originally, which raises some eyebrows.

Line count is a poor proxy for simplicity or scalability.  What the
engine changes is the serialization model, and that is the part collapse
needs changed: the PMD granularity and the exclusion both come out of
the locking.

Incremental does not reach it, though.  The old mechanism is correct
because it holds mmap_write_lock, the anon_vma write lock and a reference
from the LRU; the engine is correct because the sources are frozen behind
migration entries.  There is no halfway state that is correct under both,
so the switch lands as one patch.

What can be incremental is everything around it: the engine goes in beside
the old mechanism, patch 25 points the anon path at it, and 28 removes what
it replaces.  Until 28 both are in the tree with only one of them
reachable, so the switch can be reverted on its own.

> We should also be aware that people are proposing file/shmem mTHP collapse, so
> ideally what we refactor would naturally unify some of these code paths.
> 
> I am wondering whether shmem mTHP collapse should come first. (I'm hoping that
> shmem mTHP collapse can unify some of the anon+file collapse code in a nice way,
> to similarly just look like a cleanup while enabling a new scenario.

mTHP collapse as it stands has limited usability: PMD-aligned windows only,
and one VMA has to own the PMD.  Bolting file collapse onto the same
structure adds to the debt instead of paying it down.

It would fit the new design.  The frame -- scan, candidate selection, the
round and its passes -- has nothing anon-specific in it; what is
anon-specific sits in the freeze (folio_test_anon(), PageAnonExclusive())
and the unshare in the fault-in pass.  A file source would bring its own
check, freeze, copy and install.

I am not sure it should, though.

Do we want to find file collapse candidates by walking the virtual
address space at all?

collapse_file() already works on the mapping -- it builds the folio in
the page cache and then repairs every mapping through
retract_page_tables() -- so the VMA walk only picks which inode range to
try, and it reaches only what a registered mm maps right now.  Large
folios buy more than TLB reach: fewer page cache entries, cheaper
writeback, natural locking batch, etc.  Those apply whether the file is
mapped or not, and going at the inode directly would reach them.

> Agreed, I think we really should unify+cleanup the existing code first before
> doing more drastic changes.
> 
> Having a series that throws all of khugepaged.c into a mixer and pours something
> new into collapse.c is ... concerning :)

The moving around is patches 29-35 and the tracing after them.  None of it
is needed for the engine: 1-28 add it, switch the anon path over and delete
the old mechanism, without moving anything else out of khugepaged.c.  If
the churn is the problem, v2 can stop there and the moves can come later as
their own series.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
