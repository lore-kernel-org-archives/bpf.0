Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1431985C
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928696; cv=none; b=BmxdQFt2OOk10TRWhTc1rPOcK1mJxIlsjuFNHrK19DUZAnQdAXlO2E3EUtWEZUKS2gLgs9ZjKqux8kwl24LL/yPoOE0knsT+Ml94W5ZAWHneaL5i/qailQGRo4/0HIm6vxUmlHd4+E1ehSEFBzFe+KXKGmcKEt7JUGpF9MP2yHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928696; c=relaxed/simple;
	bh=20BNAu0toLJu3EDSbAd1PFkdToLOSXojvcM2xNhDLFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDB4I6tvfJRdy7cg+vBHhAT8UOhMnPo80chppnLB3mPQ98DDPAn+Y0UbfGg7LXqJ3ACucE6MuNCPEyVAwml6WlVGF0TmGmcliXNg99We+QD+5/Yip6qyJ7+mBTmtETPeS6qzjbo09R4NKpte6M/kh9IxtRfyzZ/4j84vIwA6bms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P/R7+NSk; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P/R7+NSk"
Message-ID: <1585500e-ad00-427e-91f7-7beb60303a0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782928690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJwnGWtiO6o/kI+CCb46HCwB5s1Rnx47zF25eEQimqo=;
	b=P/R7+NSkYG6BLdnct5/DBB0tNY+imhfXivPm5Ui1gqhYLA9c8r7nKiEWOJN02AXSGyze1w
	7GQrE1fNBy9uFu9OkbIAncsRNxqVWrTzEDoDpUx8EcO+BpPhg6XSkFYX+J12KP2pY/Thno
	GlAJNyzL2t220svW2FygDnPwOwY7tos=
Date: Wed, 1 Jul 2026 10:58:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Verifier aspects of (was Re: gcc [RFC] bpf: don't synthesize
 sign_extend for ISA v4)
Content-Language: en-GB
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@gcc.gnu.org
Cc: jose.marchesi@oracle.com, ast@kernel.org,
 Eduard Zingerman <eddyz87@gmail.com>, David Faust <david.faust@oracle.com>,
 bpf <bpf@vger.kernel.org>
References: <20260413185834.58706-1-vineet.gupta@linux.dev>
 <992e0697-f0da-4bfd-8178-abb206410e9d@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <992e0697-f0da-4bfd-8178-abb206410e9d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/30/26 11:05 AM, Vineet Gupta wrote:
> On 4/13/26 11:58 AM, Vineet Gupta wrote:
>> Currently the extendsidi2 expander generates a shift left+right to
>> materialize a sign_extend. This is not needed for ISA v4 which
>> natively supports the sign extending move.
>>
>> There are various other reasons for fixing this:
>>
>>   - The shifts are throwaway work since Combine subsequently undoes them
>>     anyways, while diminishing potential opportunities for other optim
>>     transformations it could have done, given to its own limitations of
>>     max 3 -> 2 combinations.
>>
>>   - Interim passes scuh as CSE1 can also "see thru" a native 
>> sign_extend:DI
>>     better than the shifts, again opening up more optimization 
>> opportunites.
>>
>>   - It also helps slightly with debugging Expand dumps as sign_extend is
>>     obvious vs. 2 shifts.
>>
>> The fix itself is easy: just gate the expander on non-availabilty of 
>> smov
>> which in turn is keyed off of -msmov or -mcpu.
>>
>>                   Before                              After
>> ----------------------------------------+--------------------------------------- 
>>
>> (insn 8 7 9 2 (set (reg:DI 19 [ _1 ])   |  (insn 8 7 9 2 (set (reg:DI 
>> 19 [ _1 ])
>>     (ashift:DI (subreg:DI (reg:SI 24) 0) |     (sign_extend:DI 
>> (reg:SI 24)))
>>        (const_int 32 [0x20])))           |       (nil))
>>    (nil))                                |
>> (insn 9 8 10 2 (set (reg:DI 19 [ _1 ])  |
>>     (ashiftrt:DI (reg:DI 19 [ _1 ])      |
>>        (const_int 32 [0x20])))           |
>>    (nil))                                |
>>
>> This change is clean running bpf.exp testsuite tests.
>>
>> The complication comes from a subtle yet very important aspect, which is
>> in the old regime, expander unconditionally forced src operand to 
>> DImode.
>>
>> |  operands[1] = gen_lowpart (DImode, operands[1])
>>
>> With the patch, src remains SImode which exposes some latent issues in
>> the backend and/or "impedance mismatch [1]" with the kernel verifier 
>> and it
>> reports following additional fails vs. gcc trunk against kernel 
>> bpf-next [2]
>>
>> | #12      attach_probe:FAIL
>> | #74      cgroup_xattr:FAIL
>> | #122     file_reader:FAIL
>> | #412     sockopt_inherit:FAIL
>> | #413     sockopt_multi:FAIL
>
> For sockopt_multi, the trunk version we have the following snippet:
>
>    0: (81) r0 = *(s32 *)(r1 +24)         ; 
> R0=scalar(smin=0xffffffff80000000,smax=0x7fffffff) R1=ctx()
>    1: (55) if r0 != 0x0 goto pc+10       ; R0=0
>    ...
>    11: (95) exit
>
> Insn 1 branch is not taken, so upon exit, verifier is happy that r0 == 0.
>
> W/ the patch, codegen changes slightly
>
>    0: (61) r2 = *(u32 *)(r1 +24)         ; R1=ctx() 
> R2=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
>    1: (bf) r0 = (s32)r2                  ; 
> R0=scalar(smin=0xffffffff80000000,smax=0x7fffffff) 
> R2=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
>    2: (56) if w2 != 0x0 goto pc+10       ; R2=0
>    ...
>    12: (95) exit
>
> Here's verifier can't conclude that r0 is 0 or 1 and complains.
>
> For sign extending move, verifier: check_alu_op () can't establish 
> that truncated+extended r2 value (r0) and r2 are and equivalent and 
> delinks the scalar ids. So on insn 2 it can deduce that r2 == 0, it 
> can't be backpropagated due to delinking of the regs. We initially 
> thought this would be a simple "bug fix" in the verifier. But it seems 
> this requires additional state tracking - currently all 64-bits are 
> tracked with copy_register_state, this need to be broken down into 
> separate lo/hi bits with additional link kind similar to BPF_ADD_CONST 
> - will that be acceptable ?
>
> What's also interesting is for a reduced version the codegen 
> difference between gcc trunk and clang.
> The first load is a regular signed int access so technically it needs 
> to be either *(s32 *) or a *(u32*) + (s32).
> Clang seems to be eliding sign extension altogether [1] and only 
> generating *(u32 *)
> Any thoughts why clang can do that ?

