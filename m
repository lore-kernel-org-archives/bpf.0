Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E20421A09;
	Fri, 29 May 2026 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080249; cv=none; b=nvClOGO2ooKsba+ORq+QONTzMX/XYLBlvtf16YCks4psbNqsHexPod4DIjVm7ZlT5XIVcQzandGDXAg74YnjYWP3vT076T9TF0dH1CE08fHPSbd+Ei87n3GbGzgXWp978jQ28QR/pD+1MnFT4C78vJTSCaNwChySs9sfJGyi8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080249; c=relaxed/simple;
	bh=lB4UHwwKsjEktKbsiosmb+A5JY/1UUjZeTWNw5g5k8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxE8ckovPzFbWbsMKo9ufDa+SSJbK52OyJAu9lN2uiQvb3ITNYUcjTlmr6WCCcqByjymqIsmeqRfopyTDtVChXdhzIGQIWrtTBOHCqWeB/qH3wfBWKlxAq8L3Ph/GwU/HJab62k0SF/kppKuDs80KsYVUcZkR76dC5AJGK8BfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO85kgeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO85kgeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842341F00893;
	Fri, 29 May 2026 18:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780080246;
	bh=ZwpO+pOOZTWBchQdW/Dv7jGhsKusDPQYZ/nVee/aPKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BO85kgePRyguLqXdsSmYSPPbc2M9M1R9D7u7yNKftG8vO83z5DOcpC1hVIDZvumcT
	 QWxKTrqcHbY4mwtZyZS6Ri4wQ8M2wE5vozWmFRthBrdQTSjixI1eNMVZe401kMXp9x
	 VKQXxqMh1mY8BQveioCajwIz3qEgPD3Wz7WFV799FuuXrDcApB+DKzZxCKjOMBtPc8
	 xHIQ50diUzeyAWDTfME/K/4V9hozcFX8TbJXdud7+hlk9p/n3YoI3H2L1udoyJNVo2
	 5aUAa1AzYtzcKeTBeKIaIbwzo5WR4sOI3s9svJydmcCnk5t2Y6uhwHfkazwN33Ed9k
	 vzcg2+4l1sZBA==
Date: Fri, 29 May 2026 08:44:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
Message-ID: <ahnedQ33ZH8ogjbC@slm.duckdns.org>
References: <20260522172219.1423324-1-tj@kernel.org>
 <20260522172219.1423324-3-tj@kernel.org>
 <7fd673df-22f3-4d70-a779-ea0b878188b3@kernel.org>
 <DIUMP21RASZI.2VNQV45RIL209@gmail.com>
 <3901fe0537edee9d7acdfd91695ead28@kernel.org>
 <CAADnVQJ+CqAszS2sSVu7gSfA_g4oaTR+SWmLNMX3_8c=OdR7NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ+CqAszS2sSVu7gSfA_g4oaTR+SWmLNMX3_8c=OdR7NQ@mail.gmail.com>

Hello,

On Fri, May 29, 2026 at 11:38:21AM -0700, Alexei Starovoitov wrote:
...
> > 1. The racing write. set_pte_at() and the scratch installer's
> > ptep_try_set() hit the same PTE with no common lock. On x86-64 and arm64
> > set_pte_at() is a single atomic store, so it can't tear against the
> > cmpxchg, but a plain store racing a cmpxchg isn't atomic in general.
> > David, is that the worry - an arch where set_pte_at() is split and could
> > tear - or something else?
> >
> > 2. The SEGV. It's a BPF program failure propagating out as a SEGV. Maybe
> > not ideal, but as long as we surface the BPF error properly, it doesn't
> > necessarily seem broken to me.
> 
> returning EBUSY because apply_range_set_cb() hit scratch page
> is SEGV out of arena_vm_fault() and arguably ok-ish,
> but bpf_arena_alloc_pages() returning NULL because scratch page
> was in the range just sucks.
> Earlier bpf prog passed the wrong arena addr to kfunc and triggered
> that scratch page. It broke the contract and kept the pieces,
> so ok-ish too, but overwriting scratch page with proper page
> during bpf_arena_alloc_pages() is imo much better behavior.
> That scratch page will cause all future bpf_arena_alloc_pages() fail as well.
> Hence I prefer that check removed.

Yeah, let's do that. David, would that be enough? Or are you still concerned
about set_pte_at() competing with ptep_try_set()?

Thanks.

-- 
tejun
