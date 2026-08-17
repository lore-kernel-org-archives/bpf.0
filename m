Received: from mta1.migadu.com (out-191.mta1.migadu.com [95.215.58.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E02F7AD2
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937572; cv=none; b=QCw8JXdZCCBkrggEP9WCwpqWR5t30CJocc9MTtu9YkpSl6wxiBL9/uVYkEZZo258Mlr3D+QjUlJL2sLYXYWxaEMJL+4FYvzou1F/jisu6/OiZOYVCkpD63vGi/iD3mLV378JPz9lLbGFMTZ5aWG/jKmD3hD7/Fs3YrMDcK6xde8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937572; c=relaxed/simple;
	bh=cpmpbP2UkgmJOwV6bS7ua1hQpoezdgjLcHb/wQFxtNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFRnCJWkmAkKCr43HFrg4FcSteVH25EARYxoHCZEAYKB0U04nwl6KMeqtm/3Xa3KCvGCWkX014JhlVdvTL46Gyv1KYMD6w3Wi2J2mXJUMQ2TZ8cayKmrOwfQKH5y8IMQMSZ62xSGc+ppCPQjeoewQkrZ9uaDmftIp2JRIkaIp7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mCOU7cvq; arc=none smtp.client-ip=95.215.58.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mCOU7cvq"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cpmpbP2UkgmJOwV6bS7ua1hQpoezdgjLcHb/wQFxtNo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786937568; v=1; x=1787542368;
 b=mCOU7cvqvtq/GepSId/5UND/ETpqg6lPPYtrKmnqXlilcRx8bUwqpkmynrxyZ4SocVsAzHix
 wRHSvAnMqm7jri+NukUUHrwjilQ8KHIQXqWBGingA2axaBNBYtJVB+RkDPBaZZdbvOzqPsvyklK
 3DTA8kjZENw9uPSI56tzpv6w=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id 2bdf649410ccb99c;
	Mon, 17 Aug 2026 03:32:48 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <d14e1165-609c-4b54-b703-2a182615399c@linux.dev>
Date: Sun, 16 Aug 2026 20:32:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 04/11] bpf: Track R2 of register-pair returns
 in precision backtracking
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260813200230.1995389-1-yonghong.song@linux.dev>
 <5e43d273b5933f72fb0d45f3dcd67c149a371860391837680739df6555477e77@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5e43d273b5933f72fb0d45f3dcd67c149a371860391837680739df6555477e77@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/26 1:49 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
>> index a2b18a9f1694..0c8e05a7e175 100644
>> --- a/kernel/bpf/backtrack.c
>> +++ b/kernel/bpf/backtrack.c
>> @@ -423,6 +423,16 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   				 */
>>   				verifier_bug_if(idx + 1 != subseq_idx, env,
>>   						"extra insn from subprog");
>> +				/* a global subprog returning more than 8 bytes
>> +				 * sets R2 as well. R2 is part of the args mask
>> +				 * checked just below, so clear it here rather
>> +				 * than next to R0. Only a subprog that does
>> +				 * return a pair defines R2, so leave the mask
>> +				 * alone otherwise and let the check below catch
>> +				 * an R2 that has no business being set.
>> +				 */
>> +				if (bpf_ret_reg_pair(env, subprog))
>> +					bt_clear_reg(bt, BPF_REG_2);
> [ ... ]
>
>> @@ -506,6 +516,17 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   				return -ENOTSUPP;
>>   			/* regular helper call sets R0 */
>>   			bt_clear_reg(bt, BPF_REG_0);
>> +			/* a kfunc returning more than 8 bytes also sets R2.
>> +			 * R2 is part of the args mask checked just below, so
>> +			 * clear it here rather than next to R0. The prototype
>> +			 * lookup is only worth doing when R2 is requested at
>> +			 * all; any other call leaves R2 uninitialized, so a
>> +			 * request for it is caught by the check below.
>> +			 */
>> +			if (bt_is_reg_set(bt, BPF_REG_2) &&
>> +			    insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>> +			    bpf_kfunc_ret_reg_pair(env, insn))
>> +				bt_clear_reg(bt, BPF_REG_2);
> [ ... ]
>
>> @@ -520,7 +541,41 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   					return -EFAULT;
>>   			}
>>   		} else if (opcode == BPF_EXIT) {
> [ ... ]
>
>> +			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
>> +			r2_precise = false;
>> +			if (from_subprog_call && bt_is_reg_set(bt, BPF_REG_2)) {
>> +				call = &env->prog->insnsi[subseq_idx - 1];
>> +				subprog = bpf_find_subprog(env, subseq_idx + call->imm);
>> +				if (subprog < 0)
>> +					return -EFAULT;
>> +				/* Only a callee that does return a pair defines
>> +				 * R2. Leave the mask alone otherwise, so that
>> +				 * the check below still catches an R2 that has
>> +				 * no business being set.
>> +				 */
>> +				r2_precise = bpf_ret_reg_pair(env, subprog);
>> +			}
> [ ... ]
>
>> @@ -533,30 +588,27 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   			if (subseq_idx >= 0 && bpf_calls_callback(env, subseq_idx))
>>   				for (i = BPF_REG_1; i <= BPF_REG_5; i++)
>>   					bt_clear_reg(bt, i);
>> +
>> +			/* a callee returning more than 8 bytes sets R2 as well;
>> +			 * R2 is part of the args mask checked just below, so
>> +			 * clear it here rather than next to R0.
>> +			 */
>> +			if (r2_precise)
>> +				bt_clear_reg(bt, BPF_REG_2);
> This isn't a bug, but the "R2 is part of the args mask checked just
> below, so clear it here rather than next to R0" rationale appears at
> each of the three call boundaries (global subprog, kfunc, and BPF_EXIT).
> Would stating it once - say at the first site, or in a note above the
> BPF_EXIT block - and keeping the other two to a one-liner read more
> easily?

Eduard suggested to remove the condition "r2_precise" for bt_clear_reg(bt, BPF_REG_2)
which should solve the problem.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31740414277

