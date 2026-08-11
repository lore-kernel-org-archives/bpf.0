Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67318392C2E;
	Tue, 11 Aug 2026 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786490595; cv=none; b=DRoKbMeE8ECGySbfmf8sSGX8bNiwPRhdbKpg+nC782RzvnrGemtdg9nhUCgzF6CVN5pa5gKElXFA7RpHPQaq3pGZPo9PiQU0jSMbpXshsQS0tzkjGqMwGZvwhPpm3MVFcf9s2Ajw1ORky73HmkWKblE17HYQGajrKSANqAaFUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786490595; c=relaxed/simple;
	bh=/seEQHFuMv4DziJQ/QZP4aMrvxTdFjN5yRAX49p03rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0Wdi9hWTBSNgGIyYqVfTuYmBm3c3mdGyshLfrKqo/lED8VXhF/cg0VHjCw3yLwubWlXrJkzg3HztzzLP6Hd3Cx4izxPp0grt9Qdkp2LzHc5jTuYQY6e29peydo4GAoLidnhQjv9MuIT5ez+HZZKXRVI1YAavq9kDBeOiHTGaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polyxeno.com; spf=pass smtp.mailfrom=polyxeno.com; dkim=pass (2048-bit key) header.d=polyxeno.com header.i=@polyxeno.com header.b=gH88tGym; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcBNogld; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polyxeno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polyxeno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=polyxeno.com header.i=@polyxeno.com header.b="gH88tGym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcBNogld"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 434D17A00D9;
	Tue, 11 Aug 2026 19:23:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 11 Aug 2026 19:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polyxeno.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786490591;
	 x=1786576991; bh=qv8vPOvn4g++CtI6ApCXXOpo5hnWioSjAMw3+tA2wY0=; b=
	gH88tGymFIqy7b9F+7Oe/rVaAIYIrTubYVMPqqZ8T5Ptfi8e/EgvT+wSeG7fGGP1
	j9a/TbTRnKXhj7aZ8KX5PdwkEKo9Kll+EjW/rCAc2Si93ruIUkXEMYljmqtWSBfa
	uo/C3NAPbp3t2mphxRLuKe3Nh6tlrZJaMW7vf0FJDQb/vitKtLkOT5zEYWsIb2gg
	qDVWSdxCqDEGTKhCqg2VDL1JFkadkithf0QMQo00O5RCXnk//w/P2FmQO4OUKeG3
	qK1z5Z7TxhisPvFOPIMVbRP2RBTmxVfz/P2jd6M736AM4PysgONquWO4EhfsS4A6
	3xW4R77oGE9hwXo6ktUT9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786490591; x=
	1786576991; bh=qv8vPOvn4g++CtI6ApCXXOpo5hnWioSjAMw3+tA2wY0=; b=k
	cBNogldYwADl6/e6b6Al3CS6jwFnruWWLkPk5Rdmo6D0yHDvWxTnn0rwsmVn4J2E
	Flj1+/V6zhaLVrdXDjLhQSdIfO0+DT+tjxvNmG/K/5XT15lSAnZ86EijsmXRE6uW
	kmBJIeYuSR4DhPpd/6GdCoL2PBj1qd3XEUlp/yiaOFoLV8+fwe6KNoLY6btzf6rC
	Bb1hVmC/CHkIqek5drhxgsWnz0pTWzpKvMGYRAhnfiTz6Ek++oiAxHb4WAOhn1m/
	GN0WzdgSSE5NT3PNUy4RvEmxPhHZbf0NsyrcSG64nTqDFqjDgxLx4ByPPPOEag7N
	reuHGWlBXDdKFmZv9g55w==
X-ME-Sender: <xms:3K57agwEc2DEkbmac-PB7BR9MmE34mV2EaTyALHUSUVbCcY2y-Fkzw>
    <xme:3K57aloYxuufsTTw_WmTVwtDeQ2n0iYsGS7jH8Uw9QCBefVDe4fssoz7TFo1Hnsd1
    ZtR6NbuQKjoQJ50kQdr_lstIT4M-Gw9q9nUxuzgiY-f1miv_YXC4yA>
