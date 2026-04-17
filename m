Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B50737186A
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776408882; cv=none; b=evL8cP7MtXoJFr3bVlmymlMNQUucsc5SiJ/1x2wuETwDEV4PWWfcHku4snmjshLoyQLlMksq2FcUwSG7ay8YZSc3pDJ3YbUQ59cqLTjxlgNHD74nIG0GlNxsyaiMafXzFjelcqIiK9XdxMdg/7L9tKgcG5XqCsmfPiCx/HGJ3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776408882; c=relaxed/simple;
	bh=EeB0sB4jfiNc5ZxzMeHEnwVZR9LSTcb+7BgA6eh9b6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoSkiCQs7TzHZuNxjRoCv1jivMXAhRNh4hOb/+2uEPrFcJYO/SwZ5i6ug+IVKOz7+27fzHOsgzboKrxkbhb+1e9HX+4uPjgqdQT3DVJLXAp8nkJn08F4O/WATaBr8Qbqao66FN55zpXGFc4Jo3SdGOKB/4fVuJOA89Voi4TrNxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=C20W6kJP; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="C20W6kJP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=nj9WjNgZe8RFcxQHAiMacZuT0UZkIp8H8yQorTIlWDc=; 
	b=C20W6kJPIGqX8+Hnx4UsQYK7l8AZ2pL3RLWDDz8LYFJuqbsp9ScqCDMAhgdpk6MgepK8mpM5mDg
	BChPdrYUiOJjLkLDfW9kJaRoOO9A5O30NCyPteJP0lzB3n1xT+GKNyS8klaXOqq36m8Z8nRZw/Yjn
	B3kWOLvzH7aJsAellVAGrpv72ON6sbEP1DVTNOg2UCzt3vNRHKo8bpOUiLm0f6IqHDN+WpSCwQiuA
	Kser7YUjVidn4OdkHDsMMbvmHtAEsLzgCICDm76mGpt4oasHOcqI8B0L8ThmJ5yX4RYmeOWnCldrX
	NwoZxo2Xmolps1o+EUwk02b/bfVWqU9Hsi9Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wDd5x-006jql-2Z;
	Fri, 17 Apr 2026 14:54:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Apr 2026 14:54:29 +0800
Date: Fri, 17 Apr 2026 14:54:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>,
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
Message-ID: <aeHZJUw-ZRA3ZWVE@gondor.apana.org.au>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
 <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
 <aeBxQn8ATaNuEF4X@gondor.apana.org.au>
 <DHUN1UJ0DLBC.3UC7SXBAV2FOW@gmail.com>
 <96b6f76e-1dc9-4d54-9f92-8586796ef607@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96b6f76e-1dc9-4d54-9f92-8586796ef607@gmail.com>

On Thu, Apr 16, 2026 at 04:10:35PM +0100, Mykyta Yatsenko wrote:
>
> There is a problem though is the get_next_key interface:
> 
> int get_next_key(struct bpf_map *map, void *key, void *next_key)

Any chance of changing the interface?

If not then perhaps a better solution is to use a linked list
in conjunction with rhashtable.  It'll cost a little bit of
extra memory, but really provides you with the ideal solution
for what you're trying to do.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
