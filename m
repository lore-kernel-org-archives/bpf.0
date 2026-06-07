Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E074071C8;
	Sun,  7 Jun 2026 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780864291; cv=none; b=UiSYD204ztTRkHJ8GuovxX81fIuawsMP71Jd7O01P07en4tS6f7ZCaqktCEtY6b3JlUL0Nm6BY8+GB3hNRBSZW3BTnAZaHqhtdgTlmSdi/V9iUElMiyL2NdOg/eH2QkctJPPIGZoVPoDWudjDAOi3ErX1AX7lfYtwW715iARt+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780864291; c=relaxed/simple;
	bh=vedSbHWVWJe0Ke5/QRNqJHVEboPffZIfJ0Z8nUsS+W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBOiA6GcT+ylB0f45rDKFNhiQLQCGRqz2F1y+PZ91DivZ87VWMwDqs4bfFF881sLwRb0QnjTloJITHE4t947zrgxCdqOXQkzWVqpc0Gc1b6Xb1hWwhLsn3ldaZFRsTsUj/Moq760vgBBhus9g7Vv7cH6kcDGOFot6l+SXcIvsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tUnZicFS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tUnZicFS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CF252923;
	Sun,  7 Jun 2026 13:31:18 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA9893F632;
	Sun,  7 Jun 2026 13:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780864283; bh=vedSbHWVWJe0Ke5/QRNqJHVEboPffZIfJ0Z8nUsS+W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUnZicFS6DDHwNp7DB2mtYFmNTdq4Tex2cDVTJRe/IxGJoy1g3goY3hNlCLRaWfIc
	 zl3fvjq3Duh1oUMdlU3D1WJbGPFMB1sv7OryckcWhUBYTL22ot8PfWqXCKv+AbDVo4
	 CBpGXbIjmoScDJVn8NQnl0jwiy7Ex5RIv+iuWHO4=
Date: Sun, 7 Jun 2026 21:31:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Tejun Heo <tj@kernel.org>
Cc: bot+bpf-ci@kernel.org, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, david@kernel.org,
	arighi@nvidia.com, memxor@gmail.com, akpm@linux-foundation.org,
	rppt@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, emil@etsalapatis.com, void@manifault.com,
	changwoo@igalia.com, clm@meta.com, ihor.solodrai@linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] arm64: mm: Complete the PTE store in
 ptep_try_set()
Message-ID: <aiXVFK_qb54is8b1@arm.com>
References: <088f52fd25860ca961449d53f91b214a@kernel.org>
 <5f68f44310d4878185fd5ebc52d66530b99f174c6d04ab1170dc53cefaa54568@mail.kernel.org>
 <1780862659.ccb18e27e916dc4b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1780862659.ccb18e27e916dc4b@kernel.org>

On Sun, Jun 07, 2026 at 10:04:19AM -1000, Tejun Heo wrote:
> > Can this path actually loop, or is the deferred barrier guaranteed to be
> > flushed before the faulting instruction is retried?
> 
> I don't know the arm64 paths well enough to say. What I can see is that
> ptep_try_set() only runs as an apply_to_page_range() callback, and
> apply_to_pte_range() brackets it with lazy_mmu_mode_enable()/disable(), with
> the disable() flushing TIF_LAZY_MMU_PENDING before returning. The barriers
> would land before the access is retried. It also looks like the same
> queue_pte_barriers() path __set_pte() already uses. I'd defer to Catalin and
> the arm64 folks on whether that actually closes the case.

I don't fully understand the BPF parts but I think the bots have a
point. If a BPF kprobe fires while we are in lazy mmu mode,
__set_pte_complete() will defer issuing the barriers.

I think better to just call emit_pte_barriers() directly. If
ptep_try_set() is always called with valid kernel ptes, we can skip the
if (pte_valid_not_user()) check as well (which was just an optimisation
anyway).

-- 
Catalin