X-ME-Received: <xmr:3K57arn553eysdhTnYOsVUbG4ED25jV0T0pQx7HCKMVhiT0YmA3R79E8aS9Pa5RMFw>
X-ME-Proxy-Cause: dmFkZTGA4p2m0h86tl9j6HOSHujSc9UkeRA36LSVS/A6oF+Ja5ObZ8CTPdjY78J10/nZDE
    zkoVViraY3UdoxIIwfzNVN5cY7PpdmicmwHIpjnofv9VXbVXtG7Sl+clAf0dw8dYO6spoe
    uC0BRYSF0v6u5NiPkdjho3qhGC2+jwLzZelVyiU4eVH885WLaaZPdbgw3cZGiLrCpEk9+7
    BpL5K0qlbyHHL5fNgNu/6PxOkWbaeW+IX1dTeaAvAS40aCuzhw6JHnG2/5Jx5Rf/2khZwg
    rvnQeKa/deqmMD/8bSHkdMqSSLrvnc4D5IPYqK7sDZDHKGFqcYXIjeuKJlBRy4WPjHgBPL
    X0PYW8gH5MBz+scuyoi0IaanuWjDqn9vr9Zm+WJrXzkibocmAHL1vf+h42qcroxN0q7ABH
    u0zTcXtCjbnHAP6X0hXxp/MUbRi18pp8V/FapW7RBI7qqQIPpZCDJcOujeHlU/mINWCxXj
    uOiwbrcl6MDD+JIModsa4YFg9FFnanm6/KGhARkux47HrIVpjrSLRtGSe4E5vzkGBqpI2Q
    QpLA++ky+Bz1vgXblDjj13wbGVd4D41iO5ik/pwIWT01TKdRKswLjLW6aUqOKN5vqTp3P8
    xJtCWG9FOULwA/G0g1m/zao7mTpQPtOQmeP0BCyVPftcQv3mE3yFYh3xS1Yg
X-ME-Proxy: <xmx:3K57amxApCAYRsglI1DZmktfG1pR3FgrWBm9V4rgEVUB3De4nSELbw>
    <xmx:3K57ao1_BpljEvHnrFg7ZNXF0bk64y8jSHKc6kL5u3ujM-F_HQwAIg>
    <xmx:3K57aqBaPO8GX7JbJR2iMjSvuCjzYreD8JlRIX3VIb1amy0useJ3vQ>
    <xmx:3K57al-ojROQTq8-dwWa_hbhzlO81aPj669Hunwa-B6ljVuMgg1-vg>
    <xmx:3657asMAEszOItIpU9glF6InjOQbk6Sf2j7ksWmAWcvl6yBFTtZh4dfb>
Feedback-ID: i09fe4b60:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 19:23:03 -0400 (EDT)
Message-ID: <75501d4b-7a75-4f0d-8d88-0d631016c9ab@polyxeno.com>
Date: Wed, 12 Aug 2026 09:22:59 +1000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 RESEND] m68k, bpf: Add initial BPF JIT
 compiler support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: geert@linux-m68k.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 marscheng@google.com, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, bpf@vger.kernel.org,
 Daniel Palmer <daniel@thingy.jp>
References: <20260729002737.1008358-1-visitorckw@gmail.com>
 <1ade6c35-7f8a-406d-9c89-8d10218258c6@polyxeno.com>
 <anmiML76I1qSiZLL@google.com>
Content-Language: en-US
From: Greg Ungerer <gerg@polyxeno.com>
In-Reply-To: <anmiML76I1qSiZLL@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuan-Wei,

