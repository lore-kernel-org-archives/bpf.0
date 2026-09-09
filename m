Received: from mta0.migadu.com (out-58.mta0.migadu.com [91.218.175.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE755930D
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958786; cv=none; b=VOXLI1KB+9+O/O4wOgt5JkBrYkRpWdYn8xQjBtmm926EAVOU7nqb5KWNnPew+Efsxuoy+QeWhxHvCSFaM6pDVNwq5im6HFhkfTwMW026AcStBTgpYo1gsosqtHQRD2zn2eJcf6JRRlQSwQcESdESG39Bu2eigGSEUR1/j7W2lKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958786; c=relaxed/simple;
	bh=3O/8KHYbKIzs1YhR+mXrt8jL3rOGkrXjzfsWjUm1AeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwryvV3CDs6Iap5FA4DMwhROiZgYldj85XYiNgvFoRcEfhNV4SqbYT35K6wbk+xeHAK6dEzEZ4+vUtY7vm6Fbq3vgDoldyLtufZDzYUrGDmSLM+D2ZsvwecWRJlq2pV8S0O6kCaqItrUbFkFSwRASwSLrhIF7jTYPM7ZPMiPMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FebCfLSo; arc=none smtp.client-ip=91.218.175.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FebCfLSo"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3O/8KHYbKIzs1YhR+mXrt8jL3rOGkrXjzfsWjUm1AeA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788958781; v=1; x=1789563581;
 b=FebCfLSo0uvT1r2oT4tC2ZZMnvpOEw+ZCXyhVf42FkVGcAKKGWiAchh6x61JmtmNG/0jeLkE
 0+aKDBM2H/B/hSYjQq1raLw5+9EvbA4011beHIRF3Frd4XRj+FP3SsHoDlVjKemRxQLI2grEtkc
 GgHkbV+v1Ml1450G7gJ6eXg0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d6310b345bcbb34d;
	Wed, 09 Sep 2026 12:59:41 +0000
X-Mizu-Trace-ID: d6310b345bcbb34d
X-Migadu-Flow: FLOW_OUT
Message-ID: <a2a2d7f0-8869-4d85-95d5-e436f743c163@linux.dev>
Date: Wed, 9 Sep 2026 18:29:35 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 5/6] bpf: support low-32 subreg scalar linking for
 sign-extending movs
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
 <20260814231945.3884596-6-vineet.gupta@linux.dev>
 <d43e9adedfeced52ccf5eafea9f2aec01b79f413.camel@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <d43e9adedfeced52ccf5eafea9f2aec01b79f413.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/26 11:48 AM, Eduard Zingerman wrote:
>> @@ -570,9 +572,18 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>>   		 * on a path that predates this series, which is a pruning change
>>   		 * that wants measuring on its own; it is deliberately left
>>   		 * alone here.
>> +		 *
>> +		 * Only demand a match when the old state carries a link at all.
>> +		 * These flags are only ever set together with an ->id, so
>> +		 * rold->id == 0 implies none is set, and the only case this
>> +		 * admits is "old knows no low-32 relationship, cur does" -- cur
>> +		 * is then strictly more constrained than old, which is the safe
>> +		 * direction for pruning. The reverse is still rejected. Without
>> +		 * this a register that first acquires a link inside a loop would
>> +		 * never match its pre-loop state and pruning would not converge.
>>   		 */
>>   		if (rold->id &&
>> -		    (rold->flags & BPF_FLAG_SUBREG_ZEXT) != (rcur->flags & BPF_FLAG_SUBREG_ZEXT))
>> +		    (rold->flags & BPF_FLAG_SUBREG) != (rcur->flags & BPF_FLAG_SUBREG))
>>   			return false;
> Same comment as for ZEXT patch.

The prior zext patch compares ->subreg with enum distinguishing zext and 
sext: no sext specific code needed.

>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8a802d49d0a4..45cb67dc3999 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -14976,6 +14976,8 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
>>   	return 0;
>>   }
>>   
>> +static void reconstruct_sext32(struct bpf_reg_state *reg, struct bpf_reg_state *src);
> Nit: is it possible to avoid forward declaration?

Removed.

