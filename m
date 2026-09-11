Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34A3E0C7A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120828; cv=none; b=uslhMsrC0XVkTO7s+y/5pS8/xgTKzwlow9Y4CMGvjhEoJUgW+b/IxCc+gZjdooi0A0C7bzGRhMsHRcLMCYe/38cHnE1nCLwK2saWzDLUGQ8+GED4l8uOmPWBXmTPtk5uXfDEIfFwchOFWjcHS67TjeKDykE7aTtfeyuEuOtvK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120828; c=relaxed/simple;
	bh=a4FPr2KXlsFkRV0vRSFXbaQhHPOfudnmvDVa+wHqJbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=beHIO7+b4PhJth5LykLl2Viu2ik5UkgCm+1oQZtsBObvfnRUd0KwatFjuALzzO5d2GZzTyhAuSrfdVNMAp0t7L1IAzJm84VNfOHiGaSiTteCxmf5ENC8sopilNabUHNN/V2bGxW/OJJd6y7DTO9yRnVy+Bjafg5G4PsUL/+/Jc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jan8ZJqV; arc=none smtp.client-ip=91.218.175.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jan8ZJqV"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=a4FPr2KXlsFkRV0vRSFXbaQhHPOfudnmvDVa+wHqJbs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789120824; v=1; x=1789725624;
 b=Jan8ZJqVUQv4W3QPPSkmZr9su4pC/FyGyJCGpseluAbczInlnR4O9VqbP4H1vHkTzIhXnDtK
 Rzj6ZhblK+PrIBdL0xLLoba4L0Au3t42uoeJexizfCjactPvZmZGwLGIA3l0GJpGQwhlhKDDFgE
 YIxMnZLSQI/aEDRuvt58Wh3k=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fb675a7ecc21192d;
	Fri, 11 Sep 2026 10:00:20 +0000
X-Mizu-Trace-ID: fb675a7ecc21192d
X-Migadu-Flow: FLOW_OUT
Message-ID: <d2bfd056-2147-4002-a9ee-fa13bbf50dd9@linux.dev>
Date: Fri, 11 Sep 2026 15:30:15 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 07/13] bpf: track low-32 scalar equality
 across sign-extending movs
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260910164635.459558-8-vineet.gupta@linux.dev>
 <654adc93a03b1bbeef530ffb6adb9a2d204e5bb01d7707dc0b16889fb05fc3dd@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <654adc93a03b1bbeef530ffb6adb9a2d204e5bb01d7707dc0b16889fb05fc3dd@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/26 11:22 PM, bot+bpf-ci@kernel.org wrote:
>> @@ -16248,12 +16258,23 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>   						return -EACCES;
>>   					} else if (src_reg->type == SCALAR_VALUE) {
>>   						bool no_sext;
>> +						/*
>> +						 * A 32-bit sign extension keeps the low 32
>> +						 * bits, so record a low-32 link as the
>> +						 * zero-extending mov does. A self-mov
>> +						 * qualifies only if src is already linked.
>> +						 */
>> +						bool subreg_link = (insn->off >> 3) == 4 &&
>> +								   (src_reg != dst_reg ||
>> +								    src_reg->id);
>>
>>   						no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
>> -						if (no_sext)
>> +						if (no_sext || subreg_link)
>>   							assign_scalar_id_before_mov(env, src_reg);
>                                                          ^^^^
>
> Can widening this guard drop an existing ADD_CONST link on the source
> register?  With 'no_sext || subreg_link', assign_scalar_id_before_mov() now
> also runs on src_reg when !no_sext, and that helper discards the source's
> delta tracking:
>
> kernel/bpf/verifier.c:assign_scalar_id_before_mov() {
> 	...
> 	if (src_reg->add_const)
> 		clear_scalar_id(src_reg);
> 	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
> 		src_reg->id = ++env->id_gen;
> 	...
> }
>
> clear_scalar_id() zeroes id, delta, add_const and subreg, and the following
> statement then mints a brand-new id, so src_reg is unlinked from the
> register set it was tracking.  Before this commit the !no_sext arm left
> src_reg untouched.
>
> For a BPF_ALU64 | BPF_MOV | BPF_X with insn->off == 32:
>
> 	r1 = r2			/* r1, r2 share id N */
> 	r1 += 8			/* r1->add_const = ADD_CONST_64, r1->delta = 8 */
> 	r3 = (s32)r1		/* r1 is wide -> !no_sext, subreg_link true */
> 	if r2 < 100 goto out	/* sync_linked_regs() no longer reaches r1 */
> 	... use r1 ...
>
> At the mov, r1 loses its ADD_CONST_64 / delta = 8 link and gets a fresh id,
> so the following 'if r2 < 100' compare no longer refines r1 to [8, 107].
> Is that the intent?  This is the compiler idiom described in the comment
> above adjust_reg_min_max_vals()'s delta handling.
>
> The clear also does not look necessary for the new link: since !no_sext, the
> SUBREG_SEXT link is established through the freshly minted id.
>
> Would excluding add_const sources be enough, something like:
>
> 	bool subreg_link = (insn->off >> 3) == 4 && !src_reg->add_const &&
> 			   (src_reg != dst_reg || src_reg->id);

Indeed it needs to fixed with the additional !add_const check.

> The zero-extending arm added earlier in the series uses the same guard
> shape, so a fix likely wants to cover both.  Looking forward through
> 2c5433cf9fbb..1d3c4a0831be, the later commits extend the same mechanism to
> narrowing stack fills and spills and reuse the identical guard, so none of
> them change this.
>
>>   						*dst_reg = *src_reg;
>> -						if (!no_sext)
>> +						if (!no_sext && subreg_link && src_reg->id)
>> +							dst_reg->subreg = SUBREG_SEXT;
>                                                          ^^^^
>
> On a related note, for 'r0 = (s32)r0' where r0 carries add_const,
> subreg_link is evaluated before the clear and sees the old src_reg->id as
> non-zero, so it is true.  assign_scalar_id_before_mov() then clears and
> re-mints the id, and SUBREG_SEXT is applied to a register that is the sole
> holder of that id.
>
> The changelog says:
>
>> Unlike the zero-extending arm, a self-mov can form a link here, but only
>> when src is already linked: r0 = (s32)r0 is how a sign-extended int return
>> lands. On an unlinked register there is nothing to link to, and minting an
>> id would leave the register describing itself.
> bpf_clear_singular_ids() drops singleton ids before state comparison, so
> this does not look unsound, but does it match the rationale above?

yes the changelog needs to be fixed.

Thx,
-Vineet

>> +						else if (!no_sext)
>>   							clear_scalar_id(dst_reg);
>>   						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
>>   					} else {
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34506184282

