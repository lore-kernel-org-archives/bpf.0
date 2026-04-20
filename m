Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041D2E093A
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700235; cv=none; b=Med5UO9lYPu3VEnhfEHZKFEo1B9gWF76Ss9i6IKbWlGkHFUe7FKmtqDJvyqLRd/0hVbFaVpUg6FFrzNA/deyCw4MJaskgpWZs7EbxxQjyxFFWPAZPdXrDVROya2ZC9ryo1ZPdr2a0lNKDiRByITpYK4SbLeHsZ/jU3SOfcFzlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700235; c=relaxed/simple;
	bh=tn3rz9lPVhGbJPsGYirTGiwnaPSgwJWFlJwPBL9i9EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSU/haqHxwwC2EJOAKBFjFGtX0iQhFIORQSpAvkJoPfY6bdPsd/fAtL6+diBOFUSzy8CHoOUpbBkXQP/kC6WLCWJVOS94U2Z/kE9+WhU6E9bEGJ3ABQVricTBcJU0z7RyFmB9auk36w2UsUVZ+8xg83+gPy5XZB5uFIgHKPMmTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQjFFpSl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQjFFpSl"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso37145305e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776700232; x=1777305032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIczP1pTvCUiAQHsSXPKgNppAd63WdxGB6ogL8fjEb4=;
        b=cQjFFpSl0VBFflk7jII7tfMxzQrYh8OTCf5dxXE6FfsgQ5kmeMaL71UG0K8g5B3mQ6
         f2gts0fnWbesHjiEK5TrS1+Aa7zo8HI87G9PC3/ozy5/Z7QsjMC8hSkmZKTOB2ECOVJH
         EAVBHvvo6qMchxDg6qut3W0fxeQr+3PTBVwr9ZCTVBXmqvyxzATaJQBJWRHhQtJEivix
         kukKdUQU3dvZTrRjHiTxDdbWfHnj7Bzrf+0CajyMIrWPwLPc3926ZFogLlneTjL81ZJx
         sUS+qGvjwSyHz4NEuWdCLG1FZjNZeyhiaroJeyM07lVlSrw25ctEAefIIpNbwYCHJFQc
         e4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776700232; x=1777305032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIczP1pTvCUiAQHsSXPKgNppAd63WdxGB6ogL8fjEb4=;
        b=H08WybUYGUu1a9z7C4GisGLk4TMvYWVhihZsWsJ+PsyguHaOXg1duJLDD5fWU0/u/l
         RY8GZ02j7hFY6ji1J4hZ6ge4ZcVzw56aGqaiAUKk7vNBRZQgtQcZPl/8aG4ijBH5DQWY
         Q9rotmy5lpBqRQo5h0RKiqaPoWBlOBo7jm5WooeaQvo7agqU3gDTC08V+bSkAZBAecY2
         HAMn8K81xw3Ky0w6BU9NsAGAvI3siNdG7n1OPleojRJ+3+rwd8pLGgysTwEhYDLK+hE3
         19+fgf1bfTMzhvQaP0KeFGtj/Rm8gVktEUt8561IKX1YF32PkeV51K/Wl21OWhwxw3Aw
         +hbg==
X-Gm-Message-State: AOJu0Yw0/x4icZQmRbB830PzW6I5urgjAEFSUjMCuBe8flVaC1Ncjhjn
	4pBDd02UW5WyA5Djdj3g3654xwwK9qTB0TZRqe9IgYDPDE8LOgvOukU2
X-Gm-Gg: AeBDiesfnDcF0iDCP4qFI9GdzqCl8SJHDJJMOUo1mgiLl5gCTolBIwoJxj38NILnPlk
	w1PQBPYRrLiuvpSBWUjEYrCruNjG1pufvDwQH8eyHpPt+5Em5c3VXcU6eRqko0gUIA+8OHTNbSl
	eqPigatmE/N1cUqrYgnKd+gUDCUWWkmdLRFjC6S2Nt1bmPEw4I0Rx6pqmK5EHpULNcBeP34RB6r
	uSzfGadIPr3PEBgPzqo+4ougRir3iHHJ3JYCV6FqpTL8pVCFuNL+jFh82rvZDhuJq+2qVOxOXU9
	p4jTSWBDN99mHTvkZTVi9WgqS1MZgE51MilAlczO8cDP/k27oGXDSUHiDLd2mAcHHf9F+DPzfKU
	OClktcC6SVuWNhFt3u9H8P3zwNjZZ20ww4xJKUT9SXcvFvjbtIhnZKitJBWxU5y23TruX3midjq
	TDA4WZilp4YpoHJxT+lAjJzVeuLCsN2cS9SjDnSYjn+hEWieX7+K/XVlNOZk1V/QkV1wiVwA==
X-Received: by 2002:a05:600c:33a4:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-4891abb574amr42348225e9.5.1776700231993;
        Mon, 20 Apr 2026 08:50:31 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5432:2d05:ea5:f7f7? ([2620:10d:c092:500::6:8ffd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cdfcd50sm31159385e9.9.2026.04.20.08.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 08:50:31 -0700 (PDT)
Message-ID: <68e0580a-4002-4b9c-a003-7cf85560d791@gmail.com>
Date: Mon, 20 Apr 2026 16:50:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
 <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
 <aeBxQn8ATaNuEF4X@gondor.apana.org.au> <DHUN1UJ0DLBC.3UC7SXBAV2FOW@gmail.com>
 <96b6f76e-1dc9-4d54-9f92-8586796ef607@gmail.com>
 <aeHZJUw-ZRA3ZWVE@gondor.apana.org.au>
 <4c0e73e1-43c3-48a3-ab89-239fed7e6c23@gmail.com>
 <aeLTlNbM1rH31D4L@gondor.apana.org.au>
 <af4b850f-ac88-4c99-8d66-00e40efbd4d7@gmail.com>
 <DHY3HII4WSJS.Z7A2V8PWG22W@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DHY3HII4WSJS.Z7A2V8PWG22W@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/20/26 4:41 PM, Alexei Starovoitov wrote:
> On Mon Apr 20, 2026 at 4:45 AM PDT, Mykyta Yatsenko wrote:
>>
>>
>> On 4/18/26 1:43 AM, Herbert Xu wrote:
>>> On Fri, Apr 17, 2026 at 04:16:34PM +0100, Mykyta Yatsenko wrote:
>>>>
>>>> Changing interface is practically not possible - this comes from the bpf
>>>> syscall.
>>>> Linked list solution: we probably can't afford it performance-wise, it's not
>>>> worth it to pay for the linked list maintenance in insert/delete operations,
>>>> to make traversals work well.
>>>
>>> What performance penalty? The linked list is just a pair of pointers.
>>>
>>> Memory-wise it'll be two extra pointers per node.
>>>
>>> Cheers,
>>
>> I'm concerned about pointer chasing, when we inserting a new element to
>> the list or removing existing, we'll need to update pointers of the
>> neighboring elements. It'll be nice to measure it, of course, let me try
>> to prototype it.
> 
> hold on. let's not overcomplicate things.
> We only need to notice that resize happened, right?
> In such case just ad generation counter and let resize increment it.
> If it changed in our iterator -> ERESTARTSYS.
> EAGAIN doesn't quite fit, since it implies that immediate operation can be
> retried, while here the iterator need to be destroyed and recreated.

I think that won't work with get_next_key() because we don't know what 
generation previous key was read (in API we just get prev_key and return 
next key).


