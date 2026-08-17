Received: from mta1.migadu.com (out-223.mta1.migadu.com [95.215.58.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA18303CAB
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937723; cv=none; b=uyHLe4etjDN0uqo9cxp2O23Z5BREKNw0nWuMK3ekfhmFXfJ4nKtWvXIuvF3KEkl0/UZhCkSQ7XeUtcLkRjPtU1Dtnv4CjcoD4zitZ5HIkZkASQ6iGwWKlVojb+Cpbyk6AVgea35KHC8fxUBYfhUtsnKkY/NBt6vMAapl37A/Erw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937723; c=relaxed/simple;
	bh=341gYsVcuEDX1S12g4bLB1dRDrCJlTLFjfno5jIK05M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ej8+CMDZfDVNI7bImfq2RfQaDUUybi0SFZohLpudif76hhJiTHfCpGosiRTwFLJm4qBN1A48mw8bHfYW3uaJLM0QmaGVm5Xs0z7hgSfrVvu7T9XN8OkHdxPWOWNqv8WAwLR83OtgmrP5ZliktFqayUEfBUI7ZedpyMg+nhFw23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jLn4equ+; arc=none smtp.client-ip=95.215.58.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jLn4equ+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=341gYsVcuEDX1S12g4bLB1dRDrCJlTLFjfno5jIK05M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786937720; v=1; x=1787542520;
 b=jLn4equ+go/OBc2O4BcyNwMRjRl/SrRbFJmBPb2LZzMH11CQ7r/sW1dGINTKqMdSmtrfh8Co
 KuvL4YqD4HUc+yEphmLSdmmHuSEsvUPWPohsPzh/u4Cg8fk5O16nH2BfmODwcmrdNIeOAZg44FK
 fEms/prBs2v5mIe/4xaJ574Q=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id c03165809de37c4c;
	Mon, 17 Aug 2026 03:35:20 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <6058f12d-dd67-4795-bb06-a76e79edec16@linux.dev>
Date: Sun, 16 Aug 2026 20:35:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 05/11] bpf: Account R2 of register-pair
 returns in live register analysis
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200235.1995574-1-yonghong.song@linux.dev>
 <20260814015034.EDD381F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260814015034.EDD381F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/26 6:50 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Static (non-global) BPF subprograms returning a register pair are functionally broken because the verifier does not propagate R2 back to the caller frame.
> --
>
> --- Patch [5]: [PATCH bpf-next v5 05/11] bpf: Account R2 of register-pair returns in live register analysis ---
> commit 35ab629244a73b2ad2baa7b7f0fd5b365c1b35e9
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Account R2 of register-pair returns in live register analysis
>
> This commit updates the live register analysis to correctly mark R2 as read
> at the BPF_EXIT of a subprogram that returns a register pair. This prevents
> R2 from being considered dead and pruned incorrectly.
>
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index 74fc4b3f80d6e..71f998c6eb888 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
> [ ... ]
>> @@ -2191,7 +2193,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
>>   			break;
>>   		case BPF_EXIT:
>>   			def = 0;
>> -			use = r0;
>> +			use = ret_reg_pair ? (r0 | r2) : r0;
>>   			break;
> [Severity: High]
> This is a pre-existing issue, and wasn't introduced by this patch, but while
> we are fixing liveness tracking for register-pair returns here, is the
> propagation of R2 back to the caller missing in the verifier?
>
> Looking at prepare_func_exit() in kernel/bpf/verifier.c:
>
>      } else {
>          /* return to the caller whatever r0 had in the callee */
>          caller->regs[BPF_REG_0] = *r0;
>      }
>
> When a static BPF subprogram returning a 16-byte struct is called,
> check_func_call() sets all caller-saved registers (including R2) to NOT_INIT.
> When the callee exits, it seems we only copy BPF_REG_0 back to the
> caller's state, leaving BPF_REG_2 as NOT_INIT.
>
> If the caller attempts to read the second half of the returned struct in R2,
> will the verifier reject it with an 'R2 !read_ok' error?

We should be okay here. The next patch will actually introducing return value
R2 in various places.

>

