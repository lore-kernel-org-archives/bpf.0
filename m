Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055250;
	b=Thyph2gGjsNwlXegr2Ad9wo6FldKhVJpu3u3+to7kVKo6aXXFOd+YgyMgQ2IAX8skJLV
	 5a52YPwlJSYrkMRNpzlG0Qq7g/mWxDM361w26t370zhCulHWeDKsfiXwOxmtsSvEASvka
	 COT2YRIXIRbhJDsBqNMQ4OzmMRUzFY500L7B77y5wy4fpldPkWZdc30qm9KYO2r2jc2fL
	 ffKNyfH1qIuQuF2hutDKIDUNDJYldRr5T3nNItQQEJYhXDMj781ZDGVzS1Wl+eQ8iTeHJ
	 DWWz5mCmJIP9uDHp0HIUKHblDhLl/yRudGioZuF79Xyon95vfddKdUoAfH1jTR3lxog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055250;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wEYcI8ZI9y7ywNGs0DfQNK8MaDqc368NRHggaoWZKho=;
	b=f4habsInBIRo+J81Asn8c1CSBTk/Q0HkouU3q6giQeZ4gDSKgibEGuxCQySKRegJFNc4
	 2gLjSWTREhHGHWEnU1ywEAOOlIHu7CLCR73L6on+Kxt7Otq0QQY4UVvKl2S6a6mT3V4az
	 izl73FrUhNovbID7sPJl2iR6BnPpYFIMWNltV3yd+qLSDo5ryJYfB3F8tMsB5W6fQ8INg
	 Y1t/BayEUPHELB8aTgt7y9LkoSe2OJG29nnhUC5u25B1FgODQc+y01S2G30dpHOuOwd9e
	 tlz3eAKo/CyO3yunJf3mgjGO8Aa9ITSArr1ci0c7KxQ1WaqWTNA1ziw//jCfUwxAcSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="egE0b/qD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD263606A33A;
	Thu, 19 Nov 2026 02:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egE0b/qD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9991F000C4;
	Thu, 19 Nov 2026 02:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795055250;
	bh=wEYcI8ZI9y7ywNGs0DfQNK8MaDqc368NRHggaoWZKho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=egE0b/qDsY0A71yzb2c39TpIgIPuJabvIZSoXlZAb2g0ZQ467LxImtQV+hewOOUcx
	 AmqxU30arIrjCofZK/V6HBWJZWe2Uto2N+xf8tjeLQm8vnYWwZr3FxDNEWn3YlWypg
	 xmjZw9ktgYQ1Zh23rzmDkcRTCq4iTGU02JmXElmovMcTU6k7ZkqgxrDdb1qzhUAAuv
	 dpp8IZZKITwUQDxmw2aOgVvhX4J7OiM5IZzuMIzM/P8LORq915AeeLeRGNup3C7A70
	 al8OljM/GT+b9MgQW8iBqp8D5eSz/h0ezL5FbqQYdA3NRAMtDQQrEGY4MtWJSSAkTs
	 a+3UPKVo/42GA==
Date: Wed, 18 Nov 2026 18:27:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Todd Freed <toddfreed@meta.com>
Cc: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Wei Wang <weiwan@google.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, Sabrina Dubroca
 <sd@queasysnail.net>, "Boris Pismenny" <borisp@nvidia.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net/sched: act_mirred: don't send decrypted
 skbs from egress to ingress
Message-ID: <20261118182729.21bcf5f5@kernel.org>
In-Reply-To: <20261113185553.171059-2-toddfreed@meta.com>
References: <20261113185553.171059-1-toddfreed@meta.com>
	<20261113185553.171059-2-toddfreed@meta.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 10:55:51 -0800 Todd Freed wrote:
> On transmit, skb->decrypted means that the device must encrypt the
> packet, e.g. a packet of a kTLS or PSP device offload socket.
> 
> On receive, skb->decrypted means that the device decrypted the packet,
> and kTLS device offload trusts it as such (tls_device_decrypted()).
> 
> A packet which mirred redirects or mirrors from egress to ingress keeps
> the bit. On ingress, it then claims to have been decrypted by the device,
> although it was never encrypted, and its payload, which was to be
> encrypted before leaving the host, could then be forwarded in cleartext.

I don't get it, TBH. The bit says the data is in cleartext, and as you
flag we can't forget that. But my understanding was that the only thing
we have to guarantee about such packet is that never _leaves the host_
as clear text. Within the host it is clear text, whether its coming in
or going out. Can you ELI5 what the problem is?
