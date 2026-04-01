Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9F371057;
	Wed,  1 Apr 2026 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038368; cv=none; b=jWoD/UintEzw+vdV/jow7OCxwGyDG1lxX7TEn5AMP/M7qmKXjtkRq2ityOkGkw+LOrIrxGCWX1Rjo9d9Z9GCVHJWo7Uv9qjioauh43c5A9Osk19aG7qzI+AFifxIdIROahoeCICagVcnBkNSwNruQkz/1T9fO3vdN62peGJSeTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038368; c=relaxed/simple;
	bh=3kIhoicvnvPNpK62DGxhaQUxpRFDPvITbIvEfhgwgNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T9CiIyGoQ8wWOunfE2VUfrQA0uyQ7nTkBiP7zhbkuw9LToKzSOGinrZxV5ytNwIc4pKsrYnBJhliK1KK5r5tcfC0hHAP8zF264flu1lvGlrZbI9AYfEiryrDp+THidiZ27vgXEjJH4ogj+lQO/2jGEgy8gr8LlzSmMP+l+0F6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCXYVFld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCXYVFld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F0EC4CEF7;
	Wed,  1 Apr 2026 10:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775038367;
	bh=3kIhoicvnvPNpK62DGxhaQUxpRFDPvITbIvEfhgwgNs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=OCXYVFldXEYiEAxJXFmtpXA0NEPxJzrGmpN0jD5zvFU6Rmn9UA8J11scE1RMDpvZw
	 QNSbZA4/ml5LU+x3ITrz2d905VM8/2fC6jyFvrOG8AUaOysxOwJG/xeAL9eBP+MJYV
	 iDDWBdXBRv1naQF0C3ukUtZrfKNitgbvQ43iFgk8MZNueVT3ehZHRrej4U2LBnuD61
	 mtNMiClIn74kFJiDpZ5ZiULEPttAybC/iqog8YM9Rnp2MzDK/kYaPqOnaMYhRJPOVj
	 +Ox2NsvoK9jLyW8yNF0W2/jCzQyfdOeo2Pg3MAKbOFyEWCP4SsqUHNpl3yaKTY/oeL
	 dQHKcU4jfF6qw==
Message-ID: <9fa011dd-156d-4e92-bc27-340ee85ed904@kernel.org>
Date: Wed, 1 Apr 2026 12:12:41 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] mm/page_alloc: Optimize free_contig_range()
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>, Vishal Moola <vishal.moola@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Ryan.Roberts@arm.com, david.hildenbrand@arm.com
References: <20260331152208.975266-1-usama.anjum@arm.com>
 <20260331152208.975266-2-usama.anjum@arm.com>
 <f61e0fa6-a716-405f-bce9-a2bf4ef0c045@kernel.org>
 <6494c9d9-9598-437a-bc50-54a4b6401a3d@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <6494c9d9-9598-437a-bc50-54a4b6401a3d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/26 11:59, David Hildenbrand (Arm) wrote:
>>> +
>>> +	for (i = 0; i < nr_pages; i++) {
>>> +		bool can_free = true;
>>> +
>>> +		/*
>>> +		 * Contiguous PFNs might not have contiguous "struct pages"
>>> +		 * in some kernel configs: page++ across a section boundary
>>> +		 * is undefined. Use pfn_to_page() for each PFN.
>>> +		 */
>>> +		page = pfn_to_page(pfn + i);
>> 
>> Hm ideally we'd have some pfn+page iterator thingy that would just do a
>> page++ on configs where it's contiguous and this more expensive operation
>> otherwise. Wonder why we don't have it yet. But that's for a possible
>> followup, not required now.
> 
> pfn_to_page() is on relevant configs close to just a "page + i". Not
> entirely, but I am not sure if the micro-gain would really be worth it.
> 
> E.g., on CONFIG_SPARSEMEM_VMEMMAP
> 
> #define __pfn_to_page(pfn)	vmemmap + (pfn)

Oh I see. Yeah agree not worth it. The compiler can probably turn it to
page++ already then.

> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 

