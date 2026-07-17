Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA23B42D2
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273237; cv=none; b=YUt+lf2cLxWD3HzCiAUNytfx2D4EwSGKdxFKP4SzAlGlGzXwtAw2fOHKNWGvyqzdj1R8St5LXRBSlR1m06LdJSsOKAgpChCetHHnnH4t1baWN3A13HB6HusMI6kj5LD3cfpjDIKAORmUEVjwvwpKLrThZ8ZObvAmqMrBQpXX36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273237; c=relaxed/simple;
	bh=+c1BnKCDEQ3gnHueuw5QTr2XAvtr/08flu7onybr7A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPBT0uMH7X5ixkXxyXLzhhNgEiE3aY+RwdjYwUtY28UltPpqOJXtADgaDCsgIxVDFsX22G1kH6iWJXzdaHUwK4mk/QFxGEsQRRftJzdFImHTmjteoZ2+VpH1R1D5rNPKYJUtNHl/PDYoxyH2UvmR+w7tfnp9by//Jkouo1jCRPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8GzKaOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8GzKaOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50801F00A3A
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 07:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784273235;
	bh=+c1BnKCDEQ3gnHueuw5QTr2XAvtr/08flu7onybr7A0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=G8GzKaOc0Jvk8TEXbyPSVKF/f3Ibbrn0n8xeWeY2Ju3TjODR7SN+ptVYI22g30V7O
	 bVm9kC4x5lvg/CgvzYsxXCgmEpRkkS5WUxPwKMPhP1cinJIp3bbecydp3CW86IWof9
	 3jghXpiX7LeYzsdn3f/6nlaJXrQ6mWrA5yQ1PSzXRtulJZGZXfKS3gTZ9/RFjqWWF0
	 w9XS36Hr5eYM9VKw3HAtnyT9lfrTixiEKjYOhrP0e0kwNPCGcurQvotygaL2qJgQgO
	 UjUFPlnH7kIrO+uWu0VBhl2VybdZfdbEUDjlh3rAqHxlVI0eqaISL5pdyONsLZlWGJ
	 aSF+ep4k8Itpg==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8f1e274ccb9so31252036d6.2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 00:27:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpUJ15zUESU0iLDoFojiUAsPH+RIYf13DcwGgU3G56GirAhCDtd4/JYPuLAi839/3KRZP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLR7aoB96kjxU7AHlidBIABq59tlOaudkqrFanigzQTCv4bffX
	du5SQIpHxb9UKX+HG2JmqbMZrZCE9YSaC1hYe5TNbHT6JEpBRqvCHASGGS5KPpnSrPZQK1Subs7
	azMjZsXkbvjKnbe7N9At99udfbFXPAQg=
X-Received: by 2002:a05:620a:2985:b0:915:a811:1707 with SMTP id
 af79cd13be357-930b3ed9e4dmr151991685a.5.1784273234978; Fri, 17 Jul 2026
 00:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <CAPhsuW5pRMtpa5Q0Y=zO5=2HSj4xOX+i5Vp+g2a6RDvmkeHKFw@mail.gmail.com> <alnOkjf8rq3dUGmg@kernel.org>
In-Reply-To: <alnOkjf8rq3dUGmg@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 17 Jul 2026 00:27:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7xvJM6PPGwkeZJhi+a-emuuX09uxKom29mns5-iwOYXw@mail.gmail.com>
X-Gm-Features: AUfX_mzZuQMVeoaPUGN7-WJp_yB6Y6DgWtQRr48Eo6PuskP4XZj2uvYTZSydvGg
Message-ID: <CAPhsuW7xvJM6PPGwkeZJhi+a-emuuX09uxKom29mns5-iwOYXw@mail.gmail.com>
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

On Thu, Jul 16, 2026 at 11:41=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Thu, Jul 16, 2026 at 05:00:11PM -0700, Song Liu wrote:
> > On Thu, Jul 16, 2026 at 12:51=E2=80=AFAM Mike Rapoport (Microsoft)
> > <rppt@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > BPF allocations of executable memory on x86 are essentially read-only=
. Most
> > > paths that call bpf_jit_alloc_exec() immediately make it ROX with
> > > set_memory_rox().
> > >
> > > The code generation, at least on x86, uses separately allocated writa=
ble
> > > buffers and then updates the actual text memory with text_poke().
> > >
> > > These patches do several small adjustments to how BPF allocates execu=
table
> > > memory and enable EXECMEM_ROX_CACHE for BPF allocations on x86.
> >
> > After this set, we are still using bpf_prog_pack_alloc() from x86 code.=
 I think
> > the goal is to eventually remove bpf_prog_pack_alloc(). What's our plan=
 for
> > the next steps (toward removing bpf_prog_pack_alloc)?
>
> "It works, don't touch"? ;-)
>
> We can add another layer for sub-page allocations to execmem.

Sub-page allocation is not a hard requirement here. Using 4kB for
each small BPF program isn't too bad. We added bpf_prog_pack to
avoid fragmentation of direct map page table entry (caused by W^X
requirement). If execmem allocator reserves large enough ROX
memory (with PMD page table entries) and reuses them properly,
we shouldn't see page table fragmentation getting worse over time.
Then, we can use 4kB granularity allocation for BPF programs. (I am
not sure about 64kB pages..).

>
> Since BPF is the only user the easiest would be just to move prog_pack
> logic from BPF to execmem and call it a day.

If we move to bigger page sizes, say 64kB, there will be other
users that would benefit from sub page allocation, right?

> Another option is to add a slab-like layer for sub-page allocations to
> execmem. This is more complex but it would allow to get rid of the rigid
> BPF_PROG_CHUNK_SIZE.
>
> Maybe it would be also possible to teach SLUB to use execmem_alloc()
> instead of alloc_pages() but that's surely the most far fetched one :)

I was thinking some rb-tree algorithm might be useful here,
something similar to vmap.

> And since we are talking about bpf_prog_pack_alloc(), why
> BPF_PROG_PACK_SIZE accounts for num_possible_nodes():
>
> #define BPF_PROG_PACK_SIZE (SZ_2M * num_possible_nodes())
>
> Is it an elaborate choice or it was picked to work around older
> vmalloc_huge() limitations?

It is a bit complicated. The goal is to get PMDs for prog_pack.
We can adjust this if vmalloc_huge() changes after that.

Thanks,
Song
