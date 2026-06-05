Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452641DFF0
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659839; cv=none; b=MK73D8pRusCBU6/SgnMJs0m4J5/FKa9mFhWAW/07hqH+1GtHjuCQ5T5o3l3E4B6F4bGRJeAiaRcHM8uXxCs45eqyuNkcFAWT0CpMDmUXFGbKzESJx0q236nO14u6J6DRj815LoIKJ3qVZe19l7gsEVab9r5mKvcvJtBLbyp6zRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659839; c=relaxed/simple;
	bh=dZBt0eHYQrKhEiBaS0fysWbQ+NtHtl+IAzSN7boWOeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P39AEL5XGAZBft4XovkJONXkvKo//H04m0uXc3kuq6xppYzVdTyb3XDTVH5lF7TcpJS81p9Mx/GsK7NYo3a+rh+qwanl8VXfjCxvhXRxIoxTNQczAJxy27mYW8yxSpCHD7MZg0ASkp17FI8fL+uPrBPfmBaqn8+ERpzmpV/PKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=NK2wUOvY; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="NK2wUOvY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=kz4CBgU1tJ6AHdxQ/MK8aXUbpqWObX3wnPy+KDoTWb0=; 
	b=NK2wUOvYTv178D60g0cYo/7IBVLtmKCfNpbAB4RmtrLYCrSvapIaZdk9SMyVJop8Fn+mFHp64+b
	NFPd4njPin/UjYQLo7qqbWlAezwwrsQBESca45xI8VSQjlgGsyV3VCLeusXgOYygxUnRo5DvU1ri4
	0GofgzwFVy7GmVUPhc10Gp1PpnJ6O2IHNvSBnM6sumjyTYJzapnbUuBsoilldlj39QjFffC7DsWn8
	jhVa0R7UnU94XKpipYs7WqxgL26qZLLf77wFN2Qj6HO6rQnhNnFvyuAz8IhFCrYNaKUvcl+nlBxHW
	NTsZ/G9Lrm/jsLfaiyRRdL7N8g0vDvcybNKA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVSxu-002oqn-2c;
	Fri, 05 Jun 2026 19:43:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 19:43:54 +0800
Date: Fri, 5 Jun 2026 19:43:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v7 02/12] rhashtable: Add selftest for
 rhashtable_next_key()
Message-ID: <aiK2esU7VvdGV21x@gondor.apana.org.au>
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
 <20260605-rhash-v7-2-5b8e05f8630d@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-rhash-v7-2-5b8e05f8630d@meta.com>

On Fri, Jun 05, 2026 at 04:41:19AM -0700, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Insert n elements, then verify:
>   - NULL prev_key walks from the beginning, visiting all n
>   - non-existing prev_key returns ERR_PTR(-ENOENT)
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  lib/test_rhashtable.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
