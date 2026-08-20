Received: from mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC838B15B
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252127; cv=none; b=XEp5APN0grU4XbID3/dDF3sbbxQsiI2h6kvElNyEbnI0EP7qxh3Y9mgAL5/NJp5nv4qsULUinl4T7sGmPx5WAGtWQO9nHz4k5j0tXHS36OfmJTyzuNyLgNrAgFc3U1+xSSC41R5vzczKLQF67dbQ/yYcMnyfju630enFJ0iBDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252127; c=relaxed/simple;
	bh=BYijUTdm+orM9I18GTSVdsRiGIWupi5fX79ayzW7mWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HM+1ERl4p9pMHm61zHAR+XBkw42bBYimfM1RSe/Ht3s6FjKGxRdrAKVyyIVeq/D8SVIJd6663v0zP/TLaYYp6bi5MgdAVw2Q1e1bFdZcQ/h/y/2vnnZx4oQ3Rpx+2jDQ+EVGnD3oLt28fH4ueeX7RwiSwtH/HzljICHTLDxQrNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FdFwlWbt; arc=none smtp.client-ip=95.215.58.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FdFwlWbt"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BYijUTdm+orM9I18GTSVdsRiGIWupi5fX79ayzW7mWQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787252121; v=1; x=1787856921;
 b=FdFwlWbtOzs1ImaiQygqVHkSv5IOa9mNWFwxMUMztRKRKiRfjs2JE5G5u5m8EgisnfctCg/C
 R61paKTaJK06KHTs5T1jTV+BkaHS0YE9MlrpE+ok7sw920P+ZTTFQigcq92qYvRTyW1N5y8RxGN
 W+1RJqOYT/FidgWcxz2BDPwA=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::4:9261)
	by smtp.migadu.com with ESMTPS id dbe889990013fa15;
	Thu, 20 Aug 2026 18:55:20 +0000
X-Mizu-Trace-ID: dbe889990013fa15
X-Migadu-Flow: FLOW_OUT
Message-ID: <15d67935-9267-45b2-a8ed-e64c837491d4@linux.dev>
Date: Thu, 20 Aug 2026 11:55:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Track linked scalars across a "rX <<= 32;
 rX >>= 32" zero extension
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260820013925.2515018-1-yonghong.song@linux.dev>
 <88b2bba531714814df5a2c4fe9d10aadfd4cce47.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <88b2bba531714814df5a2c4fe9d10aadfd4cce47.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/20/26 9:57 AM, Eduard Zingerman wrote:
> On Wed, 2026-08-19 at 18:39 -0700, Yonghong Song wrote:
>> For the following test in
>> tools/testing/selftests/bpf/progs/verifier_linked_scalars.c:
>>
>> 	void alu32_negative_offset(void)
>> 	{
>> 		volatile char path[5];
>> 		volatile int offset = bpf_get_prandom_u32();
>> 		int off = offset;
>>
>> 		if (off >= 5 && off < 10)
>> 			path[off - 5] = '.';
>>
>> 		/* So compiler doesn't say: error: variable 'path' set but not used */
>> 		__sink(path[0]);
>> 	}
>>
>> Without alu32 (-mcpu=v2), the test
>> verifier_linked_scalars/alu32_negative_offset will fail with llvm22 and
>> llvm23 like below.
>>
>>    3: (bf) r2 = r1               ; R1=scalar(id=1,...) R2=scalar(id=1,...)
>>    4: (07) r2 += -5              ; R2=scalar(id=1-5,smin=-5,smax=0xfffffffa)
>>    5: (67) r2 <<= 32             ; R2=scalar(smax=0x7fffffff00000000,...)
>>    6: (77) r2 >>= 32             ; R2=scalar(smin=0,umax=0xffffffff,...)
>>    7: (25) if r2 > 0x4 goto pc+5 ; R2=scalar(smin=0,smax=umax=4,...)
>>    8: (bf) r2 = r10
>>    9: (07) r2 += -5
>>   10: (0f) r2 += r1              ; R1=scalar(id=1,smin=0,umax=0xffffffff)
>>                                  ; R2=fp(smin=-5,smax=0xfffffffa)
>>   11: (b7) r1 = 46               ; R1=46
>>   12: (73) *(u8 *)(r2 -5) = r1
>>   invalid unbounded variable-offset write to stack R2
>>
>> R1 is never narrowed down, so the address stays unbounded and the store
>> is rejected.
>>
>> The test is okay for llvm21 with -mcpu=v2, see below:
>>
>>    3: (07) r1 += -5              ; R1=scalar(smin=-5,smax=0xfffffffa)
>>    4: (67) r1 <<= 32             ; R1=scalar(smax=0x7fffffff00000000,...)
>>    5: (77) r1 >>= 32             ; R1=scalar(smin=0,umax=0xffffffff,...)
>>    6: (25) if r1 > 0x4 goto pc+5 ; R1=scalar(smin=0,smax=umax=4,...)
>>    7: (bf) r2 = r10
>>    8: (07) r2 += -5
>>    9: (0f) r2 += r1              ; R2=fp(smin=-5,smax=-1)
>>   10: (b7) r1 = 46               ; R1=46
>>   11: (73) *(u8 *)(r2 +0) = r1   ; fp-8=ppppm???
>>
>> To fix the test issue with llvm22 and llvm23, note that the shift pair
>> computes zext32(base + delta), which is exactly the relation
>> BPF_ADD_CONST32 describes. So keep the link alive across the first
>> shift and turn it from a 64-bit into a 32-bit one at the second, which
>> makes the -mcpu=v2 sequence track like an alu32 one.
>>
>> Two conditions guard this. First, a 32-bit link requires the linked
>> value to fit into u32, because sync_linked_regs() zero extends the
>> bounds it propagates through such a link. linked_base_fits_u32() checks
>> that on the register state before the shift, mirroring the dst_umax
>> check the alu32 add path already does. Second, in between the two
>> shifts the register does not hold the value its id and delta describe,
>> so the second shift must have a single incoming edge, otherwise the
>> intermediate state could be checkpointed and another path pruned
>> against it.
>>
>> With this, the llvm22 and llvm23 code verifies, R2 keeps its id through
>> both shifts and the jump narrows down R1:
>>
>>    3: (bf) r2 = r1               ; R1=scalar(id=1,...) R2=scalar(id=1,...)
>>    4: (07) r2 += -5              ; R2=scalar(id=1-5,smin=-5,smax=0xfffffffa)
>>    5: (67) r2 <<= 32             ; R2=scalar(id=1-5,smax=0x7fffffff00000000)
>>    6: (77) r2 >>= 32             ; R2=scalar(id=1-5,smin=0,umax=0xffffffff)
>>    7: (25) if r2 > 0x4 goto pc+5 ; R1=scalar(id=1,smin=5,smax=9,...)
>>                                  ; R2=scalar(id=1-5,smin=0,smax=4,...)
>>    8: (bf) r2 = r10
>>    9: (07) r2 += -5
>>   10: (0f) r2 += r1              ; R2=fp(smin=0,smax=4)
>>   11: (b7) r1 = 46               ; R1=46
>>   12: (73) *(u8 *)(r2 -5) = r1   ; fp-8=ppppm???
>>
>> The llvm21 log is unchanged, R1 carries no id there so the new code
>> does not apply to it.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> I think this is too tricky. A simpler thing is to rewrite the incoming
> program as `w2 = w1; nop;` in place of two shifts. The CFG check would
> still be necessary, though.

For just left and right shift, probably `w2 = w2; nop;`.
But this approach is indeed simpler and easier to understand.
Will explore.

>
> ...

