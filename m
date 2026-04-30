Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921C1402446
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551001; cv=none; b=Fmz7GNQUctbglwDv9urfdQHFMNczzgspiosdFhrosFdl7q9vZPqQP0lARIIGbVK4Ihs/SmbHWWZkXdYXRiFvN3qCoyewlnBvzMNTl+ZIWW8+wsr0VX9XVWJkLFa+h9V9ZY1NYfWoWy9saPd4vDo0b7fqdfSMxZ547gc35MK04Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551001; c=relaxed/simple;
	bh=tj+gg8pp6MdmiyOh+6dl3NjIPWGm6gpjZAsvRUJFhEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akKDMflpkQq5CyMbP6DAXEUPNPYNqbB+FRlZjgWEStnwiuFUv9c0rJGWO4atq6iZkStsdTBxZONVsjFogDjPxPlZmG1JyXCCYCGmXZYUlzueDHI3RvoMtFmpIvr3Yo0mL367yCykDx4ZQlehte+6QJ+KHDlGMpsuZ0MVu3TVsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=ujrGB/bi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="ujrGB/bi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so6781615e9.0
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1777550997; x=1778155797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BM5KrwxlYL2yWx54/IrxJMUv0ov8gisDWiwFBM3mToc=;
        b=ujrGB/biKMvIU301bI5bggwK9bIbKZvq6gJlEywVIzrNtHbTzLzA+B35VDlzJDCrLi
         vTW3VRXzjpiNdMbbc7pR0JyZZHJYrm+kBogYukSkayecocvbYDJKuq12P+9s7mrckPaD
         UyAQ2mUK8KampyCFDm1VnvttxKhqDp2t509GIe5JliGZL5eLomm3uZ6Z+Y9BkqNtH73/
         +014WbH4uR2kFl2+sFMa+V4lhx9BB/igVcSHQgp4t7Kw+OYa3DPlpq3AlrVkianYJeCC
         KR17xTM++F10SWRljUBqA7zb6C0cnAhhILq/GiMGaYsnl9jQprUSueMZajeFGxzVPtu0
         p+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550997; x=1778155797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BM5KrwxlYL2yWx54/IrxJMUv0ov8gisDWiwFBM3mToc=;
        b=e/Mwx8QKt/QAI3O/F6kY67DeO9H6ig7NFtEcGiAhX9ScGNukeaxm2NSjlUjGCbWB93
         G63kpMQJ7NgWudVe/QOPxJgjxwEXKCmRgeHC+LdjXomxP0MtzoRkNcvaf5FisBI62g9i
         oWm9q5gkHbbUPG0keg8tBux5H2B2yl3J+BHWQcrzvQlPUUfAv1SeD0BU3gULs3Lw7NHe
         l1hCXsKOI5Jy6/xbUMwXZiS13Je2p6HQcVbWubmIzjyaWUqBCwGXiSfaOInc6nv1/8ma
         mZ12i3mIN0STvjvmVXlM/4+UqmO9s0xC3fNvqzCKWxGP/Vtxgv2nsUL2j3pzYko8aoHD
         j0Mw==
X-Forwarded-Encrypted: i=1; AFNElJ+WggCSSl5fDtuFa+cU5HtuSQ8AX//Gr3RtwSwtZvl6U2Z8QpZFJxO5KqNmXG0q7lGSiB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+pizixT9JCfXio3k9GcnNybW0IbyIL/Qy9zy2IPQp9MoErYc
	E9XYhIts9psAzWdpq/lo10yFo/Ih5fcRZIFH5bhq33Tm38bov5AQV5cO2zPs4lt2mRg=
X-Gm-Gg: AeBDieukKEHOmKdIEcx/aqptukoCO6GaVkM9tahgrqU0hDPZQATEwpqjFYg5GIu3YYn
	NituQ7JaB8L6k9KNwdWj6i5AYl9ieqT61NODib2965F7d/9cVZ/Jp6MgNRFazZXn65uqnCzvGVF
	uYPdsp1ZjDsOobM3+pjZj3kaetRRnl4z7nvsFuxmKRYI6ZkPTU+edx2jUjuEXVgNV8ysxoCPzFw
	forpVLPtlTwQVYBkiEZUTYwcP3fAaaihenIPed1eHHN69DmMGHba2rD6VOwCyoQAW9cwQwVRRpw
	H+Nhc02nATBM834+dEwi6wV8DlkW0lGgQbjO6rCitKW20ZZ9PpqwGo5Iomn7Rv/ZYTXpzbaYjzR
	s3GF2nQAkWPcZkBCzyCLUcTxolOmzCaddbuzjp1mkckK+ioAO4D4smRvQ+yg/gVf5znL2IvAymp
	HbyjGS+tEQ8mNwP372rFc0QccwSg==
