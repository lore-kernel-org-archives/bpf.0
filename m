Received: from mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262F04D2EFE
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860904; cv=none; b=JfrLnuVnbNugjHBI7vwwmg5FgjIve4NebrlDrb177B63ztiZ2bCITmfpnmc4i0jFgBll5sQtB7UM7yJHMvzde0K4c2SGp8XueSdrNc/0IMwllyWbYOxg5zXLm1FLkJ4vUN757c5lCNsgJoIzpL5Vd9aDcNg8V9AM2PK/vaG+X+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860904; c=relaxed/simple;
	bh=/ZYMYmpgg2XO2vAXyids1UUAianNNzROZUceYBbtSIE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=meVJoWZyiu2rLOUcE2udxqWYaSXZeSA4E1Pp4J95xcEStzy2eRUEAc1SWobX7JooJT2wEH7cH6G8iPVyT9YzMrZ388BRXVTSGJ8WPjlPn03aMt8Vz3tkeGYH+yars2w6YXSZjsUq5t5FDeoBXZ2yyzLtLcv89qCRpSNqCWTN4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i1XKcynH; arc=none smtp.client-ip=95.215.58.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i1XKcynH"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/ZYMYmpgg2XO2vAXyids1UUAianNNzROZUceYBbtSIE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788860900; v=1; x=1789465700;
 b=i1XKcynHmMUe8EgY2eXn36Idv5ukbAVndYr1DqCBO6UgOZLgQ+PBSnMsQz6dWbHtFD1s+oGI
 eYm+O+hI5qyjekJ7JofO9LS9mOpd95+t1kODWgEakarHd4I0g34d/y8WEDQTaXO0tXg6wpfl86F
 xPkj0QlZul2XiIcQK9jLdlFE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 41922c109361a687;
	Tue, 08 Sep 2026 09:48:10 +0000
X-Mizu-Trace-ID: 41922c109361a687
X-Migadu-Flow: FLOW_OUT
Message-ID: <e0249bc4-c14d-4df3-b798-bc6fb06ae436@linux.dev>
Date: Tue, 8 Sep 2026 15:18:04 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vineet Gupta <vineet.gupta@linux.dev>
Subject: Re: [RFC bpf-next 3/6] bpf: support low-32 subreg scalar linking for
 zero-extending movs
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
 <20260814231945.3884596-4-vineet.gupta@linux.dev>
 <04238b5fe022a851b8e1fad0af03dd45c15faf7c.camel@gmail.com>
