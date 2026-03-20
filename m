Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E523750D4
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041842; cv=none; b=g5xkgdwPCO+7c8cX9f3WLfEWQnktSxlqyg5o2qNI5HKkqXJj9w1Duf+Rcw5+1SXQ7GjQeqNBGZwmEPUSJ6rhWsezZ/aB3qX/eKVO7Mi/6uR5kw+mthq4SyFguOIuI2vSYh809O7/I7Sz5wv/C2yUq3ySuHq3A7QyfIoZNvUmYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041842; c=relaxed/simple;
	bh=ozLFzhpVI2O2/f4t79l4sqzEcVkJzPQSj+jGAVH4sPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBviAuqhAT+bmg5cvThmyyRlq32vR0flu9sX69HAS/JxrUpiglFGH/6mIU5meghoXWM+xyuwZiNxN2Xy7fKrF/H1ZJP6EPolZQi6pWyiedENWc4LIi34Ez99wXDS41tJEZtNBBSnW7E3bDzysusbI3+tSyxJPdcGBuItrfrHE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRw4CTbC; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRw4CTbC"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4e9694so2494438c88.1
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774041837; x=1774646637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cc7L1+/6dVTTAc1rDpaFmgif5bqTxN/xlHF2dS1giug=;
        b=nRw4CTbCTsZveqJWZk+vOpb0upPF89+gzcVtzmiCNpiNQiMatFK3zM9pyTl5X/WCRZ
         jsvgykq9tv2XSArjzHu6/0GFfEaIhBAj50oYrf8LtGcwwsH/XqAKrlX6lf7OHR4UI1Zc
         xNBDBu150PCT/fvNJv18OPh3KhQ68+0PT+2SQohYPUvr3ZYZSzuY43m/CfR864EzVPXp
         KvI31anqfBXn8PL1DXv9F+dPsUqFJomWLbZOfivTe2vsbLUQprjU4l5PDrCPOraq7miB
         u+BFIJ+2ug1TdvMzRX+BjE/3Zh9MCvcRQ2nNqckrXMXBdgzmY42PK0iX+0spyDKdTOoj
         hqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774041837; x=1774646637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cc7L1+/6dVTTAc1rDpaFmgif5bqTxN/xlHF2dS1giug=;
        b=Bcy/g+lMTc2vm6S1niGPyj0hDrGA2+yCkBvqvbgp1PZnMC9ojxKDrC006ITUHjvM+e
         NdWJ7TSFSjQV1iINZEKvpQVNHH58TksgyRevWrkt2y9NtRqRBgc9+mTNQNFGWUZhcPmp
         dAemTml58dOMKW8fb+D1nrb6YKMkhBT+0yUx/PHbosi1XCHJmW59CH74yV01EDYnS0oE
         KAIpn/1Azu+Kq9PEKWwecve1vC9oQmbvULBu6EeaXj3d6z4c6EBZrzI64xNVLfMxffQu
         ebP1fLRpTYprVkis2CEzfmlOyQD6krQZuRAlzC1En9m64vFHhBF7qnrvJkEYwGG3fLWk
         qkTw==
X-Forwarded-Encrypted: i=1; AJvYcCUXvQhKLZsNajLTMZRJ2w9wN0AfI08XxKGHUTSwxthTeyABv1Pxqq4Je19zzeK9z4IHv4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgbGBhcKbprVXZv5+jkp6UeXHO7IesgjN3kGvCvD/ZFhy1uJD
	VERiTrF8ynC0aXaLTH0IB9wOBOdpBRpH+dHXiBfDPAX+W+x/qDqJ2XUH
X-Gm-Gg: ATEYQzz2qFm6GNTq6W97n3NqzY5FT7HV6OG9AXHFqq92ipNrfUa36NK7ZaBpm7ufrMb
	z3aJIUChjqn7SKlrA2BcYMkGUS+UhKSGWnw0IE6mPLPXCUI3i4/xZxGMwEfM6Q9Y4l5BpYC3mBm
	Pw0gICbOzmv0b1TdfaNQYQXkgiy7Rh1GugGOlieV5WnuW0qbLFX02La/lkxFoX+AusSJU1YIqAx
	KQ+FFaP7BgLDbbWEPwZqgMr9QnZShnFsHikNQyb+RXtmhn/jFA6ijp4z+nc9rXskKCBzfYk/wwk
	9eigaFRi3W9VtfxIHW73f3QsahHEfEN7iCQn347ZaPHfr9AVdFXcnV6ISuhgz5fAqrcyr4pQIvc
	1KF7Vc5upOBOdNRf4qe1Zju38ASehf+6eM8YsfQ2yU/JW3YfreYKTXOAO3lHdKjY8HwvWJj2PX1
	//c7i/zX+5kfo93TByT3ic2sEuc2CwmB1V4xZL3sAAGrs6eu2vzoXoTT8/SkJo
