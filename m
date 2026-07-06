Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78DD1E32CF
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341876; cv=none; b=UQfo9yRkpcGND7Q/NNcm3BTrgZ0vD4xXyAq0Y/uYUPO68EKomiRBI5TdLQPDDSbw9wpVa8gLl03of5Ny1bGy0T6c/yDJf9Tp/ChANeUB8h8ilfIKkpCJTiDTZVaqWf+1tnGqkRIdaL1X4KjPPv8hsHqMd7zw6Viq8hFznk7vkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341876; c=relaxed/simple;
	bh=A6J3qZ1+JzJgiX28rP9twI3tGY+ys//pbkUnyVWTm5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIfCI+BbiJMWmxs5FDFi8l8h+qwW0P2y+0IluQEit1DgPkDZWVRtStBWNQiTR1yXJoVma4jp3pbkPjrugDiLofSquLCBlM3/Uai0lcH66PmxX+MGAK5pJv6/WWrbqOMXBsro7e93PfusadMNNkJR7E+oRArpvBrGDBcKtYidruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aRBLG77y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BR4YPo6+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRBLG77y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BR4YPo6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783341872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSNzVEuRNXjbACmsP0kXVdabmw9oRqyKD7jVej0sPKA=;
	b=aRBLG77yphMs69lu94k4pleNv1TGkuRFU8crHdCus+4BXGHqNRRiNRracye0pwRHjRWmwP
	dMkWpWp4tKV4Lu2yyHQ8A+qzkFyyXQ5gjl/GVkK0TPAV9jpQYO5x3dBd/KUWI9Dr+Gj6gl
	foyItOKS+dtcqPNmuFDjVVaNubOyvVQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-Sg-mTOhpP5GfC_HNSAsNdA-1; Mon, 06 Jul 2026 08:44:31 -0400
X-MC-Unique: Sg-mTOhpP5GfC_HNSAsNdA-1
X-Mimecast-MFC-AGG-ID: Sg-mTOhpP5GfC_HNSAsNdA_1783341870
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4744b72f90bso1841512f8f.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783341870; x=1783946670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSNzVEuRNXjbACmsP0kXVdabmw9oRqyKD7jVej0sPKA=;
        b=BR4YPo6+9EbYOU8X2ywICAI6hx+uwldn9bSioEJ/+61v1WeDNzBERfeN8gCUXIVj5i
         lzs58AgRZHBiUnJr6GkfWkLuRnf3xlflK1R2TSs2j3GRrrcTo16kYm+wDl6UvmG8lL/i
         HVmBZ3oVH013Uvhot1u8kQEhdgkGG1J037fzjMrlK7ATWOy22Cm+j7cpDFybo4YV4jv+
         E5FC9WUDH5zfFfmJD15Dt0m3jnKyhAaZfI5mxR+qTiB5Ns+tDR8TJyOBHeyE1MeToT2q
         z97jw41WUzJlIe8TTdly2Po1lvD5BdD1BG0X58wh/sUNht1gEnZXV6m3laD8nzKv+I2W
         EJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341870; x=1783946670;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSNzVEuRNXjbACmsP0kXVdabmw9oRqyKD7jVej0sPKA=;
        b=SDDNas8y0VIS7Xoje4gD/ZtIlXbCeC1BXWNAhNZ8CMsQUO2kdfgB4qPbDs6L4ErvIm
         2G883qdczAi1v7MCmdjuRBoA8FDrsywJapQvMrxBcEJdsTNpJx0epD/x8TEFdW2DIe1V
         pvk8HDjOAD9jz9fWZ/5Etp7vEBZuE85S0w7dJj49AvcqTqG0cGSWFEN7I/Bv5rPW63eb
         QvXsag3pWK7TCDHBTzd+j9XNeRX8GOKZJ4HUhZNEx0IekhglDAKtcuiHYYmpUPImVP6A
         HquEfds6adaBfuJfyKByZ4kdConH90vM1VhDIb3aof9/OjlSS3+kE1xN4n/a5gdrZONp
         U5kg==
X-Gm-Message-State: AOJu0YyFUovT3EIuY+YkH7+dQ8CZbN6Mpwvr6XJbVrQ/iK4a5kc0CYFW
	oNpiQ29TRSgZ3R/L0ML438zYVZkV53DcksfBvtde+aSIL1RPnozggx9tseHJ2mxx8aYDnOdB+d8
	Xad1FS7sgxKFPS7M1rpvA6cFFGKJVvrcXV15nSrdgBGRAAg1UZxLG
