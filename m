Received: from mta0.migadu.com (out-101.mta0.migadu.com [91.218.175.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BBF3B6347
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136350; cv=none; b=LEaYrI87sNPsPdjzC33D/014LptrJMidCNeDeLRUHuaVyD+4ixKfuUL4hQZdBPc27MO+HNwOYdE59edWZ74USW+T0p/1V5rViQIOhn41HolN3+FrO+9mHOaLuf9hQdFMg7Iuvf+jJnLKZIeSPonvGwdjpo0nVJ7UNaR4tMziuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136350; c=relaxed/simple;
	bh=gOrFnigJfpGwqpYCqTwbXTfY1DnWXRRqUxf1/ERHO5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSw5zRBW+vc4GGRdT4WrT682K/mNURXGxUrW9mBH687Ofq0skWxuUXuX9fv9bAgj4mbhu35xUgodQg3oqoG7GnsOE754z85qDQSHTCbPp9A0RBt3438EJ/x7m4wP6tfFfRplr+p4bt04q1YzgJOxNyiwfYsLuWFOpT/JTvBqQwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MzZ6bIDL; arc=none smtp.client-ip=91.218.175.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MzZ6bIDL"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gOrFnigJfpGwqpYCqTwbXTfY1DnWXRRqUxf1/ERHO5E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790136345; v=1; x=1790741145;
 b=MzZ6bIDLYHVq8ovf0/397aL1KwNPkVAByK1fHAx2WFCyRRNnF5cP6aIM1TdzN+vCEpyoaOHk
 qGqYH2T1qiam9wj0CzLZEwmrDhK8voN5OfP98cRQt0acbhsPkkNTsQLu5q9xsVeJW96L5qYvb7v
 ZLpBMBvQ5EGuRFkZZ01+7eaE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1a468926db72ebea;
	Wed, 23 Sep 2026 04:05:45 +0000
X-Mizu-Trace-ID: 1a468926db72ebea
X-Migadu-Flow: FLOW_OUT
Message-ID: <0a841d74-398b-4999-b974-8c337ca057ce@linux.dev>
Date: Tue, 22 Sep 2026 21:05:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 04/20] bpf: Prepare for an exception cleanup
 table before the CFG walk
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210053.1717603-1-yonghong.song@linux.dev>
 <8fd3e980749f4a5ac10ff5d3d1704e42c1bda643.camel@gmail.com>
 <e2905d50-0afd-49a3-818a-681bbd665f84@linux.dev>
 <2c2a6d6b41da4354b871bfcf42665fdd367e0614.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2c2a6d6b41da4354b871bfcf42665fdd367e0614.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/22/26 8:54 PM, Eduard Zingerman wrote:
> On Tue, 2026-09-22 at 20:07 -0700, Yonghong Song wrote:
>
> ...
>
>>>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>>>> index 4b3ac93e98c1..67af78baa558 100644
>>>> --- a/kernel/bpf/exception.c
>>>> +++ b/kernel/bpf/exception.c
>>>> @@ -18,6 +18,66 @@ static bool insn_is_unwind_resume(const struct bpf_insn *insn)
>>>>    	       insn->imm == bpf_unwind_resume_id[0];
>>>>    }
>>>>    
>>>> +static void cleanup_mark_kfunc_sites(struct bpf_verifier_env *env)
>>> Nit: the 'cleanup_' prefix in function names triggers me a bit,
>>>        as it is usually used when there are some cleanup actions are
>>>        taken by the function. Maybe drop or reword it a bit?
>> Yes, I will try to avoid cleanup_ prefix then. For static functions,
>> I will not have cleanup_ prefix or may use exc_ prefix.
>> For global function, I will bpf_cleanup_ as prefix.
> Yonghong, a wider naming question: should we use cleanup/cleanup_pad
> or landing/landing_pad to name these things?
> It appears both LLVM and GCC use landing pad.

The reason for functions with cleanup_* is due to section name '.bpf_cleanup'.
cleanup actually is a good name since it means something wrong and go to
do cleanup. Unfortunately, cleanup has some other meaning which makes it
hard to infer.

landing or landing_pad itself infers exception target (landing_pad)
but it does not infer exception source.

In my next version, I tried to use bpf_exc_* where 'exc' means exception.

