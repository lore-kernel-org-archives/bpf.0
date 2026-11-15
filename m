Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794769097;
	b=4MArO9E0LYHgUaoIYbqDOP4v426v8KzepL6StADOmxjP7OfWeVw94+P40TzSut+Jm+ve
	 FhGZaUFOQlEBjjsOJee7FhgEZ+a6SQnPkx662bf9Q3E64sfETKzwP0aL5hpYbBstOL4/J
	 FZ0ymfCB+9oop/x3V5/jcohLcgDd8HNd7cjf8qUXy2lNaQhWIhpEcBu3lnUszhiXbPGS2
	 ECC7Rzbu5LrXWbZzMMcvhWiJRebV50FcXBuPMzjmSkMY434J0T9l02agu8B6ikCUm2WV8
	 mZ61UVaXhlrh6l/7c7FUcaMCKuXCPYBFYzrnP4J2vFg7Jd9/WAklwDHc6XPCziSY1uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794769097;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/5QrKnvU0Qno9VQ/EvjjfuAudcpZNRbBCfi2bu7/sfU=;
	b=nIcs05pSl7LhvxOlmxm0BBKVrs4TAffTgv0WAy5yJjEizabPslJoM4IFEqhqd/22l9zV
	 TYxufHWNULc65pDpYncmdNpYILcg7Fizk6QDyK28uz1QFnE2IL3VqOiNH8XYeVErq6yli
	 JLryzbFdUMbsmw1ncQnuX0d6zQVw9YXohAPa20gPDILE6nVop3aPa9RTYEVaiYTSPNmMB
	 fJdmAvCioAwfcRjMv0nAd7fnQj+ygpDxE50XE6OeYGyJkTx5IgmxfiVZu8QFP7NtK4w1X
	 O7/+Dq+pSU6QOiXVy1FqWZFnvxi4Jy7Wsrb7b4tE2G1Yfdf8bjoLET4QxhzhkSPgJ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+NZbe8T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E20606A31D;
	Sun, 15 Nov 2026 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+NZbe8T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F551F000C4;
	Sun, 15 Nov 2026 18:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794769097;
	bh=/5QrKnvU0Qno9VQ/EvjjfuAudcpZNRbBCfi2bu7/sfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=U+NZbe8ThzlDpgS3kabDksHjepLJhEYiNYKs/u4dKBxnesdlD+FwDl8aarRKbjo95
	 WCvNzaMpy5iyoUy8PHgiyU+KZ4EnM1SsofUi35hRlNXrZVcfD9faKMLPQMXV3GxdQ8
	 H2eaf2hriAgJ0cGqoOfl4Ay6a4Pzx6uNjAGSPiUiqim/RGzOG+N/WEdAAlQOG1Q7sd
	 j6S8MVtqk0mhLSrldt89Q4Fuw8K0tFc2SUd3BgNS4Tp97A7+UzT1G+wQS9kKN5km+u
	 Vng7DxWJieY4JjxTVUbq6AuvD7Zp0GIWUdjmuZTcqGgrC/sNIIZSA3jZC5+mPI1HOW
	 hhSEjNI7QdGyw==
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
Subject: Re: [PATCH net-next v1 05/11] xsk: Install UMEM page pool providers
 in the core
In-Reply-To: <CAHS8izMkjoJgoPObC++mXRrA6NUx9+hWLE7JWAH3UXbtm8HEXA@mail.gmail.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-6-bjorn@kernel.org>
 <CAHS8izMkjoJgoPObC++mXRrA6NUx9+hWLE7JWAH3UXbtm8HEXA@mail.gmail.com>
Date: Sun, 15 Nov 2026 19:58:14 +0100
Message-ID: <87mrr9j515.fsf@all.your.base.are.belong.to.us>
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

>> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
>> index fdd55265a6cd..c2214e718cdb 100644
>> --- a/net/xdp/xsk_pp.c
>> +++ b/net/xdp/xsk_pp.c

[...]

>> +/* Called with RTNL and the instance lock of the device */
>> +void xsk_pp_unbind(struct xsk_buff_pool *pool)
>> +{
>> +       struct xsk_pp *pp =3D pool->pp;
>> +       struct pp_memory_provider_params mp =3D {
>> +               .mp_ops =3D &xsk_pp_ops,
>> +               .mp_priv =3D pp,
>> +       };
>> +
>> +       /* Unregister removed the provider already */
>> +       if (!pp->rxq)
>> +               return;
>> +
>> +       netif_mp_close_rxq(pool->netdev, pool->queue_id, &mp);
>> +       xsk_pp_detach(pp);
>
> Need to handle netif_mp_close_rxq() failing here maybe?

Ya, Sashiko found that too... a failed restart leaves the old queue
running on the provider, and this unmaps the UMEM under it. I have a net
fix that keeps the provider on such a queue and retries the removal; it
covers io_uring zcrx too, which drops the error the same way. The fix
then releases the UMEM only once the queue DMA has stopped.


Bj=C3=B6rn
