Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777197;
	b=NOyjRReX7YEdzr7wrXnM+flIT0lcvlcJSBtCT9lZA49nm/BGjhPaNSsay79P2B6xmJsL
	 ZXWWgumQAtY5lUI86Z/cfEy+bG2ISwintdjtlbjTxURIIBI/fLfMWVcBrWcDNaBBhgKqG
	 b/ZwN4zd3S5Tx4+oapkSh2W8W7e80oHdVISTM4ST0rxDLd5GWH2/AiwNKb3Om8PJu3FFw
	 UOT5GRBDLySlWoTE/Gvc2WqyyoyKffUYUNi61lHJA5PR/FFzgDm8t1Y3vrQ5omKR7RcYG
	 SltN3XBZsTHcDgI7H94KRR97h6UITMYcb0mteaXkzWPa9EYTphzpAaz7teCUlU7OXgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777197;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dl2GSKLNZwxHnys/gmOepf+Z7DTsWvB68DYjsGWZv64=;
	b=TxPDETuG8JRheq5bumrsFf2WzyLiwwd86kG0CGR/OoqwIOyE18In8FvwHd+mkGAMeDHt
	 YhhBwpsPGbvsWwr4cH8QF7+SxpmwaP4FUC3hyCj/phgD1n1+bqlW6gGRSd0KqwHlGN4lC
	 5vt606VRmodnERqi/V83HziHSBN20N7XeIquwLpQpDBxc6jVMUn9C2yQBVsn96JWBaAQ6
	 Dkm7m69gyX4Av0pCiTyOYhmQfO3VlfFuxzlWyMRljfI1YYwrEKUrhoML1CHsaSqa5GAjZ
	 riyvEsqvNRqXqpUKjTbUdgq8BYfmU3XfMUjzO08EMJqPyGEugFs/bfCGZElSaaJfV/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GS99ENSk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E568B606A31F;
	Sun, 15 Nov 2026 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GS99ENSk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9511F000C4;
	Sun, 15 Nov 2026 21:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794777196;
	bh=Dl2GSKLNZwxHnys/gmOepf+Z7DTsWvB68DYjsGWZv64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GS99ENSkyF3TPKalnRsitjk9MfxxCoI6uu2CrsWuj6OXs2LGrdDdsTtemrKU81oTS
	 NQz61UnwJFhSzPQx45UBtUCU4SHKf9nYerW8/f0vMoe4Nnc0PqiDPZ6GkUmC8WfdEr
	 81svY8FiHAcrkEj9C1GqS0Y+SS20Rz6IEPoAbbjdiVpqAFlGrVvJXGcD5WO8EKnA+x
	 aORjlLA0gh6XEt6NUM0wUGse7rdtOVrYDdvQCgqJBfwtLeYGvawNqjgaOBHHR7rTya
	 Uj3Y8dY+wyYgPhRcmdYuNHbD31nus/Dx1xO68JCpIEI/mZzl1dYaqUpZosbs3C3yT1
	 1tvvicofqqg6A==
Date: Sun, 15 Nov 2026 13:13:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>, Jens
 Axboe <axboe@kernel.dk>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org, Mina
 Almasry <almasrymina@google.com>, "Mike Marciniszyn (Meta)"
 <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 01/11] net: Get skb fragment addresses
 through netmem
Message-ID: <20261115131314.2d3ab96f@kernel.org>
In-Reply-To: <20261110102039.1002605-2-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
	<20261110102039.1002605-2-bjorn@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2026 11:20:22 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> skb_frag_address() goes through struct page, so a net_iov never has an
> address. Only unreadable memory should lack one: XDP and BPF read
> fragments through this helper, and AF_XDP UMEM will back readable
> net_iovs. netmem_address() also returns NULL, not a bogus pointer, for
> an unmapped highmem page.
>=20
> Generic code needs the size of a net_iov to find its address, so keep
> it in struct net_iov_area instead of the devmem binding.

IIRC netmem is supposed to be used for frags and memory CPU never needs
to access. This patch looks odd. I haven't read the rest of the series
yet but at the very least commit message should explain why this
aberration is needed / correct.
