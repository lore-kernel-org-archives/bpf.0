Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF130648C
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500207; cv=none; b=oPbFxIwxhApoQtdraGX2D5y8fEJWmU+5vh5K3NayuK6mth16CrrrGY++5RMNydfPLK+23I1DPhBbTYsCIW0kQer1XvrOyqxYXhdVvJyP7Hdw6+lLFd9n5rWdmU3qNGDlRWSNTEQWaI7+ALc3zxoppnqA3lAqI5JQ61UH2L/La8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500207; c=relaxed/simple;
	bh=R7qHEZ/9Bq21Rdmb/TF54ONdmEnRuMmMnmx9ViDFNmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLdAqbdO6Z5EZiehKcGGmXXPt60Xr84gSvW50PLKt15wtfSz8Q1ZfkacspHgbJPzSh5ySTEiE0ONCcLj7nLdyvi1spiwgBUm3Gi1ZIdd1omvcbg2g8rLN3cWVHHg8+EknenJz9yTfGejllg52Wgnuuct1OjUsPgFsfC7yY81QBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwPbgu0a; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwPbgu0a"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ce22328930so3062540eec.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775500206; x=1776105006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z00Q2KW1Ko1Gia8kQnTxVHl+69B80uqs2zLH3vLC4e0=;
        b=kwPbgu0axSzEOWdkjeYz/xwaKbnAaFL9yE9GDcxW++InAyflGzKgbGuykG6H3BP7mZ
         LJJjLAwYKfRTQG3fS/dCZzJYMFYELmj3/z0EVQYQOizpw3DlaQWTJWTLk7C3OuSNXOXl
         UsR1P5LnqNknhR/es1LREwOy/WOfcQPaSsqhVYOhjT5YjWE4HMB0MthrsZlBhfT/6iYA
         y8Z5z5nMCKKXSbksg5RGWpIFk+h+u4PEqJSRJEFEZWbPU/C4zvJ1zHNXHx6f11kIvffc
         vQSkAR9e/uldnNTtjuyNkej79qGQk+ufJsBiuooWJO7g2WamlU1l0H7Nwz/fuhahW9e1
         A96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775500206; x=1776105006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z00Q2KW1Ko1Gia8kQnTxVHl+69B80uqs2zLH3vLC4e0=;
        b=NBfdgszRX83QV9uL7ggv1vSdjX3KsHJKxQw/flRvPSRBHQ/asKHAyh6xqponlDj60D
         9Iz4rfton5VxZ30IydeSb41iBT+3sZBsKTcWqT0mLj10BQq+T47yuoUua6DgSE9WIjiI
         7PUcssiXGBE6hLofF/O9InA5VGngC+HfryaDOZdRWgF/eybHAzK2vYim/OTIawXAPKJq
         nRIcKXcTlxLo/3YL3mSixLhzEn/9OpnKmwyBjkGkIxOmmXSMhOyYrRtezHHuwSoNputG
         lBMQf280Tj8XMI0oVoGYxj29sc0iITIsSMjmJe3f9ihWqExFBd7c3uSE0od411O4yEvV
         uWJA==
X-Forwarded-Encrypted: i=1; AJvYcCVcMA3UrQu7jRLYeSJRkMUQELs/tNP0HNoL1aZuTGPakRRqHWXGI+s9CN0JtjUZPfo+20k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQ5klcXIVq+FNpE4Odf9OAcO+ltB6CUARsIXDkjA7mRsIo3mf
	jber3dMX4P3tsx3xvY324S2j9zADTxWU6+8O7haQQp+85/eRDX4Adg6n
X-Gm-Gg: AeBDietb0KxABcNje/cndxS/w6SEuyHIYkVUB5I6E/wg7JJx0Rnlq3xx0P+2nxSB0Ks
	Qw6pYFQfw1R53rEx+4ll/niiZYygeOwvQLp5bDDF79FQCIshLxUJTekZTllvhO7ufookdzhCplI
	/jplCua09sRc9ZpKz4FvkzfG+ubI6ReI6cmU86NfjGJ3zOkEnO4yHx9FO7XkGUwchZCKfNOe0kq
	oJA377xwuEYNdbTjujmniGcwhaHhPQlxs4tpM0BIndARc7vVIBOfY4lQzcLALzRqBLogYCHU1uV
	b+jv95kpl0iGlKQEtnai88qu3yPkNpLGKnYnmFny8LKd6ElGArzjmdXvvbOSR4TEa65PyqjmrMF
	67WVrIV1ygJUvyoPwrvYi3DZM1AaWYip+FsQNb3sXzyKU8HEIn/Li9aIZJEVfkzL3FlQnd6TgZA
	qJnlknlOpFYapXQSCt3t1ajt4b+gisdIoC9xzWVA4CBnZDbKNDotpMmPrjYjI0jJR645dsuE5Q
X-Received: by 2002:a05:7300:2153:b0:2c7:287:6740 with SMTP id 5a478bee46e88-2cbfc45b1cemr6829669eec.28.1775500205581;
        Mon, 06 Apr 2026 11:30:05 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::5ae7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20b195sm13283913eec.16.2026.04.06.11.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:30:05 -0700 (PDT)
Message-ID: <6796586f-18ce-49d1-99d9-c3c5df72bcf3@gmail.com>
Date: Mon, 6 Apr 2026 11:30:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 7/7] net: bcmgenet: reject MTU changes
 incompatible with XDP
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>, Simon Horman <horms@kernel.org>,
 Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260406083536.839517-1-nb@tipi-net.de>
 <20260406083536.839517-8-nb@tipi-net.de>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260406083536.839517-8-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   
> +static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct bcmgenet_priv *priv = netdev_priv(dev);
> +
> +	if (priv->xdp_prog && new_mtu > PAGE_SIZE - GENET_RX_HEADROOM -
> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
> +		netdev_warn(dev, "MTU too large for single-page XDP buffer\n");
> +		return -EINVAL;
> +	}
> +
> +	WRITE_ONCE(dev->mtu, new_mtu);
> +	return 0;
> +}
> +
>   static const struct net_device_ops bcmgenet_netdev_ops = {
>   	.ndo_open		= bcmgenet_open,
>   	.ndo_stop		= bcmgenet_close,
> @@ -4102,6 +4116,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
>   	.ndo_eth_ioctl		= phy_do_ioctl_running,
>   	.ndo_set_features	= bcmgenet_set_features,
>   	.ndo_get_stats64	= bcmgenet_get_stats64,
> +	.ndo_change_mtu		= bcmgenet_change_mtu,
>   	.ndo_change_carrier	= bcmgenet_change_carrier,
>   	.ndo_bpf		= bcmgenet_xdp,
>   	.ndo_xdp_xmit		= bcmgenet_xdp_xmit,

Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
