Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7137C3672A2;
	Thu, 21 May 2026 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384151; cv=none; b=LZ3+QG3s7f7rx+a4GGHtnDftk3rU/rL+DFdpHW2Txp5IthKBIyl2I29UvLuYkv0qxnpCNUoNZR9ttHvQlfQbPiNhq/gW5bpMgLM6rah/TE3AWwD+nlHrfg79mcNQDxSVWwDi9T+CeLn4NnXpBNXkDCBZfHFO/T085+Pbih+77cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384151; c=relaxed/simple;
	bh=v2oFfrUiqBV/J3K2XNk+DTAsOAiWQoC5gEnTMyA3N7k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=s/gJ/xgevlCxJC14y5eLptVjMk4yfZCXg0VKUMQWNzrfeoAod5FdrpIqyK82+GYErfaknCAZeFSCLN6ZFA8o8PC5NdqpaEUCoxDMyCDhpY8kELBZtengGi2RLmzKQSipcPrtLirbfKdzvaKT39NCLvxUZhADCpeYdfEWgyHSKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKJIuj4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKJIuj4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29FD1F000E9;
	Thu, 21 May 2026 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779384150;
	bh=AlzKy8zLiXVW3OOWreCz0uBaIrjhWNSN2snhmHYvFec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RKJIuj4G6CxC3qvs89BfWMbcUoDSq208cSVcu+n+piDs6pYGX3tDnKJJp+wyEpHQI
	 zfUxFkRf6rqU3CJqN1pP6wxooh9U3NjM+1ynKMmwDjMJ2wuEhEaWjBQRv2GCiudUKk
	 tJuHFTXznYMDXkaP/pjJvyWq1OAXTOoYM2k/2JCDJC1pTk8+4K8wfZ7e7rZAUC7nRn
	 QnMWl0LV1raXD5Fb2tTHOkjsG8/RXyC7x1eS47hWpdOdJc3MnWfetSleiaOD6JugM7
	 BJE5HlqjmfJDsh8jjAnbWtXKeRzJcN3q9opWMQRnDTlT+jVbgUCD1I3eFZAWBMIFmy
	 6+n2MkU4nQvrA==
Date: Thu, 21 May 2026 07:22:29 -1000
Message-ID: <0ea50f62b8255cc0ff1a96206096746a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <ag66lfvACAEAI9w8@gpd4>
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-8-tj@kernel.org>
 <ag66lfvACAEAI9w8@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

On Thu, May 21, 2026 at 09:56:05AM +0200, Andrea Righi wrote:
> IIUC, since @page_cnt is sized to cover @size and the new chunk is added empty
> to the pool, gen_pool_alloc() here should always succeed. Should we do:
>
>   if (WARN_ON_ONCE(!kern_va))
>       return NULL;
>
> to catch potential logical bugs / future concurrency / exotic configurations?

Good point. It works for a single caller, but a concurrent one could drain
the new chunk between grow and retry. I'll switch it to a loop.

Thanks.

--
tejun
