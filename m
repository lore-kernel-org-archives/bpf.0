Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367657;
	b=Y7QAOPrmuDByEFTOYrBpf6dgOSVPzSdZRGC+VZ9LezAYH3b+QKA9O0nlv++26gu6Moo2
	 kgo6cCCUILBvX2M11+x64Q8cotwiOxuw1TdVYfwVR2M22p5+PKj3bAc13XlSTuDJB2/m/
	 rflFORKg9XbQy4uzuUJ4yIfSiQHbO4A+BIFRn4D4trR2ZQaHLJo5BBF7sHAIJyN6b1FKo
	 VhnydzYQGwn+okWNEep0AjXcf0oJbPSC1tO/qHQr9kBMz7dtsLYkhP+/qJLPBcFgHQpEh
	 zTlrkHdcXLlYXqc3cN3taM+TodPjWj4XSzgWrilUg1mE5A845NaECqXL62Sc6FpEFRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6ftcOiAn6XPDtcpJvCuZr8LxfA1KHRDI2fDlQ+L+wc4=;
	b=wRVNCEnh3s75s1GVE/x49h4lLZdhln1yAk3jSv6ij4SpBrheIxsLX/AdPkl4P3KfrFeq
	 PSgkz+gzkOZ2+HLl8hlDqEHgbNBKoMhGNE1VnyK1jAPg/a6MXivtdFrdv/Fx9DnBD6IU7
	 uU7zd1xeFgMKY7FNsWO3BzCpc5DxoniIWZCrxn4AsvamtbfNsQPWAzN0J77+F7npRBhyY
	 C//qOG7SC9o1ZTGPBtfJ+TlbiFs4UM2URDOGikwS55K2YGXdSwauXJFx+CiDvR4auXVmC
	 1ugmIUe4Z0aqc8PsNQlH/XkCd3kLbhXNbILfoszJ6XQFA45FIcYQ0sCjpJK6oIuUv8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QbtNzmDQ;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3361606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 03:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3361606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QbtNzmDQ
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ecda93627eso866701e0c.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 19:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794367655; x=1794972455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6ftcOiAn6XPDtcpJvCuZr8LxfA1KHRDI2fDlQ+L+wc4=;
        b=QbtNzmDQyv8DLS8//kEyOv5PRq8ZWxkTgCukGdoQV6EDOcY7DQ6gZNAp/59xdzYrhu
         Ms5UPBAJaeA4GxZyi1ftwKSB4SmfJ68Q7hDqSrLvVBTZfkb3F/RSefcyaLkEuSHLa+r+
         frbTexMEwxWxOXeCtZxHwHH6x5w2LTvHeBE5IiMURbuCbKWSKw/BUklUuxehX3qUzBiJ
         znEYWcoLEaI1YSmOy1r0dthmbcvkkZzRlxm7ds+sPwXINs8CbR5g1D285xafnGnO2P6h
         /AMiB94YZn5woriwnfTAeI4bMXt21aKr645wwqCgUbzfMErvB34GWbjbVrcKv4syADw8
         sT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367655; x=1794972455;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ftcOiAn6XPDtcpJvCuZr8LxfA1KHRDI2fDlQ+L+wc4=;
        b=Wmvz0/PgXCH7ZRnZv0IEqnre0XGDHubNskTnkEv4dVZhO5d6Ux+XEAZcgb+ZWwZbV/
         9dhKM6NPLGNisBL24lQO7FgrCpVxQulNE/DKAXMlMkilivNv6AuwLC3VibRwQYpJm3f2
         SVvVQvPTjAGSgMFPPsbHxFk05eRQffJGtzSfI0jdBUbQw1Zdx/sRCj6fNnpbt5N9yqLe
         33PeoP3uLC0UA1i1pkVFCXSlsKpdO3ENg2p+x+haZiuB4zjIEoWUboRJreYx5Q7YhGy8
         pLlhjGUPJV+09HmQeFR0AR37JqfZDFGWuITxDmcBwck+70Fnkh1W3f6AYOqi+R3Q5/mp
         D9ow==
X-Forwarded-Encrypted: i=1; AL+hErEH3HEbNd2DhAQsMHN7BPuklVdUlaQc9VSTGSxv3fRagIU1z7aFH7dga+jW3l/Cn9PHukc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ju3yMCL3KqhIJrPRb7HbB//o5zqQPACsxCXFdXX+7mvlmJFbH
	DujUkakAm2KiLzSmS/6ZVT9LOYzlBfjTnoFmlJqKYXLcSnG5URJcbQZc
