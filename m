Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385202;
	b=H5pR+GKWU4XURoou3GgU56fA7fr7QF5xG2HevW1FqSK9QGtWNOjNDc7N0CF8W48VcaZ3
	 IEvC580vTgIhtWkkWDIrLUf+QXahUK+Y3igqdpb6dXDYhZkHFokTHYqUkD7b9vZ4f3uzh
	 OkSZ1ZBIWCbN5AwrR4FtmCfz4AXpKpSuInSrBepnE62NOFrcOM+9A/9HfcHnp1xQG6GNG
	 aIxRML535xiqGBXJy3sJmweI1dh4630SsB5vi5mu7K83CPsE34x1YSw8HN7nagkJUXMEp
	 tlvzdNaMUYeiEUE2eaIzrK/nYQKCoNOkmPdOBHF56IcFtU4GfLzkI5KJihXNT3HH10Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385202;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=G3d3b2tM519kuIvjkSRexg4H0KkdNZyWkRnjj4rZTd4=;
	b=Jceix/IREydpoETU1z8xm+fYC/IhKceqHuo5YkT2A6s0i/3ak85D6eSxtEqvMP/ckPuY
	 nvn+Mzpz+FrdMZaO/Cq1rS0BqB9xUx5CGPA4QzhPyBTrYiA/tvWY/h/PDBscfkvsmyAA1
	 L26LJm8g05TtDE8rMMCRZr5oh+jNANUs5oB1TkPmio9fXBMXMn30hlt3iS8CzB7kbVTR8
	 0l7Jt3PNoD1gswWmt5d7qeTTEmc6ah6jmIIWjfOTnTgC0cynrAzi8pbEU52mru2EZzWWd
	 G+MP3DeTl/IkCIhAKZw4lKsCHwnrqGzoh6GB1LxQIf6nur5lBclvd0czJ/TINbGfglA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iyOp41w6;
	arc=none smtp.remote-ip=95.215.58.17
Received: from mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67074606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67074606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iyOp41w6
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=01hkxhMvjpH0YwUfWPSVcu2PhKCcNEL9gg0Q0PcG8gI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794385199; v=1; x=1794989999;
 b=iyOp41w6ePFfiABPcVNymqvnRo7CvaC7mYHYLS9IIcdtQDFFSmovUlyn7TOR60F6UJXjYQHx
 HBdMKlOMlV0Fj9OFgH1bcGEq7R3P7yexH45CjSDoP4/BLlil+pzb4rmq/ZUZgqqgEe0v0YN/1Yc
 B25Xx13HT1EETMUH+9zTErRQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2365b7a9a39834f0;
	Wed, 11 Nov 2026 08:19:59 +0000
X-Mizu-Trace-ID: 2365b7a9a39834f0
X-Migadu-Flow: FLOW_OUT
Date: Wed, 11 Nov 2026 16:19:49 +0800
From: Hao Li <hao.li@linux.dev>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/slub: Genericize x86-specific cmpxchg16b comment
Message-ID: <avQkXxpsIdxB5Ye6@fedora>
References: <20261111011108.29311-1-yangtiezhu@loongson.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111011108.29311-1-yangtiezhu@loongson.cn>

On Wed, Nov 11, 2026 at 09:11:08AM +0800, Tiezhu Yang wrote:
> In __kmalloc_nolock_noprof(), update the comment from x86-specific
> "cmpxchg16b" to generic "double-width atomic cmpxchg".
> 
> Suggested-by: Harry Yoo <harry@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> v3:
>   - add missing Suggested-by tag for Harry
>   - use shorter commit message as requested
> 
>  mm/slub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 45e077c7526c..090302f1daeb 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5589,8 +5589,8 @@ static void *__kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_f
>  	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
>  		/*
>  		 * kmalloc_nolock() is not supported on architectures that
> -		 * don't implement cmpxchg16b and thus need slab_lock()
> -		 * which could be preempted by a nmi.
> +		 * don't implement double-width atomic cmpxchg and thus need
> +		 * slab_lock() which could be preempted by a nmi.
>  		 * But debug caches don't use that and only rely on
>  		 * kmem_cache_node->list_lock, so kmalloc_nolock() can attempt
>  		 * to allocate from debug caches by
> -- 
> 2.42.0
> 

Looks good to me.

Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
