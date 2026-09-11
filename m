Received: from mta0.migadu.com (out-125.mta0.migadu.com [91.218.175.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C8F44A3E0
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109816; cv=none; b=BCELIrNjaH+pFdtdQaMMTzwBGeU+vVrqoow8mhKlMvmVjvt5iSjIodEuRP/4XbZ7n0jW11G+xNHYIygG/kOox/iDHF83gCqUANTldmnqj7WHcevk8ozyDz+/NhN+CVAz1lwOLPrTanp5x5hxRXg0n8hnGnJ8kKFxaNwPZ6jhBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109816; c=relaxed/simple;
	bh=6q7xhltJVHuVK0l5YFqev8/dZwx/prHRRWYUGv6SSwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=deRZicTxT2hyEc8XrPHv04ToOO5d7O+RzMF/gNkzb65M9IpvBtgDGu0nkPDPUmSQ5BXOzbzxEP7NBh5134GSPChec+bn4DDidd/z3qpIYuRMY5etCyV10y0FN7mKL9N7veuLexpgqK1rfKin7Ogj1ZYuPvfiGxggLQr77nwrd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qw50Qb75; arc=none smtp.client-ip=91.218.175.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qw50Qb75"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6q7xhltJVHuVK0l5YFqev8/dZwx/prHRRWYUGv6SSwQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789109803; v=1; x=1789714603;
 b=qw50Qb75QOHEtrwrBgEwgBMkJGQUIECXkpNQ6LKBr78RSf145jnxeinpJrVnIPuNMDE6O21C
 xRUBnILR4JoYPGMCkzg2XxCDvSpYToh8b/FuyrvB/5J7EWgwW7DImiZQAsxJ1XZX1U7J6QHUbRR
 q/zW2r2m1QDXhRNZM7GcXi7U=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6991f43a9b2606fa;
	Fri, 11 Sep 2026 06:56:43 +0000
X-Mizu-Trace-ID: 6991f43a9b2606fa
X-Migadu-Flow: FLOW_OUT
Message-ID: <6d7d2969-34a2-4c6e-b8f2-3b85cfad549f@linux.dev>
Date: Fri, 11 Sep 2026 12:26:37 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of
 bpf_reg_state->id [NFC]
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-2-vineet.gupta@linux.dev>
 <20260910170056.87B091F0089B@smtp.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20260910170056.87B091F0089B@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/10/26 10:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unintentional stricter pruning in explore_alu_limits mode causing state explosion.
> --
>
> commit aa1d987a87f62f32dd84baa98f047ffd7635c40e
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> bpf: move linked-scalar flags out of bpf_reg_state->id [NFC]
>
> This commit moves the linked-scalar flags (ADD_CONST32 and ADD_CONST64) out of
> the bpf_reg_state->id field and into a separate add_const bitfield. This
> simplifies ID tracking by removing the need to mask the ID during checks.
>
>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>> index 66fb11b6c6a76..d974baad37ee2 100644
>> --- a/kernel/bpf/states.c
>> +++ b/kernel/bpf/states.c
> [ ... ]
>
>> @@ -542,8 +527,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>>   			/* explore_alu_limits disables tnum_in() and range_within()
>>   			 * logic and requires everything to be strict
>>   			 */
>> -			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
>> -			       check_scalar_ids(rold->id, rcur->id, idmap);
>> +			return regs_exact(rold, rcur, idmap);
>>   		}
> [Severity: Medium]
> Does this unintentionally introduce a stricter pruning check when
> explore_alu_limits is active?
>
> The commit message notes that using regs_exact() amounts to the same as the
> open-coded memcmp plus check_scalar_ids() pair. However, check_scalar_ids()
> allows old_id to be 0 by returning true immediately (ignoring cur_id):
>
> 	if (!old_id)
> 		return true;
>
> On the other hand, regs_exact() calls check_ids(), which strictly enforces
> that both IDs are either zero or non-zero, and fails if they differ:
>
> 	/* either both IDs should be set or both should be zero */
> 	if (!!old_id != !!cur_id)
> 		return false;
>
> When env->explore_alu_limits is true, comparing two equivalent scalar
> registers where one is unlinked (ID == 0) and the other is linked (ID != 0)
> would pass previously but fails now, potentially causing state explosion.

The regs_exact() replacement was suggested in RFC review. And it is true 
it can be tighter.
Since the rest of series changes behavior anyways, I'm inclined towards 
dropping the NFC and document the change. And if we go down this part, 
perhaps patch 2 can also be folded into this one as that was the sole 
reason for breaking it out.

Thx,
-Vineet
