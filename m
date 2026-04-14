Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046F37CD4D
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154274; cv=none; b=t8OCb8mTzHhTg8DCz5+V8g1gauuaLsatdy4SqtnrePpzFgJ153nfvl20BOxoVt43WcX3oRY9//9UEFfWR1APPPahbMngh7PRW2vFKFvPbYSYVkiDbghGwwrl77T2r5O/8tcKNbnJH92mEQwBomykWLrXvrMIZI7CuBLPSO1x/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154274; c=relaxed/simple;
	bh=dgMMq5FLYWz/MwANDRCkyZiuwiXJZRzLh48bbljR9QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXNPvorhAXWJi3HfoI6ga57Eri6JY6im+Ls4mVglzqY54KOWcKsgJ/iY/gOqSVxf6LN0Pw9dBvjPH+ypkCOWvzeM9qbqHdHhm2zglP7msALEFH0FcDjeZEOyQ0+Ati41BpEObdwjB0VgJCuEAgHfPNtv4cRAIdjpG/f0S8waQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbGc/At3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbGc/At3"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9825ba7f9dso770490966b.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 01:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776154271; x=1776759071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQO3IUJOkrwlh8NnYkOvYQDEDu5GlYmjX95kpgm7ACU=;
        b=rbGc/At3DeXJr2LddEyA3WrvRaFXycZ5t1X3C+wfw/xFoux11nRqBzqvt0vgyrVw+e
         FKpeQ7pUClNVCJBX/whLhs2cP5ZvR4RCPjRobsYAj+G0gcxIAtSJAHcJJiE78Ht5ejv9
         YF9a+vPO6przfjgZc6oB3TP9g3ZukN+XeONjIRNOAkhT858IgeeijO8z2Hg2WdNn51cA
         dHQm7Q6qOQPbcSZpafyg+Y5+a4CKctdmj7vAsKJ56+SSOFmo7S8K7M/qfWhzRHC32B6m
         aD2GcRYdxpyZ+5YmuQWxfE/3coe/CaWlWmW1SgXfPecUWCcoQ0tBcas8g9JYW5V4hHSe
         TiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776154271; x=1776759071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQO3IUJOkrwlh8NnYkOvYQDEDu5GlYmjX95kpgm7ACU=;
        b=OblwHfnfzWBjtNehF4ooHe1mH/tBaUkmu/u7D1mh6aKQyXw1GjOGMSdQtIx+dhEf2z
         9rfDrH+MX/nyAOnYlw4M0DMsT6ckRwgcpvq2UtecA3eIBFUEfd8U++WScNQIrIfgigP3
         1mf5GkR4/qHV1YYmBr9ae/IzEd+iCXF7DwBDqKqyl3u9sgg1C54P29b6Hpphlk1L5aru
         2ZG8MsabCNWcvPuyAyKwiQXHVktkGrSB3qeqVpAKALvSEvtQUlh9A9/68cRrTJgN9JT0
         oqFtYR/mWytR/I+Kn3N9MVefJbrjJWgsjl3gZ4mGcmoZ0b0QJn7sJWVG3ZIztdbmspT5
         9L1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+dwTDEsM7Qk1yId+cvLEvNX4/Nbyx7hCAVAYKAKrLK9/l93ULssIES8yhXjGFd1nONkdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbyzHMyAWzx1Kvins9/3xAHX863QH+AspkclqwFLFIN2ZS8IOC
	DJ0AHZ8W3v0IF6KV5MXdcwWiD5eDZdh9rlmcdGOt+gu0dtpT/ipWvb7K
X-Gm-Gg: AeBDiesItk/R0JSKBTgGZkxEJK1ucZQ3xhU8wNrzqmiwgton7I+E2+94kyL0DgpoijL
	uNKt2zQ4CUZ4oXvGhVS148qGfsoBI4tVdOWhQXA2h3BpcWins1M6faeBXaHjptdT2NYAdphelmt
	pZe2E9YGrCiR0td2GR5R09ytpbU7V8FkQXsM2fWjuEe4/jvbe4VXPqOYjwRtfrKDwLCVX6MVayi
	dsAehKBzj86K+m6QRLd9Jr3d0fzSb/UKUcpr+y4ZJyh39tKbRlt4yMVFxzO1F3+Ov6FGXItqiCn
	VhEJjnMzESq5NRxpb9uOAbK9zXOJtioWHucJhqMGwk89z4e9K2vs9zwwtqy4x4KlT2k46MnRzWc
	tLF8NJlgKXV4EfSM/E9lQRLMfFHiS9UgBTIsOFVxoVeDZHVNE6AhiwDY+1mw8xABlvIhHwvJvDa
	lCDmvlZ0jOYA6WvAW/808U0i1G/wieTSd82lQVki2kjg4Y7wRXGdgheoi3vonAhfJ6Ca3FjzAm/
	e9E9gsj
