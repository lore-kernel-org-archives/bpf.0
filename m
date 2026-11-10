Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320437;
	b=gTjcxUk9CF40LlHV+0HUUz5XrOFSMpP5hBQGuGpQRrcAIrHN8CK6PTUnB5tHM+PuH2Hr
	 paA9K7kmvwND+v1fdYBMG34ezVdNYsDXBkSH2Oi4vy7iQYMn2wc1iHsQjLGcZno3veopg
	 I6rFJOiEjmeZdQ0gN5MExP8ZIDk2UCUtZNmba2bak53U7V852Suwi3j/yhbLD4UTSiJme
	 Ezh4yQgQwdGYb7Xma7WJA32ZreBQt3xbXERVLHTe6k1DvyjxwDxY+DFRWE0ZrkDBnQ9/X
	 NhpsjI1AAaBH8xds+KR9hm60L1ewSBxcTp0zhlZshqU4b7R3dGtlbljaMgyFOjR4Elg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320437;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=yxghYJJACMUSH3L8Z8k3tre7BBZpihYhe07SHtfZRzU=;
	b=IakJkJzUl2mRPFYfKK7n3e1vWqWMil8L7fs30hBAyiTMi3uQIioBqYWGmQuLAo3CfBk0
	 hwRPwP/lgNmwjsLVX9PvUgfQafcYwPp/VJKKEKZSKwuYBUyHbjrhBMCMtVJnBkqtBitNO
	 JQuJKcGUG4ZKfwadfg1inHttp4z55bjM6kmxArp7jc9vaDEI5dmUSoD9B7uPc0oTRW1JB
	 crbwVlNEQJJBebkOm0oBBinFQBvdCh4vQtuSVfNb+kw9d+8lDAeJitNnfhmb40206Qnh4
	 AFFGNj/F6R6NYohfqry4m9WBf2UECBFtoyF7E4zVfXvSLgyV/F35Fr5JqrHNj9G6Rgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tzc9Zs/y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D460A382E;
	Tue, 10 Nov 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tzc9Zs/y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657561F008A2;
	Tue, 10 Nov 2026 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320437;
	bh=yxghYJJACMUSH3L8Z8k3tre7BBZpihYhe07SHtfZRzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tzc9Zs/ycPeXxJ8aNptWRv5lXPygStV7Lf+YUKUAuneDLgJyMyaAf+p0f7TpXUTOM
	 WsEH1DhI/2Ts1lJdYM9/+VhYtt2IatVPaJZc0W6ph2hxS4vqjd6dVRdWho4YcGNpVx
	 Hv0Z9WLWCfc5ozGerNpjq0O/HYYCk5BHBJvv1eQanba4kd3aYFLPjoELh2Qv5lMmlB
	 1hIXqcR/hJlH5YIT+YK893I/s8nTPsglgehw4Q9MQkJgPaG/n1SQ3WuQXVj+Ttqyaz
	 pJ5qwLkDiWJGQ4yFAALapy77jvIDGMyiEsY2GX3clx+yVz4PFTBft10FfYxT4vAwvV
	 Z6oqX/5AyJ1SA==
Message-ID: <197d5a54-26e1-4985-8001-5819fc702fd4@kernel.org>
Date: Tue, 10 Nov 2026 15:20:25 +0100
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
Subject: Re: [PATCH bpf-next 04/15] xdp: add a kfunc to delete skb core
 extension entries
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
 <2892d19e606e3809c268de0610a4ccc8bf68625a.1794281983.git.tianyi@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <2892d19e606e3809c268de0610a4ccc8bf68625a.1794281983.git.tianyi@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/26 04:57, Tianyi Gao wrote:
> bpf_xdp_skb_ext_del() deletes the stored entry for an id. A program on
> cpumap or veth can use it to drop RX metadata that an earlier program
> stored.
> 
> Without the XDP_FLAGS_HAS_SKB_EXT flag, the kfunc does nothing, because
> the header bytes may then belong to the packet.
> 
> The kfunc only clears XDP_SKB_EXT_ENTRY_ACTIVE, so a later store of the
> same id reuses its offset. The flag and the size of the area stay the
> same, also after the last delete. To give the bytes back, the kfunc
> would have to move the entries after the deleted one. The cost is
> headroom that bpf_xdp_adjust_head() and bpf_xdp_adjust_meta() cannot
> use.
> 
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
> __skb_ext_del() frees struct skb_ext after the last delete, because it
> comes from a slab cache. The skb core extension area uses existing
> headroom, so it is not freed.
> ---
>   include/net/xdp.h |  8 ++++++++
>   net/core/xdp.c    | 26 ++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)

I think this approach of simply disabling the entry is okay.
This is trading off performance vs small area memory usage.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

--Jesper
