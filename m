Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2CF37187F;
	Fri, 20 Mar 2026 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994840; cv=none; b=DLAVzim1LEQFkgSXca1H35rZ4Cv2UtKm7MAz6FqczqtRiERhcVA2uE2BEqw48Op00e+SxlxtV/FnN0VwPZxaALHrwwxz8jn36iA4WoV3RW1nMmBN1DgLgc65Ixm1nZS3yPihnKcgR/SKqcQ+msLnHKfn33pWFU3hEdSCB7J7diY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994840; c=relaxed/simple;
	bh=xmN3vJPx4psTV4lUdM11H+sjGA+/qbfQGglSkhWCFXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMz9cBhYcjZUb8oMZmNwrrIpfB6ifSgHeJUsSaliN8MsMWtrOxCKRW2maEGYZNlFObBny4o17ry66DlOX2J8+jrqJz1kXJvXU20lappEYGkHxlCMODqmg/135NmKY9emXkB0W6S4i2rglmF9bBrhAva53wcbtIFHSWmY9s6JBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVVKrriJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVVKrriJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED99BC4CEF7;
	Fri, 20 Mar 2026 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773994839;
	bh=xmN3vJPx4psTV4lUdM11H+sjGA+/qbfQGglSkhWCFXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sVVKrriJ9G+ROdnhpqVTsRBG75244B0r8i51tEG/l/pJlDysqNkAqU7LjLcKf2byT
	 aYDHzFWdLLrPR3jbjHZH3WAHmAJRNLmYkD9ZUyYrLJztAEO8F/RDEBYNaE2xMty5rl
	 7J/FWkIPGaEpVL6Oh5/j6z7hs+7CHE7V6qYbM6sbkBIT9gwe88tN9DYXocjnDAXA5e
	 GVrExLH/HTgA5CvBh55NuxeDCbA226p16BzUHP6UdYhQ5NGe/mpNJ1XisI5aQyA93M
	 fWg/hh6sUyYnmRpcsxEWjcxWgaN1wvdFHASnNqpl5Vav3x4POTU9HjShh6yz1DGYJj
	 bZOQlqsEU4i5A==
Message-ID: <8cf1b799-c02c-466d-9212-0e12a99bfd8b@kernel.org>
Date: Fri, 20 Mar 2026 09:20:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/page_alloc: Optimize free_contig_range()
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>, Ryan.Roberts@arm.com,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Uladzislau Rezki <urezki@gmail.com>,
 Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, david.hildenbrand@arm.com
References: <20260316113209.945853-1-usama.anjum@arm.com>
 <20260316113209.945853-2-usama.anjum@arm.com>
 <220e97f0-dc82-4f37-b833-7160aee46cea@suse.cz>
 <703BB8CD-23D9-4012-8333-366837D7E95A@nvidia.com>
 <fde63978-d632-4196-b032-4cc20041fd90@kernel.org>
 <2AE5B748-C57B-4BC1-BF9E-6299CCBF295B@nvidia.com>
 <3883abcd-426d-4211-ae76-b5601ee728de@kernel.org>
 <54364b65-ffeb-4d91-918a-c1e4b0c92816@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <54364b65-ffeb-4d91-918a-c1e4b0c92816@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/26 23:07, David Hildenbrand (Arm) wrote:
>>> the allocation of non-compound order>0, like you suggested in 3, we basically
>> 
>> I suggested we'd take it away in the sense of not producing order>0 where
>> head is refcounted, tails are not, and it's not a compound page. I'd rather
>> have an API that applies split_page() before and returns it as order-0
>> refcounted pages, but not the intermediate order>0 non-compound anymore.
> 
> Are you talking about external API or internal API?

In this case of alloc+split, external, and that would make sense to me.

In case of freeing, the current free_pages(order>0) is also external and I
would prefer not to augment it for this free_contig_range() usecase.

> Regarding external interface: I think the crucial part is that an
> external interface (free_contig_range) should always get a range of
> individual order-0 pages: neither compound nor non-compound order > 0.

Ack.

> The individual order-0 pages can either be frozen or refcounted
> (depending on the interface).

Ack.

> Regarding internal interface: To me that implies that FPI_PREPARED will
> never ever have to do any kind of "subpage" (page) free_pages_prepare()
> checks. It must already have been performed on all order-0 pages.
> 
> So the TODO should indeed be dropped.

Agreed. But maybe I misunderstood Zi, so that's why I tried to add so much
detail about what I mean by what.

> I'm not sure I understood whether you think using the
> __free_frozen_pages() with order > 0 is okay, or whether we need a
> different (internal) interface.

I think this is fine. But I agree with you above that this assumes
FPI_PREPARED and will not have to deal with subpages.
