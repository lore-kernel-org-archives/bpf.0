Received: from mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625704B048C
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937620; cv=none; b=NBtiP3t/Q/SNWuQWAqMxgPgNL0Aj/XLtdvHxFPytiKYADjYErCq6cOLbiJi+sMHhpFhNbAQ5YC3UZQNoXB8F4YKUbGvwYVJXgu1QAV40XDQ3JapwytJQIli1TDRuAUuk2gvzDuutmKW+ITkHpPQ9RreN/ANtIqQfZovJpdghH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937620; c=relaxed/simple;
	bh=vvC3dM27Xtu5k7ZZ8TVO3Z4bB5tjgdcr8qGCHNmEGyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX6m++RXk2aZMUfm8NnI6BqJjdqV5wNha5P83JofB3N2ZdmVXOmnu4S2Wub7tOfMJh2LWxakQLovUDwI9aDplC2gzda8Ry6/ESegexxIQTF6SrBhLu3rh3TRsb+GjSFyXyL7YGGo/ulyJRUvHDzhUhM1ub7RiLUvCqtmiO48dpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ind734pX; arc=none smtp.client-ip=95.215.58.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ind734pX"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vvC3dM27Xtu5k7ZZ8TVO3Z4bB5tjgdcr8qGCHNmEGyY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786937616; v=1; x=1787542416;
 b=Ind734pXLYUvhXjltm+qJaBdJZscpRBBHItqzfIX07FIpuy5Q1n7SFdlC6djBwzmnz7zMMyz
 nQbMnUA0JXK75q9iITIkNodVaYPKS+wgiJ6/0IaxkVzaH/oFZWt62g+a/ApUagghihtlZeL23dU
 LM1Hcrd+yvXU3Y3FK6gjzKWM=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id e2f5301ab50edf18;
	Mon, 17 Aug 2026 03:33:36 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <7dfa0e95-2a23-439f-98d6-308eeefb321d@linux.dev>
Date: Sun, 16 Aug 2026 20:33:29 -0700
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
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200230.1995389-1-yonghong.song@linux.dev>
 <206e8cd41f7955e6526b78df4f9bfd2307b13260.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <206e8cd41f7955e6526b78df4f9bfd2307b13260.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/26 4:37 PM, Eduard Zingerman wrote:
> On Thu, 2026-08-13 at 13:02 -0700, Yonghong Song wrote:
>
> ...
>
>> @@ -520,7 +541,41 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   					return -EFAULT;
>>   			}
>>   		} else if (opcode == BPF_EXIT) {
>> -			bool r0_precise;
>> +			bool from_subprog_call, r0_precise, r2_precise;
>> +			struct bpf_insn *call;
>> +			int subprog;
>> +
>> +			/* BPF_EXIT in subprog or callback always returns
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
>> +			 * handling below clears R1-R5: unlike R0, R2 is an
>> +			 * argument register as well, so that clear would drop
>> +			 * a pair return on the floor.
>> +			 */
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
>>   
>>   			/* Backtracking to a nested function call, 'idx' is a part of
>>   			 * the inner frame 'subseq_idx' is a part of the outer frame.
> I still think that the above complications are unnecessary.
> The patch could be simplified by assuming that R2 always propagates
> w/o loosing verification safety. E.g. as in the attachment.

Ack. Thanks and will adopt your suggestions.


