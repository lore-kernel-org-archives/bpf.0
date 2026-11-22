Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378422;
	b=d7iNXX5rNCGbgsBYwukUYWjFwTnR1A0KCUyiIwlCeNvyJHMwiSkMULjNDBnASaOz46US
	 aAGsx1k6l9MVFKNi1NveCtB/MDSVzbAD2sFxj7jMSU6WGCvmzxcDM7gWpL0biOdJB1h4T
	 0Sk+F1bJt+P9WQ23sRTKY1eBNRwJfC2ZISZU2Fcg477PFZmGx74neDwhMPNjq6Wpel8xz
	 SpOC5XEgM8QYND5sNL1r9iqdAJc/69LChbd58AzLGqmvcNoTmrR/wu93MO9ycvFBGK0Ir
	 cztXiFCiiNPbsVjTjHYIcaHTVCuuILr/CEX8ehLwAx2kD8R0Ko8YtiCp5TAwMjHmKcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378422;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=51UHX4Srt09ec1lomLkwc4wOrxJotF+1iVMx5Ln4R3o=;
	b=0V+NzHYlzbrrUtUHXKxIRFY5xeDM9l5YlFxvBIxPhwEFsWQG+98UdC+cZpdLR+ENM7RE
	 RxNVmKT3PY/qEyGWpT4C365iTYqGB0hVqxFRRLzfAUuWNgnBEOd8tSk2LC0Go3vaCfkMq
	 0KQNcodq8YbW8pvCXHVZscYFS48zJWT5j43V1yW+EwDmi6vz/royZ91EGJ2NIjakXkXfE
	 3llTRKAEoI/9nXCmsqkaTDcuJvGt7WgDSB01DTZnaUFUuLUG9iMSbYFKjvLWp5OdvGcCS
	 QalWFudcyCSAq3Pqo3vcMofVVPT7NFHNlPfeouhHQLV4nHTP0YzRV4BhgcoolU6NKEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZleViSN8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD28606A31D;
	Sun, 22 Nov 2026 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZleViSN8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238D81F000C6;
	Sun, 22 Nov 2026 20:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795378421;
	bh=51UHX4Srt09ec1lomLkwc4wOrxJotF+1iVMx5Ln4R3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZleViSN88BjY16Q2M+ZekAjLmnNSmmvQd8GG0EQA+eaDeU60Ht6xzWZjMGtYl8tWM
	 rcjBHvA5ATc1dDgo18CWMB8xMVNa+gnQS3NJedaUcadHiJxSaHNuUAnJHuh9dwugn8
	 rpDcjAcqIh3tuwrmJRpfMZnCbVioqbgAGezZ/wnx+H0h/QNuAToy0q5vHZ1wUhCg+A
	 QFwXNz/7ogA5tOeI5tLRBgfjBxIe0J0GBPsm4ig2wshqfaMsD3VpuHB717dEkogmbx
	 zm0wvsu4vygWPYpKl3sOYAq29l28SqW/mohimbgsKn3sVlWTff/zwi9xY9OHxlvClT
	 rYDoHy/UMSN+Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Alexander Duyck
 <alexanderduyck@fb.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Pavel Begunkov <asml.silence@gmail.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, kernel-team@meta.com, John Fastabend
 <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Weiming Shi <bestswngs@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Bobby
 Eshleman <bobbyeshleman@meta.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next 7/7] selftests: net: Test XDP on io_uring RX
In-Reply-To: <av-Udp0GfOjxH9vq@devvm16445.scu0.facebook.com>
References: <20261117164700.2157816-1-bjorn@kernel.org>
 <20261117164700.2157816-8-bjorn@kernel.org>
 <av-Udp0GfOjxH9vq@devvm16445.scu0.facebook.com>
Date: Sun, 22 Nov 2026 21:13:38 +0100
Message-ID: <87mrr01v65.fsf@all.your.base.are.belong.to.us>
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

> On 11/17, Bj=C3=B6rn T=C3=B6pel wrote:
>> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/t=
esting/selftests/drivers/net/hw/iou-zcrx.c
>> index 91b025a8771e..f7e909fd6840 100644
>> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
>> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
>> @@ -258,6 +404,34 @@ static void add_recvzc_oneshot(struct thread_ctx *c=
tx, int conn_idx, size_t len)
>>  	sqe->user_data =3D conn_idx;
>>  }
>>=20=20
>
> [..]
>
>> +static void verify_data(struct thread_ctx *ctx, int conn_idx,
>> +			const char *data, size_t len)
>> +{
>> +	size_t offset =3D ctx->received[conn_idx];
>> +	size_t i;
>> +
>> +	for (i =3D 0; i < len; i++) {
>> +		if (data[i] !=3D payload[offset + i])
>> +			error(1, 0, "payload mismatch at %zu", i);
>> +	}
>> +	ctx->received[conn_idx] +=3D len;
>> +}
>
> Move some of the refactoring/fixes out into a separate patch?

Ya, makes sense! Will do!

> But in general feels like a wrong test to extend.. Why not call
> ncdevmem somewhere in python wrapper (and attach xdp prog that you
> have in this patch)? To decouple xdp testing from the entity that
> generates/receives unreadable frags.

Good idea, I'll try that!


Bj=C3=B6rn
