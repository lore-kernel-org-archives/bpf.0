Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265616;
	b=YZoKeO7GR5x6GezRYW5JBInKvfqslr/sno3Z2SaTlL7QSdVNdGpTFhjVQR7q4beB25Is
	 NIQ3Wd2RRa1QTShuFjrT774J9T0QsT5jx8eonVHiQGp+tTzGyeMBPuAWh2TkZm4qOLsob
	 irKgaZ1gK9Yod13riPfue20V3QEWGqpFJ3cskx7woamzTEChdU8Xgj9Ae2GF0V90iPL78
	 nKXFlou8QRwN2uyBxDeEqPmG9EE2WsI3EW96kzbxr9DtuOO2eRT+l96Hqpd6siZzVym5/
	 skIV3STGJWb06WI4Epr7YbeWqdN3373vpiaLPPJSAPFe/MWV5cmIbOlh+AE7uqpAdLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265616;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=Kv39YFS3gCTmTIBEpLn+LTr7Kna7mVqtgec2/Wwwicg=;
	b=HV/LvRIe7CQLRz4RRKp+1hWRwmUoSYbveOtP1msP931pWKmDcZC/XBP26BifRLbW1ppJ
	 5GBMS+ICCpuxzeQjNxNzep+Zb9KgdmFLrkTbm6OFFuUfNKVA1wr8L+vdPAyVmHdlaRF71
	 L/zFe8v6XMlcc8NqvgF6H3nmntb+azk8q+VIJJnpDqZwC3kdczzD2+LuiRAkToOF4nQOD
	 nqlI7uEZX/NH8dTgLLf/CDpw6aOOjiGDLqxq/AsZeugWbLjdb7Fk0uxuXIVKApgme+ieg
	 M3OeKmgyU6jknlkW9GjMaHgsbyDnHwp2FxsRNiUwClSoDVGdPPcdIxcB0ffYila8UHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=D0Tve2Qu;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799DF606A32A;
	Sat, 21 Nov 2026 12:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 799DF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=D0Tve2Qu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kv39YFS3gCTmTIBEpLn+LTr7Kna7mVqtgec2/Wwwicg=; b=D0Tve2QuWJTHNHXcUWkFbcPJC6
	TOiab1mhHs6+yzFNQHQnVJYMmE0HwdjNO4aoMN/HLWc3urlQ9nXzmbb34/0NKQmmZYBczP5RgddvH
	vzPz1NHrWYJie+e/K15GD8dlMYj/CXf9w0DKH/xT+vKgtCjYmNk69C+vpkiU9O7hPkWzKKLzrAg8f
	Nf25l5vkdz8GZzeFje0DF2iR2MHUoNElJSn8yGmhHt0W4XZ0syoVlw9TUXq0J+bzrExPGV8ZX7Oht
	60GhviSwhWNnr2BnnEi+keEhlEd9U+CK57Qc7Ndr6c3hpqyWnxHuLJc10iKwBlrRkHh3/olbdjqs0
	hUkL9QWg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xUkaj-003fOK-0z;
	Sat, 21 Nov 2026 12:53:17 +0000
Date: Sat, 21 Nov 2026 04:53:09 -0800
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 1/3] net/tcp-ao: convert the getsockopt helpers
 to sockopt_t
Message-ID: <awGTN1cIEnnlAMPq@gmail.com>
References: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
 <20261112-getsockopt_phase7-v1-1-1eb759dd0929@debian.org>
 <avdxDgmlDBTRgqM0@devvm16445.scu0.facebook.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avdxDgmlDBTRgqM0@devvm16445.scu0.facebook.com>
X-Debian-User: leitao

On Fri, Nov 13, 2026 at 12:21:27PM -0800, Stanislav Fomichev wrote:
> On 11/12, Breno Leitao wrote:
> > @@ -2214,6 +2213,21 @@ static int tcp_ao_copy_mkts_to_user(const struct sock *sk,
> >  	}
> >  
> >  	bytes_to_write = min_t(int, user_len, sizeof(struct tcp_ao_getsockopt));
> > +
> 
> [..]
> 
> > +	/* The reply is up to nkeys entries, user_len apart, with the match
> > +	 * count in the first entry's nkeys, so it can outgrow optlen. Size it
> > +	 * by the keys on the socket rather than by the caller's nkeys.
> > +	 */
> > +	hlist_for_each_entry_rcu(key, &ao_info->head, node,
> > +				 lockdep_sock_is_held(sk))
> > +		nr_keys++;
> > +	reply_len = max(array_size(min(max_keys, nr_keys), user_len),
> > +			offsetofend(struct tcp_ao_getsockopt, nkeys));
> > +	err = sockopt_expand_out(sopt, reply_len);
> > +	if (err)
> > +		return err;
> > +	head = sopt->iter_out;
> 
> Is that faster / cleaner / more preferable than calling sockopt_expand_out
> on every iteration hlist_for_each_entry_rcu below?

sockopt_expand_out() can't be called once something went through
iter_out. It re-anchors the iterator at the head of optval, so it WARNs
and returns -EINVAL if the iterator has already moved.

That check came in v2 of the series that added the helper [1], because
a late call would rewind the write cursor. With a call per key, the
second key would trip it.

So the size has to be known before the first entry is written, which is
why the keys are counted first. ip_mc_gsfget() does the same and sizes
its source list by min(sl_count, gf_numsrc). tcp_ao_info just keeps no
key count, hence the walk.

Sizing by nkeys alone doesn't work either: a large nkeys would hit the
MAX_RW_COUNT check and get -EINVAL, where today it copies only the keys
that match.

The extra walk seems very cheap. The keys come from sock_kmalloc(), so
optmem_max caps how many a socket holds, and the socket lock keeps the
list stable between the two walks.

I'll say this in the comment and resping a v2.

Thanks for the review, you are being key to this whole convertion,
--breno

[1] https://lore.kernel.org/20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org
