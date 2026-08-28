Received: from mta0.migadu.com (out-154.mta0.migadu.com [91.218.175.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6930137EFF4
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787940619; cv=none; b=h9U8AVUottglQzLAtLG235zqP4I/mrds5kB58aASd1tqCq2lFOOpvtSgM43MXLLrcCcl3dGwMER/ygMVlRYE1qkdfeHsTA5G3frbwkkADu80IBNnTmypGoFrmmB9DVHS/MFqD+3Rtdvv509FSd6exdxUk3EQev7HceHC/QUntbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787940619; c=relaxed/simple;
	bh=0jAntp/k5frMlwWOXtwiJhAaoLyOUrRRAzcIFD6dJfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpoumCXxbOUO9OCn0+NrGM33IaM2ojfqzGw6gPDX6OZF7KHI06cYIeDkGF6wxO4brld2eFo/HiI+kc8CjxSF1AewEFXqZfOi3bdTOIB9PVHUY1+jlsJaOEPEZjfWYqfgZTdDx7tKXaZwnkSrE10p5BdV93WbH9GH+bY6Cao4m7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZnSESBlt; arc=none smtp.client-ip=91.218.175.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZnSESBlt"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0jAntp/k5frMlwWOXtwiJhAaoLyOUrRRAzcIFD6dJfU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787940615; v=1; x=1788545415;
 b=ZnSESBltoXNRd/l1zOp3s8gpPsJYvW1Wub4Zv8/fGBhhPkA0KVUNutGEKx1k0KzU0XagoSBH
 etaLi62vFrmWwaicm8R84lqPrylKOxmC4eIlaEkIgcjMn8ex6OUwXcdF676787XDIwybygrAR//
 hsCXGmqpnObBUVIuabiE4Knw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6a2f8667b8884629;
	Fri, 28 Aug 2026 18:10:15 +0000
X-Mizu-Trace-ID: 6a2f8667b8884629
X-Migadu-Flow: FLOW_OUT
Message-ID: <47573fc4-be5c-44bf-b307-b1528eae196c@linux.dev>
Date: Fri, 28 Aug 2026 11:10:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 07/11] bpf: Allow arena pointers in a by-value
 kfunc return
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260827061114.2514603-1-yonghong.song@linux.dev>
 <20260827061150.2518572-1-yonghong.song@linux.dev>
 <20260827065558.C91891F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260827065558.C91891F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/26/26 11:55 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Kfuncs returning structs by value can leak uninitialized kernel stack memory via struct padding.
> --
>
> commit a43266e4517bac02a4bb85149655178eefda72ad
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Allow arena pointers in a by-value kfunc return
>
> This commit allows by-value struct returns from kfuncs to contain arena
> pointers, in addition to scalars. An arena pointer has no provenance to lose
> and can be cast by the program, so returning it as a scalar is safe.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 967ad010b3222..9a36808136c9a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -14119,13 +14119,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   
>>   		/*
>>   		 * The returned struct comes back as raw register bits modeled
>> -		 * as an unknown scalar, so it must contain only scalars:
>> -		 * otherwise a pointer field would be laundered into a scalar
>> -		 * and escape provenance and reference tracking.
>> +		 * as an unknown scalar, so a pointer member would be laundered
>> +		 * into a scalar and escape provenance and reference tracking.
>> +		 * Only scalars and arena pointers are allowed: an arena pointer
>> +		 * has no provenance to lose, since a program may already derive
>> +		 * one from any scalar with addr_space_cast(), which confines the
>> +		 * result to the arena.
>>   		 */
>> -		if (!btf_struct_member_walk(env, desc_btf, t, BTF_MEMBER_SCALAR, 0, &path)) {
>> +		if (!btf_struct_member_walk(env, desc_btf, t,
>> +					    BTF_MEMBER_SCALAR | BTF_MEMBER_ARENA_PTR, 0, &path)) {
> [Severity: High]
> This is a pre-existing issue, but does returning structs by value from kfuncs
> leak uninitialized kernel stack memory via struct padding?
>
> When a BPF program calls a kfunc that returns a struct by value (up to 16
> bytes) containing padding bytes, the C compiler leaves the padding bytes
> uninitialized in the return registers (e.g., RAX/RDX on x86-64).
>
> The verifier's check_kfunc_call() processes this using btf_struct_member_walk()
> which ignores padding. The code then calls mark_kfunc_ret_regs() which
> unconditionally marks the entire return registers as fully initialized
> scalar values:
>
> kernel/bpf/verifier.c:mark_kfunc_ret_regs() {
>      ...
>      mark_reg_unknown(env, regs, ret_regs[0]);
>      if (nregs == 1)
>          return nregs;
>
>      for (i = 1; i < nregs; i++) {
>          mark_reg_unknown(env, regs, ret_regs[i]);
>      }
>      ...
> }
>
> Can a BPF program then read these registers and exfiltrate the uninitialized
> padding bytes (e.g., via BPF maps)?

We should be okay. Based on type, the return register will do proper narrowing
e.g., zeroing out the upper 32bit value, etc.

>