X-Received: by 2002:a17:907:6093:b0:b9b:171e:bae9 with SMTP id a640c23a62f3a-b9d76ec80b9mr776513766b.24.1776154270658;
        Tue, 14 Apr 2026 01:11:10 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:2caa:994a:1164:dca? ([2a02:8109:a307:d900:2caa:994a:1164:dca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c544asm377134266b.33.2026.04.14.01.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 01:11:10 -0700 (PDT)
Message-ID: <93e6f4b9-b360-4dbf-b229-24d3524e30da@gmail.com>
Date: Tue, 14 Apr 2026 09:11:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 05/18] bpf: Implement get_next_key and
 free_internal_structs for resizable hashtab
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-5-3b3675da1f6e@meta.com>
 <DHSE3ICYF886.1JAWWOKCDODDF@etsalapatis.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DHSE3ICYF886.1JAWWOKCDODDF@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/13/26 11:44 PM, Emil Tsalapatis wrote:
> On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Implement rhtab_map_get_next_key() and rhtab_map_free_internal_structs()
>> of the BPF resizable hashtable. Both are only called from syscall, so
>> it's safe to use rhashtable walk API that uses spinlocks internally.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/hashtab.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 77 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index ea7314cc3703..7eee450a321e 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -2921,13 +2921,89 @@ static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>>   	return insn - insn_buf;
>>   }
>>   
>> +/* Helper to get next element, handling -EAGAIN during resize */
>> +static struct rhtab_elem *rhtab_iter_next(struct rhashtable_iter *iter)
>> +{
>> +	struct rhtab_elem *elem;
>> +
>> +	while ((elem = rhashtable_walk_next(iter))) {
>> +		if (IS_ERR(elem)) {
>> +			if (PTR_ERR(elem) == -EAGAIN)
>> +				continue;
>> +			return NULL;
>> +		}
>> +		return elem;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>>   static void rhtab_map_free_internal_structs(struct bpf_map *map)
>>   {
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhashtable_iter iter;
>> +	struct rhtab_elem *elem;
>> +
>> +	if (!bpf_map_has_internal_structs(map))
>> +		return;
>> +
>> +	/*
>> +	 * An element can be processed twice if rhashtable resized concurrently.
>> +	 * Special structs freeing handles duplicate cancel_and_free.
>> +	 */
>> +	rhashtable_walk_enter(&rhtab->ht, &iter);
>> +	rhashtable_walk_start(&iter);
>> +
>> +	for (elem = rhtab_iter_next(&iter); elem; elem = rhtab_iter_next(&iter))
>> +		bpf_map_free_internal_structs(map, rhtab_elem_value(elem, map->key_size));
>> +
>> +	rhashtable_walk_stop(&iter);
>> +	rhashtable_walk_exit(&iter);
>>   }
>>   
>>   static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhashtable_iter iter;
>> +	struct rhtab_elem *elem;
>> +	bool key_found;
>> +	int ret = -ENOENT;
>> +
>> +	/*
>> +	 * Hold RCU across enter_from + walk_start to prevent the
>> +	 * element cached by enter_from from being freed before
>> +	 * walk_start re-acquires RCU.
>> +	 */
>> +	guard(rcu)();
>> +	rhashtable_walk_enter_from(&rhtab->ht, &iter, key, rhtab->params);
>> +	key_found = key && iter.p;
>> +	rhashtable_walk_start(&iter);
>> +
>> +	elem = rhtab_iter_next(&iter);
>> +	if (elem) {
>> +		memcpy(next_key, elem->data, map->key_size);
>> +		ret = 0;
>> +	}
>> +
>> +	rhashtable_walk_stop(&iter);
>> +	rhashtable_walk_exit(&iter);
>> +
>> +	if (ret == 0 || key_found)
>> +		return ret;
>> +
>> +	/* Key was not found restart from the beginning */
>> +	rhashtable_walk_enter(&rhtab->ht, &iter);
>> +	rhashtable_walk_start(&iter);
>> +
>> +	elem = rhtab_iter_next(&iter);
>> +	if (elem) {
>> +		memcpy(next_key, elem->data, map->key_size);
>> +		ret = 0;
>> +	}
>> +
>> +	rhashtable_walk_stop(&iter);
>> +	rhashtable_walk_exit(&iter);
> Nit: The two attempts are partly identical, can you try to
> roll them together and use a goto to retry? Or do you think
> this will be too messy?
> 

It felt nicer just to write this code sequentially without any gotos or 
loops. No strong opinion here.

> Otherwise:
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
>> +	return ret;
>>   }
>>   
>>   static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_file *m)
> 

