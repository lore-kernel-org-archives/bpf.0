Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355258;
	b=autY8p34W9Fy+YpeYfEbcne0gaX2s0UTj/+pOvrBhCMJO4Csfqag99FaTxZE9yZTJ9Hs
	 532h+Ql47TOvCeiI/y4SDk3XzDuGoNR94ljbBRwXyUYDTy/YRUMdXHg5f6otPNWrgpdLg
	 q3HC7pBLXTBWRmpAbC4Kmg5N5zW81+dXjk/3bF8D5fme+icsV2CtP/xqieVv3Pg7+VD2S
	 eOUJbNGPle69Ldh89Fzzu5sfidtXMLPkVUu/Neucvo0NEEDNq8oKkPT5U+OoPSgAlkHh/
	 QNH3IId1+y3ipgEjYn/gBWzlmJ79fWHEf8w07cByFdcjiLRbPcBvw9/L7jFWxzdqHSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bYaErAxQk82jgbOAPhvOLDjqMW7sA/6+9+NevIx4alw=;
	b=pvae9nc/H6DAPyx89y/zcVkab7xWHBz2QHhN1bQ0XMKswiGKErKmNlfDTTwQSegQD9WW
	 LK8BCfukBml8vsLMIclJaSR91y0Su+0oa+GzwOAs7iUnrCmgAElaqP37U8A5GHr5HLGyh
	 65VwaLkXLoQbmepWLAbn6f8qO49QVC72goML09u88QByIX7frqCDWEfP+7m0Wrc7wL8I4
	 FQQyTnva11x+NA/JtHSQj6Kb5viF6kn5BpX38Yz0UeHL5pM2AHrWePLjro/LcyX6n6GMY
	 Z7NaOYYtuTHCwtmT79ERglaReoa0wMIVgZcCv0QITgxw11tZcNIMCkzAqRxJlTUltkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t9TAbB+g;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5D606A327
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 00:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FC5D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t9TAbB+g
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36f758312e0so1267573eec.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355257; x=1794960057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bYaErAxQk82jgbOAPhvOLDjqMW7sA/6+9+NevIx4alw=;
        b=t9TAbB+gGdTcVq3NKRacPVt0N7MjkADs80KixPKvho+VsCVkoONwqkO/yJ/R8u5s2t
         sU9qfXBu+fZ2f+ktLbaRcQP1JUWWcVt1Fdbqa/eQbcIiLEtxXQoKQ3sLAmrxeQykyCN2
         49gyjEHNylCKfRyIbQk8A7tQfltVuGM4+o9KlANYaQOAdjVDaBEFIYSTSPPuHrHa5vH4
         1ntDDzByXQNjxkoHCJ8Zg+FfDpNx5BdDMLoBbqgU2bUForQ7XgCLF8X3ErsGHfHghBfW
         TrPH66Wi7muVvYkZOho47s0CKpbAoxIu5IjK2FIpcRJF2KmPFdk+AT0W3KF20V5scofS
         +4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355257; x=1794960057;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYaErAxQk82jgbOAPhvOLDjqMW7sA/6+9+NevIx4alw=;
        b=TCHw5DAbodGFMMh3jUdSNim+Jui7fzDuypudVlBmDvCV8jQv7gkFBMllz+rs2RyiJn
         3rqo2f4WEu9Wjfg2jauyMTMp4rl4Utx1eLTdx3x6AvnTCTsP/V58nyitOR9xHDXh65FN
         CZuINWwhjyKrohk8yMnHk3ieWwoHH5PgCIpN1q/nySb3b4JJfWmkFPCKDgH6cUWSTHHq
         AjiWG6OXQMA7uhXm0GVUWDQAfh83oFILBxz0k7PBKMVvfBjJncUlX1MXkmGHeDIT7DyQ
         bqck+QkYm6dyWRkMI7iCpZWw5RE+DPJTCfQ+fmmzTjsmfGPkVqfq3eDnDBib2wUFbkPi
         x2tQ==
