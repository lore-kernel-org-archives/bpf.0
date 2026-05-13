Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C73E95A8
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669106; cv=none; b=fT2+5cjLqflInSNzt/0nohaan+haO3BUN41g2NZxmKVPHeqKpygLSceNpgmWTK8SDQtrwD3ukUsprMe+0/Cmc/M7BcgvKC4C1H43EIHE6wuAr0xXJXa3YE3zgqNo/ZuGf7Q0zvkrecmHO4uc0Uukcsor2MGNBcziAgrvdGpEdHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669106; c=relaxed/simple;
	bh=mb7xgfwPFf4dXX1t4tYcp5VGHnpyXla+eax8ZaoMbEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYDFzHQhDao9LavZrrYcYqusmDhCpvreA0VCZuBaf0lKUdsWbNRLxiBtqQkvcv+GVHnvh9YPQ8XzJm2QXet+y6h6FY3owHGLMXrUNCTBl15EFm6L2U8yMoexmwhJf2U34OxP7ZhUCTpi0aHfxcg0uvuyoOj/lxi4xGymLYZfWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dL45d4eu; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dL45d4eu"
Message-ID: <4e22ee14-6d49-4eff-83df-cc1e908c17e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778669092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWWzFI4RAJF71dNmeRDb+aiELMv8Xhq9/aQr1qvY9/w=;
	b=dL45d4euVlicjgsPKjwWSSzP+KN37XNA3fmGukC7qK7wsW9fdZffYbd+CE/n6bjmjCWkVK
	WNTvOZhD5cODFcKJiKddX+8/TxLpfjAmCSe+Uns2f27vKyCcE8G/f/j3FP2IcBWIqh8Sts
	AwWfnIcS/TAQld+wFqV2L6yleZnqNOk=
Date: Wed, 13 May 2026 18:44:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 4/8] bpf: Add syscall common attributes
 support for prog_load
Content-Language: en-US
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260511152817.89191-5-leon.hwang@linux.dev>
 <20260512221819.7EA2FC2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260512221819.7EA2FC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/5/26 06:18, sashiko-bot@kernel.org wrote:
[...]
>>  int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
>> -		      u32 offsetof_log_true_size, bpfptr_t uattr)
>> +		      u32 offsetof_log_true_size, bpfptr_t uattr, struct bpf_common_attr *common,
>> +		      bpfptr_t uattr_common, u32 size_common)
>>  {
>> +	char __user *ubuf_common = u64_to_user_ptr(common->log_buf);
>>  	char __user *ubuf = u64_to_user_ptr(log_buf);
>>  
>> +	if (!bpf_verifier_log_attr_valid(common->log_level, ubuf_common, common->log_size) ||
>> +	    !bpf_verifier_log_attr_valid(log_level, ubuf, log_size))
>> +		return -EINVAL;
>> +
>> +	if (ubuf && ubuf_common && (ubuf != ubuf_common || log_size != common->log_size ||
>> +				    log_level != common->log_level))
>> +		return -EINVAL;
> 
> If a user specifies log_level != 0 but leaves log_buf == NULL to probe for
> log_true_size, will these checks bypass conflicts?
> 
> If one side provides a complete tuple and the other provides only log_level,
> or if both provide mismatched log_levels without buffers, it appears the
> conflict checks are skipped and no -EINVAL is returned.
> 

Correct.

However, if users want to probe for log_true_size, they should not
provide common attrs. It is compatible for bpf libraries to probe for
log_true_size using union bpf_attr without providing common attrs.

>> +
>>  	memset(log, 0, sizeof(*log));
>>  	log->ubuf = ubuf;
>>  	log->size = log_size;
>>  	log->level = log_level;
>>  	log->offsetof_true_size = offsetof_log_true_size;
>>  	log->uattr = uattr;
>> +
>> +	if (!ubuf && ubuf_common) {
> 
> Does this condition silently ignore valid common->log_level configurations?
> 
> If the user provides only common->log_level via bpf_common_attr for a log
> size dry-run, ubuf_common evaluates to NULL. The condition here would
> evaluate to false, and common->log_level would be ignored instead of
> applied.
> 

The user should probe for log size using union bpf_attr instead of
common attrs.

> Also, if both specific and common attributes provide identical log
> parameters, the code appears to unconditionally use uattr for the
> log_true_size writeback since ubuf is not NULL.
> 
> If the original uattr uses an older layout without space for log_true_size,
> log->offsetof_true_size will be set to 0. Does this mean log_true_size
> writeback will be lost even if the user provided a modern attr_common
> struct with sufficient space to receive it?
> 

This was intentional.

If the user uses union bpf_attr to receive log, he should provide the
space for log_true_size.

IOW, if the user uses common attrs to receive log, he should provide the
space in common attrs for log_true_size.

Thanks,
Leon

>> +		log->ubuf = ubuf_common;
>> +		log->size = common->log_size;
>> +		log->level = common->log_level;
>> +		log->uattr = uattr_common;
>> +		log->offsetof_true_size = 0;
>> +		if (size_common >= offsetofend(struct bpf_common_attr, log_true_size))
>> +			log->offsetof_true_size = offsetof(struct bpf_common_attr, log_true_size);
>> +	}
>>  	return 0;
>>  }
> 

