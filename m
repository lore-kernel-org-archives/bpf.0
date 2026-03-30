Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1C3C1415;
	Mon, 30 Mar 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872576; cv=none; b=Y8WfPrIf5Dc4uMALS+K5Akj1Ho2tDR0QTmQbBLdNld/oy83SpFl0qJX1Q/1xZPCMmpe/yMIvzMbRAMuIqL+RLVM840fLlAIvrCc8ChUEdPbm1MycPzUmD3IrD0ejq9tf1ltwUIyRJ3stQnpjDFgd6a14wjNZImFVdkxtb2M1sog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872576; c=relaxed/simple;
	bh=bAMR2VvQnY1wHO5Aay50HuiIUDYJz6WQd+15bmNhySg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D9Gvh+j+GdyzILbEvbhAeOoPKgr2Wbsf/QbY/s5k12WPjnBbfT5SBKxP0+y/pvuJjjHrD6oqnC/NhSDA0SxaIrPDaADAnjSBe3IBKBlgmd8bmEWH85ZqI7QJsIxvt5nbcSF2z4m+R0SZiZ0Crs2DFmXMV3ZeOIgQwP5nRNUmYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Z8G4l//I; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Z8G4l//I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Lx7YRXKJCWBCsErD1cu39z8DMl9eZkAIZO/j8HiaQCg=; b=Z8G4l//IHYvULS6gB1JauJrEtw
	AjIx5BEWpsHQLzzni1ebLacBV+oM/lKD7PzgW4yaFtfG64jNKIINZHuvssct7WH4g/4xu/+OC0Mpi
	ufsZvAFurtiC6+PDuvAJagqyR4Y3NvowwbVm/3oMMvPFvm+reaUzAKPxeL/Uw00638RBX85pOt69W
	TUebJtQbnrtfnLkC8d4Soyvv7uEF28tAqg17vvz0znaxZdFBVvfdmKoEIPqRWYNG962tUYnMwzOuw
	13i+cvREO+GX/ytmySMnKcOXIHL4vKNqSgz2HZjE1F7rKG4EIlP1ZiEPpEWP90vTakBcNL0KCcYgz
	8pVfmmJA==;
Received: from [187.106.45.161] (helo=[192.168.100.160])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1w7BQo-008xuJ-2D; Mon, 30 Mar 2026 14:09:22 +0200
Message-ID: <7fb97184-baaa-4639-a0b9-ac289bf2e54d@igalia.com>
Date: Mon, 30 Mar 2026 09:09:16 -0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: fix umin/umax when lower bits fall outside u32 range
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org,
 shung-hsi.yu@suse.com, yonghong.song@linux.dev, ast@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20260327194849.855397-1-koike@igalia.com>
 <74e65b463d1f992bc0e4846085394a440796f563.camel@gmail.com>
Content-Language: en-US
From: Helen Koike <koike@igalia.com>
In-Reply-To: <74e65b463d1f992bc0e4846085394a440796f563.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eduard,

Thanks for your replies and pointers, please see my comments below.

On 3/27/26 5:46 PM, Eduard Zingerman wrote:
> On Fri, 2026-03-27 at 16:48 -0300, Helen Koike wrote:
> 
> [...]
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index a965b2c45bbe..ddac09c8a9e5 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2702,9 +2702,29 @@ static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
>>   	__u64 new_umin, new_umax;
>>   	__s64 new_smin, new_smax;
>>   
>> -	/* u32 -> u64 tightening, it's always well-formed */
>> -	new_umin = (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
>> -	new_umax = (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
>> +	/*
>> +	 * If (u32)umin > u32_max, no value in the current upper-32-bit block
>> +	 * satisfies [u32_min, u32_max] while being >= umin; advance umin to
>> +	 * the next block. Otherwise apply standard u32->u64 tightening.
>> +	 */
>> +	if ((u32)reg->umin_value > reg->u32_max_value)
>> +		new_umin = (reg->umin_value & ~0xffffffffULL) + (1ULL << 32) |
>> +			   reg->u32_min_value;
>> +	else
>> +		new_umin = (reg->umin_value & ~0xffffffffULL) |
>> +			   reg->u32_min_value;
> 
> What would happen if there is no next or previous 32-bit block?
> E.g. if (reg->umin_value & ~0xffffffffULL) + (1ULL << 32) wraps around.
> I guess the argument is that if this happens, there is an invariant
> violation already, will the final register still bin in invariant
> violation state?

I thought about it and my conclusion was that we would be in trouble 
anyway and the error is elsewhere (unless my understanding is wrong).
We could add a check here, but I guess reg_bounds_sanity_check() already 
does that.

> 
> Useful picture:
> 
>   N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
>   ||----|=====|--|----------||----|=====|-------------||--|-|=====|-------------||
>         |< b >|  |                |< b >|                 | |< b >|
>                  |                |     |                 |
>                  |<---------------+- a -+---------------->|
>                                   |     |
>                                   |< t >| refined r0 range
> 
> Also, as this is based solely on unsigned ranges, the following case
> is not covered, right?

Right, this case is not covered.

> 
>   N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
>   ||===|---------|------|===||===|----------------|===||===|---------|------|===||
>    |b >|         |      |< b||b >|                |< b||b >|         |      |< b|
>                  |      |                                  |         |
>                  |<-----+----------------- a --------------+-------->|
>                         |                                  |
>                         |<---------------- t ------------->| refined r0 range
> 
> Would it be hard to implementing something in the same line as [2] to cover it?

I'll check and get back to you.

> 
>> +
>> +	/*
>> +	 * Symmetrically, if (u32)umax < u32_min, retreat umax to the
>> +	 * previous block. Otherwise apply standard u32->u64 tightening.
>> +	 */
>> +	if ((u32)reg->umax_value < reg->u32_min_value)
>> +		new_umax = (reg->umax_value & ~0xffffffffULL) - (1ULL << 32) |
>> +			   reg->u32_max_value;
>> +	else
>> +		new_umax = (reg->umax_value & ~0xffffffffULL) |
>> +			   reg->u32_max_value;
>> +
>>   	reg->umin_value = max_t(u64, reg->umin_value, new_umin);
>>   	reg->umax_value = min_t(u64, reg->umax_value, new_umax);
>>   	/* u32 -> s64 tightening, u32 range embedded into s64 preserves range validity */
> 
> I think we can move forward with this, as the fate of my RFC is
> uncertain. Please add some selftests, e.g. from [1].

Ack, I'll check the signed case, test against your selftests and 
re-submit the patches.

Thanks again!
Helen

> 
> [1] https://lore.kernel.org/bpf/20260318-cnum-sync-bounds-v1-4-1f2e455ea711@gmail.com/
> [2] https://github.com/eddyz87/cnum-verif/blob/master/cnum.c#L242

