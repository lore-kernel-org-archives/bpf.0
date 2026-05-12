Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F713B7A3
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 04:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778559451; cv=none; b=lYxrpj9O8OdZ9vIMNyIPwpGNqWiDR0hJFIdAXsPTXtxQQ66pak79nPyqagX2Pyh0DD8+C5ZKJ3QuPwWpJuJef5PrhCSOe98xHmmMpcr7VFKnvlhKrMTD2bw/Jbdx1jsaUbp2cfatJ85HbnF96SDiyGr6x3fOQXYD2goMairB4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778559451; c=relaxed/simple;
	bh=MbUl5FWM+/fxW8yiP1LS8JvK+vqgdEVXBK1Na1f6yx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCH3d5F6q8Q1js+Ty3z9v2LM6qAGuGJcUDyHbwiIBbk6em0wmKFVu2Z4g+SEoPtbDAiSy8KIC/MSBy3SkV8DZ3+NJ92papz2a1Wp03ioVhMi+OZjIFYW0vthLbIXTgqTV2QeYll5i1dH0Bd9144ZveS/4H4rMcNhjp7w3U2yHDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sX8vwZns; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sX8vwZns"
Message-ID: <5a0b1bdf-951f-4a0c-909a-8c7b0ed8cdc7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778559447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11o/mSZ75UjD9c31Euc5snZyT2riPRbmHowPtsb9JHs=;
	b=sX8vwZnsi7iTMzLYoWyI6Ul8fCkR5wl/Bm2/U/p4Sldwn/Ip9aNlK9TEDB72xwetd3iHVp
	9jR3W6aQBFyY6IAGFeL0Du2Y48NzPKFZegqjkWM51mweca/inqf7v5XHuq3boHL1SVHMHf
	qxO+r/pQHDHLu/6S/IPpemYeL8v1gXE=
Date: Mon, 11 May 2026 21:17:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 05/24] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260511053327.1883871-1-yonghong.song@linux.dev>
 <1bb0dfc54cc2dbe6a38c21af2717f1b575ba60ba66a763952f38ada03a65bf85@mail.kernel.org>
 <1718e913-d51d-4e81-9106-c39c88e9e160@linux.dev>
 <DIFZ4QX7T164.30KVT7BJ584K7@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIFZ4QX7T164.30KVT7BJ584K7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/11/26 6:05 PM, Alexei Starovoitov wrote:
