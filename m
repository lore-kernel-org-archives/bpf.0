Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECB379C22
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310623; cv=none; b=sB+Qk0P7KlHMPP+Bw/53I2XICndiErpZB7nF4Ub9b/zTq6v55YMM0ubJEbkXVMNIze9NHXXh2O+75tfnxBzQMux/nqx75icYs0esP+AmJiWJ22ycJbA5sjF1fznbHYkpEmDzQ57QyLrWaP4RS8Ue3e5ERNYwLHVW3t/h9e18Q9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310623; c=relaxed/simple;
	bh=FgoKucNOOsLynCX6/lKAm0xHgAdBNSXWqJS6XluwI54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7yNnVyWJZc7yAeXHkMD473SAUC4lE5cyIwdLYlrPnkgsYuajmHgTO+BdRaEfnJDN9rPuTDseVbhMIQw92WOIN5vfaWoLfZaoU24HKZHxos64RElKqE2G8KBPCKjpxQxQ6ooVlNMwEeHpTtM2R3L6boUrcoKozaj5s1HhIK9K2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD8CMmBR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD8CMmBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2519A1F01558
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 17:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784310622;
	bh=FgoKucNOOsLynCX6/lKAm0xHgAdBNSXWqJS6XluwI54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UD8CMmBRjVcHzsLme2ZId+4lqljidatUe+5J45030S5pcSQyTtJdYr0eBxOt87+y6
	 WygDqqk/ZVkCkVKsyvY/UXWAH/CddudTB06YOGbLFo1haMKkLxBm5yyR8LpTHbfQpM
	 vDbYgm2WgHUluLehTnypwYcAUaK1oc+YVXMAiAaA8pNinvZUqEUaHyrAOn/Ywd8zrW
	 EiU7feSgDaknCYMXbzrBZo3JtkKo86V1ZKM3uXKjcq/UHzbQK1jPXp7u9vFvVHoU8/
	 9flK0KldzDHQjQsrEc2Ta1MzJG5VtOmeI5juEQzjS2PJy73WCQoK19keyHI+icnUSN
	 tmEgQG///JDlA==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e5d50b0dbso358611785a.1
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 10:50:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrcqZYAQOX5LCBZQc61zyldSdpyy9BWseaztsbfvJ8wBI6bz0ExWmDouUF1e0o5WxwSylc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlzs2uY47XPRGLNdnM/4hRojIR5HAZiDnsh40lfydojQumI4nw
	+wBT3sf7vs/IGC7G+IuHEuz+n44nblqtYnOS7ZoeUVOU1zxkPKvobwFSwiln1luYuR6kcZoR17v
	gXEG0mfXEdktlLUY7PcNdcbhu4G6D2II=
X-Received: by 2002:a05:620a:171f:b0:92b:6805:9176 with SMTP id
 af79cd13be357-930b41ce3a3mr398722785a.62.1784310621271; Fri, 17 Jul 2026
 10:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <CAPhsuW5pRMtpa5Q0Y=zO5=2HSj4xOX+i5Vp+g2a6RDvmkeHKFw@mail.gmail.com>
 <alnOkjf8rq3dUGmg@kernel.org> <CAPhsuW7xvJM6PPGwkeZJhi+a-emuuX09uxKom29mns5-iwOYXw@mail.gmail.com>
 <aln1_kGygUqdtlAt@kernel.org>
In-Reply-To: <aln1_kGygUqdtlAt@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 17 Jul 2026 10:50:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4dt6YdNnce4wfJkVuuP339sh=0wCGwBG2_Nc2BYu4CSQ@mail.gmail.com>
X-Gm-Features: AUfX_my_13iFc0QT02UU2DQ4inneVQRCQTP3JT1mkEXbrDYcMwoA5JBs5pjnii0
Message-ID: <CAPhsuW4dt6YdNnce4wfJkVuuP339sh=0wCGwBG2_Nc2BYu4CSQ@mail.gmail.com>
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

On Fri, Jul 17, 2026 at 2:29=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
[...]
> > >
> > > "It works, don't touch"? ;-)
> > >
> > > We can add another layer for sub-page allocations to execmem.
> >
> > Sub-page allocation is not a hard requirement here. Using 4kB for
> > each small BPF program isn't too bad. We added bpf_prog_pack to
> > avoid fragmentation of direct map page table entry (caused by W^X
> > requirement). If execmem allocator reserves large enough ROX
> > memory (with PMD page table entries) and reuses them properly,
> > we shouldn't see page table fragmentation getting worse over time.
> > Then, we can use 4kB granularity allocation for BPF programs. (I am
> > not sure about 64kB pages..).
>
> execmem uses PMD_SIZE pages for ROX cache. Since right now it's only
> supported on x86, the issue with oversized large page with 64k base pages
> didn't come up yet.

With 64kB page size, PMD_SIZE is probably too big for execmem.

> > > Since BPF is the only user the easiest would be just to move prog_pac=
k
> > > logic from BPF to execmem and call it a day.
> >
> > If we move to bigger page sizes, say 64kB, there will be other
> > users that would benefit from sub page allocation, right?
>
> Maybe modules could, don't know TBH.
> There is another caveat with sub-page allocations: they must preserve ROX
> and no subsystem except BPF can deal with ROX-only allocations and writab=
le
> copies.

I think ftrace and kprobe could be good users?

> > > Another option is to add a slab-like layer for sub-page allocations t=
o
> > > execmem. This is more complex but it would allow to get rid of the ri=
gid
> > > BPF_PROG_CHUNK_SIZE.
> > >
> > > Maybe it would be also possible to teach SLUB to use execmem_alloc()
> > > instead of alloc_pages() but that's surely the most far fetched one :=
)
> >
> > I was thinking some rb-tree algorithm might be useful here,
> > something similar to vmap.
>
> Could be that or maple_tree especially considering there's an active
> discussion about converting vmalloc to maple_tree as well:
>
> https://lore.kernel.org/linux-mm/20260613-vmalloc_maple-v1-0-0aa740bb944b=
@oss.qualcomm.com/
>
> But the choice of allocation algorithm is anyway secondary to the decisio=
n
> whether execmem should have the sub-page allocator.
>
> If you say that a page per BPF program is fine, than maybe we can just ri=
p
> off bpf_prog_pack_alloc().
> If BPF still needs to maintain the ability to allocate in smaller chunks,
> then maybe the best way is to keep bpf_prog_pack_alloc() as is because I
> don't foresee other users for small page allocations any time soon.
>
> > > And since we are talking about bpf_prog_pack_alloc(), why
> > > BPF_PROG_PACK_SIZE accounts for num_possible_nodes():
> > >
> > > #define BPF_PROG_PACK_SIZE (SZ_2M * num_possible_nodes())
> > >
> > > Is it an elaborate choice or it was picked to work around older
> > > vmalloc_huge() limitations?
> >
> > It is a bit complicated. The goal is to get PMDs for prog_pack.
> > We can adjust this if vmalloc_huge() changes after that.
>
> Since commit c82be0be9576 ("mm: vmalloc: don't account for number of node=
s
> for HUGE_VMAP allocations") vmalloc_huge() is fine with PMD_SIZE regardle=
ss
> of number of nodes.

Before execmem can handle sub page allocations, how about we
send allocations that are bigger than page size directly to execmem,
and let bpf_prog_pack handle sub page allocations. Then,
BPF_PROG_PACK_SIZE will be PAGE_SIZE. This should be a net
win for x86_64. Other archs will be the same. WDYT?

Thanks,
Song
