Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4029443
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531657; cv=none; b=X44kZEvN+xXhNXqKqCCspTz7t0VfCyRXs8mz2H+/T/6LmjWkE/NbMEUDMlq9NPf1NC6X4WzBFR4g1Oq4UNo2lipu/p38iPGXZq5sIITb+pZECNFpk2k7zj9Bu1tBY04TfmdWig46ZOzfhWROM9v3K9TAZ28ABHIGOfY2t2cCugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531657; c=relaxed/simple;
	bh=D51TuqHFz1fsxHCfWrD2LeRosUy75+YCry0TWzdhU1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsHRYhwG+0QcpmWdI+QPz2Ws8FS5gttjMQhQYBhsFBM8/cwMciQznbcQShw18bCXSmR5UjPjK1ma7Zy1kiW7S1DJpNbJ3kPZEOAB8NHf4doPEeG/IWhKDsPfWOnOurCNwFTW1GpkXYXh3OzDjUfW6brZZLEI+d2lvZsZ7aqQ/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q5x0v/nG; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q5x0v/nG"
Message-ID: <b9ae30fb-e3b6-45fa-858d-8c95c96aa1f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776531653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBYJUuoiuYPWVVbXsspqfYNeLFqjBFmVjToUyMoFoRY=;
	b=q5x0v/nGoVlI5EtAqfYPjgGN222/pg1SxxkSxVz3EkJT+4Z8jNfEhNoV06odc08v0663ij
	WGHle/y/q0qVdNyeo9n53d1QXqRCZY/rC3nLVazuuagb0z5YLZWF1Bu52qirtcxx0KOhWz
	tX+SqAUZqJfM/S79NxkW6mKvgE4PUQk=
Date: Sat, 18 Apr 2026 10:00:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 07/16] bpf: Reuse MAX_BPF_FUNC_ARGS for
 maximum number of arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260417034734.2629722-1-yonghong.song@linux.dev>
 <d23db60b9c7e22d8ab443688b4f2da8d5594d6c07698cdc282faccaade757430@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d23db60b9c7e22d8ab443688b4f2da8d5594d6c07698cdc282faccaade757430@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/16/26 9:30 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1151,6 +1151,10 @@ struct bpf_prog_offload {
>>
>>   /* The longest tracepoint has 12 args.
>>    * See include/trace/bpf_probe.h
>> + *
>> + * Also reuse this macro for maximum number of arguments a BPF function
>> + * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
>> + * stack arg slots.
> Is this description of the calling convention accurate? The comment states
> "Args 1-5 are passed in registers, args 6-12 via stack arg slots," but
> doesn't argument 6 get passed in the R9 register rather than on the stack?
>
> Looking at arch/x86/net/bpf_jit_comp.c, the existing comment states: "x86-64
> supports up to MAX_BPF_FUNC_ARGS arguments. 1-6 are passed through regs, the
> remains are through stack."
>
> The follow-up commit 0ef907c3ec2c in this patch series ("bpf,x86: Implement
> JIT support for stack arguments") documents the actual calling convention as:
> "Follow x86-64 calling convention for both BPF-to-BPF and kfunc calls: - Arg
> 6 is passed in the R9 register - Args 7+ are passed on the stack at [rsp]"
>
> Should the comment say "Args 1-5 are passed in registers, arg 6 in R9
> register, args 7-12 via stack arg slots" instead?

I add something like:

The JIT may map some stack arg slots to registers based on the native calling
convention (e.g., arg 6 to R9 on x86-64).

>
>>    */
>>   #define MAX_BPF_FUNC_ARGS 12
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24546989054

