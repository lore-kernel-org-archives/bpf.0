Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89AE37C118;
	Mon, 27 Apr 2026 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301020; cv=none; b=o4ER1KNY8pS8OLp9QZfpD5SnXEskD1o1ln1ORxT5CvJ8qgmZjyeBv03g9fqmpb0T9wum8FR0SiKM2pnhn66EHRCpb/CL+sHgm11hNxt3V7hD6o5feg51HtC2mBwIrqbc9GZb54wP6DIFtaIS5zKFzZyMkj/s9N9KsmAGN4kWKfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301020; c=relaxed/simple;
	bh=IuwvTispTDs332RKsGKh12doad46AZ+T/uImbfUW5hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4fKM79uDxz0jzwb0GaSvZQ9ZVihd2U64H/KURPHekbpPhGH7nxF+6tor2KnERiC/geIDEEUVhYuUw9y30GjPZzSrWzeVyd3NqpNz+Z/QdGJImOAjTQAt+pU9UZk7L6styRNaGh8hO3ztJKgjy3HFjyMbq7CvJppuXDX3+14law=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BLOa/aPa; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="BLOa/aPa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f4zHSFMRCDIOzJvASvG53//nYdaZVKmO6GM9qNfqLSI=; b=BLOa/aPa6STWM/QAkpwF2fJs0q
	0JjOWwgFJWIw6s+11hZ1BJRkwezP6zIglOWogLDCNZz7Qj+rbjP0xEUUpOt7qKQC8nps51h+KmpKc
	aLL7UWtNr4yLW/D1e7ISuAmjj1a5leMJH9bgiDjTVNJICALMGV2OdhZDWGzSFSemoQupQzAsM/KNS
	rGtphBvHvnbEwxDLfIV1d0Tst4GZfA3ecDCE87kaQOvpC9XZoqe62DvymnlyIinez28hlwOxlk28P
	8ssdbmdpsYo9QfLgT6nqWmHpYj/+C0hZagB4IbjhKfI2A4LkXfmdz0vZBv6n+pFpeBQBp6mWDxqgO
	o2UwBOkg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wHNAj-005YIa-39;
	Mon, 27 Apr 2026 14:42:54 +0000
Date: Mon, 27 Apr 2026 07:42:46 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm: remove page_mapped()
Message-ID: <ae91ogo90bSDFNPC@gmail.com>
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
 <20260427-page_mapped-v1-3-e89c3592c74c@kernel.org>
 <20260427062137.48739e6fa6e550f1f0e8ff48@linux-foundation.org>
 <06218a87-8346-40b4-adf4-dc494b5f1293@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06218a87-8346-40b4-adf4-dc494b5f1293@kernel.org>
X-Debian-User: leitao

Hello David,

On Mon, Apr 27, 2026 at 03:23:33PM +0200, David Hildenbrand (Arm) wrote:
> On 4/27/26 15:21, Andrew Morton wrote:
> > On Mon, 27 Apr 2026 13:43:16 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> > 
> >> Let's replace the last user of page_mapped() by folio_mapped() so we
> >> can get rid of page_mapped().
> >>
> >> Replace the remaining occurrences of page_mapped() in rmap documentation
> >> by folio_mapped().
> > 
> > This broke Breno's "mm/memory-failure: add panic option for
> > unrecoverable pages"
> > (https://lore.kernel.org/20260424-ecc_panic-v5-2-a35f4b50425c@debian.org),
> > which added a new page_mapped() call.  I made the below adjustment to
> > Breno's patch:
> > 
> > --- a/mm/memory-failure.c~mm-memory-failure-add-panic-option-for-unrecoverable-pages-fix
> > +++ a/mm/memory-failure.c
> > @@ -1353,7 +1353,7 @@ static bool panic_on_unrecoverable_mf(un
> >  		cpu_relax();
> >  		return page_count(p) == 0 &&
> >  		       !PageLRU(p) &&
> > -		       !page_mapped(p) &&
> > +		       !folio_mapped(page_folio(p)) &&
> >  		       !page_folio(p)->mapping &&
> 
> If we have a folio, we should really lookup the folio once. Not 4 times.

Why 4 times?

> Breno's patch likely needs some love. :)

Would something like the following give it all the love in the world?

 folio = page_folio(p);
 return page_count(p) == 0 &&
        !PageLRU(p) &&
        !folio_mapped(folio) &&
        !folio->mapping &&
        !is_free_buddy_page(p);

Thanks,
--breno
