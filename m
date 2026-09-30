Received: from mta1.migadu.com (out-223.mta1.migadu.com [95.215.58.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4E24293C
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731097; cv=none; b=ToYTyL+xxn2mnuZWkxo9y8dlhmTllN8NRs4u2TUmbHy+uA/1Z1SU0yLhr9rEgbdGLggriVcSds7L9qPSEyGZ4uBzB1WUyO2RxW4ybiyhUoWiLzZoXVMU0Cw1goeJCWBXEKBplHizos/lCp/I22EHXCkSzw9oUVcZLOL7qepqZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731097; c=relaxed/simple;
	bh=8dcmcOKMI2QBj1U7MAwq3Q1E9AxcGC47qpUvOgRf+00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJ9+yfTplWgf9pRcz7foDQ5oOPF2du10pfC5r77AWlHGIP1XSfpq7EekzpFkh2sibCnygCMFcG7qGwT2kqd/hi4GXXxbFNrsqmXqWCmRgciOcqx9P4HQv4C0D/MOse4k5M86Ft0+60CevNVjTtrkXss/ciVm5O+FoeFFgUqwQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EE9mE6yj; arc=none smtp.client-ip=95.215.58.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EE9mE6yj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8dcmcOKMI2QBj1U7MAwq3Q1E9AxcGC47qpUvOgRf+00=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790731093; v=1; x=1791335893;
 b=EE9mE6yj5XM4LT2X7p5whCcOEtJtaHeUL2JDYSaMn4ys3K6rJKKfk7BCsowSWlss9Gp5VEPh
 h/khGiKaD/A+YFVYMJfAOh73g1KupeqrcRCn9+ESRyXhf6iTpmA9mhshkl5hy04qLZYiTzUmnqV
 AjuzaMMVlaJF90fRV8TKpeQ4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4fa29fd6c1ba2c13;
	Wed, 30 Sep 2026 01:18:13 +0000
X-Mizu-Trace-ID: 4fa29fd6c1ba2c13
X-Migadu-Flow: FLOW_OUT
Message-ID: <c058f6de-1454-4ee3-8c49-92cbff873f7c@linux.dev>
Date: Tue, 29 Sep 2026 18:18:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 11/22] bpf: Dispatch cleanup pads by rewriting
 return addresses
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260929001658.3251019-1-yonghong.song@linux.dev>
 <97e6da4cbbd16c8938762c0c0cb2044b1ff910eb53cb6ed54864b46773c65eb7@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <97e6da4cbbd16c8938762c0c0cb2044b1ff910eb53cb6ed54864b46773c65eb7@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/28/26 6:14 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 5b7fe4ba610b..bff9d2539371 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#include <linux/bitmap.h>
> This isn't a bug, but is <linux/bitmap.h> needed? No bitmap API appears
> in the file.

Thanks. Will remove.

> [ ... ]
>
>> @@ -1286,6 +1309,61 @@ static int resolve_func_ptrs(struct bpf_verifier_env *env)
>>   	return 0;
>>   }
>>
>> +static int exc_info_for_subprog(struct bpf_verifier_env *env, struct bpf_prog *sub,
>> +				u32 subprog, u32 start, u32 end)
>> +{
>> +	struct bpf_cleanup_info *recs;
>> +	u32 i, cnt = 0;
>> +	int err;
>> +
>> +	if (!env->cleanup_info_cnt)
>> +		return 0;
>> +
>> +	err = bpf_exc_alloc_info(sub->aux);
>> +	if (err)
>> +		return err;
>> +
>> +	for (i = start; i < end; i++) {
>> +		if (env->insn_aux_data[i].cleanup_pad)
>> +			cnt++;
>> +	}
>> +	if (!cnt)
>> +		return 0;
>> +
>> +	recs = kvmalloc_array(cnt, sizeof(*recs), GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>> +	if (!recs)
>> +		return -ENOMEM;
>> +
>> +	for (i = start, cnt = 0; i < end; i++) {
>> +		u32 pad = env->insn_aux_data[i].cleanup_pad;
>> +
>> +		if (!pad)
>> +			continue;
>> +		pad--;
>> +		if (verifier_bug_if(pad < start || pad >= end, env,
>> +				    "insn %u is covered by a landing pad at %u outside its subprog [%u, %u)",
>> +				    i, pad, start, end)) {
>> +			kvfree(recs);
>> +			return -EFAULT;
>> +		}
>> +		recs[cnt].begin_off = i - start;
>> +		recs[cnt].end_off = i - start + 1;
>> +		recs[cnt].landing_pad_off = pad - start;
>> +		cnt++;
>> +	}
>> +	err = bpf_exc_attach_info(sub->aux, recs, cnt);
>> +	if (err)
>> +		return err;
>> +	return 0;
>> +}
> This isn't a bug, but is the subprog parameter meant to be used? The
> function body uses only start and end, yet both callers pass a value for
> it.

Will remove unused 'subprog' parameter.


