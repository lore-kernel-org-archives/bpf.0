Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495211;
	b=Hy7dIJwjwQfOy1jzOZqUlrX22NwAQSHPvmeSi8c/pTYpPj+FYC4yzVK5OWu216JfSTpj
	 xc5vPTceyvCuc9uPM3mfUKU2VpIy9pmkLCDroN5ZffU0or8YYTbwoHdfCuPyJSASbv1ya
	 zb6oURAyMuzU5dE/8Ly/WUmSx9LIsMpER146kB13XXDuUQis0Zk0WDiungV0fG9Jr6Prp
	 phy1n/1fmfOKDMdyWHJRCDma0U/a49P4WcKh3idq/qxMKiRKUL/GUBt5fmBgEmsplZ9Ae
	 AYKu1057xnkLIU8Q/8kO06bpcvSPo68rNIFNNIdpNesQJSAbcsV6wa6COv2oHNdO8Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495211;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UBXnliURw1WYp3chrqS7sjRbFTt6XEXbMT1fDo9/1TM=;
	b=k0WkBC8jp8SEp/9JQwXWc5wZ+xPP3RpSlE/VpRP80stzw0WLMQ8XTj9UyRl8qQ7CuEFi
	 ZevJCAohyoJ+xmDseK77juG24UKmPD2MOhgWya/jhtLd0BfX5mmjhvMU1Hm7CQDqXB8Y2
	 im9swdd4rStxRTU1ZK0/8/8ELR8TTUBWG3MrxLZrQyL4EemXoqs3of7I9MwTTVY5DipnQ
	 wu1ZINpAq40qdW46tCbI5arTKS14Eh7QvpXpNhdsVD4taMUnFmutlPW8V2tMUeboF9amy
	 Ahgu7bQa4dSeff7aaeZGinkqwY1dlppTjweG1Rq3dXTwpBKoUMAExea+Q412pYgm26Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSUSIwfp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB5606A321;
	Thu, 12 Nov 2026 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSUSIwfp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67991F00A08;
	Thu, 12 Nov 2026 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794495210;
	bh=UBXnliURw1WYp3chrqS7sjRbFTt6XEXbMT1fDo9/1TM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BSUSIwfpwBS95bhGX07VGZDkvg5eJbUBRjTovvFvuyyl9O4KKBkRLMpDjQWmkCCv2
	 14m3/vbC/nnjlVkglV3QPl3riOJFD5UvK39YWhOEfVVmFRUJ6aRnkuKMGk2TlFeMjl
	 fF/cbZbYAcderFGW12psD5gJtpIIDqGl1SFcnrBPY22izW2LGGLEjRj9nv2UFbNeja
	 ikfgKQrbKaFPQxmwodBjYhUvcCNmek0dufRRAc0o9J9WdFqNM4qoL/zLgX4ZpXxN5U
	 f9k4ZswwSCr/tGFWel0B7PdTbQGT86nnmEhWHpnSnsbHTQhx6EGPCoN97SjZQisZGn
	 MibpFZab8bc+w==
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
Subject: Re: [PATCH net-next v1 06/11] page_pool: Coordinate refill with
 memory providers
In-Reply-To: <avT2Fj5qjbJkArpg@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-7-bjorn@kernel.org>
 <avOtxBw_grmuDJae@devvm16445.scu0.facebook.com>
 <87tslnrwgt.fsf@all.your.base.are.belong.to.us>
 <avT2Fj5qjbJkArpg@devvm16445.scu0.facebook.com>
Date: Thu, 12 Nov 2026 15:53:27 +0100
Message-ID: <87y0ayqexk.fsf@all.your.base.are.belong.to.us>
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

> On 11/11, Bj=C3=B6rn T=C3=B6pel wrote:
>> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
>>=20
>> > On 11/10, Bj=C3=B6rn T=C3=B6pel wrote:
>>=20
>> >> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_qu=
eue.h
>> >> index 989120cbf452..ca12cbf7b825 100644
>> >> --- a/include/net/netdev_rx_queue.h
>> >> +++ b/include/net/netdev_rx_queue.h
>> >> @@ -33,6 +33,12 @@ struct netdev_rx_queue {
>> >>  	struct pp_memory_provider_params mp_params;
>> >>  	/* stamps the page pools of each queue allocation */
>> >>  	u32				mp_gen;
>> >> +	/* NAPI of the running queue, for memory provider wakeups. Set while
>> >> +	 * mp_armed, and if the provider has a refill_done op. Written under
>> >> +	 * the ops lock, read under RCU, see netif_mp_wake().
>> >> +	 */
>> >> +	struct napi_struct __rcu	*mp_napi;
>> >> +	bool				mp_armed;
>> >
>> > The comment should explain why mp_napi !=3D napi? (I do not understand=
 why)
>>=20
>> Fair. It's the same NAPI, with other rules. napi is the driver's
>> association: read under the ops lock, and not cleared when the NAPI is
>> deleted. Provider wakeups run without that lock, from socket syscalls
>> and ->release_netmem().
>>=20
>> mp_napi is an RCU copy, set only while the device is up and the queue
>> isn't restarting, for providers with ->refill_done(). netif_napi_del()
>> clears it before its grace period. Setting it also schedules the NAPI
>> once, which replays wakeups lost while the queue was stopped. I'll put
>> that in the comment.
>
> And all this only to make sure that we are not recycling something from
> the old pp into the new one? And reworking existing pointer to change/upd=
ate
> its lifetime is not gonna do it?

No, it's how the provider wakes the queue when chunks show up: userspace
posts FILL and calls {e,}poll() or sendto(), or an old page pool
releases chunks after a restart. It replaces ndo_xsk_wakeup.

But! I think that rxq->napi can do it: make it RCU, clear it when the
NAPI is deleted, and have the driver poll the queue once after enabling
its NAPI, as fbnic does. A wakeup that hits a stopped queue is then
covered by that poll, so mp_napi and mp_armed go (and with them the
error-path bugs Sashiko found...) I'll do that in v2.


Bj=C3=B6rn
