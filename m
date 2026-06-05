Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F421DFF0
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659822; cv=none; b=Bp31LAdoTZOmlR45ZsH2w2Uh7hiCqkoYRg6xzOTsp/UYGhV4egg6EJPc7CvoZ19r1YeDouHl74gcm1vqtqvjC4DcXj99gd4q0xAiXLB7yQ44pvAoVUjkt9x3GqXglw3Xba45ui2fl5DlpkJATDrUuL9MmNnVwP/4+tu2yB+8yVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659822; c=relaxed/simple;
	bh=7MSqZqYTET7tVaDSBb+jFe/uMCk/vrK55DsbopYK1TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzpRYECg7h5NpSy6WIpuRINP4Hu5klVmDkC9wwBHd0Id8JAB5EmDKBlmVFyp5Ua9hXXEXvsPuS57B5VXSHx5oCIJuapeSqDU7wkLA6HtNeX1kNbbc7mph/91qGH+CCMkz3gNGJV9WCe+YU53A999sEjqbXTrhUIr7YcxXSMeQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=B7wgmVPc; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="B7wgmVPc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=DVCu9JLMjq69DHPZvUO2L2ShC2vrCOi4IUHX3GnkQ1I=; 
	b=B7wgmVPcCt1CXJF6OsoflXcNRJWaedT2UulKVnlJcyd8a2An1t8ZZBqzjC4HSxzIZg76KtMUCZh
	32DqBH2RJBpfIhHqii88nuUsz1++7Ml7F5kZVsLTMF/1/eVtUWbjDEhYz0Hhpfr3LAN3vtDupnnFZ
	3FzZwoaHecB7Ge7MPZabSVsA+wdASUlNaedJoPPFFKjSDlopXNM4/H95Wf/dqaiJ3OwXK3mfUrSP1
	kX6mPGXvWQXQmnElM8C80DSJbiv6PSIHorc+VUvZRy9hpVhy+ZaBdG5mGFTmpObWoOWioifMbfd2B
	xivwqorQUS8xX+IlcROY6GOnzTqMdW/sIzZw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVSxc-002oqf-0v;
	Fri, 05 Jun 2026 19:43:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 19:43:36 +0800
Date: Fri, 5 Jun 2026 19:43:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v7 01/12] rhashtable: Add rhashtable_next_key()
 API
Message-ID: <aiK2aGUJgE-LLKw7@gondor.apana.org.au>
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
 <20260605-rhash-v7-1-5b8e05f8630d@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605-rhash-v7-1-5b8e05f8630d@meta.com>

On Fri, Jun 05, 2026 at 04:41:18AM -0700, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Introduce a simpler iteration mechanism for rhashtable that lets
> the caller continue from an arbitrary position by supplying the
> previous key, without the per-iterator state of the
> rhashtable_walk_* API.
> 
>   void *rhashtable_next_key(struct rhashtable *ht,
>                             const void *prev_key);
> 
> Caller holds RCU; passes NULL prev_key for the first element or
> the previously returned key to advance. Walks tbl->future_tbl
> chain so in-flight rehashes are observed.
> 
> Best-effort: in case of concurrent resize, provides no guarantees:
>  - may produce duplicate elements
>  - may skip any amount of elements
>  - termination of the loop is not guaranteed in case of
>  sustained rehash. Callers are advised to bound loop externally
>  or avoid inserting new elements during such loop.
> 
> Returns ERR_PTR(-ENOENT) if prev_key is not found.
> Behavior on tables with duplicate keys is undefined.
> rhltable is not supported — returns ERR_PTR(-EOPNOTSUPP).
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/rhashtable.h | 40 +++++++++++++++++++++++++++
>  lib/rhashtable.c           | 69 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
