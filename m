Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933A309EEC
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219725; cv=none; b=koMxiTZV/3Fn1hbOCUch6tU0wZHRy6LtEmgL7a/cwDdHULX0lATtji8a2s2AxJIxXIibMV4gd3v46+c6m7t9SNT6Bd8FZ9sTpQ853Jh/zYataS9/89Cvyhtw7GmzhZgT+5NqeK9qwIDD2Qc9Aids0tdOfoOkdgw/Pn2hm3CQNvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219725; c=relaxed/simple;
	bh=p2r4gcb42xTsxaNA5xPh+LYVuA5ynBc9KIAfNKRT2l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3gfEm72I6hhVIOviSfC6EwPZRsOZ+wpzXT9kHD+3eEX87BLaN5dCoorYiMcw6VD6+UndD0CwBXFE/zfFgnnlX0UBnhOWCqjAmrAO0zSw6bocg/C/oQwpJM/nj8k/rBY7UtlQCf/9WzZkCFi1qMJCpmQhXBNDUNtIdTtbZVMFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD+Ye1YG; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD+Ye1YG"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-3a476ee8669so790173a91.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791219723; x=1791824523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZsfW1R9N4QPstXuCZT7OiJ7xuKBOf1oZsvEYYuLcZDU=;
        b=HD+Ye1YGzIXiImlWR3zGYVXshBf+UxHvyW7WDosAG2jHVh4LfYnJv7ANuRxbCqS9aO
         2lMPunBqHs7dLxeOQAdlsEnuw7CR3QARePr80Pz8vQe7f9vMhXqZhN+tdAmYzIgsBP9x
         Vo9rJAM4G03+ppu0QNv7DR62GA0fsExz8xWjyPR8M6vbrqyb5RDwagt5rcs+je8xB+86
         qXPRC5HjoJAV59b/KiHMuvnEahkwc9gQNGWhRmr4Z3UmYyEUD6dh+S+mQ68kpn+OPUJI
         wiDWT8B8fzc+5lRXwEJVCOW4DBKFTC4m6cUmX0Gz+4OIjb6d38elRh3kDMTZqCQrOAQt
         FxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791219723; x=1791824523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZsfW1R9N4QPstXuCZT7OiJ7xuKBOf1oZsvEYYuLcZDU=;
        b=ceNNeAph4gV4Fy6DUnXOd9zJqYxG8uz/lmYI98uzrQXVzV6BFqy+QV7uZe6CHT9bR7
         JHKWgsnbWmy1/tB/eNzoIO/ByrBUMr4q3GLOuANa9xJwmquArzsS8BirADzJZXaFgJKx
         CpuGAxCYQpy5AeLGFvX8fV9KZ8TWzWxofUWvo3xkMxhI+lHGbjb98K+EuTxv+BnQDG4t
         WmGQkKS0a3d34vORnieZgF1HQPSza5JrT7rnagID+O9i+xu5ao+okw5t8qh2XFMcxzsj
         deha2OMNJmcU9rEEHDFjA4Kvf9bNDsUVMxHaSq956PiwxSYYEUTR8bgrxBJToAX0fEkd
         UK7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwRbD1Z39WvqcT8uz/mpEzpWytSkEGIifSBZulwoYEmV3/6vpDQU9ScvcNFsoBvviOU+88=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQmMOsvrYbEUfGd5fci2RB4EbYNNaC06E9rXuMVrkPdKv77WyV
	oqKJ4E5oNWmOZhnqXNcdq8YnGffTnW/e0wg2DovSP7qs3V0pkaZtESr2
X-Gm-Gg: AYBFou1i3Aq6aZ8iGl5HrkyeRag437n9vz0lDLEWPEkvKlCaA2hvyAIFglMxKvWqNwh
	5X2rB6LbjzAwSAf/PvUFwMB/rEbKsLv6QEz3jeXaCuOqaJm7zfLBvq+8wJ7n7xS/RJdt/qFnDhj
	oOcLDFro3EapwN5q2DCw+KP5iC3Gz+bA7y6iS19Tw0qF1G+u881T08o5fnY3h7pDuoXkc/obMwT
	T22T90tNOAV4LEoq0+eTrxbBA/ilhoc3CdqTR6rqr3JnNzilXRgGEVC9ZnMeWm8fNqeJtkrEASs
	HoiOkyojNNv1HFqFbql3nJMP56E/5pJuUjMY6ldHhUNwudVyZg++HO5UgzCyowIKultNvzWXIR2
	Rv0LQLYEKtrtwPR9zBJCND5693WwqDU7A/gtZwNyo3o07SQe1W59C8ZF1Fh3AIberDDXikohNus
	hyPkret7TQH4TAooAdSbdYohnv0Bur6vZrsgkjNoHhTI96xTvkTbyBP0p8SPbkahg=
X-Received: by 2002:a17:90b:57c6:b0:3a0:c276:1ec0 with SMTP id 98e67ed59e1d1-3a7872b6af0mr6425813a91.28.1791219722834;
        Mon, 05 Oct 2026 10:02:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd0cd76bsm9240167a91.2.2026.10.05.10.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:02:02 -0700 (PDT)
Date: Mon, 5 Oct 2026 10:01:57 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	io-uring@vger.kernel.org, "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, 
	Weiming Shi <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	David Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>
