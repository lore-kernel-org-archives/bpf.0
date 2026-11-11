Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436884;
	b=33Yg3Fc90+hGzWZNNUdKG+iRg4ktvVieQioYkI0EDqjFZ4KZkhveCyhrpwGx7BD2qjor
	 IE+Q6nHtoEyUTZdkvhqA68/2vuR/78ReHbBJXvtRFK5vnpBsrmyTJz3K6rVYw+lLxytC0
	 c529b+4Y3xAn4kBoSlKl7j+Sjp+OL67cUI4IUa8aqWJMBrUtcdDYmBfXKPounrEjdku8w
	 jzEmWkFmc54tvUsh/sbn7GslVHf5jtIJt2WAJ0JyRCkmhTmkltd1tnojHSE0LwZHKxtqF
	 qXjUhgHqQKvTu4FKsP4EhX09WFDuzQPnFHNf/s8MGz+uuKz4mdyvdgwK9HtjPLNxrPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436884;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1ZszL408OtVOYhxcADqDXyCFPN2IPKvweH7l3LeJgEc=;
	b=Kd4AYtacdyeXhjp4jGsydUorxKXwICT8AXlRcmEr5rBzCNsJ1YNPT/kKdyN/RmPi8gAk
	 mIYXC12hwHIGXU7/P2sKSSAoFSC1EXt8kNx2lK7Y8VLw5ZNZFnKbkQYVdCMgbAp/4un1M
	 Dar3XvOFzUIjBci9a1aYd0+lzQn2NVuJFp8LHeh5W7B3FvWEU1ct1v79YwDNDzzD5cIdr
	 wAagb4h0o3GSJBOOlLHuzbpsaMRE05NMlGdVvIbHTihBuW8bQwN54p1QR0E0ak9MPnv9J
	 UzJ5FNj3Cc7GKK02oxY7tu/Gqovq0mWgSKs7dsxlht/BkTfSppk4i2/4L0N4A3QT0WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhGYVF1A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7B606A336;
	Wed, 11 Nov 2026 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhGYVF1A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6C21F00A05;
	Wed, 11 Nov 2026 22:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436884;
	bh=1ZszL408OtVOYhxcADqDXyCFPN2IPKvweH7l3LeJgEc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VhGYVF1ACkNkJmWQcgrSe4xq0u7p9IcPv50kYi0r0zkpK9kBgNCeLK5j/JWEIVewS
	 SYM1BlCdSaKoa1Q8lDng/fxwNyw3HGDnK5lIxS/JkjCjpsng/iaSRridBJUevSX+DZ
	 HnMAHRW9YMcJQzDvvOMG02pMh4btDUUj1zh8liWLiF9mlwpcdc6DOmEdKpsdho/OYF
	 2ET5J0xk+iq1mFj+j2/PPi6p8RCK9S1l0GU/2PYech/JAwq7V1P61c8Sv8z7vRV9Fm
	 OgpP++8N1IrCl6T6jZndpm5cJdtQrapg8uQJ940/ocRUORHk+P3LsAIipcog1dAgC2
	 sUMFE6ef483Hg==
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
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
Date: Wed, 11 Nov 2026 22:41:21 +0000
Message-ID: <179443688151.2199510.3920075646889577971@kernel.org>
In-Reply-To: <20261110102039.1002605-3-bjorn@kernel.org>
References: <20261110102039.1002605-3-bjorn@kernel.org>
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

- [Low] Documentation/networking/netmem.rst, 'Driver RX Requirements',
  disagrees with the readable-provider semantics this patch adds.

--

net: Add memory provider capabilities

This adds MP_CAP_READABLE and MP_CAP_FRAG memory provider capabilities.
The header split and XDP restrictions now apply only to unreadable
providers. A new PP_FLAG_MEM_PROVIDER flag lets a page pool take a
readable provider from its RX queue. devmem and io_uring are marked
MP_CAP_FRAG and keep their current behavior.

> diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> index 6871dcdd700cc..39cb75339704d 100644
> --- a/Documentation/networking/netmem.rst
> +++ b/Documentation/networking/netmem.rst
> @@ -103,6 +103,11 @@ Driver RX Requirements
>       which knows when dma-syncing is (or is not) appropriate.
>     - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag iff
>       tcp-data-split is enabled.
> +   - PP_FLAG_MEM_PROVIDER. The page pool takes memory from the memory
> +     provider of its RX queue, readable or not. Page pool creation fails if
> +     the provider is unreadable and PP_FLAG_ALLOW_UNREADABLE_NETMEM is not
> +     set, so do not set it on header page pools of such a queue. Without it,
> +     PP_FLAG_ALLOW_UNREADABLE_NETMEM selects unreadable providers only.

[Severity: Low]
This isn't a bug, but does this entry belong under item 4's heading, "The
driver must use the following PP_FLAGS:"?

PP_FLAG_MEM_PROVIDER is opt-in. The comment in
include/net/page_pool/types.h says "Take memory from the memory provider
of the RX queue, if one is installed".

devmem and io_uring pools still get their unreadable provider with only
PP_FLAG_ALLOW_UNREADABLE_NETMEM set, because page_pool_select_mp() assigns
unreadable providers without the new flag. The entry itself also says not
to set the flag on header page pools of a queue with an unreadable
provider.

Item 2 above is still an unconditional requirement:

    2. The driver must support the tcp-data-split ethtool option.

However, __netif_mp_open_rxq() now checks hds_config and hds_thresh only
when the provider lacks MP_CAP_READABLE:

    if (unreadable &&
        dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {

The MP_CAP_READABLE kernel-doc also says such a provider "may back header
page pools".

Could items 2 and 4 be reworded to cover the readable provider case? As
far as I can tell, this text is still unchanged at the end of the series.
That leaves af_xdp.rst as the only place that describes the
readable-provider driver contract.

>  
>  5. The driver must not assume the netmem is readable and/or backed by pages.
>     The netmem returned by the page_pool may be unreadable, in which case

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110102039.1002605-1-bjorn%40kernel.org
