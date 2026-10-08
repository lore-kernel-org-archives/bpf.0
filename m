Received: from mta0.migadu.com (out-156.mta0.migadu.com [91.218.175.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B866E384CE1
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476746; cv=none; b=Cm/DoLr6gmu1e/EMQ4jFvtnGq40hANmMca/L2Jhy3W9smGfS5neMHXiYxpsRxPJ9RPEZkeT0J8NCK/SNQmEAXvuPx7fOF6fyCvwnvyhFlD0kfp2eyuBNKU0pJMKhnQ2vP6XyCRxr4XP2lVhZVkWUk16Nrc0/QdXIylgfrrKOo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476746; c=relaxed/simple;
	bh=ffGNYFCBbGGa3Wx6jWOWR1W1yjnohc36RFEcJ9LsM1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJO4ixIyarz33RnrOVN0Kp1mdkNqXYuXskEfXUbW+Y9hpRxHjdNz82EkWSkbr925XpPyhMd/l7EnIv7UtscvyhrUbnfH2K+MgnT8GxNTkSacZsxmJqIZnlJo157yN3U+7GD3G4wF1IVWa9AepwQDy4JjPQWKci+dUbMqbpoNZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n8S/dmRb; arc=none smtp.client-ip=91.218.175.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n8S/dmRb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ffGNYFCBbGGa3Wx6jWOWR1W1yjnohc36RFEcJ9LsM1k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791476742; v=1; x=1792081542;
 b=n8S/dmRbi7q3kWJ3VU/euh8/9rsR/hd+MQJLPXAnhVzmm3w9EtVADAefoWA5U+HX7xtvjR7b
 QvgfIGSPMlgDtVBYdjm2bDSuLyovMn9L1Ea2YVQ9Jc8FsSO9L6P3lVAy4ighsETnI8vhR0SACaY
 Ucx2tFSdvhev874zBRpluKPE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1d44a88433cb8400;
	Thu, 08 Oct 2026 16:25:37 +0000
X-Mizu-Trace-ID: 1d44a88433cb8400
X-Migadu-Flow: FLOW_OUT
Message-ID: <cd3f0e94-96dc-4164-a10e-94b8a62dbba5@linux.dev>
Date: Thu, 8 Oct 2026 18:25:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 16/23] libbpf: Add cleanup_info to
 bpf_prog_load_opts
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
 <20261008075121.3005539-1-yonghong.song@linux.dev>
 <sashiko-outbox-163808@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-163808@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/8/26 10:12 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: libbpf misaligned cleanup_info read during verifier log retry
> --
>
> commit 44e841423bd633c0b2885ef9ad198f15d3871fba
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Add cleanup_info to bpf_prog_load_opts
>
> This commit adds cleanup_info fields to bpf_prog_load_opts to allow
> callers to pass an exception cleanup table to the kernel during program load.
> The new fields are propagated to union bpf_attr for the BPF_PROG_LOAD syscall.
>
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index b49822d212aed..b4031f62bdee5 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
> [ ... ]
>> @@ -370,6 +370,10 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>>   	attr.fd_array = ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
>>   	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
>>   
>> +	attr.cleanup_info = ptr_to_u64(OPTS_GET(opts, cleanup_info, NULL));
>> +	attr.cleanup_info_rec_size = OPTS_GET(opts, cleanup_info_rec_size, 0);
>> +	attr.cleanup_info_cnt = OPTS_GET(opts, cleanup_info_cnt, 0);
>> +
> [Severity: Medium]
> If the first sys_bpf_prog_load() fails with -E2BIG, the kernel can mutate
> attr.cleanup_info_rec_size to a smaller size.
>
> During the verifier log retry block later in bpf_prog_load():
>
> 	if (log_level == 0 && log_buf) {
> 		...
> 		attr.log_level = 1;
> 		fd = sys_bpf_prog_load(&attr, attr_sz, attempts);
>
> If attr.cleanup_info_rec_size was mutated, the retry uses the smaller size
> while attr.cleanup_info still points to the user's original array with the
> larger stride.
>
> Does this cause the kernel to perform misaligned reads starting from the
> second record and parse garbage exception info?

This is the first time we introduced cleanup_info_rec_size. There is no
need to retry by changing attr.cleanup_info_rec_size. If users have
a bigger cleanup_info_rec_size and causing -E2BIG, it is users' problem.

>
>>   	if (log_level) {
>>   		attr.log_buf = ptr_to_u64(log_buf);
>>   		attr.log_size = log_size;

