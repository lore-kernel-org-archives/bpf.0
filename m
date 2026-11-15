Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777522;
	b=Q5M4EfEGk2oJ/nihG3QaAAbkMci7nfCmfjOXD1NJOKcUs+daFpRUhvcUa4+4GoEqeQvB
	 lQEfmf0b6iMLRIppUdDkkWEFB310ezMgo8nPLAstNOoPQJiZCZKlyxZMq8OhevhoGzbtr
	 2lID9oEpa9i68egXZwah3yqbiYEX/+FC0qmeRuFVqfM8sf04XmIjGeeEJy3b3mpphUuXF
	 0bnPMHgvCjKcyv7biPhcVdw6E1/2pnDbgn4L7xkvChniKM8S2ga0cnfGjSHrwnfsyD1XI
	 E0vUbcHJShs2jycnTBgek9NJHNOAiwvCzM3VOmwGiXwebbvLFwKO30vVK7R32G8GMwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777522;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q5iSJg23I/t5s7cgSYKq2DalQ5gBF4qJzBvJDEt0/lY=;
	b=A24O1vdTXwHTBeXh6ISv36tAIhGtDlqOJbqw1xqDaAsOeFg8XP0uAC7kCtXZpfE6UdNt
	 u8mJnPcTUnIUeMA/YeeuiNh1jtZnfVR7jipZ4Giyuf1+Brh3YxqW2xi+YHTg8llu7qagk
	 55SkW7lzEl5mYtzwM7JY7AUFsRDzlCfFImFszrE+fxWQyIPxGFa8hVN7conKvMkcStuW3
	 zdi4BQuBGCLUeLzcib8RCBChLz9XA6NGMnOfLTzHm2URXBoDb8ee2y4yl5A60AEiaVHGH
	 bZoKPzyjGgs2zMwekb+IGi+j4LcGHeGYufWM3lSak0QVsahcK6pn6MjvlEPQL9JkjVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtD7pwMy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA860606A323;
	Sun, 15 Nov 2026 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtD7pwMy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BF51F000C4;
	Sun, 15 Nov 2026 21:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794777522;
	bh=q5iSJg23I/t5s7cgSYKq2DalQ5gBF4qJzBvJDEt0/lY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UtD7pwMyR5SxiDxtCKmp9a2QJlTQP2tilz9oUgQfWQMw4RoPgBSPc30BdzTC7hWyO
	 Dz+mZcWIay2QujraHaA8j/S1TVUnVUuzlYVnn9C5aGfXQ+IvPqO2qaKUIaciJWwIZO
	 3DRjrk9bzlm49h0FIjGfKr2QDjIVCxmvlTzCpMFShNPRNWla8VuXSH9IjVEUfvO1NF
	 8rGFPqXJBg1TnaCkqezW22OdtvU0slXiZ6W+shZHcaoO2Y2/PK3IoPdohQ+ayNCEmO
	 MitpO6bq+eePkAsluXJ8Xyok+6aHDW5SBqCeCx618Tu9iKxBEf9iTEWMUB4gBVbwiG
	 uQTwJ7x5R7wHg==
Date: Sun, 15 Nov 2026 13:18:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>, Jens
 Axboe <axboe@kernel.dk>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org, Mina
 Almasry <almasrymina@google.com>, "Mike Marciniszyn (Meta)"
 <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
Message-ID: <20261115131840.55b03578@kernel.org>
In-Reply-To: <20261110102039.1002605-3-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
	<20261110102039.1002605-3-bjorn@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2026 11:20:23 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_p=
ool/memory_provider.h
> index bceb5f7740e2..4417e54a0f81 100644
> --- a/include/net/page_pool/memory_provider.h
> +++ b/include/net/page_pool/memory_provider.h
> @@ -19,6 +19,18 @@ struct sk_buff;
>   * Per-provider custom logic must be delegated to memory_provider_ops ra=
ther
>   * than handled directly in page_pool core code.
>   */
> +
> +/**
> + * enum mp_caps - memory provider capabilities
> + * @MP_CAP_READABLE: The CPU can access provider memory. It may back hea=
der
> + *	page pools, and XDP programs may run on it.

Being readable is the normal state for memory.
We should be marking mps as unreadable, not as readable?

> @@ -1070,6 +1095,9 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_=
pool *pool,
>  	unsigned int max_size =3D PAGE_SIZE << pool->p.order;
>  	netmem_ref netmem =3D pool->frag_page;
> =20
> +	if (static_branch_unlikely(&page_pool_mem_providers) &&
> +	    WARN_ON_ONCE(!page_pool_supports_frag(pool)))
> +		return 0;

Shouldn't we return a full page if we can't frag?
Fragmentation breaks up a page into smaller units,
it should be legal to simply return a full page if
fragmentation is not supported for the provider.

>  	if (WARN_ON(size > max_size))
>  		return 0;
