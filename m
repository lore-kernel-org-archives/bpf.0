Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670737;
	b=kBd/cDlEuMuTLU09cG3FGH7rkK75wPErQMiDThoAlH5aPl5lA3a3z70D8upkppJ3LVLX
	 mfmDxPtm2VuKdLpa21RP6Ac3FiKdLEE9bhXlAMeJLn/PAVAG//U2rzm5x8aUMXbTW+dxy
	 4ial6hfVh/GKn+UqvMabUeMnbVDG2wfJt1y09HTbO7ybl2bFmYJyQnDQeArg7jzXcWYBS
	 RfuCfrcIhuzr4i0PNYFm7xdeAn+cMDqO1yOD3QVYn7fgzsX8UygBgPfLzs0k7e8mqNsvH
	 l18FTEHw1DiT6n6CWE4adT9yrs4VgqJFvXTjN7lrO0dQYf86Yrb+goWIGg4Cae6Z0SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670737;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=RtyNW0gmNKu+F4S4geYgGRfWCseBxV4f/FbulQHc5qY=;
	b=5UxPMc3VCulHIWfu89GXj1ind/nXQu79RhOisdzd+IoPbaYyRnnh0ZUteo14RPiyZLwL
	 udvQ4uVc4xg5Z1JfbLPPKzSTo7ABE+v7LlyZY5eX/VzNo2k51JmlfuEKwwA+8s4VwyaqI
	 VrXb8lgSZew8wegwUUertlQjHvBfsQxfx8rBEyNovGGsqBQHmXpth6wcxx/6nruxXFvL9
	 SKRkwvjQs8kBYO7F9wZnwbE6vleqgVQsbql9cBGJE5cWs/XqGg505jNJOBxKDaMwYecXY
	 Zo52+E0rFZBgEz5qibk2Inds1el18APJ7kU7tlX2G98kLkOXLXW/YtpFenuWZZkQkNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C08606A324;
	Tue,  3 Nov 2026 01:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17C08606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxUNFOPulqFs0bAA--.15379S3;
	Tue, 03 Nov 2026 09:52:14 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxBc1MPulq3QkyAA--.9889S2;
	Tue, 03 Nov 2026 09:52:12 +0800 (CST)
Subject: Re: [PATCH v1] mm/slub: Genericize x86-specific cmpxchg16b comment
To: Harry Yoo <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261102082730.12430-1-yangtiezhu@loongson.cn>
 <auihvtpGJPDbb4Hz@thinkstation>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <5ce58389-db68-54f2-51fb-0d43b0e0cb2d@loongson.cn>
Date: Tue, 3 Nov 2026 09:52:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <auihvtpGJPDbb4Hz@thinkstation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxBc1MPulq3QkyAA--.9889S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar13WFyktF43uFyDCF13WrX_yoW8Gr18pa
	yktFW8X398Xr1a9ws7Ca17Ww1fXa4UKr97Cw15G348Jr9xKr15GFy0yrWfWayrXryS9342
	kas2qFW3Zw4UXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

On 2026/11/2 下午10:49, Harry Yoo wrote:
> On Mon, Nov 02, 2026 at 04:27:30PM +0800, Tiezhu Yang wrote:
>> The kmalloc_nolock() infrastructure relies on slab caches with double-word
>> atomic cmpxchg capabilities (__CMPXCHG_DOUBLE). The current inline comment
>> in __kmalloc_nolock_noprof() uses 'cmpxchg16b' as the prerequisite hardware
>> capability.

...

>> diff --git a/mm/slub.c b/mm/slub.c
>> index 45e077c7526c..216bc6b5d776 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -5589,8 +5589,8 @@ static void *__kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_f
>>   	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
>>   		/*
>>   		 * kmalloc_nolock() is not supported on architectures that
>> -		 * don't implement cmpxchg16b and thus need slab_lock()
>> -		 * which could be preempted by a nmi.
>> +		 * don't implement 128-bit atomic cmpxchg and thus need
>> +		 * slab_lock() which could be preempted by a nmi.
> 
> maybe "double-width atomic cmpxchg" is more accurate considering
> e.g.) x86-32 implements cmpxchg8b?

OK. Using "double-width atomic cmpxchg" is much more accurate
as it perfectly covers both 32-bit and 64-bit platforms, and
aligns well with the __CMPXCHG_DOUBLE flag.

I will send out v2 with this update later if no more comments.

Thanks,
Tiezhu

