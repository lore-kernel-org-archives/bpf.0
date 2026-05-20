Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8931AA9B;
	Wed, 20 May 2026 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320866; cv=none; b=WfVYtoUqX66RRyoT9TJBt4qUzZVngB00Z7OXUdpRUTGhMcoj/Ld3B+UPH955L82UL5AqoJenBegHS0qVOsAPdzJoLtGwBIplpNY286rOe4A5bfQGdYkvBLzFGkAiWyv13qZNdLB34E0yANAa+7Pn+6TWPy9TQQzqgKKaNL7lbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320866; c=relaxed/simple;
	bh=VqdUhxQRHfKc2fYQUeGieNHRoLL+vlXd4MzpyPnbOnc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=VfJ5yPqpuYFwHfCHclp38rVkgA9bGvOWPV9abDnnEg1ITjL3HfFy4c02UexqjrTaCHJd6zqF62z7dOhyBpinAV05p+n391YlRumy8YS8pN7TlPep5dy/Rj903PHJspbbxmO0jqmpXN00wRNuQpSnkfAzdHQAb4XSX3UVvd98+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCfZVT5i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCfZVT5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2081F00A39;
	Wed, 20 May 2026 23:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320853;
	bh=VqdUhxQRHfKc2fYQUeGieNHRoLL+vlXd4MzpyPnbOnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GCfZVT5iBwTSlw1drAnQSELAuPQwkctGKQNFw1NbcFq6SBdMsZGCLPhwT2W47gHks
	 cDXQGOfTuCpOFeWIDO5aHSNt+zM0B3R0wvRot5jCZ/VWwV1I/T2K/9dguvz+JcMQl0
	 pD2MNtdMF4ps/3nfkuzmYRGeAExG6A5+AAt3qYb27khyYGuWR3kNXstvWYD8PuOmlx
	 fE85ErDNWg1KohaQpt1/fKjNC/0QuK9kzppfpYd2lc2b8ifhganknb2H4Sw25SvlK4
	 x/5iCHiArTnGiXX97nQdiSJlkTYt1htEXl+YtLH8Ycnomv4wC7phNNQNTOLAl+IbQX
	 EqGjZ8xh7CPqQ==
Date: Wed, 20 May 2026 13:47:32 -1000
Message-ID: <eaeb316b7a45956ed5f335050e6e9538@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] sched_ext: Sub-allocator over kernel-claimed BPF arena pages
In-Reply-To: <DIM6W7GRZK2N.14AH43S1XTFCG@gmail.com>
References: <20260517211232.1670594-1-tj@kernel.org>
 <20260517211232.1670594-8-tj@kernel.org>
 <20260518072042.GP3102624@noisy.programming.kicks-ass.net>
 <agtt2dEjS4Qg7a_P@slm.duckdns.org>
 <DIM6W7GRZK2N.14AH43S1XTFCG@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

On Mon, May 18, 2026 at 04:26:11PM -0700, Alexei Starovoitov wrote:
> Well, this gen_pool based allocator of arena memory is a temporary hack.
> It's ok for rare allocation like in this at scx init time, but not suitable
> for active arena management. We don't need to expose it beyond scx.

I see. Peter, as Alexei is already prototyping a slab-based arena
allocator, how about keeping the gen_pool layer scx-local for now? Once
the proper allocator lands, scx can switch to it and the custom piece
goes away.

Thanks.

--
tejun