X-Received: by 2002:a05:600c:5254:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-48a8445f451mr47883195e9.25.1777550996490;
        Thu, 30 Apr 2026 05:09:56 -0700 (PDT)
Received: from localhost ([2620:10d:c092:600::1:2d86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a824f9f0dsm58153455e9.15.2026.04.30.05.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:09:55 -0700 (PDT)
Date: Thu, 30 Apr 2026 08:09:50 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
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
Message-ID: <20260430120950.GA1738@cmpxchg.org>
References: <20260401101634.2868165-1-usama.anjum@arm.com>
 <20260429103326.GA1743@cmpxchg.org>
 <20260429050430.d86f01dbe731edc9fa932add@linux-foundation.org>
 <9834200a-492c-4705-a2b2-e76cc0ba5392@arm.com>
 <4ff3d230-d48d-4a9c-aac8-30a7b80c4775@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ff3d230-d48d-4a9c-aac8-30a7b80c4775@kernel.org>

On Wed, Apr 29, 2026 at 03:04:16PM +0200, David Hildenbrand (Arm) wrote:
> On 4/29/26 14:31, Ryan Roberts wrote:
> > On 29/04/2026 13:04, Andrew Morton wrote:
> >> On Wed, 29 Apr 2026 06:33:26 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> >>
> >>>
> >>> I think we should revert the original patch.
> >>>
> >>> The premise is that we can save some allocator calls by requesting
> >>> higher orders and splitting them up into singles. This is a frivolous
> >>> and short-sighted use of a very coveted and expensive resource.
> > 
> > I'm not sure it's that simple. First off, vmalloc has preferred to allocate high
> > order pages for quite a while, it's just that the patch you're referring to
> > makes it try even harder. So reverting the patch doesn't completely revert the
> > behaviour, it just reduces it.
> > 
> > Performance benefits because those high order pages are mapped appropriately in
> > the page table - i.e. 1G PUD, 2M PMD, (or 64K CONTPTE on arm64). So it's not
> > solely about the number of cycles spent in the allocator; the HW is used more
> > efficiently. vmalloc only splits to order-0 for the benefit of the caller,
> > because there are some places that assume they can access each returned struct page.
> > 
> > And all the order-0 pages of the original high order page are freed at the same
> > time, so it's not like we are destroying the contiguous resource; it remains
> > intact for the next user (well, ignoring that some will be freed to the pcpu
> > list - this series solves that wrinkle). I've heard it argued that this approach
> > is actually _better_ for conserving contiguous blocks because it's keeping the
> > lifetime of all the constituent pages bound together and reducing fragmentation.
> > I've never seen any data though...
> 
> Right, that's what Willy has said: allocating+freeing larger blocks, especially
> for unmovable data, reduces fragmentation as a whole. And that theory makes
> sense for me in the context here.

Do we have data confirming that it works out like that?

I think the missing piece is that as long as we still *do* have small
order requests with mixed lifetimes, they will punch holes and cause
fragmentation. Large requests need to clean them up, which is
expensive. You can of course make the argument that it's really the
small requests that are the source of the cost. And I would agree ;)

But adding higher order requests right now surfaces that cost. We've
seen that everytime in real workloads: THP, the large page cache
requests, and now vmalloc. They all increase compaction rates, cause
failures in higher-order network atomics etc.

I do appreciate it's a chicken and egg problem. But I don't think we
can justify regressions from now until there are no more small(er),
fragmenting requests.

So we should still require some form of amortization story when we add
larger requests. It's not accurate to say that they pay for themselves
right now.

And the small cost reduction in the vmalloc alloc path does not offset
the externalities of consuming contiguity, not by a long shot.
