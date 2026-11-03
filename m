Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710624;
	b=LA3/kh4ZJ016KlhmNwLTvJBjQEidl2ZkgNQ1Obrfh4Bfgtw//m5p1QhHF6V39uoib0JA
	 hYPugDi4jHIklau1dmkgOyDqf/MbpFXFplFNa0Qb8xmFe/36ikkI4am4JvcB/aqZTSm6L
	 r9VYW2DNQ5doXjLE1k2D++6GiLiSC9o5aWMf24tWBYZSUiyyJFK3mJyZXWrZK0qLtF0Of
	 Y+u1YaV6bhA+Xo2v6dvk/Y1Kt+Ht002/jfvNnn/j3WJpUM3yGzCcrsPL3FJREeL1pfep5
	 iSX1sMWN5Qm0dH7eJhCULc0Uwzsaun8J55dbS/zNGZoED48yx5Afr/qCOreYCi6muVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710624;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=4o4omHn1+u1f0FmmaUR31SphcVstuiJ16MNLe/HqgJ8=;
	b=cWSy95YijqqVWN1+xiAGYIVAGqCqNDfR5Xa6q7L9jOzN32oKPtjdAAA/RpBTaWIYQlZL
	 J3a5hk0FSfZ5d3ANIwbUtK7coi6fCDQnIQGNr3dN8p/udrrSmdk+qSMREOoJmu/M1huCb
	 ZZRssT2+v0+pYltgNyxHXNMfubNBnY6P+cWX2T5vUHNMoCibBNVTf1ixJtQvO/iouUPsf
	 IDHhctDG/p12e7HjNcpQ7D68HVxWw/pjbSRbrK0JWJ1E6dlLkwvZXF3eP3AvOlmfv+EtS
	 SBMvJ5WkmMcXAvOnQze6/CXsWXWWfUTdSEPGoWUr4V2kXGI2wDiNZU6+C8NHxIX+/TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Qlr8EB8A;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D2606A327;
	Tue,  3 Nov 2026 12:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B6D2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Qlr8EB8A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4o4omHn1+u1f0FmmaUR31SphcVstuiJ16MNLe/HqgJ8=; b=Qlr8EB8AkKEq6Ek3iNaxf3v5nd
	ctQLK1Om5pyYTOKGiZeuJh1jn6iK3E/oRVe+whovci3iLhuUHodsNDjSXDOn5KjCYdjRQ9psy56rS
	IyU2frzRCB6pwoEsif4O87h6GZpeqbk7HxZfOopwimGD6ZRdFMfbx3gjp5fLF7RTYGQlQynwz4U5A
	YwNnk7Kox+jQnDZmW2XsHQwBj/QLG6iJpw/uEyit1xdIpnEKutsOj20rGn7T0UHBrfgXPAG/rdtf/
	EQYcoMDqdLkfzvbYDX96SrxD+JGjAuW+2U/WfYC5dcRYHyZA2/2sKTxkD4mmTEw3kPi0VcnDxQyHz
	4zczb8ig==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xOE4T-0001HR-1e;
	Tue, 03 Nov 2026 13:57:01 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xOE4T-0005Pu-0k;
	Tue, 03 Nov 2026 13:57:01 +0100
Message-ID: <61ad5448-4501-45b5-ae4c-512e3f7c4d4d@iogearbox.net>
Date: Tue, 3 Nov 2026 13:57:00 +0100
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
Subject: Re: [PATCH bpf-next v2 14/20] bpf, arm64: Shorten the tail call
 sequence
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261103122733.1383002-1-daniel@iogearbox.net>
 <20261103122733.1383002-15-daniel@iogearbox.net>
 <sashiko-outbox-195256@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <sashiko-outbox-195256@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

On 11/3/26 1:36 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] bpf, arm64: multi-line comment style violation in emit_bpf_tail_call()
> --
> 
> commit 4fbf9f6098933836065a7c888c2383cfd6d009d7
> Author: Daniel Borkmann <daniel@iogearbox.net>
> 
> bpf, arm64: Shorten the tail call sequence
> 
> This commit shortens the arm64 BPF tail call sequence by six instructions by
> using immediate offset forms for struct member accesses and tail call count
> comparison, along with an extended and scaled register offset load for the
> program array lookup.
> 
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index a327c90fe2c78..bc1ec8b179b2e 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -905,13 +905,19 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>>   	__le32 *branch2 = NULL;
>>   	__le32 *branch3 = NULL;
>>   
>> -	/* if (index >= array->map.max_entries)
>> +	/* The struct offsets fit the immediate forms, the count fits cmp */
>> +	BUILD_BUG_ON(offsetof(struct bpf_array, map.max_entries) % 4 ||
>> +		     offsetof(struct bpf_array, map.max_entries) > 0xfff * 4);
>> +	BUILD_BUG_ON(offsetof(struct bpf_array, ptrs) > 0xfff);
>> +	BUILD_BUG_ON(offsetof(struct bpf_prog, bpf_func) % 8 ||
>> +		     offsetof(struct bpf_prog, bpf_func) > 0xfff * 8);
>> +	BUILD_BUG_ON(MAX_TAIL_CALL_CNT > 0xfff);
>> +
>> +	/* if ((u32)index >= array->map.max_entries)
>>   	 *     goto out;
>>   	 */
> 
> [Severity: Low]
> This isn't a bug, but in emit_bpf_tail_call() in arch/arm64/net/bpf_jit_comp.c,
> should the modified multi-line comment place the opening /* on its own line
> to follow the BPF coding style?

Hm, yeap, preexisting but could have been converted along the way. If v3 is
needed I'll fold it in.

> 	/*
> 	 * if ((u32)index >= array->map.max_entries)
> 	 *     goto out;
> 	 */
> 

