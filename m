Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24F92D97AA;
	Sat,  6 Jun 2026 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761986; cv=none; b=R1b3kHXPkvXov6CbzkudvgAG/WSx3rxzJtx9e5tvPiof/V3O88BPjv/Lvms0CBKSghzCdMSoSosbu3BxqHAlsQgED3pVxYNVehaYqrSssnqZbtV7ELjbAmdAS9jnepSplHt5OpkxQdccALKX92YSEhc4Vmto/ULLR/sWk8pCen8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761986; c=relaxed/simple;
	bh=snvrP3iXAE7+rPVGPdv2I0d1O8un1BOK8oUMCKBNj7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDFkozFAD+moAo1fLSJKldV6D95bfM2frpqbETHrT9n/YtrjY/MrQ8J5wgTs7f/2JzIPUAnZ690yTSVzcSufThWFCK/8Kx3x7VcUkqdTBEEWa4fRBMyMrmXcx1yDyNtbOEukwRf4oB+sb5RVhiDxDtoqM/xF/ft8cODJigCD82M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fioo/WXR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Fioo/WXR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE08C4E42;
	Sat,  6 Jun 2026 09:06:11 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A11B3F632;
	Sat,  6 Jun 2026 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780761976; bh=snvrP3iXAE7+rPVGPdv2I0d1O8un1BOK8oUMCKBNj7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fioo/WXR+6E2VeHXtpMTCyYZU27JnoxYA6CB0uRghrHJ5aZZyaaIcZRxJ0aH7JFsW
	 xngkbzIzYdlUW15WY/Z2u7zCjIdmVIrsHgk/6sOUrC+EbqbHreg/CDeoNlbonXt/pY
	 t9S0fleMOnVpzuZZbKKbyRo+Fo9udRji81CSAdsM=
Date: Sat, 6 Jun 2026 17:06:11 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Tejun Heo <tj@kernel.org>
Cc: bot+bpf-ci@kernel.org, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
	peterz@infradead.org, will@kernel.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	akpm@linux-foundation.org, david@kernel.org, rppt@kernel.org,
	emil@etsalapatis.com, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next] bpf: Replace scratch PTE atomically when
 allocating arena pages
Message-ID: <aiRFcz78QTZdIHHB@arm.com>
References: <20260601183728.1800490-1-tj@kernel.org>
 <f45f02410d23c99d14f3577da9b27a327816b5a0904bdeefc8e229eac760d1cf@mail.kernel.org>
 <8f133924fbf8d259340f3057e505f663@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f133924fbf8d259340f3057e505f663@kernel.org>

On Tue, Jun 02, 2026 at 12:09:11PM -1000, Tejun Heo wrote:
> On Mon, Jun 01, 2026 at 08:15:34PM +0000, bot+bpf-ci@kernel.org wrote:
> > After the real page is installed without a flush, can that stale
> > kaddr -> scratch_page translation persist, so that later kernel-side
> > accesses at kaddr reach the shared per-arena scratch page instead of
> > the freshly allocated page?
> 
> It can on x86, but it's harmless: that CPU faulted on an unallocated
> address and got scratch-recovered, so reaching either the scratch or the
> real page is fine. No flush needed.

I think for arm64 it will be slightly different. After making the pte
invalid, we flush the TLBs and subsequent access will be fault. However,
ptep_try_set() is missing __set_pte_complete() with the necessary
barriers. A subsequent access may fault rather than hit the old or the
new page. Something like below, as a fixup for 258df8fce42f ("mm: Add
ptep_try_set() for lockless empty-slot installs"):

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3ce0f2a6cab6..dc8525431273 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1838,7 +1838,11 @@ static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
 {
 	pteval_t old = 0;
 
-	return try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte));
+	if (!try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte)))
+		return false;
+
+	__set_pte_complete(new_pte);
+	return true;
 }
 #define ptep_try_set ptep_try_set
 

-- 
Catalin
