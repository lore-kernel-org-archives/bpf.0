Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F0B3DE441
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000266; cv=none; b=TdMrA9inQGwktuLo7fJRKHFZJl8K3b7kpUgVOCXWqasGCHPC3BvTfmtR9yPepm1yLkqEAHnxrNdke2XUbGM3bVmMHfp1JfFPUXwjdSJOd8YzgDclgfy9v8BWJJG0AT7H6ZXiVP2bEadORzzxr9iBH4qF9efeidrdL94v1VXr9s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000266; c=relaxed/simple;
	bh=bSUk1Gkcfu/PImKNZfN7B5e8QXU7yU7J+f1S+wP0XGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MddT/vIThHz7YMuAJxfzi6zmoIji5ZZGYaBxD8UDE98fkuxPe5pVEjEWqahx6XBsYxQa1ub0dnB/X+BTo4Y54+5du4eU4XyO+0pwE/BapAYzFEZBH/srpCAvuP3VNYXc3RpWpHOX/FUu48WlC7T8+gx6ilL0HhG6ra98N+NizyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO2lST1B; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO2lST1B"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43fe62837baso3035274f8f.3
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778000263; x=1778605063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gf8p2hTR3w/DkxMYWfJ41+/E5OReCnE0qZTNiffMl6k=;
        b=SO2lST1BIV+E8EuWwoo9xbzgimSyGYC9Q3+/l6B3Wc41ajMNQVJyFMyBgxJe06P+I1
         /Ga1uuLi3JK8tFPFiCpQBfdYn6L/PgOhMt5KSKMQiqDd+xT8Gjq4FGDSO9PuVSaHmf+i
         TApd6T5rqz6Bum6GX5uObv/aDT1L6GzIDvDwDgcNBfxhpb1ye10lEOyN2WEYxn+RFslF
         VL5XIAIt7qqkaHn2DJFFSgnNe1H/JPeXBzoaw4EhUlU1c/kgghjtvTGgiX3dQLUjXPfr
         e7CzNmdk50EuqG+YFbekToLUBODETW7bTp0+umDRtF+sUSlhi+MsgQGl1i+DKc1DtZxM
         uqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778000263; x=1778605063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gf8p2hTR3w/DkxMYWfJ41+/E5OReCnE0qZTNiffMl6k=;
        b=Azz7tNmNCYezakiXVIrbEVeArbXb0pnpLXnPSqedq8NagtRBcK7SPKd8SAZFIZb904
         GUc5Alg5z9vw7mIwat8hkcNjZ3W2P1YtBJ7KBBasL0LdBeg7P0rpqlg2Q+EpCtVj7ce4
         Z6N2rAdEVFwe4Pp7Yw2XuEY1hte2yln4/7JxsyfZqYoASFZVJq4zFoKCpaliUE6XEXi8
         FQHRpARUPyCuTYlPKueyg+KmlAF0B65+7+8+/dmA/jogcbsAXMTrba7v0pvDZTCWzCbu
         xNXjaoGMTiD3ejH7sRlb9OKm8Ntat3m/zKQWSehR72CtgRNQiIq3NYHrV6CdP8X46cJW
         zH2g==
X-Gm-Message-State: AOJu0YyXokTKaNeEI9brQpgZtme9h7EuAz/SYgzNNLxbR0pvN1k2v9jh
	4IyVFCkMNhqcnRyt/RVFBy7NNMp83cqW+AQuqbn6mvUc4YIuluXtPJ9QqzseONeb
X-Gm-Gg: AeBDies4GPEu9021H0e7AEvrD2JgzK9bogeHxN7lc35liNJoCRyBJ2qNh+ceggSZAP/
	hD58+xmsvjSblkG3YxY1i/QfY3zIc61vH7+L/YWBYjLIovIo77yco98vVHpfh/3HcghaG7DwGb8
	izjto4aR15r0LRhfvxQwqpbad/VrYvrcO3qWQ7hwqsX6M1pVJYfd64ppMEPG09hubRTEjuVhzpz
	oVWAbkzk3OVTWbdlEgdupi67aVBX5pK3tC7VtiUXIFdiTurjOfnmqkipt+D0j1QmbOig9cnvPbX
	OralpVnJGJ7KPToF9mt6jz4xCGuDvI93XpcVNw9euhxKFpyFkvKoG9sOPXXUvj4OVGuP/hU/I+W
	1mnjrfzep1TmXUeh3Qmy90xecsW61aWtgtsBF1IrYz2i0APyJ4BC56sq1BMSCy7j5CTRg6iz5o3
	EFnWcKhmpgIvrVdA0pS2g4D0Zg0Jh3CvJnAbSuVPVLh30AlCtZykMh8VpwT1PzO6FI5/ZbpArtb
	sGn+azqe0OcDobgzer8/A==
