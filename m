Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996574;
	b=Vm4qVcK+0r2pZo6C5XPCWcnHyE6AMUPgIF7PkokXRKaj6zaZShyEEQPI8hU9eGOzg1Oo
	 28mjQZ8lzNWSVkxfYwgA7S0FsCzdheuw2rd58aC4BIHAEpYe0FCXAjaBhiUP9ryQZGQCH
	 JDENnL9a2j1ofYXwJDnPuBLd0Dbw/m38WBKNaILKLHmtrREWGmlAnRe3NKAJIXQh/xv8a
	 obK1pBQVsJB6AXwx9mH5CvQByVj3mDRjzy0IkZWf+QAmoCwumBJeLEgQNXruAsfsRyeXu
	 p1izJvUVsMuunIAgSK0zX6zQ0zhjzmu6URTMJxZzzbdVZ6kkR89+e2tVVkve0hoFRsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996574;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Y0lcaYt+bmFvr8dyls95K52B7B9OJsMZVI4Tj+lox64=;
	b=QADbzQhfg7r9NEkeCwVmO5Mnr5D4N0RJapoRwJCO1GlZC/MjKEp9gxSC/sW9Z7AljKb9
	 /TfCAxxj1Q1TiyZArldi9av7UjafvlavAebvkzcH3CE8aM2k7q8VdYj2ug3sfTbdGEVho
	 zJIHnx0b9Rct1FiYyHcJgFURyK1Uc9OF+RCTgmhpt9Xis5AqP4ilGBtf1d03JEtHM5zh7
	 tVGZa3ebNXmKI0npelMEBMI8jpHxKLVvzzbf2lBV4T/qrEuVJLOMpyE1NI4E8mFcFas9y
	 KoiSfxqhfVUF6jbBQLym81/bp/ZdcU0DJxhDpnYRQM6F0bOjLEokGfts7BRAzEqWdyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Dd+LHoKp;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52582606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 10:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52582606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Dd+LHoKp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Y0lcaYt+bmFvr8dyls95K52B7B9OJsMZVI4Tj+lox64=;
	b=Dd+LHoKpdLuVsKDEpVeFVvW7zeV1kuIWImd5g/S4e1loNTFJS6qYR2RDAg7y8h
	JMDLkKmJNZXbpp106mzXfLgaZt79/GUx4qnNobdSDExa2sUfp4U8oXYcTpzwPdt0
	ycDjHwjynhhnNXdKsr+01I5EsKloTy4KCdH5+gOFoR+84=
Message-ID: <a689d5fb-6e33-4b04-a84b-318d3f483be9@163.com>
Date: Wed, 18 Nov 2026 18:09:23 +0800
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
Subject: Re: [PATCH bpf-next v3 5/6] bpf: Check async callback value
 membership in the setter
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261111024333.228633-1-luyun_611@163.com>
 <20261111024333.228633-6-luyun_611@163.com>
 <sashiko-outbox-208308@kernel.org>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <sashiko-outbox-208308@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vy9Tef1qDujzIw--.24292S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF13ArWDKr1ktr4kWF4Durg_yoW5tr4UpF
	Z5XFyakr4vqa9Fvw4xZa18CFyFv395J39xG3Z8KFyrZrZ5Wr97Kryxuay29rZ8Zr48JF45
	Zryjg3ya9w48Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR8b1nUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BSNXGr9eVRsrgAA3R


在 2026/11/11 12:43, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] bpf: missing map usercnt check in __bpf_async_set_callback()
> --
>
> commit a30152ffd79aa0871058c367266aaec41f12d33b
> Author: Yun Lu <luyun@kylinos.cn>
>
> bpf: Check async callback value membership in the setter
>
> This commit checks map element membership in __bpf_async_set_callback() so
> that timers and workqueues initialized on deleted map elements cannot have a
> callback installed and started.
>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 716be7a852b58..9fa75bcd5e77f 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1552,11 +1552,25 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
>>   				    struct bpf_prog *prog)
>>   {
>>   	struct bpf_async_cb *cb;
>> +	struct bpf_map *map;
>>   
>>   	cb = READ_ONCE(async->cb);
>>   	if (!cb)
>>   		return -EINVAL;
>>   
>> +	/*
>> +	 * The prog can still hold a value of an element that was deleted from the map.
>> +	 * bpf_async_cancel_and_free() is done with it and nothing stops a new callback
>> +	 * when the element is freed. cb is published at this point: either the lookup
>> +	 * doesn't find the element or bpf_async_cancel_and_free() finds cb.
>> +	 * Nothing runs without callback_fn. An idle cb stays in the element until the
>> +	 * element is reused or freed.
>> +	 */
>> +	smp_mb();
>> +	map = READ_ONCE(cb->map);
>> +	if (!map || !bpf_map_value_is_linked(map, cb->value))
>> +		return -ENOENT;
>> +
>>   	return bpf_async_update_prog_callback(cb, prog, callback_fn);
>>   }
> [Severity: High]
> Does __bpf_async_set_callback() also need to check atomic64_read(&map->usercnt)
> and return -EPERM when it is zero?
>
> Because __bpf_async_init() leaves an idle cb attached to an unlinked element
> in a non-preallocated hash or rhash map's bpf_mem_alloc cache while
> map->usercnt > 0, a subsequent bpf_map_put_uref() only walks linked elements
> in htab_free_malloced_internal_structs() / rhtab_map_free_internal_structs()
> and never clears that unlinked element's cb.
>
> If a loaded BPF program then recycles that element back into the map via
> bpf_map_update_elem() after map->usercnt has reached 0, copy_map_value()
> preserves the timer/wq field and bpf_map_value_is_linked() succeeds here.
> Installing cb->prog after map_release_uref() has already run pins the BPF
> program and map in a permanent reference cycle, or allows a callback on an
> inner map to race with non-synchronous cancellation in htab_map_free() /
> rhtab_map_free() and use the freed map and element after they are kfreed.
Thanks for catching this. An idle callback on an unlinked element can 
survive the last
user-reference cleanup and be reused when the element is inserted again. 
In next
version(v4) the shared timer/wq setter will return -EPERM for zero 
usercnt before
taking a program reference. Init stays as is.

I'll put a full barrier between the membership lookup and the usercnt 
read. In a reduced
LKMM model, a read barrier still allows the setter to see the insertion 
and the old count
while cleanup misses the entry. The full barrier excludes that result in 
the model.

With the same wq regression binary, the setter returns -EPERM on v4
and 0 on v3.

---
Thanks,
Yun Lu

