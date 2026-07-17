Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503F333440;
	Fri, 17 Jul 2026 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280586; cv=none; b=tW8041ZzvadXSyXcvN3/ATC5fj1Gt7DlP0IokB2kkfzAhqvxISgxYU2hZl2Qd7PlumsRijz4urTrwiYTI6eoOpOgTtFnkoz2xIKC+ELmwzAc3XgdNWKgbp8kCmQyusozVxs1ZAzmXoLCYKqYLG4QcEL8qGk2eFSziIt5arYt6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280586; c=relaxed/simple;
	bh=RmhJm58Pb3EzFlXhZx761PWQvJ+MFe/Bl/f7J/p3UbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7zGP/5OX4sqUe/kVw003VO1r7iTNTeRu1jHyhMrfUlzx2hl/R871JI2ReKUmJpk0X2drsr6XZZ9jiK95LOZM9GUHskjrgnHazFus5k81Pm2qiha56NbVCbZkTiUjbHd/8kVwoaXY99z0VYaEbpEOySTn22omm0x9IZYLL1ctG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIvIqW3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIvIqW3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACABF1F000E9;
	Fri, 17 Jul 2026 09:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280585;
	bh=Xv/sPwTs/PBhP/94cZTgrxFKOFDrVCaO2zmc3lQZyKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LIvIqW3U7Tq/bIwQKp9L10wGVU6sDpXw1NVgMdhVq6SsPsqisyI2gEjlqvG81D78N
	 u/d4uzMrqipu5d14ofLxuMBf+OKz3chvHtAdTgvk2KVxW1YML1gGe20vN9JT4q/gI8
	 wRZirhh0PMRWuRFXqWmKnZmwqOViZk2C3Fm6xbU0jUbJJ4m/CZ+7HmI9DgoBCluH+J
	 f3OqTzzdVGK+g4uWcODGgU9x+ubFYdR0unyNJ7GZCBka27aRPBF4w0ZzGC8gwE8Nl4
	 Gvxfall8ixgbq8BCyJSilNCCnTyUmkb8GGrXHktWkfhHi7OvPNOGuVBDrdZr8egLWW
	 0j4sSk2znfzeg==
Date: Fri, 17 Jul 2026 12:29:34 +0300
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
Message-ID: <aln1_kGygUqdtlAt@kernel.org>
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <CAPhsuW5pRMtpa5Q0Y=zO5=2HSj4xOX+i5Vp+g2a6RDvmkeHKFw@mail.gmail.com>
 <alnOkjf8rq3dUGmg@kernel.org>
 <CAPhsuW7xvJM6PPGwkeZJhi+a-emuuX09uxKom29mns5-iwOYXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7xvJM6PPGwkeZJhi+a-emuuX09uxKom29mns5-iwOYXw@mail.gmail.com>

On Fri, Jul 17, 2026 at 12:27:03AM -0700, Song Liu wrote:
> On Thu, Jul 16, 2026 at 11:41 PM Mike Rapoport <rppt@kernel.org> wrote:
> > On Thu, Jul 16, 2026 at 05:00:11PM -0700, Song Liu wrote:
> > > On Thu, Jul 16, 2026 at 12:51 AM Mike Rapoport (Microsoft)
> > > <rppt@kernel.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > BPF allocations of executable memory on x86 are essentially read-only. Most
> > > > paths that call bpf_jit_alloc_exec() immediately make it ROX with
> > > > set_memory_rox().
> > > >
> > > > The code generation, at least on x86, uses separately allocated writable
> > > > buffers and then updates the actual text memory with text_poke().
> > > >
> > > > These patches do several small adjustments to how BPF allocates executable
> > > > memory and enable EXECMEM_ROX_CACHE for BPF allocations on x86.
> > >
> > > After this set, we are still using bpf_prog_pack_alloc() from x86 code. I think
> > > the goal is to eventually remove bpf_prog_pack_alloc(). What's our plan for
> > > the next steps (toward removing bpf_prog_pack_alloc)?
> >
> > "It works, don't touch"? ;-)
> >
> > We can add another layer for sub-page allocations to execmem.
> 
> Sub-page allocation is not a hard requirement here. Using 4kB for
> each small BPF program isn't too bad. We added bpf_prog_pack to
> avoid fragmentation of direct map page table entry (caused by W^X
> requirement). If execmem allocator reserves large enough ROX
> memory (with PMD page table entries) and reuses them properly,
> we shouldn't see page table fragmentation getting worse over time.
> Then, we can use 4kB granularity allocation for BPF programs. (I am
> not sure about 64kB pages..).

execmem uses PMD_SIZE pages for ROX cache. Since right now it's only
supported on x86, the issue with oversized large page with 64k base pages
didn't come up yet.
 
> > Since BPF is the only user the easiest would be just to move prog_pack
> > logic from BPF to execmem and call it a day.
> 
> If we move to bigger page sizes, say 64kB, there will be other
> users that would benefit from sub page allocation, right?

Maybe modules could, don't know TBH.
There is another caveat with sub-page allocations: they must preserve ROX
and no subsystem except BPF can deal with ROX-only allocations and writable
copies.
 
> > Another option is to add a slab-like layer for sub-page allocations to
> > execmem. This is more complex but it would allow to get rid of the rigid
> > BPF_PROG_CHUNK_SIZE.
> >
> > Maybe it would be also possible to teach SLUB to use execmem_alloc()
> > instead of alloc_pages() but that's surely the most far fetched one :)
> 
> I was thinking some rb-tree algorithm might be useful here,
> something similar to vmap.

Could be that or maple_tree especially considering there's an active
discussion about converting vmalloc to maple_tree as well:

https://lore.kernel.org/linux-mm/20260613-vmalloc_maple-v1-0-0aa740bb944b@oss.qualcomm.com/

But the choice of allocation algorithm is anyway secondary to the decision
whether execmem should have the sub-page allocator.

If you say that a page per BPF program is fine, than maybe we can just rip
off bpf_prog_pack_alloc().
If BPF still needs to maintain the ability to allocate in smaller chunks,
then maybe the best way is to keep bpf_prog_pack_alloc() as is because I
don't foresee other users for small page allocations any time soon.
 
> > And since we are talking about bpf_prog_pack_alloc(), why
> > BPF_PROG_PACK_SIZE accounts for num_possible_nodes():
> >
> > #define BPF_PROG_PACK_SIZE (SZ_2M * num_possible_nodes())
> >
> > Is it an elaborate choice or it was picked to work around older
> > vmalloc_huge() limitations?
> 
> It is a bit complicated. The goal is to get PMDs for prog_pack.
> We can adjust this if vmalloc_huge() changes after that.

Since commit c82be0be9576 ("mm: vmalloc: don't account for number of nodes
for HUGE_VMAP allocations") vmalloc_huge() is fine with PMD_SIZE regardless
of number of nodes.

With 64k pages it's still a lot though.
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.
