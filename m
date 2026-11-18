Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038497;
	b=YgVBkseEl79wGYORWP5VVxInV8OqZhjAO/Z0irvdtcVttqNzH6vozwFaPvOX0pC9E+r/
	 8fLAGSL/N3oH0V5uc4RwUmC/+ILQGMqSXBwgYSuqMxTWXVM+N+l+PhBKt4ey0ybsVwN63
	 TDdQv3hmW45wlGRxaKZ0eMGj7h2ahr7dQ1e+j4pGBLLNtSWM2d+L2jT0DikbwqbHgk0po
	 AWJ7jZ6Jl1MPWCDFnrJnUjN8O3oMlaQYFWLgtvjANLvvut9ol1nQ93h0gaj3z1jVFko1l
	 ZXJCIy4WzwQ6hr6nfDnIvZWro1PyjS3DyZWTbZQpVwCuNhY19tssmGvEzDdQCltn5wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038497;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=FmazbUcyJv2DZJt0DwoZZdCNAhZOwPEZbzF3LjOaQzI=;
	b=UMZFuthe3EhZzfZUZElsckpd2GRfcpEEtTtPPUt7wQ865T/PpK54K2Ik+1QucthW72CS
	 nQkVACd4wZTS2jHNISN2/BWmCgSAJ2+snOODUk5t5U4HA+U1a6dMVIZjeJmeaPiE7pji8
	 +3FsKnyeT5WeAdNLQkUuqa2JnjvG62GV+R/LK1uNqe8ZYk6jc0keiOTahuEOPDYW8sNuK
	 1UKTi7VJxGUxdJLdf63STcQp8wXa3PXX+raN4JJJ7wO8PV54+bDYWe4oJXv/9A3Y95M++
	 wPfqQerPmkAI3MWUYeZnbZrFr1Pt/3bckkNRDjotPxrKDAPVTAkXisYCjaX0c1q4yfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gAcAFoHd;
	arc=none smtp.remote-ip=95.215.58.93
Received: from mta1.migadu.com (out-93.mta1.migadu.com [95.215.58.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE61606A320
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 21:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAE61606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gAcAFoHd
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lDmX3HacvpZlC7SbFW4I0h+2lCXa1G37/dwBApAQGSk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795038494; v=1; x=1795643294;
 b=gAcAFoHdp4xk5/UlomDuBIX+nOan9LWgGTV/QicK5nTZcCBJIUnIIk5mn+rMltwXiNK/kKJ0
 N68YbYbkWak8XoX971oKCogU2xsRET2RVj1Kpba8KErsFafajb+5CX1WDbLU02vZgZ16xyxaALi
 o16SO3chHuUqcVOL+JIJ4e3c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 79200d32be978053;
	Wed, 18 Nov 2026 21:48:14 +0000
X-Mizu-Trace-ID: 79200d32be978053
X-Migadu-Flow: FLOW_OUT
Message-ID: <dfba2231-4cf4-4bb2-90b9-6261b7567895@linux.dev>
Date: Wed, 18 Nov 2026 14:48:10 -0700
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
Subject: Re: [PATCH bpf-next v1 0/4] libbpf: Support kernel-side kfunc flavors
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
 <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
 <08d6be6e9e0dcf6570ecd83671e9dbe63a417607.camel@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <08d6be6e9e0dcf6570ecd83671e9dbe63a417607.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-11-18 2:42 p.m., Eduard Zingerman wrote:
> On Wed, 2026-11-18 at 14:12 -0700, Eduard Zingerman wrote:
>> On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:
> 
> ...
> 
>>> resolve_btfids fails the build if two of bpf_foo and its flavors have
>>> compatible prototypes, unless both have foo's exact prototype
>>> (aliases), so the fallback finds at most one match.  This ensures at
>>
>> Why is an exception for kfuncs with identical prototypes necessary?
> 
> Ok, my helpful assistant points out the following use case:
> 
> On kernel side:
> 
>    __bpf_kfunc bool foo(struct task_struct *p, u64 flags);
>    __bpf_kfunc bool foo___v2(struct task_struct *p, u64 flags);
> 
> 
> On BPF side:
> 
> 
>    extern bool foo(struct task_struct *p, u64 flags) __ksym;
>    extern bool foo___v2___compat(struct task_struct *p, u64 flags) __ksym;
> 
>    /* Resolves to the kernel's foo(). */
>    foo(p, 0);
> 
>    /* libbpf strips ___compat; resolves to the kernel's foo___v2().
>     * workaround used before this series.
>     */
>    foo___v2___compat(p, 0);
> 
> New mechanics adds an obligation on the kernel side to maintain that
> foo and foo___v2___compat are semantically identical, despite being
> physically different functions. (Does it?)

Yes. I just replied with exactly same example (it's used in sched-ext).

> 
> Would it be possible to use some kind of annotation, e.g.:
> - __alias(foo___v2) (an ELF symbol alias), or
> - __kfunc_alias(foo___v2)
>    (resolving to some sort of btf_decl_tag for resolve_btfids to act upon).
> And avoid allowing functions with compatible prototypes w/o exceptions.
> 
> ?

My intuition is that it's possible, but it'd be more complicated.
The question is why? libbpf side might become marginally simpler, but
we'd add complexity on the kernel side, no?

