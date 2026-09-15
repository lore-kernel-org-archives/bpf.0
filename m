Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0375531355C
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510118; cv=none; b=lfhjaf790aMt8WhcsNw3KN5ooanUD+4M8sDY5K6QEvZ+hmxZNWI3hR+pPibGB9MVYseaGObcz1S6v1ly6v5L26LvKDxc+A2kyZqB7YIu6ZyMhlk3Fkxuzkb82qlY8mtX2FN+InIL7yOiTSKeEg2Qr4mnxGpo6saE2WhgURFIsc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510118; c=relaxed/simple;
	bh=A37HkCwaw8sH5HmzUhu1ht6ab73vHd8c3KMufJ/82cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YulN6zJagy2ptQZ37A3vzipw/mh7snuAgdJsweA1H5IDJJIW3R6Zzql+YpSKUMoXC/XHmnGP8LQ4+W0F99GoJRHNOWszbSTlBUx88YKK83mjkUA9HD8plgk4if6TYkYAXq6rWH33L+IMWuf0h5Qrap0OfIn1VO4hSKvBw5v5DaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dDZ5yCvQ; arc=none smtp.client-ip=91.218.175.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dDZ5yCvQ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A37HkCwaw8sH5HmzUhu1ht6ab73vHd8c3KMufJ/82cA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789510115; v=1; x=1790114915;
 b=dDZ5yCvQrCY6S8dMwteKOOzUNcLooi67ihVprfiGojTreiTuac1D6h4BMcA3H7Nl+T+YMxYG
 /aCfJAM6+H4aRSd+qvDlJhYucT1oH0eTazjnR3wGix2srmx24kLA4exg4GnI7O4DIa+nuVhUg8V
 G2I9x/sZgGEtelvg91AonbsY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 89c315bdab0e4b39;
	Tue, 15 Sep 2026 22:08:24 +0000
X-Mizu-Trace-ID: 89c315bdab0e4b39
X-Migadu-Flow: FLOW_OUT
Message-ID: <b1f31312-0f2d-4965-9bd4-d27a11b9d9fb@linux.dev>
Date: Tue, 15 Sep 2026 15:08:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 12/13] bpf: track low-32 scalar equality
 across narrowing stack spills
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-13-vineet.gupta@linux.dev>
 <20260910170600.0DFBA1F00893@smtp.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20260910170600.0DFBA1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/26 10:05 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Sign-extending loads from 32-bit narrowing spills incorrectly inherit and preserve a `SUBREG_ZEXT` link, causing a critical discrepancy between verifier bounds and runtime values.
> --
>
> commit 3396576ba1c56571ccd9a040716058594f558da8
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> bpf: track low-32 scalar equality across narrowing stack spills
>
> This commit allows the verifier to track a SUBREG_ZEXT relationship when a
> 64-bit scalar is narrowed during a 4-byte stack spill. This preserves the
> knowledge of the lower 32 bits for subsequent loads.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6cb35fc0d0fb0..9e63eddb9023b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -3678,8 +3687,15 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>>   			 * it came from.
>>   			 */
>>   			coerce_reg_to_size(&state->stack[spi].spilled_ptr, size);
>> -			/* Break the relation on a narrowing spill. */
>> -			clear_scalar_id(&state->stack[spi].spilled_ptr);
>> +			if (subreg_link && reg->id)
>> +				state->stack[spi].spilled_ptr.subreg = SUBREG_ZEXT;
> [Severity: Critical]
> Can this lead to verifier state corruption when the spilled value is later
> read with a 4-byte sign-extending load (BPF_MEMSX)?
>
> If a BPF program performs 64-bit arithmetic to create an unknown scalar and
> spills it to the stack via a 4-byte narrowing store, it records a SUBREG_ZEXT
> link here and coerces its bounds to 32 bits.
>
> If it then reads it back via a 4-byte sign-extending load, when processing
> the read in check_stack_read_fixed_off(), narrowing evaluates to false since
> the bounds were already truncated during the spill:
>
> 	bool narrowing = get_reg_width(reg) > size * BITS_PER_BYTE;
>
> As a result, subreg_link is false, and the verifier skips the
> is_ldsx ? SUBREG_SEXT : SUBREG_ZEXT correction logic. The destination
> register blindly inherits the stack slot's SUBREG_ZEXT link.
>
> In check_mem_access(), coerce_reg_to_size_sx() properly sign-extends the
> loaded value's bounds, but because the subreg link is non-zero, it skips
> breaking the scalar ID:
>
> 	if (!no_sext && !regs[value_regno].subreg)
> 		clear_scalar_id(&regs[value_regno]);
>
> The register now has sign-extended bounds but a SUBREG_ZEXT link to the
> original 64-bit scalar.
>
> If the original scalar is later refined, sync_linked_regs() will invoke
> reconstruct_zext32(), completely overwriting the sign-extended bounds with
> zero-extended bounds. The verifier will incorrectly assume the register holds
> a positive value, while at runtime it holds a negative sign-extended value.
>
> Does this permit arbitrary out-of-bounds kernel memory accesses?

Yes there's a bug here. A narrowing spill records SUBREG_ZEXT, 
truncating the slot, and a later 4-byte ldsx has narrowing == false, 
inherits the slot's SUBREG_ZEXT  leaving sign-extended bounds under a 
zero-extending link.

Fixed by making the sign-extension path drop any link that is not 
already SUBREG_SEXT:

   -   if (!no_sext && !regs[value_regno].subreg)
   +   if (!no_sext && regs[value_regno].subreg != SUBREG_SEXT)
               clear_scalar_id(&regs[value_regno]);

Also added a test to that effect.

Thx,
-Vineet

>
>> +			else
>> +				/*
>> +				 * Nothing to relate: either the source has no
>> +				 * id to share, or the store is narrower than
>> +				 * the 32 bits a link can describe.
>> +				 */
>> +				clear_scalar_id(&state->stack[spi].spilled_ptr);
>>   		}