> On Mon May 11, 2026 at 8:46 AM PDT, Yonghong Song wrote:
>>
>> On 5/11/26 8:19 AM, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>>> index 321b9d69cf9c..f9020a4ea005 100644
>>>> --- a/include/linux/bpf_verifier.h
>>>> +++ b/include/linux/bpf_verifier.h
>>>> @@ -402,6 +402,7 @@ struct bpf_func_state {
>>>>    	bool in_callback_fn;
>>>>    	bool in_async_callback_fn;
>>>>    	bool in_exception_callback_fn;
>>>> +	bool no_stack_arg_load;
>>> [ ... ]
>>>
>>>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>>>> index bd9c22945050..c249eb40c6d6 100644
>>>> --- a/kernel/bpf/states.c
>>>> +++ b/kernel/bpf/states.c
>>>> @@ -833,6 +833,32 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>>>    	return true;
>>>>    }
>>>>
>>>> +/*
>>>> + * Compare stack arg slots between old and current states.
>>>> + * Outgoing stack args are path-local state and must agree for pruning.
>>>> + */
>>>> +static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>>> +			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
>>>> +			   enum exact_level exact)
>>>> +{
>>>> +	int i, nslots;
>>>> +
>>>> +	nslots = max(old->out_stack_arg_cnt, cur->out_stack_arg_cnt);
>>>> +	for (i = 0; i < nslots; i++) {
>>>> +		struct bpf_reg_state *old_arg, *cur_arg;
>>>> +		struct bpf_reg_state not_init = { .type = NOT_INIT };
>>>> +
>>>> +		old_arg = i < old->out_stack_arg_cnt ?
>>>> +			  &old->stack_arg_regs[i] : &not_init;
>>>> +		cur_arg = i < cur->out_stack_arg_cnt ?
>>>> +			  &cur->stack_arg_regs[i] : &not_init;
>>>> +		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
>>>> +			return false;
>>>> +	}
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>>    static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *cur,
>>>>    		    struct bpf_idmap *idmap)
>>>>    {
>>>> @@ -924,6 +950,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
>>>>    	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
>>>>    		return false;
>>>>
>>>> +	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
>>>> +		return false;
>>>> +
>>>>    	return true;
>>>>    }
>>> In v2 (May 7), bot+bpf-ci@kernel.org raised a concern that
>>> no_stack_arg_load is not compared during state pruning in
>>> func_states_equal():
>>>
>>>       "The same issue applies to state pruning: func_states_equal/
>>>       stack_arg_safe does not compare no_stack_arg_load either, so a
>>>       state with no_stack_arg_load=true can be pruned to an old state
>>>       with no_stack_arg_load=false incorrectly. Should no_stack_arg_load
>>>       be placed before stack (to be memcpy'd) or should copy_stack_state()
>>>       explicitly assign it?"
>>>
>>> The field placement was fixed (moving no_stack_arg_load before 'stack'
>>> so it gets copied by memcpy), but func_states_equal() still does not
>>> explicitly compare this field.
>>>
>>> Could this allow incorrect pruning? If a BPF program writes to stack
>>> args and calls a function on one path (setting no_stack_arg_load=true),
>>> then branches and tries to read from stack args on another path, the
>>> verifier might incorrectly prune to the old state with
>>> no_stack_arg_load=false, missing the enforcement that stack arg reads
>>> must happen before writes/calls.
>>>
>>> Looking at func_states_equal():
>>>
>>> kernel/bpf/states.c:func_states_equal() {
>>>       if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
>>>           return false;
>>>
>>>       if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
>>>           return false;
>>>
>>>       return true;
>>> }
>>>
>>> Should no_stack_arg_load be compared here, similar to how other boolean
>>> flags in bpf_func_state are handled during state comparison?
>> You are right. The following is an example:
>>
>>     /* subprog with incoming stack arg */
>>     r1 = *(r11+8);         /* read incoming arg, no_stack_arg_load = false */
>>                                                                                                                      
>>     if cond goto path2;
>>                                                                                                                      
>>     path1:
>>       call some_helper;    /* sets no_stack_arg_load = true */
>>       goto join;
>>                                                                                                                      
>>     path2:
>>       /* no call, no_stack_arg_load = false */
>>       goto join;
>>                                                                                                                      
>>     join:
>>       r2 = *(r11+8);       /* read incoming arg again */
>>
>> In the above case, at 'join' point, we have no_stack_arg_load = true and false
>> respectively. In this case, we cannot do pruning.
>>
>> Will fix.
> Hold on. Didn't we agree that any call should scratch all arg slots?
> In the above example call some_helper will scratch it and last read shouldn't be allowed.

Looks like we may still need to compare no_stack_arg_load in func_states_equal().
The following is an example:

The selftest:

+__noinline __used __naked
+static int subprog_pruning_call_before_load_6args(int a, int b, int c, int d,
+                                                 int e, int f)
+{
+       asm volatile (
+               "if r1 s> 0 goto l0_%=;"
+               "goto l1_%=;"
+       "l0_%=:"
+               "call %[bpf_get_prandom_u32];"
+       "l1_%=:"
+               "r0 = *(u64 *)(r11 + 8);"
+               "exit;"
+               :: __imm(bpf_get_prandom_u32)
+               : __clobber_all
+       );
+}
+
+SEC("tc")
+__description("stack_arg: pruning keeps r11 load ordering")
+__failure
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("r11 load must be before any r11 store or call insn")
+__btf_func_path("btf__verifier_stack_arg_order.bpf.o")
+__naked void stack_arg_pruning_load_after_call(void)
+{
+       asm volatile (
+               "call %[bpf_get_prandom_u32];"
+               "r1 = r0;"
+               "r2 = 2;"
+               "r3 = 3;"
+               "r4 = 4;"
+               "r5 = 5;"
+               "*(u64 *)(r11 - 8) = 6;"
+               "call subprog_pruning_call_before_load_6args;"
+               "exit;"
+               :: __imm(bpf_get_prandom_u32)
+               : __clobber_all
+       );
+}

It needs the following

diff --git a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
index 2d5ddb24e241..83692570d5bc 100644
--- a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
@@ -15,6 +15,11 @@ int subprog_call_before_load_6args(int a, int b, int c, int d, int e, int f)
         return a + b + c + d + e + f;
  }
  