On 10/8/26 20:04, Kuan-Wei Chiu wrote:
> On Fri, Aug 07, 2026 at 01:28:20AM +1000, Greg Ungerer wrote:
>> Hi Kuan-Wei,
>>
>> On 29/7/26 10:27, Kuan-Wei Chiu wrote:
>>> Add a BPF JIT compiler for the m68k architecture.
>>>
>>> The JIT generates m68k machine code targeting m68020+ processors. It
>>> currently excludes 68000/68010 and coldfire processors, as it relies on
>>> 32 bit branch displacements (b<cc>.l) to handle large bpf programs.
>>
>> I was interested to see how difficult this would be to get working on
>> a ColdFire target. There is a little more to it than just the 32bit
>> branch displacements. If you limit the target space to ColdFire parts
>> that have an MMU (so parts that have the ISA_B or ISA_C instruction
>> set) then 32bit branch displacements are supported. So that is no longer
>> a problem.
>>
>> The following are issues I hit:
>>
>> 1. lack of movem with pre-decrement and post-increment modes
>>    used in quite a few places
>>
>> 2. lack of register exchange instruction ("exg")
>>    used in emit_atomic()
>>    used in emit_call()
>>    used in 64bit bpf shitf operations in emit_alu64_shift()
>>
>> 3. lack of rotate instructions ("ror" and "rox")
>>    used for bpf shift operations in emit_alu64_shift()
>>    used for endian transformation in emit_bpf_end()
>>
>> Issue (1) is easy to work around, manually manipulating %sp as required
>> with an extra instruction.
>>
>> Issue (2) also is easy enough, needing temporary storage.
>>
>> Issue (3) is annoying and means a bunch more instructions to carry
>> out the equivalent operations. None the less it is not too difficult to
>> modify for. ISA_C does have a "byterev" instruction that would make this
>> really easy - but only the very most modern ColdFire silicon use that
>> (like the 5441x family).
>>
>> The attached patch is my first pass at it. It works and passes the
>> test_bpf.ko module with no failures(*). Surely could be optimized a little
>> more, but good enough to get it working. Tested and running on an
>> M5475 ColdFire target.
>>
>>     test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
>>     test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
>>
>>
>> (*) I did come across a cache flush issue specific to ColdFire - but it
>> is not related to this code and can be worked around.
>>
>>
> 
> Thanks for testing the jit and providing the patch to enable coldfire
> support. It's great to see it running successfully on the M5475 target.
> 
> For v5, please let me know how you would prefer to proceed. I can
> either squash your changes directly into my current patch, or keep your
> work as an independent patch and send them together as a patch series.
> Let me know what works best for you.

I am happy if you want to fold it into your existing patch if you think
it is good enough in its current form. Breaking out the ColdFire specific
changes into mostly separate functions seemed like the cleanest approach.

Do you think the Kconfig change - to only condition on MMU - is enough?
I figured that would exclude plain 68000 as well.

Regards
Greg



