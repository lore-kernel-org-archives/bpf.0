Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315733;
	b=PZPt37Dk9Of2llU1fsYA2S4p6PxdOWVd1IOMC4WV9ReI0+gCFIGzXduzweVL1Zd0Fha8
	 VnSAGIknmeGpU8z+q1CcQvl1umm7sEHuyjmIlhmtO2qtg7FUnxt1a4i/FLrA6pL6eb92H
	 i71o2IPFxyEimu6IGaL72jExbaxQQmqJVlbyRsNqd35ly886ZtEQstEpQNB8p/sMoS/Lj
	 I7pd14VWvl89+vC7UzS9V7oB+GJhIKSHGJR6KHTxGYuvqOqF1K7sbGHlWtLj9ESq+S97f
	 cdcemjcGoYpf2JUFAbz31UfVkkv2YbOYo+vIMB6GGh8dAcgfEuQ5+eRQhkEeWHqczNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315733;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jmytX1alxm46Z7KikqFXBcorSxxsi2qlPM9aYuMFJLo=;
	b=LUiHKnTu9UasjpjnrXLXv6PCeKuIvuAb3iP8tgULbzOAurWBB3LfYDXpjGGmNZGxrBa0
	 Dii0EZ9jKQA72UPO7kTiiIP2pn1q7oqRsFKs8NTDd68qRj4VdWoWOT7iVy/mUU5PJLdjk
	 hX2bpEAS61DeJfoPHDGM3QUQoLzHRTzN6ZkP1o1vS6DzkZdQhRQSZc/5l5wRYjRYb1crX
	 vLWUyvrYRB4vvGN/XB8olrk1nrxP6+X4PPb2aTOXV1wPBu+SxTiHtBNVBqMFzZA2NQ/0d
	 UJ+b/DjkAiPsuWZpZAKIZY1fMGdLd+vI74wgZzy9IackExBVVyF7Cy575sUQ+k7lq1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAo3gcZm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06368606A7D6;
	Tue, 10 Nov 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAo3gcZm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E9B1F008A1;
	Tue, 10 Nov 2026 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315732;
	bh=jmytX1alxm46Z7KikqFXBcorSxxsi2qlPM9aYuMFJLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eAo3gcZmqWtOPx75UD0JZIp0/rUOLSR0khkKOdV3zDQpnO/7F2bZHqCcpNMU1s4Uw
	 hWoWOZt/+jQTl7OgWOqvnge9FG9Fl/PAdnGKw7zFrGaUHZI/XslnIp+3eHejYM5OPC
	 RD8x1cruazrVkl32sSZURBRLH/JOoe7yL8qFJr+fh3AWCGpNoq6qyH5yUujdFxbUHU
	 6Rno1WwU7leYRROXtOmhgileWTmV45YB4mm5bWRb3TU/2g/mCEKhONzuGe2fF2Njrb
	 etwhPt6N036CMwbplvwU+KhtCGY8K6gt508qM69S4B1uyQNA8toNyyXwnGBAuFo2te
	 Z90IQAjrffWjw==
Message-ID: <287c1cb5-7523-4f73-a16b-b066fd9d56a7@kernel.org>
Date: Tue, 10 Nov 2026 14:01:59 +0100
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
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Tianyi Gao <tianyi@cloudflare.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vladimir Vdovin <deliran@verdict.gg>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Chris J Arges <carges@cloudflare.com>, Jakub Sitnicki
 <jakub@cloudflare.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 llvm@lists.linux.dev, kernel-team@cloudflare.com
References: <cover.1794281983.git.tianyi@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/26 04:56, Tianyi Gao wrote:
> An skb gets its RX hash, VLAN tag and checksum status from the RX
> descriptor, which describes the packet before the XDP program ran.
> 
> Without this series:
> 
> - On XDP_PASS, the values are stale. After the program strips a UDP
>    tunnel header, the stack applies the outer CHECKSUM_UNNECESSARY to the
>    inner packet [1]. If the outer UDP checksum is 0, a packet with a bad
>    inner checksum reaches the socket.

Our XDP Unimog load-balancer uses GUE like packet encapsulation, so it
hits above case all the time. If packet is end-host, it modify packet by
popping header and returns XDP_PASS for local netstack delivery.

> - On XDP_REDIRECT, the values are lost. The skb that cpumap or veth
>    builds from the xdp_frame has no RX hash and no VLAN tag, and its
>    checksum status is CHECKSUM_NONE.
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

Yes, GRO missing RX-hash for bucket split is real. Above IPsec XDP load-
balacing have been running in production for a year by now.
Our more general RX-pipeline CPUMAP redirect is currently being tested
in production.  This means all of our traffic will soon be hitting this
GRO limitation.

