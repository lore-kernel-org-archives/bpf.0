Received: from mta1.migadu.com (out-48.mta1.migadu.com [95.215.58.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019230E83F
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791743200; cv=none; b=AFgFA7dEzv56oQEO68hGHTfAc88lVHRD+wUiCmSVjx8gDDLj1SzFYRQX3j3mE+IKgndqMq5rslvGyYi1dvdFaJ1MR/EudKK64xcgyHRu9XDIFXjFAWU5ujc9MZKIsFJ7GvoFOIYO/zgzpoTL+GG4ZM7IgztEkz4gdpY/PQAkptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791743200; c=relaxed/simple;
	bh=c6E4SMOwpUG99xKFEE8QBpGeGUlTurqSr7Zwyuz4EUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsqFX4MSWKHnDreW5AE60Yjk9nvQFi6eCmudT3UtUQ6z4suQhNDnUWXMOmvmh5EJi8TjLnHZiFFLvYAL/xZq3DP8s81GPWiSqhxvJxisbHM1VR7eKY1/rLX5vIXDjw/knWav1l26QAXxABQTYa3yzFBx2h7YO0S9QOyViJosOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eYSx9p9P; arc=none smtp.client-ip=95.215.58.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eYSx9p9P"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=c6E4SMOwpUG99xKFEE8QBpGeGUlTurqSr7Zwyuz4EUk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791743194; v=1; x=1792347994;
 b=eYSx9p9PU8JrP+Rf0fJ+Jazvg3PlmF1gjQPG3MyLqWGfDyYIoP7ZaUyhvUmOQjR1g4AmadyR
 1fs6I8lD1u77MVggv32geL47RHvQ7+ZbmUpns3dkkUmHab/+i5rgvd50v7YbYa/0RZPi5Prnzka
 kssXXjMN4bE3unQ1JkQF1YSg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e83480c855db23dc;
	Sun, 11 Oct 2026 18:26:34 +0000
X-Mizu-Trace-ID: e83480c855db23dc
X-Migadu-Flow: FLOW_OUT
Message-ID: <4e5d4bbe-9d03-470b-8a02-034381a6b53e@linux.dev>
Date: Sun, 11 Oct 2026 11:26:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 09/24] bpf: Refuse a landing pad that does
 not resume
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041534.27944-1-yonghong.song@linux.dev>
 <DM194GWC0XHZ.10Q1AUS5TQYNO@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DM194GWC0XHZ.10Q1AUS5TQYNO@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/26 5:08 PM, Alexei Starovoitov wrote:
> # CARRIED OVER from the unsent v9 draft (leftover of your v8 09 mail). Delete this line, or the file if you dropped it on purpose.
> On Thu, Oct 08, 2026 at 09:15 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> +		if (unlikely(env->cleanup_info_cnt)) {
>> +			err = bpf_exc_check_insn(env, insn);
>> +			if (error_recoverable_with_nospec(err) && state->speculative) {
>> +				insn_aux->nospec = true;
>> +				goto process_bpf_exit;
>> +			}
>> +			if (err)
>> +				return err;
>> +		}

Remove the error_recoverable_with_nospec():

+			if (error_recoverable_with_nospec(err) && state->speculative) {
+				insn_aux->nospec = true;
+				goto process_bpf_exit;
+			}

For selftest:

/* A pad whose speculative walk reaches an exit: a barrier, not a refusal. */
static __used __naked __noinline __u64 spec_exit_pad_frame(void)
{
         asm volatile (
         "r1 = %[input] ll;"
         "r6 = *(u64 *)(r1 + 0);"
         "r6 &= 7;"
"1:"    "call always_unwind;"           /* cleanup region */
"2:"
         "r0 = 0;"
         "exit;"
"3:"                                    /* landing pad */
         "if r6 > 7 goto 4f;"            /* never taken: walked speculatively */
         "call bpf_unwind_resume;"
"4:"
         "exit;"
         CLEANUP_REC("1b", "2b", "3b")
         :
         : __imm_addr(input)
         : __clobber_all);
}

SEC("?syscall")
__success __caps_unpriv(CAP_BPF) __success_unpriv
__xlated_unpriv("nospec")
int entry_spec_exit_pad(void *ctx)
{
         return spec_exit_pad_frame();
}

and get the following failure:

libbpf: prog 'entry_spec_exit_pad': BPF program load failed: -EINVAL
libbpf: prog 'entry_spec_exit_pad': failed to load: -EINVAL
libbpf: failed to load object 'exceptions_cleanup_shapes'
run_subtest:FAIL:unexpected_load_failure unexpected error: -22 (errno 22)
VERIFIER LOG:
=============
arg#0 reference type('UNKNOWN ') size cannot be determined: -22
0: R10=fp0
; return spec_exit_pad_frame(); @ exceptions_cleanup_shapes.c:1091
0: (85) call pc+1
caller:
  R10=fp0
callee:
  frame1: R10=fp0
2: frame1: R10=fp0
; asm volatile ( @ exceptions_cleanup_shapes.c:1067
2: (18) r1 = 0x0                      ; frame1: R1=map_value(map=exceptio.bss,ks=4,vs=40)
4: (79) r6 = *(u64 *)(r1 +0)          ; frame1: R1=map_value(map=exceptio.bss,ks=4,vs=40) R6=scalar()
5: (57) r6 &= 7                       ; frame1: R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=7,var_off=(0x0; 0x7))
6: (85) call pc+5
caller:
  frame1: R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=7,var_off=(0x0; 0x7)) R10=fp0
callee:
  frame2: R1=map_value(map=exceptio.bss,ks=4,vs=40) R10=fp0
12: frame2: R1=map_value(map=exceptio.bss,ks=4,vs=40) R10=fp0
; asm volatile ( @ exceptions_cleanup_shapes.c:390
12: (85) call bpf_unwind#87213        ; frame1: R0=scalar()
; asm volatile ( @ exceptions_cleanup_shapes.c:1067
9: (25) if r6 > 0x7 goto pc+1
exit at insn 11 ends a landing pad: a catch pad is not supported yet, only cleanup pads that resume
processed 9 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
=============
#134/56  exceptions_cleanup/entry_spec_exit_pad @unpriv:FAIL


>> +
>>   		if (bpf_is_prune_point(env, env->insn_idx)) {
> since you're going to respin consider the following feedback:
>
> The special case for speculative paths is still here.
> in_pad is compared in func_states_equal() now, so there is no need
> to check before pruning.
> Call bpf_exc_check_insn() from do_check_insn() ?

Moving bpf_exc_check_insn() to do_check_insn() makes sense.
The above selftest succeeded (w.r.t speculative path).

> error_recoverable_with_nospec() after it does the same thing,
> and the error will be printed after the insn instead of before it.

