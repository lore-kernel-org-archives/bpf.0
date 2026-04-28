Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2293240611
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372533; cv=none; b=TWFfB5ZPIV6XDXp5fW950GLmYEhIY19A8yej6Tep7tnWNxQ8lhRIfokl8MvsU6RxacvfkwiOAYeq1J9tzX2qCa0+9kHQsHVFCQBl44mXZ7Bk9Ied25GP5bpwypxV4IKCdQ08n8KiXkJmh0r0mOKoQWAwA0zodvxzO5Xx/qLInS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372533; c=relaxed/simple;
	bh=ufWGZQb4W2jCHYUop+iJRB9WZ+8bepy3FIfhVn/fuck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PW/iBIsWLUYROWEJs13lniG/yOiXZ7vERO/vzAvnbbsu+AYk9eOBcON3LJm9RO9hubL7wrbyy8A8R87vZUGtDKwObzq5eGYvjriccZDm6SUTTmpJJ7MXeRoONpMcmh2fINZwe6PpSJcNybtwjDL/J1mPYp4SYC4VzBLi8pcWSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=RLKvkwGv; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="RLKvkwGv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=dvCHubGHL2RzXnfnMlmDAPSPT0heEe9MeLi10CqDY0o=; 
	b=RLKvkwGvW3PLzVvdEf9bILz4qkJYIGbdrgmaUgv+NlSBCXu7QqweGOnK7A2lY4GdLyXNgb5VaTQ
	JvNO/QVP+awKlSDWCpF9iiibpD6gNjWM2ToHjWqPglT+mbJz0mzfpSDqYcz+jffve28iq5cIXbh3x
	HYpBppVeB0XZZLMubZzwr3gghHgiRz9XIDrsAxUepzd2AFDc/Q8aCHSzrOlMw9XmQ1RI5Kih+vZO1
	HG5mHYGyvoYwURsfZ08iLTxw1+NMSruiu5RA015W/kiYSXJV97roTQU+HRsKFRn2tIiFh/n6kszrb
	71wOVSi6JoyvNzHPtmJd7hT/i9Plrp6XAkMw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wHfmq-009UF4-0H;
	Tue, 28 Apr 2026 18:35:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Apr 2026 18:35:28 +0800
Date: Tue, 28 Apr 2026 18:35:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v3 02/10] rhashtable: Add
 rhashtable_walk_enter_from()
Message-ID: <afCNcFLArNkj7GXh@gondor.apana.org.au>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
 <20260424-rhash-v3-2-d0fa0ce4379b@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424-rhash-v3-2-d0fa0ce4379b@meta.com>

On Fri, Apr 24, 2026 at 12:50:44PM -0700, Mykyta Yatsenko wrote:
.
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 6074ed5f66f3..2a6098edf737 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -692,6 +692,47 @@ void rhashtable_walk_enter(struct rhashtable *ht, struct rhashtable_iter *iter)
>  }
>  EXPORT_SYMBOL_GPL(rhashtable_walk_enter);
>  
> +/**
> + * rhashtable_walk_enter_from - Initialise a walk starting at a key's bucket
> + * @ht:		Table to walk over
> + * @iter:	Hash table iterator
> + * @key:	Key whose bucket to start from
> + * @params:	Hash table parameters
> + *
> + * Like rhashtable_walk_enter(), but positions the iterator at the bucket
> + * containing @key.  If @key is not present in the main table, the iterator is
> + * positioned at the beginning.
> + *
> + * Same constraints as rhashtable_walk_enter() apply.
> + */
> +void rhashtable_walk_enter_from(struct rhashtable *ht,
> +				struct rhashtable_iter *iter,
> +				const void *key,
> +				const struct rhashtable_params params)
> +				__must_hold(RCU)
> +{
> +	struct bucket_table *tbl;
> +	struct rhash_head *he;
> +
> +	rhashtable_walk_enter(ht, iter);
> +
> +	if (!key)
> +		return;
> +
> +	tbl = iter->walker.tbl;
> +	if (!tbl)
> +		return;
> +
> +	he = __rhashtable_lookup_one(ht, tbl, key, params,
> +				     RHT_LOOKUP_NORMAL);
> +	if (!he)
> +		return;
> +
> +	iter->slot = rht_key_hashfn(ht, tbl, key, params);
> +	iter->p = he;
> +}
> +EXPORT_SYMBOL_GPL(rhashtable_walk_enter_from);

I still think this is misguided.  I'm not going to stop you from
doing it if you really wanted to, but this thing will not work well
if your rhashtable is constantly resizing.

You also need to consider the possibility that an adversary is
triggering the constant rehashing.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
