Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D23E8356;
	Mon, 17 Aug 2026 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786961238; cv=none; b=KczcpKvQN40LhAysqIr55ZdveHgG7LZSBU/OEsOjGltaiAIicKqQfUubAXFIo+gq+WxdjHMM+q9kd+1NPWWhrTRY7r8Telf1XcpzcvgL7dfgH0E/9UA3oK2FWUWbEH3egBMYwJZlMdYRo26RRCBhg1KGb/jVLc01dGWamWe7WYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786961238; c=relaxed/simple;
	bh=ZLDLJ/KyytAKY3NBmGcEhTfUVtSQGMNC3kccuD/k488=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNGYf/+S8E63v+lKsn3LzS/9NyLVFsoHUKjeAWLN5i769/23ojRn1rw5KFNZGKuvB4diAS4xhQKa0unQ2Ff8zN9ISKR80KH6s/pYTiUKWvQZvAB8oqV2VnJM/1QH7jepiFEl0hCulrELktwomCkVpyMlsP89BwRJx7hfNVXLOpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Obw+j5Wg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jc5xJb2V; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Obw+j5Wg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jc5xJb2V"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 5ECA31300157;
	Mon, 17 Aug 2026 06:07:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 17 Aug 2026 06:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786961232; x=
	1786968432; bh=aRuNgn93bXJUfUxBiQxkO2z074NGsTuHkXM1In4i/2g=; b=O
	bw+j5WgWN+X6RQhGAYltwX6zzKc0Fc3AgF/3bxvz2QdUBFHjnMtBLTcg+Y+dnImg
	CyzEfKss1yEa2iQcZJvd7MoCY3w8OU/SSX5g8LouAtrJSqf2QgP4o3DVmRU4RfAE
	xL6WLF8j79qAZvgk0xHb/r+suYpm9YbGpJj3HNbBlXaIFwCjomWvp39d7bu0pE9O
	FQ7J9brTf0KpLa4NP5We5Yt5jfLeGAcKf8WLpTIrZIz5BEL9gW5R0udM8ieJU8AC
	6+tWXw25nO0maJonQZMdrMIZq3EXoX0ev6OqrvgZfzxh6dvU6RvUG977GDJbSb4v
	7MjxthZq5Ew36jTVBXhTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786961232; x=1786968432; bh=aRuNgn93bXJUfUxBiQxkO2z074NGsTuHkXM
	1In4i/2g=; b=jc5xJb2VoVZ1fl2S6LLqziq4i2u2Rbe32OHQeJVp/2ttPYTXew0
	7fI87ivUzXyjtnbDs9dM6NQNV3o8ArPMOKaUgnltc5Lub9V598q6WxgipKSq6vty
	zeDD7M/ZgRR1gOO4hUgeirt736eb0ZwlUwCWnJNZDvk45D3gRHqaNGzzARe++MR9
	T8wj+C5TYn88f0zcpQvtazCWS5NJGNTs8rMFuHegFjkZ7AePLSicCWft5HQoGLPo
	Ln/FnQvW+gGfYcLSaa3nFZzFQoC5+Ljnv2h1n2phwmmvNY7BrTExfOMM6wYBBug/
	CEcTRhxwPoeOjpi4FPmH/fDkD7KGYVnvEwQ==
X-ME-Sender: <xms:Tt2CapXMRrdqUkLUYClECzMGWz7C6_A8JSuSSJczEnq-CYWn6lQsHg>
    <xme:Tt2CaqBxYZMKV3YyzhukbCH2OSBWz-cCHzzrGjyuynRYx5hdylU-XPFPbhGqWCImY
    hw6SzT0-0rOPRj49_5_IZYpzj-lPJn2bXjj1VxLQrLJl4bXkRPTjbzP>
