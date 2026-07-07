Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2223D648F
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417738; cv=none; b=c5H2Q6dOJepCMgOyx1PfZrHr1HgS7UcM/250rF8hxYHGf3PBcmFOpaENyfZ58FaPZh7p2GJyKX8xlOWZJz5C6EM14AVCYblFbohcbgkkZcEYRtWbucETKYIqFqwY0ySpHrbt9IMIp6c4KaMwYNwWMfmXE1H3Y5DxlC2jRkxJyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417738; c=relaxed/simple;
	bh=dxErGz/gtuJMMd0ZCUwsU0QRw3tKi/SSEtrZ2mEv2ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s26jq+mlx7sPutK9yDUIYrIBu5LDR4FrU8wed8uX049BOWKgP650Bo9F1j/lRGlevuxpHQJ42X+CA9UWp7kmXFRGnDKpB8tGYkhNvjvAm/8NFLpIO7vwYqB4u9U94GEgK1GHObAUg6LDNOFojotq8yF9doITMlbs2sy+Y2iuqF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=WmmDCAQc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="WmmDCAQc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso16948395e9.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 02:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783417733; x=1784022533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs3A+LONAtni+h8Qp1wmlltG03uWEkxp59/Fd3Ox+rE=;
        b=WmmDCAQcONqxk8QJsEcXqFwhg5sYGEf8xrpamiqLkwYdRbxOBRrJN/i29BzoAXcTgS
         k5hXvOuvttmuf2y7ZHOViUajJuhaMkyUBDWR8eg537kXOx/1jz3tuhX0ifR88nk2tJ+b
         l9WQNxWWuUIv3OFmvIrIpcqAo5LyInMH1s0WBaSzBD9/UMuiTDXrF40U7uP3FpFT4bLI
         AHSp0whB9b9JMnJW4L7eYN4Xgmh6NdnDe73jLVji6bS6JBMlSMQh04uNMmuverWCfw99
         JXr8HgmQOS6ah49YklfN+e0+QNbBDQuVpHn2e4hprBvTK+1iHWg1gEJy5vjEdHG9Q3i7
         aQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417733; x=1784022533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qs3A+LONAtni+h8Qp1wmlltG03uWEkxp59/Fd3Ox+rE=;
        b=YN85rSBgXye0xNSWZmamSmEDric8t0dS86/NZ3u/Qd4wnZyugrX3XPvZHuZ5IrXJmk
         caNec1yBdVSCh0VEsC4jI9CPCZxudu67AXVClN+f2ZwC21/feQymu/QvJpMhqK7ZnNZY
         ipxqixivrzuYj3FfF3ImFdTZwfW2hAmVoXJ66+JmcMh6D3g0/xtVT7cW3aU6nTLMiUC/
         tgONqRWDODVHIv8rER0pQAl3dLz9jBR8Bn23/LZguDZflHQiXXNAE7c1PZxr78zPkbSQ
         Lj5euc0UU2gZOc1oRwauRjGJSuPM/pYMlG3es6CksMmpnoSLxjJdKPTf2r3CfVYKhRMW
         hiXw==
X-Forwarded-Encrypted: i=1; AHgh+RqFMJAq6yk16k824D79Iv7shl00Hu2lRc0NUOmnmv/wX9NCXdHjwn/vitcaSIjVGUUya/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gx/OSuzsv6bVtM8kFwDaCHVQIS6qxy8cHKDxh7K5UivzVoOR
	lEvG+cUZmumCpoAtFdVkyZG/zn9h5S8xwoe9TKEkuINrpvA5fOC+XohciVyrvS1Pi5A=
X-Gm-Gg: AfdE7cle5eRHdznbIWv5tpIy0ATVF/uCJJFPHYvYbcySLaJ5nxqsseYGmdkYObkysKX
	4YcBQeJLirBJjhU8yV1jeKT6NPq57HgavpE7829/9O8jTDm+23rJnzD35U6zooyDQoYvtdkUfWq
	aRxwIs6RfNb6RgjnB8hwWxTL1zavfjMum1jzPhgDNIkuSElfruVkSEFTvBPWcrpA1HPyNJJK0YH
	32ChFiFJ6bj7InqlgC31TKSSHHaIM1ExUC1tJH+FA64Zxqtfav8OghukjItwj8mNpCTc5WS2zYX
	/e9vURQ7jh4kr+4CL77eflkSHJgSKUGwvYfpDXizWHmmKUvsGo6VcN38VJh72igJNB/kJ3akODs
	gLMZdD36olyXhY5Oekk0UI57mvA9aN/OlGokOX87tTKWUSxuNFjltSJnGCf8L2m6b5jhUQpNMbt
	ME9LcGw69sUC2xF6UHd8NOdKY/3TSdykQXjCcMD6zNNoayHIbbJpz6tEp3ZLEluyyoQ8Ss6uIqm
	BJbw3495FoY2AOBiXodlcZPizYr5NcVYo56tL06ZyDtuxwJFpHWcPWzh63A3pBUdrZIUL2iXg==
X-Received: by 2002:a05:600c:8b67:b0:493:bd2f:c5dd with SMTP id 5b1f17b1804b1-493df08c35dmr46181645e9.21.1783417733495;
        Tue, 07 Jul 2026 02:48:53 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0078d49sm47904175e9.0.2026.07.07.02.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:48:52 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:48:50 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Alex Elder <elder@riscstar.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Avoid freeing and re-requesting IRQ during
 XDP set prog
Message-ID: <akzLgrzsw4xYmnLH@aspen.lan>
References: <20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com>

On Mon, Jul 06, 2026 at 05:17:58PM +0100, Daniel Thompson wrote:
> Currently stmmac will run a full cycle of IRQ tear down and setup when
> setting up a new XDP program. This makes tuning TSN systems difficult
> because whenever a new XDP program is installed then the irq threads will
> be stopped and restarted which will undo any thread tuning.
>
> The problem is avoided by removing stmmac_free_irq()/stmmac_request_irq()
> from stmmac_xdp_release()/stmmac_xdp_open().
>
> stmmac_free_irq() implicitly synchronizes interrupts and, with that
> removed, I was unable to prove that later actions in
> stmmac_xdp_release() are safe when there are concurrent interrupts. To
> avoid problems let's also move the code to disable DMA interrupts earlier
> in the sequence and explicitly sync the interrupts handler(s).
>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> <snip>
> @@ -7156,10 +7201,8 @@ int stmmac_xdp_open(struct net_device *dev)
>  	stmmac_reset_queues_param(priv);
>
>  	/* DMA CSR Channel configuration */
> -	for (chan = 0; chan < dma_csr_ch; chan++) {
> +	for (chan = 0; chan < dma_csr_ch; chan++)
>  		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
> -		stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
> -	}

Sashiko picked up that stmmac_init_chan() has the effect of enabling DMA
irqs, making this code unsafe.

Given stmmac_xdp_open() can only be called on a running interface (and that
stmmac_xdp_open() explicitly sets sph) then re-initializing with stmmac_init_chan()
should have no effect and we can drop that as well.

I'll double check with a code review across all the dwmac versions
before pushing out a v2!


Daniel.
