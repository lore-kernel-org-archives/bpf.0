Received: from mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1A45DF45
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113630; cv=none; b=YSKSalFZY09wiwZzuqSOeN4OV76Fq1MxFcmnAkn28g2gP8BYvEO/bwrL6KjriOYwZQp/daQU3zxRNsqIiafQsajl7zDyj/y9yLQkECb8igwfKKa/TIKgkkQCLZzkCK/3FjAl5xpcX1Pq1AFhooXVZdQ/ClSuOKhdRil76PHh2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113630; c=relaxed/simple;
	bh=afKiJa6hxOxYUi6bVE0sRytlbJBMbtKUr3nFCUs23Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fc1KRgHnI2SB9oDKWDETrQ4+SXOPsyEylhXZ0NXS+ETCtg/irIdj6fWgvJ+yupoBAOjA2/7YVdDy+9YeKlDU+E9PnaPLhjupxJKrIczmJIeyJ9cMfZePmB3RvwPBVJ8eebD7LeUjz/XUB1WqWzZbAnKTD3Q1+CvembLsenMN3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rqu3dWQw; arc=none smtp.client-ip=91.218.175.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rqu3dWQw"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=afKiJa6hxOxYUi6bVE0sRytlbJBMbtKUr3nFCUs23Ag=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113626; v=1; x=1789718426;
 b=rqu3dWQw9V6BFWdZ0r6uujuUUxROnGxtXQ4CV8vVd96LEglhrE1mYbclk8R1g1pA/OVicFd0
 21jc+5rqtlJIC3HgENk/ZT0aFFHcMnua8iH6S0QlEl2i9e4icrS4hT05imdVu7U1f4kmkZt7zMX
 rDZSXuFLiI04R716A93u7y2o=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ae1b02bf5b6b67e0;
	Fri, 11 Sep 2026 08:00:15 +0000
X-Mizu-Trace-ID: ae1b02bf5b6b67e0
X-Migadu-Flow: FLOW_OUT
Message-ID: <f0fa0178-4109-476d-b42b-0970b398de56@linux.dev>
Date: Fri, 11 Sep 2026 13:30:04 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 08/13] selftests/bpf: cover the low-32 link
 for sign-extending movs
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260910164635.459558-9-vineet.gupta@linux.dev>
 <5c3e4124ce20a8c5b435ae68e4facd38b0dab5b9f643e74d014287dc9172076e@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <5c3e4124ce20a8c5b435ae68e4facd38b0dab5b9f643e74d014287dc9172076e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/26 11:22 PM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: cover the low-32 link for sign-extending movs
>>
>> Five programs, mirroring the zero-extending set:
>>
>>   - sext_mov_wide_src: narrowing the source reaches the destination, and
>>     the value that arrives is sign-extended rather than zero-extended
>>   - sext_self_mov_keeps_link: r0 = (s32)r0 on an already-linked register
>>     stays in its set, the shape a sign-extended int return takes
>>   - sext_self_mov_no_link: the same mov on an unlinked register mints no id
>>   - sext_no_sync_when_base_has_delta: a delta on the base stops propagation
>>   - sext_no_sync_from_subreg_base: narrowing the link does not run
>>     backwards into the rest of the set
>>   - sext_kinds_reach_different_values: the same low half reaches -1 through
>>     a sign extension and 0xffffffff through a zero extension
>>
>> Each guards a div by zero that is only unreachable if the propagation
>> happened, so losing the link is a verification failure rather than a test
>> that quietly stops checking anything.
> This isn't a bug, but should the count read "six programs", and could the
> closing sentence be scoped to the two __success programs, since
> sext_self_mov_no_link has no div and the __failure ones expect it to be
> reachable?

OK.

>> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> index eb88d9ce6c34..45bfa02a5338 100644
>> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
>> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> @@ -269,6 +269,14 @@
>>   #define CAN_USE_BPF_ST
>>   #endif
>>
>> +#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
>> +     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||		\
>> +     defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) ||	\
>> +     defined(__TARGET_ARCH_loongarch)) &&				\
>> +	(__clang_major__ >= 18 || defined(__BPF_FEATURE_MOVSX))
>> +#define CAN_USE_MOVSX
>> +#endif
>> +
> This isn't a bug, but now that the gate lives in bpf_misc.h, would it be
> worth switching verifier_movsx.c's inline #if over to #ifdef CAN_USE_MOVSX
> so the arch/feature list exists in one place?

Yes.

Thx,
-Vineet

>> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> index 65cb0efd268f..9d060d8b0c1f 100644
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34506184282

