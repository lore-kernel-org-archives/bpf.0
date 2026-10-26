Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051517;
	b=tYbPLyWcohMHUeAS/N741CS+wla/IeeNvjEZU7JwmP5QZVIpAtaGbWl4zIIwbj2wit38
	 DUpuFHp+C8xQEXkpgAMIlpxgqRcd2TRQiFqIQdzhtnRcW46S1LMZoNAfPjKIC9hBvLKpY
	 Zu8vHdthhtncLVVPdbjDj8JMfGInpopdSTggdbM4Payz/Xpym8kanifxkHJSW48yPGIl+
	 hPrH++ayO2eMDJGWA5KC99/4Bh9xwzOSoEYwGWiGeXK/kvE4fd0S3JvgGmuWcoxnz5yNJ
	 Ab+IVoVAI0OGeBeQNxbaHomKI7JNgaSla9b8dSxdkOK82YpMgbI2WgyCRCuwJRjeF7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051517;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6Hio2H0utwAIyxxhgVH/5n+oK2ZNwQDLtqxwHftDHhI=;
	b=SXc2DK9QAqt1v5cYzHzb0Z7ia7CzyMMTygI+SI9LIHCFK/Vz7A8SeFjZDC+Uw8GSfpSO
	 AJ4034ALs3ZKN2aQoIImefJhzGBJiMhgEHdIhhxzbP2i6k9B0z1l1O1/10GE5IwrLBvdE
	 LHzutRjEb78ctPF6nWpur8w1dyBIOOiQ1gQ3vngnqwdKm85bz852Tl/EgtpftZnCzKCTs
	 /UAbS3Qqt8wVULGK3FqVY1k3hNexk8ifjQqTS1gyCOjAMOOI2XY0XHQ9X2L6Eg4Rt/PXY
	 OuQo81iT5b55ovG5bf5jZZd3QcQiZap4HdxlLwOiKbxgtlDn0GmqMS8OB31i2qJJa2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IFd6sX2k;
	arc=none smtp.remote-ip=91.218.175.148
