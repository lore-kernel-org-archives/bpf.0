Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3653384CE8
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453803; cv=none; b=EsM6I6bPBrBH/FEFxx7TL2hNJCrTn/hpyHOyMxwvSdleLLi2fNkvZ7Bo3JzBADILaG1QBg2QyRn+16riWvV4u8Osma55GcdwCpWZM07/7AiyjcrvGuS239n73lNNKBrSQFygc0p42xFU9eWQ0mu+u5dNyzG0MlsqSlSlKQ7QATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453803; c=relaxed/simple;
	bh=8q3Bty09AAQKGTs1XHrfnvjJrboNLrR1idvqys5U8B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by5BSYDUG9NUiIK4GTAEBjhsVfrUb6KJO/QvHMtN1/sbaw4vimgUKD3ITQL6IVDzZcmdGBv8AC2NaHni1KDhFGZyqjeRGCioRCHD28lTgmTHiKXhSRX4Gjkln6KviIHaRG8oAss+X0sL2RhGatkj4pwVdcZ9M9F6mE5J5mP/6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=UvT86WQ4; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="UvT86WQ4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=9tBlSK9+G2gYBskn2d0ukEqZtGZfb+A6M7fQLcFWvG4=; 
	b=UvT86WQ4RN4zL+8e/KQrQGf4vlxUIY+q9eGOjR0TLecbHs1z5NszSaMluK2nbh7cn/9kqs7Hd/W
	8TIEMIX9AtQWE0MZ5ar9LFFk+YaHfIJ7B1nzmccXdxS1Z2i4DVu6DywUFSrpIEQst3JFT7mPaWsjD
	OIHvENhIjojXnaWN1th8cijQNBOzbV73A+ZGDEwRrtehSfFCJqcLCgLExr6vwMpfr7BkBj+n8o9qZ
	qLLfW6jjTtyQjcuJmk4I4B24dqyxhijEYpgXnNLhD1cIX6Tlug5EFWg3zVzwLCI2BiBUZfwNIELA+
	+k/RI8KNTTJu1pogKHMP3PqNhHWsF24svaNw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wUbMa-001u3b-0q;
	Wed, 03 Jun 2026 10:29:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 03 Jun 2026 10:29:48 +0800
Date: Wed, 3 Jun 2026 10:29:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v6 01/11] rhashtable: Add rhashtable_next_key()
 API
Message-ID: <ah-RnMHSKUIIjwVb@gondor.apana.org.au>
References: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
 <20260602-rhash-v6-1-1bfd35a4184f@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-rhash-v6-1-1bfd35a4184f@meta.com>

On Tue, Jun 02, 2026 at 01:45:30PM -0700, Mykyta Yatsenko wrote:
>
> +static inline void *rhashtable_next_key(
> +	struct rhashtable *ht, const void *prev_key,
> +	const struct rhashtable_params params)

Why is this function inline? We only inline the fast path code
and iterating the table does not warrant that treatment.

Just get rid of the params argument and make it out-of-line.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
