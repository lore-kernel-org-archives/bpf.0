Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794768474;
	b=e2S5v97qA7iVwjuCXZjiPklzfrGlIRTMPNYpiF8s0DEyg0dLm2UR+bA1J+7S9OeStRVQ
	 C9jb/Iebl6myqxXUcDLeAWOd+5eQ41wfiIEh10f8gJm2zU1aWVyrq5+AHIHraLNCfV7Yv
	 pDgahMKUaF0yWcdNJ+zQ20xUU7RtDUPlPy4ZluZwih3tGbkS7iIz4Bcn5EFvZit080YSJ
	 upIDile24B1K2vTQzEEWvVTQK8rHsGmdEB+oSOI3tavU8cQkpXRkmJG6mlCVVsLxPYu/z
	 dQ/QkNKwQ+ASe4JFgOeENToYF4eQ5wtPDpD1sSsgFDgyICc7s/UpO9aAOKULFP400EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794768474;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vVIT0VvIfr5x7hfZPd3p28y+jJruOeCF2tb8ILdwEA0=;
	b=W//Cajl3sbKqHeopwx90vlwDHdBB04ME3QDUF8rdaSD5hj94bXI/VXfQcAW6xACSFhnl
	 3COeket+nT1n5/nWBRHZE1p5Eg4Dg4kl1tb2y4OApSLrRU2SOcc2nPfvXYFO5PyHeYamh
	 KQ92fSqaAgzjWdpWTwndHcbDbUZ/fSgLzETjCCQDLupizFNzgziqLi8EMbWiCAr9IHNDK
	 pOvbVJmySRUUG2F2VA+p93DNp1CxC+HUH90ihHrTbtOTR7uGzq1+hz4JPJRdMEUMak/UN
	 /BcNubAykvdAEoynttvB61pqCH6xAUZ5OrngzAo1wfFSbuhFPuOZKzm47JI5mGs/lYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnjywwDy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08908606A32C;
	Sun, 15 Nov 2026 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnjywwDy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEB91F000C4;
	Sun, 15 Nov 2026 18:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794768473;
	bh=vVIT0VvIfr5x7hfZPd3p28y+jJruOeCF2tb8ILdwEA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gnjywwDyy/1QOFuNOsVPOBmY0oUJnv/uxMTHgl3S317Jni12vFsFvxSJ61qmRThqA
	 M5eFtD4v/rpELq8WGYNFP7QeWruxp3vRdH77cBLmWHTRXx2TYOY0kpXUiqJmMMgWty
	 jZVFKRdrg/6OriBN3Joj2FWmhhlD3cGRU/jdGL04akelTdAzEWkuM0bdikTIKAubFw
	 /ukQVE1ulZuxXEc0LEIDnjLbyR92xIoHxIC9RDQWUR2hVvNt88INllkoBbjpgj1IEU
	 OLDFWnEh3tMHl83ES3li7ut5hFASgZ1XS1xRrbxkeWLqOzHMZYlGZj51lDVhUihMcN
	 4Xi8w5jxyrV6A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
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
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
In-Reply-To: <avZXuHWBUTJvJnEu@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-3-bjorn@kernel.org>
 <avOYe27x-AlxmyK9@devvm16445.scu0.facebook.com>
 <87mrrfa6c4.fsf@all.your.base.are.belong.to.us>
 <avTy21_cSnyMdbb5@devvm16445.scu0.facebook.com>
 <87cxsarvwd.fsf@all.your.base.are.belong.to.us>
 <avZXuHWBUTJvJnEu@devvm16445.scu0.facebook.com>
Date: Sun, 15 Nov 2026 19:47:50 +0100
Message-ID: <87bj7qj5ih.fsf@all.your.base.are.belong.to.us>
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

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> On 11/12, Bj=C3=B6rn T=C3=B6pel wrote:
>> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
>>=20
>> > On 11/11, Bj=C3=B6rn T=C3=B6pel wrote:
>> >> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
>> >> > On 11/10, Bj=C3=B6rn T=C3=B6pel wrote:
>>=20
>> >> >> +	if (static_branch_unlikely(&page_pool_mem_providers) &&
>> >> >> +	    WARN_ON_ONCE(!page_pool_supports_frag(pool)))
>> >> >> +		return 0;
>> >> >>  	if (WARN_ON(size > max_size))
>> >> >>  		return 0;
>> >> >>=20=20
>> >> >
>> >> > What's the deal with that? How do we get here?
>> >>=20
>> >> Hey! Thanks for taking a look at the series!
>> >>=20
>> >> An explicit frag call on a whole-buffer provider is a driver bug: UMEM
>> >> chunks can be smaller than a page, and RX gives the whole chunk to
>> >> userspace.
>> >>=20
>> >> But page_pool_alloc_netmem() also picks frags for small requests, so a
>> >> valid call can warn.
>> >>=20
>> >> I think it would be better to make it return a whole buffer and its
>> >> actual size. The WARN stays in the frag API, before taking a new buff=
er?
>> >> Wdyt?
>> >
>> > I see.. Idk, I'd still return 0 here, but without a warn. Not sure
>> > we want a warn for any api misuse? Returning no netmem is gonna be eno=
ugh
>> > to debug things? As for the calls from page_pool_alloc_netmem, I'd also
>> > handle it explicitly? if (size > max_size || !page_pool_supports_frag)=
 ?
>> > But no strong preference, up to you, was mostly trying to understand
>> > what we are warning against here :-)
>>=20
>> Yes, page_pool_alloc_netmem() gets the explicit check. Thanks!
>>=20
>> For the frag API I'd keep a WARN_ON_ONCE, like the size check right
>> below it. A silent 0 looks like an empty provider: the queue just
>> stalls, and nothing points at the driver. With the helper fixed, only an
>> explicit frag call on such a pool gets there... Wdyt? I'll probably take
>> that route for v2.
>
> I guess, yeah, makes sense, let's return full size and warn. Maybe also
> a short comment will help to explain why?

Will do, with a comment!


Bj=C3=B6rn
