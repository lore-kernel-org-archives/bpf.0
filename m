Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F37233149
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776472989; cv=none; b=CREUBdKNQ8B8vmzWjNG7OHo+/XVCVr8MLpfLrPd9D/pbzjqrStToGmJbnnnJ0GJVEv8NfNOROjrHo8cKQv3XrRQuq8PkWX+d9yFwBOSJ5sXIylDDIGtRX6FxliT5a4ZifrT5dvXbAe+QR/kKH1RYtF5DDCNcwXpfrqdgta2MJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776472989; c=relaxed/simple;
	bh=xHKikzztcReF81C7JZlQw7ITU9rRjgCL2fR8CTa0mts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6HmcNmMoxzMVXFL5juCR5bdDXqRZ5W3ZueRKgnxzx73ytS1iXEV3zYbwW9XS7JyIGSr7UbU9tQuL2l1/gAr73C2I1PFp1xO51jPLP4ThTqBHZdGgu0CeFr57fzUTjZbpGclzbCSzrCqvmeXX4/KXbgPQMqxxEefM1qbuY4bejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ImWqsU89; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="ImWqsU89"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=BTfLkaTRr86jWHwHhZ13KwJ1YptBa5oxblTGpeNUn+4=; 
	b=ImWqsU89zbgCGiwCq4rYxpVOFHYmCayrz/r2UUM+g/+lPJv12GrYeb2UFLUOIraNKgVrDA1SWZL
	xjHiMNIKosLmqOvRKDEVtO/GVRD5J77iWop1pjCwc5zaxZx6xsPPlyEgqCzxxovDo5RszAr+zibnd
	nlFDinRaLjyYvu9s3XDo2Qnuv/Y9KkxZV3qY/N1q+4C8KcVVuds0YpnjWsrun46VvIpcosuU+GDKq
	Y07k8uLSrgIub0POUZN8bw4l0aNSooxqShhdDvjUJpacCb2AOfwovgO7Dy9sKBDX6DQtZ+hfrP37m
	rwcJv6kVb2BfWdNLUwl1FV2f652+3GlaxhSg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wDtm0-006voA-1U;
	Sat, 18 Apr 2026 08:43:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 18 Apr 2026 08:43:00 +0800
Date: Sat, 18 Apr 2026 08:43:00 +0800
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
Message-ID: <aeLTlNbM1rH31D4L@gondor.apana.org.au>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
 <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
 <aeBxQn8ATaNuEF4X@gondor.apana.org.au>
 <DHUN1UJ0DLBC.3UC7SXBAV2FOW@gmail.com>
 <96b6f76e-1dc9-4d54-9f92-8586796ef607@gmail.com>
 <aeHZJUw-ZRA3ZWVE@gondor.apana.org.au>
 <4c0e73e1-43c3-48a3-ab89-239fed7e6c23@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c0e73e1-43c3-48a3-ab89-239fed7e6c23@gmail.com>

On Fri, Apr 17, 2026 at 04:16:34PM +0100, Mykyta Yatsenko wrote:
>
> Changing interface is practically not possible - this comes from the bpf
> syscall.
> Linked list solution: we probably can't afford it performance-wise, it's not
> worth it to pay for the linked list maintenance in insert/delete operations,
> to make traversals work well.

What performance penalty? The linked list is just a pair of pointers.

Memory-wise it'll be two extra pointers per node.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
