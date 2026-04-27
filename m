Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35A30EF9B;
	Mon, 27 Apr 2026 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777292280; cv=none; b=COPr6W5mXoH+QZEZ8iaQ0CGGlInmP1PxTc5XmYB8EoOLyiRTA6TFOY1bA4ZC01Qic3ErHSwl/3eG3yfDVwLz38LhnKUyIxFxRMGfDjcBIEliyeuzsOncmAdPkHL0Hax7EQrA2TSIzFN4Djis4xe9hmuKT3/Jyj6k0qjQPms8/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777292280; c=relaxed/simple;
	bh=AQ4MxxuG0FLIcClDhsTCj2LB5MBEyzoHu1DSqDFxwmU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hkTu2Hw7hTSXtqfEvnLqR45Wgb0i0/XM4S2YGEnRTMrBguzm3F++RVPq0b+r0mXenY8JolCAlG9y6Lzj49a2KJNdvEUO5PZF9XrSOpUJmzZDV0IZHufFhc0K0vygNvgyPY0DZ/OMsht7Gdjc8u1xwVqsdqOLBK6RKqzDdpHtbG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fiFx94gu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fiFx94gu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB317C2BCB5;
	Mon, 27 Apr 2026 12:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777292279;
	bh=AQ4MxxuG0FLIcClDhsTCj2LB5MBEyzoHu1DSqDFxwmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fiFx94gucSnLNgfPsXQ6PkeKXBxrZAes8+MyPSVTnQtSHgxCxOgepMVd9ezClmOYh
	 661TwppiHatNg981pbUYr7Wx+07vpWIoXk5tf9119+sUPpC1tjtDHhvVEBFjVAwyyM
	 z4FQvDG6nYl4yDFqyAfwe4QfcfJHlUUawc1seo6w=
Date: Mon, 27 Apr 2026 05:17:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel
 <riel@surriel.com>, Harry Yoo <harry@kernel.org>, Jann Horn
 <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett"
 <liam@infradead.org>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] bpf: arena: use page_ref_count() instead of
 page_mapped() in arena_free_pages()
Message-Id: <20260427051758.e1b714a4b567917971920eaa@linux-foundation.org>
In-Reply-To: <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org>
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
	<20260427-page_mapped-v1-2-e89c3592c74c@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 13:43:15 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

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
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  kernel/bpf/arena.c | 2 +-

BPF maintainers will probably want to carry this in the BPF tree. 
That's fine - please go ahead and add it.  I'll carry a duplicate in
mm.git so it compiles.
