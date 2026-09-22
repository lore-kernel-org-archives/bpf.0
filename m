Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC2B4848B3
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100655; cv=none; b=W3/AzdLdF2XMbX51lGeXUt/2b/A8L70tqhE+e3ARpcCCzX4j2Zdjipp3kI6PS06fl5Gc/EvT8Ayb/jR136DxhmSv355G9stYHj9dYJm+iDEimqcu8p/LtpZmPkMHwrTqoWmT0bcv0oVeEJbXSIWdxVgRa9Gmwx4GW36cq6jvbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100655; c=relaxed/simple;
	bh=Aiwi/57ro32i8S+PbUKG7AiN5OxGDUL9agMO9A0gG+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Si0gMcLuMWLAiViMDRisTjxxZEJcS7ff8pFfAymj4jNRZbq08EaVah565DqR5s2Wolleb5PLCzHN7ekY1sb40IUOSb4pd1T4IfKlX/b1hJ04UB4CtWj1+5iLicWHbndPe88qRJi7cxBblJK1NSXacrzFdofl8CQs9uxQ6iZx99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR32jHIt; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR32jHIt"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c3so166306f8f.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790100652; x=1790705452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xTJGDgnrwX0goSYWUxKDiz39i158qeQbDfyk43iX700=;
        b=lR32jHIti4tr2hbTuNY4v2ds8Ssq42eV/tm0oDS5tVN2/HHPLG65Yw1dCpWYH3zDwO
         rJn/1hMtCi1WQpIpusXma8swWkV6IqQB6S4juz1NPgUf44dU6u+YfHwkjXmqdFOguWUq
         jwpmgzKgc6q4YmBvUMtK6yL2g3hs/JcHLI+kvMzOapRQTjj6hs2WEGt3aRWLnTLMi8e9
         yaoz/YyyoIjaJ/Jyu1Mq9oMcABFN+a2f4Jk5pKHz0FiFp3sF8HSaaUsDD5dtKxelMxG0
         AgVWJYC2B1gWsjtQwq+6rC8zv3PmivQp3qT5wAgFlFNlmkBTo16E9LhbyIbwyWfwnnxS
         UZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790100652; x=1790705452;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xTJGDgnrwX0goSYWUxKDiz39i158qeQbDfyk43iX700=;
        b=LwlTZk1hHM7ewdzXaXGd0NLb0TseUAIGuD3BL4XDXHAXsJxuWQ8a4UX+AE+emkRWNS
         LeU4i4bMTXjGfHtgEeQ5vX68z5+3a5A1wKXNvewnzShiV+fOrhrnLODYhdoM2GJvcZ7B
         qCPsmDd/fP2lneequxZu71s4j0BTAIR4+bn5ntTmKmEC1YaN0akk89jjQxI+EoaSnUKD
         drHAyLFfIRy1fjb4RurqIEwZm9288l61LNaI5OxaxQ7QIVsB85YvliuBboMEXH7BIjGs
         L3i2BuYHTAnX1IQWTtj031zrx6qfg41cgGf+1cyzhcRmF91EiQ3EYSDsU3oraC9M2900
         HUaw==
X-Gm-Message-State: AFuF++m4sYjL1d9SEpoJipbjQ+CC4o6gC0UzQ6dzOWB6NKEbe1Jp92X8
	g900Mt4cyttcCSjeN4SvV9Pz3khiowQf6p5Vgkfq8HkHpJvNH0MDtqMjE/1gyAd1iko=
X-Gm-Gg: AYBFou0QruORuX+YlR33cMx23JpPx5AWsErT3C1tYSHSIn8IKyy3ou8ZmOxM777bxq/
	xvry5cYAvFpXl5L6imMhif1uQSiipQFdSmH4Bw2n2JG0NHXXdYX/wPxpsTetN6mhk7C56QSDb6w
	bHaRXavNUFyXdTNRT1r4fHjzpmDlSsvEErAYnjUM1RRW2azZQG1UwFNSuSrZ2ENAjaIs5VKiNwV
	1SofmC0PFShmS2/RVBZ7Cr36YEtpibYsxIP/Bf896HI1Uvc5ziQNIi2f6LvuYNnNbrFBMhC5J2R
	LjMkfKfrftq5qXTmNBm2Z+j+rmLgKAyn3q6+7V4iHiVQwpkoQAkhUYfP6UGqIldlm0goUc+yqjF
	V0nf4uT5co09xj0jInq6FxVS14/kqUub8JfrpfWYbWfj1s7enSK/+M3viduxEkBK2jHDN11vC4j
	INc8ALA3dhjfelzjkvlvZdAJney6SHhGGTm2BpXkRFxaGY9bWPsp1I3RBO3oT+u6dKLkLXSVG+Z
	nKjG06xBLwp/dFYCSEJS6UToggHxDkCjd0=
X-Received: by 2002:a05:6000:430d:b0:486:ecc3:2d1a with SMTP id ffacd0b85a97d-488670a04b4mr601845f8f.31.1790100652027;
        Tue, 22 Sep 2026 11:10:52 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1715:59a3:7aab:2955? ([2620:10d:c092:500::7:c6a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c1fdsm190681f8f.14.2026.09.22.11.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 11:10:51 -0700 (PDT)
Message-ID: <be18926e-124c-40b1-9846-b99277c800ad@gmail.com>
Date: Tue, 22 Sep 2026 19:10:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpf: Speed up htab lookups for u32/u64 keys
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260922-hashtab_fast_hashfn-v3-1-b7b0e9bc33ac@meta.com>
 <20260922180843.CB7721F000FF@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260922180843.CB7721F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/26 7:08 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: missed u32/u64 lookup optimization for LRU/per-CPU/of_map variants
> --
> 
> commit 88a648ce718a5816a7cc1175a104d2f26afc58c0
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> bpf: Speed up htab lookups for u32/u64 keys
> 
> This commit introduces specialized hashing and specific lookup entry points
> for 4-byte and 8-byte keys in BPF hash maps. It achieves significant
> throughput improvements for standard BPF_MAP_TYPE_HASH lookups.
> 
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 6f331c80130d7..f744a42bb8139 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> 
> [ ... ]
> 
>> @@ -783,7 +805,16 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>>  
>>  	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
>>  		     (void *(*)(struct bpf_map *map, void *key))NULL));
>> -	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
>> +	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem_u32,
>> +				  (void *(*)(struct bpf_map *map, void *key))NULL));
>> +	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem_u64,
>> +				  (void *(*)(struct bpf_map *map, void *key))NULL));
>> +	if (map->key_size == sizeof(u32))
>> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u32);
>> +	else if (map->key_size == sizeof(u64))
>> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u64);
>> +	else
>> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
> 
> [Severity: Medium]
> Does this miss an opportunity to apply the identical u32/u64 lookup
> optimization to the LRU, per-CPU, and hash-of-maps variants?
> 
> It looks like specialized JIT lookup generators were added here for
> standard hash maps in htab_map_gen_lookup(), but identically structured
> functions in the same file such as htab_lru_map_gen_lookup(),
> htab_percpu_map_gen_lookup(), and htab_of_map_gen_lookup() still
> unconditionally emit a call to the unspecialized __htab_map_lookup_elem.
> 
> Would it make sense to update those generators as well, so these heavily
> utilized map variants do not miss out on the same performance gains?

yes, I think this is a good idea.> 
>>  	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
>>  	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
>>  				offsetof(struct htab_elem, key) +
> 

