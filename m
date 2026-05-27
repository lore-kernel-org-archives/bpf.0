Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00C3E5596;
	Wed, 27 May 2026 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884512; cv=none; b=DhbiWV7hRNPOQI+iI5jZUPbb6txFVXcW85a+pQ68NpwILuWDQdwKPom2BQpJD6bexg0FFF1w6UwH79A++j5jHMOkYgLntczhnoHThpBVPelvVShdN+LRcu4UIkWnS/dCEYss4Xy2vwUVAFhFj1UEsAvqTQMelUYRKCHgb0bZIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884512; c=relaxed/simple;
	bh=J+ZnLy/9G+pJ8wHavzj3Dl55mP+QyCB7v2erG5OZu6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRS0rzIzwRpy4UJDrAXbx4XuZXtp37yeIJQX0roNXZRFMhbNBqdmIfDWEebtkeUh+ri1T6wPgHrRR6Ax+8wdr0iuCLLgDTFcocnrPlJ9s8tcL4+r+RHJKHHWEVACzMfNB4zKAofHwKzHvnPgBUOpFo8S9CNQbIfGLSKiFmAMPa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EDFD668BEB; Wed, 27 May 2026 14:21:48 +0200 (CEST)
Date: Wed, 27 May 2026 14:21:48 +0200
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
Message-ID: <20260527122148.GA6838@lst.de>
References: <20260527070239.2252948-1-hch@lst.de> <ee817070-cc7a-40d5-92a4-2bd8e9e65fbe@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee817070-cc7a-40d5-92a4-2bd8e9e65fbe@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 27, 2026 at 11:11:31AM +0200, Vlastimil Babka (SUSE) wrote:
> > value convention.  Fix that and add documentation.
> > 
> > Note that the few comments explaining it mention that the gfp flags
> > must allow "spinning".  That's not really a term used in the memory
> > allocator, is this supposed to mean "block" or "sleep"?
> 
> Page allocator now has alloc_pages_nolock() for when no spinning is
> possible, and it uses ALLOC_TRYLOCK internally.
> 
> Slab has kmalloc_nolock() relying on that when it needs new pages.

The comment long predates that, and it isn't expressed using gfp flags,
but by requiring separate functions so I somehow doubt that was meant.
But I could also not see why it would not support GFP_ATOMIC /
GFP_NOWAIT allocation, so I might just be confused.
