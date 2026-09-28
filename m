Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60BB3812D2
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620308; cv=none; b=soJNU1Bev5PIPg1dFefeeO+OOIbK2hVAUwxf1obSVKdKVgjCC8t+FDYn1Q/sRU/LDpjJMeR4tYfVRgW89Yp3mQW0pZ8cRT13WOxeXgSKYTFosIx1pbCiXOmt66daEZ6bBAUBYdRVtpP0x7ok/rrMvrNK7n1eI8X+sMIdWE2GW2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620308; c=relaxed/simple;
	bh=dGT6rdAuNcxpO3zZFglGqVdapk6wU4wQNhDh/4tqGYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibIyJyt3WIMSCwJc7vKwWvwtv2mHYwFNL80UujPk1VkfEE5DisBleu+W8FiRZ6P3dlv8dI9yzEgbb9drxAIRO0lNF5gAW0rC9JLshvmeS7+NQvU7R+IxNdjkerAyeAO/92WJmXqOu7ichmfV5J54i8RbRT+gkKPzFBoZDfUzM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfcJyiVd; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfcJyiVd"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885a1480a2so1961713f8f.3
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790620303; x=1791225103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4EEBEDfQuq5YyK606T/DU1oBvG5Jd2rjsRyzMfb5mP0=;
        b=TfcJyiVdiEL4okttXVrBcjUd3+sGfw6DbuaMVrcqbPhDk9skxvUjzK0ROJMExwgTmc
         8J2O2inIxVbkbIoVSYTKJKB1wHKGy/Nwf6ar9K5AXILdXX8fU+H124CouP99w5zDxyGH
         HLkvlsI0Dk7gkxOPJDYGGZhWTQUtqUQ4H+A0CCuKSGSjxbFrDvh0mWAGgtj4jZ4Wq7CU
         IBviJdK5XpPpY/yPeGA651JlPHAfpGMiYUg+ZEi7tPhRwj43frOp5QZgvvsel1Sw3Rng
         Beth/FrZb47oKZouDOsXFBvmeoJ24jYbD/56uSzxRdWeHVXAcjsoaMJjoZzDUQhQvI6j
         ga9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620303; x=1791225103;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4EEBEDfQuq5YyK606T/DU1oBvG5Jd2rjsRyzMfb5mP0=;
        b=ZYbkLblbw0wHgWmqSE5gjZTgaHUtgAB9IEFJX+FsAFRVtbNSeTIc7TDYU+F3WlYRwh
         lgAzvKeMV8zVr+wx9p3bUSXYbudW/Pe46AAgpXgVgRHCPjj+pI/y9gH3jGWGvtB3H1SM
         N9f8sck35+sPh0XHU3i2crgnMTWlBZ2oCpASNSMTV6xO54YL1jdQ0XHhOHS3xqI4vzQr
         GHAx6hgvSl6kfyQz55ipAJbKCl69IAmYdzP0IB2tPibZOZbq/l7VXekVmwvfxcmbSVUT
         YWZDY6XK6H1R0S1oEr1cHiykTfi7B35aYI9RS0HPr3+6xAjc/EmXGq4Qm9vISQ3MXill
         XmhA==
X-Gm-Message-State: AFq9FYLDKjSH/tlj3vU1a0M5M1AF+Jt9cIch+Gsubgo4hC6rlqnC+tQI
	2eh+1F4OVzHQAJh1BnpcCKRdA0Hi4x7lqCJit1GKqhPpwWiPEfX/KTKv
X-Gm-Gg: AYBFou0LFS8NnSpDbvEecy0laoRWtjRzpZf4Sx/fFsuYJ7320pPrPkgcRuR1A9lnndI
	3Z+Ek1pKTGYPd04EV8yW80id0KDGvFdiaVdvxvLSengL2osOsBgm0d7m2EPoWoLi9HDHdAZBeXv
	sVr51M0QVdzZc8AacgDIOOy08QgG0hkDnVBxBpNBWeYcACEoGBX/HaEy4bbqfif88s+a2/xM/YF
	HdkVv6b2R4o//pgmVKi6v2tVo1y5Ekzf/wCWFQaiXuoDrGgGULN5/KEp71M+rH0YRge+aRrnPxI
	Xx0//M3v9OT42FubpxYwdIAMobXa3lTjLS2QD3xEHygB529Utv7FkhdahFlGlOYur9Cz/z3mglR
	ani3EQcUN7UBtB6kxjwtB6nWA89UE/VaVoKfHy616eKJY67xcYPfusa/NhT3lG3uEfEVq5+JO4k
	C+BG5L15E7HeLF8JFI32yhDmTrBJwT5hGUmsbT2U5ARhEtfnof5W3m+zEy6k7+c9cKkWcny62sb
	iRRuwy4Hr6p//QkymPzNI3evlWOKgYLthE=
