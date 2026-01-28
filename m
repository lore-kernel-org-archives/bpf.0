Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA2923EAB7;
	Wed, 28 Jan 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614387; cv=none; b=jEPfklEal8gYnPPHVjXGDwmYQE33OR6/0NOTKosEcPte/z3hmvdQ/yvkT9EpBLo8DY3Pmv3YgewuSrUX9iq417Q4kpEzq8m3VLHmuk24KxhDVz6PcFm07pPzF1X7t1qmAEEjQsjGdUdpguodz58tPY/lZujCBo2BAOBvlqshUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614387; c=relaxed/simple;
	bh=/j0QMuZZVJaohJdQE0AU/0AskFlPhD+8W5BqhMkUrJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAcH2HUiJOIOnuou7Tu/138gFJrVmf2ep56XOTGz8Pf0FLe65XVshLXCTxyKEsLwOHAA/MvCMMrItamHQF0/+I+nHpw/GmORQrYxTIqJ/gYM5mSG0rV/Pq0U0356xSU9LT0G1gpIVTnXi63EChp1sCv0rw33JnLmXaJ8q2uaGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lAeWBsWm; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lAeWBsWm"
Message-ID: <9cde3e15-4929-41df-8eef-f9dc282eed67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769614374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eAfyuSmJvy6LoTEpelkijHpOKcauN9cVZzfPkWSeICU=;
	b=lAeWBsWmMgOXU3WMkRpsMa3INwJNg+gm1iAV8lFR8rXozqYar/Tcw765EM5maSAxweyWxr
	pWkGCfrniasDCzWMTRJ3TtFTEsNQXfZEbb2CpmmnT/8FUEppcA7VxZBWeDP9Fo4NRYWK0R
	V2wo5D+VdGz1KivMG8zoQVRgxcTnCaQ=
Date: Wed, 28 Jan 2026 23:32:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add bpf_arch_supports_fsession()
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 shuah@kernel.org, menglong8.dong@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260128150112.8873-2-leon.hwang@linux.dev>
 <e64c4137e7f262e6fdab272e8ee44c8a129a36eb6d0186914375d6ba20d88474@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <e64c4137e7f262e6fdab272e8ee44c8a129a36eb6d0186914375d6ba20d88474@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/28 23:26, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 5a075e06cf..070ba80e39 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -4112,3 +4112,8 @@ bool bpf_jit_supports_timed_may_goto(void)
>>  {
>>  	return true;
>>  }
>> +
>> +bool bpf_jit_supports_fsession(void)
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is the actual function name in the code.
> 

There is no issue here.

bpf_jit_supports_fsession() follows the same pattern as other
bpf_jit_supports_*() helpers: it is declared in filter.h, provided as a
__weak default implementation in core.c, and overridden by individual
JIT backends as needed.

Thanks,
Leon


>> +{
>> +	return true;
>> +}
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index e0b8a8a5aa..3b1eb632bf 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -3142,6 +3142,11 @@ bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>>  	return false;
>>  }
>> +
>> +bool __weak bpf_jit_supports_fsession(void)
>> +{
>> +	return false;
>> +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21443677441
> 
> AI-authorship-score: low
> AI-authorship-explanation: The naming inconsistency between commit message and code suggests a human renaming the function during development without updating the commit message, not AI-generated content.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Documentation-only issue - commit message function name does not match actual code, which may confuse future code archaeology but has no runtime impact.

