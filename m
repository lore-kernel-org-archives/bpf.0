Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9A46F494
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656760; cv=none; b=JSLqD6r+5t+z1QV6FnzoimfGc0hFKgzqRQTRBslv859ybNmtRI7bgUjPFgFLQ2qgLwSs+bowPAGLD7cL4VIAmeBtCBYBzVVFaBqnYKvhlJOqE1TCxIXHRVT0+/8lONMTIJTU9zU5jeTaI/6EQRcdeROPloZ8I3GYHFZBenfguAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656760; c=relaxed/simple;
	bh=kPRXc8y1gYGfheJ+ZZjASEwga8Hrs/3Z3nvKBA/vS+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVD5yRd4e5z/l26tBpOH+AOZ2TmdyJiQxVPDYvCRDWmbRAyY6+5OBHx8z/zPi6w0avGn5zvzV58eYv+1baD4JyYGQFqJfK8gSil634DLfXIVB9vM4i6ftX6BVBbK3wkbL7zHIfgw4wAkRqOJEcgQMh9hOMsEfhBrPTEE/smjf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz+MxdV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz+MxdV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143F21F0155F
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784656759;
	bh=kPRXc8y1gYGfheJ+ZZjASEwga8Hrs/3Z3nvKBA/vS+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hz+MxdV3K7sOsgMtXYPr1lyv0RRE8kZZM7X82vUnIiQdskdkkZg/igHSAdf6RrOXF
	 VYiH90M4L0JcxU5mtLaK+rSvY19qOa1ZLWYtcKsBqqMFQzdGZuuuc8d3/vRsnSXXPo
	 xL4c5ZiXYoWEiwe3D4lRWw8Br92GMuAsvQF1hzxTEnr88TGhQkGsvtPqPXhEeK1Qtv
	 7C75tKL8XYrrcTTTwdEz9lFk03vY9fAA3tUdqSWPvOgfMOTuHRuaK/+pKMQNh/GK+j
	 hryVt3iODSDPqLsZOpIKF2scMmSS4pNOEn35FdWWFcbhVKkS8SILe0mMM6HDMK3wt2
	 Ir0CzbEYqKsFg==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-920f33347f5so912137185a.3
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 10:59:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RohvUie8KJ7wNqX2FEv0/9RI7JtqtvDoiNVrDJWLMqO7CnaiQSUDtTiGN2ugYZG5RnsD/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XAl2gjqpjyt0QAze7+m44yX4eC2Ko1e8WDkOc8bPkhx+Vm61
	u9voxXN0DC/fsM9cHMqpnxZqZxquGowAEEYRigFdRnwetcK4QtCYxi+93z69r1cd3xO7pC/kXeh
	Nmz4hIpOdpH+uZSluSBgeDvdyr9aq2c8=
X-Received: by 2002:a05:620a:4606:b0:92e:612d:87cc with SMTP id
 af79cd13be357-930b41c0e81mr1933417085a.46.1784656757947; Tue, 21 Jul 2026
 10:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <CAPhsuW5pRMtpa5Q0Y=zO5=2HSj4xOX+i5Vp+g2a6RDvmkeHKFw@mail.gmail.com>
 <alnOkjf8rq3dUGmg@kernel.org> <CAPhsuW7xvJM6PPGwkeZJhi+a-emuuX09uxKom29mns5-iwOYXw@mail.gmail.com>
 <aln1_kGygUqdtlAt@kernel.org> <CAPhsuW4dt6YdNnce4wfJkVuuP339sh=0wCGwBG2_Nc2BYu4CSQ@mail.gmail.com>
 <alyXjynKnIp7X-3b@kernel.org>
