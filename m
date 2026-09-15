Received: from mta0.migadu.com (out-144.mta0.migadu.com [91.218.175.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9C3CFF72
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504313; cv=none; b=OYLdK7P+uMXJWdri0rxhhtfYB57agNcQa4zhkaQGg1cRYt9TvX29rHNRDxL476YVFFWn9/nB24PoF3gfEZ4dX+eg0dS7Xt7uFOYhODMR/jhANRsezUlX92DYMAkA46mJQ6SuD/E12XwO2wM6MVbAUNnBLv/jmYaxx55dhKM2BFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504313; c=relaxed/simple;
	bh=DlNMEgBAu/+jKGuLmjW2kT9UG/Wuidvpo60GYwCs51s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K14DrKRimSOeim3BAu3JssisCmKa7OXSdKxjdN7GAOSR5IzSFiBpeUucW1nL/Ittp71k8PW9TLPqgiyyhEys8r3xXyC828UuplnT9AovvUCSEwCmW5BuauYh0TeRW3XA07zJnarrGziKBOYQZkKwaS+EfX5LjmnCyfOId8q14pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bjAoyw+h; arc=none smtp.client-ip=91.218.175.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bjAoyw+h"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DlNMEgBAu/+jKGuLmjW2kT9UG/Wuidvpo60GYwCs51s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789504309; v=1; x=1790109109;
 b=bjAoyw+hx9ScjmWn+XzdmmIsHl1KOWAeUHfH+1DlxCv2xMcLZRafbbhTZxAZv0bArm99zlnE
 aBsni+IGn8vYEy0zcw6ETvtT2Cde4DutkCbJj9Kq4soDtkWA305kPm/bNo01P8Ka1hsvtqmmjrk
 k7KKEpoFLVRNB1lvoSL2E1iM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4f20671e3b41c2d0;
	Tue, 15 Sep 2026 20:31:49 +0000
X-Mizu-Trace-ID: 4f20671e3b41c2d0
X-Migadu-Flow: FLOW_OUT
Message-ID: <4ab75099-0e95-4fee-81da-6f4198e3e6a0@linux.dev>
Date: Tue, 15 Sep 2026 13:31:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 03/13] bpf: track low-32 scalar equality
 across zero-extending movs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-4-vineet.gupta@linux.dev>
 <DLDKI0ZXYI7H.1XQZZE2RCU7IF@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <DLDKI0ZXYI7H.1XQZZE2RCU7IF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/12/26 11:59 AM, Alexei Starovoitov wrote:
> On Thu Sep 10, 2026 at 9:46 AM PDT, Vineet Gupta wrote:
>> Linked-scalar equality is full-64-bit only. A 32-bit mov from a source
>> with unknown high bits therefore has to drop the relationship, and a later
>> narrowing of the source never reaches the destination:
>>
>>    r6 = ...              /* full 64-bit unknown */
>>    w7 = w6               /* 32-bit zero-extending mov */
>>    if w6 != 0 goto ...   /* not taken: r6's low 32 bits are 0 */
>>    if w7 == 0 goto ...   /* not deduced today */
>>
>> Record a low-32-only link instead: dst shares src's low 32 bits and its
>> high half is zero. On a later narrowing, sync_linked_regs() rebuilds such
>> a register from the base rather than copying it, by re-applying the same
>> zext_32_to_64() the mov used. The reverse direction is skipped: a ->subreg
>> base knows nothing about a full register's high half.
> at the first glance SUBREG_ZEXT is exactly the same as ADD_CONST32 delta == 0.
> no?
> Both are unidirectional:
> w6->id == 1
> w7->id == 1, add_const == 32, delta == 0
>
> will zero extend w7.
>
> This new SUBREG_ZEXT will do the same.
> What am I missing?

The 2 examples below both imply ADD_CONST32 + delta=0, with different 
semantics and need special casing.

w3 = w2; w3 += 0
w7 = w6; (r6 was wide)

With code hacks it could in fact me made to work, but its less cleaner.


Current approach we have something like below in sync_linked_regs()

               /*
                * A ->subreg register shares only the base's low 32 
bits, so it
                * is rebuilt rather than copied. Not modelled together 
with a
                * delta, so skip if either side has one (sound, less 
precise).
                */
               if (reg->subreg) {
                       if (reg->add_const || known_reg->add_const)
                               continue;
                       if (reg->subreg == SUBREG_ZEXT)
                               reconstruct_zext32(reg, known_reg);
                       else
                               reconstruct_sext32(reg, known_reg);
                       if (e->is_reg)
                               mark_reg_scratched(env, e->regno);
                       else
                               mark_stack_slot_scratched(env, e->spi);
                       continue;
               }
               /*
                * The reverse: known_reg knows only its low 32 bits, 
which say
                * nothing about reg's high half.
                */
               if (known_reg->subreg)
                       continue;


With the suggested approach it looks something like below.
ADD_CONST_32, delta == 0 has to be disambiguated from a real += 0 by 
inspecting another register's bounds.

               /*
                * A low-32 link shares only the base's low 32 bits, so it is
                * rebuilt rather than copied.
                *
                * SIGN_EXTEND_32 says so outright. ADD_CONST_32 with 
delta == 0
                * does not: it is also what "w3 = w2; w3 += 0" records, 
which is
                * a plain equality. The two are separable only by the base's
                * width
                */
               if (reg->add_const == SIGN_EXTEND_32 && 
!known_reg->add_const) {
                       reconstruct_sext32(reg, known_reg);
                       goto scratched;
               }
               if (reg->add_const == ADD_CONST_32 && reg->delta == 0 &&
                   !known_reg->add_const) {
                       reconstruct_zext32(reg, known_reg);
                       goto ...;
               }
               /*
                * The reverse:
                */
               if (known_reg->add_const == SIGN_EXTEND_32)
                       continue;
               if (known_reg->add_const == ADD_CONST_32 &&
                   known_reg->delta == 0 && get_reg_width(reg) > 32)
                       continue;

There are other knock-on effects which use add_const as a bool.

log.c:655        if (reg->add_const) -> prints "%+d" delta

There are many more such places and would need to be handled for special 
case of add_const but delta=0 to mean something else.

My opinion would be stick to the current ZEXT,SEXT split.

Thx,
-Vineet
