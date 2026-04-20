Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA39351C07
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703061; cv=none; b=t51KlvTUG386idMZNEkMgNFMHfSFR+6b8PY1WxbZjsFFNCV/t0B/68K/HDT0oWGZgxDRxHI2dqZc6nwIrXI1xlO3PV8fHUxjvfedwrPrMmKHfotCBEqYvSZLxpW+MmwbWcH0P3p6e6AIlFpxYUKRUl3rgNZbULrf85sQo1xCt2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703061; c=relaxed/simple;
	bh=U0pPkb+V042ftOFQeZ1VYketskD+hg9UpumQHgAN9Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWV8lkbbNZph1HQZDxDTHj96nDLlSkMOBM8kPHZbh8uZHBrbpqHdwaIYnfU9Xm41JIDdl0JrAq525WNlJD12DwUYgyBVPyx946KMbWdJKmKZC66khr42+a/OfrDXhAdTej5A/ljUvfDmzhPF6Wyd+EiNZCaHMDCC2mdqMtjr1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZH17Sl+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZH17Sl+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso2004724f8f.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776703058; x=1777307858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpu14+FwOLSco0+WafBRBGwHPCgYQx+qtjEGV2+nwDA=;
        b=mZH17Sl+V1zJwUYF9ghaa//DGyQN0bzDG+u9WRrWzdODPHCkMxv2HpMfx1X4EdCa8T
         p+MuW3Hc/AzDVJoHqSaHl6WzACHEEUtJpVNT9zb87WkYdgJHfo9WCS0/RLcWlUPBaNb+
         tUso6qYPJgVOcFhrRQ/jJfmPdpyv5i0TeV9JkfzszSuRMTzV3/F/nyRZ2aG5blMAVZ8F
         iBXJwnmVLNA48+kXQY3MP0UosaL7gh8naO0BeUK05QdFyqSmipdm99935XofwOg9JQAl
         inQI/MJhsxqbPHXFslShuGB+suJOqX+7+AmWAuT7Q9CHoKNiQURAukvHpn3rDp0LYb6J
         4WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776703058; x=1777307858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpu14+FwOLSco0+WafBRBGwHPCgYQx+qtjEGV2+nwDA=;
        b=BSoIK2xwb2KcSzk1Bpxw0KDFffZEI8o142UmyFj0Ny8eFwk4mY/15HiuUqPkKkcy6Q
         MuXCuVoDM2Xrn1sIYJgON/zLt448qjHLYT3FJ0686qlDU7Tu1JsK6/NyIj0YulIVfyDE
         F2xqD1mAS5SR+m0myIAhZ7/Okz57I4lFlXsmvv0QvqRJQIeZKGb21kNHEjaz5X0UKuBQ
         i3SlFta7L3eL24pfs2ZKtklGdS5UkxNnVwHZmJqFQLh3RkXb7LJ3JJuD81Qq4UqUewmC
         CIkKn6cxDck7k48FBXldMcZs9UNWjk8Jra05FsopBdb6ba+l4d/wi0+/EZzXjZ1ulSc/
         PMQg==
X-Forwarded-Encrypted: i=1; AFNElJ/34hVMYyaYbeEzNSwTm+eXMMZ2HPV5P4PwZ5VH+TAVAgwvpXyMLji7EMVifKaqaFdYCrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPONFC9Jy27Cc0M5uXvydDkKYk+Cp/iFqYh3Dgj2rVzg1ZrCl1
	+0sak9sg7M1t/1R+PWpzw0SBUUGttPSGsF1TAdv1jiwxmmUQlCOEHDrQ
X-Gm-Gg: AeBDieurn7vtdQsRRdv5jUeBDlfGbuWR3ypDbd24IvXmNHS8Z+tcD60pffhEVwl4RDh
	r/1Athgu0CvDx2NEGESGfeGG81GQWkjG140sPW41tNCVE8keMyc6uz4ERIFZ1f5b46ehAzJMb5s
	A+zFXSHw/eXb82ZM77+TqyynZWfZPjBkuMUuk6WIwBsBgXsN1ITDKdCwzpVOm1qQwSwwcf/lGO+
	9M7YgUbg5SmGaiwmuVYeKLWht6lskk4TE+qAqfxs1CENQlI52Jl5Xewf9NUOib779TmYA5TFuGe
	7zdCc+Tcl81OJ9Jfy7N5xeDZVrZpAFraTfo/GWkcnBbi58hzps/KeqBtzVFjLeiZBSHK2u59EeR
	8EOCe3J5HmvAL/tWdSIpl2e4CH06ysBuraMowFbR4cXIvz0hIxcqrSFRLdH8Gw4vR/vjbSP4V3T
	TVyGdi6dyRxvI1ryNOUrLF5n3PHa5JujnoBpkJmMb5DolyF+Y8hkkPxLSNg1t1zHr3LgYh6Q==
