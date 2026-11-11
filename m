Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405675;
	b=i80j8lCz4j4D6A3lMJGk9zjAh22GZvKibhro68GhTUiH2cZmQhkR6GItbzE1eisdeVsI
	 kteC7nDPstX5qmL5R/OwMJ/U+tr4vaqiY37MhZGEb/whXSgWh64pXeNDGVD/EE/ddt71o
	 THO4ZtgKeVGQiRv3wv/FrITukwAyA8MFNJi5VNLQ2DRhT+knx5+Nt1XD8dyVPhXW8SGI2
	 gQITH+xvBtjbfOSFAbChmnq2HbT86vr3sEpCEjugYJaKAp3AyYzv4tg8MjETTepTramLJ
	 fVRPj8SGyzxfDWQjujCbnrlYqWwcYGq9UNT40eCvMU1CZSkk9s11NPcgK/DmVMPqxew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405675;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WoRYdTtLmsDruURquglEQQKEz9H32K7zeMI5A2g+A4g=;
	b=zowCmhMqlL/YoAi0eGOWRTFwiaei/zmrJcHdpg2mtqkKvOSLdxW90zruBy1wWte+M40m
	 Ly3bGjUbkvzTW2wYOkN5hH4kdAM96m0Jl9/A5zkisfcPYwZMhgQTi97DcT+8ueGNiQPb9
	 /1hKbotrSspziMy/HjgQ+wBG5eZieqB2sp0N6Da+PlZIf9XMjD0NZrMjzvTW9XrFoIplL
	 dX7qYvO9Mi/VtJ8RsvbkQ7PZHiKIPuQembO/qJjfgXNu6K4ZOL8PXEgyu5YT+LCJwg1mp
	 hYBfg47rxFFLeHF+tdDMiMSsYBbD81SEknyjxzYjdP69MjTS7aRa/+9Y2zUZRpkvXuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCeaMx2j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A13A606A321;
	Wed, 11 Nov 2026 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCeaMx2j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8F61F00A05;
	Wed, 11 Nov 2026 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405675;
	bh=WoRYdTtLmsDruURquglEQQKEz9H32K7zeMI5A2g+A4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KCeaMx2jcz3SFAvzP00Exb8N4E2wKRHMxllmAcWBaiCsBZWx/9QT3vL06JI6hylHv
	 l9sMtpINj3S52VvHmsRqF0On4p115Od/esnTgGsznoV3Yj9yY6d8f3ubORXu8Y++1V
	 Az02JRKHBCyPPFKQkDtcbYgxTyJUSlA8eSvvSEtqqdycnP+OrFrrD26xxqNv7NnUAJ
	 6rXKJOkUqBafI1etfhvNfOoXve6m8CGJGWVPDa5IQ9gP6qA7SYSQz9Mx+DPQMcZWPT
	 iknAS9AEH6AgTu6GjuQ6MKCwLu4VMoGdK9A01LVUKWPIMHSO9r2xDL7qksj7i14KGi
	 sYe3Zk6iTIXZA==
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
Subject: Re: [PATCH net-next v1 05/11] xsk: Install UMEM page pool providers
 in the core
In-Reply-To: <avOtdOaiLFoUgbK9@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-6-bjorn@kernel.org>
 <avOtdOaiLFoUgbK9@devvm16445.scu0.facebook.com>
Date: Wed, 11 Nov 2026 06:01:12 -0800
Message-ID: <87ik238o2f.fsf@all.your.base.are.belong.to.us>
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

> On 11/10, Bj=C3=B6rn T=C3=B6pel wrote:

>> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
>> index 18966bbdb5b7..c620a0c32c17 100644
>> --- a/net/xdp/xsk_buff_pool.c
>> +++ b/net/xdp/xsk_buff_pool.c
>> @@ -104,10 +101,30 @@ struct xsk_buff_pool *xp_create_and_assign_umem(st=
ruct xdp_sock *xs,
>>  	pool->fq =3D xs->fq_tmp;
>>  	pool->cq =3D xs->cq_tmp;
>>=20=20
>> -	for (i =3D 0; i < pool->free_heads_cnt; i++) {
>> +	return pool;
>> +
>> +out:
>> +	xp_destroy(pool);
>> +	return NULL;
>> +}
>> +
>> +/* Only copy mode and driver zero copy use heads */
>> +int xp_alloc_heads(struct xsk_buff_pool *pool)
>
> nit: move xp_alloc_heads rework into a separate patch? this one is quite
> big already

Will do!


Bj=C3=B6rn