+int subprog_pruning_call_before_load_6args(int a, int b, int c, int d, int e, int f)
+{
+       return a + b + c + d + e + f;
+}
+
  #else
  
  int subprog_bad_order_6args(void)
@@ -27,4 +32,9 @@ int subprog_call_before_load_6args(void)
         return 0;
  }
  
+int subprog_pruning_call_before_load_6args(void)
+{
+       return 0;
+}
+
  #endif

in order to get proper BTF for subprog_pruning_call_before_load_6args().

With the above, the following is the verifier log:

func#0 @0
func#1 @9
topo_order[0] = subprog_pruning_call_before_load_6args
topo_order[1] = stack_arg_pruning_load_after_call
subprog#0: analyzing (depth 0)...
subprog#0 stack_arg_pruning_load_after_call:
   0: (85) call bpf_get_prandom_u32#7
   1: (bf) r1 = r0
   2: (b7) r2 = 2
   3: (b7) r3 = 3
   4: (b7) r4 = 4
   5: (b7) r5 = 5
   6: (7a) *(u64 *)(r11 -8) = 6
   7: (85) call pc+1
   8: (95) exit
subprog#1: analyzing (depth 0)...
subprog#1 subprog_pruning_call_before_load_6args:
   9: (65) if r1 s> 0x0 goto pc+1
  10: (05) goto pc+1
  11: (85) call bpf_get_prandom_u32#7
  12: (79) r0 = *(u64 *)(r11 +8)
  13: (95) exit
stack use/def subprog#0 stack_arg_pruning_load_after_call (d0,cs0):
   0: (85) call bpf_get_prandom_u32#7
   1: (bf) r1 = r0
   2: (b7) r2 = 2
   3: (b7) r3 = 3
   4: (b7) r4 = 4
   5: (b7) r5 = 5
   6: (7a) *(u64 *)(r11 -8) = 6
   7: (85) call pc+1
   8: (95) exit
stack use/def subprog#1 subprog_pruning_call_before_load_6args (d0,cs9):
   9: (65) if r1 s> 0x0 goto pc+1
  10: (05) goto pc+1
  11: (85) call bpf_get_prandom_u32#7
  12: (79) r0 = *(u64 *)(r11 +8)
  13: (95) exit
Live regs before insn:
       0: .......... (85) call bpf_get_prandom_u32#7
       1: 0......... (bf) r1 = r0
       2: .1........ (b7) r2 = 2
       3: .12....... (b7) r3 = 3
       4: .123...... (b7) r4 = 4
       5: .1234..... (b7) r5 = 5
       6: .12345.... (7a) *(u64 *)(r11 -8) = 6
       7: .12345.... (85) call pc+1
       8: 0......... (95) exit
       9: .1........ (65) if r1 s> 0x0 goto pc+1
      10: .......... (05) goto pc+1
      11: .......... (85) call bpf_get_prandom_u32#7
      12: .......... (79) r0 = *(u64 *)(r11 +8)
      13: 0......... (95) exit
