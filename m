Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560926;
	b=Fqfi0D1UlPDv9IH6sJevUMSrLt0sYtwYJyljnOhK4pKEhZDnrXWeX/CiU5YjBo6YUi1U
	 HWfFG4kUC4co5XGS0o1HtifrE1ZXGEjRXxHHUNbtse+zgwaw7RCblZvFzryVZ9i5jFWEV
	 AWvcAdSl19URFdLN/wmv5DEz28zfO39iHVlwvMqEkxJLyFYJqjPs5Iv/MyMdjR+mSi5C7
	 /Ot+pMSFhqQEieYlEhQ1yYLUlKLHWp5vadyUXbYrYBAI9jx618r73S9Y+aQLv1MA7h+jm
	 OCzuTndIocVS6bQsHxvsCy9Qrpnl+ZvjW/k/S8eae+P7i/hcCDWcEn6amYF4YQPv60Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560926;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=M3J02I9fhxLNnztawYzUAlQ6QhBDBuVfwK+zFsDggxI=;
	b=5Oek/wlbB0pqSdvC9//R2TF9iMKVo9EzoPn2/tUkO3FE4AMKhSy7sRe+4IIpXDDUTER1
	 t4IYyDKNKYmCRLQOwvC17LuWAAk39TNUUN9c4Y5Yy54PJzzlw436mMDAdenPky6Hs9K2D
	 Wi+Qyez429xdjWPhjWsLqv0sGK1+u80Tm8Gc3roe+3rlahVB7GQSqXjq1KpaJHizy2MOb
	 KgRH3MCYpHizglEmom4PEgi9wWJ97vSfg1zv/0/0LP/9jW+qVCJRTjmIRbmobyKn8uMeQ
	 KxMSt3MANH69geYD9K4vhhBkNvWdeuo5fIgdSoi6qkwImvjbnfX9PVUGfNv6cTZMn2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KD5ni9Rf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C3606A321;
	Fri, 13 Nov 2026 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KD5ni9Rf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80211F000C4;
	Fri, 13 Nov 2026 09:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794560926;
	bh=M3J02I9fhxLNnztawYzUAlQ6QhBDBuVfwK+zFsDggxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KD5ni9RfgR2oPiPnTxi9WLqFkN9jV0P/xl5AkArK9PZNzck6d6GSiqqcJLJ/1h143
	 kjxcOQqn84Lfh85aDV87hexctxhF/nU0KHAKhGlqODU9EPG3GpscaiR8/OGM17Y3eE
	 3JsA1PZQHTpuU+g/NR8TRSaE1KtmYUXa6QZ5/LRs9MNCOW4VEWTtlj41F3Emlca/ji
	 QSTeQmwaIArDJNMwK5hgHd+szqeNvFaSZBmzERMWwJ0Ep/wRiO886k/Dii+Yrm78am
	 jBbocMXOzmMr6FOUxxx9DdhnxLTzPGk3dhKjrv6HkbPkj7JDAR71qYfKrQSJOWyDMk
	 gK4o4Jm5Ej1KQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Mina Almasry <almasrymina@google.com>
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
 "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi
 <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, David
 Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Stuart Clark
 <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 01/11] net: Get skb fragment addresses
 through netmem
In-Reply-To: <CAHS8izPnmy4W6f3dWp2NCkmNYxtP8jKm5rxjvPbQc8VdFm0Wng@mail.gmail.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-2-bjorn@kernel.org>
 <CAHS8izPnmy4W6f3dWp2NCkmNYxtP8jKm5rxjvPbQc8VdFm0Wng@mail.gmail.com>
Date: Fri, 13 Nov 2026 10:08:42 +0100
Message-ID: <87pkw9p085.fsf@all.your.base.are.belong.to.us>
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

Mina Almasry <almasrymina@google.com> writes:

> On Tue, Nov 10, 2026 at 2:21=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> skb_frag_address() goes through struct page, so a net_iov never has an
>> address. Only unreadable memory should lack one: XDP and BPF read
>> fragments through this helper, and AF_XDP UMEM will back readable
>> net_iovs. netmem_address() also returns NULL, not a bogus pointer, for
>> an unmapped highmem page.
>>
>> Generic code needs the size of a net_iov to find its address, so keep
>> it in struct net_iov_area instead of the devmem binding.
>>
>> Suggested-by: Mina Almasry <almasrymina@google.com>
>> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>
> Are the changes for niov_shift some kind of rebase error? I don't see
> how they're related. Otherwise changes LGTM.

Not a rebase error, but it's early. Nothing here reads it.

The generic code that needs it is net_iov_address() in patch 4; in this
patch netmem_address() still returns NULL for every net_iov. I'll move
it to patch 4.


Bj=C3=B6rn
