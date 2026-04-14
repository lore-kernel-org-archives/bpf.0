Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44873D5236
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162525; cv=none; b=rUawRS+LF5ivFxv3ujwh3feT3Hd/v2gI41px9cpaGRIen9GPsFJgJvAIKr9XG91Bh7/+4mlKj9flcPOdy/qpNd180zRIhP6FJmkW+3Ugs+udFCIOGWOL/0YuQWRfM6EMWu/+w+fxBE0kyoE1B0FRsF5n7OgaNbc7aXKKlXPeLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162525; c=relaxed/simple;
	bh=ewzJjYeO+GaHC2O8wWrnP3w3F7Nx+qiHSjSP7uaZ0a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGP1Q27fBRDlSnXx79L0btnuoeHXQf7hOge4Dq4COG0NjDGrMUu01yeiGVPbQCYQ6xAy7xoycy2fIjr03uQtgBo6JTzFNS8HM/uUuu7Mw+Y78JA+vV3arHC21BblcnuzumEr5UV12AQ/vmxNvoZOx6R0r4H6O2vwrOqY8uI24oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbPD7EIq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbPD7EIq"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso708139866b.3
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 03:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776162516; x=1776767316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWZg+DIY0BzjRTMCWcJyVQI0DjhbT56HtiiNc4GUW/A=;
        b=pbPD7EIq8+jHEAmiKDTxyABKKpwESzvXo2/9Ah1JKGRNEB/grAdaynYC3nCbK4MIC8
         hwUnYXuBRUzl2IBvyeUBbRbvRK0QrfAiDR5c1EEJK3QrRitKpZ5WWHW+POLIvO2w4A3d
         1qtSEapHyJhckidgJas/Gq8XsFIWsWED1Z1UFwrrC/f0XFUyA+enEyKDi15fA6zRg1pK
         xTBRYQYG6wsfeIqbjTLcgnT8CTGerHv6ksZkojVYDL7pY3baZuf6lJVvx12MaiVNbacX
         g8TFJAZ73Oli6y4L6iFw4abwFqggSs7I8gXsWLcwNmxZd1UqPH24mtnZUL5UbAK/WKH0
         3Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162516; x=1776767316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWZg+DIY0BzjRTMCWcJyVQI0DjhbT56HtiiNc4GUW/A=;
        b=Za+lV6Xdxakl5IpBoLIAVCnlofUIm5u7con3mo79JKxf+ro57+sc0nJJ3Ov6L755t8
         zSLTqvxVCFQyCkJduQUq9Hj8ds1PayvbybYGboarKgxRIpP5gyLUVtCxdvMbKDxUt29N
         qqD2L+jUNs5Ljxjr79SLek7VNF6p4kIdpWZHaa56F61YNrlh9AwOzhXHEFQiXsvd+gUb
         dmGqlrGkgfL+cuqiGn+ZJqTPBsMWY5ccm8tI1VQ/8UnzIBIHrgFJaEGox/s6Uoy7Yp2x
         ldPKxJdcP3DhR+Da34jqGYFFFdjQkg3N5Zj091IlyqFtctkRiMMwOAVm7aAlD2I/ugTq
         utmA==
X-Forwarded-Encrypted: i=1; AFNElJ+i5RnrC4Sec2lp4Jd46GrctUjjSIw242DjkWxtEuL5/q9o4CNX6MQhZx0ssCB19dF/n3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqx1ewP85qtdssfSZNjGXMggeIYS8G0B5A7ctAgoNMR3Cmy2j
	d6RuYoyVuVrS7mbL0FYZ1PNzeC49AKdxEhN5fSN5Oj5nLiHBjuABPtMS
X-Gm-Gg: AeBDies5ngJvSRdPeC0ym64GTQzijAs4vrcL9NOn8Au0iFws8gPkNneIAE4Lr/sq7CS
	KWHFqod1YdLO3TXlObEwlPmtnXpNOkRtqqcEPj/G1yQ9eirNVTLlwTYWcXd1Yz4TCjgP6FK1+ha
	mx8I263M8ThhtDhGKjdlrTDt4ta4m1F9ffEKyqARoeFM+7VS1ZTxRq0K/NpJeRDNnDxVqL3B1TY
	9OYS/xoUNDrisTn6xfnyy6PRUQ4WS8rWPMxE841d71bUHSQNDXvgPcxVRhdnT8vg8+f/iyH4ueR
	PrfgEMqlC6ilt6f7maLHKYEXr40uu0u2lB8XRkzdbQKVzsKpFK7sprnz+r/8iHEcM0eY1yN21O8
	PbiqKIdmnUsSbI5DDx0rsDovUmvQxiWE0teVp8ZkjMnC8MbnAEddtSfBq7NUowoo1ILr0RxzZdf
	iGD9sxFmDHDuQ5GLUVBW7tOfz8S0ixwA+fTVhlvnXJGbi5JODnTf6z4+4SOB3w2boYwPQTWKMEM
	I5A9XXv
X-Received: by 2002:a17:907:25cc:b0:b88:5158:d10e with SMTP id a640c23a62f3a-b9d7248482amr943763966b.21.1776162515635;
        Tue, 14 Apr 2026 03:28:35 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:2caa:994a:1164:dca? ([2a02:8109:a307:d900:2caa:994a:1164:dca])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-670703f1340sm3104978a12.10.2026.04.14.03.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 03:28:34 -0700 (PDT)
Message-ID: <d016e5bf-89c6-4fea-ad95-d722aabcd4f4@gmail.com>
Date: Tue, 14 Apr 2026 11:28:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 03/18] bpf: Implement lookup, delete,
 update for resizable hashtab
To: Leon Hwang <leon.hwang@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, herbert@gondor.apana.org.au,
 kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, yatsenko@meta.com
References: <20260408-rhash-v2-3-3b3675da1f6e@meta.com>
 <20260414102537.386868-1-leon.hwang@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260414102537.386868-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/14/26 11:25 AM, Leon Hwang wrote:
> On Wed, Apr 08, 2026 at 08:10:08AM -0700, Mykyta Yatsenko wrote:
> [...]
>>
>> static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void *value, u64 flags)
>> {
>> -	return -EOPNOTSUPP;
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhtab_elem *l;
>> +	int err;
>> +
>> +	if ((flags & ~BPF_F_LOCK) ||
>> +	    ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
>> +		return -EINVAL;
> 
> At the moment, we can check the flags using bpf_map_check_op_flags() helper.
> 
> This helper can be applied to flags check in this series.
> 

Thanks, I'll use it.

>> +
>> +	/* Make sure element is not deleted between lookup and copy */
>> +	guard(rcu)();
>> +
>> +	l = rhtab_lookup_elem(map, key);
>> +	if (!l)
>> +		return -ENOENT;
>> +
>> +	rhtab_read_elem_value(map, value, l, flags);
>> +	err = rhtab_delete_elem(rhtab, l);
>> +	if (err)
>> +		return err;
>> +
>> +	check_and_init_map_value(map, value);
>> +	return 0;
>> }
> [...]
>>
>> -static void rhtab_map_free_internal_structs(struct bpf_map *map)
>> +static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
>> {
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhtab_elem *elem, *tmp;
>> +
>> +	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
>> +		return -EINVAL;
>> +
>> +	if ((map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>> +		return -EINVAL;
> 
> ditto
> 
> Thanks,
> Leon
> 
>> + [...]

