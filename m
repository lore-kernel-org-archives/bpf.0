Received: from mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB321767D
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603709; cv=none; b=aAZ8FWGVqsJWw9xWvbYGK1KIa1zXbqamaRN2hHWm8MoEj4ogCF03FAMeWGJO2KpdOOCdnBKEE9NdHY0P+rmVbDnufYUt9hqnxtSHbK4vVJ7QKJUBpseybqioP8+eJOS/B7RlOodNiBStbpH06o6xKlRuTk/mkk5ljCrrIC4eETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603709; c=relaxed/simple;
	bh=stXunbVkIdx4k59uImIa4pDdXbqX+msrN9yjZYDiyb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8tVm/x9ahmYZGFC8zDeOGpoZYNWsselszRsoUzD602Fcgy0NEC4QtzeZo9ZuTd6B7mDDNbwAYwxIZmhiUCSxtcghJxN2bKRA5+D/jZimIDVevKTn2ss3mtqeFS8NjKFXDDgRs25JIKxo6QuRcG9/NF+3Sgnb8F4KIerF/L/5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N+I3Reme; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N+I3Reme"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=stXunbVkIdx4k59uImIa4pDdXbqX+msrN9yjZYDiyb0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789603704; v=1; x=1790208504;
 b=N+I3Reme10cccECT0mBJre6ky0ZzzL1KUu0OENGJyYFiLPDb5EcHML/GJu6Odmbhmdus2lLq
 qm7qh4Cgmgj9Kip/7lgKDi8NKtPzfeN2MWKM/N/nEyOznOGXUCBrYE1er17fKsvCaBFVR7gdvlA
 XqQY5O0Iw6mjNKDTey7xto6A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 35f6557e0c1272c7;
	Thu, 17 Sep 2026 00:08:24 +0000
X-Mizu-Trace-ID: 35f6557e0c1272c7
X-Migadu-Flow: FLOW_OUT
Message-ID: <202c45e2-58ba-4ad5-a234-c90703031f91@linux.dev>
Date: Wed, 16 Sep 2026 17:08:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 03/13] bpf: track low-32 scalar equality
 across zero-extending movs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-4-vineet.gupta@linux.dev>
 <DLDKI0ZXYI7H.1XQZZE2RCU7IF@gmail.com>
 <4ab75099-0e95-4fee-81da-6f4198e3e6a0@linux.dev>
 <CAADnVQ+N9tzBJ0Bbvp8_8QvR+QcCP4ej5CgV_kRHt=iw4BANSQ@mail.gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <CAADnVQ+N9tzBJ0Bbvp8_8QvR+QcCP4ej5CgV_kRHt=iw4BANSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/15/26 9:23 PM, Alexei Starovoitov wrote:
> On Tue, Sep 15, 2026 at 1:31 PM Vineet Gupta <vineet.gupta@linux.dev> wrote:
>> On 9/12/26 11:59 AM, Alexei Starovoitov wrote:
>>> On Thu Sep 10, 2026 at 9:46 AM PDT, Vineet Gupta wrote:
>>>> Linked-scalar equality is full-64-bit only. A 32-bit mov from a source
>>>> with unknown high bits therefore has to drop the relationship, and a later
>>>> narrowing of the source never reaches the destination:
>>>>
>>>>     r6 = ...              /* full 64-bit unknown */
>>>>     w7 = w6               /* 32-bit zero-extending mov */
>>>>     if w6 != 0 goto ...   /* not taken: r6's low 32 bits are 0 */
>>>>     if w7 == 0 goto ...   /* not deduced today */
>>>>
>>>> Record a low-32-only link instead: dst shares src's low 32 bits and its
>>>> high half is zero. On a later narrowing, sync_linked_regs() rebuilds such
>>>> a register from the base rather than copying it, by re-applying the same
>>>> zext_32_to_64() the mov used. The reverse direction is skipped: a ->subreg
>>>> base knows nothing about a full register's high half.
>>> at the first glance SUBREG_ZEXT is exactly the same as ADD_CONST32 delta == 0.
>>> no?
>>> Both are unidirectional:
>>> w6->id == 1
>>> w7->id == 1, add_const == 32, delta == 0
>>>
>>> will zero extend w7.
>>>
>>> This new SUBREG_ZEXT will do the same.
>>> What am I missing?
>> The 2 examples below both imply ADD_CONST32 + delta=0, with different
>> semantics and need special casing.
>>
>> w3 = w2; w3 += 0
>> w7 = w6; (r6 was wide)
>>
>> With code hacks it could in fact me made to work, but its less cleaner.
>>
>>
>> Current approach we have something like below in sync_linked_regs()
>>
>>                 /*
>>                  * A ->subreg register shares only the base's low 32
>> bits, so it
>>                  * is rebuilt rather than copied. Not modelled together
>> with a
>>                  * delta, so skip if either side has one (sound, less
>> precise).
>>                  */
>>                 if (reg->subreg) {
>>                         if (reg->add_const || known_reg->add_const)
>>                                 continue;
>>                         if (reg->subreg == SUBREG_ZEXT)
>>                                 reconstruct_zext32(reg, known_reg);
>>                         else
>>                                 reconstruct_sext32(reg, known_reg);
>>                         if (e->is_reg)
>>                                 mark_reg_scratched(env, e->regno);
>>                         else
>>                                 mark_stack_slot_scratched(env, e->spi);
>>                         continue;
>>                 }
>>                 /*
>>                  * The reverse: known_reg knows only its low 32 bits,
>> which say
>>                  * nothing about reg's high half.
>>                  */
>>                 if (known_reg->subreg)
>>                         continue;
>>
>>
>> With the suggested approach it looks something like below.
>> ADD_CONST_32, delta == 0 has to be disambiguated from a real += 0 by
>> inspecting another register's bounds.
>>
>>                 /*
>>                  * A low-32 link shares only the base's low 32 bits, so it is
>>                  * rebuilt rather than copied.
>>                  *
>>                  * SIGN_EXTEND_32 says so outright. ADD_CONST_32 with
>> delta == 0
>>                  * does not: it is also what "w3 = w2; w3 += 0" records,
>> which is
>>                  * a plain equality. The two are separable only by the base's
>>                  * width
>>                  */
>>                 if (reg->add_const == SIGN_EXTEND_32 &&
>> !known_reg->add_const) {
>>                         reconstruct_sext32(reg, known_reg);
>>                         goto scratched;
>>                 }
>>                 if (reg->add_const == ADD_CONST_32 && reg->delta == 0 &&
>>                     !known_reg->add_const) {
>>                         reconstruct_zext32(reg, known_reg);
>>                         goto ...;
>>                 }
> I think that's a problem with reconstruct_zext32().
> It shouldn't be necessary.
> The existing code that adds a constant should
> already handle it.
> If not, we have a bug in add_const_32.

