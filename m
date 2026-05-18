Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235C9352C5B
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 04:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080170; cv=none; b=TYK+j8zIdOxIHXnGNsXR2a0DKQQW6NcskY8wtn5c8I3E3McOAyK3ywFCXCL0XfSEqfcoxDHqYz5kd/mDWcITGHBzXo5F4Zgxmh6yefOVofcFJd5dWfyP76/R8KrjbTdGpyrwLG0dgn5KgCzI9xpzbX8IIQqWLBKdh+tnB5zl/eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080170; c=relaxed/simple;
	bh=5hyxuTKfFxj8dNNawvnPEqYLaxesxqw3RCpQH3a1SVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHkRfYMB1fHvQ/dyH7IMRGSjarUsFh64SyEkKeNmg/fPJHGZmyupVevwTssGAWnRGsNNt6MOL6f/0E0G0OG93/C94lb58wp3C8q7zW8r09O5XlrcH/AnoaKxg0K0+snM6YJesmy9DQ4dRCff1eSZSG4EFmWptVwNB1yBH4xl7HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=K11L/66b; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="K11L/66b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=CT/fucYCZuGQRqCLMooMfXk9EyC6UGqHhGnI79oNYJ4=; 
	b=K11L/66bliP7gASSu8tvFbtX4c0r4mS40EcCvTtrw7qm68uFti0Ci0tw5cfOVPIl8DSnTb5sp7Z
	SO+O2kUmY2hn/qmPjbH9du6Q2IcawNxADMmJfTbLVFbPDeqE1nYbtaoT7YjpK1/oCDbCFb6s8SxEx
	1ze0ujkSQovo6WM6OY7einQMXLiOp8lPSzE9nek6LmTeT1MHu5xNegCgh74Ha820Jn2rLmSwKMhCL
	wWXl66xHt4BJevB379MLzbmGk2DivcUI3U0ehxaPWut6WDG++LZT+PtR0aBNw5bfo62PeMPOiF+Wu
	n+mzZfTDGzPyccCZ7kbpOrxN4Q1WK+n0/Nmg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wOq1K-00F2Us-03;
	Mon, 18 May 2026 12:56:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 18 May 2026 12:56:02 +0800
Date: Mon, 18 May 2026 12:56:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v3 02/10] rhashtable: Add
 rhashtable_walk_enter_from()
Message-ID: <agqb4sBA0ISIyV1N@gondor.apana.org.au>
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
>
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

The params parameter is redundant.  It's only needed for inlining
functions, which cannot happen here.

> + * Like rhashtable_walk_enter(), but positions the iterator at the bucket
> + * containing @key.  If @key is not present in the main table, the iterator is
> + * positioned at the beginning.
> + *
> + * Same constraints as rhashtable_walk_enter() apply.
> + */

This needs a big warning that the walk is highly unstable and
may never terminate if interrupted by resize/rehash events.

This is even worse than the existing walking mechanism since it
can't even detect resize/rehash events.

But with that I will take this since you're aware of the downside.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
