Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D6471439;
	Wed, 22 Jul 2026 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707562; cv=none; b=alc2QoSDBaRZuCN+tFOqa8EDYGNfKg88QpqLDcdOskjbj5s5LiIDskgWAZ7Z7RdzbakRBsCLRQeza+V++d6kKSAy/R5h9qJ8oqS0SX2G9Ax9J3BPHXXTScAzevkP296onOy2PypiG4B0sFIyNg/nEna/kSghV6cOkE57B2S/jgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707562; c=relaxed/simple;
	bh=u96X09wuufO4dzaJuuvO4LBL+2+DVtt6RM3GbzuEmbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZUVke8L8qBmJJUoemFKBTuvf+3BsPNcqR/vByvHmtDzm53zS1yW6OHHpvgw4Nkwxkr7fbUhsh/VmA8WOUa9noxwKrn/rVQfBZxGktVJwYx074V2hCGnxiiKoPn/jVpnir9xZHeadFKozNTShitmsbXpo1J3vH2OCSjn9lzAebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NygyAUup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NygyAUup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9EB1F000E9;
	Wed, 22 Jul 2026 08:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784707561;
	bh=6Ck9xPPL0TmASgoKbDMyp7CMVHfOp+cb63tWZ/yAXbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NygyAUupeyD40hxfX2KNeaE/qRaUjaDCRqBbxUsqiZCGZOL2wii8u8p1aEFnPzkWS
	 FGYgws55wNwnCX8yuFeDBWI3gVaEwu3b5IpRAfkXBwU8kgJyzpux28jkeZwJppVVrm
	 Z2Rub7DOPzyp+ICs70MXaa2ai1lrh1psgMWeGfic2khqz2in3nCl4X8VUrUXd21txY
	 BbE7RTPpqwjsQ/5C/gg8q3ykVGP/b1WxD+/FdpgOsGpgwqBHJ0470MFRpar1j3vBW0
	 MlmUGRWtnQDtUa6VJRuhEuYRWkeMQKfGdCVlOakm/S1HRejOION9M+hyLgQkPDQSi7
	 aOsl/JVz9DjTA==
Date: Wed, 22 Jul 2026 11:05:47 +0300
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
Message-ID: <amB52yECfXNgbeY4@kernel.org>
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <CAPhsuW5pRMtpa5Q0Y=zO5=2HSj4xOX+i5Vp+g2a6RDvmkeHKFw@mail.gmail.com>
 <alnOkjf8rq3dUGmg@kernel.org>
 <CAPhsuW7xvJM6PPGwkeZJhi+a-emuuX09uxKom29mns5-iwOYXw@mail.gmail.com>
 <aln1_kGygUqdtlAt@kernel.org>
 <CAPhsuW4dt6YdNnce4wfJkVuuP339sh=0wCGwBG2_Nc2BYu4CSQ@mail.gmail.com>
 <alyXjynKnIp7X-3b@kernel.org>
 <CAPhsuW6+6zcSRGUAtp=3e4a8at3yuRP8Xijb-4LBHtQ8Li6wrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6+6zcSRGUAtp=3e4a8at3yuRP8Xijb-4LBHtQ8Li6wrQ@mail.gmail.com>

On Tue, Jul 21, 2026 at 10:59:06AM -0700, Song Liu wrote:
> On Sun, Jul 19, 2026 at 2:23 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > Since commit c82be0be9576 ("mm: vmalloc: don't account for number of nodes
> > > > for HUGE_VMAP allocations") vmalloc_huge() is fine with PMD_SIZE regardless
> > > > of number of nodes.
> > >
> > > Before execmem can handle sub page allocations, how about we
> > > send allocations that are bigger than page size directly to execmem,
> > > and let bpf_prog_pack handle sub page allocations. Then,
> > > BPF_PROG_PACK_SIZE will be PAGE_SIZE. This should be a net
> > > win for x86_64. Other archs will be the same. WDYT?
> >
> > Makes perfect sense to me for x86.
> 
> Can we include this change to this patch set? This will make this
> change a meaningful step towards migrating to EXECMEM.

I'd prefer to leave this as a separate followup. 

The decision whether to use EXECMEM_ROX_CACHE is made at runtime, which
means that BPF_PROG_PACK_SIZE should become a variable, that variable needs
initialization at some point during boot and that in turn requires a new
helper in execmem that will say if EXECMEM_CACHE_ROX is enabled.
 
> > On architectures that support large mappings in the direct map and do not
> > support EXECMEM_CACHE_ROX this will increase direct map fragmentation.
> 
> Architectures that support bpf_prog_pack can benefit from
> EXECMEM_CACHE_ROX. What does it take to also enable
> EXECMEM_CACHE_ROX for them?

For EXECMEM_ROX_CACHE to help in reducing the fragmentation and TLB
pressure an architecture should support collapsing of the split mappings at
least in vmalloc/modules space.

There is an RFC for arm64 to add support for EXECMEM_ROX_CACHE there:

https://lore.kernel.org/all/20260611130144.1385343-1-abarnas@google.com

and it looks like it'll take a couple of iterations :)

I don't how much work it would be for other architectures.
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.
