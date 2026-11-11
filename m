Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411137;
	b=EP34Tsw9Z4Y7iu3aUNsf9llMSmW8I4CsvjPcG0bQj4gV4kKqpCHqMyXeLBnml3MmLVka
	 0atcmmpNX695PAn20jYBKPKXrntCwkpSlJSOIOmm7T5q+AY9pBQARrr4wiDQGeLGjsLQu
	 1ZSi22HjgVQTXWWcr8jHBS5HbJ/WgQaG8PakkDqjspujFE6MQymxc/5vpG6l8bDKk5PYv
	 OJkiKmFVLcKktXR8HoUhqckHGq6h2i7cwOdjMMFiCfsefRH8PjozQ9d6bJsRjelTnNryz
	 jACDcBG3dBcAGD5bWAaxIAT4HlmnkPOYasPLyY4v3rXfzDsICUjeQTvDPjaiYAgGFZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411137;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=3V+m0lHRYCGoAKQSowYBsC0G4rGRJb6ZqIoJs29bl7k=;
	b=4JVeOBba7xwFa5rXD/VqdeylpMuY5joIe2JPcWpyPiFV5/a7r0XmZULdIrApzt6BO87l
	 NRuu+eYv0UKJm0Ukb1u/9Bmkam6RK85oNpzMbbZIjQhKNppQ8i6zlL1xmK7ervbavCyN9
	 iHzoWNaiT9z+RVg4HcZH0CTnvGSK+NvIyRIO7+26htQZ9gfk0uhY3Hs/Gw4JPtzfqrlcE
	 3gU5/gFjSUocT7rbcn7DM9oP2fEj4+//XZXkreZa1T9AkU26H69SP+YFgO7dluhibv2/U
	 wIiVFMeV7cknvcmbIyZPgagTBRWQ6OQjWyKj3jJmHY51o06sp4USLHZkFSvAXTL3Q5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="uy/BQTuH";
	arc=none smtp.remote-ip=91.218.175.11
Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ADC606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8ADC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uy/BQTuH
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kIVasq+kbRO5M1l3P8L45IfXEI+1KoQRMMmYUB4tDUA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794411134; v=1; x=1795015934;
 b=uy/BQTuH1p1ATdCj2A8VhzZehT9qYzVNonM57K+p4inGNTVaQXmtsBPYRVvzgSAHCZn9Qf4C
 gfVtHwbMv9QYaCCFTcMNN290d85usZMRWU4MacWAZ9/LLJFRU97vdQ0p3b+fq7FcKmTP/pmGuG5
 lYZtmUmmXj+DAmK2Q0OUwJaE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 04a8524071039322;
	Wed, 11 Nov 2026 15:32:14 +0000
X-Mizu-Trace-ID: 04a8524071039322
X-Migadu-Flow: FLOW_OUT
Message-ID: <b7d1f4cf-7488-4fe7-a8c2-280dd8e49dd1@linux.dev>
Date: Wed, 11 Nov 2026 23:32:10 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/9] bpf: Add log support for iter link_create
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
References: <20261109140816.5196-1-leon.hwang@linux.dev>
 <20261109140816.5196-4-leon.hwang@linux.dev>
 <sashiko-outbox-205082@kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <sashiko-outbox-205082@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/9 22:22, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] bpf: misattributed iter_info error log messages in
>   bpf_iter_link_attach()
> --
> 
> commit d8f64c129a2738b81f1bf280ca7bbad040d70081
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> bpf: Add log support for iter link_create
> 
> This commit passes the verifier log to bpf_iter_link_attach() and logs
> diagnostic messages when BPF_LINK_CREATE fails for iterator programs.
> 
>> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
>> index f0b29a1709357..dfefa5579e033 100644
>> --- a/kernel/bpf/bpf_iter.c
>> +++ b/kernel/bpf/bpf_iter.c
> [ ... ]
>> @@ -538,24 +539,36 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
> [ ... ]
>>  	if (!bpfptr_is_null(ulinfo)) {
>>  		err = bpf_check_uarg_tail_zero(ulinfo, sizeof(linfo),
>>  					       linfo_len);
>> -		if (err)
>> +		if (err) {
>> +			bpf_log(log, "Invalid iter_info.\n");
>>  			return err;
>> +		}
>>  		linfo_len = min_t(u32, linfo_len, sizeof(linfo));
>> -		if (copy_from_bpfptr(&linfo, ulinfo, linfo_len))
>> +		if (copy_from_bpfptr(&linfo, ulinfo, linfo_len)) {
>> +			bpf_log(log, "Invalid iter_info_len.\n");
>>  			return -EFAULT;
>> +		}
>>  	}
> 
> [Severity: Low]
> Are the log messages for iter_info and iter_info_len swapped or
> misattributed here?
> 
> By the time copy_from_bpfptr() runs, linfo_len has already been clamped to
> sizeof(linfo), so copy_from_bpfptr() only fails when reading from the
> ulinfo pointer (attr->link_create.iter_info) faults, yet it logs "Invalid
> iter_info_len.".  Conversely, bpf_check_uarg_tail_zero() rejects linfo_len
> values larger than PAGE_SIZE with -E2BIG without touching ulinfo, which
> logs "Invalid iter_info.".
> 

Sounds reasonable to me, will swap them in the next revision.

Thanks,
Leon

