Received: from mta1.migadu.com (out-133.mta1.migadu.com [95.215.58.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B5521E097
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846675; cv=none; b=i7fL3ETC+fXva9IvYJr07+gYTgfUDTt/epVDNRWLJFSLIwO0WJOYUBQ8dUvt5eP8NgyH1mzr9Emj69Mf9XtbnFI18uli+2Eg9WAd6kmjQwdHxKOvl4WcuF4FeaJUUDDkfw2lhyaKiVOy8sNp6LZdsfUw7y243J8g+S9q+wQtWPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846675; c=relaxed/simple;
	bh=Qf159ozv3ptJ94sPAF3+71RPqkNsFz3N0iav+2Zt8eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeOEo5gNItrpGmz3ldcXSp+ZSqOC0zy8oNAenobBF2uD+UxhI3jGYGVC6ExniCprowFR8Cc1nxLzYoleD8lqlPE7QJUrijaEexGegx0W9aQwvBC5v4wM0By83yQwNOoau5bf9ioMj+dPRkqjY3M7Ewf2Ma3TEodM8u4f6IagBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HG3H+6oc; arc=none smtp.client-ip=95.215.58.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HG3H+6oc"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Qf159ozv3ptJ94sPAF3+71RPqkNsFz3N0iav+2Zt8eU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789846669; v=1; x=1790451469;
 b=HG3H+6ocmHPWCoujpfLIYJx4jombZcZhBeU5oQcm9Zoguds52x7Q+KHTG9NN0UesIS5FujCx
 Rhp9lmP0scezvK3kClUBI+Q8nTRxVNTqCQFwDKmC21UxOhde5FE7NdwIcI86OkexTUFKEHRf8yT
 MDJosgU+Mh+Q4ZR6NpcYpl2E=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6149f87e05e14491;
	Sat, 19 Sep 2026 19:37:49 +0000
X-Mizu-Trace-ID: 6149f87e05e14491
X-Migadu-Flow: FLOW_OUT
Message-ID: <c4c47944-578d-4694-8933-c8fbb09e76e9@linux.dev>
Date: Sat, 19 Sep 2026 12:37:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 09/20] bpf: Refuse a private stack for a
 program with an exception cleanup table
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260918044243.3288865-1-yonghong.song@linux.dev>
 <6d68bdd97e85a2c8b74ab62769fd7846a3f9c83f825697eb9fd35a6723842a73@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6d68bdd97e85a2c8b74ab62769fd7846a3f9c83f825697eb9fd35a6723842a73@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/26 10:44 PM, bot+bpf-ci@kernel.org wrote:
>> A landing pad is about to start running outside its own frame, on the
>> bpf_throw() walker's stack, with that frame's registers put back from a
>> spill area whose contents arch_bpf_run_cleanup_pad() knows how to read. The
>> x86-64 JIT addresses a private-stack program's frame through a scratch
>> register that it recomputes after each call rather than through rbp, and no
>> spill area holds that register, so a pad there would address its frame
>> through whatever the kernel left behind.
> The description says the x86-64 JIT 'recomputes after each call'. Does the
> JIT actually recompute it?
>
> Looking at the x86 JIT, emit_priv_frame_ptr() (arch/x86/net/bpf_jit_comp.c)
> is emitted once in the prologue, and the value in X86_REG_R9 is carried
> across calls by push_r9()/pop_r9() around each call site; BPF_REG_FP
> accesses are rewritten to X86_REG_R9.
>
> The load-bearing half of the argument is still correct -
> arch_bpf_run_cleanup_pad() (added later in the series,
> arch/x86/net/bpf_cleanup_pad.S) restores only r15/r14/r13/rbx/r12 and rbp
> from the spill area and never restores r9, so a pad in a private-stack
> program would address its frame through a stale register.
>
> Only the described mechanism (recompute vs save/restore around calls) is
> wrong, which makes the justification harder to check against the JIT.
>
>> Everywhere rather than arch-conditionally: arm64 keeps its private
>> stack pointer in x27, which is in the prologue spill and so survives, but a
>> rule that holds on one arch and not the other is not worth the second code
>> path when nothing is lost but an optimization.
> Does 'nothing is lost but an optimization' understate the effect?
>
> The private-stack mode also changes the verifier's stack-depth accounting,
> not just JIT codegen. In check_max_stack_depth_subprog() a
> PRIV_STACK_ADAPTIVE subprog is checked against MAX_BPF_STACK on its own ('if
> (subprog_depth > MAX_BPF_STACK)'), while a NO_PRIV_STACK subprog accumulates
> into 'depth' and the whole bpf2bpf chain must fit in MAX_BPF_STACK
> ('combined stack size of %d calls is %d. Too large').
>
> So for the prog types bpf_enable_priv_stack() would have returned
> PRIV_STACK_ADAPTIVE for (kprobe/tracepoint/perf_event/raw_tp, and
> tracing/lsm/struct_ops with a recursion or an explicit request), a program
> carrying a cleanup table whose nested subprog depths sum above 512 bytes now
> fails to load rather than losing performance.
>
> Worth stating in the changelog, since it is a load-time visible restriction
> on the new feature rather than an optimization.

Okay, comments and commit message may have some stale things or something
like (when nothing is lost but an optimization) is not correct. Will fix.

>
> Related: kernel/sched/ext/ext.c sets prog->aux->priv_stack_requested for
> sched_ext dispatch/sub_caps_updated, and verifier.c rejects such a request
> when the JIT cannot honour it; here the request is silently ignored instead.
>
> This looks like a bug fix for private stack support. Should this include:
>
>    Fixes: a76ab5731e32d ("bpf: Find eligible subprogs for private stack support")

Fixes tag is unnecessary.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711