> Regards,
> Kuan-Wei
>>
> 
>> --- a/arch/m68k/net/bpf_jit_comp.c
>> +++ b/arch/m68k/net/bpf_jit_comp.c
>> @@ -518,6 +518,47 @@
>>  	bpf_put_reg32(dst[0], d_hi, ctx);
>>  }
>>  
>> +static inline void emit_lsh64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
>> +{
>> +	if (CPU_IS_COLDFIRE) {
>> +		emit_16(ctx, 0xd080 | (d_lo << 9) | d_lo);		/* add.l d_lo, d_lo */
>> +		emit_16(ctx, 0xd180 | (d_hi << 9) | d_hi);		/* addx.l d_hi, d_hi */
>> +	} else {
>> +		emit_16(ctx, 0xe388 | d_lo);				/* lsll #1, d_lo */
>> +		emit_16(ctx, 0xe390 | d_hi);				/* roxl.l #1, d_hi */
>> +	}
>> +}
>> +
>> +static inline void emit_rsh64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
>> +{
>> +	if (CPU_IS_COLDFIRE) {
>> +		emit_16(ctx, 0xe288 | d_lo);				/* lsr.l #1, d_lo */
>> +		emit_16(ctx, 0xe288 | d_hi);				/* lsr.l #1, d_hi */
>> +		emit_16(ctx, 0x6400);					/* bcc 1f */
>> +		emit_16(ctx, 0x0006);
>> +		emit_16(ctx, 0x08c0 | d_lo);				/* bset #31, d_lo */
>> +		emit_16(ctx, 0x001f);
>> +	} else {
>> +		emit_16(ctx, 0xe288 | d_hi);				/* lsrl #1, d_hi */
>> +		emit_16(ctx, 0xe290 | d_lo);				/* roxr.l #1, d_lo */
>> +	}
>> +}
>> +
>> +static inline void emit_arsh64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
>> +{
>> +	if (CPU_IS_COLDFIRE) {
>> +		emit_16(ctx, 0xe288 | d_lo);				/* lsr.l #1, d_lo */
>> +		emit_16(ctx, 0xe280 | d_hi);				/* asr.l #1, d_hi */
>> +		emit_16(ctx, 0x6400);					/* bcc 1f */
>> +		emit_16(ctx, 0x0006);
>> +		emit_16(ctx, 0x08c0 | d_lo);				/* bset #31, d_lo */
>> +		emit_16(ctx, 0x001f);
>> +	} else {
>> +		emit_16(ctx, 0xe280 | d_hi);				/* asrl #1, d_hi */
>> +		emit_16(ctx, 0xe290 | d_lo);				/* roxr.l #1, d_lo */
>> +	}
>> +}
>> +
>>  static void emit_alu64_shift(const struct bpf_insn *insn, struct jit_ctx *ctx, bool is_imm)
>>  {
>>  	const s8 *dst = bpf2m68k[insn->dst_reg];
>> @@ -551,16 +592,12 @@
>>  
>>  	loop_start = ctx->idx;
>>  
>> -	if (BPF_OP(insn->code) == BPF_LSH) {
>> -		emit_16(ctx, 0xe388 | d_lo);				/* lsll #1, d_lo */
>> -		emit_16(ctx, 0xe390 | d_hi);				/* roxl.l #1, d_hi */
>> -	} else if (BPF_OP(insn->code) == BPF_RSH) {
>> -		emit_16(ctx, 0xe288 | d_hi);				/* lsrl #1, d_hi */
>> -		emit_16(ctx, 0xe290 | d_lo);				/* roxr.l #1, d_lo */
>> -	} else if (BPF_OP(insn->code) == BPF_ARSH) {
>> -		emit_16(ctx, 0xe280 | d_hi);				/* asrl #1, d_hi */
>> -		emit_16(ctx, 0xe290 | d_lo);				/* roxr.l #1, d_lo */
>> -	}
>> +	if (BPF_OP(insn->code) == BPF_LSH)
>> +		emit_lsh64(ctx, d_lo, d_hi);
>> +	else if (BPF_OP(insn->code) == BPF_RSH)
>> +		emit_rsh64(ctx, d_lo, d_hi);
>> +	else if (BPF_OP(insn->code) == BPF_ARSH)
>> +		emit_arsh64(ctx, d_lo, d_hi);
>>  
>>  	emit_16(ctx, 0x5380 | count_reg);				/* subq.l #1, count_reg */
>>  	emit_16(ctx, 0x6600);						/* bne.w loop_start */
>> @@ -573,6 +610,107 @@
>>  	bpf_put_reg32(dst[0], d_hi, ctx);
>>  }
>>  
>> +static inline void emit_to_le16(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
>> +{
>> +	if (CPU_IS_COLDFIRE) {
>> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
>> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
>> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
>> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
>> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
>> +	} else {
>> +		emit_16(ctx, 0x0280 | d_lo);				/* andi.l #0xffff, d_lo */
>> +		emit_32(ctx, 0xffff);
>> +		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
>> +	}
>> +
>> +	emit_16(ctx, 0x7000 | (d_hi << 9));				/* moveq #0, d_hi */
>> +}
>> +
>> +static inline void emit_to_le32(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
>> +{
>> +	if (CPU_IS_COLDFIRE) {
>> +		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
>> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
>> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
>> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
>> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
>> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
>> +		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
>> +		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
>> +		emit_16(ctx, 0x2e80 | d_hi);				/* move.l d_hi, (%sp) */
>> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
>> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
>> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
>> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
>> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
>> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
>> +		emit_16(ctx, 0x809f | (d_lo << 9));			/* or.l (%sp)+, d_lo */
>> +	} else {
>> +		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
>> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
>> +		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
>> +	}
>> +
>> +	emit_16(ctx, 0x7000 | (d_hi << 9));				/* moveq #0, d_hi */
>> +}
>> +
>> +static inline void emit_to_le64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
>> +{
>> +	if (CPU_IS_COLDFIRE) {
>> +		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
>> +		emit_16(ctx, 0x2f00 | d_hi);				/* move.l d_hi, -(%sp) */
>> +
>> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
>> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
>> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
>> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
>> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
>> +		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
>> +		emit_16(ctx, 0x202f | (d_lo << 9));			/* move.l 4(%sp), d_lo */
>> +		emit_16(ctx, 0x0004);
>> +		emit_16(ctx, 0x2f40 | d_hi);				/* move.l d_hi, 4(%sp) */
>> +		emit_16(ctx, 0x0004);
>> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
>> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
>> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
>> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
>> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
>> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
>> +		emit_16(ctx, 0x81af | (d_lo << 9));			/* or.l d_lo, 4(%sp) */
>> +		emit_16(ctx, 0x0004);
>> +
>> +		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
>> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
>> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
>> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
>> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
>> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
>> +		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
>> +		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
>> +		emit_16(ctx, 0x2e80 | d_hi);				/* move.l d_hi, (%sp) */
>> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
>> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
>> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
>> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
>> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
>> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
>> +		emit_16(ctx, 0x809f | (d_lo << 9));			/* or.l (%sp)+, d_lo */
>> +
>> +		emit_16(ctx, 0x201f | (d_hi << 9));			/* move.l (%sp)+, d_hi */
>> +	} else {
>> +		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
>> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
>> +		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
>> +
>> +		emit_16(ctx, 0xe058 | d_hi);				/* ror.w #8, d_hi */
>> +		emit_16(ctx, 0x4840 | d_hi);				/* swap d_hi */
>> +		emit_16(ctx, 0xe058 | d_hi);				/* ror.w #8, d_hi */
>> +
>> +		emit_16(ctx, 0xc140 | (d_hi << 9) | d_lo);		/* exg d_lo, d_hi */
>> +	}
>> +}
>> +
>>  static void emit_bpf_end(const struct bpf_insn *insn, struct jit_ctx *ctx)
>>  {
>>  	const s8 *dst = bpf2m68k[insn->dst_reg];
>> @@ -587,27 +725,13 @@
>>  	if (to_le) {
>>  		switch (imm) {
>>  		case 16:
>> -			emit_16(ctx, 0x0280 | d_lo);			/* andi.l #0xffff, d_lo */
>> -			emit_32(ctx, 0xffff);
>> -			emit_16(ctx, 0xe058 | d_lo);			/* ror.w #8, d_lo */
>> -			emit_16(ctx, 0x7000 | (d_hi << 9));		/* moveq #0, d_hi */
>> +			emit_to_le16(ctx, d_lo, d_hi);
>>  			break;
>>  		case 32:
>> -			emit_16(ctx, 0xe058 | d_lo);			/* ror.w #8, d_lo */
>> -			emit_16(ctx, 0x4840 | d_lo);			/* swap d_lo */
>> -			emit_16(ctx, 0xe058 | d_lo);			/* ror.w #8, d_lo */
>> -			emit_16(ctx, 0x7000 | (d_hi << 9));		/* moveq #0, d_hi */
>> +			emit_to_le32(ctx, d_lo, d_hi);
>>  			break;
>>  		case 64:
>> -			emit_16(ctx, 0xe058 | d_lo);			/* ror.w #8, d_lo */
>> -			emit_16(ctx, 0x4840 | d_lo);			/* swap d_lo */
>> -			emit_16(ctx, 0xe058 | d_lo);			/* ror.w #8, d_lo */
>> -
>> -			emit_16(ctx, 0xe058 | d_hi);			/* ror.w #8, d_hi */
>> -			emit_16(ctx, 0x4840 | d_hi);			/* swap d_hi */
>> -			emit_16(ctx, 0xe058 | d_hi);			/* ror.w #8, d_hi */
>> -
>> -			emit_16(ctx, 0xc140 | (d_hi << 9) | d_lo);	/* exg d_lo, d_hi */
>> +			emit_to_le64(ctx, d_lo, d_hi);
>>  			break;
>>  		}
>>  	} else {
>> @@ -692,8 +816,8 @@
>>  	}
>>  
>>  	if (is_64) {
>> -		emit_16(ctx, 0x48e7);					/* movem.l d0-d1, -(%sp) */
>> -		emit_16(ctx, 0xc000);
>> +		emit_16(ctx, 0x2f01);					/* move.l d1, -(%sp) */
>> +		emit_16(ctx, 0x2f00);					/* move.l d0, -(%sp) */
>>  
>>  		emit_16(ctx, 0x2f00 | s_lo);				/* move.l s_lo, -(%sp) */
>>  		emit_16(ctx, 0x2f00 | s_hi);				/* move.l s_hi, -(%sp) */
>> @@ -710,11 +834,11 @@
>>  		emit_16(ctx, 0x2601);					/* move.l %d1, %d3 */
>>  		emit_16(ctx, 0x2400);					/* move.l %d0, %d2 */
>>  
>> -		emit_16(ctx, 0x4cdf);					/* movem.l (%sp)+, d0-d1 */
>> -		emit_16(ctx, 0x0003);
>> +		emit_16(ctx, 0x201f);					/* move.l (%sp)+, d0 */
>> +		emit_16(ctx, 0x221f);					/* move.l (%sp)+, d1 */
>>  	} else {
>> -		emit_16(ctx, 0x48e7);					/* movem.l d0-d1, -(%sp) */
>> -		emit_16(ctx, 0xc000);
>> +		emit_16(ctx, 0x2f01);					/* move.l d1, -(%sp) */
>> +		emit_16(ctx, 0x2f00);					/* move.l d0, -(%sp) */
>>  
>>  		emit_16(ctx, 0x2f00 | s_lo);				/* move.l s_lo, -(%sp) */
>>  		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
>> @@ -729,8 +853,8 @@
>>  		emit_16(ctx, 0x2600);					/* move.l %d0, %d3 */
>>  		emit_16(ctx, 0x7400);					/* moveq #0, %d2 */
>>  
>> -		emit_16(ctx, 0x4cdf);					/* movem.l (%sp)+, d0-d1 */
>> -		emit_16(ctx, 0x0003);
>> +		emit_16(ctx, 0x201f);					/* move.l (%sp)+, d0 */
>> +		emit_16(ctx, 0x221f);					/* move.l (%sp)+, d1 */
>>  	}
>>  
>>  	bpf_put_reg32(dst[1], M68K_D3, ctx);
>> @@ -905,8 +1029,8 @@
>>  		s8 s_lo = bpf_get_reg32(src[1], tmp2[1], ctx);
>>  
>>  		if (insn->imm != BPF_CMPXCHG) {
>> -			emit_16(ctx, 0x48e7);			/* movem.l d0-d1, -(%sp) */
>> -			emit_16(ctx, 0xc000);
>> +			emit_16(ctx, 0x2f01);			/* move.l d1, -(%sp) */
>> +			emit_16(ctx, 0x2f00);			/* move.l d0, -(%sp) */
>>  		}
>>  
>>  		emit_16(ctx, 0x2f00 | M68K_D0);			/* move.l %d0, -(%sp) */
>> @@ -930,8 +1054,8 @@
>>  			if (is_fetch)
>>  				emit_16(ctx, 0x2600);		/* move.l %d0, %d3 */
>>  
>> -			emit_16(ctx, 0x4cdf);			/* movem.l (%sp)+, d0-d1 */
>> -			emit_16(ctx, 0x0003);
>> +			emit_16(ctx, 0x201f);			/* move.l (%sp)+, d0 */
>> +			emit_16(ctx, 0x221f);			/* move.l (%sp)+, d1 */
>>  
>>  			if (is_fetch) {
>>  				bpf_put_reg32(src[1], M68K_D3, ctx);
>> @@ -945,8 +1069,8 @@
>>  		s8 s_hi = bpf_get_reg32(src[0], tmp2[0], ctx);
>>  
>>  		if (insn->imm != BPF_CMPXCHG) {
>> -			emit_16(ctx, 0x48e7);			/* movem.l d0-d1, -(%sp) */
>> -			emit_16(ctx, 0xc000);
>> +			emit_16(ctx, 0x2f01);			/* move.l d1, -(%sp) */
>> +			emit_16(ctx, 0x2f00);			/* move.l d0, -(%sp) */
>>  		}
>>  
>>  		emit_16(ctx, 0x2f00 | M68K_D0);			/* move.l %d0, -(%sp) */
>> @@ -965,7 +1089,13 @@
>>  		emit_16(ctx, 24);
>>  
>>  		if (insn->imm == BPF_CMPXCHG) {
>> -			emit_16(ctx, 0xc141);			/* exg %d0, %d1 */
>> +			if (CPU_IS_COLDFIRE) {
>> +				emit_16(ctx, 0x2f00);		/* move.l %d0, -(%sp) */
>> +				emit_16(ctx, 0x2001);		/* move.l %d1, %d0 */
>> +				emit_16(ctx, 0x221f);		/* move.l (%sp)+, %d1 */
>> +			} else {
>> +				emit_16(ctx, 0xc141);		/* exg %d0, %d1 */
>> +			}
>>  		} else {
>>  			bool is_fetch = (insn->imm & BPF_FETCH) || insn->imm == BPF_XCHG;
>>  
>> @@ -974,8 +1104,8 @@
>>  				emit_16(ctx, 0x2401);		/* move.l %d1, %d2 */
>>  			}
>>  
>> -			emit_16(ctx, 0x4cdf);			/* movem.l (%sp)+, d0-d1 */
>> -			emit_16(ctx, 0x0003);
>> +			emit_16(ctx, 0x201f);			/* move.l (%sp)+, d0 */
>> +			emit_16(ctx, 0x221f);			/* move.l (%sp)+, d1 */
>>  
>>  			if (is_fetch) {
>>  				bpf_put_reg32(src[1], M68K_D2, ctx);
>> @@ -1244,8 +1374,15 @@
>>  	emit_16(ctx, 0x4fef);					/* lea 40(%sp), %sp */
>>  	emit_16(ctx, 40);
>>  
>> -	if (insn->src_reg != BPF_PSEUDO_CALL)
>> -		emit_16(ctx, 0xc340);					/* exg %d0, %d1 */
>> +	if (insn->src_reg != BPF_PSEUDO_CALL) {
>> +		if (CPU_IS_COLDFIRE) {
>> +			emit_16(ctx, 0x2f00);			/* move.l %d0, -(%sp) */
>> +			emit_16(ctx, 0x2001);			/* move.l %d1, %d0 */
>> +			emit_16(ctx, 0x221f);			/* move.l (%sp)+, %d1 */
>> +		} else {
>> +			emit_16(ctx, 0xc340);			/* exg %d0, %d1 */
>> +		}
>> +	}
>>  
>>  	return 0;
>>  }
>> @@ -1261,8 +1398,15 @@
>>  	emit_16(ctx, 0x4e56);					/* link %a6, #-total_stack */
>>  	emit_16(ctx, -total_stack);
>>  
>> -	emit_16(ctx, 0x48e7);					/* movem.l d2-d5, -(%sp) */
>> -	emit_16(ctx, 0x3c00);
>> +	if (CPU_IS_COLDFIRE) {
>> +		emit_16(ctx, 0x4fef);				/* lea -16(%sp), %sp */
>> +		emit_16(ctx, 0xfff0);
>> +		emit_16(ctx, 0x48d7);				/* movem.l d2-d5, (%sp) */
>> +		emit_16(ctx, 0x003c);
>> +	} else {
>> +		emit_16(ctx, 0x48e7);				/* movem.l d2-d5, -(%sp) */
>> +		emit_16(ctx, 0x3c00);
>> +	}
>>  
>>  	emit_16(ctx, 0x2d40);					/* move.l %d0, off(%fp) */
>>  	emit_16(ctx, (u16)STACK_OFFSET(BPF_TC_LO));
>> @@ -1302,8 +1446,15 @@
>>  
>>  static void build_epilogue(struct jit_ctx *ctx)
>>  {
>> -	emit_16(ctx, 0x4cdf);					/* movem.l (%sp)+, d2-d5 */
>> -	emit_16(ctx, 0x003c);
>> +	if (CPU_IS_COLDFIRE) {
>> +		emit_16(ctx, 0x4cd7);				/* movem.l (%sp), d2-d5 */
>> +		emit_16(ctx, 0x003c);
>> +		emit_16(ctx, 0x4fef);				/* lea 16(%sp), %sp */
>> +		emit_16(ctx, 0x0010);
>> +	} else {
>> +		emit_16(ctx, 0x4cdf);				/* movem.l (%sp)+, d2-d5 */
>> +		emit_16(ctx, 0x003c);
>> +	}
>>  
>>  	emit_16(ctx, 0x4e5e);					/* unlk %fp */
>>  	emit_16(ctx, 0x4e75);					/* rts */
>> --- a/arch/m68k/Kconfig
>> +++ b/arch/m68k/Kconfig
>> @@ -8,7 +8,7 @@
>>  	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
>>  	select ARCH_HAS_CURRENT_STACK_POINTER
>>  	select ARCH_HAS_DMA_PREP_COHERENT if M68K_NONCOHERENT_DMA && !COLDFIRE
>> -	select HAVE_EBPF_JIT if (!COLDFIRE && !M68000)
>> +	select HAVE_EBPF_JIT if MMU
>>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if M68K_NONCOHERENT_DMA
>>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
>>  	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
> 

