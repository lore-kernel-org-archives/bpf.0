Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3BE39CD11
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184458; cv=none; b=eDPRQlpaIT/vT3AFT5f0/vgP6V0Nvc4JiVt4yhiXXct28qbYj5iB4ZZTyCY/iqIU3wtADN6Xp3tCeCg/xTnMwcGePhk/sBmJm/2TMpkPlH7Xuowq6lcULrSP6y+Yyyp5CU3uydu8PEi7iU2voJHJz6q4gl9QJiXKBdOBl6mkJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184458; c=relaxed/simple;
	bh=WtbGRPSv9mFKyEE9cxd16Qv712ENXYOVsE1O+iezUhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nf4iTW5IT+zy7yW7yHmRIY2fLzTRz2Po626JsSD3Nlu6Lf3NLH+OcjPYQG5Wl1z+pfaKUfnFizERjOe4BIM5uk1e03wFRxlB7bOXGRb5EQXe+LLUg5E2RWWJ61bHYW6xkiOMUqkyh60exon9VWuSY6Lpy+fJ74/ijBzGgqb3u5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f/OCpzd8; arc=none smtp.client-ip=95.215.58.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f/OCpzd8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WtbGRPSv9mFKyEE9cxd16Qv712ENXYOVsE1O+iezUhI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790184452; v=1; x=1790789252;
 b=f/OCpzd85S0VCVL2eeUmeVqkzcD0+dwrsj+6f+FN0bP8dNdBt7N33mx4aZcSInOEWPpee3n/
 mgkZv7PShUiU8Kdt2ByeQ7SErAfjCisY0RJLqN00rqE32/Z5RhlgLisAyKsFnEdsPgHgDmfStpG
 FhKF0ojPjZnMqxNZJkC2tgSE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ebedf2e4f8614006;
	Wed, 23 Sep 2026 17:27:32 +0000
X-Mizu-Trace-ID: ebedf2e4f8614006
X-Migadu-Flow: FLOW_OUT
Message-ID: <3469ede8-6c37-49c9-b261-d2c8506eada5@linux.dev>
Date: Wed, 23 Sep 2026 10:27:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 07/21] bpf: Explore the landing pads no call
 site reaches
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923045922.2417689-1-yonghong.song@linux.dev>
 <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/26 9:26 AM, Eduard Zingerman wrote:
> On Tue, 2026-09-22 at 21:59 -0700, Yonghong Song wrote:
>> A cleanup record need not cover a call an exception can unwind out of: a
>> frontend is free to emit a region around a helper or an ordinary kfunc,
>> both nounwind here. Nothing marks a call site then, and that record's
>> landing pad is reached by nothing at all -- leaving bpf_check_cfg() to
>> refuse the program over code its own frontend had no way not to emit:
>>
>>     0: call bpf_preempt_disable
>>     1: call bpf_preempt_enable      record = { begin = 1, end = 2, pad = 4 }
>>     2: r0 = 0
>>     3: exit
>>     4: r1 = pads_ran ll             landing pad
>>     6: r2 = *(u64 *)(r1 + 0)
>>     7: r2 |= RAN_NOUNWIND_REC
>>     8: *(u64 *)(r1 + 0) = r2
>>     9: call bpf_unwind_resume
>>    10: exit
>>
>> The range [1,2) holds one call, and it is a kfunc, so an exception cannot
>> come out of it. mark_call_sites() marks nothing, nothing pushes an edge to
>> 4, and 4 through 10 are reachable from nothing: "unreachable insn 4". The
>> pad is dead, which is correct -- no exception can ever arrive at it -- but
>> the program is fine and has to load.
>>
>> Walk every pad the table names that the edges did not reach, the way the
>> walk is already re-seeded at an exception callback. From there the pad is
>> code like any other: do_check() never enters it, because no call site
>> dispatches to it, so the dead code sweep removes it along with everything
>> else that was not reached.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Yonghong, in v4 you said that rustc does not generate dead landing pads.
> Why do we need this patch?

This patch is to avoid a verification failure. Let us say, we remove this
patch and run the following
   ./test_progs -t exceptions_cleanup
and we will get the following failure:

test_exceptions_cleanup:PASS:open 0 nsec
test_light_skeleton:PASS:light open_and_load 0 nsec
test_light_skeleton:PASS:run 0 nsec
test_light_skeleton:PASS:retval 0 nsec
test_light_skeleton:PASS:pads_ran 0 nsec
libbpf: prog 'entry_nounwind_rec': BPF program load failed: -EINVAL
libbpf: prog 'entry_nounwind_rec': -- BEGIN PROG LOAD LOG --
unreachable insn 6

Verification failed: Program Structure: Unreachable instruction

Reason:
   Instruction 6 is not reachable from the program entry point.

At:
   nounwind_rec_frame @ exceptions_cleanup_shapes.c:663:2
   Source context:
       661 | ...
       662 | ...
   >>> 663 |         asm volatile (
           |         ^-- error: unreachable instruction
       664 | ...
       665 | ...
   Instruction context:
        4 | (b7) r0 = 0
        5 | (95) exit
   >>>  6 | (18) r1 = 0xffa0000001d94010
        8 | (79) r2 = *(u64 *)(r1 +0)

Suggestion:
   Remove the unreachable instruction or add valid control flow that reaches it.

processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'entry_nounwind_rec': failed to load: -EINVAL
libbpf: failed to load object 'exceptions_cleanup_shapes'
libbpf: failed to load BPF skeleton 'exceptions_cleanup_shapes': -EINVAL
test_shapes:FAIL:shapes open_and_load unexpected error: -22
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
#128/4   exceptions_cleanup/light_skeleton:FAIL
#128     exceptions_cleanup:FAIL

This happens in cfg.c:

         for (i = 0; i < insn_cnt; i++) {
                 struct bpf_insn *insn = &env->prog->insnsi[i];
                         
                 if (insn_state[i] != EXPLORED) {
                         verbose(env, "unreachable insn %d\n", i);
                         bpf_diag_program_structure(
                                 env, i, "unreachable instruction",
                                 "Remove the unreachable instruction or add valid control flow that reaches it.",
                                 "Instruction %d is not reachable from the program entry point.", i);
                         ret = -EINVAL;
                         goto err_free;
                 }
                 if (bpf_is_ldimm64(insn)) {
                         if (insn_state[i + 1] != 0) {
                                 verbose(env, "jump into the middle of ldimm64 insn %d\n", i);
                                 bpf_diag_program_structure(
                                         env, i, "jump into ldimm64 immediate",
                                         "Target the first instruction of the ldimm64 pair, or restructure the jump target.",
                                         "Control flow reaches the second half of the ldimm64 instruction pair that starts at instruction %d.",
                                         i);
                                 ret = -EINVAL;
                                 goto err_free;
                         }
                         i++; /* skip second half of ldimm64 */
                 }
         }

This patch intends to explore *unreachable* insns to avoid verification failure.

I think due to "record = { begin = 1, end = 2, pad = 4 }", it is considered that the code at 'pad = 4'
is not dead, but actually it does dead later so we have the above failure.

So I add this patch to avoid failure. But maybe we should just remove this patch,
and mark this test as failure as indeed landing pad is not reachable.

WDYT?

