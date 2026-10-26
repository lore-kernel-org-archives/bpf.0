Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792981724;
	b=Ps+jJeQmhl7x9/eQpJAw4CkcwdsS6fjuUFpY0hGICxevBCiU9F/wa0STFQOMPQtqPP1D
	 L16H5yJEozm2X+jVi1bw25C2RHoXSBAVIMkAFYf8+pSWOqLoyPDftZIuCkk907SmLbYML
	 Ij/9yOsx8DMiFM4fo4DR0tqNfcA3tnHyPLyuffLCz8qupCp47ZqM5C6iEKX3xk1TDF5dm
	 vMQk6m32HXbYED5EaDIsleSRFZAyCKEvULGGcBgf/Arq26UBtcEPF/5kb0YHH6u6798TB
	 04YKvdYWZ3oqRTilfV3ojA/w9iJsUt0cSAbxdj22O4RyWnomSa/AGfbFB9sZ5ol4Jcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792981724;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=xSqbF++GIOusajRju8i0O/lyZHXvPt4g7pSYlheLAJc=;
	b=qg+GEkoTUb41EnJYUo36zURxnUUt7IQrY2vuMFgP9BFfaMv4PGDuxPHuoeRXp5KV5Vvk
	 USnj0G5J6ATAIpeZEpe+6ZEQx8pPQEG9gXv5A4R5lQlOlJPUSy1KheyFf1BxP6vN3vxJ9
	 qm7T6zDGOS8reAy23Cji7Owa4JNRWSFnD0Q9bQpScQS9YMJ2vNOVcQU7BR44+aLtXlTO6
	 hatvmZZMvON8gAOfHYhwETtPOhDvgPjTvlDCe64kRaQFZPDGCI+z9PqDOZq9Db9Z1kleI
	 GRynY16MMNTtTEOOM3Nzg0/JNEIMAvUB84gGK47luDL5hi6MbngRIiL/hMp+bPXqf9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fvj8BrY6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E480606A31A;
	Mon, 26 Oct 2026 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fvj8BrY6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7271F01825;
	Mon, 26 Oct 2026 02:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792981724;
	bh=xSqbF++GIOusajRju8i0O/lyZHXvPt4g7pSYlheLAJc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Fvj8BrY6QWX6OjTYDUq92r9jHZMFHGihHPbQt8mBEQhuTkD5os0/9QJjIJdkL6iU6
	 7GleS5R2MzG9NQhjabVwKOpmOjeXNqJ6Me/alSLC6gDA6i/rfRZyYi+6pXCxHBHsB/
	 VYYQm+uZPZpcoPVoH1J/RURlR40V0tp3xOxMTklFmFZ4J58mNQBzdDEydESKc4jTcI
	 FISNnyCnmnTF95Z/hd76HHoSGDbwuL7fBAfzOBZcTo0k8EQenCgnLZpna3OHzZR925
	 /QqcaS+fbbN/HsXrc2aoKJAAL4WrHOXO0sQW0We6eXuXZOlYE5zrZqq+z1qOIMc7aP
	 lLxG77zeVPcMg==
Content-Type: multipart/mixed; boundary="===============2872749516240892361=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b8aa48beaa95c94849ca2ed564ac9bc8b63720f8708525a668d1e9248725339b@mail.kernel.org>
In-Reply-To: <20261026015250.1674676-2-bestswngs@gmail.com>
References: <20261026015250.1674676-2-bestswngs@gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test missing and callback stack arguments
From: bot+bpf-ci@kernel.org
To: bestswngs@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,co+eada64ce90ecebce@bugs.sh,xmei5@asu.edu,bestswngs@gmail.com,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 02:28:43 +0000 (UTC)

--===============2872749516240892361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test missing and callback stack arguments

TL;DR: Commit message only: the stated reason for the r11 stores before helper
calls in the callback selftests looks inaccurate; the tests themselves look
correct. Asks for the real reason.

>     selftests/bpf: Test missing and callback stack arguments
>
>     Exercise the path where a static seven-argument subprogram has unreliable
>     BTF and is called through a bridge with only one initialized outgoing stack
>     argument. The callee expects two stack arguments, but the unreliable-BTF
>     path skips check_outgoing_stack_args(). Expect the verifier to reject the
>     second r11 load at offset 16.
>
>     Also exercise synchronous and asynchronous callbacks whose BTF prototypes
>     declare a sixth argument. Initialize the outgoing slot at each helper call
>     site so the programs reach the callback-specific rejection. Keep a valid
>     six-argument direct call in each program so bpf_fixup_call_args() records
>     the stack-argument requirement and cannot become an unrelated rejection
>     fallback.
>
>     The fix also rejects the existing uninitialized-stack-argument test before
>     the later unreadable-register check. Update that test's expected diagnostic
>     accordingly.
>
>     Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>     Assisted-by: LLM
>     Signed-off-by: Weiming Shi <bestswngs@gmail.com>

This isn't a bug, but is the stated reason for the r11 stores before the
helper calls accurate?  The commit message says:

    Initialize the outgoing slot at each helper call site so the programs
    reach the callback-specific rejection.

push_callback_call() calls btf_check_subprog_call() ->
btf_check_func_arg_match() before the new "callback subprog cannot have stack
args" check.  callback_6args() is static and its cached arg_slot_cnt is 6, so
btf_check_func_arg_match() first runs:

    for (i = 0; i < min_t(u32, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS); i++)
        if (caller->regs[BPF_REG_1 + i].type == NOT_INIT)
            return -EINVAL;

and returns -EINVAL before check_func_args() -> check_outgoing_stack_args()
gets a chance to return -EFAULT.

In stack_arg_sync_callback(), r5 is never written before "call %[bpf_loop]".
In stack_arg_async_callback(), r3-r5 are cleared by the earlier
bpf_map_lookup_elem() call.

push_callback_call() ignores that -EINVAL (only -EFAULT is fatal) and goes on
to reject on bpf_in_stack_arg_cnt(), with or without the stores.

The stores only change what an unfixed kernel does.  In the sync case they
keep caller->stack_arg_regs non-NULL, so the old check_stack_arg_read() reads
a real slot.  In the async case they change nothing, because the old code
reads frame[curframe - 1] with curframe == 0.

The tests themselves look correct, and the expected messages match the fixed
verifier on every explored path.  Could the changelog give the real reason for
the stores, or are they needed on some path not covered here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40257528533
--===============2872749516240892361==--