Subject: Re: [RFC net-next 06/15] xdp: Track non-page netmem in receive
 buffers
Message-ID: <asPXa7k-_drxXiI0@devvm7509.cco0.facebook.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-7-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002190018.696925-7-bjorn@kernel.org>

On 10/02, Björn Töpel wrote:
> A page-pool memory provider can give net_iov buffers, and
> virt_to_page() does not work for them. An xdp_buff holds only the
> data pointer, so code that returns or converts a buffer cannot find
> its net_iov.
> 
> Add NET_IOV_XSK, the net_iov type for AF_XDP. Add the internal flag
> XDP_FLAGS_HAS_NETMEM. When it is set, the xdp_buff holds a netmem
> reference in the union with the devmap TX queue, which only devmap
> egress uses. The flag is cleared when flags are copied to an skb or
> an xdp_frame. xdp_convert_buff_to_frame() sends such a buffer to the
> zero-copy copy path.
> 
> A fragment from a readable net_iov area no longer marks the buffer's
> fragments as unreadable. The skb layer still treats every net_iov as
> unreadable, so such a buffer must be copied before it becomes an
> skb. Later patches in this series do that.
> 
> skb_shared_info holds kernel pointers, so it cannot be in UMEM,
> which userspace can write. A netmem xdp_buff points to a
> skb_shared_info that the RX queue keeps in kernel memory instead.
> xdp_init_buff_from_netmem() sets this up. Page-backed buffers still
> use their tailroom.
> 
> On 64-bit, struct xdp_buff grows from 56 to 64 bytes. struct
> xdp_buff_xsk stays at 128 bytes on x86-64. Where the largest
> alignment is 8 bytes, as on s390, it grows from 120 to 128 bytes, so
> a pool needs 8 more bytes per UMEM chunk. Only helpers that need the
> netmem or the fragment info test the new flag. Page-backed receive
> and return paths do not.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  include/net/netmem.h |  1 +
>  include/net/xdp.h    | 56 ++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index e6dff0b01581..76e4fe878863 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -68,6 +68,7 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
>  enum net_iov_type {
>  	NET_IOV_DMABUF,
>  	NET_IOV_IOURING,
> +	NET_IOV_XSK,
>  };
>  
>  /* A memory descriptor representing abstract networking I/O vectors,
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 07231adfb5f8..80931490ca3a 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -11,6 +11,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h> /* skb_shared_info */
>  
> +#include <net/netmem.h>
>  #include <net/page_pool/types.h>
>  
>  /**
> @@ -81,6 +82,8 @@ enum xdp_buff_flags {
>  	 * XDP program is not attached.
>  	 */
>  	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
> +	/* The txq/netmem union contains a receive netmem reference. */
> +	XDP_FLAGS_HAS_NETMEM		= BIT(3),
>  };
>  
>  struct xdp_buff {
> @@ -89,7 +92,12 @@ struct xdp_buff {
>  	void *data_meta;
>  	void *data_hard_start;
>  	struct xdp_rxq_info *rxq;
> -	struct xdp_txq_info *txq;
> +	union {
> +		/* Valid for DEVMAP egress programs. */
> +		struct xdp_txq_info *txq;
> +		/* Valid for receive buffers backed by non-page netmem. */
> +		netmem_ref netmem;
> +	};
>  
>  	union {
>  		struct {
> @@ -104,6 +112,8 @@ struct xdp_buff {
>  		u64 frame_sz_flags_init;
>  #endif
>  	};
> +	/* Kernel-owned fragment metadata for non-page netmem. */
> +	struct skb_shared_info *sinfo;
>  };
>  
>  static __always_inline void xdp_reinit_buff(struct xdp_buff *xdp)
> @@ -138,7 +148,7 @@ static __always_inline void xdp_buff_set_frag_unreadable(struct xdp_buff *xdp)
>  
>  static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *xdp)
>  {
> -	return xdp->flags;
> +	return xdp->flags & ~XDP_FLAGS_HAS_NETMEM;
>  }
>  
>  static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_buff *xdp)
> @@ -150,6 +160,10 @@ static __always_inline void
>  xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
>  {
>  	xdp->rxq = rxq;
> +	/* Do not initialize the txq/netmem union here. DEVMAP generic XDP
> +	 * sets txq before this helper is called; receive drivers set netmem
> +	 * explicitly.
> +	 */
>  
>  #ifdef __LITTLE_ENDIAN
>  	/*
> @@ -176,6 +190,33 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
>  	xdp->data_meta = meta_valid ? data : data + 1;
>  }
>  
> +static __always_inline bool xdp_buff_has_netmem(const struct xdp_buff *xdp)
> +{
> +	return !!(xdp->flags & XDP_FLAGS_HAS_NETMEM);
> +}
> +

[..]

> +static __always_inline netmem_ref
> +xdp_buff_get_netmem(const struct xdp_buff *xdp)
> +{
> +	if (xdp_buff_has_netmem(xdp))
> +		return xdp->netmem;
> +
> +	return virt_to_netmem(xdp->data);
> +}

You keep adding methods that are not used in the patch where they are added.
I keep getting confused :-p

For virt_to_netmem, maybe a meta question: does xsk pool need a treatment
similar to the socket path? Where we did s/page/netmem_ref/ ? Then might
be less reasons to special case?
