Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F337A481
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119024; cv=none; b=gW/deXLwlwqtS3qC/Iuv0A+BCznNonoeW1C/ghbP7y6gCEPws9SMGS3txLUE4DlFNjkmQI7I+3azgU29fOR3pFEx8t1ON6soZFg9WNjQ/qCPRSNlfwTNP+haSi2vPkm3qyWtihECj9w6YRVPp6VwtZalmP7Gkl0PjORcubZh5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119024; c=relaxed/simple;
	bh=UgDP47cPkmBb/mueTtjUDjQ+T7ZjtzXnEDLcKSfkTG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/3WeIF0/3SJcFAddEksL1pQ8304fGfzh4MbC73BPh98GW2T5x3diHGSE72HYcM/qYv4wPFpwxcqsJo1A2hkNoxupemhOpUWzIARlZJuBC3KrrUo7nwMONzT5uehFeVNubNgDrDYTbsWfHeUo5u1sRpqVZNFRoff317r5meGkSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s3rUynAM; arc=none smtp.client-ip=91.218.175.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s3rUynAM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UgDP47cPkmBb/mueTtjUDjQ+T7ZjtzXnEDLcKSfkTG0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789119019; v=1; x=1789723819;
 b=s3rUynAMUddhG/IT+Lxn7P+wt+NzaIJOze3GYTNh+twvdDK10HnRWejtV6xIyUN2Cxz4a8iP
 Qa6K0SyURpWYUzCfzdsefEultbZmoUVvxejISLP5MIwBIvewK4E9crU/rnM+enxcz7l91OAjYVv
 nR7BH45jJ+xtShoDRT102uFo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b64bfc29917c1b89;
	Fri, 11 Sep 2026 09:30:03 +0000
X-Mizu-Trace-ID: b64bfc29917c1b89
X-Migadu-Flow: FLOW_OUT
Message-ID: <c0a15bf9-0922-42a7-b2a9-d7eff50669a5@linux.dev>
Date: Fri, 11 Sep 2026 14:59:57 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 03/13] bpf: track low-32 scalar equality
 across zero-extending movs
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260910164635.459558-4-vineet.gupta@linux.dev>
 <ad011852b5532901853fbc1c16d5a27d50231065dad9b1e4bbfee1c02b4735e5@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <ad011852b5532901853fbc1c16d5a27d50231065dad9b1e4bbfee1c02b4735e5@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/26 11:22 PM, bot+bpf-ci@kernel.org wrote:
