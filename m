Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE451279DB6
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776535695; cv=none; b=NYZ8jdFsMl2nxWKx1VLdmIS6HPUr5Ve5SD1DluL3pk8dtKsKO+3CF5/dqX67jwH2AdCALAAHXzBR/Amtgpx23pVMu5JyJ2oNXobleQAePfu6gDcGvc2LSRuKRuDrYqcm9QTCU7exZsHExYoZDMmWVOflHLz9bBc7ga11y+Rm1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776535695; c=relaxed/simple;
	bh=kDXvGZA/cD6RE/iBWXd16Y0O7rA4m9ec+aFMqdtGT5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVUgFciF51+JOB6N5rF/R2uWxhPAkTApN02p1Z0z0Dpwg+Nh06tkgmoGU5EEaFrX9YJv4TlRm/1d46EiZwdNsnPqwXjakMUaByQkO3QXGZ1vkC9kUWB+hkYA3tMihCOl1CGXF/GIfk6r8su2QigO9/EwgK+IV3q2S499blWIfQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PPXqtnEW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PPXqtnEW"
Message-ID: <22ab7b8e-73ad-4675-959d-d4d6801954f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776535692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kGfyRfUBKU4v904m0PiQU71IBf6oLu9wHicVns8qnM=;
	b=PPXqtnEWDGM6X+Whe5W+xx8hMf2HxA3D9fDlmveTDygAR+MFo5ySVufSZZkWkcad3lYbfe
	/5fYvmpcert5lUsDS159Pxzn5P3VgrAOAA2YSkPoO0WbTVoUneSFFAxyhZvg1mgOrVeMWL
	tYmFfloaJv8rOvIzL0fSmNDFyy5WkNg=
Date: Sat, 18 Apr 2026 11:07:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 12/16] bpf: Enable stack argument support for
 x86_64
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260417034800.2631277-1-yonghong.song@linux.dev>
 <20260417050346.F2E3FC19425@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260417050346.F2E3FC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/16/26 10:03 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] Enabling `bpf_jit_supports_stack_args()` for x86_64 without the corresponding JIT implementation introduces a bisection-breaking regression that can lead to arbitrary kernel memory writes and ABI violations.
> --
>
> commit b40feee41e4472d0e27be38b4c99c940abe3c1ba
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Enable stack argument support for x86_64
>
> This commit enables stack argument support for the x86_64 JIT and verifier
> to allow BPF programs and kfuncs to use more than 5 arguments.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index e9b78040d703e..32864dbc2c4e8 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -3937,6 +3937,11 @@ bool bpf_jit_supports_kfunc_call(void)
>>   	return true;
>>   }
>>   
>> +bool bpf_jit_supports_stack_args(void)
>> +{
>> +	return true;
>> +}
>> +
> Does enabling this without the actual JIT implementation break bisection?
>
> If bpf_jit_supports_stack_args() returns true, the verifier will allow
> instructions using BPF_REG_PARAMS (register 11) to handle stack arguments.
> However, since the JIT support isn't implemented in this commit,
> BPF_REG_PARAMS is not yet defined in the JIT's reg2hex array.
>
> Could this cause reg2hex[11] to implicitly default to 0, which maps to
> RAX (BPF_REG_0)? If the verifier emits instructions using BPF_REG_PARAMS,
> the x86 JIT might miscompile them using RAX as the base register, potentially
> allowing an arbitrary kernel memory write since R0 is controllable by the
> BPF program.
>
> Additionally, it appears kfunc calls with >5 arguments won't have their
> arguments correctly marshaled to the System V ABI (like moving the 6th
> argument to R9), which could lead to reading uninitialized garbage from
> registers and the stack.
>
> I see the JIT implementation is added later in the series in commit
> 41dcf99330b6b ("bpf,x86: Implement JIT support for stack arguments").
> Should the JIT implementation be merged before or in the same patch as
> this feature enablement to maintain bisection?

Good point. Will enable stack args in JIT patch.

>
> [ ... ]
>