X-Received: by 2002:a05:7022:1601:b0:124:8d7d:2d63 with SMTP id a92af1059eb24-12a726d018dmr2186785c88.35.1774041837053;
        Fri, 20 Mar 2026 14:23:57 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c8::140f? ([2620:10d:c090:400::5:f9c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a73407854sm3732795c88.8.2026.03.20.14.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 14:23:56 -0700 (PDT)
Message-ID: <1d708196-7b89-431f-bb17-177564196894@gmail.com>
Date: Fri, 20 Mar 2026 14:23:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] e1000e: add basic XDP support
To: Matteo Croce <technoboy85@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260320132356.63194-1-teknoraver@meta.com>
 <20260320132356.63194-2-teknoraver@meta.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260320132356.63194-2-teknoraver@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> + * e1000_xdp_xmit_ring - transmit an XDP frame on the TX ring
> + * @adapter: board private structure
> + * @tx_ring: Tx descriptor ring
> + * @xdpf: XDP frame to transmit
> + *
> + * Returns E1000_XDP_TX on success, E1000_XDP_CONSUMED on failure
> + **/
> +static int e1000_xdp_xmit_ring(struct e1000_adapter *adapter,
> +			       struct e1000_ring *tx_ring,
minor nit: alignment issue

> +		if (unlikely((staterr & E1000_RXDEXT_ERR_FRAME_ERR_MASK) &&
> +			     !(netdev->features & NETIF_F_RXALL))) {
> +			page_pool_put_full_page(adapter->page_pool,
> +						buffer_info->page, true);
> +			buffer_info->page = NULL;
> +			goto next_desc;
> +		}
> +
> +		/* adjust length to remove Ethernet CRC */
> +		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING)) {
> +			if (netdev->features & NETIF_F_RXFCS)
> +				total_rx_bytes -= 4;

Looks like, total_rx_bytes can go negative here since it is not updated 
after being initialized to 0. Is this expected?


> -static inline void e1000_rx_hash(struct net_device *netdev, __le32 rss,
> -				 struct sk_buff *skb)
> -{
> -	if (netdev->features & NETIF_F_RXHASH)
> -		skb_set_hash(skb, le32_to_cpu(rss), PKT_HASH_TYPE_L3);
> -}
> -

The function was just moved. Looks like an unrelated change?

> +/**
> + * e1000_xdp_setup - add/remove an XDP program
> + * @netdev: network interface device structure
> + * @bpf: XDP program setup structure
> + **/
> +static int e1000_xdp_setup(struct net_device *netdev, struct netdev_bpf *bpf)
> +{
> +	struct e1000_adapter *adapter = netdev_priv(netdev);
> +	struct bpf_prog *prog = bpf->prog, *old_prog;
> +	bool running = netif_running(netdev);
> +	bool need_reset;
> +
> +	/* XDP is incompatible with jumbo frames */
> +	if (prog && netdev->mtu > ETH_DATA_LEN) {
> +		NL_SET_ERR_MSG_MOD(bpf->extack,
> +				   "XDP is not supported with jumbo frames");
> +		return -EINVAL;
> +	}
> +
> +	/* Validate frame fits in a single page with XDP headroom */
> +	if (prog && netdev->mtu + VLAN_ETH_HLEN + ETH_FCS_LEN +
> +	    XDP_PACKET_HEADROOM > PAGE_SIZE) {
> +		NL_SET_ERR_MSG_MOD(bpf->extack,
> +				   "Frame size too large for XDP");
> +		return -EINVAL;
> +	}
> +
> +	old_prog = xchg(&adapter->xdp_prog, prog);
> +	need_reset = (!!prog != !!old_prog);
> +
> +	/* Transition between XDP and non-XDP requires ring reconfiguration */
> +	if (need_reset && running)
> +		e1000e_close(netdev);
> +
> +	if (old_prog)
> +		bpf_prog_put(old_prog);
> +
> +	if (!need_reset)
> +		return 0;
> +
> +	if (running)
> +		e1000e_open(netdev);
> +
> +	return 0;
> +}
> +

If I am reading it correctly, this can be problematic (maybe with very 
small likelihood). If e1000e_open() fails here, we will still return 
success. How about the following?

if (running) {
     int err = e1000e_open(netdev);

     if (err) {
          /* Remove the XDP program since interface is down */
          xchg(&adapter->xdp_prog, NULL);

          return err;
     }
}

