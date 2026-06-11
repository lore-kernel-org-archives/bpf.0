Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B89365A19
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154333; cv=none; b=AeZtcgqW2swkbvl09Rllua1X5N8DQPvTaz1WiKLngLB+qrXTezjvNQ85WvIK+U6C3u1iqhKz7NkF0zBQ1UKrVeJl5OPo4qbHz3qUN4FAisQNSdZcXFOpo0YaKD4EDPQi9m0+t062HVj6dthtbE7sYquBSfsOk5TN6ftgKEVFVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154333; c=relaxed/simple;
	bh=0Vp/CkXo4f4LibD/XuKyhEXDGKM30ok/hlm85tBQI14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6ittgsD5mLv6nsGlJbTbhq1ATvQqg1Oz6tOHrNui1znn/71X9ZjGp0qFhb3SOQ+oBpMGxOPKxRTjOh5Sqq65XX2QHpdQIVMNL3zfkgrs7KGpXB4D+3cDtwv4opT+PO+o5uSpb4wqbEWOsSy9pH5BJTsAfuP/jKNYKISo9vn6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OG3nAYAq; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OG3nAYAq"
Message-ID: <c00b2e74-c1eb-4441-a090-0d68fffe4376@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781154322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUVFqqm/60zjtt88IvfjuOrD2ZoPKjcgjmqQ+Vm2pzk=;
	b=OG3nAYAqEO05JuERQx1Bwg0tQgFRQen+Y+/YGIwMG68s6S4TNE1R50s5lp7rIbIYEkb/AB
	W05R1ZMH1wGf2/v1q1P8jljiykDyq2umWmbM2JPCAKpmqW0xhW3JmgijMd8RQCfTyimn3f
	TpGEg3EdNBlL30JL+5+7nigLjSAmi2M=
Date: Thu, 11 Jun 2026 13:04:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/9] bpf: Introduce global percpu data
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260608145113.65857-3-leon.hwang@linux.dev>
 <20260608151347.2C77D1F00893@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260608151347.2C77D1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 23:13, sashiko-bot@kernel.org wrote:
[...]
>> +
>> +			aux = &env->insn_aux_data[i + delta];
>> +			map = env->used_maps[aux->map_index];
>> +			if (map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
>> +				goto next_insn;
>> +
>> +			/*
>> +			 * Reuse the original ld_imm64 insn, and add one
>> +			 * mov64_percpu_reg insn.
>> +			 */
>> +
>> +			insn_buf[0] = insn[1];
>> +			insn_buf[1] = BPF_MOV64_PERCPU_REG(insn->dst_reg, insn->dst_reg);
> 
> [Severity: Critical]
> Can this crash the kernel if JIT compilation fails dynamically and falls back
> to the BPF interpreter?


Sounds reasonable.

I think it is a pre-existing issue, because the interpreter does not
support BPF_MOV64_PERCPU_REG() insn.

Also, the interpreter does not support user addr_space_cast insn.

Will fix them btw.

> 
> While env->prog->jit_requested checks if JIT was requested, it doesn't
> guarantee JIT success. If the interpreter (___bpf_prog_run()) executes this
> BPF_MOV64_PERCPU_REG instruction, it ignores the special BPF_ADDR_PERCPU
> offset (-1) for ALU64_MOV_X:
> 
[...]> kernel/bpf/verifier.c:check_mem_access() {
> ...
> 			if (tnum_is_const(reg->var_off) &&
> 			    bpf_map_is_rdonly(map) &&
> 			    map->ops->map_direct_value_addr &&
> 			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
> ...
> }
> 
> returning -EINVAL here propagates the error back up to check_mem_access()
> and aborts verification.
> 

Correct.

I've added a test to verify it that it will return -EINVAL for rdonly
percpu_array map.

Will exclude BPF_MAP_TYPE_PERCPU_ARRAY here, and add a test.

Thanks,
Leon

>>  	err = map->ops->map_direct_value_addr(map, &addr, off);
>>  	if (err)
>>  		return err;
> 

