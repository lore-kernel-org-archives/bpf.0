Received: from mta1.migadu.com (out-165.mta1.migadu.com [95.215.58.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6412E2BE656
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789849097; cv=none; b=JRhjY2WQtc0/bO7JNC40bS8ZumrjR3XTH8aVVmeK4E8e9v4tturQwbg/aQFJ+K5QQg6dOXooBwLWEJf+ohlluopcma4CGmfNWtS2qeSWLJWw3vfUFWmf2mvMSqeO+boNLQg9KGtBcD17K8OFyjYgeI4MOzQy2FQ3WvAxui7NZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789849097; c=relaxed/simple;
	bh=lJucHcGuLAZsC3uuNEk4X9N1B5r3ZoMMwc468PxnFHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4NAgPBj2t1gf0sIY2DK3SVQjtrkv1GS+PoX/LCzfThHZd5QzJA53+ufJJPGaXTUQIvO/gKoxr3VvnguhgFZqxIOB+NCJPRjJ2eTgeA3D/aiHRHKE0tbERIV5sE5rvm7iv3kHfNccna9TnJd1h7pS8jZZq6qOXLvnmbu5leo3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C5Iup6C3; arc=none smtp.client-ip=95.215.58.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C5Iup6C3"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lJucHcGuLAZsC3uuNEk4X9N1B5r3ZoMMwc468PxnFHc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789849093; v=1; x=1790453893;
 b=C5Iup6C3hohA7w4fZmMmr6eKz+PLHstP+yfUggBQ6MmdpMxmjcWgesO5hKV868k7BTECuwNn
 k0XLREm8Of2LRn9/MyR+0IOxximDssyiB81z/OzR4SN0caJnRwpmNBWjUp6uxe22IlS+igVteH1
 nQ45RY2dS7yGd71Rb1dIreF0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5e1a89ceafcf4eaf;
	Sat, 19 Sep 2026 20:18:13 +0000
X-Mizu-Trace-ID: 5e1a89ceafcf4eaf
X-Migadu-Flow: FLOW_OUT
Message-ID: <2d855468-6fa5-4c68-b752-71647fc57bf4@linux.dev>
Date: Sat, 19 Sep 2026 13:18:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 14/20] libbpf: Add cleanup_info to
 bpf_prog_load_opts
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044311.3291504-1-yonghong.song@linux.dev>
 <20260918045721.2DFA01F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260918045721.2DFA01F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/17/26 9:57 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] libbpf: missing E2BIG fallback for cleanup_info breaks forward compatibility
> --
>
> commit d67b69538e39a329708fcc9fa943f0ad05afaa05
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Add cleanup_info to bpf_prog_load_opts
>
> Let a caller hand the kernel an exception cleanup table. Extend struct
> bpf_prog_load_opts with cleanup_info, cleanup_info_cnt and
> cleanup_info_rec_size, pass them through to BPF_PROG_LOAD, and grow the
> attr size bpf_prog_load() computes to cover the new fields.
>
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 96819c082c772..bcf490570961c 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
> [ ... ]
>> @@ -370,6 +370,10 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>>   	attr.fd_array = ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
>>   	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
>>   
>> +	attr.cleanup_info = ptr_to_u64(OPTS_GET(opts, cleanup_info, NULL));
>> +	attr.cleanup_info_cnt = OPTS_GET(opts, cleanup_info_cnt, 0);
>> +	attr.cleanup_info_rec_size = OPTS_GET(opts, cleanup_info_rec_size, 0);
> [Severity: Medium]
> Will this break forward compatibility for bpf_prog_load() if cleanup_info
> triggers an -E2BIG error?
>
> Later in bpf_prog_load(), there is a retry loop to handle -E2BIG when the
> userspace-provided record size is larger than what the kernel supports:
>
> 	while (errno == E2BIG && (!finfo || !linfo)) {
> 		if (!finfo && attr.func_info_cnt &&
> 		    attr.func_info_rec_size < func_info_rec_size) {
>              /* try with corrected func info records */
>              ...
>
> The loop condition and body don't seem to include checks for cleanup_info.
>
> If the kernel returns -E2BIG because of a larger cleanup_info_rec_size,
> won't this hit the else { break; } block or skip the loop entirely, causing
> the load to fail instead of retrying with truncated records?

This is the first version to support .bpf_cleanup. It is too early to
talk about the future extension for .bpf_cleanup although we do have some
room to grow struct size if needed:
   #define MAX_FUNCINFO_REC_SIZE   252
   #define MAX_CLEANUP_INFO_REC_SIZE       MAX_FUNCINFO_REC_SIZE

>
>> +
>>   	if (log_level) {
>>   		attr.log_buf = ptr_to_u64(log_buf);
>>   		attr.log_size = log_size;

