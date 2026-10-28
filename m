Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203706;
	b=19LHutYlncbF/jhIl/e9wtQQNKwm1AL9nE12JCTkqYKVRXEYR/k/HM70pBE1UJlX1Guh
	 Fo6B5DLvEQMgBV0IMg+/bRgt1DZljY0qDNnEIFc8KC3A6UUBb25VX/90wpi+z8CaBCTl6
	 2xeOJjIht3kSujUA3bAIpCxUdL4LY7ZZZyP5JW+YSyA2h+jizmo2SQnLMM2Hq9b1ynkL+
	 hewYw9DRp/DQ0NjqIak4897iAncqfd5f6Jh15zXZznvoKeSyyTsoHfT5/KSbuEom5l9PH
	 WXR8dZj8yojXC6W/D9GZJDXjUc43/WJ1r45+f2WrQb43a+Tys/F2ojc2uoDoy2hKT1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203706;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MxROFele/7xmUBoLLTNHElbT4fiioQcRUV0YBjVBRTI=;
	b=UzCZmFlSX0ufK/+pRbHY1IMgPpkBEsOYTn+nkULUc6GuQVFr5486c1/naS14jDyL6oe/
	 Qu0dkros3RpRrFn/5d4UbBB6dGvl4azVSrepEdcrbcr/s6DV3b1c7e5ieZbpOXYMolLT0
	 eINaa8qjEO+4ic1nJexiGAu9cJzBpWNYcm0TivS4lWMEXpBHkCOtwq86bZl7XPo1ifa67
	 BBqNMW9dE5TuGGUJ4Thq5unvqkSJkHHvhFuJtpCp+vs6VqqQ3/3QrXmOsMzAIARAsarCv
	 paSYZKQ0QrL41XQQArnxjyDX0s5bXGpL2PQIxE1k+IYRsVIil8d8/hzSKgPyo2+1ktQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w5OyxGnn;
	arc=none smtp.remote-ip=95.215.58.219
Received: from mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802F0606A31C
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 16:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 802F0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w5OyxGnn
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ed1QhX/EeBnT+m6d5f/VEjVqb0pcdtMA5QIcEBWm57k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793203701; v=1; x=1793808501;
 b=w5OyxGnnRiBQzqMvIN/WPsUfZ6dezQYzsS7Ur4iBQg1G8A/x4tFToSBEV7jtEO+O+ZYdp1HJ
 aVDOEZeXyrrDVItPG9hGDEvwEVRluUdtRkHXdlxSPvZOljGnhjy8yOTlK6Tgxu3j3cTZ7vrLSEN
 aKnB+m1E/upH7BAgMHgKpbWM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 693a6adefefd24b0;
	Wed, 28 Oct 2026 16:08:21 +0000
X-Mizu-Trace-ID: 693a6adefefd24b0
X-Migadu-Flow: FLOW_OUT
Message-ID: <346c3e4f-9244-47c9-927f-8e866b478fe2@linux.dev>
Date: Wed, 28 Oct 2026 09:08:13 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/7] selftests/bpf: Build callx tests with GCC
 that defines __BPF_FEATURE_CALLX
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, john.fastabend@gmail.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 jose.marchesi@oracle.com, david.faust@oss.qualcomm.com,
 martin.lau@kernel.org, mason@kernel.org
References: <20261028000411.4010967-2-vineet.gupta@linux.dev>
 <804b7fd3c3bf40a5edf65903d90514263e61fc6fa2ef513d35913fe8ed9acad8@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <804b7fd3c3bf40a5edf65903d90514263e61fc6fa2ef513d35913fe8ed9acad8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/26 5:46 PM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Build callx tests with GCC that defines __BPF_FEATURE_CALLX
> TL;DR: Nit only: the new __skip() reason in the callx selftests omits riscv64,
> though riscv64 is supported, so a riscv64 build with a GCC lacking callx
> prints a misleading skip message.
>
>>
>> +/* clang always emits callx, gcc only when it defines __BPF_FEATURE_CALLX */
>> +#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
>> +     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) &&		\
>> +	(defined(__clang__) || defined(__BPF_FEATURE_CALLX))
>> +#define CAN_USE_CALLX
>> +#endif
>> +
>> @@ -1075,6 +1073,7 @@ int callx_c_ops_on_stack(void *ctx)
>>   #else
>>
>>   SEC("socket")
>> +__skip("callx needs x86/arm64 JIT and compiler support")
>>   __success
>>   int dummy(void *ctx)
>>   {
> this isn't a bug, but the skip reason leaves out riscv64, even though the
> CAN_USE_CALLX macro above accepts it.
>
> The same string is added to the dummy() program in
> verifier_callx_rodata.c.  The riscv64 JIT implements bpf_jit_supports_callx(),
> and commit 530dfafc6107 ("selftests/bpf: Enable callx related testcases for
> RV64") turned these tests on for RV64.
>
> On a riscv64 build with a bpf-gcc that does not define __BPF_FEATURE_CALLX,
> the arch supports callx and only the compiler lacks it, yet run_subtest()
> prints:
>
>    run_subtest:SKIP: callx needs x86/arm64 JIT and compiler support
>
> That reads as though riscv64 itself were unsupported.
>
> Could the reason say x86/arm64/riscv64, or leave the arch list out (for
> example "toolchain or JIT can't do callx", as the new comment in
> callx_rodata_lskel.c does)?

I'll just leave out the arch list and refer to just toolchain or JIT.

Thx,
-Vineet

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40608355234

