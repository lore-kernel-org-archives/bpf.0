Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439264;
	b=nHnnv03KAs6ZXWHk8/LPZQ6E1ssYrqkwRNEADleOlIHwvCrEMDEoUx796fXohBVr7kss
	 wnha06i026p7j+y37XB8+/pVJFsErDE+7ILUnl7as7EdKcjZlhQtffolSIaOkdRRvy7Ws
	 rontPXYqy1Cgm3R4COXrIxQ66K5+owbwoBvOTjvkHJkvCbI+TEZT2X0kUytguyEojY7+M
	 SIFwJ9TICKjNKxkqO9vv+tAosTIU4dZS0TAbH1oITYj0/+WBe98Q6eFrYZ+YB447uwIGr
	 eeEpwKIlm5POMR0sl1ebDhPo2NkaBlihXoPtemMVcDQDKbhOqpZCaUInSmiWNXfJHdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=eE9X9IsI4DGKfcKaEqbUpAyTJeGhuPKiIV6pCis8+mc=;
	b=WHVLhGlgXFVsJg+Itne8KLX6PiUstePc4ZOmkNydmOdxPsCaaEcUqoH5plNrlrqT4wIo
	 aazhdczHVzz5i6kF3bFO4U6rQ+aD2Hxj4+mvu5PbWa8Xklb8OCFqIWW/NAMZgF5kuuRsf
	 vyC+ybz8t04/KNW4RCLz4ZloNG5Lmw/kMCG2kVyuc2Qzv/7fmYARukc0HIT1Tc9J3/WiC
	 52XpswZ3l11GTolzArq68Y067o4ijLEruSWt561H89lWGb3aY/gkvGUDSscBgOjwiT4IN
	 kd0ZwoHYc9ait9RlSFYucL/+5wfU5IIAu5bfH6Yx+RIA/dJD8cPED3crvrZ1NHLdKfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AS4FCx2D;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD133606A8A5
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 23:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD133606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AS4FCx2D
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-19305bcb6d5so1264887c88.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794439263; x=1795044063; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eE9X9IsI4DGKfcKaEqbUpAyTJeGhuPKiIV6pCis8+mc=;
        b=AS4FCx2Dzy3knLqQU0KfBNqF5KUSlkLF7ulR+nDPovTotbPJqyuHWJZbdiqD0hnert
         Fjrod0191CeZY5GKnOqJQFXEdEHnEc9RnGOSGH5h4p748bHPLDNJ0byXo7dSycqqcU13
         OyILZU4dK6tcd2Ci05DZ8FF8yEvMkGJErFQBNpoVdDDqtfOvSHLZqPU/NPmpqdQ/5ur1
         G0ewEQXkjx0av1/XfhNJuB0qBTb2u6LImLfzoX4gBMIL2Eoag2sL2m+gsCjyN778IkpV
         3mYuBiwwgs25VP7eFbwR1g1h0EZbnCDVpu2l2LNGRuQnz/SV5so618qySg3qt6ExWr2C
         Jtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794439263; x=1795044063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eE9X9IsI4DGKfcKaEqbUpAyTJeGhuPKiIV6pCis8+mc=;
        b=H7GD9hiwNaK5zwD08iM0BPo7y0aNgnOUg7xnRcckTo4E6zAAMrO2cSYjdjPtuA2rp4
         odxkm5Vmr/bOIjFxgPUTaFyMjcI6CbmjFFfTILg+PWHOzOnNzU7+CItu2xtvVADbmFx4
         1lIVr1N+XNZbKf/6SsqJZRrG/8lUY7DkTll82HbaslSVVKwN9Gl6NzyIjLdANx1zOv3L
         PzE7tXKWNeuHV0gHqXeyaOmxem8mmuR08YsXI/4OOBbgZn4F7niSLcQa6z8I3/8WWvjy
         oxNlk6vAT0SBYMyvYd+d6lGjILV7yeO4ogFoiigr4vOjWADR4Nr+IF4KsaGNRpJvmaX7
         6yjQ==
X-Forwarded-Encrypted: i=1; AL+hErHe5izaOxDhzraKQXKe49ZBKAP8uaFEUEkBkV7sXvkgIv9hRxIPOJ2jtJiNO4LfeTHok6M=@vger.kernel.org
X-Gm-Message-State: APuU4Z917y/uQ63F6N/ZpK21cCT/DCFcjXltkHrDvebWoiHc7iQkzjpd
	4XIKKnXCeoTHGImyWWZtbRKolsh64p9CcCKlm0+EStx4mKio1j7WOOds
