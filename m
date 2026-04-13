Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69466313E21
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109412; cv=none; b=Fbg16nyRwtFmF2pZl/1Q+gePStWiKPGGC2lwPL01V4MEK6T24hcm5plWgUMGZM40hGmzVfdjU5Br6TbyQkptjD2ZPMSGIwaBBGSrsXGw5Evp9uvhhlYD50wdrql3Pb7tJ/rTIUbGQTbnvOx8jtLuBqhhI8jfujLY3v2ZRxbnMoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109412; c=relaxed/simple;
	bh=3kiLo8azqTKO2kEHHx8Xx7tbnKa//lIReqCqbAHDoNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5jEbXqaW5TnEcZWsc1NOfm/p5ZRxG/Yzi8X+Z0bry7RocqH5BvkrMUto1f0gQr2wA6F47BopzwN1V0XfDzNGcIcH0FKH8suIY7Ms8z+ONklNvP+GyDQQgPCBe8CzWHNsnQo8Lyca2rTi/pYjUvrgSRpdURmUkOKCDwBF4emvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1G2xkZ7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1G2xkZ7"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d73422431so1306866f8f.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776109410; x=1776714210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q26qowQQQeXeJH053L0d1vLtzTp11trjRoi+Kxejymo=;
        b=a1G2xkZ7fh5hNrUpeP3ke4qdiEf7kgbuE6FufWYfUxfSnUEAq6/RPgilnyyCs04Hzj
         XDKdcbVTjL+TnY2FzvPc5u7KmPZZMxbNbWabZCXSWKNZ7DhwyP+uXQ6AMvoNY7Jr7JS/
         I6GmwwbVP4l73mBN8Lk/SqOty/N7SF9HV9avND47i0d1bcGDsCF+vIak+7IsnD5+zrP1
         47emIFnEaNFRcWBCmjhpow4DQnWO9AFRXBIQYu+t1jyWl2ClFBsBmKr0ns0YlnmbrqIr
         ADDcWmn39WJoNOkneMfIfLpxfLeSIFmGUPl3V8mpSUjdwrR729y4ETBuU/IwA7dFU1rT
         +EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776109410; x=1776714210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q26qowQQQeXeJH053L0d1vLtzTp11trjRoi+Kxejymo=;
        b=qoXRZwIWYud0aoJJ4XlG8Bi5frDIKerKVfCrh/Q7kv5IbxaOLmrQJIbWbQlMi+PZC3
         gKHOpgUQnzuy4gkwvH9t7uqlJ8oXJXhcMnicp9eV5QyFkvNpdOkMWtn15TmKpWBXFuXc
         li9Odn5R7DxxH20TVfIma+irCk+zzCo9W0SpTToydvDRynvA1ye7gfKEGS4oeC2dO8Fx
         V9YwsZIFdwwmgIj4fmKEjdPdGnenEusYtDHpgMd17Gc/3+U/iU6CK8TNEW3FTg8NV5Zq
         IdhRl83yrLIVco4QaSPdMlF0rzsgdOiOpTStkyHTGLKzvPLpChjhOWPQdjMIjuz0ahR4
         36SA==
X-Gm-Message-State: AOJu0YzkAdXPTYjRl5cktK2RtTcWsaXyIsCRpeLWCav3njCmAiZPxZ2Q
	qOHVVT6VQoj0gezIaCaWXTS9UVWKep6boeDu10TNoEzyAUGgti3lQw7y
X-Gm-Gg: AeBDies3P7pqWrLa2GpGsBHBPGxLSVVKxqpBh+PvMRRsNlPuxLqsll0icXIAVS8qdaA
	rjRnmL9xgY48gUO14ppyYGeoixJhCcP6aJmuou6c9u9VnTj2NdHkueNF6mmSui8u3StoU/616+2
	hB8Dnbwk/knfbyasV4DoW/GjG0EPaleY+7V5SHr9o3W9C3kboJFDFmo3e5fq8RQqFoxq1By3c5A
	es+++IgC7Y1Do7MvRxq7sKo5KoQukOTNXTM4HJ5YHnHJroWz4bzew5kCH51xr1zRAK2Sp8l3vcd
	hsy0/TM6F4W8XCvKtPmtQSwI9rTHTiGUBatHS2aHwr7eX+oZop7YD95jLM0NyG60nq6cHzgnlss
	Lpk8bi1RbG7vC2aIIj/69DUJTuQZM8gTD7LTiwYqA61IuGcafoJEH7GKpKjcWWUsFSYXS6ISMIw
	fKkBjwl9FOb9Fh3rHJmBtoGVxGTODx8NZ5QqdbU+ctyJrWbSxMdk1PGalIyjRxdi59WbXt5tKD7
	ZdNRXy6FdQ=