X-ME-Received: <xmr:Tt2Cam23dXjUyNx77-7MMZ_lxv3FAf44uQvC9wprJ7cpr2x2MfiOIMp7_-o>
X-ME-Proxy-Cause: dmFkZTGPke0xlf6uK3/vVuV73Zp1ci4I00XU/mQfuBGFKH1EChMGX2W2K2Ay2xhloeELQD
    YiSpOdYfS3z1XRkLC6OwopMYsiHdQ/yeActqocVNoFvfU/5hj7DZTAbsGqeu/+vlYMOKYe
    MWZ9Q8UiaBU71nzHRAot0umiaedntditcGBLwUem5zhFHFf5OpfS/6n4GvupEXcpjvPGj3
    YS/MsMxbcZPoVQjXb4Y5nmgZiQQTorgVnlVV7XtccWjaPbJxsCJxHuas6xK55NYWz1sLxN
    BrpX30FWPC089z3CGRvQuRihRi+MjBpPadK+XwuOwmXhO/v6SpeTG64SVzAEO1fg3twnP1
    Kff7Ds0jl28z1J7Pw/pA2yU9ggaWKCe8j6+zwfuGFFyZuYj9ej/W7PLO9hSwDLHvIdW6e6
    Mr/XVT8/uY+izsqEvf9nEEzVsCTyF+Mu7ocLv1N8u1P7CBjqyb9zStDL6Ow8OhJrSPvHnZ
    CY4gqFI+3SIrPoHTIQjBKp2kK4SlVy31eGOwFfSooL93C7phrDuEtE6RThgrayhp9q/CEb
    MtROetx8oiqBJOf2mJ2ieygLVtmzuoOpIsCwDXTmS1tO5vJZ8JyienAdNO5QvrPaiK4piA
    hA0YgweTdo/51rf4vottrOb6FRoIjt2cLXIPrFbDaGaLAA1zaoVYm2Nyd23A
X-ME-Proxy: <xmx:Tt2CasUuEtiP84tS7a6-AsE2jEt4pUnaX_etlNhxWeXrpK8Iiw-iZA>
    <xmx:Tt2Cai9U7lLXVYWTLOHt9tMTtMIJQhUW-2RPfF55m9wC3ZiigfrLbQ>
    <xmx:Tt2Cah1N-5Sw1mAJFbviYO3ob6StIInc6Me9s3_0UAv57rrxd4fFhQ>
    <xmx:Tt2CatD1gW3cHx2rVnpjpUMd3hGXJN-wCfU4S8HoIuNJkC5uGGA8kQ>
    <xmx:UN2Can-cWdfMqC3gdMhs9v4sDRqa48mv37iCCpvVjODesicJh_YR0Jdx>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 06:07:10 -0400 (EDT)
Date: Mon, 17 Aug 2026 11:07:08 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	nico.pache@linux.dev, baolin.wang@linux.alibaba.com, baohua@kernel.org, 
	dev.jain@arm.com, hughd@google.com, lance.yang@linux.dev, liam@infradead.org, 
	mhocko@suse.com, rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, 
	surenb@google.com, usama.arif@linux.dev, vbabka@kernel.org, usama.anjum@arm.com, 
	agordeev@linux.ibm.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jannh@google.com, willy@infradead.org, pfalcato@suse.de, 
	rostedt@goodmis.org, mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH 00/57] mm/collapse: rebuild collapse on migration
 primitives
Message-ID: <aoLc38LkU8bLAJ3Q@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <DKQUL7RN5K3W.30VLVVWFPBRXZ@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKQUL7RN5K3W.30VLVVWFPBRXZ@nvidia.com>

On Sun, Aug 16, 2026 at 10:02:53PM -0400, Zi Yan wrote:
> > What that removes from every collapse path:
> >
> >   mmap_write_lock              -> mmap_read
> >   anon_vma_lock_write()        -> nothing: an rmap walk needs the folio
> >                                   locked, and the engine holds that lock
> >                                   from freeze to putback
> >   tlb_remove_table_sync_one()  -> nothing: one ranged flush per round
> >   LRU isolation                -> nothing: sources are inert in place
> 
> I remember we were discussing using migration entry and the issue with
> mmap_write_lock() in the context of in-place THP promotion and the
> conclusion was that because MADV_DONTNEED (maybe MADV_REMOVE or
> MADV_PAGEOUT) works on page table and does not change VMAs,
> mmap_write_lock() is needed to prevent things being changed under
> khugepaged. Anything different in normal khugepaged collapse process, so
> that it is OK to use mmap_read_lock? Let me know if I misremember it.

IIRC that discussion predates Hugh's pte_offset_map() rework -- since
0d940a9b270b the helper takes rcu_read_lock() and fails if the pmd is
none, !present or huge, so mmap_write is no longer what keeps a pte
walker out.  MADV_DONTNEED is still not excluded, and the engine does not
try to: the install re-reads every slot under the ptl and publishes only
if it still holds the migration entry this round put there, leaving a
zapped slot alone and dropping the rmap the frozen source still held.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
