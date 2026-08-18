Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2CE3E51C6;
	Tue, 18 Aug 2026 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050279; cv=none; b=c3zX23CA2AbmS3vHjUMwXukVIUZ5KV4p5GZJr4CBJEMllNZMG/4PnADTfZQ2Wzspr5YDA6UZuHmJhewhgheNnIX4BREkFosdhI+1s73uCBIG4pH/Zw4W9N7fOsShRXZ3Wf9p9gaybSWJ7CqJ88zokdstTokYksSy4vvm8BosQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050279; c=relaxed/simple;
	bh=IcyIKaGfjrV8voifjtVWYsV9xL8MgZBQ/mM+wjZyBiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxf+UMmu4Wk6GuymGucMyGR7MEuqcr6jAQeAKt6dVsi9SKHwz6We5kwWsr0mEIoH9/uwWtRZpjeTjyAULDpiKhs/Cd6lSV0wnz5tTUoHqMVTGedw48vhkJADEu97qWFPQwEY/L+bJw+HJr05LKE/1mUHWxZeb7yYUHEOneCz9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU7ibEVD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU7ibEVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2881F000E9;
	Tue, 18 Aug 2026 10:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787050278;
	bh=v/r1q9aoLnp9aEHT/nQ5T+KzdqplXpUML9DRN9EYw2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IU7ibEVDFlaLQyDaxdtw1Xdg2N0NmY3zns0fCrt1pYivktpYFzSGfPIrf4nNS1Uxj
	 pRDOrF5Wx6cPpExqhlrekUj+Yk0kVSx2C11adSZ8cnMXBVWBVJp3QixWTIduhFMvXM
	 QgsvQKgbYdyad5eJFj8jwLE6q4ynkJMF1klnfWiBqNG4NZT/nXzOKZIY2A+bfn6PUJ
	 Trb8q7pWfh6+cDPqV36MZEoh5mcN5a4gIdvtu5GBgljQy4aNnSBjz4W81BRVxLmDYl
	 lQG9WJZ9m2GDsey/X1jtdWlw5KKT8pF3mDouKTTR+75U/nmNHBcMzFYMZb61IqmEBf
	 RiLF5HUPxfVJQ==
Date: Tue, 18 Aug 2026 11:50:55 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, david@kernel.org, nico.pache@linux.dev, 
	baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com, hughd@google.com, 
	lance.yang@linux.dev, liam@infradead.org, mhocko@suse.com, rppt@kernel.org, 
	ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com, usama.arif@linux.dev, 
	vbabka@kernel.org, ziy@nvidia.com, usama.anjum@arm.com, agordeev@linux.ibm.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kas@kernel.org, jannh@google.com, willy@infradead.org, pfalcato@suse.de, 
	rostedt@goodmis.org, mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH 03/57] mm/collapse: add collapse.h for the shared
 collapse state
Message-ID: <aoQ47NMwUddi8h1M@lucifer>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-4-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816224609.308019-4-kirill@shutemov.name>

On Sun, Aug 16, 2026 at 11:45:15PM +0100, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
> Preparation for building the new collapse engine in its own file.  The
> engine and khugepaged.c need to agree on what a collapse result is and
> what state a scan carries.
>
> Move enum scan_result and struct collapse_control into a new
> mm/collapse.h.
>
> No functional change intended.
>
> Assisted-by: Claude-Code:claude-opus-5
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Any change that introduces a new file should in the same change update
MAINTAINERS (in the THP section to which this belongs :)

