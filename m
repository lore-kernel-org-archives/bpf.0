Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436890;
	b=stMWDrgadOXP7oBLT3DcEP236oDUUebIaetnlHG7UuwEY27kYRpErsMqxJ9Q0jCVIhDM
	 bzj8mG3c+AKPtgseZlJkmMrLLUg2UBcQQxRn9PkVPJlwtJ8IBD42UYk/jsISUl+aLm9YK
	 pfPc8Wt00NNMpgEcY+cBV0MmORqp5e9egnq7BrAjtQMbZBmvpaJt3axaxhMvlw/ZrRkQQ
	 Wb3xAozPxFIg2bQ5ma4g1fg1KAv0nm4NkTPgM0YuuxLu/z2aq1yZDV9eVa3y9MsxmXCJx
	 ZCOxniT5vaaT093qMZ6hHPpTbTw/1HhrF96v8238km+a+WI7wG3PKxLazUYUonwOYnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436890;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=I3SdX6kZQ0XDoO/6VQkWrZqhfUCv1pPcoLBzgR6/zDc=;
	b=vmOj1obywy1rJ/s4r3gH+KSTf+SPlzaKsKjcUaTCZQqdjzPFACyUbBNzkZ/VggV5HMHe
	 wJU+pDby+o7nHn2mrZ65v09idycZ1UzJXPZ2pa3JvYlYlo83AmNr8Hi4KNBe1QoaNzMmh
	 PnHOHID4jpwt75syC1O2hOLA6GnwFM+4mhgQhpKdqN7p7RB/g1KmBdaZF30l4eIj2g7H5
	 qQhxtQuSsJjZH9qxpCGDWdVCUountrtJUS3EXkgpHVp3DL8G3PG8dzSXiWhoNYdnZkFwT
	 fdlmaFYw/n/+zEltWhPPmDqT9JLS6w+afOKOr7xB38Dop/YtPAZYGWCXfU1wDlm+1Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAZ8uQGr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443660A2604;
	Wed, 11 Nov 2026 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAZ8uQGr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35AB1F00A05;
	Wed, 11 Nov 2026 22:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436890;
	bh=I3SdX6kZQ0XDoO/6VQkWrZqhfUCv1pPcoLBzgR6/zDc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KAZ8uQGrJIqbjhAcnQh3lL3zP6UZKh6JTUOlsvT9lh7HbzzYdt5JASy+/049a1IOF
	 Qh93y6CsfRl/KzjafjGP7QsrxASRizDoZY6HRBlFuYgCmB8E3wIb3e4z5cP5OAf4wP
	 im6oRyCFFqm+T3JuQpu3EPULMuPa8z5bqYxJ/dHniZTt30yW+6JBcPFgLKoSA+4Z+J
	 ujaGJEbLyoMamXOOO7qsxMX8QvjgMlB56oRFTsVB4xNC8bjGLay5o2/YKbx9nyWNgP
	 V7h3eJkrf4mSk4XMg6Iud8pg4v/GuzS4NQbdi4D4kaJIVT8GjT/O44q7fnUHZwYosx
	 iK1XNWMujKdPQ==
Subject:
 Re: [PATCH net-next v1 04/11] xsk: Allocate UMEM chunks through page_pool
From: netdev-bot+sashiko@kernel.org
To: bjorn@kernel.org
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, alexanderduyck@fb.com, kernel-team@meta.com,
 andrew+netdev@lunn.ch, hawk@kernel.org, ilias.apalodimas@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 asml.silence@gmail.com, axboe@kernel.dk, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org,
 io-uring@vger.kernel.org, almasrymina@google.com, mike.marciniszyn@gmail.com,
 bestswngs@gmail.com, razor@blackwall.org, dw@davidwei.uk,
 aleksander.lobakin@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stuclar@meta.com
