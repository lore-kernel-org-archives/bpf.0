Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496224;
	b=snOZgEZSfH67YC3QbQJaqI6QaqQshkzrSwZOYAnixq4IbX+FQCQEC0RAaMHSuJLMZEX9
	 kyV0aEXUiWKEyY/jfFlfSaGcuRifEGxKPP177ILqFMqZm3dkRCQFJXtkWFiK+9gxk1h8z
	 f1btavPRMhxhiqW6Dp+t9bCEsK+vSshgX3SIfWtcefqulvAc7KW/j9Ck/ypK2Akc3Z3Df
	 1JAIuHNYwpykwsAHyinONBkD/R1cbdyC3scodUQlnRa9qNJp79HntbxtWyVvrqexghbfy
	 WEql4Z6w6+mWYOktv1i0g/UqWa8s8ZT8XqGsD9Zz7H9jaWCDHW8Y2xfTjaU8kTQQdLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496224;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eCnP3f/5sYjDgXu5gjLcJGqvVbM8pnJiTnh+Y99hcQc=;
	b=BjjtmEFPke+RJ9ALOm57CbBnucRcKJffAwfUBk8HBZfCfV+xe/ixYuPs52BlN17Os+nl
	 NiFehmKb9RV020nj44tWe9Y/p+y8saUyZRAE2Oi6sG2wsYBVkrwBhVm3OlpG25PSFrezD
	 bF7FKk0bK8gkEqSCPMVTAx+g6bOAF2D3j2Fas78XdVIEUxy/LK2mtMHkylpk46TPrKnol
	 e7HwZFfmCKD/pOZ+8aNl+Wq73nVErMVrAmce9qIsHbTZKg4R5E09v/4Wc5qn27H7heW8N
	 JBrTbK5Tl5W4eb9/3/a9BZG2cYNLihSxzSqrXDWC8nWt56Dcinrh+CI15yTcpvQqD8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FO5t0psT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569E606A321;
	Thu, 12 Nov 2026 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FO5t0psT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B841F00A05;
	Thu, 12 Nov 2026 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794496223;
	bh=eCnP3f/5sYjDgXu5gjLcJGqvVbM8pnJiTnh+Y99hcQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FO5t0psTMMZWTQWrqQmrvKX36gkiFfAvWR4ZiJcJQPFqWVcWeZ6he0Lnaz9j6IYXe
	 OEhcfG3tlmlZ/fATPT5sFcQSt7MVxQJvfaGiDGWXbrugT/e9zrsByvjQuURudjIKql
	 gtAG65W3qOmSeFUxExq7PhBgy3xrfs6MpgPQ2jKTx248VgzHeub57/eF3bpAJsts6c
	 OGSCZc/p5egFjnMBgPqeFROyK9o1O2FzrbS6UGt8xstf9stnD3hpsFKzx85K9HsqhR
	 kF8f7qvoEkDB6/QcIXpKjVxAjj4hT5qouLyrG2HDncrZTR16M4thCL4WmT+Fa9EI/F
	 beW8/QL8AEP5Q==
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
Subject: Re: [PATCH net-next v1 07/11] xsk: Deliver provider chunks without
 copying
In-Reply-To: <avT3vVT8iyKqyW8q@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-8-bjorn@kernel.org>
 <avT3vVT8iyKqyW8q@devvm16445.scu0.facebook.com>
Date: Thu, 12 Nov 2026 16:10:21 +0100
Message-ID: <87qzgqqe5e.fsf@all.your.base.are.belong.to.us>
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

>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
>> index 113b0b08356d..b419c673e3f1 100644
>> --- a/net/xdp/xsk.c
>> +++ b/net/xdp/xsk.c

>> @@ -453,8 +501,14 @@ static int xsk_rcv_check(struct xdp_sock *xs, struc=
t xdp_buff *xdp, u32 len)
>>=20=20
>>  static void xsk_flush(struct xdp_sock *xs)
>>  {
>> +	struct xsk_pp *pp =3D xs->pool->pp;
>> +
>> +	if (pp)
>> +		xsk_pp_flush(pp);
>>  	xskq_prod_submit(xs->rx);
>> -	__xskq_cons_release(xs->pool->fq);
>> +	/* A provider releases FILL entries under its lock. */
>> +	if (!pp)
>> +		__xskq_cons_release(xs->pool->fq);
>>  	sock_def_readable(&xs->sk);
>
> optional nit:
>
> if (pp) {
> 	pp_flush
> 	prod_submit
> } else {
> 	prod_submit
> 	cons_release
> }
>
> sock_def_readable
>
> (hard to follow these scattered if(pp) checks :-( )

Sure, will do!

>
>>  }
>>=20=20
>> @@ -464,6 +518,11 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp=
_buff *xdp)
>>  	int err;
>>=20=20
>>  	err =3D xsk_rcv_check(xs, xdp, len);
>> +	/* Only the NAPI of the queue feeds a memory provider socket. */
>> +	if (!err && xs->pool->pp) {
>> +		xs->rx_dropped++;
>> +		err =3D -EOPNOTSUPP;
>> +	}
>
> This is confusing? Why even call xsk_rcv_check for pp case?

Hmm! I think you're right here... this was a (is it bound) check. I
might have been wrong in my reply to Maciej as well. I'll drop this.

>>  	if (!err) {
>>  		spin_lock_bh(&xs->pool->rx_lock);
>>  		err =3D __xsk_rcv(xs, xdp, len);
>> @@ -488,7 +547,26 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_=
buff *xdp)
>>  		return xsk_rcv_zc(xs, xdp, len);
>>  	}
>>=20=20
>> -	err =3D __xsk_rcv(xs, xdp, len);
>> +	if (!xs->pool->pp) {
>> +		err =3D __xsk_rcv(xs, xdp, len);
>> +	} else {
>
> [..]
>
>> +		/* A CPUMAP program runs XDP on another CPU, not in NAPI. */
>> +		if (unlikely(!xdp_rxq_info_is_reg(xdp->rxq))) {
>> +			xs->rx_dropped++;
>> +			return -EINVAL;
>> +		}
>> +
>> +		err =3D xsk_pp_rcv_zc(xs->pool->pp, xs, xdp);
>> +		if (err !=3D -EXDEV)
>> +			return err;
>> +
>> +		/* Copy only packets of the queue, from its NAPI */
>> +		if (unlikely(!xsk_pp_queue_buf(xs->pool->pp, xdp))) {
>> +			xs->rx_dropped++;
>> +			return -EINVAL;
>> +		}
>> +		err =3D xsk_pp_rcv_copy(xs, xdp, len);
>
> Move this into __xsk_rcv_pp ?

Yes.


Bj=C3=B6rn
