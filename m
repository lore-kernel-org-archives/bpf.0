Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381B3B6BE8
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024544; cv=none; b=IbthviQdiiwHJuC7AMvXpRqoly3R88MFGkaA50+hEQI9XO26aC3J7spwpn0chA1YIAxayEmQ899JdN9lsJ5KOPLSEkGao5oA4Om+Sr7Iv33tBdkwnoOeRee2Xv7lQd7Pi67jtbhTezIu/T8ub4RFgZV74zOls7cDu9CyMi1V+yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024544; c=relaxed/simple;
	bh=cNdsAI7Z5D7KsKcEyB+EW7DpMSbpeItLfIJp3ChdbcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULs1jJ5K+YJa8EtVsEsqsRTbj87EQjoRk/mJ869MOH7mcLKAWJCa/FKm9b0ZWDTqJ71EZ/szHgrU4HxVBLl5QciGLJgSg+w/ZwGP6OsG8iC75W8u+yQq/9hBupBTxCAMXgQbPj2tYFMsOiZi0I2XssTJNlLw+I5LS+9o+aepflI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v2OeLYRX; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v2OeLYRX"
Message-ID: <7f5e6242-c5f4-4238-95cb-7bc24d5e1b9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781024526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFwcyz1tM8wZUAwOLgquJfIAbvVblL8BdNmlIMOE2tc=;
	b=v2OeLYRXn63F+QG7UMybyt0ZQBDYedpvFKmBM3P8JQHceyPA0nkZFj1AaBlL4zOnMDJLlB
	vRZms+buV2RcbAvRWDaKXGrcDDLODtruFNTLppoka+2IJ+UX6qMxUMYz9tVTDQvIUKm6xK
	yPQednr0XiABfKqC9T8ObK5FlccIZVw=
Date: Tue, 9 Jun 2026 10:02:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Keep int return type for
 tailcall subprogs with maps
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260609163952.1718472-1-yonghong.song@linux.dev>
 <20260609164816.DB3821F00898@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260609164816.DB3821F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/9/26 9:48 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The BPF array map `array` defines its value type as `__u64` (8 bytes), but the code passes pointers to local `int` variables (4 bytes) as the map value to `bpf_map_update_elem()`. This causes an out-of-bounds stack read by the BPF helper, leading to either BPF verifier rejection or incorrect map state.
> --
>
> commit 638a9e186d9da40d2e394848eda6a546f07a86fd
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Keep int return type for tailcall subprogs with maps
>
> This commit prevents LLVM23 from changing the caller's return type in BPF
> tailcalls by using a barrier_var. It also switches to using an Array map to
> store subprog return values to preserve test results.
>
> Link: https://github.com/llvm/llvm-project/pull/198426
>
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
>> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
>> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
> [ ... ]
>
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARRAY);
>> +	__uint(max_entries, 2);
>> +	__type(key, int);
>> +	__type(value, __u64);
>> +} array SEC(".maps");

> [ ... ]
>
>>   SEC("tc")
>>   int entry(struct __sk_buff *skb)
>>   {
>> -	int ret = 1;
>> +	int ret = 1, ret1, ret2, key1 = 0, key2 = 1;
>>   
>>   	clobber_regs_stack();
>>   
>>   	count++;
>> -	subprog_tail(skb);
>> -	subprog_tail(skb);
>> +	ret1 = subprog_tail(skb);
>> +	ret2 = subprog_tail(skb);
>> +
>> +	bpf_map_update_elem(&array, &key1, &ret1, 0);
>> +	bpf_map_update_elem(&array, &key2, &ret2, 0);
> [Severity: Medium]
> Will the BPF verifier reject these bpf_map_update_elem() calls, or
> will they read out-of-bounds on the stack?
>
> The array map defines its value size as __u64 (8 bytes), but ret1 and
> ret2 are declared as 32-bit int variables (4 bytes). When passed into
> bpf_map_update_elem(), the helper will read 8 bytes starting from the
> pointers to the 4-byte integers, potentially reading uninitialized
> adjacent stack memory.

Good point. I should do __type(value, int) instead of __type(value, __u64).
Will fix in the next revision.

>
>>   
>>   	return ret;
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
>> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
>> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
> [ ... ]
>
>> +struct {
>> +        __uint(type, BPF_MAP_TYPE_ARRAY);
>> +        __uint(max_entries, 2);
>> +        __type(key, int);
>> +        __type(value, __u64);
>> +} array SEC(".maps");
> [ ... ]
>
>>   SEC("fentry/dummy")
>>   int BPF_PROG(fentry, struct sk_buff *skb)
>>   {
>> +	int key1 = 0, key2 = 1, ret1, ret2;
>> +
>>   	clobber_regs_stack();
>>   
>>   	count++;
>> -	subprog_tail(ctx);
>> -	subprog_tail(ctx);
>> +	ret1 = subprog_tail(ctx);
>> +	ret2 = subprog_tail(ctx);
>> +	bpf_map_update_elem(&array, &key1, &ret1, 0);
>> +	bpf_map_update_elem(&array, &key2, &ret2, 0);
> [Severity: Medium]
> Are ret1 and ret2 causing the same 4-byte stack read for an 8-byte map value
> here in the fentry program?

The same as above. The value type in the map should be just 'int'.

>
>>   
>>   	return 0;
>>   }

