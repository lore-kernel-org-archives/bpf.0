Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC74C650B
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545721; cv=none; b=U8w1Q//qAu9TOPROnrtbXXY40Fn/D1K3+eBl5UG5u1rHCAIJHVUL8aE4Flh+StiX52vNSeTDcUMOhwRMB51QBb+WEoN0pnbFYPgvdPpRfNf5bTNWsZPBQAQuOU8/ZuXdUOnopG8noM3aajltJH72/1j1Wdu0NbH5jMnn+fn27+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545721; c=relaxed/simple;
	bh=DS9T197J6smEJKdQJEolczf3SYe8Yko36KC2CkFGNYM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=i2JWChhyPDKuvRzsU4DLXzSh9d4H2yMKX8jJNmyuZL0jx04HScoRyJd608JmJoDWlVTSkOGyItKXEFTi27KJ9/qZvfsug/zqQiuLzy27J9TpaB4t/uXzDfG6tn2SczFYqIAXRSzmYeL5KHBbrZLBxJMaLfYkYh15BJuN9StUzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCsA8J22; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCsA8J22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FFF1F00893;
	Fri,  9 Oct 2026 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791545713;
	bh=yqY70+PsiU25prNPnUb+vu3CtkLJrk7/cZu1vrVm0VA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCsA8J22BQb8DRdIfCdJvXetOo8uAHXU46JJAPeBwXCfhbKIvw4+mpyiBHESBjc7A
	 /LSXgn/LIyi4vKs0fTfswkcoDCyM2D8h1k4BH5n9ruKjZzTFezQlJe0JkD+z7E8/bX
	 gVV0Oy3tqOCfKkL+cNGO7D5wiPoZI5pc62chTDya2+2kzuOSoQUdjDU0wfVBm4m64g
	 Oy76yLteyBii5FflrCxWnOYFdTSZqOLkbaSY68Z+O6LbOQ5xvgbRfskTqViWG7qq5C
	 YsOCNv/Pfu+PXRx+nGGNfisDNYxj2rU8tJgt87yYjInQ9w01b56yqCHIgEbpmMnp7q
	 SEWqlILxpW8oQ==
Message-ID: <sashiko-outbox-165395@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] mm/page_owner: extract page_owner_next_eligible()
 from read loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009112308.240769-2-zhen.ni@easystack.cn>
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
 <20261009112308.240769-2-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:35:12 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: soft lockup in page_owner_next_eligible() due to missing cond_=
resched()
--

commit 303a10c305ed333982228df86334f12bd6d8a3c2
Author: Zhen Ni <zhen.ni@easystack.cn>

mm/page_owner: extract page_owner_next_eligible() from read loop

This commit extracts the page scanning logic from read_page_owner() into a
dedicated helper, page_owner_next_eligible(). It advances a cursor to the
next eligible page and takes a snapshot of the page_owner record inside the
page_ext RCU window.

> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index fbbda7ba914ba..bafe474f33602 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c

[ ... ]

> @@ -798,37 +795,67 @@ read_page_owner(struct file *file, char __user *buf=
, size_t count, loff_t *ppos)
>  			goto ext_put_continue;
> =20
>  		/*
> -		 * Access to page_ext->handle isn't synchronous so we should
> -		 * be careful to access it.
> +		 * Take a snapshot of the page_owner record inside the RCU
> +		 * window, then validate it, so that print_page_owner()
> +		 * reads the checked handle from the same snapshot.
>  		 */
> -		handle =3D READ_ONCE(page_owner->handle);
> -		if (!handle)
> -			goto ext_put_continue;
> +		scan->pfn =3D pfn;
> +		scan->page =3D page;
> +		scan->po_snap =3D *page_owner;
> +		page_ext_put(page_ext);
> =20
> +		if (!scan->po_snap.handle)
> +			continue;

[Severity: High]
Could this cause a soft lockup? By using a continue statement here in
page_owner_next_eligible(), we jump directly to the next loop iteration
(advancing pfn) without executing cond_resched() at the end of the loop
block.

If a large contiguous sequence of allocated pages lacks stack handles
(e.g., if stack depot is exhausted or during early non-tracked allocations),
the kernel could iterate over millions of pages without yielding.

The original implementation used goto ext_put_continue; which correctly
yielded. Does this need to be updated to explicitly yield or use the
goto instead?

> +
> +		return true;
> +
> +ext_put_continue:
> +		page_ext_put(page_ext);
> +		cond_resched();
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009112308.2407=
69-1-zhen.ni@easystack.cn?part=3D1
