Received: from mta0.migadu.com (out-82.mta0.migadu.com [91.218.175.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F02336166A
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559573; cv=none; b=T0OpMdzrjjElWNWi4wddWTUkrGpBuqg9n1pvrSYPjdg7V/hqXeeTldfLkp8/BlczKf3DJKJo3JD0gHpAPjcQBQzJNvOqMMIOeuYPbljKiXIgxsg7TF8ISFNq86pO15+famiPvgfNRE48iYgQGrmkDjDsK2ImaQ54CHj+1JEtvAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559573; c=relaxed/simple;
	bh=uQt9Wkm5K6X1ONckwJEa5XYHD9ehhkS60OVN3YbNSZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1KFdpzdDbHqbNxg3CEfgYYXMPxjEH1WVm/jGeQZnZZsGtYW2fdkVNWLOx/mc1cvJhVLgybLyBxkSUUYaX8Fe1i7o15BStAEgWG1tN4vd8GQX44o6wwEeZkW6E/ycFVP9q2Qyhro9LvX2PoyapoHDUT3TEwkGIPmUSJJ8gJiw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ouGWEFbB; arc=none smtp.client-ip=91.218.175.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ouGWEFbB"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uQt9Wkm5K6X1ONckwJEa5XYHD9ehhkS60OVN3YbNSZE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791559570; v=1; x=1792164370;
 b=ouGWEFbBiHvu6aGyxW4mjV1apnlD6gPiijhhc1dU1v0EQwp8hf96mN4JMRTb2n5GTeegD3rr
 xmx+OhZo+S39S4BxRxekishM2KvAG68DKAYNVKgdqRWB0Vo6te/byLvI/CTMFg5Tb9yUmgGx0jG
 bxGp6Nab/5cYK/zTKGNjMQmM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 49a596fdf5ea5fa1;
	Fri, 09 Oct 2026 15:26:04 +0000
X-Mizu-Trace-ID: 49a596fdf5ea5fa1
X-Migadu-Flow: FLOW_OUT
Message-ID: <1f517342-2123-4a51-8581-99d04108c0d9@linux.dev>
Date: Fri, 9 Oct 2026 17:25:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 07/24] bpf: Verify an unwind through landing
 pads and epilogues
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261009041523.26992-1-yonghong.song@linux.dev>
 <59c036011bdc8e7bee4cdb78ab4ed375729668c9e99f62a82b7c156c80967bc9@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <59c036011bdc8e7bee4cdb78ab4ed375729668c9e99f62a82b7c156c80967bc9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/9/26 7:13 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Verify an unwind through landing pads and epilogues
> TL;DR: Nit only: unwind_frames() sets r0 to zero in two calls;
> __mark_reg_const_zero() could do it in one, as process_iter_next_call() does,
> and the explanatory comment could go. No bug.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 0cf30220b777..1553c7d5bbdb 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -19203,6 +19212,135 @@ enum {
> [ ... ]
>> +static int unwind_frames(struct bpf_verifier_env *env, bool *do_print_state)
>> +{
> [ ... ]
>
>> +	/*
>> +	 * The call clobbered r1-r5, and r0 holds the zero the fixups put
>> +	 * there. Mark r0 unknown first: the known-zero helper keeps a NOT_INIT
>> +	 * type.
>> +	 */
>> +	clear_caller_saved_regs(env, cur_regs(env));
>> +	mark_reg_unknown(env, cur_regs(env), BPF_REG_0);
>> +	mark_reg_known_zero(env, cur_regs(env), BPF_REG_0);
> this isn't a bug, but could this use __mark_reg_const_zero(env,
> &cur_regs(env)[BPF_REG_0]), as process_iter_next_call() does, and drop
> the part of the comment that explains why two calls are needed?
>
> unwind_frames() sets r0 to a scalar zero in two steps here:
> mark_reg_unknown() sets the SCALAR_VALUE type, then mark_reg_known_zero()
> sets the value.  __mark_reg_const_zero() already sets the type to
> SCALAR_VALUE, the value to known zero, and precise to !bpf_capable in one
> call.  process_iter_next_call() and check_kfunc_call() both use it for
> r0 this way.

Okay, will do (with better code) in the next revision.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37884246994