X-Gm-Gg: AfdE7cnt1nPm1Scd1vfu3aVI/Vj6p5SzkUSS2vG3CNYs7pPWB//lu/GcSqt3gEurL5i
	wDs3fhhEneXH+0wE9oDV7frr6bpRWPPAwHskSFy1u1KkTwFFTOmSVfZuYe0/Gy+C+7J35BdRya7
	qqX0/WEXQ76848sCUs6uZPmPoa7AlZCDbXApSK2G+TXAq1T4RrP/WvEJFoeVxbr+UxPuvf322mp
	6MdWL6z9qdQg5Ei5VcRm6uQYBwj8VCyPIGNMqMKnvZVBE+btIxP6xjfDFPTbO1igyUdf14Wjtxa
	R1hcGiCC6WJFB/HftFKnHv0XitxXz7DLpivx/sJWew+POAixKd7G0ozKA52sr43H+Q7WpGfc6Rf
	NyebABC4O1LHTx0NR6KxtmgMYiCi0JiL+tG/DvxamGbc2rA==
X-Received: by 2002:a05:600c:5297:b0:493:d1e0:a4f1 with SMTP id 5b1f17b1804b1-493deffbf21mr4834405e9.0.1783341869852;
        Mon, 06 Jul 2026 05:44:29 -0700 (PDT)
X-Received: by 2002:a05:600c:5297:b0:493:d1e0:a4f1 with SMTP id 5b1f17b1804b1-493deffbf21mr4834055e9.0.1783341869459;
        Mon, 06 Jul 2026 05:44:29 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdb62d3sm303300755e9.8.2026.07.06.05.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 05:44:28 -0700 (PDT)
Message-ID: <c0a3c830-0b28-47a9-96ee-c0a0f34490eb@redhat.com>
Date: Mon, 6 Jul 2026 14:44:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] perf trace: Refactor augmented_raw_syscalls using
 bpf_for
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <cover.1783339165.git.vmalik@redhat.com>
 <fdf56026e442e44b2374119c21babde4910f3b6e.1783339165.git.vmalik@redhat.com>
 <20260706121432.8F39A1F00A3A@smtp.kernel.org>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260706121432.8F39A1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/26 14:14, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The fallback standard `for` loop will fail to load with `-E2BIG` on older kernels when compiled with Clang 15-18, breaking backward compatibility.
> --
> 
> commit be9035b8b528902be67522e81fa232a2f597b164
> Author: Viktor Malik <vmalik@redhat.com>
> 
> perf trace: Refactor augmented_raw_syscalls using bpf_for
> 
> The commit replaces the standard `for` loop in `augment_sys_enter()` with
> `bpf_for` to fix BPF verifier `-E2BIG` errors on newer Clang versions. It
> drops artificial verifier workarounds in `augment_arg()` that were previously
> added to fix these errors. A fallback standard `for` loop is kept for backward
> compatibility with older kernels lacking `bpf_for`.
> 
>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> index bc036a348079d..215516df5d2a3 100644
>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> @@ -440,10 +442,11 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>>   */
>>  static inline int augment_arg(struct syscall_enter_args *args, int i,
>>  			      unsigned int *beauty_map,
>> -			      struct augmented_arg *payload_offset)
>> +			      struct beauty_payload_enter *payload, u64 offset)
>>  {
>> -	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>> -	s64 aug_size, size;
>> +	int index, size, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>> +	struct augmented_arg *payload_offset;
>> +	s64 aug_size;
> 
> [ ... ]
> 
>> -	} else if ((int)size < 0 && size >= -6) { /* buffer */
>> +	} else if (size < 0 && size >= -6) { /* buffer */
> 
> [ ... ]
> 
>> @@ -522,14 +529,30 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>> 	/* copy the sys_enter header, which has the syscall_nr */
>> 	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
>>  
>> -	for (int i = 0; i < 6; i++) {
>> -		written = augment_arg(args, i, beauty_map, (struct augmented_arg *)payload_offset);
>> -		if (written < 0)
>> -			return 1;
>> -		if (written > 0) {
>> -			output += written;
>> -			payload_offset += written;
>> -			do_output = true;
>> +	if (bpf_ksym_exists(bpf_iter_num_new)) {
>> +		bpf_for(i, 0, 6) {
> 
> [ ... ]
> 
>> +	} else {
>> +		for (i = 0; i < 6; i++) {
>> +			written = augment_arg(args, i, beauty_map, payload, output);
> 
> [Severity: Medium]
> Will this fallback standard `for` loop fail to load with `-E2BIG` on older
> kernels when compiled with Clang 15-18?
> 
> Since the `(int)size < 0` cast and `s64 size` verifier workarounds were removed
> from `augment_arg()`, it appears the unrolled loop in this fallback path will
> once again fail the BPF verifier checks when evaluated on kernels older than
> 6.4 (where `bpf_ksym_exists(bpf_iter_num_new)` is false). Could this break
> backward compatibility for `perf trace` on those older kernels?

Oh, right, I guess we need that combination to remain backwards
compatible, too. I'll keep the hack in place, then.

Viktor

> 
>> +			if (written < 0)
>> +				return 1;
>> +			if (written > 0) {
>> +				output += written;
>> +				do_output = true;
>> +			}
>>  		}
>>  	}
> 