Not really a bug, but a deliberate design choice in the past.

if (alu32 && (dst_umax > U32_MAX))
       goto clear_id;

So the core change is ADD_CONST_32 needs to be allowed on wider regs.
So treating it as
     reg = (u32)(base + delta)

which simplifies to zero-extend for delta==0 and base can be either wide 
or narrow.

> Instead of losing link at wx=wy time
> we can keep it with delta == 0
> and sync_linked_regs() shouldn't need any new code.

I toyed with a prototype which essentially lifts the restriction above 
(and ensuing adjustments)
FWIW it *does* require a reverse guard in sync_linked_regs() - so some 
additional code there (at least in my version).

It ended up with full testsuite run parity - after 4 incremental patches.
But the pattern of all those patches was adding some predicate / 
special-casing to reg->add_const

hunk 1

-       if (src_reg->add_const)
+       if (src_reg->add_const && src_reg->delta)


hunk 2

-               if (dst_reg->add_const) {
+               if (dst_reg->add_const && !dst_reg->delta &&
+                   dst_reg->add_const == (alu32 ? ADD_CONST_32 : ADD_CONST_64)) {
+                       dst_reg->delta = off;
+               } else if (dst_reg->add_const) {


hunk 3

-                               if (subreg_link && reg->id)
-                                       state->regs[dst_regno].subreg =  is_ldsx ? SUBREG_SEXT : SUBREG_ZEXT;
+                               if (subreg_link && reg->id) {
+                                       if (is_ldsx) {
+                                               state->regs[dst_regno].subreg_sext = true;
+                                       } else {
+                                               state->regs[dst_regno].add_const = ADD_CONST_32;
+                                               state->regs[dst_regno].delta = 0;
+                                       }
+                               }


hunk 4

-               if (known_reg->subreg)
+               if (known_reg->subreg_sext)
+                       continue;
+               /*
+                * Same for a zero-extending link, now spelled ADD_CONST_32:
+                * reg == (u32)(base + delta) does not invert once the base is
+                * wider than 32 bits.
+                */
+               if (known_reg->add_const == ADD_CONST_32 &&
+                   get_reg_width(reg) > 32)
                         continue;


Yes it does allow removal of reconstruct_zext32()

-               if (reg->subreg) {
+               if (reg->subreg_sext) {
                         if (reg->add_const || known_reg->add_const)
                                 continue;
-                       if (reg->subreg == SUBREG_ZEXT)
-                               reconstruct_zext32(reg, known_reg);
-                       else
-                               reconstruct_sext32(reg, known_reg);
+                       reconstruct_sext32(reg, known_reg);


but personally speaking reading the code feels a bit more harder now.

I can send over the full patch which converts the v2 SUBREG_ZEXT into 
ADD_CONST32+delta=0 to give a feel for all the special casings, were it 
to be subsumed into the orig zext support work, but I think you 
understand what I'm getting at ;-)

Happy to pursue whatever your maintainer hat tells you.

Thx,
-Vineet