>>   /* check validity of 32-bit and 64-bit arithmetic operations */
>>   static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>   {
>> @@ -15052,15 +15054,65 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>   							insn->src_reg);
>>   						return -EACCES;
>>   					} else if (src_reg->type == SCALAR_VALUE) {
>> +						int sz = insn->off >> 3;
>>   						bool no_sext;
>> +						bool subreg_link;
>>   
>>   						no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
>> -						if (no_sext)
>> +						/*
>> +						 * When no_sext, dst == src exactly, so link them
>> +						 * (existing behavior). When !no_sext for a 32-bit sign
>> +						 * extension the low 32 bits are still identical (sext
>> +						 * preserves them), so form a BPF_FLAG_SUBREG_SEXT
>> +						 * link: a later narrowing of the low 32 bits
>> +						 * propagates here, and sync_linked_regs() rebuilds
>> +						 * the high half via reconstruct_sext32().
>> +						 *
>> +						 * An ADD_CONST-linked src is excluded for the same
>> +						 * reason as in the zero-extending arm below:
>> +						 * assign_scalar_id_before_mov() would clear its
>> +						 * base+delta link, and a combined subreg+delta link
>> +						 * isn't modeled anyway. Unlike that arm a self-mov is
>> +						 * NOT excluded -- r0 = (s32)r0 is the case this is
>> +						 * here for.
>> +						 */
>> +						subreg_link = (sz == 4) &&
>> +							      !(src_reg->flags & BPF_FLAG_ADD_CONST);
>> +
>> +						if (no_sext || subreg_link)
>>   							assign_scalar_id_before_mov(env, src_reg);
>>   						*dst_reg = *src_reg;
>> -						if (!no_sext)
>> -							clear_scalar_id(dst_reg);
>> -						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
>> +						if (!no_sext) {
>> +							if (subreg_link && src_reg->id) {
>> +								/* ->id already copied above */
>> +								dst_reg->flags = (dst_reg->flags & ~BPF_FLAG_SUBREG) |
>> +										 BPF_FLAG_SUBREG_SEXT;
>> +							} else {
>> +								clear_scalar_id(dst_reg);
>> +							}
>> +						}
>> +						/*
>> +						 * coerce_reg_to_size_sx() falls back to the full sext
>> +						 * range when smin/smax straddle the sign boundary (e.g.
>> +						 * an errno-or-zero value clamped to [-4095, 0]). For a
>> +						 * register tracked as the sign-extension of its low 32
>> +						 * bits the high half IS that sign-extension, so rebuild
>> +						 * the tighter 64-bit range from the low bounds, taken
>> +						 * from a snapshot because coerce overwrites them.
>> +						 *
>> +						 * Gated on sz == 4, not on the flag alone: an (s8)/(s16)
>> +						 * mov whose src is already SEXT-linked copies the flag
>> +						 * across in the *dst_reg = *src_reg above, and a 32-bit
>> +						 * reconstruction must not run for a narrower operation.
>> +						 */
>> +						if (sz == 4 && (dst_reg->flags & BPF_FLAG_SUBREG_SEXT)) {
>> +							struct bpf_reg_state sext_src = *dst_reg;
>> +
>> +							coerce_reg_to_size_sx(dst_reg, sz);
>> +							reconstruct_sext32(dst_reg, &sext_src);
> It does not make sense to maintain two functions that do register sign
> extension. If coerce_reg_to_size_sx() is not precise enough for the
> 32-bit case, then it should be adapted instead of special-cased.

Adapting coerce_reg_to_size_sx () update is now a standalone patch, with 
it's own test.

+       if (size == 1) {
+               field_smin = S8_MIN;
+               field_smax = S8_MAX;
+       } else if (size == 2) {
+               field_smin = S16_MIN;
+               field_smax = S16_MAX;
+       } else {
+               /* size == 4 */
+               field_smin = S32_MIN;
+               field_smax = S32_MAX;
+       }
+
+       /*
+        * The range already fits the field, so (sN)v == v for every 
value the
+        * register can hold and the sign extension changes nothing. The 
tests
+        * below cannot reach this case once smin is negative: a 
negative smin
+        * and a non-negative smax never share their high bits.
+        */
+       if (reg_smin(reg) >= field_smin && reg_smax(reg) <= field_smax)
+               return;


It existing usage is retained in check_alu_op, w/o any reconstruct business.

However in sync routine reconstruct_sext32 is needed, see below....

>> +						} else {
>> +							coerce_reg_to_size_sx(dst_reg, sz);
>> +						}
>>   					} else {
>>   						mark_reg_unknown(env, regs, insn->dst_reg);
>>   					}
>> @@ -15107,7 +15159,15 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>   						if (!is_src_reg_u32) {
>>   							if (wide_subreg_link && src_reg->id) {
>>   								/* ->id already copied above */
>> -								dst_reg->flags |= BPF_FLAG_SUBREG_ZEXT;
>> +								/*
>> +								 * Zero-extension: high bits are 0, not a
>> +								 * sign-extension of the low field. Drop any
>> +								 * SUBREG_SEXT copied from a sext-linked src
>> +								 * so sync_linked_regs() rebuilds dst by
>> +								 * zero-extension, not reconstruct_sext32().
>> +								 */
>> +								dst_reg->flags = (dst_reg->flags & ~BPF_FLAG_SUBREG) |
>> +										 BPF_FLAG_SUBREG_ZEXT;
> Nit: please find a way to reduce indentation (e.g. less if-nesting, or a utility function).

Flattened.

>>   							} else {
>>   								clear_scalar_id(dst_reg);
>>   							}
>> @@ -15961,6 +16021,32 @@ static void collect_linked_regs(struct bpf_verifier_env *env,
>>   	}
>>   }
>>   
>> +/*
>> + * Set @reg to the sign-extension of the low 32 bits currently held by @src.
>> + * A BPF_FLAG_SUBREG_SEXT-linked register came from a 32-bit sign
>> + * extension (r0 = (s32)r0): it shares @src's low 32 bits and its high bits are
>> + * the sign-extension of that low field. Only the value fields are written;
>> + * @reg's linkage fields (id, delta, flags) are left intact by
>> + * the caller (___mark_reg_known touches only var_off/r64/r32). Callers must
>> + * ensure no ADD_CONST delta is involved (see sync_linked_regs()).
>> + */
>> +static void reconstruct_sext32(struct bpf_reg_state *reg, struct bpf_reg_state *src)
> Nit: let's rename src -> known_reg, to make reading sync_linked_regs() simpler.

