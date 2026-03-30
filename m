Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A543DC4CF
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894562; cv=none; b=O9vqe1OIXpDtrdqHLXepwObx+wxowlNPbJp8eIgDzNCh2adRnxXufDwwwbTyDyMHmajGdRhW72iD5F3G6CqmXw0nFFNYh//Na7S/cm17wh53w9pnhuAQDs2WRUr4V3F9SHAsGXlucE4rsKzsaraNEwXKbP1oBkdVmP+Rc4jCP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894562; c=relaxed/simple;
	bh=w3laICLdUr/It025yULtMzfgTQBRcrqRCXageJtlNJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFvgJZVymP8yUewF9+ENa98iUKwv/lQEOs1/1Vo2OJXQDwQuCtDp4KeC53DD4Vqnr2a7HdrAj/V6/+kYWg4HYRBz7+wlysiVEw8Y6hvFc4+nBBZqDIYD2qtdQ0/DoSKzzr3jwUjPAh++AmHSA02ynTbZl3EakHnO+Ik4z1T+n0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLSRAqpj; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLSRAqpj"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12776bebe9fso1310872c88.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894561; x=1775499361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwQw96URI4tIsjOfhNQCUIMUJe4UuSRPr0npvZsSxqk=;
        b=LLSRAqpjVR5xcYGfPdaqmtpX3KmgWrg/lYgYMUXU+FA3Sqr6lW+3TIWVSICBPideM5
         OW8NhFUAmnlkt96ap+r4RdvufjPJfv35Eeo3GAwDLdGRslgdGzsax0cxAFkBs5fs/g2B
         i6R6f2aqUyOTRF9R84Ac6tNLoG5lEqOyo+Xwdk7HcjUXkUT+PneNDcIMmq96k+TnSGpk
         h57dCzDvaRJq4eO/Byl7C2f6/R+tMF7vH77fufg5HbdwmgAVt2OVzlhO+YpRYDkjGNAq
         QhAr1QIyPlL+j8/PXHMpmNMlGfjHkYrxQiiidOQnEhXTw8dXBvK8UBJWWlAhOxdZoBLw
         h5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894561; x=1775499361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwQw96URI4tIsjOfhNQCUIMUJe4UuSRPr0npvZsSxqk=;
        b=MpIac4QrqeBe0zzgsq4kD73Vg83ZA1/3+DmvxUHR6SXqh7GZhQQialugV2RRv3t998
         ZOQQljc2ProJcj6j4fcEoqahW/4jSEMIZTlEyFJDNiRbG5lGgCiP9Df2QPFdR9IVtEJ8
         6XJBGW2QXguB7dHsVGiW1YHmGkqaaPlJX45B2NvTGA/EWuHf0ZL5FiImCfmhHesvfmkE
         s9ToiUgxeOAT4c5dXfUv6lMUnPEkIZGO1xsbZGRWfKn5AdN1is/Zi3gpxO0BjdI68j07
         EJ11ZtzOVRyfg5vFtgB9XRqwMgbmj7ObgJR8HQ0JEQGuAiX3FeeK+kpjneq+Qb4H73dY
         n5EA==
X-Forwarded-Encrypted: i=1; AJvYcCWkClKqVol3AfCOFoz/tnaONsvwCPDUe6+5mxxtGbrnu+sCf/lvoQbDBJxjDajk25cGmFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDoHMDiaatETnRkGv0QlGIn+lrJD69E/jlRWLQLiKVv/KbSjd
	NOmDn3sawfFTjlpoYWMXSuikrhvr1UAIjFVTfy+4CJtACmkSgPQAcoLM
X-Gm-Gg: ATEYQzxONmvOzehxeuFBGix1KRalstx6+95HloB/P07phThLucI85TVtiCp0N62m/18
	N5ww0NP6ivhYp9yAh2MZ7pvlmQELIDFj0vM/rg9XE0Fll+gKxkVI8EP9Qf/VQA0J5VcU21xLGyc
	kH4zRgrf17FcziMdaoinWtv7MxUzxs9lfh3tI2g04Dd0aPgi32qRSF1PoWmo8JaraVX8lICObR6
	l9fkJD3Ct4ywi+oTGiT9yCnCN27xIKLlqKn7DT1w9Jke0eV0jXYbf44oI5rDfTAafu5HsEh9fLB
	ArhfE0Jo1LN985RQHjo0NceFwEEnqONLzpzHZZDcG2FC9kMtI7DWg6vAydNGYABiVWVEJfJSWRK
	5wfZWI2gU/NW/LCaav75h4s9dCgXe7jxpDErOKe0Q4uqx4cX3XODR4DAae9fNj3ek6orJ4o6bs2
	TrIs+49nTymqt66q05bPyyUeigAoq9hxCs4yzQDrtcLGs8Asv7+986jEpUzut/oYL0LhuWWz0FA
	Q==
X-Received: by 2002:a05:7022:6182:b0:123:2c98:f65d with SMTP id a92af1059eb24-12ab286cd31mr8629558c88.13.1774894560790;
        Mon, 30 Mar 2026 11:16:00 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::1:79e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97efb42sm12090342c88.7.2026.03.30.11.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 11:16:00 -0700 (PDT)
Message-ID: <c79a7b7e-9e1c-4b3b-8ef0-2d4144dccc25@gmail.com>
Date: Mon, 30 Mar 2026 11:15:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/6] net: bcmgenet: add XDP_TX support
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-5-nb@tipi-net.de>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260319115402.353509-5-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



> +static bool
> +bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
> +			struct xdp_frame *xdpf, bool dma_map)
> +{
> +	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
> +	struct device *kdev = &priv->pdev->dev;
> +	struct enet_cb *tx_cb_ptr;
> +	dma_addr_t mapping;
> +	unsigned int dma_len;
> +	u32 len_stat;
> +
> +	spin_lock(&ring->lock);
> +

So we acquire lock on per-packet basis on the XDP_TX path? Do you think 
we can batch this?



