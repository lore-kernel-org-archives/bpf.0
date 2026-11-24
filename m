Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511675;
	b=dUc6WPg5hbT10KBalafDm6jUJgXySJiKbkZdEuayH/KALhZ7sHhi6iVJ5FrS0a4m3Sgb
	 k1SOcmvB5j+4xq9HPEiq+67mAO4OddcQmVvm4f0cb0IXtLsAcRM40+RB9AChroJZglyz5
	 AmUOw/2Ze1kzZUQROtgDnPot0xLdF303e9Ss4XCWhKSokAnyUT3oT8jzyXeempNh4+TeC
	 LQnZvXCP/h4eE1C6kjwOkxtq5aMy847sUHdBWw7uatiOldJthybaG58zqGx+tc/xnFnZz
	 aW4IC2NNzyJsCtq376WPW98PZPSkXsVZbNV1dDeW2DbyX6OU01g7mJ43KCEDQHBYfeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511675;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=OUngm4girPZ/UgXDY4tToZ5+MVYoWJUTU2VlTrOevjQ=;
	b=QVDp9AQ6J4GFmm6OdyjJdn8ckNGrofe5cZ/nvqxvBfvavk/Fla+ylb+2yTXs7zIQKeSf
	 w0HRcO1wSTmy+jxj6SHQKVR9OVzMbBZde5nh8s1VwYGefLJA5wcyED6DIG7FYMUf7PaAw
	 O5s5YzDf9/kZCkbU0bJKbgNci4qZ/wXcIr+4I32y4kIMh6F5eaB7+ZWhwIv8CaDNa0cWC
	 UdPZhzF002Lx3dREdJhjA2wuaYk2uxYFZ8xKT8e63vWC6AWBfg9WGcBbwjplgUR59czl1
	 S8oAsWUcgnPI89UDiWNJLaNo/xJh4jwb3o7/gaAQ9Wy1Owc+8rPIKxfA0Hx5d7sRgyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=C+JbvLTx;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF15606A322
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF15606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=C+JbvLTx
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 668B7C4CBEA;
	Tue, 24 Nov 2026 09:14:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 085D3601E1;
	Tue, 24 Nov 2026 09:14:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1FC9111E68DFE;
	Tue, 24 Nov 2026 10:14:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795511671; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=OUngm4girPZ/UgXDY4tToZ5+MVYoWJUTU2VlTrOevjQ=;
	b=C+JbvLTxACFgmMXVP5wvlu1mwmVIZQveH3j3i0LGBpo78jGydRRVv3Hmp9utJB7uXLQ+s2
	Qgc5XZZ5u4jbrc0G5lH6mvUGyLCWErr9KbVrLnD/rFathee8+APWG7fT/gWcoOAtKt4pEi
	FML1o06sWvxWlFeUgrvifnT+nWxVxZ2DsliSkVbaKQNQUe7VomPqbvjei8feQ37mEkrslC
	Vq4FDCp2vHaWKuAHDHa2+/LubEr0dc7UHiWE9BOsuuihGpxseeqihOXgLJVrRPOZygT24e
	aXmUyEfacOCvvtChysMgxDNGTI4uFRujoUZ73JU+QXBSQdp9cRgCFYPzhftReA==
Message-ID: <cc3580f8-9a45-487f-ac86-84e0f1c3e8b4@bootlin.com>
Date: Tue, 24 Nov 2026 10:14:13 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 1/4] net: xdp: add
 __xdp_build_skb_from_buff() helper
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>, Simon Horman <horms@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, peilinhe2020@163.com,
 Peilin He <he.peilin@zte.com.cn>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20261121-stmmac-rx-mb-v12-0-3ae2f3bce174@oss.qualcomm.com>
 <20261121-stmmac-rx-mb-v12-1-3ae2f3bce174@oss.qualcomm.com>
 <9997f4e9-9453-4511-af3e-4be664a09281@bootlin.com>
 <awVTNSYCD-_5gE4D@lore-desk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <awVTNSYCD-_5gE4D@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/24/26 10:04, Lorenzo Bianconi wrote:
>> Hi Lorenzo,
>>
>> On 11/21/26 18:28, Lorenzo Bianconi wrote:
>>> xdp_build_skb_from_buff() always calls eth_type_trans() on the skb it
>>> builds, which pulls the Ethernet header and advances skb->data. Drivers
>>> that still need to process the L2 header before protocol parsing
>>> therefore cannot use the helper.
>>>
>>> stmmac is such a driver: its software VLAN path (stmmac_rx_vlan()) reads
>>> the VLAN tag at skb->data and shifts the MAC addresses over it, so it has
>>> to run before eth_type_trans().
>>>
>>> Split the implementation into __xdp_build_skb_from_buff(), which builds
>>> the skb (including the recycle mark, the Rx queue index and the frags
>>> info) but leaves skb->dev, skb->protocol, skb->pkt_type and the mac
>>> header unset, so the caller must initialize them, usually by calling
>>> eth_type_trans(). Make xdp_build_skb_from_buff() a static inline wrapper
>>> that still calls eth_type_trans() as before, preserving the behavior of
>>> existing in-tree users. A follow-up patch will let stmmac use it.
>>
>> I've been questionning why we even do that in stmmac in the first place
>> actually. This pretends to offload, but it's just to deal with the tag
>> in the driver instead of later down the road.
>>
>> The original idea was for GRO back when it didn't handle vlan tags, but
>> this isn't necessary anymore.
>>
>> There was a series in-flight to remove stmmac_rx_vlan altogether, but it
>> seems to have stalled [1]:
>>
>> [1]: https://lore.kernel.org/all/20260914150612.9798-3-peilinhe2020@163.com/
>>
>> Peilin He, do you have any plans to continue this ? If not, it may be good
>> to pick this up instead of working around this.
> 
> I am fine to rebase my series on top of that one or pick the required patch.

There's been no activity on this since september, I think you can pick this
one up and have Peilin He in CC + Author then, your multi-buff XDP has been
going on for long enough, let's not block it further.

Maxime

