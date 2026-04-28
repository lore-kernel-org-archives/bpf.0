Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B73225A38
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372435; cv=none; b=dWa2eoPOG/RM5AT+njXYkkFpO3zbp8cu1weVIm+fLLvjEyKEaEdGXmyB04f2tvLf1OozEND6tKhj9NLgkXeiErIHaMSnEQ9iPu6bT4lH6WxFQepXDhE02xfbtbfhBOXyg1bWlnghZFw6RHHQFxs4tXEfnfl/RNEBsEAdBLmhOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372435; c=relaxed/simple;
	bh=qb7VeerfSjvHCIIJH0UYHXCzJDbJBJVWCoh+NyBO9yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFckv2EFIUxIayXqJclBZwO7dUnr0W7qFYFjj2haPMU99f3FMJzWgjTeNs/+63z+UVtffVNoHixznL1fjcwvMqUMAVIMJOxV5Ch0Z1o9hxTg9u57l2BBDT6umXHKQQdSkB6z997ZyjhPjd9DYrUXGqyvDTk7cY5spV7FzB706x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=UILAnKS4; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="UILAnKS4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=UKNRuc+klmpa/bKfByFHMcR7TYxrYbxiLCr/auYg/YA=; 
	b=UILAnKS4Ms+NmLCWu/z8Za7y4n8bSr3uGWDaoadHD5bMCVe8WVBUR70ww1OTLlA2VgxgPamDFs/
	erS+Vqkqh+GDo03Z8ju18M398trJl072XSx5A7qKv8KISFa76COVwiBWdu2+q7dFwHH+MaU+6VPlZ
	Bh5+REIwveLFCKUdezJDaePgFKMiX8cuwnuJRsiRx/S1kajbevYvgcSwo5OrkKJooLkQPxnyLRn2q
	nsIp7XgGpB6bmS3glDYHuFkZzJdZekYHccQ9w+hsGNTKXUkJNF1jeFSZsTlljrI2b1t8COh42quEy
	bzD8b5Rq7j3OGj3Op75p/GSYBEOPL2Nhx6tQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wHflE-009UDa-1C;
	Tue, 28 Apr 2026 18:33:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Apr 2026 18:33:48 +0800
Date: Tue, 28 Apr 2026 18:33:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 03/10] bpf: Implement get_next_key()
 resizable hashtab
Message-ID: <afCNDOhbszgMlGB7@gondor.apana.org.au>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
 <20260424-rhash-v3-3-d0fa0ce4379b@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424-rhash-v3-3-d0fa0ce4379b@meta.com>

On Fri, Apr 24, 2026 at 12:50:45PM -0700, Mykyta Yatsenko wrote:
>
>  static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  {
> -	return -EOPNOTSUPP;
> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
> +	struct rhashtable_iter iter;
> +	struct rhtab_elem *elem;
> +	int ret = -ENOENT;
> +
> +	/*
> +	 * Hold RCU across enter_from + walk_start to prevent the
> +	 * element cached by enter_from from being freed before
> +	 * walk_start re-acquires RCU.
> +	 */
> +	guard(rcu)();
> +	/* If key is not found, places iterator at the beginning */
> +	rhashtable_walk_enter_from(&rhtab->ht, &iter, key, rhtab->params);
> +	rhashtable_walk_start(&iter);
> +
> +	elem = rhtab_iter_next(&iter);
> +	if (elem) {
> +		memcpy(next_key, elem->data, map->key_size);
> +		ret = 0;
> +	}
> +
> +	rhashtable_walk_stop(&iter);
> +	rhashtable_walk_exit(&iter);
> +
> +	return ret;
>  }

The same issue from v2 still exists here.  If a rehash occurs
in between calls to rhtab_map_get_next_key you could be iterating
over the table forever.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
