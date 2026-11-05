Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874233;
	b=TTLdqjJXOcKZm5LeLhW2stzcG8EGlEQOmh3BYgeuWTmKUTuc4IC6ywMbA0BynZW4cLKO
	 nET9vkQIIAWlOhGf38mDRHErqL86iAYaCpIIfKF9N90yqcxn6Y3zhJJU9y6X5T3sr3dJC
	 vyCTKaTkfKKHSRM3h7bvCC730od5sJgViA1z6XlrOCxu44O/ko0lQzNfA2V5gjapLt2uH
	 EnCacCpbi2DhyaDwvxQ0VkmRSSHucyUmBCP3QKxLjtY0ePb4/na3Xk2j/zSTU18fv6pbW
	 mtXDEZe9SSGu8MWjv1MkrIKWz9B6lqhN2H2EzH2JKz6bFRCgN2rgXQOq+sPfXx0OOYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874233;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=iF+E3A4lrYTQexomXs4BQ8l6HqAmssOEMa18CwE0L+c=;
	b=PY5ppJsZRhzKvNgvYHqOb8fbXs0Ogweet0ubzIbhP6kTTTVimWkhnUqRT04fXUa1EWEJ
	 W9a44Io0RmAILQ/aO6rqh+LkNO+Z/R4TrVFpSlmExSUc9kTI4b53pBpE6xqAAYSIoIiNy
	 xIltasH/wzO78vW0ef8CzcSWRfd3zWhRThSfj7ST7CbMkbIXDJ8Xs9da5DJqzo1LoBofT
	 B2qIvNjk+mZZbEchqtZTpNabz/4cPDEmRsRfCFwbmdTjBgh996OA37LIv/TCBPXSp8P1I
	 DHzpF4S/NRX/fRmxkyaF7BsLqrJY9EMoVlhQtUXsVSvwTg1Hj7iZRfavUY8gIZh1gWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbrR9cYL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA454606A31B;
	Thu,  5 Nov 2026 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbrR9cYL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B221F00919;
	Thu,  5 Nov 2026 10:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874232;
	bh=iF+E3A4lrYTQexomXs4BQ8l6HqAmssOEMa18CwE0L+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NbrR9cYLZhNHNpuDXvfPn4BsboYHzSp7gAlLtvj5WDDUdGPrsoxzVo27FDAU1Kstv
	 jsbVLoX8hc7ZnvctVffNI8bZIiEpgNqujSQknPFncZPbV/h8pmUuKi8aCfULwX6J6y
	 NGFZMnr+P5VIMf078k3sa1mT17JuiFg7c/AVxeg3bJyBt2BGE4BW35N2f73065VeAc
	 ndogGL2WjONv92vt8T7F4zyf0xhw2M/Zp266ns4P2ZIFKTKHq1pJYJ0XA0VoHYQUD3
	 YmUWAE9qU+8F7uvo2FFyvasZ4KYNXyMPkF6uNZ/Kc/hMd3hlTB2FzWhFYESx+LiuCe
	 oma2cgh+v5YMQ==
Message-ID: <dfa01a1d-0b95-4cd2-ab8a-390da5ffe2ab@kernel.org>
Date: Thu, 5 Nov 2026 11:23:41 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/khugepaged: scan mm's more efficiently under
 mmap_lock contention
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Waiman Long <longman@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
 <20261103-khugepaged-latency-fix-v1-2-a07ab16ac860@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261103-khugepaged-latency-fix-v1-2-a07ab16ac860@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 09:27, Lorenzo Stoakes (ARM) wrote:
> Ostensibly khugepaged collapse traverses eligible mm's, scanning up to

"Ostensibly", now I need a dictionary to read commit messages :P

> /sys/kernel/mm/transparent_hugepage/khugepaged/pages_to_scan eligible pages
> at a time, sleeping for /sys/.../scan_sleep_millisecs between each
> traversal.
> 
> mm's are scanned in collapse_scan_mm_slot() under the mmap read lock,
> obtained using mmap_read_trylock(), skipping the mm if there is lock
> contention, and dropping the lock before allocation.
> 
> khugepaged will keep scanning the same mm until it is about to be torn
> down, prctl(PR_SET_THP_DISABLE) disables THP for it, mm->mmap_lock
> contention occurs, or all its VMAs have been scanned.
> 
> When any of these occur, khugepaged doesn't keep track of where it left
> off, as the current address is tracked in
> khugepaged_scan.address (essentially a global value), which is reset.
> 
> This is a problem when lock contention occurs, as when the mm is next
> scanned, it starts from address 0 again.
> 
> If there's a lot of mmap_lock contention this can significantly slow down
> collapse later in the mm, since the /sys/.../pages_to_scan budget can run
> out before the end of the mm is reached.
> 
> The budget is incremented (as tracked in cc->progress) at a rate of 1 page
> per ineligible VMA, but the budget is only checked once eligible VMAs are
> encountered.
> 
> Then, it only takes the combined total of ineligible VMAs and eligible but
> non-collapsible pages to exceed the /sys/.../pages_to_scan budget for the
> rest of the mm to be skipped.
> 
> For a system with 4 KiB page size and default sysctl settings this only
> requires 4096 ineligible VMAs/uncollapsible pages to be skipped before this
> happens.
> 
> Examples of eligible but uncollapsible ranges are those containing a large
> number of forked PTE entries (more than /sys/.../max_ptes_shared), swapped
> out PTE entries (more than /sys/.../max_ptes_swap) or none or zero-page PTE
> entries (more than /sys/.../max_ptes_none).
> 
> The latter might seem unlikely to happen given /sys/.../max_ptes_none
> defaults to HPAGE_PMD_NR - 1 and CONFIG_PT_RECLAIM frees PTE page tables,
> however CONFIG_PT_RECLAIM only removes the page table if the zapped range
> spans at least a PMD size (see pte_table_reclaim_possible()).
> 
> Thus, userland software that applies madvise(..., MADV_DONTNEED) across
> sub-PMD ranges can thwart this, which is quite feasible for memory
> allocators and GC heaps, for instance.
> 
> Resolve the issue by simply tracking the last examined address in the
> khugepaged_mm_slot object, so when the mm is resumed, the scan starts from
> where it left off.
> 
> Additionally, skip to the next candidate if a VMA cannot be collapsed.
> 
> This issue was noticed during some work in which an mm was instantiated
> with a large number of small VMAs under significant mmap_lock contention,
> during which collapse was observed to take 10.8s. With this patch applied
> it took 3.6s to collapse the same mm.
> 
> Also, while here, update a couple VM_BUG_ON()'s to VM_WARN_ON_ONCE()'s.
> 
> This patch is also a pre-requisite for a later patch in this series.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/khugepaged.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index aad8797f8d5a..216c4b8d28c4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -69,23 +69,23 @@ static struct kmem_cache *mm_slot_cache __ro_after_init;
>  /**
>   * struct khugepaged_mm_slot - khugepaged information per mm that is being scanned
>   * @slot: hash lookup from mm to mm_slot
> + * @address: the next address inside that to be scanned
>   */
>  struct khugepaged_mm_slot {
>  	struct mm_slot slot;
> +	unsigned long address;
>  };

I could have sworn I saw a similar patch from Nico at some point ... maybe it
was in a private discussion.


Am I correct or is the short version of this change "Remember the next scan
address per MM instead of starting from address 0 whenever we continue scanning
a MM after a skip; and we might skip under mmap lock contention" ?

I think a lot of the commit message above can be simplified.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