In-Reply-To: <alyXjynKnIp7X-3b@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 21 Jul 2026 10:59:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6+6zcSRGUAtp=3e4a8at3yuRP8Xijb-4LBHtQ8Li6wrQ@mail.gmail.com>
X-Gm-Features: AUfX_mwFeJItVOUqxa0ZNk_JHGOGFwzak8s1jRFC67wLfHqu_KqKcTLJKdpc-xQ
Message-ID: <CAPhsuW6+6zcSRGUAtp=3e4a8at3yuRP8Xijb-4LBHtQ8Li6wrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/5] bpf, x86: enable EXECMEM_ROX_CACHE for
 BPF allocations
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	"H. Peter Anvin" <hpa@zytor.com>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 2:23=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Jul 17, 2026 at 10:50:09AM -0700, Song Liu wrote:
> > On Fri, Jul 17, 2026 at 2:29=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > [...]
> > > > >
> > > > > "It works, don't touch"? ;-)
> > > > >
> > > > > We can add another layer for sub-page allocations to execmem.
> > > >
> > > > Sub-page allocation is not a hard requirement here. Using 4kB for
> > > > each small BPF program isn't too bad. We added bpf_prog_pack to
> > > > avoid fragmentation of direct map page table entry (caused by W^X
> > > > requirement). If execmem allocator reserves large enough ROX
> > > > memory (with PMD page table entries) and reuses them properly,
> > > > we shouldn't see page table fragmentation getting worse over time.
> > > > Then, we can use 4kB granularity allocation for BPF programs. (I am
> > > > not sure about 64kB pages..).
> > >
> > > execmem uses PMD_SIZE pages for ROX cache. Since right now it's only
> > > supported on x86, the issue with oversized large page with 64k base p=
ages
> > > didn't come up yet.
> >
> > With 64kB page size, PMD_SIZE is probably too big for execmem.
>
> Yeah, I think so. But maybe on arm64 with 64kB pages we could use CONT_PT=
E.
>
> > > > > Since BPF is the only user the easiest would be just to move prog=
_pack
> > > > > logic from BPF to execmem and call it a day.
> > > >
> > > > If we move to bigger page sizes, say 64kB, there will be other
> > > > users that would benefit from sub page allocation, right?
> > >
> > > Maybe modules could, don't know TBH.
> > > There is another caveat with sub-page allocations: they must preserve=
 ROX
> > > and no subsystem except BPF can deal with ROX-only allocations and wr=
itable
> > > copies.
> >
> > I think ftrace and kprobe could be good users?
>
> Don't know about ftrace, but kprobes essentially has page-sized caches an=
d
> uses them internally.
>
> > > > > Another option is to add a slab-like layer for sub-page allocatio=
ns to
> > > > > execmem. This is more complex but it would allow to get rid of th=
e rigid
> > > > > BPF_PROG_CHUNK_SIZE.
> > > > >
> > > > > Maybe it would be also possible to teach SLUB to use execmem_allo=
c()
> > > > > instead of alloc_pages() but that's surely the most far fetched o=
ne :)
> > > >
> > > > I was thinking some rb-tree algorithm might be useful here,
> > > > something similar to vmap.
> > >
> > > Could be that or maple_tree especially considering there's an active
> > > discussion about converting vmalloc to maple_tree as well:
> > >
> > > https://lore.kernel.org/linux-mm/20260613-vmalloc_maple-v1-0-0aa740bb=
944b@oss.qualcomm.com/
> > >
> > > But the choice of allocation algorithm is anyway secondary to the dec=
ision
> > > whether execmem should have the sub-page allocator.
> > >
> > > If you say that a page per BPF program is fine, than maybe we can jus=
t rip
> > > off bpf_prog_pack_alloc().
> > > If BPF still needs to maintain the ability to allocate in smaller chu=
nks,
> > > then maybe the best way is to keep bpf_prog_pack_alloc() as is becaus=
e I
> > > don't foresee other users for small page allocations any time soon.
> > >
> > > > > And since we are talking about bpf_prog_pack_alloc(), why
> > > > > BPF_PROG_PACK_SIZE accounts for num_possible_nodes():
> > > > >
> > > > > #define BPF_PROG_PACK_SIZE (SZ_2M * num_possible_nodes())
> > > > >
> > > > > Is it an elaborate choice or it was picked to work around older
> > > > > vmalloc_huge() limitations?
> > > >
> > > > It is a bit complicated. The goal is to get PMDs for prog_pack.
> > > > We can adjust this if vmalloc_huge() changes after that.
> > >
> > > Since commit c82be0be9576 ("mm: vmalloc: don't account for number of =
nodes
> > > for HUGE_VMAP allocations") vmalloc_huge() is fine with PMD_SIZE rega=
rdless
> > > of number of nodes.
> >
> > Before execmem can handle sub page allocations, how about we
> > send allocations that are bigger than page size directly to execmem,
> > and let bpf_prog_pack handle sub page allocations. Then,
> > BPF_PROG_PACK_SIZE will be PAGE_SIZE. This should be a net
> > win for x86_64. Other archs will be the same. WDYT?
>
> Makes perfect sense to me for x86.

Can we include this change to this patch set? This will make this
change a meaningful step towards migrating to EXECMEM.

> On architectures that support large mappings in the direct map and do not
> support EXECMEM_CACHE_ROX this will increase direct map fragmentation.

Architectures that support bpf_prog_pack can benefit from
EXECMEM_CACHE_ROX. What does it take to also enable
EXECMEM_CACHE_ROX for them?

Thanks,
Song
