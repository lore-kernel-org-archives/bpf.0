Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DA29D264
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539818; cv=none; b=krxAoNlIhYG3qRrPSNUb4+WanaVAg9Zxqi7PxUJ00+E0lXtysPKvrJ2rrkijKH4DC++6l92zmWirtYRCpu3YWkGLyMCHNS0Ur7hGGjfC+T7Fb1t88LFFVDwsBhXGTbyS8TsTUr7cMJiy3I4aInbX/XXERIAhDNF0VcvhDsivGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539818; c=relaxed/simple;
	bh=QG7vPbkyoq7VlC1qwYsactQbnLDbsH5yklFMqCbrvIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKLYmWmzTEf5t+DpBEESTKLuYRky/ygJ/EtWfL3FCx22Pzt7M177fk2mBhWxIdjN2HaIbG/6tsSgDM0/jpu9UVclWYL2y8G0bCDcBYiUsXR4zjAiwP0w4UK1WhLQ8sRu0rLRMbNxNUT5YB+tdocGOg75otOHZ70Bohz210nNKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iymTNiKZ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iymTNiKZ"
Message-ID: <802f6e4f-8cf4-4437-8035-d9a5c02cac97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780539814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoY78+x+SH2QoAJCHHmcdAiYEbylwJaqt/cNFDwcfKQ=;
	b=iymTNiKZHtVy5+R952b7XmD8OqJAUo6ar9tqvtC6l8J+BkMeoFyR1zx0Au1XfuCIIf3e44
	qJVNto+J3vxmsDNbO1Kn7JHjnQyxDXKH0drKkE1PeO+kWRTgTc5mOOlDn41EvAZe4UbI/f
	uUFdu+zAj+A8N0d2h9QPBQfWLfekdPw=
Date: Thu, 4 Jun 2026 10:23:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Check tail zero of bpf_prog_info
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260603144518.67065-3-leon.hwang@linux.dev>
 <20260603151405.6DB111F00893@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260603151405.6DB111F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/6/26 23:14, sashiko-bot@kernel.org wrote:
[...]
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 1007fb7c87e91..0c86a70d31c17 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -5115,10 +5115,11 @@ static int bpf_prog_get_info_by_fd(struct file *file,
>>  	u32 info_len = attr->info.info_len;
>>  	struct bpf_prog_kstats stats;
>>  	char __user *uinsns;
>> -	u32 ulen;
>> +	u32 ulen, len;
>>  	int err;
>>  
>> -	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
>> +	len = offsetofend(struct bpf_prog_info, attach_btf_id);
>> +	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), len, info_len);
> 
> [Severity: Critical]
> Does this change break the ABI for existing deployed binaries?
> 
> Previously, expected_size was 232 (sizeof(info)). If an existing binary
> passes info_len = 232 with uninitialized stack garbage in the 4-byte
> padding, bpf_check_uarg_tail_zero() would see actual_size <= expected_size
> (232 <= 232) and immediately return 0.
> 
> By reducing expected_size to 228, actual_size > expected_size (232 > 228),
> so bpf_check_uarg_tail_zero() will actively check the 4 padding bytes and
> return -E2BIG if they contain garbage. This rejects previously working
> applications.
> 
> Additionally, does this actually protect against the stated future issue?
> 
> If a future kernel adds a new 4-byte field, the struct size stays 232, and
> the new kernel's expected_size will be 232. At that point, those old buggy
> binaries passing info_len = 232 will once again hit the fast path
> (actual_size <= expected_size), skipping the check and allowing the
> uninitialized padding to be consumed as the new field.
> 
For this case, forward compatibility is more important than backward
compatibility. Thereafter, those old buggy binaries should fix
themselves instead.

Thanks,
Leon

