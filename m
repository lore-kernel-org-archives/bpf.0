Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628A3B7B9D;
	Mon, 27 Apr 2026 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294850; cv=none; b=qfFdqLRtidNlY0ZGqHomq+929BCpH2DB+Mky9ale/o9y78ndMpflc4/zwMesRS+1fOMFgdtUmxIuAzL44gahqjLZ8lAPZPxSOdwrnCIZZO6c7g0ovNarO2ICCb1lCgwHl92D1Cku4MLtQhcipfKiUQNU7Q6olxAda5iqM/PWh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294850; c=relaxed/simple;
	bh=gW+w1J0q/vOdp5xspzFhPdjxkIqYUplx9IFrkah7vv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2/40Zlm1QyHGhczuaMiTxLEUN8ymkA4nrm+sMT3U4Z7zwy8nbuGXbxbGmiSBJTmfCWVJWgadvXqhB0a4p1g+XFJqcOakZruHnR0LSLzW1J9gG1GR0Oc4TBEb+jxlMygp70s8vNRzyJpMdIOiAEkGKmq880+phZe/U7V99efGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KhresZp9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KhresZp9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3pPbjszTa9FPZHzEBxBvM5QTIp8aOy3rtQ8mmz6pcLE=; b=KhresZp9qVD0MIn2zcL6d93p+u
	YP6E0DDNIPcfHMGbSJQeuyCSK1cj50OfRjVJARZtOM8LmCEUABm8jKVR923RuCzGDTYSBnzn7JByk
	2HUBHnab8NCjgQi+8wTrjmCKIWQGfOqoyzc8ND874Z8uwqSGXy/nKlM1Cdcg/IeQpVHmmpxvDZvr8
	IjJeWL9Z5BEJiGYWJNHnAu31LR6HjEC6evr5wOtENKrU9sKOPiSws7F6cpkIks6ZMYeVp9DusSyeO
	27l2WRHnwk/V110p/IysON5iyNnX6M8KN9wujEeKBVN7/tpdN7RhNiuXYhUEdUu7Bd6Wg9YUs8+WN
	rwLE6f2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHLZi-0000000263n-3frl;
	Mon, 27 Apr 2026 13:00:34 +0000
Date: Mon, 27 Apr 2026 14:00:34 +0100
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
Subject: Re: [PATCH 2/3] bpf: arena: use page_ref_count() instead of
 page_mapped() in arena_free_pages()
Message-ID: <ae9d8rXC-V2OkTcf@casper.infradead.org>
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
 <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org>

On Mon, Apr 27, 2026 at 01:43:15PM +0200, David Hildenbrand (Arm) wrote:
> Pages that BPF arena code maps are allocated through
> bpf_map_alloc_pages(), which does not allocate folios but pages.
> 
> In the future, pages will not have a mapcount, only folios will.
> Converting the code to use folios and rely on folio_mapped() sounds like
> the wrong approach.
> 
> Should BPF arena code allocate folios and use folio_mapped() here? But
> likely we would not want to use folios here longterm, as we don't really
> need folio information.
> 
> Hard to tell. But in the meantime, we can simply use the page refcount
> instead, as a heuristic whether the page might be mapped to user space
> and we would want to try zapping it, so we can get rid of page_mapped().
> 
> Page allocation will give us a page with a refcount of 1. Any user space
> mapping adds a page reference. While there can be references from other
> subsystems (e.g., GUP), in the common case for this test here relying on
> the page count is good enough.

Well, if we GUPped the page, it must have been mapped at some point ;-)

Anyway, I approve of this patch; it lets us defer the hard decisions and
work until we know what we really need.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