X-Received: by 2002:a05:600c:3423:b0:488:fd7e:1063 with SMTP id 5b1f17b1804b1-488fd7e1253mr106824685e9.29.1776703057854;
        Mon, 20 Apr 2026 09:37:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5432:2d05:ea5:f7f7? ([2620:10d:c092:500::6:8ffd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4890009e759sm228960045e9.6.2026.04.20.09.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 09:37:37 -0700 (PDT)
Message-ID: <cf77ad2b-6ecb-4a0d-8ae9-75b62e253eb8@gmail.com>
Date: Mon, 20 Apr 2026 17:37:36 +0100
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
 <aeHZJUw-ZRA3ZWVE@gondor.apana.org.au>
 <4c0e73e1-43c3-48a3-ab89-239fed7e6c23@gmail.com>
 <aeLTlNbM1rH31D4L@gondor.apana.org.au>
 <af4b850f-ac88-4c99-8d66-00e40efbd4d7@gmail.com>
 <DHY3HII4WSJS.Z7A2V8PWG22W@gmail.com>
 <68e0580a-4002-4b9c-a003-7cf85560d791@gmail.com>
 <CAADnVQ+_gYx2AiqqtmyXhB8qgioKN3t1H-TgeMMWZzv15Jt14A@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQ+_gYx2AiqqtmyXhB8qgioKN3t1H-TgeMMWZzv15Jt14A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/20/26 5:06 PM, Alexei Starovoitov wrote:
> On Mon, Apr 20, 2026 at 8:50 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>>
>>
>> On 4/20/26 4:41 PM, Alexei Starovoitov wrote:
>>> On Mon Apr 20, 2026 at 4:45 AM PDT, Mykyta Yatsenko wrote:
>>>>
>>>>
>>>> On 4/18/26 1:43 AM, Herbert Xu wrote:
>>>>> On Fri, Apr 17, 2026 at 04:16:34PM +0100, Mykyta Yatsenko wrote:
>>>>>>
>>>>>> Changing interface is practically not possible - this comes from the bpf
>>>>>> syscall.
>>>>>> Linked list solution: we probably can't afford it performance-wise, it's not
>>>>>> worth it to pay for the linked list maintenance in insert/delete operations,
>>>>>> to make traversals work well.
>>>>>
>>>>> What performance penalty? The linked list is just a pair of pointers.
>>>>>
>>>>> Memory-wise it'll be two extra pointers per node.
>>>>>
>>>>> Cheers,
>>>>
>>>> I'm concerned about pointer chasing, when we inserting a new element to
>>>> the list or removing existing, we'll need to update pointers of the
>>>> neighboring elements. It'll be nice to measure it, of course, let me try
>>>> to prototype it.
>>>
>>> hold on. let's not overcomplicate things.
>>> We only need to notice that resize happened, right?
>>> In such case just ad generation counter and let resize increment it.
>>> If it changed in our iterator -> ERESTARTSYS.
>>> EAGAIN doesn't quite fit, since it implies that immediate operation can be
>>> retried, while here the iterator need to be destroyed and recreated.
>>
>> I think that won't work with get_next_key() because we don't know what
>> generation previous key was read (in API we just get prev_key and return
>> next key).
> 
> The first one starts with key==NULL.

If we iterate entire map in one go, we can detect resize, agreed. But if 
user just randomly calls bpf_map_get_next_key(), we cannot really detect 
resizes, because we don't even know when iteration started - it may not 
even be an iteration, but just an odd bpf_map_get_next_key().
I think we can handle resizes next way:
  - map_get_next_key(): leave as is, can't detect resize or even if 
resize matters.
  - map_for_each_callback(), iter_seq_info(): error out if resize takes 
place mid iteration.
  - batch ops: store generation counter in the bpf_attr, so on resuming, 
we can detect if there was resize.


