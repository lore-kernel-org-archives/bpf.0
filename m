Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760639EF0C
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685567; cv=none; b=f6OYZQ1IBewYVg9YInlM4RIO3kC4iKvvClNvSVxCP3WACxZqTu0XFCALXxlcS5I2E6uP1gGy5hI5K70JAjmBbiDxZhQArCG8nPbpNk6ST8HuG1YmFakQQz3zalTQqoV0cHGR501XgBA5jFJnZvJLIgJzO/THyT4ERKr+F8L2SJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685567; c=relaxed/simple;
	bh=2aoxVm7vLxTDJDHbM7nfjYBGTNnnLxn1yscGhkbQwNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niDCRC3uDlvnwYavCqgo/iZWYGgEVs6rqHO0FQSOltZy9klOtMepYXwXR4G3ESr79/FptfkkB9U6cioKuadQo4ewq5mEgvIrJiQS9qLlbSxK9RrMWL5UXGzPIgchCnTP4uNUJww6sydcr3OpVdwbF58phSPKWlY6uAS1Q9MBaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbgWf+ly; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbgWf+ly"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so2757225e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 04:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776685561; x=1777290361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFvEWrbvc0//GCqTUDgnMwODGe0cE6wGwgL9KvmdxkE=;
        b=WbgWf+ly7K9SBDuIotPzi13IOOaNP465R/ky3FZPYDoniLnt0fakhjWyEn+c8h3qHi
         lRebbGG3ZlXwzJG+1KB7ZGavBTyAtzH+hnoO5tL+IRMDQ9LSxf8Ulp6CMcyNr07jRM7a
         qEVIwAEUEt42JijLDkeBj7osC7mkDLlMqXynpdJKXDdHHv9D7rX9T/ZUR2SvWF00URKS
         YqP+jsaZur32/zbBjOAfBZDSY5FCvJrvPL9jpEiGEhQ5UJ3bU/cdy7Xqcu6l+pwjUGvK
         qyyqCEb7qHBHr9qq5fxwhGUso88jiUym+0OlC0nNRLE+9GX/7n/vOHbPbRodjfSomOGJ
         XEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776685561; x=1777290361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFvEWrbvc0//GCqTUDgnMwODGe0cE6wGwgL9KvmdxkE=;
        b=iWZLc1wKkiRM6R+3MTDEnD+R/WW4zAf3SLKDAj4ApbvTPflUY/iimtx7hlqs0T8Rx3
         VDfEANkiDsJCqVDMKF72Q5Dzrts421EWwcRM0PHAWioSin9dFuasoMaJeLHfMbH99ZE5
         x4rrgLYqd1IKqwAdWqPFKOSN/hegY0Lqsvc6kfBu/IJTK7CFPCOB3feIeFwkRxw6JPgZ
         3Ww1h074GJGjNVhSYsj6KfNG5nB6wCJfNlU1U46fVxtdYgG/qrGWzba7wEMuEU8gcUCd
         U2pXLYGYmPAbxnR3hDt2IeYNWDxq4WKYT+vMYy21Cri1SWLKssPdwilsbl6aDAZoItSb
         jxhg==
X-Forwarded-Encrypted: i=1; AFNElJ+63fVKSU/qjlU+LZkSHt8kMfdewet0QxPRu0H8ZDA/i3Ky7ddRd4wYY5JON2xvADfCOXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mgQ9yuEsbUypeZtAVPxTPyiyPJ35DB6P2cnSC6Qh/mN9FklN
	I9zCqjWHpBUgQ+79YMCPG+TGpslrezlmGSRSxJNH6xcVliOKkxnxEAW3
X-Gm-Gg: AeBDievJ5VPKknYNsLfnFF/32Hyd/nqLx/8pC/RJyLhcPACdn2Au7DD9Ir0v/UbmQQm
	jyUB8KchygEfiz6yUdwCM9GHd5gc0MLH3T/mXL0Qlkuc5qpSMrJk4czYZmpPTm0A6Y9wk0FZKBV
	HXfjmAcjQtAnWs3/ryowX6EPwjX3B2Ow1lxYInykHqENumB9DqnIk8Sh2C+FfmwV7pN80QiiVwc
	JXQFcQHiGBweLJLvYpO6sjjrMW/gqEtis5djlfSuVTNrScaOJHecsAYP+tKprpxOpM1yHq3NygC
	elqJGjmHHSKXFrAkLkt1rlzgLDfTX2hYFCVoxxaI+zjIamf40BJ9WMCpYEsiDxPKFBuKEC64XmB
	nZsRpyFnMySzbK4wNkrXJLl5KcOxrq7ooBT9ePlZJ0dyz3Q/jFk2BtJMj7sbBr6jZeO9cMq70VT
	q9DZApI/iKD/alSZfq6oYDu4E+D67htoMSIS2SSDMtSICFMFIehe8J6d7dnuSmCE0zuGwW
X-Received: by 2002:a05:600c:34ca:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48a07615b87mr20267945e9.8.1776685560593;
        Mon, 20 Apr 2026 04:46:00 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5b5:398f:7272:a46c? ([2620:10d:c092:500::6:c4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1ce408sm259462885e9.14.2026.04.20.04.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 04:45:59 -0700 (PDT)
Message-ID: <af4b850f-ac88-4c99-8d66-00e40efbd4d7@gmail.com>
Date: Mon, 20 Apr 2026 12:45:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <aeLTlNbM1rH31D4L@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/18/26 1:43 AM, Herbert Xu wrote:
> On Fri, Apr 17, 2026 at 04:16:34PM +0100, Mykyta Yatsenko wrote:
>>
>> Changing interface is practically not possible - this comes from the bpf
>> syscall.
>> Linked list solution: we probably can't afford it performance-wise, it's not
>> worth it to pay for the linked list maintenance in insert/delete operations,
>> to make traversals work well.
> 
> What performance penalty? The linked list is just a pair of pointers.
> 
> Memory-wise it'll be two extra pointers per node.
> 
> Cheers,

I'm concerned about pointer chasing, when we inserting a new element to 
the list or removing existing, we'll need to update pointers of the 
neighboring elements. It'll be nice to measure it, of course, let me try 
to prototype it.
