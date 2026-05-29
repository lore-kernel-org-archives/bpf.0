Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B402367DF;
	Fri, 29 May 2026 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062659; cv=none; b=GQ2VooVlqeRX2kI6SY6mSEsxtRCXox/mqOe/SvF8UCHfTfyz5jFKJoZ0ARhnwzBZm+deRWjMW93aeK5tdTBJeJp6L0qumWMnG2O69OPjD1WU9vJcFSODHiUkNSQqJ1obqQIb/DJOS+0pTswJzNaeu2Fk5XFvo9awh6eKHGpk9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062659; c=relaxed/simple;
	bh=7+i9Fd5aDPNAYM4ppNK+WMgpBVr6NsfM2RtwMVUGnn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOJYLUjBSCaIt3g2Zs+8QuH5aRN4iw4t+hi1tLWqTdIjQWRfts5BjJSxtvOJZjgfdhguV1PbayCZn58Tmm+w/DofIk9cjWEHqdZ4jAgf1XKfzbHkDp43+DahfReCHwGSJh5Vi7Y5gW1H32/iUFyowoCI7kWTuk4OcSZOTcio5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 08F5568B05; Fri, 29 May 2026 15:50:46 +0200 (CEST)
Date: Fri, 29 May 2026 15:50:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Harry Yoo <harry@kernel.org>,
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
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
Message-ID: <20260529135045.GA10647@lst.de>
References: <20260528093437.2519248-1-hch@lst.de> <20260528093437.2519248-2-hch@lst.de> <5f7f90d8-cb32-4ffb-8f1c-0722aafbe869@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f7f90d8-cb32-4ffb-8f1c-0722aafbe869@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 29, 2026 at 01:54:48PM +0200, Vlastimil Babka (SUSE) wrote:
> Thanks, I applied it to slab/for-7.2/alloc_bulk and merged to slab/for-next
> (it's still yankable in case of issues)
> 
> Did some fixups below (the comment was stale prior to the patch; restored
> unlikely(), simplified one line).
> 
> A test merge into yesterday's -next found a conflict in drivers/gpu/drm/
> panthor/panthor_mmu.c. Commit 1013bf53650e ("drm/panthor: Split
> panthor_vm_prepare_map_op_ctx() to prepare for reclaim") moved the changed
> codeto a new function panthor_vm_op_ctx_prealloc_pts().
> But it's solvable so no need for a complicated coordination I think.

Ok, thanks.  The two Sashiko complains also look like they had merrits,
but I won't get to looking into them until Monday.

Your fixups look good to me.
