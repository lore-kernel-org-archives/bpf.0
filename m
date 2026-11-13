Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609382;
	b=ZRHUkTb5vg/v/sifb/3kuOwGqek/N+2U381X99BFsrhW8Rf69iJMsma96+OFUWmNlWls
	 n1Gij+6EymdH/4wePd+7F6tEE2xIi8SulpSIsq8W6AD7dAEaA/1ueezIQISxMnIrG6ZNV
	 wsWI1QqJT/RtKIFKCqTfdEhK35zukuwEE+ZqVeVd+0waf7FkBucKaUnPgQgyRcRGs2XzZ
	 rlMTxWkrXclxsFFuxFBqezuX4vmSxKvZlMZKyOTtjiPCZN69Rsma10EYECBnpZooaUNYi
	 3573A8CsaUChW3pY2lhxHT3qTwubTmKyp9314Bnl36nSf80u2q7S9Gc8WNEMWU42KsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609382;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Tm0KsbHdwGJF54Zx8hQsqG6F8oKBBxs/HZqcH7Y8YjI=;
	b=BugD7rJtLXbgAyi8XzE3lojzSmwXk/2sq/xJxExAidN1BByA78przPtC3+BHNN4Qv+Je
	 +Y3SEGRnhl1kLoUlwMWjpQOVZz2c+mxThXS3al0Y0uHPvbHQTRBNUL5zCXrVEBDmwl1hv
	 dDzLVmcZv0ym5cKpi+BX//LNhBNyg12EHH7+kxq/WLCdqNIaF5/gtOJzzYYJyJW5Z4oT8
	 Ir8RpirgyG5X/PutGPnjEE8Y9BOnMkNTE3b6oz9DltuPMznPocfEzhxrVVDCje9xxnElD
	 a5r4Naq0o+3O8GPYOzlF0ezs6PnbTkON2Q2q0KZEE4/an9B9UdDqKBAB0E0+u6c2aDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nLoEHnEq;
	arc=none smtp.remote-ip=95.215.58.151
Received: from mta1.migadu.com (out-151.mta1.migadu.com [95.215.58.151])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351DD606A323
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 22:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 351DD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nLoEHnEq
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TtBRXW6QA+XpUjRfc2qsO4A+37Kv5TpP9BUsEKKizFQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794609370; v=1; x=1795214170;
 b=nLoEHnEq1ZQpjZzdWvaZtZme0132ShAMTCjauvoSbqTA6PsII5ve4EpcSu6HR9+7dBd2lWrE
 s6D26Efm5liWkQy9KCBW1jMgEhSdXgMNSRvodyKj95Ucclpp66VuwNcfrg/jz8k7wLhAmYWV1QS
 JDJuAjRrNzexoRuWeBYCRihQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 752cf6fae846f8b5;
	Fri, 13 Nov 2026 22:36:10 +0000
X-Mizu-Trace-ID: 752cf6fae846f8b5
X-Migadu-Flow: FLOW_OUT
Message-ID: <55b6a4f6-46bf-4edd-9da3-e9cfd48e8a5c@linux.dev>
Date: Fri, 13 Nov 2026 14:36:03 -0800
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
Subject: Re: [RFC PATCH 1/2] percpu: do not put btf_type_tag on per-cpu
 variable declarations
To: Chris Down <chris@chrisdown.name>
Cc: dennis@kernel.org, tj@kernel.org, cl@gentwo.org, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, acme@kernel.org,
 yonghong.song@linux.dev, eddyz87@gmail.com, martin.lau@linux.dev,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, llvm@lists.linux.dev
References: <20261110012235.1024461-1-vineet.gupta@linux.dev>
 <20261110012235.1024461-2-vineet.gupta@linux.dev>
 <20261113115808.87a52a7c74e293ce@chrisdown.name>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20261113115808.87a52a7c74e293ce@chrisdown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 11:58 AM, Chris Down wrote:
> Hi Vineet,
>
> Vineet Gupta <vineet.gupta@linux.dev> writes:
>> The message is confusing: this is a declaration, not a definition. But
>> the compiler is right to object to a type tag on the aggregate, and the
>> issue is fundamental: every variant of an aggregate shares one DIE, so
>> there is nowhere to put it. clang drops it silently and GCC warns.
> Not a big deal, but the definition in GCC's message is the definition of
> struct cpuinfo_x86, not of cpu_info. It's saying the attribute is being
> applied to the struct type after the struct was already defined, which is
> accurate. So maybe just drop that first sentence?

Oops, thanks for catching that. I misread which definition it meant. 
Dropping the first sentence in v2.

> I've tested this with clang 23 and GCC 16. With clang, the same 280 types
> and 3360 bytes of BTF go away. Likewise, with GCC, the per-cpu
> declarations no longer warn, and the non-enclosed address space errors
> are gone.

Thanks for verifying, with both the compilers.

> Once the commit message nits are fixed, please feel free to add:
>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Tested-by: Chris Down <chris@chrisdown.name>

Awesome, I'll add these in v2

Thx,
-Vineet
