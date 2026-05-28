Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2E39E16B;
	Thu, 28 May 2026 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959116; cv=none; b=p6K/Ibp4txRoAeITXZQoOMr1YN7AeCzBdfAINFTJ8nkWFRz0Z8zjlxm6/m/YHIJnoXPtbVW84GvlzGVwlrtG34PIbn4YD8GUym3tk2b9RmBUxqR2E4yQ5OLySwRiLdu4Bj+omrhcXHrWkEahm0oAehAfugQHwpNW7y+rw8y+CiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959116; c=relaxed/simple;
	bh=Wgj1AFhm7MQ7HhTqX39oI5eoayqlItDzxkQczK2qw/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvgCSXLYDkJIWT0PhBMlaVltF09MWbrosStrVdAHNer8D914QZNTv21t6Ax1v0OjQxtdGnrXmrcqcktziYdXcgkp5l3DcH3p7MKDCMAphYba5f9QaEOzY3o1srus3PHI/ec5RtLMuJCXiJz/RygInKm+OGB4DbbL7IgakapxafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 454E468B05; Thu, 28 May 2026 11:05:09 +0200 (CEST)
Date: Thu, 28 May 2026 11:05:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, io-uring@vger.kernel.org,
	kasan-dev@googlegroups.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: improve the kmem_cache_alloc_bulk API
Message-ID: <20260528090508.GB8376@lst.de>
References: <20260527070239.2252948-1-hch@lst.de> <ee817070-cc7a-40d5-92a4-2bd8e9e65fbe@kernel.org> <20260527122148.GA6838@lst.de> <482ee03a-c5b3-4873-a550-cc5743068616@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482ee03a-c5b3-4873-a550-cc5743068616@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 27, 2026 at 04:07:12PM +0200, Vlastimil Babka (SUSE) wrote:
> commit 46dea1744498 ("slab: refill sheaves from all nodes") from this January.
> Previously it was just interrupts enabled.
> 
> > but by requiring separate functions so I somehow doubt that was meant.
> 
> Yeah, it's expressed by the _nolock variants. But slab propagates it internally
> by the gfp flags, and since 46dea1744498 it affects kmem_cache_alloc_bulk().

So what are the GFP flags that affect spinning?  I can't find anything
related to that in either Documentation/core-api/memory-allocation.rst or
include/linux/gfp_types.h.

