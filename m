Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F1F38838F
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838967; cv=none; b=Vv+3zUptetwB640LEsI3ctmeowXZNTPTTLyae72t0hKIAT3a4DPqjPGwATx5HwxtsfL36CUuWEkbacAJ1rhFYkMTEfCH53ChkpHbVjs9irSC8BgfCMViTgNsgS90R4c5tLaG3YhfGiAVK5a2/APM5NtooeqSq6EYDXW8ZgsM/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838967; c=relaxed/simple;
	bh=XI+wSDPsDalgmSpvWDGOHzYmKlkwoiZ+NkcKWszYEag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F0nMj0xMDziEeQZ2QrjaBET9wyk/JxSn12TDxpUt7Cavx03rMNglmhnZWokwKIyqZUP1OmD0PjkqE/BXIzeK+UM3bF6DpdJqYpWXaZSxdj8hRRZpj2EpIZE4V2HrZjGmuNWzefF/NoZqxEeS0RcIOI2HlGAVIyS1IVcKZZirArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd3VFS3y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd3VFS3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EA1C2BCB4;
	Sun,  3 May 2026 20:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777838967;
	bh=XI+wSDPsDalgmSpvWDGOHzYmKlkwoiZ+NkcKWszYEag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Pd3VFS3yeSkVIZJKuEH4h3XVtMhYbW0IV/v7skyLrrZhyD4QPIp/xSNL7WDkh5XCk
	 r3E9ZuizqmlxJC3wNNGngwNzT9ETxk51lj9FQvvRCH1qqP5jPzZIFIM94TgNf9/Zw4
	 r4Zt1gdt/caP9KRsUfLFDct2RcSYFV5V9gDPzmqiOU3YIjqxzUmRshRzcJOpSBdMYT
	 jSwOIf5mlEOYcMc0silVqzfMoLFNwb9NjWNITs/qJU/7FDBQeQhvUgt/20vbF8cuzj
	 tjhKYHor8XoctIv+6EnWEXSbrLXi3J71M+HUquzMyt7jv6LcH95QhQDMg6FMW8Yo03
	 P/jOXaG8PWCqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 6/8] xsk: avoid skb leak in XDP_TX_METADATA case
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260502200722.53960-7-kerneljasonxing@gmail.com>
References: <20260502200722.53960-7-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 20:09:26 +0000
Message-Id: <20260503200927.73EA1C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) vulnerability on shared =
UMEM metadata allows bypassing checksum bounds validation.
- [High] Leaked `xsk_addrs` structure in the non-zerocopy `xsk_build_skb()`=
 error path when page allocation fails.
--

commit f1079e9399771f267ff5b6767db05016e5ee4840
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: avoid skb leak in XDP_TX_METADATA case

This commit fixes an skb leak in the XDP_TX_METADATA case by explicitly add=
ing
kfree_skb() before returning back to its caller. The issue happens when
xsk_skb_metadata() returns an error, leading the caller to clear the skb
without freeing it.

Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.=
org/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index af3c5752bb63..770ba4695a9d 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -821,8 +821,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct=
 xdp_sock *xs,
>  		skb_reserve(skb, hr);
>  		if (desc->options & XDP_TX_METADATA) {
>  			err =3D xsk_skb_metadata(skb, buffer, desc, pool, hr);

This wasn't introduced by this patch, but is it possible for a shared UMEM
metadata TOCTOU race to bypass the checksum bounds validation?

In xsk_skb_metadata(), meta points to the metadata area within the umem buf=
fer
(buffer - pool->tx_metadata_len), which is memory-mapped and concurrently
writable by userspace. The function performs a bounds check:

    if (unlikely(meta->request.csum_start +
                 meta->request.csum_offset +
                 sizeof(__sum16) > desc->len))
        return -EINVAL;

If this passes, it re-reads the values directly from the shared memory:

    skb->csum_start =3D hr + meta->request.csum_start;
    skb->csum_offset =3D meta->request.csum_offset;

Could a malicious user application race to overwrite these values with
arbitrarily large 16-bit integers between the validation check and the
assignment, leading to out-of-bounds DMA accesses? Might we need to copy
the metadata to a local variable (e.g., using READ_ONCE()) before validatio=
n?

> -			if (unlikely(err))
> +			if (unlikely(err)) {
> +				kfree_skb(skb);
>  				return ERR_PTR(err);
> +			}
>  		}
>  	} else {
>  		struct xsk_addrs *xsk_addr;

This wasn't introduced by this patch, but does the non-zerocopy
xsk_build_skb() leak the xsk_addrs structure on its error path?

When appending a fragment to an existing SKB (!skb is false) in
xsk_build_skb(), the code converts the destructor_arg from a direct address
to an allocated xsk_addrs structure and initializes xsk_addr->num_descs =3D=
 1.

If the subsequent alloc_page() fails, it jumps to free_err and returns
-EAGAIN, leaving the partially built SKB in xs->skb without incrementing
num_descs.

When the socket is closed or the SKB is subsequently dropped via
xsk_drop_skb(), xsk_consume_skb() is called. Because destructor_arg is now a
valid pointer, it fetches num_descs as 1. The cleanup logic relies on:

    if (unlikely(num_descs > 1))

to free the xsk_addrs structure. Since num_descs is exactly 1, does it skip
the free, permanently leaking the xsk_tx_generic_cache object?

I saw this issue is addressed later in the patch series (xsk: fix xsk_addrs
slab leak on multi-buffer error path).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.5396=
0-1-kerneljasonxing@gmail.com?part=3D6