> This series introduces SKB core extensions for XDP. It reserves an skb
> core extension area in the headroom, right after the space for struct
> xdp_frame. An XDP program stores RX metadata in the area with kfuncs,
> and the kernel sets the skb fields from it. This design was initially
> proposed in [3].
> 

Yes, I agree. We don't want to add static members to xdp_frame, as it
will always reserve the space.  Instead this only takes up the space
when needed.  The most obvious case is the VLAN.


> The layout of the area follows skb extensions (struct skb_ext). A small
> header gives the offset of each entry. An entry takes headroom only when
> the program stores it, so the area does not grow with each new type of
> RX metadata, unlike [4]. Unlike skb_ext, the area needs no allocation.
> 

Hopefully other maintainers like this encoding format better than our
previous attempt.  As this is already used by existing skb extensions.
This is not expose as UAPI and BPF access this via helpers.


> This series supports three types of RX metadata. Each type has a store
> kfunc, and bpf_xdp_skb_ext_del() deletes an entry:
> 
> - The RX hash and its type: bpf_xdp_skb_ext_store_rx_hash().
> - The VLAN tag and its protocol: bpf_xdp_skb_ext_store_rx_vlan().
> - The checksum status: bpf_xdp_skb_ext_store_rx_csum(). Only
>    XDP_CHECKSUM_NONE, or XDP_CHECKSUM_UNNECESSARY with a csum_level up to
>    SKB_MAX_CSUM_LEVEL, are allowed [5][6].
> 
> The kernel sets the skb fields from the area:
> 
> - After XDP_REDIRECT, in __xdp_build_skb_from_frame().
> - On XDP_PASS, in the NIC driver. A driver that does this sets the new
>    XDP feature skb-ext-pass. On other native XDP drivers, the kernel
>    warns once when the program returns XDP_PASS with stored values, and
>    ignores the area. This series adds the support to ice.
> 
> The existing XDP RX metadata kfuncs are bpf_xdp_metadata_rx_*(). Only
> a device-bound program can call them. Programs on cpumap and devmap are
> not device-bound, so they cannot call them. Relaxing this check would
> change their semantics. So this series adds three load kfuncs,
> bpf_xdp_skb_ext_load_rx_*(). They read the stored values.
> 
> bpf_xdp_adjust_head(), bpf_xdp_adjust_meta() and bpf_xdp_pull_data() do
> not move the packet or the metadata into the area. In this series, the
> area takes at most 20 bytes of headroom. With the hardware RX timestamp,
> the RX queue index and CHECKSUM_COMPLETE, it would take up to 40 bytes.
> 

I like how the size usage is limited in this patchset. As I understood, 
this was previously a concern from Jakub/kuba in my previous patchset.
In my previous patchset we allowed more flexibility and others to use 
this area. This has been dropped. Notice how this patchset focus only on 
the fields needed for the SKB.  This is basically working towards that
xdp_frame becomes the "mini-SKB" concept.


> Lorenzo's RX checksum kfunc series v5 [7] also defines enum
> xdp_checksum. The series that is merged second drops its copy.
> 
> Performance:
> 
> We measured on ice (E810, 25 Gbit/s) with bpf-next 0fb18ce8a2e9, patches
> 1-3 of [7] and this series. In the RX metadata column, the XDP program
> reads a value with bpf_xdp_metadata_rx_*() and stores it. The veth test
> stores the checksum status, and the cpumap test stores the RX hash. The
> kernel then sets the value on the skb. Baseline does not store it. Each
> value is the median of 5 rounds:
> 
> test                  metric          baseline     RX metadata
> veth, 1 TCP flow      RX CPU busy     100%         66% (-34%)
> veth, 1 TCP flow      RX cycles/pkt   2027         1343 (-34%)
> cpumap, 16 TCP flows  throughput      17.6 Gbit/s  23.4 (+33%)
> cpumap, 16 TCP flows  pkts/GRO skb    3.4          7.5 (+122%)
> 
> Both veth columns reach line rate, so the gain is in CPU time. A store
> kfunc takes 2.9 to 4.9 ns. Details are in [8].
> 

Nice performance gains :-)

--Jesper

[... cut ...]
 > [1]https://lore.kernel.org/all/20260227153231.78d16b69@kernel.org/
 > 
[2]https://lore.kernel.org/all/ca38f2ed-999f-4ce1-8035-8ee9247f27f2@kernel.org/
 > 
[3]https://lore.kernel.org/all/1d5521eb-84fc-4417-a3f5-6366694d160a@kernel.org/
 > [4]https://lore.kernel.org/
 > all/175146824674.1421237.18351246421763677468.stgit@firesoul/
 > [5]https://lore.kernel.org/all/20260722113525.34092660@kernel.org/
 > [6]https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/
 > [7]https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-
 > v5-0-623d5c0d0ab7@kernel.org/
 > [8]https://github.com/tgao-cf/skb-core-extensions-bench


