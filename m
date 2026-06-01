Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB213019AA
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331917; cv=none; b=JIKmFIUZcRKwHFH5K1pCrEFH3uOmmU7oJsTpQm4fEtWEE5zzQUASuGhkoyWPXJYTpussN1agi+5an7lzNNrVlODyqVW+iMYMsH+Pa39FpVxjyrTL/IqIP3/9RTMyBiowsqV+CSkOYE0xD3LJhpt4fdaNYbsWiolgYiEWkOEEYPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331917; c=relaxed/simple;
	bh=NhMdKMbxd578ve88bY8hzsnoTjxXLQEEBtSn+TrvUDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+Rkp4VlvHtFu+t/WGcxMaGgY/FiQ6YpExEDNdqRKpYMBcjSyJYLOZv3I2ZDOTtzIPdf417qc2/HhNyUTcBJUfxb6BYzvRP9YH/u9diN1TQTK9T0y7eJ4QVcpUN+qVROYZrPJfWTwf9Sy7LmprB2AMlb5876J7wGeXE8kOCDBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=srw2NLt+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srw2NLt+"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490ac357c55so9937815e9.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780331914; x=1780936714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O25LddiBm/bSmAHhSH1MOmSMmOhV8d/5eCeC02vFeOI=;
        b=srw2NLt+PUdTX/qvwGj/a+m3O9UMVOM057sZRNEq55Y8EEjSu+5BLb1SdO0vphuK7A
         SmQfi8ziDMQ642gHI2YES3z6YH9qfCNiyQUdfkwLYtOpfqZvHaz8MgdnIV7V8/7HZ2eV
         r6YkHBybN/fG+VQGRl1YJBdnBHO8DiUGqn4fhx+tSbEUbxyuw4WYeKJtx8CB8nHpNAV4
         jbuIUtuU9xVf3insKtuZXhPlBUnGhcdwR4oIIUR78QuKzKKu3bxfMvg0OSLScSjCABR1
         niZ6cMPM8ab5zD1BfqIcwZTyk/sFlTXPKVPbxeConFDwOKUdVkSxn4DSWsqqGvvCOM99
         0bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780331914; x=1780936714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O25LddiBm/bSmAHhSH1MOmSMmOhV8d/5eCeC02vFeOI=;
        b=hJlHAz22J9QHxisRfTJSugMJD6mzAelc7/o1drSy52n0kSRoBrYQVSxXnssDcdXgZq
         pfCsLsGq45Yx6XQTJDNSHLPJ7d+dmqrct3JvC34xSJHtpF9mPwev6/JADwzNQZuxHNfK
         3/PF/32tIskGnAMT8RSIJJMPb/v6utLZd4ooOkVu83DwqYG4cPNL0HJEBQgZyfnVcRPH
         ilReLC4sQix//gddUKv49y4GNXM1JevytBcG17vzy+37WMa1scGz/YnFDU1CxxoQrxyn
         BHDhT+mZdhkHKzgLeoLXwhME+4ObRDyJxoZ2+Xz0Bj/+ZXySCZRYIPbYLsSdhZMxPoVD
         Xf7w==
X-Gm-Message-State: AOJu0YwPAbW+Ff2sNWcidGN2OkjKT8Ar+jv9T2DfkKina7CCGRT5qbFA
	TLIp+2tIABh8mxQJvRTbquDzzWGPnV1hSJYebE8D9J4bnyrA8Nlh658DszKvrC+9
