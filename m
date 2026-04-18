Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBE12222A9
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531823; cv=none; b=JjD3R1J+pDLRHpm6Q4I1GGmAXGHT8H2F4yhweugJ2QRyx9GJq7GKpGrsqRT87HkQ9DFFHZeBy84TZtRZ3biyuHBzpYJa729BrrSbhGpZPJIRjiSemDfy1iIQRwXf6c3Htz3ZPVgWTAJJrqKF7lt02kxpctj6xrbtWc7Xo6zbecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531823; c=relaxed/simple;
	bh=KG+BJVwmGJCMql1wz/pr9bn+IcjEsvzxpsRs546TUM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppARVOZaQ3Yj2Z+tw+nxgSbLfQEMdF5G27I0Hq3HR2fdhFtnhUBByLCH+1Xa7IPL5PrsGSIU8ZlUoUKHhM78+G0hmn/yd6IdNc6ZRn8Gl+5rho/vZjIPkQ0RI0IW3r1BCAmezZERypwr4Df2SwV0ukPkT0GVAq1xoLG7DhBcSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YHIeShCf; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YHIeShCf"
Message-ID: <a3246084-b3dc-48e0-a4fa-e44e6aa3ce68@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776531820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3U7BDpTfZSDWZ5+bPijG2IG5QxMbq62bQD0QQeTJrM=;
	b=YHIeShCfafsF0BUcQy9QfeBf2fqsTh7gEW1cve9Usq/yHzKrUMQaIepmFYbsKHgGmmvnR+
	9qXzHH9RrNcw2WMLXOonJcEqtNNaiBjjl7Kh0sowoubGfeKwR+S0HhdbBqfbD0Gc40sKdF
	BZ2OhHOuADrCU962fZym9s5I5gg38Cw=
Date: Sat, 18 Apr 2026 10:03:26 -0700
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
 <3bc734dfbeffc1c45e1c640be67af1824500aa1b8e04aee814e1942c1064cc96@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <3bc734dfbeffc1c45e1c640be67af1824500aa1b8e04aee814e1942c1064cc96@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/17/26 5:52 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1151,6 +1151,10 @@ struct bpf_prog_offload {
>>
>> -/* The longest tracepoint has 12 args.
>> +/* The longest tracepoint has 12 args.
> This isn't a bug, but the multi-line comment opening doesn't follow BPF
> subsystem style. Per bpf.md: 'Multi-line comments MUST have the opening
> /* on its own line'. The rule applies even if surrounding code uses the
> old style.
>
> Should this be reformatted as:
>
> /*
>   * The longest tracepoint has 12 args.
>   * See include/trace/bpf_probe.h
>   *
>   * Also reuse this macro for maximum number of arguments a BPF function
>   * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
>   * stack arg slots.
>   */
>
>>   * See include/trace/bpf_probe.h
>> + *
>> + * Also reuse this macro for maximum number of arguments a BPF function
>> + * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
> Should this say "kfuncs" instead of "kfunc's"? The context is plural
> (referring to multiple functions), not possessive.
>
> Additionally, bot+bpf-ci@kernel.org raised a concern in v5 about the
> calling convention description. The comment states "Args 1-5 are passed
> in registers, args 6-12 via stack arg slots," but argument 6 is actually
> passed in the R9 register, not on the stack.
>
> Looking at arch/x86/net/bpf_jit_comp.c, the existing comment states:
> "x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6 are passed
> through regs, the remains are through stack."
>
> The follow-up commit 0ef907c3ec2c in this patch series documents the
> actual calling convention as: "Follow x86-64 calling convention for both
> BPF-to-BPF and kfunc calls: - Arg 6 is passed in the R9 register - Args
> 7+ are passed on the stack at [rsp]"
>
> Should the comment say "Args 1-5 are passed in registers, arg 6 in R9
> register, args 7-12 via stack arg slots" instead?

See previous comment:

The JIT may map some stack arg slots to registers based on the native calling
convention (e.g., arg 6 to R9 on x86-64).

This should clarify.

>
> Reference: https://lore.kernel.org/bpf/d23db60b9c7e22d8ab443688b4f2da8d5594d6c07698cdc282faccaade757430@mail.kernel.org/
>
>> + * stack arg slots.
>>   */
>>   #define MAX_BPF_FUNC_ARGS 12
>>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564

