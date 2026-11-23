Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426877;
	b=uv1/q9CoMIxN9WYzSiaJTyjDk8FpyN5a6+sLdMBRr7O4bmr6A78k/9tnv5hByPNst0aA
	 lZIRpOsPs1508jy+iCqaTvm5j02HjxUn2zJT0GuO+PUXheFN3GlunIdp3owQusNiEBRVP
	 Oc4PYuWXY7/aN2sRmTp01Aput4TpznwU/blwWeLtMKSg0kqEQHZ+USjgXCAe0/hiMA7UF
	 OH+vWnnZZ74cEMN3HQzlP/vgxJ/Q467Ollib0afourJEEyBqaq+hthkwmw6gCuN7Ahe0i
	 0PEabxu4i7V28qTQEolJP/o06NLqOtVnM9qB3Ajxg0WZAB0aLG6gncsjcrV7Bb1keSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426877;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DFFpd8oykjbv1qX8zdsesrXWdcjGBZNE+skVcHUqGbg=;
	b=IdRvaQJm7dkIjPYHDB8+uefuACdYKiR0EQ70kPV1euFzsdl5Ss767As2NzAIxJeCu9T5
	 +YtjbRITh/cGmdBXaYUiNc2Nzr2XSyt0SFds2to2llULzVpnlKbZvKH2lESoXbVloTQfi
	 81UHLfUkaId5PDcMIEOudEvU3Aoxg3C2KIeKstZRxhEHYeU7RtkDYouq+XeV6pi/k1kBV
	 +IMt2EfryGjtI/9+NqOD39SRI31lkkHSCMbzqa6t7BbBLNZoL1Md5Eas9Bc+U8XjSC2uk
	 lupZgwy+ySOqCbAKwJHY1Uiqbnb1wrKC31oaTIrPeP0i6Xnsz0d6enZG1RAYs98hJag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eKet2WJu;
	arc=none smtp.remote-ip=91.218.175.123
Received: from mta0.migadu.com (out-123.mta0.migadu.com [91.218.175.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837C606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 09:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B837C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eKet2WJu
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DFFpd8oykjbv1qX8zdsesrXWdcjGBZNE+skVcHUqGbg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795426874; v=1; x=1796031674;
 b=eKet2WJul1hJtCbV96bMmqoDIpQL4MErdZL0CFyQ1pRy03SOjmrq9SGRlnhrlzCFQ06VK3QX
 nku4W8DluGIF4uPAR/W/i5XXe0AQ6Aq3ZHEQrM+Mn0LXvLKQjBYJLhXqoB7+7PRDZMEowS4T4Gx
 GRR7Ps/nxY689EiBzOZ9PxZo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 038b842452f0cc6a;
	Mon, 23 Nov 2026 09:41:14 +0000
X-Mizu-Trace-ID: 038b842452f0cc6a
X-Migadu-Flow: FLOW_OUT
Message-ID: <3c96d878-0326-43c2-9869-e941cae675f4@linux.dev>
Date: Mon, 23 Nov 2026 17:41:07 +0800
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
Subject: Re: [PATCH bpf 1/2] bpf, net: validate assigned socket on receive
To: Nikolay Aleksandrov <razor@blackwall.org>, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Martin KaFai Lau <kafai@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org
References: <20261123084138.723275-1-razor@blackwall.org>
 <20261123084138.723275-2-razor@blackwall.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261123084138.723275-2-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/23/26 4:41 PM, Nikolay Aleksandrov wrote:
> bpf_sk_assign accepts any hashed socket and the rx path uses it without
> checking against the packet which can also be rewritten after the
> assignment. A TCP socket can then reach UDP receive, AF_INET socket
> IPv6 receive, a v6only AF_INET6 socket IPv4 receive etc. A queued skb can
> also be delivered in another netns than the one checked at assignment, e.g.
> after an rx_handler forwards it to an upper device there.
>
> Check the socket where it is consumed: inet_steal_sock and
> inet6_steal_sock take the protocol of the caller and drop a prefetched
> socket on a mismatch. Like bpf_sk_lookup_assign, IPv4 also rejects v6only
> sockets which tcp_v6_conn_request would otherwise accept through
> tcp_v4_conn_request. A syncookie request socket left on the skb is released
> as well.


Some old discussion is here:
https://lore.kernel.org/netdev/20260403015851.148209-1-jiayuan.chen@linux.dev/
https://lore.kernel.org/netdev/20260608125846.157004-1-jiayuan.chen@linux.dev/

But the situation will change as time goes on. Hope the issue can be fixed.

