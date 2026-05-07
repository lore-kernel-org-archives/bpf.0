Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3D38F638
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142398; cv=none; b=hGZ3tcHBoZtJy5C4tJl2aHMfBCXFQpxRlIgHUiVW7yf4GChjr0eKGSn3Sk+MdbnYJ6UAkWlKHnbARvqrNqyVjY7DUbYWKKq5101vOwMzzYGHE4qvRtuUssD7pBtV/dUoSdwJ8z9kKi/YuwY4BnEv4Z6gwr/8d2gmnw5k+SRZE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142398; c=relaxed/simple;
	bh=br1ONutS4Hyzxbt6ODb/PvOrgBa1aQxAx2L6AAnXrTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgHxm4k4C+xqDj9M30MPWhrm52GttEZ/02LtD7wGM7ARAtUVVnhuzAUhWIMynb4VAyMaNo3GWtSy7pMpCNZJ0J2xpykWVRS59YJnN+SazUXcZVlwLP5kpYSvIQnvUrSe8htkQ9Eau3GfWn9UOTTS/4FYrt2JXFgnCrColdaM7bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=O94YWXFw; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="O94YWXFw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=oNU6DKt2fOVaOTCRvzEn9bSNZZ7qLIl1U12tvS6jL9I=; 
	b=O94YWXFwuX7RrrVZzeZweDz56ZN8L3MyqMGi3qkk7TGIHqimu0aKwQBcrnNrO2BPST58OtmoDRD
	IvFXcMGf4+7HqMU5gKXsCIYZuZs4NUBc+FECQgRxoFn+eoWJjUBu55O8ESi99GH02I2k9BkPR96wh
	VtPfucsPbNCj/hs5JzW/llo7CAHB9MJHbmwvHPs0vK6mxJTNDwpnGsDzPrufDT1I5tWLlQTv0dTDw
	dGCmfXEHXlqrWDTwHqstQPjUtGPUXQi/9gpF7J/hFfg/zzr6Z5XSE7RfYZvqwqIm39nNOrGRy4D8N
	IKE5Vgg/alr9QsarxSUp9A4GUbsb7Wt0FEYw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKu3u-00C1A1-30;
	Thu, 07 May 2026 16:26:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 07 May 2026 16:26:26 +0800
Date: Thu, 7 May 2026 16:26:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v3 02/10] rhashtable: Add
 rhashtable_walk_enter_from()
Message-ID: <afxMsrMYRDHZMIa_@gondor.apana.org.au>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
 <20260424-rhash-v3-2-d0fa0ce4379b@meta.com>
 <afCNcFLArNkj7GXh@gondor.apana.org.au>
 <9a83db58-5192-4d12-80f1-2a63ba29def3@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a83db58-5192-4d12-80f1-2a63ba29def3@gmail.com>

On Tue, May 05, 2026 at 05:57:41PM +0100, Mykyta Yatsenko wrote:
>
> We brainstormed with Alexei on how to integrate rhashtable better,
> as a BPF map, we have the next proposal:
> 
> Introduce rhashtable_next_key() API
> ```
> static inline struct rhash_head *rhashtable_next_key(
> 	struct rhashtable *ht, const void *prev_key,
> 	const struct rhashtable_params params);
> ```
> 
> It returns the next element, by finding prev_key in the tbl chain
> and returning the next element in whatever tbl the prev one is.
> This way we keep rhashtable API tight, less surface, not exposing unnecessary
> details, although, this new API will have the same issues with full
> iteration support (which we fine to deal with on userspace side).
> Appreciate if you share your opinion on this.

Can you please show me how this gets used? Basically send me the
patch 03 from your v3 series with this new interface.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
