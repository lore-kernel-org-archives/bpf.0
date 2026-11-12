Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491877;
	b=3LBHnbLa8CCBXnnHgfBVgizl1FU/iiXGoij1/GBXAi7DsHXrtrlVebCNZvRVPFRHFFL+
	 tK0BLCaNHmwT2+bl3rK2nhFYfk2c3T/jmLoFIfs9cQtJLB646pMKMivm11c/2lyZr7E49
	 BWfHpE/OkyN64grrPDIJ+ZAQ7LQOOWmGVtw//+mPd4fnZ5dGGcie2BVvQb+eo82bcjvYz
	 /yu51varekPTEuCP86Du+4eqkVmMnkTUW515aqp/7CwbWycC2RpAbjxy1ThQ1EW+IFTtr
	 wa1ncPEjY6GxRGRJoz1VSYJCeZ80P1d5j+1nO5Mwac3nXlsx5D5rijzXux3JGLBsDCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wdg8stMM6r5FBivxq5EOSdvuNXe49X33jADApWgpna0=;
	b=EKkat43Dug/bTS7Z7khc81l7mdJbxXuFbRJ//VSfgahORj5UuQJAE3anKhPs9Tvx0qez
	 KHMYEHpCmFugGp86Ay2bBX2I29BmSbrhxCBQcFNSb9lAQB5HcXTJwZz6wtjy9iKTuPFT3
	 P6YF2jp+e/YXxMl1UEj7PUYPiD5mNLtN3EhWAurWIyhHuZauXqP4aLI1Slewm8crjUuUN
	 ppKQhDwabaxqu7y2CFpSDvxGrKSeArNCAfz2iALuDuMlO8kumDDI716Sr62o6zIFWUuZB
	 tpEm9ZsdS66ZfLMjNODJK2IK5AE46vmEuvldVDuTgmwhNhoi6gqSv0y8xmqJ2yIxwOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODhw8U4P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49765606A32D;
	Thu, 12 Nov 2026 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODhw8U4P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B681F00A06;
	Thu, 12 Nov 2026 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794491877;
	bh=wdg8stMM6r5FBivxq5EOSdvuNXe49X33jADApWgpna0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ODhw8U4PU7NP+U07JtvrHQ7fu76dDLy178QWgpxgqEazVhYKBZGPLIoEgZis3SVGS
	 hQDy8s6SGKHwCcswZeDrcCyFyHmmjh1B8CYSQAZSTEhrAE5Zaz+0h+Xq41B2MztB8l
	 WspG5vC8CCIyhfeM0RzhKJzHrsE69lZGgiegiBQ6HpYGejFxwiouVHVpx0FWVoXh3Y
	 ZF98zklsEGtHur1BtcNANtZUsILZoKQd4Utonsdsj20ZOqsJ6a0E3e2KMLxr7Drjh8
	 DeobS4tVRNpaqSOGlAhSgQ8XfHHd06S0GKxW/yXutdhBS40zknt3k7hTol6e9Cnt5j
	 F1Nd/XoO/2BBQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: saeed bishara <saeed.bishara.os@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org,
 Mina Almasry <almasrymina@google.com>, "Mike Marciniszyn (Meta)"
 <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 01/11] net: Get skb fragment addresses
 through netmem
In-Reply-To: <CAHfVqdVYBbs8zu40nEaCDvGVNeXHe2DXh0dGxEcgL3kP8S8_HQ@mail.gmail.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-2-bjorn@kernel.org>
 <CAHfVqdVYBbs8zu40nEaCDvGVNeXHe2DXh0dGxEcgL3kP8S8_HQ@mail.gmail.com>
Date: Thu, 12 Nov 2026 14:57:52 +0100
Message-ID: <87ld6yrw2n.fsf@all.your.base.are.belong.to.us>
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
Content-Transfer-Encoding: quoted-printable

saeed bishara <saeed.bishara.os@gmail.com> writes:

> On Tue, Nov 10, 2026 at 12:27=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
>>
>> skb_frag_address() goes through struct page, so a net_iov never has an
>> address. Only unreadable memory should lack one: XDP and BPF read
>> fragments through this helper, and AF_XDP UMEM will back readable
>> net_iovs. netmem_address() also returns NULL, not a bogus pointer, for
>> an unmapped highmem page.
> Does this mean that skb_frag_address_safe() is practically identical
> to skb_frag_address()? I assume highmem page is the only case where
> non niov page isn't mapped.

Yes to both. With this patch they're the same, so I'll have
skb_frag_address_safe() call skb_frag_address() instead of keeping a
copy. Its callers can move over separately.

>>   *
>> - * Returns: the address of the data within @frag. The page must already
>> - * be mapped.
>> + * Returns: the address of the data within @frag, or %NULL if the CPU c=
annot
>> + * read it.
> "CPU cannot read" isn't accurate, I assume that in iouring case the
> buffer is mapped to userspace.

I'll use the netmem.rst term: "%NULL for unreadable netmem or an
unmapped highmem page". Same for netmem_address() in patch 4 and
MP_CAP_READABLE in patch 2.


Bj=C3=B6rn