X-Received: by 2002:a05:6000:2481:b0:439:b1c3:84c8 with SMTP id ffacd0b85a97d-43d642ae5a6mr20914058f8f.21.1776109409466;
        Mon, 13 Apr 2026 12:43:29 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:699e:f085:b19f:def1? ([2a02:8109:a307:d900:699e:f085:b19f:def1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5061fsm36519428f8f.30.2026.04.13.12.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 12:43:29 -0700 (PDT)
Message-ID: <06191c11-6342-40e2-8a3b-a3f32589e3a3@gmail.com>
Date: Mon, 13 Apr 2026 20:43:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 03/18] bpf: Implement lookup, delete,
 update for resizable hashtab
To: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@meta.com>,
 Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Mykyta Yatsenko
 <yatsenko@meta.com>, Anton Protopopov <a.s.protopopov@gmail.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-3-3b3675da1f6e@meta.com>
 <CAADnVQJ-rW+MkrrtaAoVvExNYX9rEc+=zSw+phzCgv9QtaAX8w@mail.gmail.com>
 <a103c612-2639-4578-8d8b-48ac72e96c63@gmail.com>
 <CAADnVQKK8KvPAtO5f5ndmBXOWxYbGMrnUiCap9tuf6HNCG1akQ@mail.gmail.com>
 <707a2aad-7617-49d9-8bdc-8f0ee22e7fe7@iogearbox.net>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <707a2aad-7617-49d9-8bdc-8f0ee22e7fe7@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/13/26 5:27 PM, Daniel Borkmann wrote:
> On 4/13/26 6:24 PM, Alexei Starovoitov wrote:
>> On Mon, Apr 13, 2026 at 3:52 AM Mykyta Yatsenko
>> <mykyta.yatsenko5@gmail.com> wrote:
>>> On 4/13/26 12:10 AM, Alexei Starovoitov wrote:
>>>> On Wed, Apr 8, 2026 at 8:10 AM Mykyta Yatsenko
>>>> <mykyta.yatsenko5@gmail.com> wrote:
>>>>>
>>>>>
>>>>> +static void *rhtab_lookup_elem(struct bpf_map *map, void *key)
>>>>> +{
>>>>> +       struct bpf_rhtab *rhtab = container_of(map, struct 
>>>>> bpf_rhtab, map);
>>>>> +       /* Using constant zeroed params to force rhashtable use 
>>>>> inlined hashfunc */
>>>>> +       static const struct rhashtable_params params = { 0 };
>>>>> +
>>>>> +       return rhashtable_lookup_likely(&rhtab->ht, key, params);
>>>>
>>>> How does the asm look like?
>>>
>>> You can see how asm looks like below. An interesting thing is that gcc
>>> inlines jhash2, but not clang, which costs a lot of performance.
>>>
>>> gcc:
>>> lookup 20.675M ± 0.090M events/sec (approximated from 32 samples of 
>>> ~48ms)
>>>
>>> clang:
>>> cpu00: lookup 15.882M ± 0.530M events/sec (approximated from 32 samples
>>> of ~62ms)
>>>
>>> I think inlining is also consistent for htab and rhtab (either both
>>> inline or both do not inline).
>>
>> Try other hashes. I recall somebody from isovalent experimented
>> replacing jhash with xxhash and/or siphash in hash map and had nice
>> improvements for certain key sizes.
> 
> [ +Anton ]
> 
> page 26+: https://bpfconf.ebpf.io/bpfconf2023/bpfconf2023_material/ 
> anton-protopopov-lsf-mm-bpf-2023.pdf

Thanks for sharing that presentation, looking at the graphs on page 27, 
jhash2 is actually a better choice for the key size below 10 bytes 
(correct me if I'm wrong). And for rhashtable it's going to make even 
bigger difference, because jhash2 is inlined, because it's used by 
default by rhashtable, while other hash fns we'll have to provide via 
function pointer -> no inlining, which is a huge difference (see above).
Looking at the profiling data, hash fn (when inlined) does not look like 
a bottleneck memcmp is, though.
Anyways, I'll run benchmarks with other hash functions.
