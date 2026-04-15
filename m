Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA631A555
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223672; cv=none; b=d5pK47GRd26ShnG20nV3xUYy9BLn/tfPXLHAGM7CmR9HPFbueTSpRl2r9KmkNpdjMG6qxq00I3tdBZ5F6fJ2x6bRwdy5JvbyQKcZ6j9GQv7+NyBSKEwU1hYGbmxEwKChtpO7Krg07qe2V39Zp6F4TmikHR6ldqae4EbL5JvYpgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223672; c=relaxed/simple;
	bh=BSLWZEeyiGLkWmdhgkHUXyMzVLOfv2SFYvbaK/XLBCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0sNsajP+uQIH3AEDAhaL8nscO86f2/aSrU1NbqzHHovsXSH1DXRVVQMnylqxjWqLIvNdo1ZhZj1EhmzzWPXuOX25Axsrijo+7FawDP1okYdK40dZL98NLyPfCKFXlTpnxa80ti4tTniCPaPP9/3v/vzWgCaDKlsAolzDlfBmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=YLdk8kpP; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="YLdk8kpP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=pFYq5Hzm0sI905yTElU9H8Zj3dJTGquQpnLSoQkCffo=; 
	b=YLdk8kpPd5V4q6btphKCcCAqcUfB8dUkB6j87N2dxmWKdyoatR1hpvxphao/h2YSqx0kPlLt3du
	bTf+hUjS4li4lc07d5ZibH/lgnR5Mxl5aA1R96rSdoewmFR11ujz7FkdL1ZnAIVkIPTUbJTw6Cih1
	z9NOsn8lQErgINPQEu1XZmfkX7lOeVmrhIUzlz4NE+AUSZmsbPiqv29jxOPf76CWs6+GjII4T3hUy
	2s2FpaLzIo+Zq7Yz9b0uiI9RIVLI1WmRN45Au8anpMKIIh39fSGagfaVkdEFz0r59VNsFgXiywSTS
	IcX+8yb4+YtJNJvorSqlm/xTBBcMmjYEQLAw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wCqVI-006BIM-1w;
	Wed, 15 Apr 2026 11:27:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 15 Apr 2026 11:27:43 +0800
Date: Wed, 15 Apr 2026 11:27:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
Message-ID: <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>

On Wed, Apr 08, 2026 at 08:10:05AM -0700, Mykyta Yatsenko wrote:
>
>       rhashtable: Add rhashtable_walk_enter_from()

Rhashtable walking is strongly discouraged because there is no
way to provide a consistent walk on a hash table that can be resized
or rehashed during the walk.

So the question is why do you need to be able to walk through the
hash table, and do you need consistency guarantees such as walking
through every entry once and once only?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
