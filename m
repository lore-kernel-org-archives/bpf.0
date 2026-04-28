Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67847A0D0
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382455; cv=none; b=nBnRWbKKbftgWvom3GTeXGgwtp7pINviAMK1NqLquZcibIJ39oK0KwZxctzb57C56MyxtQP9etvwtIY4G3Ei3Yawj7CqL076I9woRlsTDN4rvq4rq5vNoP00hz/t5Kt8PlH7CUrCteY9DdttrSGHGsIdpdGlEelSIdIk7I0F1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382455; c=relaxed/simple;
	bh=2iRKyq2ypGPCv3jDsU/R9/TlTHG4j+AAlpxVYxq89p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3d7/iD2UqOXNj8nY8ntsQhtKTYP62x5cBZgq1VtTvDO++MjKR6ce3uFeZQo7h9+gxglu2vYppFj/O9jSFSLTQU+4maHG5h6J/R+SiZUB1Um1gR2fbBI2ZI1Re6VG20KaLg0P777f6bDoIp5dKbe6RE4nFwxcIVgv1S9Y1ux+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXpOYFZ/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXpOYFZ/"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso119285435e9.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777382452; x=1777987252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5i7prc6vKc4cjBbzoB05e+OmnbLpkMsKJiJ/LOhK0RA=;
        b=VXpOYFZ/npWKsfHVqhc/M+rtKSS75bOUx5wb6Wl7q5z0F43TPB0i6nQXJY79vGSMYB
         q7806q8IiFt8n+mSnv1SNhKAiXZIeoyg0nTXE0Z/8GNm5oqS+bv+ozo+3jMkLBnXe7vG
         zuo7acEziR5L/nWWrLp0YpsaZ14XJDRFmyyIg1ZgG2tncyZClnuZ6ed44q5P+QJ80OfU
         9O0VRNCP0EwEgRSlV+ux+koqEAXq0lk5btN70UPCga6vA/SI+EJU7g4deckOpUz5Px11
         3SLjgsk7S/hOB32+rEupN4Fig9XIqUp8puO93mPFjSUGOwiv9FRUsfu4EdWRBFvuFrSy
         NauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382452; x=1777987252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i7prc6vKc4cjBbzoB05e+OmnbLpkMsKJiJ/LOhK0RA=;
        b=DSPyrc+wAGYQNDhRIGnmyhVdzAuosPhqb52h8B/hxtaa47+gMH13QvWECAgd10Z89u
         0wxzxYqj8wTxqGjIOxNtIYg1P4itqiHJWh68XplPVH1gqVG73ExfJdq/Ps3KWBQ6aWuf
         taCyMsNT5nLYoTNQTE2w0+J909EdLvyINZ0fdqSiECSoD0hf/wz/ngtwVWUTrv3PHI5z
         b2swG3WJktKaDbq1ATa5738mxQ3FaJlVrD3U2IroLqqL40s4qEqZgSToJukmUOuB66ew
         KU7/Kd0RZm7KsAIsOpzgY50JK5y99CPwreX6ekjXJQ+YgT1dzqY208uA0VMgyM4X0PDH
         bWPg==
X-Gm-Message-State: AOJu0YxBKi8ptSlQrcCxxvG8d1Ol1UY3g0vAiS3Sq3Do9yZMgrREW6rX
	Ysetmy5/GT9XzaXFoeCWErZsF6eaj66nrUu+vLEmUgPoULDdPBgSId6M
X-Gm-Gg: AeBDieubvOt3cLYlKBcbF10r31ZciKJAnz50HfFFqqIaExME+AtScBmungTBF8mlJ8w
	KKGT/02G21zx/toDFO7ellQxiFyqavnjaS7QH2+6JErIXc007MVvmOS6hNa+D1KJAdJIa/h0ED7
	cES/nQz52AHwbzI9zEy//vVurKN/5U6KmnsR636jjypd81Cpsuc6HlNDhXs318yLV/f04UP2IIn
	SUnsxNHvawcgxG5c/r6b/zCpDLdBRY55HnD1dmTWyHKJdbiN+hd9GK1hKWjK95pyyVHlj3bGZ0R
	vJu+SEzh8mQEv66wi2kMPYXe6W9AsXJTG7hfkn1JqINJcHc4yryoTPEQ8LBf+ta+dfpRfc+4gfQ
	NRWIajpVWetG6My61rk4ySJyS3MF9+BoPecKQbJeUfqx+ImDmzYlLHr+A+e2xYsCQgvWYphPryq
	Ql/MlpMk68UHscRi07G/z8M2sZ6e+hm1ZoH6zBFZ/nltPDtMp84lHRAPcChhdG2oWAT+RbSa0=
X-Received: by 2002:a05:600c:81ca:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-48a77b24e5emr48687355e9.27.1777382452103;
        Tue, 28 Apr 2026 06:20:52 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:a8fa:3ba0:8ad5:b4fc? ([2620:10d:c092:500::5:c044])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77449ce5sm30956335e9.0.2026.04.28.06.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:20:51 -0700 (PDT)
Message-ID: <abc3f69c-94c3-4817-8ac3-e2c9fd39a5b3@gmail.com>
Date: Tue, 28 Apr 2026 14:20:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 03/10] bpf: Implement get_next_key() resizable
 hashtab
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>,
 Emil Tsalapatis <emil@etsalapatis.com>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
 <20260424-rhash-v3-3-d0fa0ce4379b@meta.com>
 <afCNDOhbszgMlGB7@gondor.apana.org.au>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <afCNDOhbszgMlGB7@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/26 11:33 AM, Herbert Xu wrote:
> On Fri, Apr 24, 2026 at 12:50:45PM -0700, Mykyta Yatsenko wrote:
>>
>>  static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>>  {
>> -	return -EOPNOTSUPP;
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhashtable_iter iter;
>> +	struct rhtab_elem *elem;
>> +	int ret = -ENOENT;
>> +
>> +	/*
>> +	 * Hold RCU across enter_from + walk_start to prevent the
>> +	 * element cached by enter_from from being freed before
>> +	 * walk_start re-acquires RCU.
>> +	 */
>> +	guard(rcu)();
>> +	/* If key is not found, places iterator at the beginning */
>> +	rhashtable_walk_enter_from(&rhtab->ht, &iter, key, rhtab->params);
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
>> +	return ret;
>>  }
> 
> The same issue from v2 still exists here.  If a rehash occurs
> in between calls to rhtab_map_get_next_key you could be iterating
> over the table forever.
> 
> Cheers,

Yes, I agree that it is possible. For this function kernel does not
iterate the entire hashtable, each get_next_key() call comes from 
userspace via syscall, maybe the risk is acceptable in this situation?

Other functions, where kernel does iterate over the rhashtable, it fails
and returns -EBUSY on resize.
