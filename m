Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794768423;
	b=hiF9rP/X4cz4QvIQbRSRtS+dMRx9fzxVYH1i5dd2lO1ILVtIgYZxJHecEsLz9OL1+F+8
	 sqlFW7mwXuxLAmjoRWnw6nAgQzMLEBcgYeHJ+rFXS8wwM/ZXUldDt0kUF1K6YAR9jRGTu
	 BLE7gQMKY3lOx85YzoAv7QvekrHo3K2fDyjD8WlUf9+mjf7UIUVihw2QfoSKPdN9Bl7/Q
	 Q4bNGkLqc00Ny32ENviEhTf6OI98dO76z2U9OurPhQyW8YoAHnOT+brfaBotFuotO0KAA
	 sEAN7PfLQbW9uDixU3zQEOHPsXskQcFvJbojy4T0R2YtumI78w1cK36glX4XR8EywUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794768423;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Na2XO9zB5CCljMGVxWPztMYjQeo7vwyHFK10e26rYCg=;
	b=DooAt3ul7vEoZ5ojN7Sn+K9hfxrGz6fYOJXC02jlVSb4dBtYDcKgwnXIMn2YmOe40LJL
	 Hujc4EEybWPGonLJFk5KhZJMDm1X4opbY5Tph/3UK+yCkY+WD5syrbAGiAjiR3hJAwPeW
	 ozCQTNApr/Isr2DIqbVme7R1KU/DuwD6PuzN5cQtYIXagR6vWuonp0wMvytB1h9pUq3G2
	 /rPj84i8sjtfgONiFxje1qhw9sCRjPu50Avjw0uSmNmNrEVr0WjmxgHUhDNIDb8FKoo5g
	 1tTs4PfqqR1jDbukjTe3TnrfqMjS2NaM/8XgjkSJdck1Oa6KDxGqAeLuXUUWA4aLdaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/qmH5ha";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4042F606A31D;
	Sun, 15 Nov 2026 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/qmH5ha
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CFE1F000C4;
	Sun, 15 Nov 2026 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794768423;
	bh=Na2XO9zB5CCljMGVxWPztMYjQeo7vwyHFK10e26rYCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=U/qmH5ha4nQoNSqrzW1+vONVi4qEDqJD002kvbGnuEYnu9pgJ/u3bROdSccZsxs9w
	 XnVYBUj4swTq9zb1L1Nwqs2G3Ve7CHxMto5LG5T+zy/BYVCCk005yZNmWXT1MYAUG5
	 4+8hgt0Qs04bk8HAccehXAB7rQktrZydb5ZW3gDMWmzOjkRecJITgpq7ekleOfaSKj
	 wPrOKTBXAJZSkOuLd/c6PqdoSoDdxwlxoRV09DPxORqgURiLdlNA7NpGSRQpCpO45v
	 XZLqUmgDgEGMgNhB/0Xz8Lnc3qpLZ0cSwmqaF6k9nb9Sq+xV/H0n7BNmgwRj0YgRWM
	 YQ8FNkYNIuKMA==
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
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
In-Reply-To: <CAHS8izMaAv6gX1NeJR+QCf43CL+DC4DgePRNNxSLoE31jxHU0g@mail.gmail.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-3-bjorn@kernel.org>
 <CAHS8izMaAv6gX1NeJR+QCf43CL+DC4DgePRNNxSLoE31jxHU0g@mail.gmail.com>
Date: Sun, 15 Nov 2026 19:46:58 +0100
Message-ID: <87fqx2j5jx.fsf@all.your.base.are.belong.to.us>
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
>> The core treats every memory provider as unreadable: installing one
>> needs header split and no XDP program, and any page pool that allows
>> unreadable netmem takes it. An AF_XDP UMEM provider is readable, needs
>> XDP, and hands out whole buffers.
>>
>> Describe providers by MP_CAP_READABLE and MP_CAP_FRAG; devmem and
>> io_uring keep their behavior with MP_CAP_FRAG. A page pool takes a
>> readable provider only with the new PP_FLAG_MEM_PROVIDER:
>
> Why do we need this? I thought whatever creates the pool actually
> shouldn't get to pick whether the pool picks up the memory provider. I
> thought if core has configured the rxq for a memory provider then the
> pool is forced to take it.

Thanks for looking at series, Mina. ...this needed some thinking.

It isn't forced today either: only pools with
PP_FLAG_ALLOW_UNREADABLE_NETMEM take the queue's provider. Drivers set
it on the pool that holds payloads, and keep headers in host memory: in
a separate pool (fbnic, bnxt), or outside the page pool (gve, mlx5).
That works because every provider so far backs payloads only.

UMEM doesn't. The socket gets whole packets, so UMEM has to back the
header buffers, and with multi-buffer the payloads too. The flag was my
way to get it there, but you're right that it's the wrong knob: it lets
the driver opt in, where it should only say what each pool holds.

How about this instead. Both sides use the rx_roles bits from patch 5,
HEAD and PAYLOAD:

 - The provider says which buffers it backs, next to rx_page_size in
   pp_memory_provider_params: devmem and io_uring zcrx PAYLOAD, AF_XDP
   HEAD, or HEAD|PAYLOAD with multi-buffer.
 - The driver says what each pool holds, in rx_roles. A pool without
   roles but with PP_FLAG_ALLOW_UNREADABLE_NETMEM holds PAYLOAD, so
   existing drivers don't change.
 - page_pool_create() gives the provider to a pool whose roles are all
   backed; the others get host pages. No opt-in.
 - After ndo_queue_mem_alloc(), the core checks that the new pools that
   took the provider cover everything it backs, or fails the restart.

With fbnic's header and payload pools:

  devmem:                header pool host, payload pool devmem
  AF_XDP single-buffer:  header pool UMEM, payload pool host
  AF_XDP multi-buffer:   one shared pool, UMEM

A shared pool on a devmem queue doesn't take devmem, since devmem
doesn't back HEAD, so the check fails and the driver has to split.
That's the "headers in host memory" rule, without the driver asking
which provider it is.

Wdyt?


Bj=C3=B6rn