Date: Wed, 11 Nov 2026 22:41:27 +0000
Message-ID: <179443688740.2199510.18354202331310807632@kernel.org>
In-Reply-To: <20261110102039.1002605-5-bjorn@kernel.org>
References: <20261110102039.1002605-5-bjorn@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch adds NET_IOV_XSK, a net_iov type the CPU can read:
  net_iov_address() returns area->vaddr + (idx << niov_shift), and…
- [Low] The kernel-doc of __netmem_address() (include/net/netmem.h) still
  describes header buffers as the standard case of always-page-backed…

--

xsk: Allocate UMEM chunks through page_pool

This patch adds an AF_XDP memory provider for page_pool. Each aligned
UMEM chunk becomes a CPU-readable net_iov of the new type NET_IOV_XSK,
and netmem_address() can now return an address for it. The provider
tracks which owner holds each chunk, and keeps chunks released by a page
pool on an internal reuse stack.

> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index b986ad616334b..a3b67ef32b218 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -69,6 +69,7 @@ DECLARE_STATIC_KEY_FALSE(page_pool_restricted);
>  enum net_iov_type {
>  	NET_IOV_DMABUF,
>  	NET_IOV_IOURING,
> +	NET_IOV_XSK,
>  };
>  
>  /* A memory descriptor representing abstract networking I/O vectors.

[Severity: Low]
The struct net_iov kernel-doc just below this enum still says:

 * Examples include imported dmabuf memory and imported io_uring memory. See
 * net_iov_type for all the supported types. While current net_iov types are
 * unreadable by the CPU, net_iov has no inherent restrictions and may be

NET_IOV_XSK is readable by the CPU. xsk_pp_create() sets
pp->area.vaddr = pool->addrs, so net_iov_address() returns
area->vaddr + (idx << niov_shift), and netmem_address() is no longer
NULL for every in-tree net_iov.

Documentation/networking/netmem.rst has the same problem. Its "Decouple
net_iov from unreadability" section still says that in-tree net_iov
implementations are unreadable by the CPU and that netmem_address()
returns NULL for them.

Should both texts be updated to list XSK UMEM as a readable net_iov
type? Neither has changed by the last commit of the series, "eth: fbnic:
Support AF_XDP page pool zero copy".

[ ... ]

> @@ -345,10 +362,16 @@ static inline void *__netmem_address(netmem_ref netmem)
>  	return page_address(__netmem_to_page(netmem));
>  }
>  

[Severity: Low]
The kernel-doc for __netmem_address() above still uses a header buffer
as its example of netmem that is always page-backed:

 * Unsafe version of netmem_address(). When @netmem is always page-backed,
 * e.g. when it's a header buffer, performs faster and generates smaller
 * object code (no check for the LSB). When @netmem points to IOV, provokes
 * undefined behaviour.

memory_provider.h says MP_CAP_READABLE providers "may back header page
pools". xsk_pp is the first provider that is both net_iov based and
MP_CAP_READABLE.

xsk_pp_init() does not reject header pools, and xsk_pp_alloc_netmems()
only hands out NET_IOV_XSK net_iovs. Later in the series, "xsk: Install
UMEM page pool providers in the core" requires the readable provider to
back the header pool.

A driver that follows this doc could call __netmem_address() on a header
buffer of an xsk_pp backed queue. Would it get a garbage pointer back?

No in-tree caller does this today; fbnic uses netmem_address(). Should
the "e.g. when it's a header buffer" wording be updated, though?

> +/**
> + * netmem_address - get the CPU address of the memory behind @netmem
> + * @netmem: netmem to get the address of
> + *
> + * Return: the address, or NULL if the CPU cannot read @netmem.
> + */
>  static inline void *netmem_address(netmem_ref netmem)
>  {
>  	if (netmem_is_net_iov(netmem))
> -		return NULL;
> +		return net_iov_address(netmem_to_net_iov(netmem));
>  
>  	return __netmem_address(netmem);
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110102039.1002605-1-bjorn%40kernel.org
