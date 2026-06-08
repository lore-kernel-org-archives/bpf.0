Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92233B14A6;
	Mon,  8 Jun 2026 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908219; cv=none; b=LzTLLqFXmfSQ3t+VfhDwHTvIcNvkBFt8Eyf39yS3KDQMYPK+8HPAR3CoKHP3ixQ/QKe7DqVMhp5C7Hyv6POZL1pDP0LAi0vlDudrMM9aezaZhzcItTT9qYQvA9baxXCFA4yW3tvo963AMjfjdJ3//tkVZXQehNj0Fu2o5S22Prw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908219; c=relaxed/simple;
	bh=FjzT5RcBQdDdIEoaNoG32miDcUBIMi1hQyHWzkZszv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmwAUH2++oTVhFMSQGp0fC7tS/Sk8nygFiSfG9RzBvO86mR01nX60Z0u8G0XCmDe7pUg+lBSyqZHNx3c6kyVQPDYeZXdlE3V5qo7TOp7MSSy7htP8FXBphc3Di0FDIypZA4c2wlkMjfFMP7eb8TmAqsh8wu2dBgH4/81Irwvpkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y3K2BCo0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y3K2BCo0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DE1A3290;
	Mon,  8 Jun 2026 01:43:30 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 693C33F99C;
	Mon,  8 Jun 2026 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780908215; bh=FjzT5RcBQdDdIEoaNoG32miDcUBIMi1hQyHWzkZszv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3K2BCo0/UBNqU0k0thuEuhnek8OYAJF79Xh+dFBb16uvJzUHv0//2JXHjFGytIIY
	 ZTcaOYXijTpBDiXvaHTdKouF7fWJCVNNJxmbHGVH4xqTlTynktxZc/o7XT6d1vqF9l
	 2bj0jXSxM/9AaXUe8OGPBioPd65MM7iMjNx4qrig=
Date: Mon, 8 Jun 2026 09:43:29 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Tejun Heo <tj@kernel.org>
Cc: Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next] arm64: mm: Complete the PTE store in
 ptep_try_set()
Message-ID: <aiaAsTnEtwHx9JqE@arm.com>
References: <088f52fd25860ca961449d53f91b214a@kernel.org>
 <5f68f44310d4878185fd5ebc52d66530b99f174c6d04ab1170dc53cefaa54568@mail.kernel.org>
 <1780862659.ccb18e27e916dc4b@kernel.org>
 <aiXVFK_qb54is8b1@arm.com>
 <7f5f7c94601312c1a401fb18998291cc@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f5f7c94601312c1a401fb18998291cc@kernel.org>

On Sun, Jun 07, 2026 at 09:25:47PM -1000, Tejun Heo wrote:
> ptep_try_set() installs a kernel PTE with try_cmpxchg() but, unlike
> __set_pte(), skips the barriers that arm64 requires after writing a valid
> kernel PTE. Without them a subsequent access can fault instead of seeing
> the new mapping.
> 
> Issue them with emit_pte_barriers() rather than __set_pte_complete().
> ptep_try_set() must finish the store before it returns, but
> __set_pte_complete() would defer the barriers when the calling context is in
> lazy MMU mode.
> 
> v2: Emit the barriers directly instead of __set_pte_complete(). (Catalin)

Nit: I'd place this after the --- line.

> Fixes: 258df8fce42f ("mm: Add ptep_try_set() for lockless empty-slot installs")
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Link: https://lore.kernel.org/all/aiRFcz78QTZdIHHB@arm.com/
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  arch/arm64/include/asm/pgtable.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 3ce0f2a6cab6..3e579c26b383 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1838,7 +1838,16 @@ static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
>  {
>  	pteval_t old = 0;
>  
> -	return try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte));
> +	if (!try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte)))
> +		return false;
> +
> +	/*
> +	 * The store must be complete by the time this returns, but the caller
> +	 * may be in lazy MMU mode, where __set_pte_complete() would defer the
> +	 * barriers. Issue them directly.
> +	 */
> +	emit_pte_barriers();
> +	return true;
>  }
>  #define ptep_try_set ptep_try_set

It looks fine now. Thanks!

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
