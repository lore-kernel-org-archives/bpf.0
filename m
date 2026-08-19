Received: from mta0.migadu.com (out-153.mta0.migadu.com [91.218.175.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA8480DCD
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154859; cv=none; b=EmXifJQXy6uZnqzPSwGMHxjbUwbp6DDiKO5n1rzbf4JoDw9NT3lbEX3xyTIHYQKvavz/zTf/275hbvhZrAhJb9+GO+h+nASRNCdd2bHgCzsp1wmM6u7vQFJ4l+d9B/ftHv/lnG+dZB+hFqKHuRhBw4lmy7zRlULbgMJjQ1LdWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154859; c=relaxed/simple;
	bh=ga4iCN9MpDHY01rWYETPo7NaSHPsYk+IP9nQrpDupE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXzp1/B7deOgf9lx6BgOoGua5Xudckyf6mAVmvxw8dt6A+p2pZqQnCpHC44iOITpBkZkG/zp4l2ozVs/i9weR2v36grIH8bsf5gAMWDil4YC+r4CNhS7zBV+xZcsDfxc6qGeCW7T2qLrTcQhJ2fBEUvbOn5WigIZOL2WwoX8Emg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dG2pp71t; arc=none smtp.client-ip=91.218.175.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dG2pp71t"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ga4iCN9MpDHY01rWYETPo7NaSHPsYk+IP9nQrpDupE4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787154855; v=1; x=1787759655;
 b=dG2pp71tw6mP+flcRkvv7mXVxeT4CXbI17Vlattm2inNryCH4DIZGZX1H/uF/MgAvJWDjhpg
 M7PP7DtavZRGfk3BNm31LkZU1YbspnQgatUMqLYUN46TJlfpont4HaE9JTcpg83huhrAoJmc0Zv
 Ya7kjU44JB/NqAU2oMl+Gyl8=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5d0e)
	by smtp.migadu.com with ESMTPS id 4607e8584e3dc236;
	Wed, 19 Aug 2026 15:54:15 +0000
X-Mizu-Trace-ID: 4607e8584e3dc236
X-Migadu-Flow: FLOW_OUT
Message-ID: <d1e1d798-4905-4d43-9b66-ac827f064381@linux.dev>
Date: Wed, 19 Aug 2026 08:54:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 04/10] bpf: Handle R2 as a return register in
 precision backtracking
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
 <20260819055259.3295829-1-yonghong.song@linux.dev>
 <20260819060306.6F2141F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260819060306.6F2141F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/18/26 11:03 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Multi-line comments do not follow the required BPF subsystem style.
> --
>
> --- Patch [4]: [PATCH bpf-next v7 04/10] bpf: Handle R2 as a return register in precision backtracking ---
> commit 827448f59c95b01086f128d7ec2894a154de5092
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Handle R2 as a return register in precision backtracking
>
> This commit updates precision backtracking to treat R2 as a return register
> alongside R0 at call/return boundaries. It clears R2 unconditionally when
> evaluating subprograms or kfuncs, and samples it before callback paths clear
> R1-R5.
>
>> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
>> index a2b18a9f1694c..653db80bcc47b 100644
>> --- a/kernel/bpf/backtrack.c
>> +++ b/kernel/bpf/backtrack.c
> [ ... ]
>
>> @@ -520,7 +524,25 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   					return -EFAULT;
>>   			}
>>   		} else if (opcode == BPF_EXIT) {
>> -			bool r0_precise;
>> +			bool from_subprog_call, r0_precise, r2_precise;
>> +
>> +			/* BPF_EXIT in subprog or callback always returns
> [Severity: Low]
> This isn't a bug, but does this multi-line comment follow the preferred BPF
> subsystem style? The opening /* is usually required to be on its own line.
>
>> +			 * right after the call instruction, so by checking
>> +			 * whether the instruction at subseq_idx-1 is subprog
>> +			 * call or not we can distinguish actual exit from
>> +			 * *subprog* from exit from *callback*. In the former
>> +			 * case, we need to propagate the precision of the
>> +			 * return registers, if necessary. In the latter we
>> +			 * never do that.
>> +			 */
>> +			from_subprog_call = subseq_idx - 1 >= 0 &&
>> +					    bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]);
>> +
>> +			/* Sample the return registers before the callback
> [Severity: Low]
> This isn't a bug either, but the same formatting question applies here. Should
> the opening /* be on its own line for multi-line comments?

We should be okay here.

>
>> +			 * handling below clears R1-R5.
>> +			 */
>> +			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
>> +			r2_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);

