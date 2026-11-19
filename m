Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107078;
	b=wpUO2pROeHHhNQEAtMdve46b8L9CYPlcPPFDpj8M38yFps2P8pg4LtdAPPwm5ySqzebr
	 dJGAmLfaKCskAf5w0MikGqsyqIvOUDLaK5j+k1QRgnRCpa7Jc61mQxc++iTdqVSLrmgJV
	 wENr1BgnUofeaC9P9wn7n/JbON8zTeJr3Cjd1LtealUId4vQ/hBxbmdb2+fvvJuhNHlto
	 +EoLFT2tzPppmgUdGdnnOSkl65j1C1YLGF2s0EToDNdihQf7r5m659oc4F+pGImHqrevH
	 pWOuAZ9EFLksm1pCveifOnHA4yux4cj+ApHnBUWWGe3X6X+WHbbnj9Stww1Rhd0/TGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lRdO4Y9UH2iKezbocQeecDxSl284A9tGk8f3DKBUEvw=;
	b=KE08Wqr6mqFVaECxPJ+hu0nNxeopP5RaHQblsNl6oYBggtvkEw8TUOQtfQOJCn16dzh9
	 QvcBVkvCOGM0NTG/vozqTWIeq/QJsERVqwDCo6fFkX5bo7D9aaytAPvt3fUHjUt0JtBRF
	 eoDpnJoeWDfX04wRP+Kuh0sNXbmwMYXYY0RRU1H3LwtxY4C0ZN8MxHjDs9XKy77A0Zxn4
	 OG+IEZ7Rp5I3BT9o+l6fDKESqMiL052AygEZWzauh/e0IpdE2sI1Z7TqWMU55+OsmQeCd
	 K/DCoCsZ3mHOjsiyFMd/Rt7ipAHex4UdDJj5jyKHfqXwQfpvRRb/q7NjiN/r7WnO2oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W5wO6cSp;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3366606A338
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 16:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3366606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W5wO6cSp
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3b3fb6d5edeso6846a91.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795107077; x=1795711877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lRdO4Y9UH2iKezbocQeecDxSl284A9tGk8f3DKBUEvw=;
        b=W5wO6cSphMtufLh55O1QNHFTjjb1uZu5SGtB5W7M62SmtljwEGk7x3+bhzJ+DREFK6
         umUp6pwX5j+HBfVAZA44kvYcenfW2ZXBeKRbIgFV02b5iZ0jdHoB5mQNj9FdjY3Q1vtw
         bhiqhmaJ3qXePUgF5vYOCQwnUqrgTLMFRkJ2LXEBXHMT5utExV3QpMGWC5UUblaatWXr
         jPJsVBx48ePyUXCmmGeWvOnStA4jjHK9GMCxpyFdG4QMocQqrY/5IPAsj0+zxTL7GgEe
         hkthLF2Kph1SFQXMlKWX2vB2SzT9y2FtH/HwmLi8Y1kUI3sVT4mkiJAcUcDqcgFItZ3k
         tvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107077; x=1795711877;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lRdO4Y9UH2iKezbocQeecDxSl284A9tGk8f3DKBUEvw=;
        b=2SVcp5wY86ZhubQiV9L3GANOk9FuFCzsrS/Tn06unGtlSju8z3rMYZar6hJ/2L0rcm
         Txu4uV06yNwQMeoKvcLYkzDeKE6LzpZvXPxKldrCWMe06yrj60pyA9S10yGxYm3ge3Ta
         PXH/W5K7/DxSa2h1UQSR5j3Z890k39lrCkIcGayGHsrq9LQDJYPzDN1ySkELSUko8IRa
         gHeTp4XiTaeTFnovSrjPw0OQa9DW8J5ssThdyMJ4w54k4NvVTyUv5HQxzoqwEIMf/EXK
         jm9Oz3flOAZ8J0B8MU+SCtrn0b/dbEQWVW149lcshfReet9kv2Cg42NbJZehwSCGIm0H
         E+gw==
X-Forwarded-Encrypted: i=1; AL+hErGrL3zQ7WxZAii+T7gGXFjUu3GZBxZcrwEI2k4gNRcoPD9ufrXcvi7vweKsq+46zpD0ji0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9OvE5NN1FQBxs9PqwRTC7erdCFVHdr8zXezgBp3djJaVVMb6B
	L8yy2AdDoCT1g292504BDtfFC+HeEBOpQZiwHXtEww4Fod5NOA9Xq7/Z
X-Gm-Gg: AZFdTZdZvj4pjusI2hhMTZnSodpBBXFzDOYGj2CKLMQOVu+3IKLFRxVF2vAITsscOoP
	3yypPOX6pPvTRSrRP+MTF/qcWiEJvENb2DF+PQmAJao1gzRVQTrhFATZdGZ1Bc0/U91twImyf5G
	i3qZxWRHiB25mKaCo+N63pH5JrcJ3YXftqOYjj8uYkBv5tpIMyysw2A+WBmadmJsJ7WdycQ9eOX
	LgAVEy8WLDilFTPbrjNWGc95LO/ZkrIjkQ56q9TgV26MvABdIIfWI+nE9h8unwgZFud0XIldtjs
	kv7u16kRpTr0k+Wkn3qGnpEKaDBXwp2v+YKhK0I12Fx5G8AK//1Ygaxcu0n1EwB30TWGa9EC8EQ
	E7s2lqbGcl4UujUgWZfIvx+1FB1s3Zoy0eVgTrubEAjQCTkXJ51fbRuMUCNtDpU+iCo9UH3cpOW
	YxFQ+azGatQaOrG7dD/plKzIxD6FN6UhlCWnlDIbaHj5vT9aO8b7nMVSJiIrW09BZrGVc0bMlVn
	CKTQHVHk+D0F0aGZrg5w3PcNRzv/PuqU+ggmUAdC7wDD0JG83oq1K8XQC1yZ1Zzd3ixlA7a+EAT
	S4g2i49S4rKFCgt5Vo0CVWY=
X-Received: by 2002:a17:90b:5407:b0:3b3:b0f4:1bf6 with SMTP id 98e67ed59e1d1-3b3d074d82bmr6300014a91.22.1795107076893;
        Thu, 19 Nov 2026 08:51:16 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c13sm129647a91.14.2026.11.19.08.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:51:16 -0800 (PST)
Date: Thu, 19 Nov 2026 08:51:11 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	yoong.siang.song@intel.com, kerneljasonxing@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, tianyi.gao@linux.dev, 
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net] xsk: reject TX checksum requests that overflow
 skb->csum_start
Message-ID: <av8o-Egamsxv-uWn@devvm16445.scu0.facebook.com>
References: <20261116162834.30087-1-tianyi@cloudflare.com>
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
In-Reply-To: <20261116162834.30087-1-tianyi@cloudflare.com>

On 11/16, Tianyi Gao wrote:
> xsk_skb_metadata() sets the u16 skb->csum_start to hr + csum_start. With
> 64K pages, csum_start can be close to U16_MAX, so the sum can overflow.
> The checksum offset then becomes negative. With XDP_UMEM_TX_SW_CSUM,
> skb_checksum_help() triggers a warning. Without it, the device gets a
> CHECKSUM_PARTIAL skb with a negative offset.
> 
> Reject this with -EINVAL. Use the limit of skb_partial_csum_set(), which
> also rejects U16_MAX, the "not set" value of transport_header. That
> helper cannot be used here, as the skb built for an IFF_TX_SKB_NO_LINEAR
> device has no linear data.
> 
> Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-203545@kernel.org/
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