X-Gm-Gg: AYBFou1QOJA208aYTPNpRYlPS0TbXsG8QIpbGIXjElSpYClSdf3Hy7khXZlRWokXL4/
	Q1QU0i4WKH8njNab5HGAMJR7ak7/Cgk9/ay/zXYWcAoau8kPnew9zGIp6ov1eDM5NIzw6eTZ/I7
	vOckssCICHjgMqTcdm9psAVnKLG8Oo3yWdcR2fUFRHYLYIhf/ZlA2s8z+Eo1fb2VtP5UzA2BXEK
	NxOqRPnuoOhDOZLj7Ru9id9orp4KuNohKJcNpTVHU0engK3YOCNx9iVDQIdVYTrD9+AaApWss/q
	95BnOlMdGOnxndTFfj8l2aqBmWgqV2wtzzid34jslFheYgVLoyuBVrOU+v0BMzsaZzFpaj+70xa
	lOp41RU0T+Ps/wGpbRGeDYgpPSxzts64De8Hdg+xfS6y9SlKpoha3rmbAcUd60JLXvwZWTBkIJE
	/JzwKYzpgOqVWYqLQDfCwUl8Bwr00fFZopcsvsPJT1aPPS8iNEWDWCARxfeOvn8gsRI/1JdrlQt
	mTQeXAQz20/7OFJ/gSuSjEUFxn/OOhqnNXd52zNAJe/bvR7TLTE1Tq2G5l5E/lxwFUtyHeh53Tt
	6Lv/IqKl2io0vw0VJ6pmQdu47Q20HbcPU/iLLlEfzaiAmyb+PiSu7LGWp5KYdeBvMZe1s1vGDJY
	KItcq6ALNbjJ2wsUklZEj8WVV6z4QcXp5WEHcUDIlahMMfw04luTi2HPpee5nj0+aReGiUhc=
X-Received: by 2002:a05:6122:3d0b:b0:5c9:66f7:2f23 with SMTP id 71dfb90a1353d-5ee1c29a86amr335477e0c.2.1794367655542;
        Tue, 10 Nov 2026 19:27:35 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5afeb2sm3174383e0c.9.2026.11.10.19.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:27:34 -0800 (PST)
Date: Tue, 10 Nov 2026 22:27:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tianyi Gao <tianyi@cloudflare.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, 
 netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Simon Horman <horms@kernel.org>, 
 David Keogh <dkeogh@amazon.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Nimrod Oren <noren@nvidia.com>, 
 Alasdair McWilliam <alasdair@mcwilliam.dev>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Breno Leitao <leitao@debian.org>, 
 =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 kernel-team@cloudflare.com, 
 nh-open-source@amazon.com
Message-ID: <willemdebruijn.kernel.37fb7add3354a@gmail.com>
In-Reply-To: <20261110201250.95225-1-tianyi@cloudflare.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
 <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
 <willemdebruijn.kernel.1d64e7848503b@gmail.com>
 <20261107182526.69543-1-tianyi@cloudflare.com>
 <willemdebruijn.kernel.2c6a653eb65fa@gmail.com>
 <20261108190831.3f991a13@phoenix.local>
 <20261109154909.32748-1-tianyi@cloudflare.com>
 <willemdebruijn.kernel.935b9bf7f1a1@gmail.com>
 <20261110201250.95225-1-tianyi@cloudflare.com>
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and
 LL_ALLOC_SPACE()
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tianyi Gao wrote:
> Hi Willem,
> 
> On Tue, 10 Nov 2026 11:23:09 -0500, Willem de Bruijn wrote:
> > I have some hope that if there is sufficient reason, this backlinking
> > to the originating netdev (or socket?) can eventually be addressed as
> > well. Rather than work around it.
> >
> > The skb_orphan and iif issues are well know. But not set in stone.
> 
> Thank you for the suggestion. I looked at what backlinking would take.
> 
> For the socket, ip_rcv_core() orphans the skb, and after that skb->sk
> holds the receiving socket, for tproxy and early demux. Keeping the
> sender's socket there would break that assumption.
> 
> For the netdev, skb_iif is the last receiving device, not the
> allocating one. So keeping the origin needs new state in the skb,
> such as an skb extension.
> 
> Even with a backlink, the kernel still needs to know when to adjust
> tx_extra_headroom of the originating netdev. This brings back
> auto-tuning, with the problems from my earlier reply.
> 
> Taking a step back, IMHO it is more natural to set the extra headroom
> indication on the netdev that the skb is allocated for, than to have
> other devices raise it through a backlink, which can get messy.

As said, the problem with that is that an admin has to do it, each
time. Whereas the kernel has this information.

> For v2, I would prefer the narrow VETH_INFO_TX_EXTRA_HEADROOM UAPI,
> following what has been done for IFLA_NETKIT_HEADROOM. I will put it
> in the last two patches, so the rest of the series can be taken
> without it if you prefer.

Ok. I don't expect this to be solved in this series.
