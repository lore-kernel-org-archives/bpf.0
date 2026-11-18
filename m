Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996294;
	b=F+r41kwOMFaB0Dfcxl40LuH3AGLCjvwfou355IaZqRyFGXCaF2sSqdZ2RjGiooNblkcz
	 G98omqSgqHI2/qNcNFa2e9luIGYp7QR8xj31il80CuO++zAiiLaxi9gUg2wK5f/GF9UUp
	 jOj6U4Un6OKg6lyfJAUvMQTkBPmM/sXoZtI2JzMp9dTRdgLjrSKPUFHh8PCPAXAFAJdd5
	 wKtuhdMFw2uNYnxAyZvATuiNqjNysvh7QWu9iDb9FPjv0aG+3lXRvaRr6aHgCr0jMwBE5
	 T0Vc5+pb+nSPvykn49kw0CEgVOZSfOzF6K3rVHxTx7UZcVRoEthU4s8Pt+q4bJnnWUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996294;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=yKD4ZsjMIh2eJ5Wohhn7XOIuF7ywO7iVvU1PMgUsysU=;
	b=JjIbGx8ewlEkqYFhI6t7CWvuSldWx2xAvYY10jz726JLB/MeDATTFxYuphy4xLINEyVM
	 C+JydbtgiLpJdGw8jP58B8SyQ8xli5O6Vk32/UWLtJ6BavM9litS1D4Wf5W0I4tf3QZJx
	 7R8GEh/TAP/5doeTo7qEoItmZSQR7hbTOvZ9bEZrfQ1qp3Y2aTDXT3mNmnremWI9PcQDN
	 F01rOjqVyv+KPV/ybqAaXHv/u22X3yhS5Cf7hoH4t3QRcBV0mfNWNIx+4B96rRtwwEpW+
	 FgYkO1Hi5o69jr+6knNFy/DN8FPnf/4tQal6CGuLXtR8uZKOgAbPziZzkC3aSAnoEgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NV8bvp8V;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3563606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 10:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3563606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NV8bvp8V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=yKD4ZsjMIh2eJ5Wohhn7XOIuF7ywO7iVvU1PMgUsysU=;
	b=NV8bvp8VNTLDuWWgQaNN3T0SBLgTp3w7kU6gI/LJlvRVhTeJwnupRXz+hBNwIG
	D6jg+2xfGQc/8Le2Q7CjLLr1QXjs+rNj5WOT1z5hiGSov7bxAl+IlkxxBPT7iOO4
	mdskbFJ1AwivBXir/DtsrZHrzPP8vhTDuS1fCsosUC1jM=
Message-ID: <84286263-5111-4358-8b90-9e9d86d846cb@163.com>
Date: Wed, 18 Nov 2026 18:04:33 +0800
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
Subject: Re: [PATCH bpf-next v3 4/6] bpf: Invalidate async callbacks before
 detaching them
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261111024333.228633-1-luyun_611@163.com>
 <20261111024333.228633-5-luyun_611@163.com>
 <sashiko-outbox-208275@kernel.org>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <sashiko-outbox-208275@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn16IxeP1qZmXgIQ--.10193S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF17AF1DXr48tr1DJF1UKFg_yoW5Zw4kpr
	sxtFW0kr4DJFZYvw4kXa1rC3W8WryfW3ZxCr90gay0yrZ5Wrn7Kr1kWFy29F9xZr4kAr4U
	Xr4jqa93ZryUCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRo89_UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6xJEE2r9eDIR5gAA3E


在 2026/11/11 12:22, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] bpf: stale async->cb pointer when losing xchg() race in
>    bpf_async_cancel_and_free()
> --
>
> commit 686504449c958e635d8414edba153676c8d63adc
> Author: Yun Lu <luyun@kylinos.cn>
>
> bpf: Invalidate async callbacks before detaching them
>
> This commit changes bpf_async_cancel_and_free() to clear cb->map with xchg()
> under RCU before clearing async->cb, so that a callback object is invalidated
> before it is detached from the map value slot.
>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index a08b2af56ee64..716be7a852b58 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1747,15 +1747,18 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
>>   {
>>   	struct bpf_async_cb *cb;
>>   
>> -	if (!READ_ONCE(async->cb))
>> +	/* Another canceller can release the map-owned cb reference. */
>> +	guard(rcu)();
>> +	/* Order unlink before reading async->cb, including an empty slot. */
>> +	smp_mb();
>> +	/* Acquire any invalidation published before the slot was cleared. */
>> +	cb = smp_load_acquire(&async->cb);
>> +	/* Only the first invalidator detaches cb and drops the map's reference. */
>> +	if (!cb || !xchg(&cb->map, NULL))
>>   		return;
>>   
>> -	cb = xchg(&async->cb, NULL);
>> -	if (!cb)
>> -		return;
>> +	WRITE_ONCE(async->cb, NULL);
> [Severity: Medium]
> Can a losing canceller return from bpf_async_cancel_and_free() while
> async->cb is still non-NULL?
>
> Before this patch, xchg(&async->cb, NULL) guaranteed that async->cb was
> NULL whenever bpf_async_cancel_and_free() returned.  With the split between
> xchg(&cb->map, NULL) and WRITE_ONCE(async->cb, NULL), a second canceller
> can observe the invalidated cb and return early before the slot is cleared:
>
> CPU0                              CPU1
> array_map_update_elem()           array_map_update_elem()
>    bpf_obj_cancel_fields()           copy_map_value()
>      bpf_async_cancel_and_free()     bpf_obj_cancel_fields()
>        cb = smp_load_acquire(...)      bpf_async_cancel_and_free()
>        xchg(&cb->map, NULL)              cb = smp_load_acquire(...)
>                                          !xchg(&cb->map, NULL)
>                                          return;
>                                    bpf_timer_init()
>                                      __bpf_async_init()
>                                        READ_ONCE(async->cb) != NULL
>                                        return -EBUSY;  <-- spurious failure
>        WRITE_ONCE(async->cb, NULL)
>
> The same race occurs on a single CPU if an interrupt or NMI BPF program
> updates the element and calls bpf_timer_init() or bpf_wq_init() while the
> interrupted task is between xchg(&cb->map, NULL) and
> WRITE_ONCE(async->cb, NULL), or when check_and_cancel_fields() races with
> map_release_uref() before recycling a hash map element.
>
> Having the losing canceller also clear the slot (for example via
> cmpxchg(&async->cb, cb, NULL)) before returning would preserve the
> guarantee that async->cb is NULL on return without overwriting a newly
> published callback.
Init can return -EBUSY until the first invalidator finishes clearing the 
slot. If a second
canceller clears it with cmpxchg(), init can publish a replacement 
before the first
invalidator's pending WRITE_ONCE() clears the slot again.

---

Thanks,

Yun Lu