0: R1=ctx() R10=fp0
; asm volatile ( @ verifier_stack_arg_order.c:99
0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
1: (bf) r1 = r0                       ; R0=scalar(id=1) R1=scalar(id=1)
2: (b7) r2 = 2                        ; R2=2
3: (b7) r3 = 3                        ; R3=3
4: (b7) r4 = 4                        ; R4=4
5: (b7) r5 = 5                        ; R5=5
6: (7a) *(u64 *)(r11 -8) = 6
7: (85) call pc+1
caller:
  R10=fp0
callee:
  frame1: R1=scalar() R2=2 R3=3 R4=4 R5=5 R10=fp0
9: frame1: R1=scalar() R10=fp0
; asm volatile ( @ verifier_stack_arg_order.c:78
9: (65) if r1 s> 0x0 goto pc+1        ; frame1: R1=scalar(smax=0)
10: (05) goto pc+1
12: (79) r0 = *(u64 *)(r11 +8)        ; frame1: R0=6
13: (95) exit
returning from callee:
  frame1: R0=6 R10=fp0
to caller at 8:
  R0=6 R10=fp0

from 13 to 8: R0=6 R10=fp0
; asm volatile ( @ verifier_stack_arg_order.c:99
8: (95) exit

from 9 to 11: frame1: R10=fp0
11: frame1: R10=fp0
; asm volatile ( @ verifier_stack_arg_order.c:78
11: (85) call bpf_get_prandom_u32#7
12: safe
processed 15 insns (limit 1000000) max_states_per_insn 0 total_states 6 peak_states 6 mark_read 0
=============

The insn 12 (r0 = *(u64 *)(r11 +8)) is considered safe
and the verification succeeded.

But this is not correct. The verification should fail due to insn 11.

If we add the following in states.c:

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 45d86bfe3b68..877338136009 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -941,6 +941,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
         if (old->callback_depth > cur->callback_depth)
                 return false;
  
+       if (!old->no_stack_arg_load && cur->no_stack_arg_load)
+               return false;
+
         for (i = 0; i < MAX_BPF_REG; i++)
                 if (((1 << i) & live_regs) &&
                     !regsafe(env, &old->regs[i], &cur->regs[i],


The verification will fail:

0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
1: (bf) r1 = r0                       ; R0=scalar(id=1) R1=scalar(id=1)
2: (b7) r2 = 2                        ; R2=2
3: (b7) r3 = 3                        ; R3=3
4: (b7) r4 = 4                        ; R4=4
5: (b7) r5 = 5                        ; R5=5
6: (7a) *(u64 *)(r11 -8) = 6
7: (85) call pc+1
caller:
  R10=fp0
callee:
  frame1: R1=scalar() R2=2 R3=3 R4=4 R5=5 R10=fp0
9: frame1: R1=scalar() R10=fp0
; asm volatile ( @ verifier_stack_arg_order.c:78
9: (65) if r1 s> 0x0 goto pc+1        ; frame1: R1=scalar(smax=0)
10: (05) goto pc+1
12: (79) r0 = *(u64 *)(r11 +8)        ; frame1: R0=6
13: (95) exit
returning from callee:
  frame1: R0=6 R10=fp0
to caller at 8:
  R0=6 R10=fp0

from 13 to 8: R0=6 R10=fp0
; asm volatile ( @ verifier_stack_arg_order.c:99
8: (95) exit

from 9 to 11: frame1: R10=fp0
11: frame1: R10=fp0
; asm volatile ( @ verifier_stack_arg_order.c:78
11: (85) call bpf_get_prandom_u32#7   ; frame1:
12: (79) r0 = *(u64 *)(r11 +8)
r11 load must be before any r11 store or call insn
processed 15 insns (limit 1000000) max_states_per_insn 1 total_states 7 peak_states 7 mark_read 0

Without the above states.c change, insn 12 does not have
chance to check load vs. store or call insn, and hence
considering state is equivalent.

With the above states.c change, old no_stack_arg_load is false and
cur no_stack_arg_load is true, func_states_equal returns false to
allow further for cur verification, which enters insn 12 which will
fail the verification.

What do you think about the above states.c change?

