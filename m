Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7C2D2488
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 04:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790483743; cv=none; b=M5JhYlWiQxntoDLCarf9/9Vq5Ew08sirsB02BXpY8gWCg1tb8ZFInIx6CT5wcLW4cwtKxjcgfmUoanTbibb3F5w9+hw1u7P9S6LlqIM834fzrZ6Gx72HWpal3AtCtXo+6V3E7GdhTps9g8RNd3Ptfdf+lompGUb9Mx7RbHaB3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790483743; c=relaxed/simple;
	bh=gMW+LqaZBOobL0nwVugxqJOL7fLnyUSayxIjQJjzuJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDcsKKxVnWabTCR9r3KpbIFvTrl+QKyrT3u51N/NGcJq/foPcyIHuagmwOFwpLS0NaQNjPARkX+jym9v5HmsjkSHlInWmuXbfL4odOcKO3vAl39w5RhsM9RvajPYMffP1OySmKO0Kdgiw5wlrPsK4rx9GFJUBS5zV5F9KSJ8X0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F3W/6cdg; arc=none smtp.client-ip=95.215.58.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F3W/6cdg"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gMW+LqaZBOobL0nwVugxqJOL7fLnyUSayxIjQJjzuJk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790483738; v=1; x=1791088538;
 b=F3W/6cdgIiKlatOVOIg/7Dzclp6AwJJsk/pNApNrPO7UVRxc5R06rUBPmcOH4KlwVVglsAT7
 OBTzVv069g2roWkENZKHVkOmBY8FWg4+roxY9H3iPi2HpYbnBDxHYeRIFCiaTsUfm4RlKGb20S8
 jxEs1IZlQOaTihWYbX9HOgcM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 375785e4799922db;
	Sun, 27 Sep 2026 04:35:34 +0000
X-Mizu-Trace-ID: 375785e4799922db
X-Migadu-Flow: FLOW_OUT
Message-ID: <c30b6d55-1ef1-4b9a-a434-99b7f3834bb4@linux.dev>
Date: Sat, 26 Sep 2026 21:35:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 11/21] bpf, x86: Dispatch exception cleanup
 pads at run time
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050102.2218021-1-yonghong.song@linux.dev>
 <20260926051542.4DF841F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260926051542.4DF841F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/25/26 10:15 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf, x86: missing JIT epilogue for exit-less subprograms crashes exception unwinder
> --
>
> commit 9bb870f715bdf91026578628a6afaf5325f80183
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf, x86: Dispatch exception cleanup pads at run time
>
> This commit updates the x86 BPF JIT to dispatch exception cleanup pads at run
> time, setting up native cleanup tables and populating the epilogue IP to allow
> redirecting a frame to its landing pad during an ORC stack walk.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 6c7a0578760e7..fb7e8ca1aab21 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -3278,6 +3279,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   			seen_exit = true;
>>   			/* Update cleanup_addr */
>>   			ctx->cleanup_addr = proglen;
>> +			/* Where an unwind sends a frame with no pad. */
>> +			bpf_prog->aux->epilogue_ip = (u64)image + proglen;
> [Severity: High]
> What happens if a BPF subprogram only terminates via a noreturn kfunc like
> bpf_throw(), meaning it lacks a BPF_EXIT instruction entirely?

bpf_throw() will be rejected if landing_pad is available.

>
> Since the x86 JIT generates the epilogue lazily when the first BPF_EXIT is
> encountered, wouldn't do_jit() produce no epilogue at all for such a program,
> leaving epilogue_ip as 0?
>
> If an exception unwinds through this subprogram's frame, the unwinder relies
> on epilogue_ip to rewrite the return address. Wouldn't it hit this error path
> and abort the unwind?
>
> kernel/bpf/helpers.c:bpf_unwind_rewrite() {
>      ...
>      } else if (prog->aux->epilogue_ip) {
>          *ra = prog->aux->epilogue_ip;
>      } else {
>          WARN_ON_ONCE(1);
>          return false;
>      }
> }
>
> Could this lead to corrupted exception handling that can be triggered by
> user-supplied BPF programs?

Yes, it is possible that epilogue_ip is 0 if that subprog is always
in the path when unwinding happens. The fix will be keep 'exit' insn's
so they won'be removed. See bpf_jit_comp.c

                 case BPF_JMP | BPF_EXIT:
                         if (seen_exit) {
                                 jmp_offset = ctx->cleanup_addr - addrs[i];
                                 goto emit_jmp;
                         }
                         seen_exit = true;
                         /* Update cleanup_addr */
                         ctx->cleanup_addr = proglen;
                         /* Where an unwind sends a frame with no pad. */
                         bpf_prog->aux->epilogue_ip = (u64)image + proglen;
			...

>
>>   			if (bpf_prog_was_classic(bpf_prog) &&
>>   			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
>>   				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
> [ ... ]
>

