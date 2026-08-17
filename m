Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A327FB18
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786938597; cv=none; b=BCZW66GEjeQQqT20DjfUC77mSN6VyJiIKMlAaEM6ZWXSJDx8T2XcEKvx3WWHPNKBKiub0msopaSNfZW4cO94wayYU/YT1Xeb30X4Z9Tj5wPxD7ekV4T4PKAknL4tRHh5WEf1W52xGYFzMkkW1t43c9lEt4SAUk/+UI47IeTroxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786938597; c=relaxed/simple;
	bh=oO0Fa8oRMiXpJTyPpWMxKjOJmoUdQU3ye8KGWNrXMJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryVrvRPhlkvH1UKuhHHPtatbb+7s0zPVezL3Mb/wr04tPv39xbo8drZoB0SMmtYPTXkkOhvb7lm1Pm3j/nwuYvi2lb2KYQe1M153ZkKAEXyzBzAna2tIvqtWlw1pHz5b9bN0e9vj2CX+OeoDQvu5sdebiFSNKCaraivuFFjHjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oYTmasWX; arc=none smtp.client-ip=91.218.175.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oYTmasWX"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oO0Fa8oRMiXpJTyPpWMxKjOJmoUdQU3ye8KGWNrXMJw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786938594; v=1; x=1787543394;
 b=oYTmasWX+0rtn39ZjTt/nIVH+H/U/EovFtQHB2crAldgL462KEmuWnat8gpI4zHHAf5y8I1H
 awLI/zuKFo+g2ucK21fmbDvmkJDtf9yJ1JCDsDnNfdU2creYFEIJJqQa2BY6Pwp0mh7YGcCoDmU
 7YrMcCYtV8841B8zVFQtkOpo=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id de54a06a9d27b7aa;
	Mon, 17 Aug 2026 03:49:54 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <9ec10d1e-0e98-4512-a628-a1055a1cc05e@linux.dev>
Date: Sun, 16 Aug 2026 20:49:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 08/11] bpf: Reject register-pair returns when
 the subprog BTF is unreliable
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200250.1996395-1-yonghong.song@linux.dev>
 <20260814030240.5E9981F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260814030240.5E9981F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/26 8:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] push_callback_call() incorrectly passes helper arguments for BTF validation, tainting callback subprograms as unreliable.
> --
>
> --- Patch [8]: [PATCH bpf-next v5 08/11] bpf: Reject register-pair returns when the subprog BTF is unreliable ---
> commit c1362d6d7ccc6806c96ffe9fc78804a2b8b6f1b9
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Reject register-pair returns when the subprog BTF is unreliable
>
> This patch rejects return values larger than 8 bytes as soon as the
> subprogram's BTF prototype is marked unreliable. It adds
> subprog_ret_pair_unreliable() and uses it in check_func_call() to
> prevent tracking R2 based on a discarded signature.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b23be0fa95af4..0ffb3bed1649e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -9527,6 +9544,12 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   		return 0;
>>   	}
>>   
>> +	if (subprog_ret_pair_unreliable(env, subprog)) {
>> +		verbose(env, "Func#%d ('%s') returns >8 bytes, which requires reliable BTF\n",
>> +			subprog, subprog_name(env, subprog));
>> +		return -EINVAL;
>> +	}
> [Severity: High]
> This is a pre-existing issue, but will this new check incorrectly reject
> valid BPF programs because of how push_callback_call() marks subprograms
> as unreliable?
>
> Looking at push_callback_call():
>
>      caller = state->frame[state->curframe];
>      err = btf_check_subprog_call(env, subprog, caller->regs);
>
> It passes the caller's registers (which contain the helper arguments, e.g.,
> the PTR_TO_FUNC for bpf_loop) instead of the actual arguments the callback
> will receive. Because these arguments don't match the callback's prototype,
> btf_check_subprog_call() fails, sets the unreliable flag to true on the
> subprogram, and returns -EINVAL.
>
> push_callback_call() ignores this error, leaving the callback permanently
> tainted as unreliable.
>
> If a callback subprogram returns >8 bytes, won't it be incorrectly rejected
> here if it is also called directly elsewhere in the program, since the
> unreliability flag was set mistakenly?

Yes, let us remove this patch as the above unreliable rejection may actually
reject legal prog's.


