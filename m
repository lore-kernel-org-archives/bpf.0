Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BE346E55;
	Sun, 19 Jul 2026 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784453020; cv=none; b=RdhbaNTQgKZWHvGls8+oSWGndR0TZhlRlkkyscgeeokBUFz8TPk+7jS8X3InmZVslmLgQIMlYqzeuAK2+akbhM0XwDMylhiNGEnP1n9Px2aHWtqC+Eda2OX1WwGbyEK9ZR8wRTYF2I85cRC6ZdtsR8SHktqQP+NV4ZDvr7+C414=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784453020; c=relaxed/simple;
	bh=aSg1HatHCDKb0cdWU3vBFFvlMfXxykSLrX47B0LC2PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMyVbixcqXRu64X8tGNmJ3dt34G2VUok6UbOsDmoBILZlJl7L5FjHTF+QP74iuIUUOo8O0iuCy+mlpPKFz6xHVt5C8kN1TGn45cJzB0L68DuNf7q+ruvbOqBl1fymBUWWnQotCSsWP4S57Jdx5WkA3FrTvbj0Rqugdpvesv0igM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUHdzov3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUHdzov3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC63A1F000E9;
	Sun, 19 Jul 2026 09:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784453018;
	bh=PuP9EzqwTlsKhoLgtEy3/0hMjKlLxYeVmpZLAfFwQdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fUHdzov3MC3v1wWePhABbLqZzLElCD+p//6saLHs/ketnxhw8Jp3jrM+pwx3hbefK
	 rVBqPOCZ1TSqveOu0xsGbxRRo2aiHhFouFx009684zMJMXblcN2cJFY+fjJP8zHn6I
	 OlVHBMbgM6TY8xDj2iUEzQYaD6q+t7V88aShm5mh0SGuXzAjIr202pn+lROF4/615o
	 pQWHrDBG85sAqPvaGPuunp5SJIiFxPVS2qYPUHrqzhOU3U6JULRU0jYUCQNfzR1FZi
	 sUghYoU548WwuXJsY6Kkrme13FTZw6psST8ZZPZUGZwSVYBA3cgHjVhZcx7ghVW/2A
	 P6TYHC1u/m1rg==
Date: Sun, 19 Jul 2026 12:23:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH bpf-next v3 0/5] bpf, x86: enable EXECMEM_ROX_CACHE for
 BPF allocations
Message-ID: <alyXjynKnIp7X-3b@kernel.org>
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <CAPhsuW5pRMtpa5Q0Y=zO5=2HSj4xOX+i5Vp+g2a6RDvmkeHKFw@mail.gmail.com>
 <alnOkjf8rq3dUGmg@kernel.org>
 <CAPhsuW7xvJM6PPGwkeZJhi+a-emuuX09uxKom29mns5-iwOYXw@mail.gmail.com>
 <aln1_kGygUqdtlAt@kernel.org>
 <CAPhsuW4dt6YdNnce4wfJkVuuP339sh=0wCGwBG2_Nc2BYu4CSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4dt6YdNnce4wfJkVuuP339sh=0wCGwBG2_Nc2BYu4CSQ@mail.gmail.com>

On Fri, Jul 17, 2026 at 10:50:09AM -0700, Song Liu wrote:
> On Fri, Jul 17, 2026 at 2:29 AM Mike Rapoport <rppt@kernel.org> wrote:
> [...]
> > > >
> > > > "It works, don't touch"? ;-)
> > > >
> > > > We can add another layer for sub-page allocations to execmem.
> > >
> > > Sub-page allocation is not a hard requirement here. Using 4kB for
> > > each small BPF program isn't too bad. We added bpf_prog_pack to
> > > avoid fragmentation of direct map page table entry (caused by W^X
> > > requirement). If execmem allocator reserves large enough ROX
> > > memory (with PMD page table entries) and reuses them properly,
> > > we shouldn't see page table fragmentation getting worse over time.
> > > Then, we can use 4kB granularity allocation for BPF programs. (I am
> > > not sure about 64kB pages..).
> >
> > execmem uses PMD_SIZE pages for ROX cache. Since right now it's only
> > supported on x86, the issue with oversized large page with 64k base pages
> > didn't come up yet.
> 
> With 64kB page size, PMD_SIZE is probably too big for execmem.

Yeah, I think so. But maybe on arm64 with 64kB pages we could use CONT_PTE.
 
> > > > Since BPF is the only user the easiest would be just to move prog_pack
> > > > logic from BPF to execmem and call it a day.
> > >
> > > If we move to bigger page sizes, say 64kB, there will be other
> > > users that would benefit from sub page allocation, right?
> >
> > Maybe modules could, don't know TBH.
> > There is another caveat with sub-page allocations: they must preserve ROX
> > and no subsystem except BPF can deal with ROX-only allocations and writable
> > copies.
> 
> I think ftrace and kprobe could be good users?

Don't know about ftrace, but kprobes essentially has page-sized caches and
uses them internally.
 
> > > > Another option is to add a slab-like layer for sub-page allocations to
> > > > execmem. This is more complex but it would allow to get rid of the rigid
> > > > BPF_PROG_CHUNK_SIZE.
> > > >
> > > > Maybe it would be also possible to teach SLUB to use execmem_alloc()
> > > > instead of alloc_pages() but that's surely the most far fetched one :)
> > >
> > > I was thinking some rb-tree algorithm might be useful here,
> > > something similar to vmap.
> >
> > Could be that or maple_tree especially considering there's an active
> > discussion about converting vmalloc to maple_tree as well:
> >
> > https://lore.kernel.org/linux-mm/20260613-vmalloc_maple-v1-0-0aa740bb944b@oss.qualcomm.com/
> >
> > But the choice of allocation algorithm is anyway secondary to the decision
> > whether execmem should have the sub-page allocator.
> >
> > If you say that a page per BPF program is fine, than maybe we can just rip
> > off bpf_prog_pack_alloc().
> > If BPF still needs to maintain the ability to allocate in smaller chunks,
> > then maybe the best way is to keep bpf_prog_pack_alloc() as is because I
> > don't foresee other users for small page allocations any time soon.
> >
> > > > And since we are talking about bpf_prog_pack_alloc(), why
> > > > BPF_PROG_PACK_SIZE accounts for num_possible_nodes():
> > > >
> > > > #define BPF_PROG_PACK_SIZE (SZ_2M * num_possible_nodes())
> > > >
> > > > Is it an elaborate choice or it was picked to work around older
> > > > vmalloc_huge() limitations?
> > >
> > > It is a bit complicated. The goal is to get PMDs for prog_pack.
> > > We can adjust this if vmalloc_huge() changes after that.
> >
> > Since commit c82be0be9576 ("mm: vmalloc: don't account for number of nodes
> > for HUGE_VMAP allocations") vmalloc_huge() is fine with PMD_SIZE regardless
> > of number of nodes.
> 
> Before execmem can handle sub page allocations, how about we
> send allocations that are bigger than page size directly to execmem,
> and let bpf_prog_pack handle sub page allocations. Then,
> BPF_PROG_PACK_SIZE will be PAGE_SIZE. This should be a net
> win for x86_64. Other archs will be the same. WDYT?

Makes perfect sense to me for x86.

On architectures that support large mappings in the direct map and do not
support EXECMEM_CACHE_ROX this will increase direct map fragmentation.
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.