Done.


>> +{
>> +	s32 s32min = reg_s32_min(src);
>> +	s32 s32max = reg_s32_max(src);
>> +
>> +	if (s32min == s32max) {
>> +		/* Low 32 bits are constant -> the whole value is the sext constant. */
>> +		___mark_reg_known(reg, (u64)(s64)s32min);
>> +	} else {
>> +		/* Sign-extension is monotonic over the signed-32 range. */
>> +		reg_set_srange64(reg, (s64)s32min, (s64)s32max);
>> +		reg_set_srange32(reg, s32min, s32max);
>> +		reg->var_off = tnum_range((u64)(s64)s32min, (u64)(s64)s32max);
> Note that known lower 32-bits of the known_reg->var_off are lost,
> we might benefit from adding a dedicated tnum_sext().

Added.

>> +		reg_bounds_sync(reg);
>> +	}
>> +}
>> +
>>   /* For all R in linked_regs, copy known_reg range into R
>>    * if R->id == known_reg->id.
>>    */
>> @@ -15984,17 +16070,21 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
>>   		 * A low-32 linked register shares only the base's low 32 bits;
>>   		 * the flag says how its high bits are derived. For
>>   		 * BPF_FLAG_SUBREG_ZEXT they are zero (32-bit zero-extending mov).
>> +		 * For BPF_FLAG_SUBREG_SEXT they are the sign-extension of the low
>> +		 * field (32-bit sign extension).
>>   		 * Rebuild it from known_reg's low 32 bits accordingly, but only
>>   		 * when neither side carries an ADD_CONST delta -- with a delta
>>   		 * the low bits differ from the base by that delta and the combined
>>   		 * subreg+ADD_CONST reconstruction isn't modeled here, so leave reg
>>   		 * unchanged (sound, just less precise).
>>   		 */
>> -		if (reg->flags & BPF_FLAG_SUBREG_ZEXT) {
>> +		if (reg->flags & BPF_FLAG_SUBREG) {
>>   			if (!((reg->flags | known_reg->flags) & BPF_FLAG_ADD_CONST)) {
>> -				{
>> +				if (reg->flags & BPF_FLAG_SUBREG_SEXT) {
>> +					reconstruct_sext32(reg, known_reg);
>> +				} else {
> Let's move this branch to a dedicated utility function as well.

This is all simplified in-place now.

-                       reconstruct_zext32(reg, known_reg);
+                       if (reg->subreg == SUBREG_ZEXT)
+                               reconstruct_zext32(reg, known_reg);
+                       else
+                               reconstruct_sext32(reg, known_reg);



coerce_reg_to_size_sx() reads the 64-bit smin/smax, while a 32-bit 
compare narrows the 32-bit range.

For a simple test (actually added)

call %[bpf_get_prandom_u32];
r6 = r0;
r7 = (s32)r6;         /* forms the link */
if w6 != -1 goto 1f;  /* narrows r6's low 32 to all ones */
if r7 == -1 goto 1f;  /* r7 must follow, sign-extended */
r0 /= 0;              /* reachable only if it didn't */
1:
r0 = 0;
exit;

With coerce_reg_to_size_sx(reg, 4) it fails

2: (bf) r7 = (s32)r6   ; 
R7=scalar(id=1.lo32sx,smin=0xffffffff80000000,smax=0x7fffffff)
3: (56) if w6 != 0xffffffff goto pc+2
  R6=scalar(id=1,smin=0x80000000ffffffff,smin32=-1,smax32=-1,var_off=(0xffffffff; 
0xffffffff00000000))
      R7=scalar(id=1.lo32sx,smin=0xffffffff80000000,smax=0x7fffffff) 
  <-- unchanged

With sext_32_to_64() it passes:

3: (56) if w6 != 0xffffffff goto pc+2
  R6=scalar(id=1,smin=0x80000000ffffffff,smin32=-1,smax32=-1,var_off=(0xffffffff; 
0xffffffff00000000))
      R7=-1   <-- reconstructed

Thx,
-Vineet
