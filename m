Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B6126C03
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622884; cv=none; b=XqediED6QvStK7CO9bvZnR2hfwS23rqqRGVWY4rBP6wxJ2yYPhCl3XhKhdMFnrJ1ydAHOgbZtDcU7Fo5GPjrMqmnWuOAxchviaPGGIcGY6aJ6zjA74/HgiaUyaY3LJ43eeSum1+T8U4QwdTcKhETCLcJUBaQqwhPtVdUKJDvazQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622884; c=relaxed/simple;
	bh=0d7OQd+D+14S3n20s6xWwnZr1Wxu/zgb1Z+HXT4TST4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jC3LokJ+cCONB6bSb399pfq3CevtnTQBRGulf9ItSBKEKLQtjT7Lv4L+LmwM94Avg8BJfPC17jtAK6pWnYV74U6fSK2mb1TxpMkm2f8Trr1H8Q9x4xQI716Zo8ncCv/WzqyM9P6q612RI7TME1j8kosvFUd11mPzRZ82V20v7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e2fMWtTg; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e2fMWtTg"
Message-ID: <7f02b64b-6319-40af-97df-4f632b406e18@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776622871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LYsoXHvtg/U6zD/M72t4qGHzOMrw3hwEssooHA68UFA=;
	b=e2fMWtTgmMRtdR5WtNu9wrN3bYsjEEEJ+5ZsK0yNLDSKQgrVSY1e0tbmbYRfqo8MXqEXTQ
	4bjlWzC1MbkPESK8nbVdsq9zy35yQ15X78/6B7I6fyoYbS6G0qIsdz4Bc/ZpbWy5xSRkm4
	k1BEwA1bqrMioVdn3NQuX7aqehJGvv0=
Date: Sun, 19 Apr 2026 11:20:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 13/17] bpf: Reject stack arguments if tail
 call reachable
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260419163422.738397-1-yonghong.song@linux.dev>
 <20260419170812.16705C2BCAF@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260419170812.16705C2BCAF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/19/26 10:08 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] The verifier incorrectly rejects perfectly valid subprograms with stack arguments due to an order-dependent state leak of `tail_call_reachable` during the call graph traversal.
> --
>
> commit 2677e39a30cc9fcf44cadb1927d1362ad39f7b4e
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Reject stack arguments if tail call reachable
>
> This commit deprecates tailcalls in the presence of stack arguments,
> rejecting subprograms with stack arguments if a tail call is reachable.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 13f1fd7880921..af89750498836 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -5672,14 +5677,23 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
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
> Can this leak the tail_call_reachable state across disjoint call graph branches?

I guess this is a known issue such that tail_call_reachable is marked more
than necessar. Since this has been mentioned a couple of times. I will fix
it in the next revision.

>
> In check_max_stack_depth_subprog(), tail_call_reachable is a local variable
> that seems to act as an accumulator. If the main program first calls subprogram A
> (which has a tail call) and subsequently calls subprogram B (which has stack
> arguments but no tail call), tail_call_reachable remains true while traversing B.
>
> When the traversal finishes subprogram B, this newly added check evaluates the
> current call stack (main -> B). Since tail_call_reachable leaked from the main
> -> A traversal, and subprogram B has stack arguments, the check would falsely
> reject the program.
>
> Conversely, if the bytecode is ordered so that B is called before A,
> tail_call_reachable would be false while traversing B, allowing the program to
> load successfully.
>
> Does this introduce an unpredictable, order-dependent functional regression?
>
>>   			subprog[tmp].tail_call_reachable = true;
>>   		}
>> +	} else if (!idx && subprog[0].has_tail_call && subprog_has_stack_args(&subprog[0])) {
>> +		verbose(env, "tail_calls are not allowed in programs with stack args\n");
>> +		return -EINVAL;
>> +	}
>> +
>>   	if (subprog[0].tail_call_reachable)
>>   		env->prog->aux->tail_call_reachable = true;
>>

