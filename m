Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3CC364E96
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316753; cv=none; b=XBdcKWgLWqK3Mo+0WylZ2y3YM2thEj1+2Sk7+0IJac2iUeLzXzfZDCIgBKNDrIPz6RrKGs7G1LRykWnLsE8fx0YgAa9lKu60zIHD4rcUmdJOAIaKPHJ8zDmHh58+tLyLdM8LwXrydOoZhk8u8zgpes/B/7B9HZA/5w0d1tibmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316753; c=relaxed/simple;
	bh=iRaHeGECIadoKaQxkWlSfGSDuJwRK8KsUBDGraRYa4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5zWDBV/XYqCpAjRzWKcdnrooiw2x5yXt7Icw61415rUtKx9F2tAM3+GBhbYrQ0xSL9HrxcCCxbCbhfq38abdpIqHaH69Pty4P43Gg4ENAIcxEyp0JH9b0OKOMSuB/6Dr5cBvDVOt56p8g5eZZoTasEQPckH2tNOV5MRqoMEmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ILAB5eha; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="ILAB5eha"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=nrvDmhDI29B5OsE+PDuQrkjD9JEXia10kMw2hQY3B28=; 
	b=ILAB5ehaBLIAISMESTb9u6yzwx56IXdKazzgWPpSpY3oaXrmVazE9DetwPcuBjq4q15+9yqHm5B
	Ipsu8RHRBlS2BgrrGPy5YmXw8y0kgtplxuLsULCvSfY5bwiIILpxrOy+8zK1QTiDBUcHF5mD1KyQS
	oMspuNEaSJxTX8GfomvYvkw826KSm6qLqdRTKdKcAYQixDUT9AAznyA0a0I4dYvJQL7iLawmB9H7O
	AroeLe43UQ898HFXLo4t996GDL9pBoIHi/Mb71qDQgeDxCI9wM65/xxx0YIPdJrWSbaQbSN574SUQ
	moC3G7Vx+gDz6WMfgM0+7e/L55pK9ZFMPIFQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wDF7y-006SM6-26;
	Thu, 16 Apr 2026 13:18:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Apr 2026 13:18:58 +0800
Date: Thu, 16 Apr 2026 13:18:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>,
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
Message-ID: <aeBxQn8ATaNuEF4X@gondor.apana.org.au>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
 <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>

On Tue, Apr 14, 2026 at 10:13:21PM -0700, Alexei Starovoitov wrote:
>
> No need for such guarantees. It's best-effort only.
> If the walk skips entries it's fine.
> As long as it terminates eventually it's good.

There is no guarantee that this walk will terminate (unless you
finish it in one go).  In a pathological scenario, after each
walk attempt, the hash table could be rehashed such that the
entry that you're resuming from gets moved back to bucket 0.

More practically, the walk is essentially useless if you encounter
a rehash/resize event before calling rhashtable_walk_enter_from,
because half of the hash table could be missed because the entry
got moved near the end.

I think a better interface is to detect such a rehash/resize event
and then fail the rhashtable_walk_enter_from call.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
