Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB61D63F3
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043778; cv=none; b=MDjd98+TbU7uk66ycLboe6RdLBV1nPZz1LtVYR9+X46f335GZ3gzf1qtpfIckOMqUA0tZEMrhLEXvA7+wtQhof7ns4sKlg7sKMLEhwy0/Rx/Sece+fEYIUhTjKAF0IBwmoMlmo2o/KWgCjAUI+Ta9hYSFF1evEUFTJh5AOXf59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043778; c=relaxed/simple;
	bh=OXnfBWnmFDrF1Bk67Z1blWrxbnT2h5ada/743qnmKKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVp60O9VG4A/k/03R4r1FBGwqE45cfxDYCYojHnCpwi+m6vrOF2VSFX8DWq8tJ5hrh8zeqLaKyY8meMBlpkassPrtIUI7McfIZV3Gk0toXf99xLsP6qZqr1dB8s4JHJFH2tzzkNQbiZuw73og5Opv5/WptCKEAiv8Ut1e3KT5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrapI+Hj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrapI+Hj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891f625344so66803145e9.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777043775; x=1777648575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqOptOH+OhIZdF5MOvkLZbFhX6aGFU7m7RaWsvTJRFU=;
        b=SrapI+HjFOMfd74i3e9HtwO0IRw6uYApSMJSG0OnxrMLnkVgNv0xoMB7oebDdUA1Hl
         3b7dd3MOHYygS+gCeNhIYCuWSno35nI271oWwslIWCp0uTTo8ozvbdwXUfVx31WMbIzW
         1Su4Sjk/XOpRyY+3qxnWk2QkAAQxNvwaPAw6V0vxpSpuqGPc72P6R+nBfMbCLI1ikweh
         G9hVgeevX9gBjsBn7cTtIg4N8BVHTVrIHingyWVvCkIdnQmIm+oSeQeYXPzoPbGuaRJn
         E5j+c6pkpqq48ubbobkxErSrZLL1v51+g70n5qtOxEXGzYKQDNOFsq34JYfp7SjyeDcu
         dVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777043775; x=1777648575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqOptOH+OhIZdF5MOvkLZbFhX6aGFU7m7RaWsvTJRFU=;
        b=Fgis7uoturFIFod6A9i0M4eS6SJPG6JS4HeciaM8z56238iqQ/4Q5Q6jmR7lvARZyH
         jwT7kJo8WDQ9Gclfg6+6DiVBCUhJzsXOQwL0z2AnKEInnBavDpJogDbKr65mcRaun8pN
         6kUmWyrFuNhKdg/WFGB2jmrJbYPnFHw0R3JTDbEDGLNQzqprXLfAUjE6HrKtYup+4sRz
         0n0GrYUNbxNwD0eye72Q0CGrfmQG6xGc0U11jDleXKZGwQ0LOmpF6iH8tTSuOXsvg9UN
         fEbpofy7wHmTHj1blpAXsKRLrHOpU2sqztd9Cg5b3UQHlpBtnan/tAvULYd5axNXxu0h
         2ZjA==
X-Forwarded-Encrypted: i=1; AFNElJ9lJJ2fULzh/sQ/qfoRyHFxaxBZ8piwOMLK7sHkT/T0TDygPhMOhkfiCnqzrtxFRS5iqoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsMQmdlm+ZkifJcyXdWmO9VdngryXgIo2M6PHaR2viSsaqJsFB
	rCbcT+jiKe1UmOybvf4szjXXw9zA7IxQ6OgKpKut6mJiw1pzvdRM+vaU
X-Gm-Gg: AeBDiev9cv1xuFZnEjvDs/OtMb7fCZUOgTy+lvrOWZaPfuMVWKYbNaxvR0349tVqQwk
	ls9oLc5Ixqa293lHLXacQpe6atOHzgpQofQOyNpIJrQIv0yMIWGqm7QDOpmBs7/HZYHbl3+ngMo
	DWJmFXmiPJOrXJm9YahMEWFmWEbyMnlDMOQSV8cIZQoHolEI9SOFl/AnBTUgdBfRSuFGED0rViF
	HGklF3oSG4UGOBfgv3IR9sISRzbkOpLlVhElggsFDvCjSn7Yyf+ywxEzZKRJC0g5wRWo31qDwnw
	GbSuh8t2CgrW345SW11XUJ9GcomyjTI0Vr7JvtbJ8qHV57ulaGmtQR9zHbTT2DOPAvWWcB1Tjt1
	NL3rRP7ghnguNcz94/lZQ9f2fX14qDjk0QnCvaKiwZW481YAHdrq2F8tITVlJteRNaQF5zUKgNR
	q5uwrqlGpj9bxLjflSI7f08GP4XkJhqJ61JQ1En2vTZwsYQbfwgePg2QXIrlzIgWC/jl5slzcsW
	3wB1plNWV1SYwVYyt1Bxg==
X-Received: by 2002:a05:600c:870e:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-488fb84ffb8mr434645425e9.0.1777043774724;
        Fri, 24 Apr 2026 08:16:14 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48919f54572sm158110215e9.26.2026.04.24.08.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 08:16:14 -0700 (PDT)
Message-ID: <1a4fc6da-97c3-4c3f-a120-1f68e39cc6d4@gmail.com>
Date: Fri, 24 Apr 2026 16:16:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 06/18] bpf: Implement
 bpf_each_rhash_elem() using walk API
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-6-3b3675da1f6e@meta.com>
 <DHSEH6V3WK9P.AI7TUT5Y4UQX@etsalapatis.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DHSEH6V3WK9P.AI7TUT5Y4UQX@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/14/26 12:02 AM, Emil Tsalapatis wrote:
> On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> rhashtable walk API takes spin_lock(&ht->lock) in start/stop,
>> making it unsafe in NMI and hard IRQ contexts. Guard with
>> !in_task() rather than open-coding raw RCU
>> iteration that would need to handle resize races manually.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/hashtab.c | 35 ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 7eee450a321e..e79c194e2779 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -3013,7 +3013,40 @@ static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_f
>>   static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
>>   				void *callback_ctx, u64 flags)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhashtable_iter iter;
>> +	struct rhtab_elem *elem;
>> +	int num_elems = 0;
>> +	u64 ret = 0;
>> +
>> +	if (flags != 0)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * The rhashtable walk API uses spin_lock(&ht->lock) in rhashtable_walk_start/stop,
>> +	 * which is not safe in NMI or soft/hard IRQ context.
>> +	 */
>> +	if (!in_task())
>> +		return -EOPNOTSUPP;
> 
> Use in_nmi()/in_hardirq()/in_softirq() instead?
> 
>> +
>> +	rhashtable_walk_enter(&rhtab->ht, &iter);
>> +	rhashtable_walk_start(&iter);
>> +
>> +	for (elem = rhtab_iter_next(&iter); elem;
>> +	     elem = rhtab_iter_next(&iter)) {
>> +		num_elems++;
>> +		ret = callback_fn((u64)(long)map,
>> +				  (u64)(long)elem->data,
>> +				  (u64)(long)rhtab_elem_value(elem, map->key_size),
>> +				  (u64)(long)callback_ctx, 0);
> 
> AFAICT this callback is impossible to be sleepable which is why we're
> able to call it under RCU, can we note this here in a comment?
> 

Thanks for raising this concern, it looks like the callback can be
sleepable, but the same issue can be seen in existing htab.

>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	rhashtable_walk_stop(&iter);
>> +	rhashtable_walk_exit(&iter);
>> +
>> +	return num_elems;
>>   }
>>   
>>   static u64 rhtab_map_mem_usage(const struct bpf_map *map)
> 