X-Received: by 2002:a05:6000:25ea:b0:487:c4c:5613 with SMTP id ffacd0b85a97d-488716d09demr25304679f8f.24.1790620302800;
        Mon, 28 Sep 2026 11:31:42 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:e630:49f8:e9c1:1c47? ([2620:10d:c092:500::5:3659])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a3625ccsm31128297f8f.22.2026.09.28.11.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 11:31:42 -0700 (PDT)
Message-ID: <1b41e278-f00a-4e25-a319-ba69186d92c9@gmail.com>
Date: Mon, 28 Sep 2026 19:31:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 1/2] bpf: htab: Split htab_elem_lru and
 htab_elem_pcpu off of htab_elem
To: bot+bpf-ci@kernel.org, tjmercier@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org,
 mason@kernel.org
References: <20260928150121.1712559-2-tjmercier@google.com>
 <714f119d120fb9ba4aa7e82af621edb7bc97813a760c9dd2cb5363c55b7365a9@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <714f119d120fb9ba4aa7e82af621edb7bc97813a760c9dd2cb5363c55b7365a9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/28/26 4:46 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 53c99fe4f176..5db11a21ce98 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> 
> [ ... ]
> 
>> @@ -828,8 +861,12 @@ static __always_inline void *__htab_lru_map_lookup_elem(struct bpf_map *map,
>>  	struct htab_elem *l = __htab_map_lookup_elem(map, key);
>>
>>  	if (l) {
>> -		if (mark)
>> -			bpf_lru_node_set_ref(&l->lru_node);
>> +		if (mark) {
>> +			struct htab_elem_lru *l_lru =
>> +				container_of(l, struct htab_elem_lru, elem);
>> +
>> +			bpf_lru_node_set_ref(&l_lru->lru_node);
>> +		}
>>  		return htab_elem_value(l, map->key_size);
>>  	}
>>
> 
> [ ... ]
> 
>> @@ -1310,16 +1349,19 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>>
>>  static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
>>  {
>> +	struct htab_elem_lru *l = container_of(elem, struct htab_elem_lru, elem);
>> +
>>  	check_and_cancel_fields(htab, elem);
>>  	bpf_map_dec_elem_count(&htab->map);
>> -	bpf_lru_push_free(&htab->lru, &elem->lru_node);
>> +	bpf_lru_push_free(&htab->lru, &l->lru_node);
>>  }
>>
> 
> [ ... ]
> 
>> @@ -1500,15 +1543,18 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>>  		goto err;
>>
>>  	if (l_old) {
>> -		bpf_lru_node_set_ref(&l_old->lru_node);
>> +		struct htab_elem_lru *l_old_lru =
>> +			container_of(l_old, struct htab_elem_lru, elem);
>> +
>> +		bpf_lru_node_set_ref(&l_old_lru->lru_node);
>>
>>  		/* per-cpu hash map can update value in-place */
>>  		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
> 
> [ ... ]
> 
>> @@ -2505,7 +2551,10 @@ static void *htab_lru_percpu_map_lookup_elem(struct bpf_map *map, void *key)
>>  	struct htab_elem *l = __htab_map_lookup_elem(map, key);
>>
>>  	if (l) {
>> -		bpf_lru_node_set_ref(&l->lru_node);
>> +		struct htab_elem_lru *l_lru =
>> +			container_of(l, struct htab_elem_lru, elem);
>> +
>> +		bpf_lru_node_set_ref(&l_lru->lru_node);
>>  		return this_cpu_ptr(htab_elem_get_ptr(l, map->key_size));
>>  	}
>>
>> @@ -2521,7 +2570,10 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
>>
>>  	l = __htab_map_lookup_elem(map, key);
>>  	if (l) {
>> -		bpf_lru_node_set_ref(&l->lru_node);
>> +		struct htab_elem_lru *l_lru =
>> +			container_of(l, struct htab_elem_lru, elem);
>> +
>> +		bpf_lru_node_set_ref(&l_lru->lru_node);
>>  		return per_cpu_ptr(htab_elem_get_ptr(l, map->key_size), cpu);
>>  	}
>>
> 
> This isn't a bug, but would a small helper keep these call sites to one
> line, matching the pcpu accessors this patch adds? Each site now repeats
> the same container_of(l, struct htab_elem_lru, elem) boilerplate followed
> by bpf_lru_node_set_ref(). The patch adds htab_elem_get_ptr_to_pptr() and
> htab_elem_set_ptr_to_pptr() for the pcpu variant, but open-codes the
> container_of for the LRU variant at every site.
> 

this sounds like a good refactoring:

static inline void bpf_lru_node_set_ref(struct htab_elem *l)
{
	struct htab_elem_lru *l_lru =
		container_of(l, struct htab_elem_lru, elem);
	
	if (!READ_ONCE(l_lru.lru_node->ref))
		WRITE_ONCE(l_lru.lru_node, 1);
}
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36441357391

