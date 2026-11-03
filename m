Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699065;
	b=bkWAYCq0Pbu2VbH+mjxS7GL1GUhfgmq22maJY6zRRJJb0Y0kgQzDw4svUV4wH4Ndgtf9
	 QvgD8/RiJIg6qfnrxoI74BboqsPNDkaYfwCsmFAPhkpd9s8Vq0EqcbHC6g/mXz35lwrx9
	 t4c0B41BXNM+xGldmbtZoIqpmPOULPFjgORrjr2oeqWCpdJf5SUZVcNzWiPCV95/60LL2
	 M3MKvb6a9J9pqEYg41U6UVa/CQh6TULlmSIvFfh5fiCgkmZcQtDA2xFJJi9JwSyv0o9El
	 aj3HwCJ4HWtd7+m10hUJtQlmRMH0PSBLWs1RKooVXez6i2QzfLV7ocROgEvyfuyr4ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699065;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SYguy4w1YM/41pc0M9vIj3VvmIP455ki3qTLrxyk+EI=;
	b=WSHeeHOy4igbl7Hr1Gblvp7mqKOUwWGVoax4cWkVVi1gZBzJiz9bDS41uxcDRkmDiDyj
	 hXVySk+F1CVgjvuYAmTCO9CyefmBhz8xh9O5iW65N+1j9T8wSuzC2Al7V9EdF9D8ypJ1f
	 k4S790tyEeZ5kgsngLTUvZF/Ll62/4UH76jGZG1ZX61Kw4rDgYFzi4YNmVECbB4npVxMi
	 4ymKvwcSDZLbVCuzQOzAqeCtx7TWPUwidZaWG3BGlM9ftL2u6Ny76WXlko3Zw057+tmYt
	 9axYdDr8IeGnRuWu+/RnO4C12ST3pRiV8NmTkYJUytppQVGrHBhHuLedrnRRHGIYHBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="BmFNg/1V";
	arc=none smtp.remote-ip=95.215.58.150
Received: from mta1.migadu.com (out-150.mta1.migadu.com [95.215.58.150])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA366606A32E
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 09:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA366606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BmFNg/1V
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ytP1FYc4mLUgzvNlPS6MBB0Sb8vEqTbsbrXFac19CKg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793699062; v=1; x=1794303862;
 b=BmFNg/1Vfge10nj+Wh9lYq5C/9PkGB0qDq3YYr5sdNjpljWdlY0j4DwQnMwLfGmieJ6B0lBF
 S9F4e0aUUhu7IXV0Yx3QB8prhHsAeDzOfbMJuaR1DyOOLEHw9NP0+3XnPM1+jI+tg/nZYtoehJ6
 DECA8Fa37anyRzIw/yYdBGdE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4fced7d92f6bec66;
	Tue, 03 Nov 2026 09:44:21 +0000
X-Mizu-Trace-ID: 4fced7d92f6bec66
X-Migadu-Flow: FLOW_OUT
Date: Tue, 3 Nov 2026 17:44:13 +0800
From: Hao Li <hao.li@linux.dev>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/slub: Genericize x86-specific cmpxchg16b comment
Message-ID: <aumssHCOA4D_BFm1@fedora>
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

Personally, I feel the commit message is a bit lengthy for a simple
comment-only patch. It might be better to keep it concise and just directly
state the purpose of the change.

-- 
Thanks,
Hao
