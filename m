Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BE3A4F46
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651086; cv=none; b=QtNJLbfeidI9QVwquzSqRpVee93rcEOgUw6A/SqDQe/mj3uRg8D3etxL5ZMrFuDQ6fMnXsSK/Xy/qAI6G+x61Kb63t7KES/4WbwyUIvcOw4jBDg5Qw7BHeExbEYBS1dfQslLn/khrTK7oTWlNp7hFW3Ibhqn+mWdjobpgUWnCjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651086; c=relaxed/simple;
	bh=835iUBdR9f/peBeI6XZhnFCHLnJHPVt8yznQmQVumf0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bbOjwfVR47v66R5TnapOaIT9bEXF+i1ShOOwVlw6fVn+q0R6GoAZE8mQcx9mIduq/eNq6bAqcloZ29BZ9e6lLVunfwK/FlSrVzug78cWUbiFohSCcBah3YZTVfumht1R2GXVt428JKMIhEn57WG34YWcOp6FLDBoSHz/Vf8MmDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mss6hpC2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mss6hpC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFBFC2BCC6;
	Wed, 13 May 2026 05:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778651086;
	bh=835iUBdR9f/peBeI6XZhnFCHLnJHPVt8yznQmQVumf0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Mss6hpC2S4dETyxzX/6PLKiMKClm9W58tDfROkmXDXomN5YwjU0Jrz2J4PKbfbGUG
	 zUAKYEqMuBQAs8XbcoLgOJpSsY31P6a+OnH1GN6SPk0BTaHZjz6NhbaEHc41H/7Ke4
	 b7bjk/22f0OIzgtGOFfCBHBPUdujtPf8R/llib8jhIGwx22ezhM8ut5T2LlYK/9Rwm
	 /eCUHVb3vuhlUbM23dGHHXrABnjzmK4vs8ufO1OAVJSGLpT0AAQsSJDUHt1NV9cO58
	 21ERYICF7zJE+SE6V/J9ZOgGkLwrL+BuryRgPLxrpXU5bseD/fAnuthapcxUq8NmvT
	 50rDIvY0I4fSQ==
Content-Type: multipart/mixed; boundary="===============2062401704617578845=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <764db4d58e994d64adaecf0b31465b7e9d9672c5ba5216d737baf50fa91ada19@mail.kernel.org>
In-Reply-To: <20260513045043.2389049-1-yonghong.song@linux.dev>
References: <20260513045043.2389049-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 10/25] bpf: Extend liveness analysis to track stack argument slots
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 13 May 2026 05:44:46 +0000 (UTC)

--===============2062401704617578845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Extend liveness analysis to track stack argument slots
>
>     BPF_REG_PARAMS (R11) is at index MAX_BPF_REG, which is beyond the
>     register tracking arrays in const_fold.c and liveness.c. Handle it
>     explicitly to avoid out-of-bounds accesses.
>
>     Extend the arg tracking dataflow to cover stack arg slots. Otherwise,
>     pointers passed through stack args are invisible to liveness, causing
>     the pointed-to stack slots to be incorrectly poisoned.
>
>     Extend the at_out tracking array to MAX_AT_TRACK_REGS (registers
>     plus stack arg slots) so that outgoing stack arg stores are tracked
>     alongside registers. Add a separate at_stack_arg_entry array in
>     compute_subprog_args(), passed to arg_track_xfer(), to restore
>     FP-derived values on incoming stack arg reads.
>
>     Extend record_call_access() to check stack arg slots for FP-derived
>     pointers at kfunc call sites, reusing the record_arg_access() helper
>     extracted in the previous patch. Pass stack arg state from caller to
>     callee in analyze_subprog() so that callees can track pointers received
>     through stack args, hence avoid poisoning.
>
>     Skip stack arg instructions in record_load_store_access(). Stack arg
>     STX uses dst_reg=BPF_REG_PARAMS (index 11), but at[11] is repurposed
>     to track the value stored in stack arg slot 0. Without the skip, if a
>     prior stack arg STX stored an FP-derived pointer (e.g., fp-64) into
>     slot 0, a subsequent stack arg STX would read that FP-derived value as
>     the base pointer and spuriously mark a regular stack slot (e.g., fp-72
>     from -64 + -8) as accessed in the liveness bitmap.
>
>     Extend arg_track_log() to log state transitions for outgoing stack arg
>     slots at indices MAX_BPF_REG through MAX_AT_TRACK_REGS-1. Without this,
>     changes to at_out[11..17] caused by stack arg store instructions are
>     silently omitted from BPF_LOG_LEVEL2 output. For example, when a
>     caller passes fp-64 through a stack argument:
>
>       subprog#0:
>        10: (bf) r6 = r10
>        11: (07) r6 += -64
>        12: (7b) *(u64 *)(r11 -8) = r6
>             sa0: none -> fp0-64
>        13: (85) call pc+5
>
>     Without the fix, the "sa0: none -> fp0-64" transition at insn 12
>     would not appear.
>
>     Extend print_subprog_arg_access() to include stack arg slots in the
>     per-instruction FP-derived state dump. For example:
>
>       subprog#0:
>        12: (7b) *(u64 *)(r11 - 8) = r6  // r6=fp0-64
>        13: (85) call pc+5              // r6=fp0-64 sa0=fp0-64
>
>     Without the fix, the "sa0=fp0-64" annotation at insn 13 would not
>     appear, making it harder to debug liveness analysis for programs
>     that pass FP-derived pointers through stack arguments.
>
>     Extend has_fp_args() to also check stack arg slots for FP-derived
>     pointers, so that callees receiving pointers only through stack args
>     are still recursively analyzed.
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for stack argument support. Should this include:

  Fixes: cc06010ca1b8 ("bpf: Support stack arguments for bpf functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25779371388
--===============2062401704617578845==--