X-Gm-Gg: AYBFou1UuKjlHepLBuks76PjFwA1UChHDU4oDvQ22R9G9Ch8Z5o9fWaOFw8ZAvNoXWC
	Wn8xfAMncNekveQwohd/GiIDT17gdfrq73yOee4OxkqpLhTmOvyyh/yIglCwcIfc5XYmOQBSsln
	dtnPOYxQfXBO4IGPohJyi9qhZz+JnrsBm+pt3iowgdQLl7pqivayLokxiMKX/17RVCI79hkDJZG
	py2gMmZxCkJ9WCW+YZv2NowV0oAyfzu5X66brKk4ejGDTb6DJlo3BJ9YBiCo53VE1sV9BQnlc/I
	ychA6WaVvWX1jFdZgXevTZ/36ylQkcsFnEcnmwvoi35lXESXLxnIUxH8Bv7bFN4nvQIgQXmCrhQ
	Xjuc0R/bX2+eoB8MrDKY35XSMz72BNpAsQbFFnnpOuAJHnY8MLBQA3iNTWRAcd3BJ1+qGP5yYrx
	n3yV5S2SMg1nxIoBTJzOfYowY5fTsGPo5tuoZ/1JuPUcZZzTb1vRuBBOTVCvN8Mtrci1BQdt5F5
	QW2qN+c0iHPujbbzFN7nDf9HMw8gvSVJ697k6mew1ULCfOLC0yQoO1hp89pmDtu48MIkcelqo/H
	2xMi+u3fPPZdRlOtvoK8ebI=
X-Received: by 2002:a05:7300:1899:b0:376:b957:c01 with SMTP id 5a478bee46e88-376b9570fd3mr5155040eec.16.1794439263001;
        Wed, 11 Nov 2026 15:21:03 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:66::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm19921294eec.5.2026.11.11.15.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:21:02 -0800 (PST)
Date: Wed, 11 Nov 2026 15:05:25 -0800
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
	io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 03/11] xdp: Copy buffers with restricted
 lifetime
Message-ID: <avT0b5T5trWZXAMo@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-4-bjorn@kernel.org>
 <avOZa6jLnmvYkk2H@devvm16445.scu0.facebook.com>
 <87eccra46g.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eccra46g.fsf@all.your.base.are.belong.to.us>

On 11/11, Björn Töpel wrote:
> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
> 
> > On 11/10, Björn Töpel wrote:
> 
> >> diff --git a/include/net/xdp.h b/include/net/xdp.h
> >> index 07231adfb5f8..1105bb9e3292 100644
> >> --- a/include/net/xdp.h
> >> +++ b/include/net/xdp.h
> >> @@ -81,6 +81,16 @@ enum xdp_buff_flags {
> >>  	 * XDP program is not attached.
> >>  	 */
> >>  	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
> >> +	/* Internal: the head netmem and the shared info are in &xdp_buff.ext.
> >> +	 * Not copied to xdp_frames or skbs.
> >> +	 */
> >> +	XDP_FLAGS_EXT			= BIT(3),
> >> +};
> >> +
> >> +/* For a head buffer that cannot hold kernel data, see xdp_init_buff_netmem() */
> >> +struct xdp_buff_ext {
> >> +	netmem_ref netmem;
> >
> > nit: netmem -> head ? and the same for xdp_init_buff_netmem netmem arg?
> 
> Yup, will fix.
> 
> >> @@ -138,7 +153,7 @@ static __always_inline void xdp_buff_set_frag_unreadable(struct xdp_buff *xdp)
> >>  
> >>  static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *xdp)
> >>  {
> >> -	return xdp->flags;
> >> +	return xdp->flags & ~XDP_FLAGS_EXT;
> >
> > The only consumer is xdp_update_skb_frags_info, so probably not worth
> > filtering out XDP_FLAGS_EXT here? Or is it for
> > xdp_update_frame_from_buff? Can we explicitly clear it at the caller? 
> 
> It was for xdp_update_frame_from_buff(), but looking closer EXT never
> gets there...
> 
> I'll drop the mask. Thanks!
> 
> >> diff --git a/net/core/devmem.c b/net/core/devmem.c
> >> index 8f190b574beb..dea4a4a17e86 100644
> >> --- a/net/core/devmem.c
> >> +++ b/net/core/devmem.c
> >> @@ -698,5 +698,5 @@ static const struct memory_provider_ops dmabuf_devmem_ops = {
> >>  	.release_netmem		= mp_dmabuf_devmem_release_page,
> >>  	.nl_fill		= mp_dmabuf_devmem_nl_fill,
> >>  	.uninstall		= mp_dmabuf_devmem_uninstall,
> >> -	.caps			= MP_CAP_FRAG,
> >> +	.caps			= MP_CAP_FRAG | MP_CAP_RETAIN,
> >
> > Not sure I understand this part, can you explain?
> > These are MP_CAP_RETAIN because they are unreadable?
> 
> No, RETAIN is about lifetime: the stack may hold page pool references
> after the RX poll, e.g. skbs on a TCP receive queue. That's how devmem
> and zcrx work; without it the stack would try to copy them, and they'd
> trip the DEBUG_NET check in skb_add_rx_frag_netmem().
> 
> A provider without RETAIN gets copied, so it must be readable. I'll try
> to make that more clear in the kdoc, and probably refuse a provider that
> is neither.

Ah, yes, thanks, I did miss that warn in skb_add_rx_frag_netme, makes sense!
