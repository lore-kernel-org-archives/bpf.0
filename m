Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE84223DCE;
	Sun, 14 Jun 2026 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429292; cv=none; b=FWKB/wIAeVt7gKjdf6jS0IM77sSF1cBwtyHltZB30padYTFm7U1Ek2yaqEbZCXSxsI7tuSj2xFQbVqbs4I8LcuBa5z6kowh6xC+mrD0U8Vy8D+3HMoMeTb1SIcEnEINC7zPYjy1vecEZg6rDfMI+HLXPwnXtm8vkgpIOq2bly2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429292; c=relaxed/simple;
	bh=GpPQ3docgMb22yHIzcozt2L2TGKSOPXivVbz7SzHfec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYNSswftLrPbHwvv7WESofPAwZ5h3RN0+NzQG6F3yo21l5/0YOiseJ/wYg1homLKO23XStcYT11+kpccIh2OAn+qoKzOtoPRwOK1f1H8qDJ8SwANRQ59BiOvR7Ak4icfJaPuEhj3aHqOSPFpBVBoXRM7hhRWQkWkhsT+qsQ9GQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuvD5wtl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuvD5wtl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7E91F000E9;
	Sun, 14 Jun 2026 09:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781429290;
	bh=IJeMLnJVlGg+3yFfYY8ewvq+lahUXEA89ZCMNVqQriI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LuvD5wtlvmMDVWxQCRAKGP5Fk5Ua91zWTtmgGiEjyZl0naJm7QD2bq1IQErR3g4kx
	 5g1lq7n1S4JCN4MRC6H+pQfs6eWEWioGavXdi6/0+bma0C5rW5da6/fu/4xwuJvgKe
	 HzrTO4ttBCMkPgmdrFGCy/9oPvg6teWpN+L63Kw6eKG2HVCgK98SQ+ophIaIHfzCGU
	 iqfBrIBYurBTrCX4cmqNgI4Boz6FhWb39R+bblyb+UeqldQesf5cc1GFb79FuOhPzP
	 /+UhXK5vXox6n9KKV/D05ZUh267keaN2trcOykJqJLq99QW2h1NuPfnmYaqWvYKGCV
	 0pIzPn9odMx9w==
Date: Sun, 14 Jun 2026 10:28:02 +0100
From: Will Deacon <will@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: Add ptep_try_set() for lockless empty-slot
 installs
Message-ID: <ai50IpfcvBiTZ7Ss@willie-the-truck>
References: <20260522172219.1423324-1-tj@kernel.org>
 <20260522172219.1423324-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522172219.1423324-2-tj@kernel.org>

On Fri, May 22, 2026 at 07:22:12AM -1000, Tejun Heo wrote:
> Add ptep_try_set(ptep, new_pte): atomically set *ptep to new_pte iff it is
> currently pte_none(). Returns true on success, false if the slot was already
> populated or the arch has no implementation.
> 
> The intended caller is the upcoming bpf_arena kernel-side fault recovery
> path. The install runs from a page fault that can be nested under locks
> held by the faulting kernel caller (e.g. a BPF program holding
> raw_res_spin_lock_irqsave on its arena's spinlock), so trylock-and-retry
> would A-A deadlock. Lock-free cmpxchg is the only viable option, which
> constrains this helper to special kernel page tables where concurrent
> writers cooperate via atomic accessors.
> 
> The generic version in <linux/pgtable.h> returns false. x86 and arm64
> override with try_cmpxchg-based implementations on the underlying pteval.
> Other architectures get the false stub - the callers there already fall
> through to oops.
> 
> v2: Rename to ptep_try_set(). Tighten kerneldoc. (David, Alexei)
> v3: Note that strict-zero cmpxchg is narrower than pte_none(). (Andrea)
> 
> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Cc: David Hildenbrand <david@kernel.org>
> ---
>  arch/arm64/include/asm/pgtable.h | 12 ++++++++++++
>  arch/x86/include/asm/pgtable.h   | 12 ++++++++++++
>  include/linux/pgtable.h          | 25 +++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 9029b81ccbe8..28bada97d443 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1830,6 +1830,18 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  	return __ptep_get_and_clear(mm, addr, ptep);
>  }
>  
> +/*
> + * Note: strictly-zero compare is narrower than pte_none(), but the gap is
> + * harmless: a fresh kernel PTE has no software bits set.
> + */

This comment really confused me :/

What is a "fresh" kernel PTE and why do you specifically call out "software
bits" if the CAS requires all 64 bits to be 0? Why is that narrower than
pte_none() given that pte_none() for arm64 is:

#define pte_none(pte)           (!pte_val(pte))

Will