The clang didn't use s32 becomes there is no need.
Related code:

    struct bpf_sockopt {
       int level, optname, optlen, retval;
       void *optval_end, *optval;
    };
    ...
    if (ctx->level != 0 || ctx->optname != 1)
       goto out;

In such case, there is NO sign-extenstion need from 32bit to 64bit.
So llvm decides to just use unsigned load (LDW32).

>
> [1] https://godbolt.org/z/fsdrExPWd
>
> Thx,
> -Vineet
>
>> | #415     sockopt_sk:FAIL
>> | #517     uprobe_multi_test:FAIL
>> | #519     usdt:FAIL
>> | #649     verif_scale_pyperf600_iter:FAIL
>>
>> These fallout issues need to be addressed first but as discussed in the
>> bpf patchworks call this morning, I'm sending this out as an RFC.
>>
>> [1] https://devblogs.microsoft.com/oldnewthing/20180123-00/?p=97865
>> [2] 2026-02-18 f620af11c27b ("xsk: avoid double checking against rx 
>> queue being full")
>>
>> gcc/ChangeLog:
>>
>>     * config/bpf/bpf.md (define_expand extendsidi2): Only emit shifts
>>     if !bpf_has_smov.
>>
>> gcc/testsuite/ChangeLog:
>>
>>     * gcc.target/bpf/zero-ext.c: Check Expand dumps to ensure
>>     sign_extend is present and two shifts are not.
>>
>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
>> ---
>>   gcc/config/bpf/bpf.md                   | 12 ++++++++----
>>   gcc/testsuite/gcc.target/bpf/zero-ext.c |  5 ++++-
>>   2 files changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/gcc/config/bpf/bpf.md b/gcc/config/bpf/bpf.md
>> index a2bceb8998d7..1431bfd225e0 100644
>> --- a/gcc/config/bpf/bpf.md
>> +++ b/gcc/config/bpf/bpf.md
>> @@ -308,16 +308,20 @@
>>     ;; Sign-extending a 32-bit value into a 64-bit value is achieved 
>> using
>>   ;; shifting, with instructions generated by the expand below.
>> +;; Only needed for ISA V3 and prior builds.
>>     (define_expand "extendsidi2"
>>     [(set (match_operand:DI 0 "register_operand")
>>       (sign_extend:DI (match_operand:SI 1 "register_operand")))]
>>     ""
>>   {
>> -  operands[1] = gen_lowpart (DImode, operands[1]);
>> -  emit_insn (gen_ashldi3 (operands[0], operands[1], GEN_INT (32)));
>> -  emit_insn (gen_ashrdi3 (operands[0], operands[0], GEN_INT (32)));
>> -  DONE;
>> +  if (!bpf_has_smov)
>> +    {
>> +      operands[1] = gen_lowpart (DImode, operands[1]);
>> +      emit_insn (gen_ashldi3 (operands[0], operands[1], GEN_INT (32)));
>> +      emit_insn (gen_ashrdi3 (operands[0], operands[0], GEN_INT (32)));
>> +      DONE;
>> +    }
>>   })
>
>

