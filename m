Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7639B94A
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349285; cv=none; b=RbL6rT/7Mw51SKXvXt32KYfzlFykk5lrr99zIzU7tvmnHiC4IDAkdqiWXTI/VUENiK9zCH/DJcxH6H1YG2jppQseE8ISbc+8NZA41nc2CcGbdBMFmRUeNGjERwhS7vUxhc3MEznhZEJNK7mV99R9yB/+QdKYsYPY37llocveWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349285; c=relaxed/simple;
	bh=AW0rKmnNte/ZCdL+tkUZ7j/KqSlwEiKNla1+5Cd8EG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skJZK3j0ZMWxEOvZASr1Y3Jod8abK1ii1U2wzQvplRBf1cOttJHSu8A8JFl1Rz2UQrtQuA3v4G4lUarXGjSnfyeFiDD0+rpjMB9IhGW3X7raPyMz1fXy0qF6L5vfru25O6sq8Oiiw3O8NGRLOthJ3NtgxgmptmKvJTJ33AoteGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u2QB+c40; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u2QB+c40"
Message-ID: <06642779-578a-4d79-b687-080ad8f96791@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776349281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lybRB8EHBvG98b0S3Tdfov2Z9XbgshEZtlTkAYVvF/o=;
	b=u2QB+c40Yb96hX7ZFUO3K9KTIfPbAQbT73fAeLyAvUODDX4snby4VQ9bSt8dA1d0Wur8b0
	EpieZ1TAZkMr4TTyFOyfUuqqHMbHA5jZ2KlW1bUs6NdNXPNLBiJKME9OaLYPrnpuHp2pRk
	fKgaKE7U6NvRUKwRx9941UnSdHfAWzo=
Date: Thu, 16 Apr 2026 07:21:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 10/18] bpf: Fix interaction between stack
 argument PTR_TO_STACK and dead slot poisoning
Content-Language: en-GB
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
 <20260412050000.262030-1-yonghong.song@linux.dev>
 <CAMB2axPoszkZqHYh8g3bH0V-c4-BzLX3ywSsF0fFyQOmN0Vp5Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAMB2axPoszkZqHYh8g3bH0V-c4-BzLX3ywSsF0fFyQOmN0Vp5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/15/26 3:32 PM, Amery Hung wrote:
> On Sat, Apr 11, 2026 at 10:01 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> The "poison dead stack slots" mechanism (commit 2cb27158adb3) uses
>> static liveness analysis to identify dead stack slots and poisons them
>> as a safety check. However, the static liveness pass cannot track
>> indirect stack references through pointers passed via stack arguments.
>>
>> For register-passed PTR_TO_STACK (e.g., R1 = fp-8 passed to a static
>> subprog), the liveness abstract tracker carries frame/offset info
>> through registers. When the callee dereferences R1, the tracker
>> attributes the read to the parent frame's stack slot, correctly marking
>> it alive. So no poisoning issue arises.
>>
>> For stack-argument-passed PTR_TO_STACK (e.g., fp-8 stored via
>> *(r12-8) = r1), the value goes through BPF_REG_STACK_ARG_BASE (r12)
>> which the liveness pass does not track. When the callee loads the
>> pointer from its incoming stack arg and dereferences it, the liveness
>> pass cannot attribute the read back to the parent frame. The parent's
>> stack slot is determined dead and poisoned before the callee even
>> starts. The callee's subsequent dereference then fails with "slot
>> poisoned by dead code elimination".
>>
>> Fix this by allowing STACK_POISON reads in check_stack_read_fixed_off()
>> when the read targets a parent frame's stack (reg_state != state).
>> Same-frame STACK_POISON reads remain rejected to preserve the safety
>> check for real liveness bugs. Cross-frame reads are safe to allow
>> because:
>>    - The pointer to the parent's stack was already validated by the
>>      verifier.
>>    - The slot contained valid data before being (incorrectly) poisoned.
>>    - The read returns an unknown scalar, which is conservative.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> While liveness of stack arg handled differently, can R12 base
> arguments cause some OOB in liveness.c? For example, can
> arg_track_xfer() reference at_out[12] while at_out is defined in
> compute_subprog_args() as struct arg_track at_out[MAX_BPF_REG]?

Yes. The v4 does not have this issue as it does not have arg_track_xfer()
yet when I posted it. But on top of the latest master, this is indeed an
issue and I am aware of this. Thanks for pointing it out!

>
>>   kernel/bpf/verifier.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e664d924e8d4..bfeecd73e66e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5764,6 +5764,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>>                                          }
>>                                          if (type == STACK_INVALID && env->allow_uninit_stack)
>>                                                  continue;
>> +                                       /*
>> +                                        * Cross-frame reads may hit slots poisoned by dead code elimination.
>> +                                        * Static liveness can't track indirect references through pointers,
>> +                                        * so allow the read conservatively.
>> +                                        */
>> +                                       if (type == STACK_POISON && reg_state != state)
>> +                                               continue;
>>                                          if (type == STACK_POISON) {
>>                                                  verbose(env, "reading from stack off %d+%d size %d, slot poisoned by dead code elimination\n",
>>                                                          off, i, size);
>> @@ -5819,6 +5826,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>>                                  continue;
>>                          if (type == STACK_INVALID && env->allow_uninit_stack)
>>                                  continue;
>> +                       if (type == STACK_POISON && reg_state != state)
>> +                               continue;
>>                          if (type == STACK_POISON) {
>>                                  verbose(env, "reading from stack off %d+%d size %d, slot poisoned by dead code elimination\n",
>>                                          off, i, size);
>> --
>> 2.52.0
>>
>>

