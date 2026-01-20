Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09274426EC1
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910825; cv=none; b=NexpHwWFV12UE6saGwZHyDzG/nBCdN1Hbztlf50XghpZJZJb1HIA3F8ZjhJwtj29Txz9oKM0Rc0WBR7d5U6ZbF9Q7vBlkelotyoTskiixxXRfCfIIyrTfeakw/fL/nS6e8M0Ltu+MAfrE45EOp7FZuCCaDDweNTg6osXEtU+V8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910825; c=relaxed/simple;
	bh=MVmlu/hmEOHWdiv/wcYkq4TPcwJdrG2iSYOfoHRcgQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJQz9YvzOrU7KrxtMwpY3KMn+uEjJVIjgWndGSlT4OWPswPoAU6SfnmR9FeTHTIQeh37rx2C+gWNScga4SEMta/7keT6ql+UOe89jy4MogFNBf3AmLcWxUCtKfUa4QTxMWO12QBZ18pPIO2MPo6zzY5EIBhcahVmlNRLXoG2HwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B3tfj/CD; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B3tfj/CD"
Date: Tue, 20 Jan 2026 20:06:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768910810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESCIkjisjdBoNxNmZSiugnc2ar1AP8Qe4a9WPcWHEQg=;
	b=B3tfj/CD7ml1wwxDHlSdZGI2fMeAG9dEZeL8ElH3c2JbaLRx9ONJKwKUhiNLU0mpx9IPvr
	1JbmxoMW4dMfazWRtJdpKfA/nGUJN7HkWBFmdVUVANTaGNaEzHrowcbvenSZXtPDrzmh8t
	H9PVU7umQJM8dUNl9IkMFI2cLvTkX44=
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
Subject: Re: [PATCH v3 14/21] slab: simplify kmalloc_nolock()
Message-ID: <2tvnelafuozzzfyvmxvflqmx2sepgy7ottnw4n2trkh33rrk6b@oewlapq3smvg>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-14-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-14-5595cb000772@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 03:40:34PM +0100, Vlastimil Babka wrote:
> The kmalloc_nolock() implementation has several complications and
> restrictions due to SLUB's cpu slab locking, lockless fastpath and
> PREEMPT_RT differences. With cpu slab usage removed, we can simplify
> things:
> 
> - relax the PREEMPT_RT context checks as they were before commit
>   a4ae75d1b6a2 ("slab: fix kmalloc_nolock() context check for
>   PREEMPT_RT") and also reference the explanation comment in the page
>   allocator
> 
> - the local_lock_cpu_slab() macros became unused, remove them
> 
> - we no longer need to set up lockdep classes on PREEMPT_RT
> 
> - we no longer need to annotate ___slab_alloc as NOKPROBE_SYMBOL
>   since there's no lockless cpu freelist manipulation anymore
> 
> - __slab_alloc_node() can be called from kmalloc_nolock_noprof()
>   unconditionally. It can also no longer return EBUSY. But trylock
>   failures can still happen so retry with the larger bucket if the
>   allocation fails for any reason.
> 
> Note that we still need __CMPXCHG_DOUBLE, because while it was removed
> we don't use cmpxchg16b on cpu freelist anymore, we still use it on
> slab freelist, and the alternative is slab_lock() which can be
> interrupted by a nmi. Clarify the comment to mention it specifically.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h |   1 -
>  mm/slub.c | 144 +++++++++++++-------------------------------------------------
>  2 files changed, 29 insertions(+), 116 deletions(-)
> 

Looks good to me.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
