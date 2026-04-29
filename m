Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A661537F746;
	Wed, 29 Apr 2026 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777464271; cv=none; b=DtG3pto73cN9WluKMSFxsl2KSEZet2Z5n0MGeAPIqccxA8L24AZecBO7Eyg02sXeciqbNpx6e0qtHoV2/kfCPT6VU+bfflGIlMJfquGTisaX7H8GpumYGHbeAvrOr5m/afG6dUnQfdgzq+N41gOR4Nlb88OzF9qzxLduyudnQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777464271; c=relaxed/simple;
	bh=IFAJiEknzlPW2ICs1yOFKVmjs8x4lk0T6++/h57So3A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ob2upJYGWdjRmLFKp5oVDZbAIkXmZA/Ea1fqUEFIAqsVtz/sUFR5aQbK5JXVXCgIQ+K4ENH06Piyc4OlyL8x1iBTKsDDc5fXSxx/Saxw2/UHNvvpoHldDo9ctvpzE8ZjOpbFGi+8IUJSEF0pn5Jtk2xFELElAOCZluRd+Od5CU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=p91l+b9K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="p91l+b9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF49C19425;
	Wed, 29 Apr 2026 12:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777464271;
	bh=IFAJiEknzlPW2ICs1yOFKVmjs8x4lk0T6++/h57So3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p91l+b9KXgYp+Fpi6U9aqoSTXGyLkwjQj5O0IWHaunxWDbsyPe4UIGd3MhQITqXve
	 mMVkpv5deeKDCdo1AcrYwtt4HN8fwUttVKMprhzGq97Xl2sH4gsaAQtDh/h4u7dzyn
	 Uu6KEeZltN5dUHPSEfLPCV/FoI+Ley1LWMlkJa3E=
Date: Wed, 29 Apr 2026 05:04:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, Zi Yan
 <ziy@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>, Nick Terrell
 <terrelln@fb.com>, David Sterba <dsterba@suse.com>, Vishal Moola
 <vishal.moola@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v6 0/3] mm: Free contiguous order-0 pages efficiently
Message-Id: <20260429050430.d86f01dbe731edc9fa932add@linux-foundation.org>
In-Reply-To: <20260429103326.GA1743@cmpxchg.org>
References: <20260401101634.2868165-1-usama.anjum@arm.com>
	<20260429103326.GA1743@cmpxchg.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 06:33:26 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Wed, Apr 01, 2026 at 11:16:18AM +0100, Muhammad Usama Anjum wrote:
> > Hi All,
> > 
> > A recent change to vmalloc caused some performance benchmark regressions (see
> > [1]). I'm attempting to fix that (and at the same time significantly improve
> > beyond the baseline) by freeing a contiguous set of order-0 pages as a batch.
> 
> I think we should revert the original patch.
> 
> The premise is that we can save some allocator calls by requesting
> higher orders and splitting them up into singles. This is a frivolous
> and short-sighted use of a very coveted and expensive resource.
> 
> The buddy allocator tries hard to retain contiguity *if it isn't
> needed by the caller*. This patch actively works around that.
> 
> The cost of recreating those higher orders elsewhere is shouldered by
> whoever actually needs the contiguity down the line. And that process
> is orders of magnitudes more expensive than we save here:
> 
> We're saving cycles per page in the vmalloc path, and later spend tens
> of thousands of cycles per page to recreate the contiguity. Scanning
> PFN ranges, folio locks, rmap walks, TLB flushes, page copies.
> 
> That's a terrible trade-off.

That's persuasive.

afaict much/all of this series remains useful after a06157804399
("mm/vmalloc: request large order pages from buddy allocator") is
reverted?

What I'm not understanding is how significant all of this is.  Sure,
making many-page vmallocs faster is both beneficial and harmful.  And we
have super-focused microbenchmarks which demonstrate both effects.  But
how often does the kernel actually *do* this stuff in real-world (or
even real-world corner-case) situations?
