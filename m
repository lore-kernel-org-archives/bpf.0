Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE226ED3C;
	Wed, 27 May 2026 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884418; cv=none; b=DdtT9P8x000GLIgdHC29ue7B1VrJEwwnlPqIHXF5CBQSHv4NQqSCKeWXRAMhwi4WUSdpsqXBLzYJvGEW1M2f5ANwcXcnGrTB3kEsyXN+/tgsQwLDHQPebuFlDJMw8zLqUh9bPS3csQ0i0BnPsRVo6wvI3viirjp7F37LMd+FmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884418; c=relaxed/simple;
	bh=xTXKX/qTlg5b5HNDHvmaUjULBzl9mUn07rxWI0AlDEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqCsbyvLs+88qk6HVYn7An5rYqQgjI/0W9lA8zb0Pve3hvsR0RB3hN5FF8Q4HcKejUbnujbuRdOsoaKGun+08jixq93Vs65gYRwGVWY6EgKx8WTpiv1DI2LeUNjzLgj3bh+PCaNQp+KI2FiRYCoRJf7yOOCU1rLNVMDujm0x2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F307A68B05; Wed, 27 May 2026 14:20:13 +0200 (CEST)
Date: Wed, 27 May 2026 14:20:13 +0200
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
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
Message-ID: <20260527122013.GA6765@lst.de>
References: <20260527070239.2252948-1-hch@lst.de> <20260527070239.2252948-2-hch@lst.de> <f7f35169-f77d-4678-8797-a2ad00d89e6c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f35169-f77d-4678-8797-a2ad00d89e6c@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 27, 2026 at 11:38:21AM +0200, Vlastimil Babka (SUSE) wrote:
> On 5/27/26 09:02, Christoph Hellwig wrote:
> > The kmem_cache_alloc_bulk return value is weird.  It returns the number
> > of allocated objects, but that must always be 0 or the requested number
> > based on the implementations and the handling in the callers, but that
> > assumption is not actually documented anywhere, which confuses automated
> > review tools.
> > 
> > Fix this by returning a bool if the allocation succeeded and adding a
> > kerneldoc comment explaining the API.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Would 0 / -ENOMEM be more like what people would expect? I guess both that
> and bool are better than the current API.

I find an errno return where the API could not return anything but the
specific error code a bit odd.  But even that would be a lot better
than the current version.