> ---
>  mm/collapse.h   | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/khugepaged.c | 52 +-----------------------------------------
>  2 files changed, 61 insertions(+), 51 deletions(-)
>  create mode 100644 mm/collapse.h
>
> diff --git a/mm/collapse.h b/mm/collapse.h
> new file mode 100644
> index 000000000000..26dbac7beddd
> --- /dev/null
> +++ b/mm/collapse.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __MM_COLLAPSE_H
> +#define __MM_COLLAPSE_H
> +
> +#include <linux/nodemask.h>
> +#include <linux/pgtable.h>
> +#include <linux/types.h>
> +
> +enum scan_result {
> +	SCAN_FAIL,
> +	SCAN_SUCCEED,
> +	SCAN_NO_PTE_TABLE,
> +	SCAN_PMD_MAPPED,
> +	SCAN_EXCEED_NONE_PTE,
> +	SCAN_EXCEED_SWAP_PTE,
> +	SCAN_EXCEED_SHARED_PTE,
> +	SCAN_PTE_NON_PRESENT,
> +	SCAN_PTE_UFFD,
> +	SCAN_PTE_MAPPED_HUGEPAGE,
> +	SCAN_LACK_REFERENCED_PAGE,
> +	SCAN_PAGE_NULL,
> +	SCAN_SCAN_ABORT,
> +	SCAN_PAGE_COUNT,
> +	SCAN_PAGE_LRU,
> +	SCAN_PAGE_LOCK,
> +	SCAN_PAGE_ANON,
> +	SCAN_PAGE_LAZYFREE,
> +	SCAN_PAGE_COMPOUND,
> +	SCAN_ANY_PROCESS,
> +	SCAN_VMA_NULL,
> +	SCAN_VMA_CHECK,
> +	SCAN_ADDRESS_RANGE,
> +	SCAN_DEL_PAGE_LRU,
> +	SCAN_ALLOC_HUGE_PAGE_FAIL,
> +	SCAN_CGROUP_CHARGE_FAIL,
> +	SCAN_TRUNCATED,
> +	SCAN_PAGE_HAS_PRIVATE,
> +	SCAN_STORE_FAILED,
> +	SCAN_COPY_MC,
> +	SCAN_PAGE_FILLED,
> +	SCAN_PAGE_DIRTY_OR_WRITEBACK,
> +};
> +
> +struct collapse_control {
> +	bool is_khugepaged;
> +
> +	/* Num pages scanned per node */
> +	u32 node_load[MAX_NUMNODES];
> +
> +	/* Num pages scanned (see khugepaged_pages_to_scan) */
> +	unsigned int progress;
> +
> +	/* nodemask for allocation fallback */
> +	nodemask_t alloc_nmask;
> +
> +	/* Each bit represents a single occupied (!none/zero) page. */
> +	DECLARE_BITMAP(mthp_present_ptes, MAX_PTRS_PER_PTE);
> +};
> +
> +#endif	/* __MM_COLLAPSE_H */
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5f7126cf42f5..804b1d35f52a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -26,45 +26,11 @@
>  #include <linux/cleanup.h>
>
>  #include <asm/tlb.h>
> +#include "collapse.h"
>  #include "internal.h"
>  #include "page_alloc.h"
>  #include "mm_slot.h"
>
> -enum scan_result {
> -	SCAN_FAIL,
> -	SCAN_SUCCEED,
> -	SCAN_NO_PTE_TABLE,
> -	SCAN_PMD_MAPPED,
> -	SCAN_EXCEED_NONE_PTE,
> -	SCAN_EXCEED_SWAP_PTE,
> -	SCAN_EXCEED_SHARED_PTE,
> -	SCAN_PTE_NON_PRESENT,
> -	SCAN_PTE_UFFD,
> -	SCAN_PTE_MAPPED_HUGEPAGE,
> -	SCAN_LACK_REFERENCED_PAGE,
> -	SCAN_PAGE_NULL,
> -	SCAN_SCAN_ABORT,
> -	SCAN_PAGE_COUNT,
> -	SCAN_PAGE_LRU,
> -	SCAN_PAGE_LOCK,
> -	SCAN_PAGE_ANON,
> -	SCAN_PAGE_LAZYFREE,
> -	SCAN_PAGE_COMPOUND,
> -	SCAN_ANY_PROCESS,
> -	SCAN_VMA_NULL,
> -	SCAN_VMA_CHECK,
> -	SCAN_ADDRESS_RANGE,
> -	SCAN_DEL_PAGE_LRU,
> -	SCAN_ALLOC_HUGE_PAGE_FAIL,
> -	SCAN_CGROUP_CHARGE_FAIL,
> -	SCAN_TRUNCATED,
> -	SCAN_PAGE_HAS_PRIVATE,
> -	SCAN_STORE_FAILED,
> -	SCAN_COPY_MC,
> -	SCAN_PAGE_FILLED,
> -	SCAN_PAGE_DIRTY_OR_WRITEBACK,
> -};
> -
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/huge_memory.h>
>
> @@ -103,22 +69,6 @@ static struct kmem_cache *mm_slot_cache __ro_after_init;
>
>  #define KHUGEPAGED_MIN_MTHP_ORDER	2
>
> -struct collapse_control {
> -	bool is_khugepaged;
> -
> -	/* Num pages scanned per node */
> -	u32 node_load[MAX_NUMNODES];
> -
> -	/* Num pages scanned (see khugepaged_pages_to_scan) */
> -	unsigned int progress;
> -
> -	/* nodemask for allocation fallback */
> -	nodemask_t alloc_nmask;
> -
> -	/* Each bit represents a single occupied (!none/zero) page. */
> -	DECLARE_BITMAP(mthp_present_ptes, MAX_PTRS_PER_PTE);
> -};
> -
>  /**
>   * struct khugepaged_scan - cursor for scanning
>   * @mm_head: the head of the mm list to scan
> --
> 2.54.0
>

--
Cheers, Lorenzo
