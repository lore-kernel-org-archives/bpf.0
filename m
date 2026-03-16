Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8670335064;
	Mon, 16 Mar 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677987; cv=none; b=iUTzdLFGcrojz2jS4lxu3t57nvZiaBsRtc7ON76GrVXxWxageW0N3gFIfGuo+QBiSbhhsO4mLkPPAbkAI8fUtE7EaZE45hlVEt9y9EbdWh1msQEzFxhAy6dVwdnvd3J6hnS2NRNOH6VOxpfxGu57bdwlDU0dRYA+Ryu+hBe7n2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677987; c=relaxed/simple;
	bh=OkmtNnOzPdtE0Ofj3xzJwcmVrMrtLWm1U83jw7E9K38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVQdeKfjFk7/J1amgsliqVpdW68z/kyV0tBXZBwMM/3ze+m5/i3nyW4zQy4MIgpA0LPmdOPULJN+DlUKqaQdHtKGQd1CM9v+ozESXgXWsUgcZfQTZlnXv9b1G0HIzLB8Nh6EZtrFNYz6RcL9tLjJEWNkJtxpAP6ksEHZkngntGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSIiU+fH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSIiU+fH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D161EC19421;
	Mon, 16 Mar 2026 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773677987;
	bh=OkmtNnOzPdtE0Ofj3xzJwcmVrMrtLWm1U83jw7E9K38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DSIiU+fHtk9ZRbCLUJJUI2Bm4P5vlwaJpKFoGdeqORxHC8c9BF2qOm6gaRjD4iM3W
	 LKQwIcPuE74LmLJT457pm4ISCpjmnXJa8pPZjaFI7Z0vH3ZdMsfkJJNTNtaOGuCiIv
	 LWQsO5qRx3M3/+/cAkkJ6Zy7aC0IdGJqtPLHwLFNA7Lp2r5ahsVYX4Wx7qMqPD9uYm
	 cGSfg3AVPkgq+nylubvLjz5fJK8NIvaQ1L+pKn80iyW4Mpu9fiKdHC0QCtPkAaw0yZ
	 QO+I5ieXpSmqGAvm0+M0js2JkYAisR4iRxxK75TMqCC9mGmw1Gbnj5Tf5mD7u5Pusl
	 zmhru03M4EY3Q==
Message-ID: <fde63978-d632-4196-b032-4cc20041fd90@kernel.org>
Date: Mon, 16 Mar 2026 17:19:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/page_alloc: Optimize free_contig_range()
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, Muhammad Usama Anjum <usama.anjum@arm.com>,
 Ryan.Roberts@arm.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
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
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <703BB8CD-23D9-4012-8333-366837D7E95A@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 17:02, Zi Yan wrote:
> On 16 Mar 2026, at 11:21, Vlastimil Babka wrote:
> 
>>> +/*
>>> + * free_pages_prepare() has already been called for page(s) being freed.
>>> + * TODO: Perform per-subpage free_pages_prepare() checks for order > 0 pages
>>> + * (HWPoison, PageNetpp, bad free page).
>>> + */
>>
>> I'm confused, and reading the v1 thread didn't help either. Where would the
>> subpages to check come from? AFAICS we start from order-0 pages always.
>> __free_contig_range calls free_pages_prepare on every page with order 0
>> unconditionally, so we check every page as an order-0 page. If we then free
>> the bunch of individually checked pages as a high-order page, there's no
>> reason to check those subpages again, no? Am I missing something?
> 
> There are two kinds of order > 0 pages, compound and not compound.
> free_pages_prepare() checks all tail pages of a compound order > 0 pages too.
> For non compound ones, free_pages_prepare() only has free_page_is_bad()
> check on tail ones.
> 
> So my guess is that the TODO is to check all subpages on a non compound
> order > 0 one in the same manner. This is based on the assumption that

OK but:

1) Why put that TODO specifically on FPI_PREPARED definition, which is for
the case we skip the prepare/check?
2) Why add it in this series which AFAICS doesn't handle non-compound
order>0 anywhere.
3) We'd better work on eliminating the non-compound order>0 usages
altogether, rather than work on support them better.

> all non compound order > 0 page users use split_page() after the allocation,
> treat each page individually, and free them back altogether. But I am not
> sure if this is true for all users allocating non compound order > 0 pages.

Maybe as part of the elimination (point 3 above) we should combine the
allocation+split so it's never the first without the second anymore.

> And free_pages_prepare_bulk() might be a better name for such functions.
> 
> The above confusion is also a reason I asked Ryan to try adding a unsplit_page()
> function to fuse back non compound order > 0 pages and free the fused one
> as we are currently doing. But that looks like a pain to implment. Maybe an

Yeah not sure it's worth it either.

> alternative to this FPI_PREPARED is to add FPI_FREE_BULK and loop through all
> subpages if FPI_FREE_BULK is set with
> __free_pages_prepare(page + i, 0, fpi_flags & ~FPI_FREE_BULK) in
> __free_pages_ok().

Hmm, maybe...

> 
> Best Regards,
> Yan, Zi

