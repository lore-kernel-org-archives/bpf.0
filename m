Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08836B93C;
	Mon, 12 Oct 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813189; cv=none; b=sYSl9tBj9/tFlGVGIf9Ddp3a7bGs5n58STUxKUOo+w0BFn+p7wZJMEdRvRzaje+b8s2c98fdsm0tVeh8raUD9+w0YoVMYSS3UDIzkXwawafZf9GiVfAxNwOxR7NJqmGJuZbgAi8DERNw5PBqLSOXmeh+txi3rDfGLbHtrID34eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813189; c=relaxed/simple;
	bh=ty92T9DIYoaFJgqiIsGaVgwgaRXfKBk//M0JGEOokgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B2TGPfALLfF8cd5fC0lFhFgxL//Ctz1AYkhvrkB641wH8Oc6Ps3YbaoOQfULFZ1w9HnDWlpzYAFxJ8AARfXTvWcAcSkeyFmWXcpQywTwG7o9XaKzBQlVVN/NDp2vdOfVeHl1JDSY8MA7QrUvRWSw0qgUJ2UHvfiBbnJyWvKyO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCTIHzqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCTIHzqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1016A1F0089B;
	Mon, 12 Oct 2026 13:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791813187;
	bh=GzKb4Ad7HkW8BrqEc5W4LYKOWUBVf/CLkGtUNjDmfbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YCTIHzqn72vjsJTW7DN54VLFkp+SEk1NrFctnxBpEBhPFVs1HjRsyb9z09WjCjrMh
	 aIoy/knzExgia6fSnVS8REcAs7frk82ybWlSfWazq6e1yDWXN5jeUbuBn1OwfktQA7
	 o6t4F1aYgYCLlP+onpjLne7b/QjTo1lwpS0M1myBXo/sE2AcXHT52K+21IRe9bFzzw
	 0iopNBZLcIOSnmljYjCoVkScRrjYEZuAsYBE9/xzbNCluVoivBsZzaQ2ivuxSh/uVq
	 zxuoNspDBYnkuswY5N9ZLp46OSPjz6wtLVmLY7UKlKMPBYXvDOhS+fTXRtvEv19TVP
	 PeUOn3kF4SnVA==
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
 "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi
 <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, David
 Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mina Almasry
 <almasrymina@google.com>
Subject: Re: [RFC net-next 05/15] page_pool: Extend memory provider operations
In-Reply-To: <asPUZ8DPllHd6Yu9@devvm7509.cco0.facebook.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-6-bjorn@kernel.org>
 <asPUZ8DPllHd6Yu9@devvm7509.cco0.facebook.com>
Date: Mon, 12 Oct 2026 15:53:05 +0200
Message-ID: <877bjnc9fi.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> On 10/02, Bj=C3=B6rn T=C3=B6pel wrote:
>> The current memory providers give memory that the CPU cannot read,
>> and they can always refill. An AF_XDP provider is different. The CPU
>> can read its memory, it has only the buffers that userspace puts in
>> the FILL ring, and its buffers go back to userspace instead of being
>> freed. It needs four things from page_pool:
>>=20
>> - A CPU address for each net_iov. A provider can set the address of
>>   the first net_iov in its net_iov_area and the size each net_iov
>>   covers. netmem_address() then computes the address without a call
>>   into the provider; drivers call it for every packet. A
>>   net_iov_area without an address stays unreadable.
>>   page_pool_is_unreadable() is false for a readable provider.
>>=20
>> - A way to say that the refill is not done. The new refill_done
>>   callback tells the driver whether it may stop refilling. A
>>   provider that still has buffers returns false, and the driver
>>   keeps NAPI scheduled.
>>=20
>> - A way to give up a buffer without freeing it. Add a batched call
>>   that ends page_pool ownership of buffers that leave through the
>>   provider, for example to userspace. It clears the page_pool link,
>>   so a later page pool can take the buffer. Add the matching batched
>>   call that sets the link, and a DMA sync helper for drivers that
>>   post a buffer again directly.
>>=20
>> - No buffer splitting, because a split buffer has several owners.
>>   Add MP_CAP_FRAG. page_pool refuses fragment allocation from a
>>   provider without it.
>>=20
>> devmem and io_uring set MP_CAP_FRAG and keep their fragment
>> behaviour. Their refill paths now use the batched call that sets the
>> link.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>> ---
>>  include/net/netmem.h                    | 31 ++++++++++-
>>  include/net/page_pool/helpers.h         | 62 +++++++++++++++++++++-
>>  include/net/page_pool/memory_provider.h | 28 +++++-----
>>  io_uring/zcrx.c                         |  4 +-
>>  net/core/devmem.c                       |  7 ++-
>>  net/core/page_pool.c                    | 68 ++++++++++++++++++++-----
>>  6 files changed, 165 insertions(+), 35 deletions(-)
>>=20
>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>> index cc97611632dc..e6dff0b01581 100644
>> --- a/include/net/netmem.h
>> +++ b/include/net/netmem.h
>> @@ -105,6 +105,12 @@ struct net_iov_area {
>>=20=20
>
> [..]
>
>>  	/* Offset into the dma-buf where this chunk starts.  */
>>  	unsigned long base_virtual;
>
> Will send a patch to drop this one, don't think we use it anymore..

Ok!

>> +	/* CPU address of the first net_iov's memory, or NULL when the CPU
>> +	 * cannot read the area. Each net_iov covers 1 << @niov_shift bytes.
>> +	 */
>> +	void *vaddr;
>
> Who is setting this? Somewhere in another patch? Can we keep it here?

xp_pp_create() sets vaddr in patch 9. I'll move that closer.

>> +	u8 niov_shift;
>
> If we need niov_shift at area level, let's move the one from binding here?
> Then the existing callers can do binding->area.niov_shift.

Good! I'll consolidate the binding's shift (and rebase on your
base_virtual cleanup)

>>  };
>>=20=20
>>  static inline struct net_iov_area *net_iov_owner(const struct net_iov *=
niov)
>> @@ -117,6 +123,23 @@ static inline unsigned int net_iov_idx(const struct=
 net_iov *niov)
>>  	return niov - net_iov_owner(niov)->niovs;
>>  }
>>=20=20
>> +static inline bool net_iov_is_readable(const struct net_iov *niov)
>> +{
>> +	return net_iov_owner(niov)->vaddr;
>> +}
>> +
>> +static inline void *net_iov_address(const struct net_iov *niov)
>> +{
>> +	const struct net_iov_area *area =3D net_iov_owner(niov);
>> +	unsigned long off;
>> +
>> +	if (!area->vaddr)
>> +		return NULL;
>> +
>> +	off =3D (unsigned long)net_iov_idx(niov) << area->niov_shift;
>> +	return area->vaddr + off;
>
> Or, alternatively, store dma_base in area and do:
>
> return niov->dma_addr - area.dma_base + vadd ?

UMEM pages don't have to have contiguous DMA addresses, so I'd keep the
index-based CPU offset.


Bj=C3=B6rn