Received: from mta0.migadu.com (out-148.mta0.migadu.com [91.218.175.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461F606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 21:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4461F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IFd6sX2k
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Zq216ynIgf+aDyYLsrgqAPxasG85w4rWKWBh7CqEE+I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793051513; v=1; x=1793656313;
 b=IFd6sX2kje+AKEOZWfjyKw2Ak4t0oAfCfGiwzIsR9KDzBjmDb1OBSEZjeOVi94fz5Js9fihF
 DM1LJjM+iAD9N3s4bkW7HLdy4Jy17JeNkPIUVgctxDhvDPwfIjKk/WkWI7+kqOHl0YVFTbPtBFs
 JcIAsIudNIASH/HFytAF1OcI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b7649b005e064238;
	Mon, 26 Oct 2026 21:51:52 +0000
X-Mizu-Trace-ID: b7649b005e064238
X-Migadu-Flow: FLOW_OUT
Message-ID: <6709a9b7-a9c0-4f1d-ad29-87a03a12ede3@linux.dev>
Date: Mon, 26 Oct 2026 14:51:46 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 11/12] [do not merge] bpf: Track low-32 scalar
 equality across narrowing stack spills
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-12-vineet.gupta@linux.dev>
 <sashiko-outbox-179371@kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-179371@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/26 9:42 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: zext_32_to_64() on 4-byte spill loses signed bounds on ldsx fill
> --
>
> commit b63f0039bbb8ede3ae56c9d69df1283e246bde61
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> bpf: Track low-32 scalar equality across narrowing stack spills
>
> This patch tracks low-32 scalar equality across 4-byte narrowing stack
> spills by assigning a scalar ID, truncating the spilled slot with
> zext_32_to_64(), and setting link_kind to BPF_REG_LINK_ZEXT.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 083b5bd70d3fa..de2a5c048a29a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -3927,15 +3928,46 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>>   	mark_stack_slot_scratched(env, spi);
>>   	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
>>   		bool reg_value_fits;
>> +		bool subreg_link;
>>   
>>   		reg_value_fits = get_reg_width(reg) <= BITS_PER_BYTE * size;
>> +		/*
>> +		 * A narrowing spill stores the low 32 bits of the source, so
>> +		 * the slot is their zero-extension: record a low-32 link
>> +		 * rather than dropping the relation, as a 32-bit mov does.
>> +		 * A store never sign-extends, so there is only one link kind here.
>> +		 */
>> +		subreg_link = !reg_value_fits && size == 4;
>> +
>>   		/* Make sure that reg had an ID to build a relation on spill. */
>> -		if (reg_value_fits)
>> +		if (reg_value_fits || subreg_link)
>>   			assign_scalar_id_before_mov(env, reg);
>>   		save_register_state(env, state, spi, reg, size);
>> -		/* Break the relation on a narrowing spill. */
>> -		if (!reg_value_fits)
>> -			bpf_clear_scalar_id(&ss->spilled_ptr);
>> +		if (!reg_value_fits) {
>> +			if (subreg_link && reg->id) {
>> +				/*
>> +				 * save_register_state() copies the source
>> +				 * whole, but the store only wrote its low 32
>> +				 * bits, so truncate to those before recording
>> +				 * the kind: a slot asserting BPF_REG_LINK_ZEXT
>> +				 * over the source's wider bounds is a register
>> +				 * state that contradicts itself.
>> +				 *
>> +				 * Keep the source's delta, though: the slot
>> +				 * holds (u32)(base + delta), so resetting it to
>> +				 * 0 would record a relation off by that delta.
>> +				 */
>> +				zext_32_to_64(&ss->spilled_ptr);
>> +				ss->spilled_ptr.link_kind = BPF_REG_LINK_ZEXT;
> [Severity: Medium]
> Does calling zext_32_to_64() on ss->spilled_ptr cause a precision
> regression when the 4-byte slot is subsequently filled by a sign-extending
> load (ldsx)?

Yes precision regression and it also changes a verdict.

Say r6 is given [-16, 15], a small signed range straddling zero, spilled 
4 bytes and filled back with ldsx.
On a patch-10 kernel the program verifies; with 11/12 applied it is 
rejected, because the fill no longer knows r2 <= 15:

     p10      sext_fill_keeps_small_signed_range   success
     p10+11   sext_fill_keeps_small_signed_range   failure ("div by zero")

Thx,
-Vineet

> When spilling a scalar register whose signed range straddles zero (for
> example [-10, 10], where reg_umax(reg) is U64_MAX and get_reg_width(reg)
> is 64) with a 4-byte store (*(u32 *)(r10 - 8) = rX), subreg_link is true
> and zext_32_to_64(&ss->spilled_ptr) is called:
>
> static void zext_32_to_64(struct bpf_reg_state *reg)
> {
> 	reg_step_check_unsigned(reg, 32);
> 	reg->var_off = tnum_subreg(reg->var_off);
> 	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
> }
>
> Because r32 = [-10, 10] straddles zero in unsigned 32-bit arithmetic
> (u32_min = 0, u32_max = 0xffffffff), zext_32_to_64() overwrites
> ss->spilled_ptr.r64 with [0, 0xffffffff] while leaving [-10, 10] only in
> r32.
>
> If the slot is then reloaded with a sign-extending load (*(s32 *)(r10 - 8),
> *(s16 *)(r10 - 8), or *(s8 *)(r10 - 8)), check_stack_read_fixed_off()
> copies ss->spilled_ptr to the destination register and check_mem_access()
> calls coerce_reg_to_size_sx():
>
> static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
> {
> 	...
> 	/* If every value fits the signed N-bit range sign extension is a noop. */
> 	if (reg_smin(reg) >= -limit && reg_smax(reg) < limit)
> 		return;
>
> Because coerce_reg_to_size_sx() inspects reg_smin(reg) and reg_smax(reg)
> from r64 rather than r32, smax is 0xffffffff (>= limit), so the early
> return no longer triggers and coerce_reg_to_size_sx() falls through to
> set_sext64_default_val(), resetting both r64 and r32 to [S32_MIN, S32_MAX]
> (or the full S16/S8 range).
