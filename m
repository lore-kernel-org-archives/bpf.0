Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759C1FE44A;
	Mon, 27 Apr 2026 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295551; cv=none; b=HLKnSWvIDQXzejiac9V/jgipjYoW7wNNGtEexlb+HRvdpe00IRIcVGYEQytXj2Mptd17eEi1WsnxalbUbFbFROaKZHtXHAq5HfcrWeEMEfBEWGk8GYRFmJp7P02LFvmc8Ucdv+PyDloLMy68Js6dDvD9FCDS62er/B8GAwQIKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295551; c=relaxed/simple;
	bh=7Rgm5+2Y6p9vdGk7TFYbXRWb0zShgw8fhtPh+xYWGsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3uusTkc0y+4T1Ek1ziHMTv8qJNEY/cjXA7mCu6CLfMbQvxATmOIwhoIuIGawAKVdWQ+dqDY5eg83kRAMXbsrNeYBwa6N6VdL1MJJ7AjqFC9iVZ09WhF3peMk4yeMU8umqjn9iRyAhhj2TEL173LceiAZK+5ulN7CCfrgHkJsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HqkYlS8R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HqkYlS8R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=79uM2Zdks7gEgsRotpWu+/1rf8zg45ohibw7xbEt1AU=; b=HqkYlS8RO8wHIK9MBGbTtiUrlD
	EOWiP9QV/zxAAwwytmnW21ZAZja+yrHTT6V9KAokVDmJEMYHLyY5wvzDthtWo4vCaJ0EhNr23Ce1P
	KaRFfhqSBegTIxQYgsx1U9zjnpTL9W1Z0fN5k870hAXSqIZgY5ifzGveiQyKUwcLtOBtbkuPjXBm0
	MmmxKMr1OG05FSgTvY1+qek7+N2IhQiMnKODOtwbS2K2HJ1kC1w3aVNaUyGFjp5C8SopqCeHF+3TT
	nYPNv8PpvWRYiEPmaxsylHfFYLVwOl3YtKqCDEu/jx2pvV5DqOsP3Zig2nWy3c3P19RGfR1KYho46
	2nV0i8nQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHLl4-0000000270I-3FhZ;
	Mon, 27 Apr 2026 13:12:18 +0000
Date: Mon, 27 Apr 2026 14:12:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <liam@infradead.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm: remove page_mapped()
Message-ID: <ae9gsjJolKTLeoZR@casper.infradead.org>
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
 <20260427-page_mapped-v1-3-e89c3592c74c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-page_mapped-v1-3-e89c3592c74c@kernel.org>

On Mon, Apr 27, 2026 at 01:43:16PM +0200, David Hildenbrand (Arm) wrote:
> Let's replace the last user of page_mapped() by folio_mapped() so we
> can get rid of page_mapped().

Yay!

> Replace the remaining occurrences of page_mapped() in rmap documentation
> by folio_mapped().

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> +++ b/mm/memory.c
> @@ -5464,7 +5464,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>  	if (unlikely(PageHWPoison(vmf->page))) {
>  		vm_fault_t poisonret = VM_FAULT_HWPOISON;
>  		if (ret & VM_FAULT_LOCKED) {
> -			if (page_mapped(vmf->page))
> +			if (folio_mapped(folio))
>  				unmap_mapping_folio(folio);

The idiot who authored 01d1e0e6b7d9 really should have done this at the
time ... Oh, wait, I see what I was trying to do.

I believe my thinking was that we only needed to unmap the folio if
this specific page that had hardware poison was mapped.  But no, we need
to unmap the entire folio if any page in it is mapped.

Does the affect recoverability from hwpoison?  I don't think so.  When
we detect hwpoison, the first thing we try to do is split the folio.
Of course that can fail, but if we do, we kill the process.

So yes, my R-b above stands.
