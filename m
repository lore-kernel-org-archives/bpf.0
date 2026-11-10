Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322115;
	b=fe2ad6Uhdkz7SmDuFW1fLqGIEV7zcvUiFapmK7TU2EDUHI9JFyZV757VO9su/ZPZCt5Y
	 dFdWS+WBDe9n+xL/WW+O98SKQ/8y0BJCG52mZUV97z4drG1lZ8id2F+pwZujD4pAQZ0A1
	 eWaRor+jjPtU0NeH+kDHXcxC8wV9M8qNMn5yRRf7PAtzIkQQkfAmg2JCpiVAoYA7F0Q8k
	 8wHH5CqCo0KlTIMCbUJxiKIlfWzRyKqix4h28+Pih7vHN4x/rGV9GJoTHQiaMRtmwZ9bN
	 MeMTru1IfZX33UpGhvfdoMb0DE1OSGLfms0QIPd5pbi04BFU6dmdQtHl6Bmp0LtDeZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322115;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XUiTD1fHkup0xMFyFzR4iaCQdh2qSDIS2CmJZXGFfHc=;
	b=nYwWVIDdglXrqT448os8w58hzaHZRu2XJJwo0pBKOOAyG0XvOxixdF4c/OFvuOtA2Hux
	 U5r62wEWMiojnELD2ms0fhyyAf2hARr/EY5qHb3vaH6TaZhD5KtN1NXpwK0nelpiFs6ch
	 3S/EqRNWIdbfQ0Eo5ihPLbYphY5TU1o81Z1rXPjfNvoQs7b0J2rRaw64CvC6O8WgcbQKs
	 bowwMBo7Gf2AW0VyfURxRCvEwW9Qj8eZgO8pd1qc4nxL4a0E+4MP/NAZtULssgz6ZbZ+j
	 NHXMRoGEaFj/3V0JLrt6Vpqvfiy+BSt76rctiq7oRnxbEDLwq8az0s4IIwrptXPU4Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tz+aZbtE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F760A2616;
	Tue, 10 Nov 2026 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tz+aZbtE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00331F008A7;
	Tue, 10 Nov 2026 14:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322115;
	bh=XUiTD1fHkup0xMFyFzR4iaCQdh2qSDIS2CmJZXGFfHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tz+aZbtEGDK1QeZJeYbLnEZYmje0CJnu22t/oJiUygPZWL6rL95MaUq+EDzRA/J5W
	 U7SpamNtitK/6CszxsR0T/vfLajLMLybZ+aGme3du9zszoQ94NDMkLCimVZvegBAY2
	 boILBaHaux2iUDtP1DykJhbtEmtGprT+V3i08pq3xpYNZKhlXyikTssqrM3C6t8Zhb
	 0d4/eHMRdAqjlh7gc/Y/I1/MeB08yHDxlDSvGre4L6ldn6vXZTepOvmC6vZU0BNxpv
	 1b3CtlKBAH/FGDnOT31GUx+plXev4992gbBQHqq4ate3fBAL5vik8N9LjmCPQer1rH
	 F65zIM+qKU4dQ==
Message-ID: <afe441ca-d616-4132-ae68-95d3ae5e111f@kernel.org>
Date: Tue, 10 Nov 2026 15:48:26 +0100
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
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and
 LL_ALLOC_SPACE()
To: Tianyi Gao <tianyi@cloudflare.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 David Keogh <dkeogh@amazon.com>, Daniel Borkmann <daniel@iogearbox.net>,
 David Woodhouse <dwmw2@infradead.org>, Dragos Tatulea <dtatulea@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>, Alasdair McWilliam <alasdair@mcwilliam.dev>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Breno Leitao <leitao@debian.org>,
 =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 Danielle Ratson <danieller@nvidia.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
 nh-open-source@amazon.com
References: <cover.1794020868.git.tianyi@cloudflare.com>
 <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
 <willemdebruijn.kernel.1d64e7848503b@gmail.com>
 <20261107182526.69543-1-tianyi@cloudflare.com>
 <willemdebruijn.kernel.2c6a653eb65fa@gmail.com>
 <20261108214356.95406-1-tianyi@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20261108214356.95406-1-tianyi@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/8/26 22:43, Tianyi Gao wrote:
> - That growth can move skbs into a larger kmalloc size without anyone
>    deciding it. On x86_64, for 1500-byte MTU UDP over IPv4 on an
>    Ethernet device, 194 bytes or more moves the skb head from
>    kmalloc-2048 to kmalloc-4096. That adds 2048 bytes to the memory and
>    the truesize of each such skb. The IFLA_TX_EXTRA_HEADROOM UAPI can
>    do the same, but then the operator chose to pay that cost.

This reminds me that I have previously proposed changing both the
generic XDP and veth headroom check to use 192 bytes instead of 256
bytes.  This makes sense because Intel driver for native XDP already set
this to 192 bytes.  Exactly due to 1500 MTU packets will fit into a 2048
alignment. e.g. 2048 -192 -320 (shared_info) = 1536 bytes left.

Reading about, this would also translate into a performance benefit?

--Jesper