>> @@ -17115,6 +17126,23 @@ static void collect_linked_regs(struct bpf_verifier_env *env,
>>   	}
>>   }
>>
>> +/*
>> + * Set @reg to the zero-extension of @known_reg's low 32 bits: it shares those
>> + * bits and its high half is zero. Copy the base to keep its precise low-32
>> + * tnum, then re-apply the zext_32_to_64() the 32-bit mov itself used.
>> + * @reg->id and ->delta already equal @known_reg's; only ->subreg is its own.
>> + */
>> +static void reconstruct_zext32(struct bpf_reg_state *reg,
>> +			       struct bpf_reg_state *known_reg)
>> +{
>> +	enum bpf_subreg subreg = reg->subreg;
>> +
>> +	*reg = *known_reg;
>> +	reg->subreg = subreg;
>> +	zext_32_to_64(reg);
>> +	reg_bounds_sync(reg);
>> +}
>> +
>>   /* For all R in linked_regs, copy known_reg range into R
>>    * if R->id == known_reg->id.
>>    */
>> @@ -17134,6 +17162,27 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
>>   			continue;
>>   		if (reg->id != known_reg->id)
>>   			continue;
>> +		/*
>> +		 * A ->subreg register shares only the base's low 32 bits, so it
>> +		 * is rebuilt rather than copied. Not modelled together with a
>> +		 * delta, so skip if either side has one (sound, less precise).
>> +		 */
>> +		if (reg->subreg) {
>> +			if (reg->add_const || known_reg->add_const)
>> +				continue;
>> +			reconstruct_zext32(reg, known_reg);
>> +			if (e->is_reg)
>> +				mark_reg_scratched(env, e->regno);
>> +			else
>> +				mark_stack_slot_scratched(env, e->spi);
>> +			continue;
>> +		}
>> +		/*
>> +		 * The reverse: known_reg knows only its low 32 bits, which say
>> +		 * nothing about reg's high half.
>> +		 */
>> +		if (known_reg->subreg)
>> +			continue;
>>   		/*
>>   		 * Skip mixed 32/64-bit links: the delta relationship doesn't
>>   		 * hold across different ALU widths.
> Can reconstruct_zext32() lose bounds that reg already learned on its own?
>
> Looking at the code, reconstruct_zext32() does:
>
>      *reg = *known_reg;
>      reg->subreg = subreg;
>      zext_32_to_64(reg);
>
> This overwrites reg's state wholesale without intersecting it with what reg
> already knew.
>
> For pre-existing full-64-bit links, sync_linked_regs() propagates changes
> in both directions, so the base is always at least as narrow as every
> member and the overwrite can only narrow. But the new low-32 link skips
> the member->base direction:
>
>      if (known_reg->subreg)
>          continue;
>
> so the base can end up strictly wider than the ->subreg member.
>
> Consider this sequence:
>
>    call bpf_get_prandom_u32;    /* r0 -> 64-bit unknown */
>    r6 = r0;                     /* r6 is 64-bit unknown */
>    w7 = w6;                     /* r7->id = r6->id, r7->subreg = SUBREG_ZEXT */
>    if w7 > 7 goto out;          /* fall-through: r7 u32 range [0,7]
>                                  * sync_linked_regs(known_reg=r7) skips r6 due
>                                  * to `if (known_reg->subreg) continue;`
>                                  * so r6 stays fully unknown */
>    if r6 > 100 goto out;        /* fall-through: r6 narrows to [0,100]
>                                  * sync_linked_regs(known_reg=r6) reaches r7
>                                  * via reconstruct_zext32(r7, r6) which does
>                                  * *r7 = *r6 then zext_32_to_64() */
>
> After the second jump, does r7 become [0,100] instead of staying [0,7]?

Yes it does and that's a problem.

> If so, a jump on an unrelated wide register would widen the bounds of a
> narrow copy that the verifier had already proved tighter, on a
> straight-line path. That would reject programs that narrowed the 32-bit
> copy first and the wide original second, then relied on the copy's
> narrower bound for a memory access or helper argument.

Right, sound, but loss of precision.

> The changelog acknowledges the other precision loss this patch introduces
> ("forming one costs the source its delta ... That loses tracking a wide
> source used to keep") and the follow-up selftest commit 36b84852a200 pins
> it down with zext_mov_breaks_add_const_src. But neither the changelog nor
> reconstruct_zext32()'s comment ("Copy the base to keep its precise low-32
> tnum"), nor any of the 10 new tests in 36b84852a200, mentions or covers
> this path. The only test that checks the member's fate is
> zext_narrow_dst_keeps_base, which verifies the base is not narrowed but
> does not check what happens to the member afterwards.

Ok. zext_sync_keeps_narrower_member() added and same for sext variant as 
reconstruct_sext32 gets similar fix.

> Would intersecting the rebuilt state with the member's existing one,

This one.

+       cnum64_intersect_with(&reg->r64, prev.r64);
+       cnum32_intersect_with(&reg->r32, prev.r32);
+       reg->var_off = tnum_intersect(reg->var_off, prev.var_off);

> narrowing the base's low half on the member->base direction instead of
> skipping it, prevent the member from ever being wider than what it already
> proved?

This is a new propagation path, trying to be conservative here.

Thx,
-Vineet

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34506184282