Content-Language: en-US
In-Reply-To: <04238b5fe022a851b8e1fad0af03dd45c15faf7c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/26 9:09 AM, Eduard Zingerman wrote:
> On Fri, 2026-08-14 at 16:19 -0700, Vineet Gupta wrote:
>> Problem
>> =======
>> Currently register equality tracking and propagation only works for full
>> 64-bits (with additional constant offset). It is missing the
>> relationship: "these two regs share only their low 32-bits".
>>
>> An illustrative snippet:
>>
>>>   r6 = ...                    /* full 64-bit unknown */
>>>   w7 = w6                     /* 32-bit zero-extend mov from wide src */
>>>   if w6 != 0 goto .Lxx        /* branch not taken, src narrowed */
>>>   if w7 == 0 goto .Lok   <-- missing
>> It works if the register is narrow to begin with, e.g.
>>>   r6 = *(u32 *)(...)
>> Rephrased in verifier speak:
>>
>> The linked-scalar equality relation sync_linked_regs() maintains is full
>> 64-bit only; there is no subregister (low-32) equality link.
>> A 32-bit mov (w1 = w2) is therefore either promoted to a full-64-bit link
>> when the source is provably u32, or the link is dropped entirely when the
>> wider source has unknown high bits. A later narrowing of the source to its
>> low 32 bits never reaches dst, causing safe programs to be rejected. Note that
>> the ADD_CONST32 machinery only applies to += const offset, not to equality.
>>
>> This was seen with bpf-gcc codegen that tends to reuse "w0 = idx" for
>> "return 0" on an idx==0 path, for bpf_loop callbacks.
>>
>> Solution
>> ========
>>   - Introduce a low-32-only link, BPF_FLAG_SUBREG_ZEXT, added to BPF_FLAG_LINK.
>>   - For a wide-source 32-bit mov, mark dst with BPF_FLAG_SUBREG_ZEXT instead
>>     of clearing it (when src carries a scalar id).
>>   - On a later low-32 narrowing sync_linked_regs() re-derives such a register as
>>     the zero-extension of the base's low 32 bits: it copies the base (keeping its
>>     precise low-32 tnum) and re-applies zext_32_to_64() -- the same helper the
>>     32-bit mov used -- which is sound even when the source has unknown high bits.
>>     This is applied only when neither side carries an ADD_CONST delta (the
>>     combined subreg+delta case is not modeled).
>>   - Sites that group a subreg-linked register by its scalar id compare ->id
>>     directly: no masking is needed, since BPF_FLAG_SUBREG_ZEXT lives in
>>     ->flags.
>>
>> The reconstruction copies the base wholesale, so it must put back the fields
>> that identify reg rather than known_reg -- ->id and, now, the link flag. This
>> mirrors what the ADD_CONST arm below already does ("Must preserve off and id,
>> otherwise another sync_linked_regs() will be incorrect"). Dropping the flag
>> while keeping the ->id would be worse than losing the link: the register would
>> claim a full 64-bit equality with a base whose high bits are unknown, and the
>> next sync driven by it would copy a narrowed low-32 value straight onto the
>> base's high half.
>>
>> The link_flags_match() helper added by the previous patch is widened from
>> BPF_FLAG_ADD_CONST to BPF_FLAG_LINK, so regs_exact() -- and through it
>> states_maybe_looping() -- discriminates the new flavour as well. regsafe()
>> additionally checks it early, before the explore_alu_limits and !precise
>> short-circuits, which the helper's call site below them does not cover.
>>
>> Note: the sync_linked_regs() reconstruction is wrapped in an extra block that
>> looks redundant here. It is a placeholder for the sign-extension counterpart
>> patch, which turns it into the else arm of an if/else on the link flavour;
>> keeping it now avoids re-indenting the whole body there.
>>
>> Results
>> =======
>> Improves verifier tracking (seen in the next selftest).
>> selftest runs:
>>   - clang: no new regressions (-mcpu=v3 and v4)
>>   - bpf-gcc: no new regressions; the measurable selftest pass improvements
>>     come with the sign-extension counterpart patch.
>>
>> Signed-off-by: Vineet Gupta<vineet.gupta@linux.dev>
>> ---
> As a general comment, please make the commit messages and comments
> less verbose.

To be honest a lot of this commentary was my own, but yeah I get it.

>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>> index d3105b9a9965..ef71999c4695 100644
>> --- a/kernel/bpf/states.c
>> +++ b/kernel/bpf/states.c
>> @@ -490,6 +490,9 @@ static int clean_verifier_state(struct bpf_verifier_env *env,
>>    *
>>    * Only meaningful when rold carries an id: the flags are only ever set
>>    * together with one, so rold->id == 0 implies none of them is set.
>> + *
>> + * BPF_FLAG_LINK covers every flavour, so this widens automatically as new
>> + * ones are added.
>>    */
>>   static bool link_flags_match(const struct bpf_reg_state *rold,
>>   			     const struct bpf_reg_state *rcur)
>> @@ -497,7 +500,7 @@ static bool link_flags_match(const struct bpf_reg_state *rold,
>>   	if (!rold->id)
>>   		return true;
>>   
>> -	return (rold->flags & BPF_FLAG_ADD_CONST) == (rcur->flags & BPF_FLAG_ADD_CONST);
>> +	return (rold->flags & BPF_FLAG_LINK) == (rcur->flags & BPF_FLAG_LINK);
>>   }
>>   
>>   static bool regs_exact(const struct bpf_reg_state *rold,
>> @@ -554,6 +557,24 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>>   
>>   	switch (base_type(rold->type)) {
>>   	case SCALAR_VALUE:
>> +		/*
>> +		 * A low-32-bit-only link has different sync_linked_regs()
>> +		 * semantics than a full/ADD_CONST equality. check_scalar_ids()
>> +		 * only ever sees the plain ->id and never looks at ->flags, so a
>> +		 * mismatch must be rejected explicitly.
>> +		 * Check it here, before the explore_alu_limits and !precise
>> +		 * short-circuits below (neither of which tests it). Note the
>> +		 * pre-existing BPF_FLAG_ADD_CONST check sits after those
>> +		 * short-circuits instead. The argument for checking early
>> +		 * applies to it equally, but moving it makes regsafe() stricter
>> +		 * on a path that predates this series, which is a pruning change
>> +		 * that wants measuring on its own; it is deliberately left
>> +		 * alone here.
>> +		 */
>> +		if (rold->id &&
>> +		    (rold->flags & BPF_FLAG_SUBREG_ZEXT) != (rcur->flags & BPF_FLAG_SUBREG_ZEXT))
>> +			return false;
>> +
> Why is this check here? Isn't it covered by the changes in link_flags_match()?

Removed.
FWIW it is added to regs_exact and for the other instance it is part of 
now open-coded link_flags_match call-site.

>> @@ -15076,15 +15076,42 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>   					if (insn->off == 0) {
>>   						bool is_src_reg_u32 = get_reg_width(src_reg) <= 32;
>>   
>> -						if (is_src_reg_u32)
>> +						/*
>> +						 * *dst_reg = *src_reg below copies src's id into dst, a
>> +						 * full 64-bit equality link. That is only sound when src
>> +						 * fits in u32: a 32-bit mov zero-extends dst, so for a
>> +						 * wider src the link would let sync_linked_regs()
>> +						 * propagate dst's [0, U32_MAX] range back onto src's
>> +						 * unknown high bits. For a wide src drop the full link
>> +						 * and form a low-32-only BPF_FLAG_SUBREG_ZEXT link instead, so a
>> +						 * later narrowing of src's low 32 bits still reaches dst.
>> +						 *
>> +						 * wide_subreg_link gates that low-32 link and excludes:
>> +						 *  - a self-mov (w6 = w6): src == dst, nothing to link;
>> +						 *    forming one would only mint an id and a spurious
>> +						 *    self-link (inert in sync_linked_regs()).
>> +						 *  - an ADD_CONST-linked src (rX = base + K):
>> +						 *    assign_scalar_id_before_mov() would clear its
>> +						 *    base+delta link, and a combined subreg+delta link
>> +						 *    isn't modeled anyway (sync_linked_regs() skips it).
>> +						 * In both cases src is left untouched and dst is cleared,
>> +						 * as before this feature.
>> +						 */
>> +						bool wide_subreg_link = !is_src_reg_u32 &&
>> +							src_reg != dst_reg &&
>> +							!(src_reg->flags & BPF_FLAG_ADD_CONST);
> Why checking `!(src_reg->flags & BPF_FLAG_ADD_CONST)`?
> assign_scalar_id_before_mov resets() src_reg->flags and assigns
> a fresh src_reg->id when `src_reg->flags & BPF_FLAG_ADD_CONST`.
> The existing code already breaks ADD_CONST32 relationship for src
> on mov, let's be symmetric here unless there is a good reason not to.

And this is what took me a while to unpack and reply.
I was struggling with the *symmetry* of rule leading to *asymmetry* of 
the outcomes. So let me jolt it down for posterity but mainly to make 
sure I'm getting this right.

Let's take a simple case with narrow and wide variants (the wide variant 
is also added the patch for documentation of behavior). It is also 
annotated with the 3 behaviors: pre-series, RFC and v2 (with your 
suggestion above)

Case A — narrow source

       w6 = w0;        /* r6 narrow, [0, U32_MAX]                  */
       r5 = r6;        /* r5, r6 linked, id X                      */
       w5 += 3;        /* alu32 add -> ADD_CONST_32, delta 3       */
       w7 = w5;        /* is_src_reg_u32 == true                   */
               /* pre-series: assign_scalar_id_before_mov() runs ->        */
               /*             r5 loses id X + delta, gets fresh id Y;      */
               /*             dst not cleared -> r7 shares id Y (full link)*/
               /* RFC:        identical (wide_subreg_link needs !u32)      */
               /* v2:         identical (subreg_link needs !u32)           */

Case B — wide source

       r6 = r0;        /* r6 = full 64-bit unknown                 */
       r5 = r6;        /* r5, r6 linked, id X                      */
       r5 += 3;        /* alu64 add -> ADD_CONST_64, delta 3       */
       w7 = w5;        /* is_src_reg_u32 == false                  */
               /* pre-series: assign not called -> r5 keeps id X + delta 3 */
               /*             !u32 -> clear_scalar_id(r7): r7 unlinked     */
               /* RFC:        wide_subreg_link false, because src is       */
               /*             ADD_CONST -> identical to pre-series         */
               /* v2:         subreg_link true -> assign runs ->           */
               /*             r5 loses id X + delta, gets fresh id Y;      */
               /*             r7 gets id Y + SUBREG_ZEXT                   */


So the symmetry is to allow ADD_CONST32 to call 
assign_scalar_id_before_mov () even in the new regime.

This does cause a behavior change for case B: before v2, r5 retained 
ADD_CONST32, r7 is unlinked; with v2, r5 looses the delta relationship, 
r7 is linked to r5.

I'm adding this exact test to capture the behavior.

Please shout if anything's asmiss.

> By the way, does assign_scalar_id_before_mov() need to handle
> BPF_FLAG_SUBREG_ZEXT? It appears that it is fine to share id
> if `src_reg->flags & BPF_FLAG_SUBREG_ZEXT`,

Yes.

> would be nice to drop a (short) comment there.

This ?

         /*
          * The verifier is processing rX = rY insn and
          * rY->id has special linked register already.
          * Cleared it, since multiple rX += const are not supported.
          * A ->subreg link can be shared: it describes src's own relationship
          * to the set, not a delta to unwind.
          */


>> +
>> +						if (is_src_reg_u32 || wide_subreg_link)
>>   							assign_scalar_id_before_mov(env, src_reg);
>>   						*dst_reg = *src_reg;
>> -						/* Make sure ID is cleared if src_reg is not in u32
>> -						 * range otherwise dst_reg min/max could be incorrectly
>> -						 * propagated into src_reg by sync_linked_regs()
>> -						 */
>> -						if (!is_src_reg_u32)
>> -							clear_scalar_id(dst_reg);
>> +						if (!is_src_reg_u32) {
>> +							if (wide_subreg_link && src_reg->id) {
>> +								/* ->id already copied above */
>> +								dst_reg->flags |= BPF_FLAG_SUBREG_ZEXT;
>> +							} else {
>> +								clear_scalar_id(dst_reg);
>> +							}
>> +						}
> Nit: I'd avoid excessive indentation:

OK, fixed

>> @@ -15953,6 +15980,52 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
>>   			continue;
>>   		if (reg->id != known_reg->id)
>>   			continue;
>> +		/*
>> +		 * A low-32 linked register shares only the base's low 32 bits;
>> +		 * the flag says how its high bits are derived. For
>> +		 * BPF_FLAG_SUBREG_ZEXT they are zero (32-bit zero-extending mov).
>> +		 * Rebuild it from known_reg's low 32 bits accordingly, but only
>> +		 * when neither side carries an ADD_CONST delta -- with a delta
>> +		 * the low bits differ from the base by that delta and the combined
>> +		 * subreg+ADD_CONST reconstruction isn't modeled here, so leave reg
>> +		 * unchanged (sound, just less precise).
>> +		 */
>> +		if (reg->flags & BPF_FLAG_SUBREG_ZEXT) {
>> +			if (!((reg->flags | known_reg->flags) & BPF_FLAG_ADD_CONST)) {
>> +				{
>> +					u32 saved_id = reg->id;
> Right above this hunk reg->id == known_reg->id relationship is already
> established, why is saved_id necessary?

Right, not needed.

>> +					u8 saved_subreg = reg->flags & BPF_FLAG_SUBREG_ZEXT;
>> +
>> +					/*
>> +					 * reg = zext32(known_reg): its low 32 bits come from
>> +					 * the base and its high 32 are zero. Rather than
>> +					 * rebuild the value by hand, copy the base (keeping
>> +					 * its precise low-32 tnum) and re-clear the high half
>> +					 * with the same zext_32_to_64() the 32-bit
>> +					 * zero-extending mov used -- the zero high half is a
>> +					 * fallout of it, so no dedicated reconstruction is
>> +					 * needed.
>> +					 */
>> +					*reg = *known_reg;
>> +					reg->id = saved_id;
>> +					reg->flags = (reg->flags & ~BPF_FLAG_SUBREG_ZEXT) | saved_subreg;
> This would look much simpler with bitfields.

Yep.

>> +					zext_32_to_64(reg);
>> +					reg_bounds_sync(reg);
>> +				}
>> +				if (e->is_reg)
>> +					mark_reg_scratched(env, e->regno);
>> +				else
>> +					mark_stack_slot_scratched(env, e->spi);
>> +			}
>> +			continue;
>> +		}
>> +		/*
>> +		 * Dest-driven direction (known_reg is subreg-linked, reg is not):
>> +		 * copying known_reg's low-32-only state into a full register would
>> +		 * be unsound, so leave reg unchanged.
>> +		 */
>> +		if (known_reg->flags & BPF_FLAG_SUBREG_ZEXT)
>> +			continue;
>>   		/*
>>   		 * Skip mixed 32/64-bit links: the delta relationship doesn't
>>   		 * hold across different ALU widths.

