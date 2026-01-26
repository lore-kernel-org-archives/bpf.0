Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357042550D7
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408056; cv=none; b=kBhp3TS3Xnu0AeB4VNZhY7a6iQiSwppE/y6t0ZCFVZR5dBLjzRK9bM2k3NTLOJE7KhGj+byU7EWMd/ZnJjO+xOm/+XxS6cjaVkRQx6bm4vl6vvClLkFr8V2xjy5KB8/O+WWbIf+NGTouUPn1CSIf++HDJ/d2bhjE6bZATVud+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408056; c=relaxed/simple;
	bh=v2NEwIUksdnOFxX0GH1tRRbz2NTaKdBLX86HppfXIxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLGpqx19N0b1LGWgWLFffZwcEoWRhdHG79QHB/ssiUlKDSXmX1S5U/YuVMU+488DH5bexq3AuNR0V3vM4JNRO9/M8BzzkbxXMcp9jPnvFinUOeX9q442mo0AK2abQMLR1HP2NH2FlQuitfxJW8j68XnmlJZprdh1m8jt5VYx9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pmKuYWar; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pmKuYWar"
Date: Mon, 26 Jan 2026 14:13:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769408042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fRkLP4BJZeXuj/pQ6WlXqQb5hFaywSSeMSj8bpxWqBU=;
	b=pmKuYWarxQVGBmbrGyx+AIbSk7QyLVpDVeYsyHv71m/qtrh+9UwB0Q44cC21P4FGhUyW9H
	uEE9U9BQ67bvF03/yRwaeGlBmpOEVdX9UFKDAwiaFU8e7PVcG3e4N0/jWVF221cNf11SsV
	scA6aa3AZfL4OecVK1El6ZGfRc+HDa4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 07/22] slab: introduce percpu sheaves bootstrap
Message-ID: <qrekwm7js5t4kmahu3toqnrepnvk7ve5h624f6hm262mmybvtx@rewwd4rbvf3b>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-7-041323d506f7@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-sheaves-for-all-v4-7-041323d506f7@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 23, 2026 at 07:52:45AM +0100, Vlastimil Babka wrote:
> Until now, kmem_cache->cpu_sheaves was !NULL only for caches with
> sheaves enabled. Since we want to enable them for almost all caches,
> it's suboptimal to test the pointer in the fast paths, so instead
> allocate it for all caches in do_kmem_cache_create(). Instead of testing
> the cpu_sheaves pointer to recognize caches (yet) without sheaves, test
> kmem_cache->sheaf_capacity for being 0, where needed, using a new
> cache_has_sheaves() helper.
> 
> However, for the fast paths sake we also assume that the main sheaf
> always exists (pcs->main is !NULL), and during bootstrap we cannot
> allocate sheaves yet.
> 
> Solve this by introducing a single static bootstrap_sheaf that's
> assigned as pcs->main during bootstrap. It has a size of 0, so during
> allocations, the fast path will find it's empty. Since the size of 0
> matches sheaf_capacity of 0, the freeing fast paths will find it's
> "full". In the slow path handlers, we use cache_has_sheaves() to
> recognize that the cache doesn't (yet) have real sheaves, and fall back.
> Thus sharing the single bootstrap sheaf like this for multiple caches
> and cpus is safe.
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h        |  12 ++++++
>  mm/slab_common.c |   2 +-
>  mm/slub.c        | 123 ++++++++++++++++++++++++++++++++++++-------------------
>  3 files changed, 95 insertions(+), 42 deletions(-)

Tiny consistency nit: in kfree_rcu_sheaf(), there's a remaining "if
(s->cpu_sheaves)" that could be replaced with "if (cache_has_sheaves(s))" for
consistency. It's trivial, so no need to respin - happy to have it addressed
opportunistically.

The rest looks great to me!

Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
