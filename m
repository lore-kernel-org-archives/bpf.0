Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DB388883;
	Mon,  1 Jun 2026 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300606; cv=none; b=WBbI+we8Fg5tFa7NOmlyWdFwzS3OLiJ+KTFF/sNH+W003q8Ky78YgbA2Mlohe5wSSJZ1pzq7ewfVY+kP9r9lPZcMGd5p0XEy2yly3ddLGM5rkBD6W7F+T93rdIwbIZORjVUzI+pA9D2JudTcOAEzNKfazWkoDl9yOBkYuFKwxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300606; c=relaxed/simple;
	bh=aAZb7ntFFduYlNTNS2PmpNsOM+DI6UXJG5UmaJIW2vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVqzw0XB9mVQfPehDrEhuLzFFDzqB0fbFpXxueZyglwTwzZFePWJWOIb8SceCaDNiIit2PP5dLw0wZN7/vZSYhpUoDNbsvgrEv2+RW/BGRIUO3fjlos6gsDtpreQaO8FMR9MAt/SPhahiXUkD8+tt1IHWkMyeejtYbsuDCNvW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4037268B05; Mon,  1 Jun 2026 09:56:40 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:56:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Harry Yoo <harry@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, io-uring@vger.kernel.org,
	kasan-dev@googlegroups.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	=?utf-8?Q?=C5=96ob?= Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>
Subject: msm_iommu_pagetable_prealloc_allocate, was: Re: [PATCH] mm/slab:
 improve kmem_cache_alloc_bulk
Message-ID: <20260601075639.GA8193@lst.de>
References: <20260528093437.2519248-1-hch@lst.de> <20260528093437.2519248-2-hch@lst.de> <5f7f90d8-cb32-4ffb-8f1c-0722aafbe869@kernel.org> <20260529135045.GA10647@lst.de> <5f3ba603-a6ad-4cf2-9a54-aebc10273c59@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f3ba603-a6ad-4cf2-9a54-aebc10273c59@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 01, 2026 at 03:39:06PM +0900, Harry Yoo wrote:
> > Ok, thanks.  The two Sashiko complains also look like they had merrits,
> > but I won't get to looking into them until Monday.
> The review:
> https://sashiko.dev/#/patchset/20260528093437.2519248-2-hch%40lst.de
> 
> So there is a user who might call kmem_cache_alloc_bulk() with size = 0
> (although the comment says @size must be larger than 0!) and
> kmem_cache_alloc_bulk() returning 0 was considered a success in that case.
> 
> Either fixing kmem_cache_alloc_bulk() (and the comment) or fixing the
> user sounds fine to me.
> 
> And yeah freeing an object via kfree() allocated via kvmalloc is a bug...

I think the right fix here is to check p->count somewhere in the msm
code and never get here.  And the kfree/kvfree fix of course.

І.e. nothing to change in this patch, but a headsup for the MSM
maintainers.