X-Gm-Message-State: APuU4Z9mH4SHwdfPaSySxHjUQ7+nmw5nzUCCFoIvLdsbhwUdiX0tjuKi
	ZWFAvkgv2DLzWCRqlMGQPmcLJNv/RlFgfxT5jucsK5vbFFs39rfpkE/P
X-Gm-Gg: AYBFou1D+bwdBKBiKioMiPo0RVQ2YSKmN8+sVnNZWMPN1ie4nQtkDZxeK6+vv9hxA15
	gJ/m2eUmPJY9Ibjrdic4JrYb19Yj60wgKIrX45m2wFHjhnxBg/GJiF/fwDYv4TDO1MPNV+diUPK
	OTgv/8rSNMVOHLC7PjaW9Lh7fmhK7p8jOAsJUL2mXUr2qPzcEhKvfcCbE6U0knPprC8STDrmkLM
	khQ/Ko8lESD82RkqPG8AgviSOr3v8wa/88p+wNa37wL7z4ru4DHqpPjEB/2a4CkLAUWSjT7Mw1Z
	vqBN/Uo/lhlx5qae1PQLF7gUoz8yPQS8bQDYDyqyUw68wc5/L+5nRNdd53y9aRMaZRy0boaFM/K
	im77eddyGVPap3PG4bfq82VGi7W/6tWYLeAoe2mWAWhrsMm8UFNxB81jITOVIR+snmrjX+J2kYm
	rxB4XIwbZuxMZu1kmiXYqHz2Fzn7YKzjWSblCbrSM2QRtEF1x7BtbuPcD1R9Uo1GbNQSm81q+2P
	/gPvOo5UqMM2oz6ocFSBTKYsiP8G10Xbhf2+PtK6EumkYJHV0Pb73x2Gp5ldb2prkHsdX6IjpQ7
	wb04RS9bsOchUgdId0fx0GmB
X-Received: by 2002:a05:7301:90b:b0:375:4366:a90c with SMTP id 5a478bee46e88-3768730e517mr1138142eec.41.1794355256884;
        Tue, 10 Nov 2026 16:00:56 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:71::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c7c50sm19090263eec.29.2026.11.10.16.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 16:00:55 -0800 (PST)
Date: Tue, 10 Nov 2026 16:00:51 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir Vdovin <deliran@verdict.gg>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Chris J Arges <carges@cloudflare.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, llvm@lists.linux.dev, kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
Message-ID: <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
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
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>

On 11/10, Tianyi Gao wrote:
> An skb gets its RX hash, VLAN tag and checksum status from the RX
> descriptor, which describes the packet before the XDP program ran.
> 
> Without this series:
> 
> - On XDP_PASS, the values are stale. After the program strips a UDP
>   tunnel header, the stack applies the outer CHECKSUM_UNNECESSARY to the
>   inner packet [1]. If the outer UDP checksum is 0, a packet with a bad
>   inner checksum reaches the socket.
> - On XDP_REDIRECT, the values are lost. The skb that cpumap or veth
>   builds from the xdp_frame has no RX hash and no VLAN tag, and its
>   checksum status is CHECKSUM_NONE.
> 
> In one use case, an XDP program redirects packets into a veth device.
> The checksum status is lost, so GRO verifies every checksum in software.
> With one TCP flow, this costs 34% of the receiving CPU.
> 
> Another use case [2] is load balancing IPsec tunnel traffic with cpumap.
> Without the RX hash, GRO on cpumap puts all flows into the same bucket.
> In a cpumap test with 16 TCP flows and no IPsec, the throughput is
> 17.6 Gbit/s instead of 23.4.
> 
> This series introduces SKB core extensions for XDP. It reserves an skb
> core extension area in the headroom, right after the space for struct
> xdp_frame. An XDP program stores RX metadata in the area with kfuncs,
> and the kernel sets the skb fields from it. This design was initially
> proposed in [3].

Awhile ago we discussed the alternative of adding setters for xdp metadata.
Then the veth (or whoever turns xdp frame into an skb) can apply whatever
metadata it needs (and there is some magic behind the scenes that takes
it into account when creating an skb). That keeps the layout and most
of the code outside of kernel. Have we considered that here?
