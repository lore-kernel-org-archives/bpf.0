Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA53A0B3B;
	Thu,  9 Jul 2026 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584222; cv=none; b=aOH9M+EqC7LTKCqJBognDJypIAMB5I5jzvtuOUO5g4RDs/2iLAgxjMr19/+EYEgvGj6PdIxaz3OaGbnzElsoYhtpp1KqGHYnndiWhTmk6jfUnco+ZtAecPTLFk8rq5OQItkacLUGjzESwamV5a6ocSdfacoGl5CKkxCSDCF2Znw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584222; c=relaxed/simple;
	bh=2j+GQrEsmpVM5zmmaRQe6uY9KuXEMkO+LjBNCttCGOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APIyhrzmXHmHBlpPNIg2SAG828Y5YGaY4FRxFpnEoo4mmkunQsztI3aGc6FaDB5KhA2liVI7xJ8s2Bbo+LxBCt0vuFpvp9wvcN/E/W3iCPiNn5Arkk608Ondsk5CCpKVqMqgSDh2rbUYxptj28/VAmkvO4LEkoPD/S13ot/N214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4E37u/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4E37u/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6CB1F000E9;
	Thu,  9 Jul 2026 08:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783584220;
	bh=9tetKMDD9MEjR8+3VbwnlIcq5PeiPAYUmSMxBSBWKMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C4E37u/dEStL09kYvkgw++nswEEcd0QFE7+evk9fHjGPCCjXkLVRMPCU9B6sr31Y5
	 apVkqENe9puMhx/GMH5MlB8dOX5sQwQULyvcoVqlxuWZMf701lmR4fh5CvSqQxbkrP
	 JDcff/QNj8zq91WOEgMjt33gCaacxcf738Z26Wl6wi/x2JfGJel35mMhz2JFnaLai1
	 T6ymw+XIYb+L2bHJ+gUSNUnIJ3fwtjZclMlygKti+rhaFlA/1mLLcPgBbxH58tZUwG
	 to4rftYSuHll+Gth7pVJ2L5jIR0pg5TyOKY6PBfRexWx5vAPwfKmZMwXNH/BvBj/jy
	 RiO5lOBNSIFcg==
Date: Thu, 9 Jul 2026 11:03:32 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH bpf-next 0/5] bpf, x86: enable EXECMEM_ROX_CACHE for BPF
 allocations
Message-ID: <ak9V1C-Y3x-KEcTW@kernel.org>
References: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>

Gentle ping

On Fri, Jun 26, 2026 at 09:42:27PM +0300, Mike Rapoport (Microsoft) wrote:
> Hi,
> 
> BPF allocations of executable memory on x86 are essentially read-only. Most
> paths that call bpf_jit_alloc_exec() immediately make it ROX with
> set_memory_rox().
> 
> The code generation, at least on x86, uses separately allocated writable
> buffers and then updates the actual text memory with text_poke().
> 
> These patches do several small adjustments to how BPF allocates executable
> memory and enable EXECMEM_ROX_CACHE for BPF allocations on x86.
> 
> ---
> Mike Rapoport (Microsoft) (5):
>       bpf: dispatcher: allocate bpf_dispatcher->rw_image with vmalloc()
>       bpf: drop __weak from bpf_jit_alloc_exec() and bpf_jit_free_exec()
>       bpf: alloc_prog_pack(): skip ROX management for already ROX memory
>       bpf, x86: make sure allocation in arch_bpf_trampoline_size() is writable
>       x86/bpf: enable EXECMEM_ROX_CACHE for BPF allocations
> 
>  arch/x86/mm/init.c          |  4 ++--
>  arch/x86/net/bpf_jit_comp.c |  5 ++---
>  include/linux/filter.h      |  1 +
>  kernel/bpf/core.c           | 30 +++++++++++++++++++++---------
>  kernel/bpf/dispatcher.c     |  5 ++++-
>  5 files changed, 30 insertions(+), 15 deletions(-)
> ---
> base-commit: 53435562a725962e4de0c29653223129ba11643a
> change-id: 20260626-execmem-x86-rox-bpf-v0-b4241ade80df
> 
> Best regards,
> --  
> Sincerely yours,
> Mike.
> 

-- 
Sincerely yours,
Mike.
