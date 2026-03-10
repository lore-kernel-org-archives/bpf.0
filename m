Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C836896A
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773109281; cv=none; b=nnpNCTDngD83TVipsQGnMhy+E9x0oA70CzW+L04Ienl9+Jowe/vEF+Mq+062sHfpe/jTYVOSZQ9OltAFRbAtQEAnJPoZf/X5pmKhcMLcszYvLllnEv6m1xNvWOZrkKXyXIln4aAGOGhr1T/P16V/1tf1vyyIrOu3aqlt+xhs1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773109281; c=relaxed/simple;
	bh=53JNiwjDpcrXYaD/neAIw6Fw4QymuK85KoxAwTSJI6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYOEJpghVTcwuGCWvKM86RLT49gv5qYfH06Pg3wtEHNw5G5Keye8Y7Bjt9Giq38AXrS7589g9ZWSBbNV8CXAJzHKoinN5EJTgUBRXQXoUUlwE/5CcNXRDF2HsLvknBH7vgZxxL8jWqnDe0n8nsCeXeCcGsYionFEcVpaFiJ+NP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pK07Pq70; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pK07Pq70"
Message-ID: <75298428-4210-488e-b0ad-0e58f739d8a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773109275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGbUE34o0OJRdhBBdAUuna0ZkWqH9eHbXcJGIRMFYNg=;
	b=pK07Pq70jmOMSyG/YoTKiuKOBVJQatg1nH1FRWxPdUsyWZJt9OJQuXJCmjjpTBo2Unz/W3
	t5uUROI0jwNuq0A/8h8ija+/YJcLThprKXKl22zaorpBVmAnkQfkdgKM6JoDqmSnTvVT6Q
	ax6wkU2+W5r2JqAEzkoth7sbAcwYsGk=
Date: Mon, 9 Mar 2026 19:20:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] selftests/bpf: Add tests for sdiv32/smod32 with
 INT_MIN dividend
Content-Language: en-GB
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Jenny Guanni Qu
 <qguanni@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 mykyta.yatsenko5@gmail.com, lkp@intel.com
References: <20260309215910.4131143-1-qguanni@gmail.com>
 <20260309215910.4131143-3-qguanni@gmail.com>
 <9a212cc9-46cf-4c0a-a5a6-98544f46465b@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9a212cc9-46cf-4c0a-a5a6-98544f46465b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/9/26 7:05 PM, Jiayuan Chen wrote:
>
> On 3/10/26 5:59 AM, Jenny Guanni Qu wrote:
>> Add tests to verify that signed 32-bit division and modulo operations
>> produce correct results when the dividend is INT_MIN (0x80000000).
>>
>> The bug fixed in the previous commit only affects the BPF interpreter
>> path. When JIT is enabled (the default on most architectures), the
>> native CPU division instruction produces the correct result and these
>> tests pass regardless. With bpf_jit_enable=0, the interpreter is used
>> and without the previous fix, INT_MIN / 2 incorrectly returns
>> 0x40000000 instead of 0xC0000000 due to abs(S32_MIN) undefined
>> behavior, causing these tests to fail.
>>
>> Test cases:
>>    - SDIV32 INT_MIN / 2 = -1073741824 (imm and reg divisor)
>>    - SMOD32 INT_MIN % 2 = 0 (positive and negative divisor)
>>
>> Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
>> ---
>>   .../selftests/bpf/progs/verifier_sdiv.c       | 58 +++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c 
>> b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
>> index 148d2299e5b4..fd59d57e8e37 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
>> @@ -1209,6 +1209,64 @@ __naked void smod32_ri_divisor_neg_1(void)
>>       : __clobber_all);
>>   }
>>   +SEC("socket")
>> +__description("SDIV32, INT_MIN divided by 2, imm")
>> +__success __success_unpriv __retval(-1073741824)
>> +__naked void sdiv32_int_min_div_2_imm(void)
>> +{
>> +    asm volatile ("                    \
>> +    w0 = %[int_min];                \
>> +    w0 s/= 2;                    \
>> +    exit;                        \
>> +"    :
>> +    : __imm_const(int_min, INT_MIN)
>> +    : __clobber_all);
>> +}
>> +
>> +SEC("socket")
>> +__description("SDIV32, INT_MIN divided by 2, reg")
>> +__success __success_unpriv __retval(-1073741824)
>> +__naked void sdiv32_int_min_div_2_reg(void)
>> +{
>> +    asm volatile ("                    \
>> +    w0 = %[int_min];                \
>> +    w1 = 2;                        \
>> +    w0 s/= w1;                    \
>> +    exit;                        \
>> +"    :
>> +    : __imm_const(int_min, INT_MIN)
>> +    : __clobber_all);
>> +}
>> +
>> +SEC("socket")
>> +__description("SMOD32, INT_MIN modulo 2, imm")
>> +__success __success_unpriv __retval(0)
>> +__naked void smod32_int_min_mod_2_imm(void)
>> +{
>> +    asm volatile ("                    \
>> +    w0 = %[int_min];                \
>> +    w0 s%%= 2;                    \
>> +    exit;                        \
>> +"    :
>> +    : __imm_const(int_min, INT_MIN)
>> +    : __clobber_all);
>> +}
>> +
>> +SEC("socket")
>> +__description("SMOD32, INT_MIN modulo -2, imm")
>> +__success __success_unpriv __retval(0)
>> +__naked void smod32_int_min_mod_neg2_imm(void)
>> +{
>> +    asm volatile ("                    \
>> +    w0 = %[int_min];                \
>> +    w0 s%%= -2;                    \
>> +    exit;                        \
>> +"    :
>> +    : __imm_const(int_min, INT_MIN)
>> +    : __clobber_all);
>> +}
>> +
>> +
>>   #else
>
>
> Minor nits: extra blank line before #else, and smod32 tests only cover 
> the imm
> form — a reg variant (w0 s%%= w1) would make coverage symmetric with 
> sdiv32.

Right, the committer should be able to remove the extra line.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

>
> Neither worth a respin.
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
>>   SEC("socket")

