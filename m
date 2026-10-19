Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423248;
	b=Fg37cNAnlTLLIeKePJ8BlDuWnhtWlMOVkSggSwxsrooTVE7kv8zPp8dvpepIvvYv3EMj
	 qdFvkxJBPG50d9HdjdvBzjpOatwaakwfNevtq8PvF788XgKlUItIUQJwBicjgD3Z8Pnx1
	 vJ/lLr1mQ0iyshH2Y9knREzemxCCm/v266aNjbjHL1+iohHgLWkllEjH1Ajtkyp/GdBPw
	 c3PKoxl7pkX9V0eCxJRjwOMfeZvPqmF1adJd/UaI+QSl/Ee/13FVYXLN9D7c5/+nFaydz
	 OF4w10S6gZCnSOEzCoy2LIBTPHrDywwl/QHAXT5iNQgp6gwIaDH3EqmHDpaUuKWfWOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423248;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=bBh2tZGQIxFPgEShZWQxYNOrHJClPx1vl1bg2n8Jux4=;
	b=Crql2Wddf1VISps6Ue5eyLKnk1TPLWtv1SYoIAoQW4kekAXSq4JYO913V/DvOyyGtTKo
	 EaTHRvwh+WVkdnvOnyDqvosQ2EC0PB6eLeq0Ki/UCX3wvSHWHMp2cdmdFuSL+0QILXkRa
	 SkXnx4H3S8NHy6aeRZikq7o99U8cp1e8ftIHvqaciaPszKrW8gCLNKBfkq7dv6U1tiHJv
	 qHNkwR4QwZAhgewp9U0jmctdmGz03daTXEP7OSNHEQ71waOGzzkqYMd1eusaDCVAYiD6D
	 VtXxpGy2lsuouNxZg7+xQlQZJIoF7x8BzYPCxv8lGnhDStcv/R0K9kwB2Uaf3KYRzoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=Gkcynfr8;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8039B60A7E4D;
	Mon, 19 Oct 2026 15:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8039B60A7E4D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=Gkcynfr8
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xIpAJ-0033c8-2d; Mon, 19 Oct 2026 17:20:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=bBh2tZGQIxFPgEShZWQxYNOrHJClPx1vl1bg2n8Jux4=; b=Gkcynfr8/rgtLQhhpz/qL1Wsu6
	jpuzsmXh6vMlyYitB0AlmuGBBom4jZ5niI5gWnbuwCirvSG2i+bYFXYCoepuLJeCBMjLk+IPO2x6x
	wBmkMO5tuXi5XXRxycmec/+ElGQ1FFJsSKGqzvFjBU9Z2rN6XQWXoNxzkjlYklbSGrOsNsChKKZuc
	cEgCaURPDS3rqpJyUXRcPFmZsjNI3l6Dxrj3fS+9KWMBRYybZzV8PoHhlj0KGqqyLWN+XnIkG/DGd
	n3xhu2BuinmawYiLzQA4QGmdnvqd6j5D8JqQGUaz/idetn0oCLzIv7v0U+6d5R17I5w+Acn6DbBH/
	/LjfQQRg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xIpAD-0004zf-Kj; Mon, 19 Oct 2026 17:20:37 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xIpA5-007IVS-Jt;
	Mon, 19 Oct 2026 17:20:29 +0200
Message-ID: <5b549646-90c8-4f60-9160-26adf328354d@rbox.co>
Date: Mon, 19 Oct 2026 17:20:28 +0200
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf-next 2/3] bpf, sockmap: Restrict iter-context sockmap
 updates to iter/sockmap
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Lorenz Bauer
 <lmb@cloudflare.com>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co>
 <20261016-sockmap-update-limit-iter-v1-2-23fa946db59e@rbox.co>
 <874ieiey9c.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <874ieiey9c.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/26 13:16, Jakub Sitnicki wrote:
> On Fri, Oct 16, 2026 at 11:09 PM +02, Michal Luczaj wrote:
>> @@ -10341,7 +10342,12 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
>>  	 */
>>  	switch (type) {
>>  	case BPF_PROG_TYPE_TRACING:
>> -		if (eatype == BPF_TRACE_ITER)
>> +		/* iter/sockmap only; type check rejects a freplace of any
>> +		 * iterator's bpf_iter_sockmap() subprog.
>> +		 */
>> +		if (eatype == BPF_TRACE_ITER &&
>> +		    env->prog->type == BPF_PROG_TYPE_TRACING &&
>> +		    !strcmp(afname + strlen(BPF_ITER_FUNC_PREFIX), "sockmap"))
>>  			return true;
>>  		break;
>>  	case BPF_PROG_TYPE_SOCK_OPS:
> 
> Explicit bailout when prog->type == BPF_PROG_TYPE_EXT might be more
> self-explanatory.

I just though that such explicit allow-criteria approach is safer than a
deny-criteria (should other special prog types come along). But I agree
that would be more self-explanatory.
