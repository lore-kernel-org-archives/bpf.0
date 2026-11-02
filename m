Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630983;
	b=wxo2+4ZGi26sTX/3x1VZp+cvcg7lo3IxRMwux8A9pRVm1eAg03uOJ7Y5q5L5wQKpcM/i
	 q6yvbtBJ5BS5gyrZm3+fhFSAVUFYiTNmiU/oZfece/cOZ+dw4O1KbcW4xo++bFdiB0Nx8
	 T1LoWd8hgQ/wEbR+Vlj7JhpXA6SxrnIvdjpWadbbh3Wbcr5cb9iT8IQZs3VL9m784/chh
	 JNjqXelDlyrfcAZnIlEQrfnYTuXPxb8F8e9T4dHdAr346TVm7N31LeV6wz1meP14f9Kg1
	 mDoO/WrbpvzxxKfpO0xkxbLMvwSuKsSQ29bZDDoSNfpWRuJYx0BFt9gyN2b1YMvhKtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630983;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XWoSxjQdMw8UivKHOKImqNiHmJUj5F5WenhpQwDvMLg=;
	b=ZfXkLTDW37OAtOhQMkhTvAs1oQQxqrSZtol/oaMtWZRFhayOERva6/yIrzSem/5q9QcQ
	 2CV1Qy9LBK52kVP23x78qNauzw61sh4PikL3IL+13bv61LeXZ48T7pTb2skY7EoITd6CV
	 Zh4dciBBnHY/NwvB0+2iwWWdvRGnmDqnCB1cvMPZ09WxwjefbrZgLsl8bmk7DyqaGE+6O
	 OwomSSxwuaDOfBaykRIwUDfRIyEjUEQC6NJ13O4WFID0DDtzJsn30+9TKehZbf2uVq6CA
	 ixl8aAyRPe1e2cLDsbpREJro29Sk9pjQFq8JDZTuzu3xHIjcOFBGgj6IHsDAJBUzNeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VovVNp2p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997956072ED3;
	Mon,  2 Nov 2026 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VovVNp2p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7C81F00A1A;
	Mon,  2 Nov 2026 14:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793630983;
	bh=XWoSxjQdMw8UivKHOKImqNiHmJUj5F5WenhpQwDvMLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VovVNp2p/+WUkh+42qpFU37+vJQ1cl+UoTmYTPm1xl7saMJI+Sr6zkDbOCrK4LeN7
	 3tb4Ee551fvubrjMQuUNXkfN8dTq/3+M9DRYdH0ws/q3QUATZQPuXE/731HV4w1Tv2
	 GJZRoccrQPP3c+OzSPa/85YEs8QgAaBoRpK03ACzy4f4XrRIUjTC384+TkVpjZfmHd
	 akciCQCD6Jdhsqj8YYEOseVq5zGkTZVsbwAeNT7gJ3orZStw6qef+FwCbKeiokrUS4
	 IWR1/46X8tRUE5yw2ZhcwAxKviT7O1hbKQJC6To6CIW1Twq9gtmkKXGck9WA6QAheH
	 f+UJyNEqZ48SQ==
Date: Mon, 2 Nov 2026 14:49:40 +0000
From: Harry Yoo <harry@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/slub: Genericize x86-specific cmpxchg16b comment
Message-ID: <auihvtpGJPDbb4Hz@thinkstation>
References: <20261102082730.12430-1-yangtiezhu@loongson.cn>
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
In-Reply-To: <20261102082730.12430-1-yangtiezhu@loongson.cn>

On Mon, Nov 02, 2026 at 04:27:30PM +0800, Tiezhu Yang wrote:
> The kmalloc_nolock() infrastructure relies on slab caches with double-word
> atomic cmpxchg capabilities (__CMPXCHG_DOUBLE). The current inline comment
> in __kmalloc_nolock_noprof() uses 'cmpxchg16b' as the prerequisite hardware
> capability.
> 
> However, "cmpxchg16b" is an x86-specific instruction mnemonic (CX16). On
> modern architectures supported by the Linux kernel, this 128-bit atomic
> primitive is satisfied by different hardware implementations:
>   - arm64: satisfies it via LSE atomics ('casp' instruction)
>   - s390: satisfies it via native 'cdsg' instruction
>   - riscv: satisfies it via ZACAS extension ('amocas.q' instruction)
>   - loongarch: satisfies it via SCQ extension (using an 'll.d'/'sc.q' loop)
> 
> Update the comment to refer to "128-bit atomic cmpxchg" to accurately
> describe the cross-platform hardware invariant needed by the lockless
> allocator, and to avoid misleading developers of non-x86 archs.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  mm/slub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 45e077c7526c..216bc6b5d776 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5589,8 +5589,8 @@ static void *__kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_f
>  	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
>  		/*
>  		 * kmalloc_nolock() is not supported on architectures that
> -		 * don't implement cmpxchg16b and thus need slab_lock()
> -		 * which could be preempted by a nmi.
> +		 * don't implement 128-bit atomic cmpxchg and thus need
> +		 * slab_lock() which could be preempted by a nmi.

maybe "double-width atomic cmpxchg" is more accurate considering
e.g.) x86-32 implements cmpxchg8b?

>  		 * But debug caches don't use that and only rely on
>  		 * kmem_cache_node->list_lock, so kmalloc_nolock() can attempt
>  		 * to allocate from debug caches by
> -- 
> 2.42.0
> 

-- 
Cheers,
Harry / Hyeonggon
