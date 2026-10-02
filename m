Received: from mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7B3FCB37
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978953; cv=none; b=aetvsw3UNOHYbVCQYLahOQSp5NrkRVq8lElsB500KiuUpTV2kpI0sszHYSPXvL0cBO7Y6/i728ujxQSNkybHYNcNDEXNNS6t/B/6OUTyX2jr2d+HaNYRFPWUBFnBNUdPcnEnkxYADE52Knu2ePg81x/bt+wXq24tJ3P1A/xyBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978953; c=relaxed/simple;
	bh=lCrM91YSYyv1hK7mWbTZ0/WGnWfhDQh0+G5pNz7vI0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9jNd2CuCy+l0ZYKHue7+PvfkXkSfQ59/ZuHPZbze1paqlQoN/pHbOchn4etQeWg6svSadXJoKm20Ue1PQj6PF78MSmfp583iStWB1eEnh9oigMVpfYwO+uZh2oOzPP6NDbN9izsAOxFVk2P/BXcRrMN+lhp1ExltzqN4iHFWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f79Mw8VR; arc=none smtp.client-ip=95.215.58.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f79Mw8VR"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lCrM91YSYyv1hK7mWbTZ0/WGnWfhDQh0+G5pNz7vI0E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790978949; v=1; x=1791583749;
 b=f79Mw8VRmfz1bl2x/xe7X9BZs3IMz5kBLimu8y7FwYLBX53TokMGbc5bmLzZr2YpZPE+8Syw
 xmgAePCVWxm+s484xs47JHMxWJfIKWeUKlV4kRK6sHeuWTAABguxZJTGgWGDwbTkxk33RVHVa3Q
 691IWplzA9HAlNSgKYxCuX9k=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9d2928c1e37d3bed;
	Fri, 02 Oct 2026 22:09:08 +0000
X-Mizu-Trace-ID: 9d2928c1e37d3bed
X-Migadu-Flow: FLOW_OUT
Message-ID: <b44147cd-cec9-4416-b622-24c05c2ba785@linux.dev>
Date: Fri, 2 Oct 2026 23:09:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 15/22] libbpf: Add cleanup_info to
 bpf_prog_load_opts
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133125.1344001-1-yonghong.song@linux.dev>
 <20261001134623.B9A071F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20261001134623.B9A071F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/26 6:46 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: ABI breakage due to reuse of padding in bpf_prog_load_opts
> --
>
> commit 71e2541e0b207ab646c97a6cfe861ce9bf16fe7f
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Add cleanup_info to bpf_prog_load_opts
>
> This commit introduces an exception cleanup table to the bpf_prog_load
> options. It adds cleanup_info_cnt, cleanup_info, and cleanup_info_rec_size
> to struct bpf_prog_load_opts and propagates them to the kernel in
> bpf_prog_load.
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
> [Severity: High]
> Does this OPTS_GET macro read uninitialized padding from older applications?
> When an application compiled against an older version of libbpf passes its
> opts structure here, the sz field will be set to the old struct size.
>
> If the old struct had padding at the end that the new structure replaces
> with cleanup_info_cnt, OPTS_GET might think the field is present because
> the sz value includes the padding, causing it to read stack garbage.
>
>>   	if (log_level) {
>>   		attr.log_buf = ptr_to_u64(log_buf);
>>   		attr.log_size = log_size;
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 826d9cc9ab65d..cbe56ddc8cf7d 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
> [ ... ]
>> @@ -128,9 +128,14 @@ struct bpf_prog_load_opts {
>>   
>>   	/* if set, provides the length of fd_array */
>>   	__u32 fd_array_cnt;
>> +
>> +	/* exception cleanup table, from the .bpf_cleanup section */
>> +	__u32 cleanup_info_cnt;
> [Severity: High]
> Does placing cleanup_info_cnt immediately after fd_array_cnt break the
> size-based backward compatibility check?
>
> Because fd_array_cnt is a 4-byte field, the struct bpf_prog_load_opts in
> older applications likely contained a 4-byte padding hole at the end to
> align with the 8-byte size_t type.
>
> An older application would pass an opts structure where sz includes those 4
> bytes of padding. Because OPTS_HAS evaluates if sz >=
> offsetofend(struct bpf_prog_load_opts, cleanup_info_cnt), it will evaluate
> to true. The library will then read the uninitialized padding left by the
> older application as the cleanup_info_cnt value.
>
> If the padding contains garbage, the kernel could reject the program load
> or fail unexpectedly. Could this be resolved by placing cleanup_info_cnt
> after the pointer, or by introducing explicit padding?
>
>> +	const void *cleanup_info;
>> +	__u32 cleanup_info_rec_size;
>>   	size_t :0;

I think the current implementation is okay. IIUC, 'size_t :0' will ensure
to filling '0''s for tailing unnamed fields.

