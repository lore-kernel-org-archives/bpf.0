Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795346773;
	b=i0FWP8gRzS/5sBH21OxCwGWTi6FdHz1ZvYYFBM5Cmn9Y1dHz2STwGKY0rHOLYyfLVNVr
	 tSbW82z/PSzEVdUtitHB8yKRWmzM84BaNNPmtXXKkN9y3wEXdskp852BNa0KVFr/9cEx2
	 FAncV/86tQPnvqfzR+s9/NR5SYrHn6TIeEYyz/uMwCE2fb5yKkRe/K2yJYqsR6zGh0eAu
	 fzGXsexpByKZI85asT2AnbvRaAKNLpee3o8qzjhqglIB5Jf9xETSOurk4vxgbL1gRTXWO
	 lt6B2Oi8uOUzJtlKfJs6rfrNRoqFWGWOwgZPHC2LyVIegjdeXlUQju3kI1eqlSyhC8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795346773;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=1uspMpQuJRTNzpxsgJc/n5tA+zBmUWGlhRFy9MYjGZ4=;
	b=wvX0Jk9C7YD/xYS3lPgn4iSRrO2KQRd5gxSLDjOVNwHJZ6jFAIAFRNddccDonCvznPZR
	 K6EiFXq5BxxCUSZbnAT+n6H8g6sqJRiA66WMARibVcTlE9VwZGe1gEwNmT7TpkgQRatQc
	 UbSwXw0zRv9jzLr4ZDhg+mPUykEWaa5LUDag377jOdF+bSAuM2XF3MKah8OPoWLU0U5bX
	 3i6mdcSypBSsGFbtaf1D1REY7SPivFQoU7OJkgKnSnC1FeZEIPEzvile/eFsOfRLOvxGV
	 goYWOWRcNdJPw+nIX9eO8Rnlkt8Fj+8jybNSU2VK50tJameM6Hmck4bRTmhcFoM2Rnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGiDEesB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7C606A320;
	Sun, 22 Nov 2026 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGiDEesB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8511F000CA;
	Sun, 22 Nov 2026 11:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795346772;
	bh=1uspMpQuJRTNzpxsgJc/n5tA+zBmUWGlhRFy9MYjGZ4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jGiDEesBgFtgaqJSxcBUkbVoiUFAYuMX8wBcNVupjlQPhxmmiXmWCfqSMuVMezF5/
	 4HIpkYsQueoM6a/L0IGeFHrxg5WV6optswSXWTYLzmX+OiH4RubOl8cU7EeaNe+8zB
	 bZI+bXU9rqJ/bXr0nHpOtiy6kKQpNubmBmBwvIZli7emCJ/jJaYBfQhu7QBwcU/FYJ
	 /+4NEITE8p9uMa8Fiq+KWp5aB8FWlj9MT+eomd3mWVp1fvwYXyAQR/jGqtWwawn5Nx
	 cP6XpoggkNVmRmc/suE4x23gza0scP4gbemgJTanrzumSVndZkorbPWcFvu7F2mYfA
	 so++V6xGYUMRQ==
Content-Type: multipart/mixed; boundary="===============7837141515741626607=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4fc370f55464ca8cca8c568368199863d477c38b332f9b78da00e821ec91070f@mail.kernel.org>
In-Reply-To: <20261122103838.244974-2-abhishekkhade69@gmail.com>
References: <20261122103838.244974-2-abhishekkhade69@gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs
From: bot+bpf-ci@kernel.org
To: abhishekkhade69@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,memxor@gmail.com,linux-kernel@vger.kernel.org,abhishekkhade69@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 22 Nov 2026 11:26:11 +0000 (UTC)

--===============7837141515741626607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs

TL;DR: Nits only: possibly unreachable needle_sz and !ptr checks in the memmem
kfuncs; the empty-needle branch returns offset 0, contradicting the
documentation.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> +static void *__bpf_memmem(const void *haystack, size_t haystack_sz,
> +			  const void *needle, size_t needle_sz)
> +{
> +	const char *h = haystack;
> +	const char *n = needle;
> +	const char *end;
> +
> +	if (needle_sz == 0)
> +		return (void *)haystack;
> +	if (needle_sz > haystack_sz)
> +		return NULL;

this isn't a bug, but are these two needle_sz checks in __bpf_memmem()
reachable?

Both bpf_memmem() and bpf_dynptr_memmem() already reject needle__sz == 0
and needle__sz > haystack size with -EINVAL before calling it.  The
empty-needle branch here also returns a match at offset 0, which is the
opposite of what the kfunc documentation says.

[ ... ]

> +	if (!ptr || !ptr->data || !needle || needle__sz == 0)
> +		return -EINVAL;

Similarly, can !ptr be true in bpf_dynptr_memmem(), given that the verifier
requires an initialized dynptr argument?  The neighbouring dynptr kfuncs
such as bpf_dynptr_slice() only test ptr->data.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45015018001
--===============7837141515741626607==--
