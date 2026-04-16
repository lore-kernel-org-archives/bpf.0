Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7E19E98D
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357061; cv=none; b=t1duKDifG4nVjfg9rRL9oy+fd9xpZexmkTWr+XPYU7K3yCu4px3CqPdz4ioFd3bOKiY/rQCnNMJ3bQDop6wKXToHdvl81FvGogiA6RvuXyCSbdqehbCO8v50UPM3L67F49xUl3o+OgrimoMC9PuWsLY7Ad3mq71nhp2DSMOPftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357061; c=relaxed/simple;
	bh=ENyAsrQJvZjtpMHcZswI9VmcBOq3LV2ND9Z2QGd+eWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsJ6KlShyVhifinnHBzmpjKgbcfXQhqgz6qpLChAZZCsdy5my6H0lsgqjgBTpqbt6ZYhim9Hx/kYFYPGcvnohFxw6Vh6g90gflKskbNh+esXL+DiSlZUkmZrnlYRL/oAF9VhHm3mNrDXtZcBJvSB0gDuUIRLrw3gBbdDW/WqU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2RsY8VT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2RsY8VT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso99330165e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 09:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357058; x=1776961858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqNhMV3HyPvDMPeq6YZBtjpLi8MPodQzMfsjjdgpfZ0=;
        b=N2RsY8VTkkxWPCcV4qG5DlXn0abqmFjOgcyaSuklxzEKcICiN0GKca9uFAWVeaY1kX
         X4fdLIvIr5P05BPDoU1yMeBzkTEfYbGzy4GH3t3C7EPWAyp4IyHuXerwq3bhGbxZUuZQ
         bhPibuB6R1XSK4AAg29yglysxosB9mN5TNm6GK9A+pFHTr7KKCaGO6VopvkbhUo4S7RF
         luDMkexqa/856h0NeQ+rmt8Q1Fk7SEE1dpLZZ5wL/hSssvZsnmAKo8Ck/0Ah+0BU83Qp
         5RjYL9/zlgA53q5wXKtTS5IkgC+YgKuKcfBb0yHdhtFmCsi2Ujl2AYeKA/5XvmOcN/s2
         Nf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357058; x=1776961858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqNhMV3HyPvDMPeq6YZBtjpLi8MPodQzMfsjjdgpfZ0=;
        b=P01o9hC5K4e5jBe6rG9Kxn6L7bl5iXqRdcF5AmcykOaLnFEQqgrIDvdbr2hg3KBbPE
         1K7MCXndTyxcV5fuzbSzIdlOVh/LnWnsvMpnEQpKRSyo/WVF0WCa7SM+e+3RpOuhV0Oi
         oKFj8deQr6lb7Wn/j1bITtKdKAWWfKQ8z2RTMN76RTJ9rsxrRQmZTqXROmDWpY/rUf7I
         xLmnvj3FBMNkfTinI/xTPAdBqyDpDzH+7uFfl27fNzy1+gGk2AuEugQ7FaGiIHqxrpE2
         /S7GLCS0Tk0mDtO68Dr/z8c/Og0j7yNaIxYS6/q2TZA/KeODtaw+umhd4cSvk+LnGRd9
         JzzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ruEn5ju2hiZ11YIGdrsm0Vwz4t4CupaK4ZHgPAI+9Q5Lp6oAmxfe33nfuqZh6UJboUwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnmZ5nb4Q1Pyh/99ECoim7H0xSVPcto4y2zCK0DZD0g90r+qfq
	CN2X1S3d+gGOVgR5AVuHgM4DsNT1UioMWD4TLqUsT3tZuK5osBr8skXX
