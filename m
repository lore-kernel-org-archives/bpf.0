Received: from mta0.migadu.com (out-120.mta0.migadu.com [91.218.175.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450DA3876D5
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 05:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103247; cv=none; b=HDY4e4stfFJ78z5Jvy8msBYakhT2LFvVFFeLw4M26HjU6uSDqUoOB+lUE76vmDjt5b6g26Ao1OfsZGXqyJYUvXp4lRUmhwJgLOberfyCeeG6pPN8NuiedZADVN9I/y4kPR0yY3l6tUij3tEeVm4iyAeh1YP8KFktjfbsU6zdO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103247; c=relaxed/simple;
	bh=g/LrzPMwU2k6a3uVq6mtOPg0IBqdWkXM7p18brGZkUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMYwKzCrV6aj99KRvhvJmdQ5785tKhCtzZ99uJeSzClclQOZd3tEbnrheIsvBMH0xgI0KwHdkUzzh9Jyva41/YlW/8c1hqouyuXVqvUWNSCftrRCB7jpoKp/+8tnpGau1TnILfUbi9g6S24KV22LQUXeI+NVohpJ0uyB0Ii8Hzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m7truXR3; arc=none smtp.client-ip=91.218.175.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m7truXR3"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=g/LrzPMwU2k6a3uVq6mtOPg0IBqdWkXM7p18brGZkUo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789103242; v=1; x=1789708042;
 b=m7truXR36I2P/ByGvOgaBHWOeFlcRGiCCEvt/cLCaREhVF6mt39/qaSZOn0PqKKMIXZaznqt
 TrVFFE/Pprg3fhyy90mVcPuiuAtwuLMLYLGKk4pjSvJHd88nJ6Bw1+IA+hH4S1DDTp0mqhPEWas
 p03Yd7QCOMaq+SP/Y8s8tDeA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8b2f10adbf184df0;
	Fri, 11 Sep 2026 05:07:22 +0000
X-Mizu-Trace-ID: 8b2f10adbf184df0
X-Migadu-Flow: FLOW_OUT
Message-ID: <242a06a6-dad9-4a0c-83c8-c3cf52707652@linux.dev>
Date: Fri, 11 Sep 2026 10:37:16 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 10/13] selftests/bpf: cover the low-32 link
 for narrowing stack fills
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260910164635.459558-11-vineet.gupta@linux.dev>
 <f5c0c236ba1f062cb0ab363bf6672e7aef2c278ba7193bef5891ab18d86c9b38@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <f5c0c236ba1f062cb0ab363bf6672e7aef2c278ba7193bef5891ab18d86c9b38@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/10/26 11:01 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> index 9d060d8b0c1f..e8a44e7579c8 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> [ ... ]
>
>> @@ -966,6 +966,88 @@ __naked void zext_mov_breaks_add_const_src(void)
>>   	: __clobber_all);
>>   }
>>
>> +/*
>> + * A narrowing fill keeps only the slot's low 32 bits, so a later narrowing of
>> + * the spilled value must still reach the filled register. Same relation as a
>> + * 32-bit mov from a wide source, with the stack slot as the base.
>> + */
>> +SEC("socket")
>> +__success
>> +__naked void zext_fill_narrow_from_wide_spill(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r6 |= r0;		/* r6 = full 64-bit unknown */	\
>> +	*(u64 *)(r10 - 8) = r6;	/* slot linked to r6 */		\
>> +	r2 = *(u32 *)(r10 - 8);	/* narrowing fill, forms the link */ \
>> +	if w6 != 0 goto 1f;	/* narrows r6, propagates to r2 */ \
>> +	if r2 == 0 goto 1f;					\
>> +	r0 /= 0;						\
>> +1:								\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
>> +
>> +/*
>> + * A full-width fill of a wide slot is a plain 64-bit equality, not a low-32
>> + * link, so it must keep propagating exactly as before.
>> + */
>> +SEC("socket")
>> +__success
>> +__naked void zext_fill_full_width_keeps_full_link(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r6 |= r0;						\
>> +	*(u64 *)(r10 - 8) = r6;					\
>> +	r2 = *(u64 *)(r10 - 8);	/* no narrowing */		\
>> +	if r6 != 0 goto 1f;					\
>> +	if r2 == 0 goto 1f;					\
>> +	r0 /= 0;						\
>> +1:								\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
>> +
>> +/*
>> + * A sub-word fill is below the low-32 model, so no link is formed and the
>> + * relation is dropped as before.
>> + */
>> +SEC("socket")
>> +__failure __msg("div by zero")
>> +__naked void zext_fill_byte_forms_no_link(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r6 |= r0;						\
>> +	*(u64 *)(r10 - 8) = r6;					\
>> +	r2 = *(u8 *)(r10 - 8);	/* 1-byte fill: no link */	\
>> +	if w6 != 0 goto 1f;					\
>> +	if r2 == 0 goto 1f;	/* not deduced */		\
>> +	r0 /= 0;						\
>> +1:								\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
>> +
>>   #ifdef CAN_USE_MOVSX
> Should the guard here be checking for LDSX support instead? The two
> programs added below (sext_fill_narrow_from_wide_spill and
> fill_kinds_reach_different_values) both use BPF_LDX | BPF_MEMSX
> instructions (`r2 = *(s32 *)(r10 - 8)`), not MOVSX.
>
> Other LDSX users in the suite gate on the LDSX feature - for instance,
> verifier_ldsx.c checks:
>
>      (__clang_major__ >= 18 || defined(__BPF_FEATURE_LDSX))
>
> The two macros happen to align for clang >= 18 and gcc-bpf -mcpu=v4, but
> a compiler advertising MOVSX without LDSX would fail to build these
> programs rather than skipping them.

The bot is right, LDSX needs to be checked here.
I've introduced the macro in bpf_misc.h and used here as applicable.

There are some other in-tree users of this infra, but I'm holding off on 
converting them as have slightly different definition which I'd rather 
deal with separately outside of this series.


> [ ... ]
>
>> @@ -1129,6 +1211,68 @@ __naked void sext_kinds_reach_different_values(void)
>>   	: __clobber_all);
>>   }
>>
>> +/*
>> + * The sign-extending counterpart: the filled register is the sign extension of
>> + * the slot's low 32 bits, so a narrowing of those bits arrives sign-extended.
>> + */
>> +SEC("socket")
>> +__success
>> +__naked void sext_fill_narrow_from_wide_spill(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r6 |= r0;		/* r6 = full 64-bit unknown */	\
>> +	*(u64 *)(r10 - 8) = r6;	/* slot linked to r6 */		\
>> +	r2 = *(s32 *)(r10 - 8);	/* narrowing sx fill */		\
>> +	if w6 != -1 goto 1f;	/* narrows r6, propagates to r2 */ \
>> +	if r2 == -1 goto 1f;	/* sign-extended, not 0xffffffff */ \
>> +	r0 /= 0;						\
>> +1:								\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
>> +
>> +/*
>> + * The same, for the two fill kinds off one slot.
>> + */
>> +SEC("socket")
>> +__failure __msg("div by zero")
>> +__flag(BPF_F_TEST_STATE_FREQ)
>> +__naked void fill_kinds_reach_different_values(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	r6 &= 1;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r8 = r0;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r8 |= r0;						\
>> +	*(u64 *)(r10 - 8) = r8;					\
>> +	if r6 >= 1 goto 2f;					\
>> +	r2 = *(s32 *)(r10 - 8);	/* sign-extending fill */	\
>> +	goto 1f;						\
>> +2:								\
>> +	r2 = *(u32 *)(r10 - 8);	/* zero-extending fill */	\
>> +1:								\
>> +	if w8 != -1 goto 3f;					\
>> +	if r2 == -1 goto 3f;	/* only the sign-extending path */ \
>> +	r0 /= 0;						\
>> +3:								\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
>> +
>>   #endif /* CAN_USE_MOVSX */
>>
>>   char _license[] SEC("license") = "GPL";
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34506184282