X-Received: by 2002:a05:6000:2386:b0:451:4d47:c9d9 with SMTP id ffacd0b85a97d-4514d47ca15mr222281f8f.14.1778000262723;
        Tue, 05 May 2026 09:57:42 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055e2d3d0sm5656100f8f.34.2026.05.05.09.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 09:57:42 -0700 (PDT)
Message-ID: <9a83db58-5192-4d12-80f1-2a63ba29def3@gmail.com>
Date: Tue, 5 May 2026 17:57:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 02/10] rhashtable: Add
 rhashtable_walk_enter_from()
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
 <20260424-rhash-v3-2-d0fa0ce4379b@meta.com>
 <afCNcFLArNkj7GXh@gondor.apana.org.au>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <afCNcFLArNkj7GXh@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/26 11:35 AM, Herbert Xu wrote:
> On Fri, Apr 24, 2026 at 12:50:44PM -0700, Mykyta Yatsenko wrote:
> .
>> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
>> index 6074ed5f66f3..2a6098edf737 100644
>> --- a/lib/rhashtable.c
>> +++ b/lib/rhashtable.c
>> @@ -692,6 +692,47 @@ void rhashtable_walk_enter(struct rhashtable *ht, struct rhashtable_iter *iter)
>>  }
>>  EXPORT_SYMBOL_GPL(rhashtable_walk_enter);
>>  
>> +/**
>> + * rhashtable_walk_enter_from - Initialise a walk starting at a key's bucket
>> + * @ht:		Table to walk over
>> + * @iter:	Hash table iterator
>> + * @key:	Key whose bucket to start from
>> + * @params:	Hash table parameters
>> + *
>> + * Like rhashtable_walk_enter(), but positions the iterator at the bucket
>> + * containing @key.  If @key is not present in the main table, the iterator is
>> + * positioned at the beginning.
>> + *
>> + * Same constraints as rhashtable_walk_enter() apply.
>> + */
>> +void rhashtable_walk_enter_from(struct rhashtable *ht,
>> +				struct rhashtable_iter *iter,
>> +				const void *key,
>> +				const struct rhashtable_params params)
>> +				__must_hold(RCU)
>> +{
>> +	struct bucket_table *tbl;
>> +	struct rhash_head *he;
>> +
>> +	rhashtable_walk_enter(ht, iter);
>> +
>> +	if (!key)
>> +		return;
>> +
>> +	tbl = iter->walker.tbl;
>> +	if (!tbl)
>> +		return;
>> +
>> +	he = __rhashtable_lookup_one(ht, tbl, key, params,
>> +				     RHT_LOOKUP_NORMAL);
>> +	if (!he)
>> +		return;
>> +
>> +	iter->slot = rht_key_hashfn(ht, tbl, key, params);
>> +	iter->p = he;
>> +}
>> +EXPORT_SYMBOL_GPL(rhashtable_walk_enter_from);
> 
> I still think this is misguided.  I'm not going to stop you from
> doing it if you really wanted to, but this thing will not work well
> if your rhashtable is constantly resizing.
> 
> You also need to consider the possibility that an adversary is
> triggering the constant rehashing.
> 
> Cheers,

Herbert,
We brainstormed with Alexei on how to integrate rhashtable better,
as a BPF map, we have the next proposal:

Introduce rhashtable_next_key() API
```
static inline struct rhash_head *rhashtable_next_key(
	struct rhashtable *ht, const void *prev_key,
	const struct rhashtable_params params);
```

It returns the next element, by finding prev_key in the tbl chain
and returning the next element in whatever tbl the prev one is.
This way we keep rhashtable API tight, less surface, not exposing unnecessary
details, although, this new API will have the same issues with full
iteration support (which we fine to deal with on userspace side).
Appreciate if you share your opinion on this.


