Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A643B3C14;
	Mon, 17 Aug 2026 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953890; cv=none; b=kyJIn+k/AD+eoYR5uSuiAqEMJj6vszUUuHIiODi4TNB/mZcTcqL+5SrSEQdWm4lMK0kUDPGJIPoAIufpNiLQ5QIBa0kccLV/XY/d006ZEhLhC8FjSKyMdq1G1iND9qJi5Su1Xq0EfdPqyhzmuQmsubf1qEjEH8LIGnJ/hzSfPgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953890; c=relaxed/simple;
	bh=vysRNSYSTwolpYgu/f2kDU3j2KSjD484zo5IVWXfZIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdNkR0pQpWAQ2th3RzQwB3EImj7c30kdGkNVwdSC9UcvhFeMQSQpDma67Bt1JdLNiI01rGI8DhqnR5byxgQetilPa4Kb4qdjutG/CxoRj3O3asq8Mq1uUe7kjbdom3EoA7R3zfJPmpJI4YeyTjjLXeab/5J4OE2JlXLytbGn04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlsg3MZQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlsg3MZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE351F000E9;
	Mon, 17 Aug 2026 08:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786953886;
	bh=/8YEgw0OcGhLggCgZu0df/8CubxvmgeZk0MDZaoHme4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jlsg3MZQb936uD7sRHVGzRJsM4FPP06SzC3LJGqDw3Ziw3v0yU1MFVOvQeRHx3m8o
	 2tS/8PUESGgMjjAPH43sdrcpv3blq0zwFE7Y9/Jwus9K5nh2OSeLV4CUWEWbjXRLLY
	 uzLKcaBO52LJeRgop+GD7611SUufWlz9v8BtmwWELgHKrQ3CopYlUrafbxLptgRsXS
	 ZcxocQSRRySex3jfHuDZLY/ig8HI2qtgXuVA2LIrKB17xKtWo08XOMKjeNz+eKD84x
	 m+qvoZlHD469WMQh3awtCO952TARRFzZDrvSk2C/1IZ4CGLsOtVxFr5sbaGd4V851Y
	 g9g+uW3thmbhQ==
Date: Mon, 17 Aug 2026 09:04:24 +0100
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
Subject: Re: [RFC PATCH 57/57] MAINTAINERS: add an entry for collapse
Message-ID: <aoLASuFkQ3rUrWa0@lucifer>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-58-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816224609.308019-58-kirill@shutemov.name>

On Sun, Aug 16, 2026 at 11:46:09PM +0100, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
> Collapse is now its own body of code: mm/collapse.c, a header stating what
> it offers a caller, and its own tracepoint family.  It has two callers,
> the khugepaged daemon and MADV_COLLAPSE, rather than living inside one of
> them.
>
> Add a section for it, and move what belongs to it out of the THP entry:
> khugepaged.c and its header, the trace header, the selftests, and
> mm_slot.h.
>
> The selftests are matched as khugepaged*.c, which also covers the race and
> sync-check harnesses the THP entry did not list.  mm_slot.h stays listed
> under KSM as well, which is the other user of it.
>
> Assisted-by: Claude-Code:claude-opus-5
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  MAINTAINERS | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c179b333e4e..4e4e5030b979 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16955,6 +16955,20 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>  F:	include/linux/balloon.h
>  F:	mm/balloon.c
>
> +MEMORY MANAGEMENT - COLLAPSE
> +M:	Kiryl Shutsemau <kas@kernel.org>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +W:	http://www.linux-mm.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	include/linux/khugepaged.h
> +F:	include/trace/events/collapse.h
> +F:	mm/collapse.c
> +F:	mm/collapse.h
> +F:	mm/khugepaged.c
> +F:	mm/mm_slot.h
> +F:	tools/testing/selftests/mm/khugepaged*.c
> +

I'll look through the series properly, but presumably this is a separation of
the THP collapse logic, and therefore should have the same maintainers/reviewers
as the rest of THP.

>  MEMORY MANAGEMENT - CORE
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	David Hildenbrand <david@kernel.org>
> @@ -17272,12 +17286,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>  F:	Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage
>  F:	Documentation/admin-guide/mm/transhuge.rst
>  F:	include/linux/huge_mm.h
> -F:	include/linux/khugepaged.h
> -F:	include/trace/events/collapse.h
>  F:	mm/huge_memory.c
> -F:	mm/khugepaged.c
> -F:	mm/mm_slot.h
> -F:	tools/testing/selftests/mm/khugepaged.c
>  F:	tools/testing/selftests/mm/split_huge_page_test.c
>  F:	tools/testing/selftests/mm/transhuge-stress.c
>
> --
> 2.54.0
>

--
Cheers, Lorenzo