X-Gm-Gg: AeBDiet379HJKkszmA7mwB8+npeQJBKeyfb3N6k82A9QKVxrFdxLwG1zswLRQiHzFO3
	9xKGl5Gr3JeoHyJYvRgf7ysq7Jwa6Vy7cvroULZFmtG2FahlTidFT4ux3s0KBkAqFUlamcS2VBJ
	uB2ji5JoKG6Ak/acXrWfRsIpCSd8PJ5Iv5ivejpZGIpxm1+batXehN3DLIxOaQ/38Sg3Kpp0/lE
	Duglfn2pEWX+wCv0Z9FRnpWtwZfhTTSBHn4DFr5SJlFYcUjDJEANiXy8CjPtGkxyKxBf6Rk4ZAp
	VBZaFZyCcGMO5aBnpTFFt+Y8qRxEJVkbXlAJaTjz34BwjQn8EXQr/ebIy3aXZz7Yn8x4IwFfbOh
	E3+zzxrfUuwaFJdxC89SVTT1lqxsOH2gmK/RJJd2WkPalYU+McoYKJ3TKLH7WG200El2ZOgYWc5
	1zeIAjC0umtZdltKBPM0JZnvJcIJUP4yHh/zOkNALzXGE1juK+4+8CG/L31U0=
X-Received: by 2002:a05:600c:c0da:b0:485:4bd1:4c64 with SMTP id 5b1f17b1804b1-488d68a10e2mr319825755e9.31.1776357058246;
        Thu, 16 Apr 2026 09:30:58 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5895:d15:8047:4abc? ([2620:10d:c092:500::4:7fe8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5854163sm66463385e9.13.2026.04.16.09.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 09:30:57 -0700 (PDT)
Message-ID: <bb363b68-0336-4682-b2c3-551610c97b40@gmail.com>
Date: Thu, 16 Apr 2026 17:30:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>,
 Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
 <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
 <aeBxQn8ATaNuEF4X@gondor.apana.org.au> <DHUN1UJ0DLBC.3UC7SXBAV2FOW@gmail.com>
 <96b6f76e-1dc9-4d54-9f92-8586796ef607@gmail.com>
 <CAADnVQJuOP5zViH-hiie2M5wVNFrjD=WddBoAT2NkeNb08Roeg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQJuOP5zViH-hiie2M5wVNFrjD=WddBoAT2NkeNb08Roeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/16/26 4:36 PM, Alexei Starovoitov wrote:
> On Thu, Apr 16, 2026 at 8:10 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>>
>>
>> On 4/16/26 3:11 PM, Alexei Starovoitov wrote:
>>> On Wed Apr 15, 2026 at 10:18 PM PDT, Herbert Xu wrote:
>>>> On Tue, Apr 14, 2026 at 10:13:21PM -0700, Alexei Starovoitov wrote:
>>>>>
>>>>> No need for such guarantees. It's best-effort only.
>>>>> If the walk skips entries it's fine.
>>>>> As long as it terminates eventually it's good.
>>>>
>>>> There is no guarantee that this walk will terminate (unless you
>>>> finish it in one go).  In a pathological scenario, after each
>>>> walk attempt, the hash table could be rehashed such that the
>>>> entry that you're resuming from gets moved back to bucket 0.
>>>>
>>>> More practically, the walk is essentially useless if you encounter
>>>> a rehash/resize event before calling rhashtable_walk_enter_from,
>>>> because half of the hash table could be missed because the entry
>>>> got moved near the end.
>>>>
>>>> I think a better interface is to detect such a rehash/resize event
>>>> and then fail the rhashtable_walk_enter_from call.
>>>
>>> that's certainly a cleaner interface. the user can retry
>>> if resize occurs.
>>>
>> There is a problem though is the get_next_key interface:
>>
>> int get_next_key(struct bpf_map *map, void *key, void *next_key)
>>
>> we cant store any metadata (table address) to check if rehash took
>> place. Am I missing any way out of it?
> 
> Why store anything?
> rhashtable_walk_start_check() already returns -EAGAIN if resize
> happened. Propagate it as error from get_next_key() ?

Do we care if a resize happened between two separate get_next_key()?

  get_next_key(a) → b
                    ← rehash happens here
  get_next_key(b) → c

The second call has no way to know that a rehash occurred. Because each 
call to get_next_key() initializes/destroys a new walker and only active 
walker can detect rehash took place.



