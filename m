Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425830;
	b=uE9DM0Jdztu4QmOBVnRCogttR2AbojvzZjOckW71X892UxhpYIQCuxjURgVVwaLndrT9
	 sEgK0ccJKYoPqoHA+//5AnBdilm0FZs0vxGRLzgXiCwu8Z5cebqEpS05BFos+QyNwEfzr
	 sGX1y3F1botKGhkfhDj6FQLSEy7lw7g0iy0STd7gK0QenUInwuTmL2AjKJ18YsLD7/7t8
	 3vMQ2ATXUkZT+Q4YS1sUW2rJypUl3cb1Jjw7Aw/lB5C7+FcRH9OVdX3PbWdpHRzQjpwwC
	 g5AxiJxECIwrlAYgiLBeDda1A0648o8/hTGpwVoajmETbctc18odDXA/4GwUwta8cng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rU8BFHby+chLqg6yUo2dIVn2wmUVQjWzLXO6gt/AMH8=;
	b=Dv5mjJ0fXrfqLumDtnMe+y5LEB7yZF543WMnmC2qWIajbd6/Pqz3G8v+c2BDv3BvMKuj
	 Jnbwd/dA7ECLk4U8vGZzOc7sUeFUXd9lmcT6UnVXWbFeGJ1i2hbEGvkwHQlUilC9EYFAz
	 SxHkP/EWOv51RXD7PZVVyNhqLVZ9C5zwBc3am+KUc6OdgbCg/X6NT6ul8yFq/wiAeL3qm
	 K3edUmh9mPiyTfcwqlIyNjB4jhI13Ly2x7HX9MjXvMEYJXc26Lf+fm2zAtP0L5tPmLZwG
	 KV+eEz/Vk/oPgP+2G3gvVUv0gRDeIAb4KmqztAiD+FJfGJUNYxWhZlhhZjs4ll2ZmBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3XCwI1J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729E7606A31C;
	Wed, 11 Nov 2026 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3XCwI1J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD0D1F00A0E;
	Wed, 11 Nov 2026 19:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425830;
	bh=rU8BFHby+chLqg6yUo2dIVn2wmUVQjWzLXO6gt/AMH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=P3XCwI1JFmAzSFSOPOrSh7rrINwQ1YJpxcqSYTfqOIlLS8/t22ZVQXQBn5jRXvxuX
	 OS1LEFE9x60eIO1txakYVHoGVBlh7WiBcdq7FH+tzdHicNC2K2kIkpfpF5bixxUoFr
	 GSzqvXNsZcjz0OVHH4KTY8h84icId/Jv7G8oWoXNgXNAmylmgDjDpqBN9XNCAoszOp
	 j+IHkVJh0opMaeiEssoaEISxPs40s2irBOlyK/oH0sotupmLDIJE8kWrMAMmc9Xz4O
	 uyquT2ydwZIjWwVU2RjEbl4DtclmQRhXy7vLQe36Ad0C2DMs+qJkl/FTKjNcL9dMnw
	 qOPJWS5BEa0vg==
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
In-Reply-To: <avOtxBw_grmuDJae@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-7-bjorn@kernel.org>
 <avOtxBw_grmuDJae@devvm16445.scu0.facebook.com>
Date: Wed, 11 Nov 2026 20:37:06 +0100
Message-ID: <87tslnrwgt.fsf@all.your.base.are.belong.to.us>
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

>> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue=
.h
>> index 989120cbf452..ca12cbf7b825 100644
>> --- a/include/net/netdev_rx_queue.h
>> +++ b/include/net/netdev_rx_queue.h
>> @@ -33,6 +33,12 @@ struct netdev_rx_queue {
>>  	struct pp_memory_provider_params mp_params;
>>  	/* stamps the page pools of each queue allocation */
>>  	u32				mp_gen;
>> +	/* NAPI of the running queue, for memory provider wakeups. Set while
>> +	 * mp_armed, and if the provider has a refill_done op. Written under
>> +	 * the ops lock, read under RCU, see netif_mp_wake().
>> +	 */
>> +	struct napi_struct __rcu	*mp_napi;
>> +	bool				mp_armed;
>
> The comment should explain why mp_napi !=3D napi? (I do not understand wh=
y)

Fair. It's the same NAPI, with other rules. napi is the driver's
association: read under the ops lock, and not cleared when the NAPI is
deleted. Provider wakeups run without that lock, from socket syscalls
and ->release_netmem().

mp_napi is an RCU copy, set only while the device is up and the queue
isn't restarting, for providers with ->refill_done(). netif_napi_del()
clears it before its grace period. Setting it also schedules the NAPI
once, which replays wakeups lost while the queue was stopped. I'll put
that in the comment.


Bj=C3=B6rn
