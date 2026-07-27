Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA14C92;
	Mon, 27 Jul 2026 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141364; cv=none; b=l9oCyME12w+y+5XiDmCX6JzTqGr3pLZqLP/ReemHIxf2FKE0wXmGED8MDcjd3ZVX26pCdq0PrlyqIAqDKy3GBavzm6z7KnM5Gfk8pYx3SGUAfogJ0f/czVzMKb5hnVn9Ra2W9beq3ENWosHQoXJeMY/ICiT1bUQVh7deOkOVfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141364; c=relaxed/simple;
	bh=FZrTtAQajDZLtGG6UFoTail0AOLvkde+9YefYzbTBIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHHUXxFLQ0Sr4GKsa4xDQ1xhq829oBnB1uyMNV5ro7brkSqqDNXpFEt6QlFue3QLx1ET9xLiWfo5m7D4Sd32iM1kwGHzPlirhi0NN5YsZIIXcSMAlOaR5Ynocg4pCu8c3us/9Z+g5D5LMkBBjccguaGIQ121xmyHDC4ArYqUXOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkEQMit4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkEQMit4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6BC1F000E9;
	Mon, 27 Jul 2026 08:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785141362;
	bh=G8l2A3cu41yXPeU5oF2Ly4i79VBg6YNDoHWhsOEuIEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JkEQMit4G+M36n62Tjgej/X4gfcgLYV3i61yVDPaq0O33kxxSKpIr/kJ41jUqqWTE
	 6ghuN3KsACHf3Lqnyztz4QbrHSqsFyS5l6yxHpOjbpA+peaFktGPOWK5zIED3eSyCx
	 97FZSNSXVEJtX25+RQlJUCWTi8l9aLK9MBrYciWLL3v1DxyMaoboP7EiISJYPZOzrK
	 97NcPRT8USQrZ3WJGvxkXAeHNL8ZttJHfzf+Q8EXFZfGpJN0FpSNBtwJE7M6SEFVt4
	 pZuhIGSJOxT7ifwEH7/d8nlo+OpfpoTTpqnBajw03iWAx/1CLropDdP4vSaBPzqHeO
	 bZsJu/+kvSC4Q==
Date: Mon, 27 Jul 2026 11:35:54 +0300
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
Message-ID: <amcYaosF8Eoq7S6V@kernel.org>
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <CAPhsuW5pRMtpa5Q0Y=zO5=2HSj4xOX+i5Vp+g2a6RDvmkeHKFw@mail.gmail.com>
 <alnOkjf8rq3dUGmg@kernel.org>
 <CAPhsuW7xvJM6PPGwkeZJhi+a-emuuX09uxKom29mns5-iwOYXw@mail.gmail.com>
 <aln1_kGygUqdtlAt@kernel.org>
 <CAPhsuW4dt6YdNnce4wfJkVuuP339sh=0wCGwBG2_Nc2BYu4CSQ@mail.gmail.com>
 <alyXjynKnIp7X-3b@kernel.org>
 <CAPhsuW6+6zcSRGUAtp=3e4a8at3yuRP8Xijb-4LBHtQ8Li6wrQ@mail.gmail.com>
 <amB52yECfXNgbeY4@kernel.org>
 <CAPhsuW6St=y8ekEVmQke6jPeyNC8MqhW9oG1wDJOwWmPbFZzWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6St=y8ekEVmQke6jPeyNC8MqhW9oG1wDJOwWmPbFZzWQ@mail.gmail.com>

On Wed, Jul 22, 2026 at 08:04:04AM -0700, Song Liu wrote:
> On Wed, Jul 22, 2026 at 1:06 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, Jul 21, 2026 at 10:59:06AM -0700, Song Liu wrote:
> > > On Sun, Jul 19, 2026 at 2:23 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > > >
> > > > > > Since commit c82be0be9576 ("mm: vmalloc: don't account for number of nodes
> > > > > > for HUGE_VMAP allocations") vmalloc_huge() is fine with PMD_SIZE regardless
> > > > > > of number of nodes.
> > > > >
> > > > > Before execmem can handle sub page allocations, how about we
> > > > > send allocations that are bigger than page size directly to execmem,
> > > > > and let bpf_prog_pack handle sub page allocations. Then,
> > > > > BPF_PROG_PACK_SIZE will be PAGE_SIZE. This should be a net
> > > > > win for x86_64. Other archs will be the same. WDYT?
> > > >
> > > > Makes perfect sense to me for x86.
> > >
> > > Can we include this change to this patch set? This will make this
> > > change a meaningful step towards migrating to EXECMEM.
> >
> > I'd prefer to leave this as a separate followup.
> >
> > The decision whether to use EXECMEM_ROX_CACHE is made at runtime, which
> > means that BPF_PROG_PACK_SIZE should become a variable, that variable needs
> > initialization at some point during boot and that in turn requires a new
> > helper in execmem that will say if EXECMEM_CACHE_ROX is enabled.
> 
> Hmm... deciding whether to use EXECMEM_ROX_CACHE at runtime seems
> weird. Can we enable it all the time and decide how much memory it reserves
> at runtime?

Enabling ROX cache without using PMD_SIZE mappings is pure overhead without
advantage of using larger mappings for executable memory.
 
> Given this constraint, we can probably ship this now and do the rest in a
> follow up set.

Yeah, this is something to think more about :)
 
> For the set
> Acked-by: Song Liu <song@kernel.org>

Thanks!

-- 
Sincerely yours,
Mike.
