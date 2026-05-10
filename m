Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C63B27F6
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433363; cv=none; b=RdEC0bCb9f6GLxihG2NaeMu0sImm+aArbQvZ73q5zGfsOgWCWZnNeNljyl7FeQoTdOB2VqvD59RwwuIZ2vrlZtKXyyAeOXn92RvwAGBmbahX7tm5zxUs5uMXwtb3rvcJ3MKkL47a9p11Mnx67fyOChEQE+ghdSXu1a2wI8IxXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433363; c=relaxed/simple;
	bh=ydE6slL0rNtI0woQOn8EhM8z5H/YgKQSf7CgYI91E38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqceuBnxLaKJD18J9E4odcGC9I2Ek1eShq1h1tQ2WMpynXSRQIGSeCZ+Kbft5r8HAOcKNgblxXxP8TsueCr446CT8f9A16+LZO3Vxfy7kpswASNJcjUG17Yk/ZozPRjtcv7fmrcNB3eMQeuFUqu1EJcuE3cfStvSkgNrERFdrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JAU2/Q3w; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JAU2/Q3w"
Message-ID: <d430f932-fe1b-42e9-b7cd-d0462c64b296@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778433349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbFLptN+0f4PkcdXgPLEb5th7lhard7hj7hATorjDFk=;
	b=JAU2/Q3wnK7Du4dKwKqxcw1qX3BwdmJMR4CXjeNTqQmpd6evQIWWmB0XHAm1TqD6wtlz5+
	kwbQuHKo62ygdi/73Ueg3OI5e8ktrzOYowOHyKQoX09xDzIQIGvQXyQquSR8HSEs0bYeoM
	laJgz0W9XFobRiWKcSyZH1IlnEXmgVY=
Date: Sun, 10 May 2026 10:15:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 14/23] bpf: Reject stack arguments if tail
 call reachable
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260507213054.1131645-1-yonghong.song@linux.dev>
 <20260509014207.A6D2DC2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260509014207.A6D2DC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/9/26 3:42 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Order-dependent DFS logic and incomplete fallback checks allow bypassing the stack arguments restriction and cause false rejections.
> --
>
> commit d6cf15a73bfea82a8d40934257b79e361027a9b1
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Reject stack arguments if tail call reachable
>
> Tail calls are deprecated and will be replaced by indirect calls
> in the future. Reject programs that combine tail calls with stack
> arguments rather than adding complexity for a deprecated feature.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b6d07f7a52cdf..95fe21d05c100 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -5270,14 +5275,23 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>   	 * this info will be utilized by JIT so that we will be preserving the
>>   	 * tail call counter throughout bpf2bpf calls combined with tailcalls
>>   	 */
>> -	if (tail_call_reachable)
>> +	if (tail_call_reachable) {
>>   		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
>>   			if (subprog[tmp].is_exception_cb) {
>>   				verbose(env, "cannot tail call within exception cb\n");
>>   				return -EINVAL;
>>   			}
>> +			if (subprog_has_stack_args(&subprog[tmp])) {
>> +				verbose(env, "tail_calls are not allowed in programs with stack args\n");
>> +				return -EINVAL;
>> +			}
> Does this create an order dependence where the verifier might falsely reject
> valid programs?
>
> If the main program calls a subprogram with a tail call, the
> tail_call_reachable flag becomes true. If the main program subsequently calls
> an independent subprogram that uses stack arguments, the flag can leak into
> that branch, causing the program to be rejected. Would reversing the call
> order cause the same program to pass?

The requirement here is that if any subprog has both tail_call_reachable
and > 5 arguments, we should reject this bpf program. So ordering issue
does not really matter here.

>
>>   			subprog[tmp].tail_call_reachable = true;
>>   		}
>> +	} else if (!idx && subprog[0].has_tail_call && subprog_has_stack_args(&subprog[0])) {
>> +		verbose(env, "tail_calls are not allowed in programs with stack args\n");
>> +		return -EINVAL;
>> +	}
> Does this fallback check miss nested stack arguments?
>
> If the main program directly contains a tail call, the tail_call_reachable
> variable remains false. If it then calls a wrapper function that passes >5
> arguments to another subprogram, won't the nested stack arguments be missed
> because the fallback only checks subprog[0]?
>
> Can this also bypass restrictions for callback roots?
>
> Since the fallback hardcodes !idx and subprog[0], if an exception callback
> (which is verified with idx > 0) contains a direct tail call and uses outgoing
> stack arguments, it bypasses the main check loop because tail_call_reachable
> is false. Will it also bypass this fallback block because !idx is false?
>
> Could we decouple this restriction from the call graph traversal and globally
> check env->subprog_info for the presence of both features in the program
> instead?

Again, see the above cretiria.