X-Gm-Gg: Acq92OH7+3UDyuwT3w4SdZAP0I9Z03aYp0soni7q3PsRS5Mwq4V9LxA7BDX9uWloeNh
	yDsbM9JQL8RNuivyeOxfxmYY1d/GYjHqv3PMIhnD3S5w6oabnfQLrbKasR13Tmw69+jS37RG32x
	ZODD6JlJ+Ix3u19yglVHKDSVryEqTqji/FS9/nrwTnbfc6SZUpB46swZpplk58h61KjzewOT/hG
	1jmapmsvrroCCgunXT10xcr1v1G/O6/5Y/SXR2a0RMvM2DsygVDf2eIK4KxtZGOO4xwoYSknHQb
	JYCEd+V1LcQ3bu5pqmjKNPrnMC0vN2C4TrRk+cOOPBvA/veFjhFY6TRM6BsHOsWax+hbDp5qK3K
	iz0zxR/y7Wg9clzz1TQkejFXhOCYXrkvF9fAfuZRnirAaY8nEzkaiq5Ek0R13a4NgDrMaiptRX2
	caOAeRomTqOxMk4A/+hhxk6vaNdAPlusIP/3M4TFuAzw0YFMgHpL8W4AgNGLBLfcs1gaGJ/lBNk
	0ck598STMIf/wbqM5fx0g==
X-Received: by 2002:a05:600c:524c:b0:490:52c0:744c with SMTP id 5b1f17b1804b1-490b0885319mr11135015e9.20.1780331913629;
        Mon, 01 Jun 2026 09:38:33 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm27051130f8f.34.2026.06.01.09.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 09:38:33 -0700 (PDT)
Message-ID: <a965cdd8-1515-418f-9bb6-ae7e811e5604@gmail.com>
Date: Mon, 1 Jun 2026 17:38:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 06/11] bpf: Optimize word-sized keys for
 resizable hashtable
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260528-rhash-v5-6-7205191b6c57@meta.com>
 <20260528182522.23D121F00A3C@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260528182522.23D121F00A3C@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 7:25 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Trivial hash collisions in `rhtab_hashfn_long` defeat rhashtable's DoS mitigation, leading to infinite rehashing and 100% CPU livelock.
> - [High] Direct dereferencing of potentially unaligned map key pointers in the optimized hash and compare functions will cause kernel panics on strict-alignment architectures.
> --
> 
> commit 40f8c726140c6268e5f797c092818cebd3cfc282
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> bpf: Optimize word-sized keys for resizable hashtable
> 
> This commit specializes the lookup, update, and delete paths for word-sized
> keys in resizable hashtables. It introduces a custom XOR-fold hash function
> and single-word equality comparison to bypass the indirect jhash dispatch.
> 
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> 
> [ ... ]
> 
>> +/* Specialize hash function and objcmp for long sized key */
>> +static __always_inline int rhtab_key_cmp_long(struct rhashtable_compare_arg *arg,
>> +					      const void *ptr)
>> +{
>> +	const unsigned long key1 = *(const unsigned long *)arg->key;
> 
> [Severity: High]
> Could dereferencing this pointer directly cause alignment faults on
> architectures that require strict alignment? Since BPF programs can pass
> unaligned pointers (such as from packet data in skb->data) directly to map
> helpers, using get_unaligned() might be necessary here to prevent kernel
> panics.
> 

The same problem exists for the htab jhash2. it looks like for the arches that
BPF cares about, this is not an issue.

>> +	const struct rhtab_elem *key2 = ptr;
>> +
>> +	return key1 != *(const unsigned long *)key2->data;
>> +}
>> +
>> +static __always_inline u32 rhtab_hashfn_long(const void *data, u32 len, u32 seed)
>> +{
>> +	u64 k = *(const unsigned long *)data;
>> +
>> +	return (u32)(k ^ (k >> 32)) ^ seed;
> 
> [Severity: High]
> Does applying the seed after folding the key make hash collisions entirely
> independent of the seed?
> 
> If a BPF program or an attacker inserts keys constructed as:
> k = (Y << 32) | (X ^ Y)
> 
> These keys will all fold to exactly X before the XOR with the seed,
> meaning f(key1) ^ seed == f(key2) ^ seed for any random seed.
> 
> If rhashtable detects a long bucket chain and triggers a background rehash
> with a new seed, won't all these colliding keys move together to the same
> new bucket? This might trap the rhashtable worker in an infinite loop of
> rehashing, leading to a 100% CPU livelock.
> 

It looks like the attack is possible in theory: attacker should be in control of
the 8-bytes that rhtab uses as a key. Not sure if we want to fix it or leave
for performance.

>> +}
>> +
> 

