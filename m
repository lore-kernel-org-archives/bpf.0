Received: from mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E44C4248C5
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379445; cv=none; b=JWmwecjASzPYnhXVVmD1QatREfonYEGi1ovIyX/dl52h1zS0Gr6nub6DwCNURQl4Glmhvxc6ZEKGDr8qhyVK7fZ9a18HjDaFFLpBdoZw/EA47Qjm3lgdsRLYat03/b6q+Ol+i0bd0M4mmQxFWYoXUyWaTXOJiYstOiFnRUH2y3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379445; c=relaxed/simple;
	bh=TsuFQA3Rj2PI0+TWEANhtZAp4unYhBMhzW7DTmziipI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkNdD4qYEhmVXFox/Q3QtsUzdbPRFBYvgXt335xNanHTOxh61TDcZJ7EMnlhIxZxZ6Yh7ey87O4KC+O7qeq9+ggXWFayx9CvSThUC1xSmlAVhderlNu+NXGZ+tY2Q1044mMQkSxI4DUfaVftvYV05mpm5Q9d8gfHSXtCDpo20nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fsnGIu4E; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fsnGIu4E"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TsuFQA3Rj2PI0+TWEANhtZAp4unYhBMhzW7DTmziipI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786379440; v=1; x=1786984240;
 b=fsnGIu4EzawWoH9v0xOOoVtF3tbDoogLh3qRKRBirx0g3hsvJvSIJ7B10FLV4qn3TzOpWrW3
 M58e9sp9qYjfnXJaaLSUvs3aR6xok6KrqQNvgmMt8Yrs6Hw8B9VcSwD60wlKR4SLfnOwZhhdsFn
 GgpRM61xBPAZik4dw6u6/QgI=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::5:2f4a)
	by mta12.migadu.com with ESMTPS id 941a77c603204cb0;
	Mon, 10 Aug 2026 16:30:40 +0000
X-Migadu-Scanner: mta12.migadu.com
Authentication-Results: mta12.migadu.com;
	none
Message-ID: <3ea98b14-849c-451e-bf19-4eeaca0eea59@linux.dev>
Date: Mon, 10 Aug 2026 09:30:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 04/13] bpf: Track R2 of register-pair returns
 in precision backtracking
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
 <20260808190342.1898844-1-yonghong.song@linux.dev>
 <20260808192904.963E81F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260808192904.963E81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 12:29 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Multi-line comments do not follow the required BPF subsystem comment style.
> --
>
> --- Patch [4]: [PATCH bpf-next v3 04/13] bpf: Track R2 of register-pair returns in precision backtracking ---
> commit 031a41deb76f72f449ddf5239bbf769a2cbe7e5c
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Track R2 of register-pair returns in precision backtracking
>
> This commit updates the BPF verifier's precision backtracking to correctly
> handle R2 for functions returning values larger than 8 bytes. It ensures
> R2 is cleared from or added to the register mask across function call
> boundaries to prevent unexpected register mask verification failures.
>
>> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
>> index 40bd04421a991..9b112bf427a57 100644
>> --- a/kernel/bpf/backtrack.c
>> +++ b/kernel/bpf/backtrack.c
> [ ... ]
>> @@ -425,6 +425,14 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   				 */
>>   				verifier_bug_if(idx + 1 != subseq_idx, env,
>>   						"extra insn from subprog");
>> +				/* a global subprog returning more than 8 bytes
>> +				 * sets R2 as well. R2 is part of the args mask
>> +				 * checked just below, so it has to be cleared
>> +				 * here rather than next to R0.
>> +				 */
> [Severity: Low]
> This isn't a bug, but does this multi-line comment follow the preferred
> BPF subsystem style? The guidelines specify that the opening /* should be
> on its own line rather than sharing a line with the text.
>
>> +				if (bt_is_reg_set(bt, BPF_REG_2) &&
>> +				    bpf_ret_reg_pair(env, subprog))
>> +					bt_clear_reg(bt, BPF_REG_2);
> [ ... ]
>> @@ -522,7 +543,29 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   					return -EFAULT;
>>   			}
>>   		} else if (opcode == BPF_EXIT) {
>> -			bool r0_precise;
>> +			bool from_subprog_call, r0_precise, r2_precise = false;
>> +
>> +			/* BPF_EXIT in subprog or callback always returns
>> +			 * right after the call instruction, so by checking
>> +			 * whether the instruction at subseq_idx-1 is subprog
>> +			 * call or not we can distinguish actual exit from
>> +			 * *subprog* from exit from *callback*. In the former
> [Severity: Low]
> This is also not a bug, but since this comment is being heavily modified,
> could it be updated to place the opening /* on a separate line to match
> the modern BPF comment style?
>
>> +			 * case, we need to propagate the precision of the
>> +			 * return registers, if necessary. In the latter we
>> +			 * never do that.
>> +			 */

Comment format issue. Will fix in the next revision.

