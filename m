Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341D338239B
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 01:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411490; cv=none; b=kbLKiw84mi/nZ3NntVLMiBNWO1eAmzM0VhsU14zBrYQTQhJUHGEmi7M3P8Pwx2vyugMC6We/Wsmo6XouXgNShn85mYzyjHj47stt0o914WhrD3Fv91SYi40q+43BRPaCqldWzsHUZc/TqXuLPq+GQ9P+3RbMLxjg6XtvII7yiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411490; c=relaxed/simple;
	bh=91SMTxsj05zylZ3T4CngCuiKAcpwAQoI55JLaujrg6s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ahblQqIFQgmdR3Jf4ud9Ng97kzjP78ZrMdEXg54gkyVKE/RGH61owss524U3lcAQSFjTnNpgmxcrRTg9ezNcK2N61V7nrHVlP43LG2JUsCtvnxaPMyq3BHpeNPua06N18f8F4FZGucgs/+ZOa2zeK5yYtMZ84vZjzf27m/ML/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtB06YhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtB06YhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520C21F00A3A;
	Tue, 11 Aug 2026 01:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411488;
	bh=5VnkOaqGX4fJymDYIzqTAZYmUxrFx0PzCgZcayNkyHk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XtB06YhV5OzgyAGgBThTJ8f82mrDAlo/lwZTWKldGE4P6/XX6P2MXAMTmvQG2opQc
	 2NBaM3bspSA+D0reYr3Eg1MaDZYDd0jGg1ee3oDsWVxEO+Ie7eynDV4auRcrZyGG+O
	 3eIZJwoXkKAOFyP9Y8GjeQQ1DT5+g5f7lVOdVhpX+Wr6jUGkgPzwwQcKeom0pHlIgD
	 eZDsVV5bUJUklXDorDLexEpHwnA4ktorpruJTkmGAucyxwuq+XKe1amDmZnN0pYEGD
	 EZX7OgiAjIaYj5xJsuOtaLazh1pLsBUbQcETLg41QlvLRRybvMu4YwyxK2soodtwyI
	 L040JoL3t+vvw==
Content-Type: multipart/mixed; boundary="===============1654576204027975341=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f7b8141d61d6b7089679d057252d90cc7e05f22d1bf000ae2bf16259a45cf845@mail.kernel.org>
In-Reply-To: <20260811000947.2381981-1-yonghong.song@linux.dev>
References: <20260811000947.2381981-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 07/13] bpf: Add verifier support for 16-byte returns in R0:R2
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 01:24:48 +0000 (UTC)

--===============1654576204027975341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add verifier support for 16-byte returns in R0:R2
>
> LLVM 23 added support for returning a value in two registers for an
> __int128, or a struct/union whose size is greater than 8 but not more than
> 16 bytes. See LLVM patches [1] and [2].
>
> Before LLVM 23 the BPF backend could not return these values at all. A
> by-value struct or union return (of any size) was rejected at compile time
> with:
>
>   error: aggregate returns are not supported
>
> and an __int128 return failed later in the backend with:
>
>   fatal error: error in backend: unable to allocate function return #1
>
> Both are resolved in LLVM 23, which lowers such returns into the R0:R2
> register pair.
>
> This patch adds handling for returns greater than 8 bytes in several
> places: BPF subprogram returns (the main program, and both global and
> static subprograms) and kfunc returns.
>
> The R0:R2 convention is only implemented in the JIT. The BPF interpreter
> has no notion of a second return register: a BPF-to-BPF call goes through
> JMP_CALL_ARGS and a BPF_EXIT hands back BPF_R0 alone, so a caller reading
> R2 would see a stale value. Force the JIT wherever a caller can observe the
> pair, that is at the call to a global subprogram in check_func_call() and
> at the return from a static subprogram in prepare_func_exit(). Kfunc calls
> need no separate handling since bpf_add_kfunc_call() already sets
> jit_required for every kfunc call.
>
> A by-value struct or union returned by a kfunc must be composed only of
> scalars, since the verifier models the returned register bits as an unknown
> scalar and a pointer field would otherwise be laundered into one, escaping
> provenance and reference tracking.
>
> A global subprogram must return a scalar in every return register. The
> existing exemption for arena pointers now applies only when the return
> value fits in R0 alone: both halves of a register pair carry a piece of a
> >8 byte scalar, so an arena pointer in either of them is a leak rather than
> a legitimate return value. A subprogram whose whole return value is an
> arena pointer is unaffected.
>
> A static subprogram is handled differently. The verifier walks into its
> frame, so prepare_func_exit() propagates the return register(s) to the
> caller. R0 holding a stack pointer has long been rejected outright there,
> but R2 is deliberately not treated the same way. LLVM owns both sides of a
> static call and is not bound by the ABI, so even with a 9..16 byte declared
> return type it may leave R2 untouched when the caller only consumes the low
> half; R2 can then hold an incidental stack pointer that is not a return
> value at all, and rejecting the program would be a false positive.
> Propagating the register as is would be worse: the callee frame is freed
> immediately afterwards, leaving the caller with a PTR_TO_STACK that refers
> to a frame which no longer exists. So the caller's R2 is marked
> uninitialized instead, and only a caller that actually reads the returned
> upper half fails. As with R0, a pointer into the caller's own frame is
> scrubbed too, which is conservative but keeps the two registers consistent.
>
> Once callers read R0:R2, an extension program can no longer replace a
> function with a >8 byte return value: an extension's own return is
> capped at 8 bytes by the program-exit check above, so it would leave R2
> stale for the target's callers. btf_check_type_match() cannot catch
> this, as it compares return types by btf_type->info only and an int
> carries no vlen, so a 16-byte __int128 and an 8-byte long compare equal.
> Reject such an attach in bpf_check_attach_target() instead.
>
>   [1] https://github.com/llvm/llvm-project/pull/190894
>   [2] https://github.com/llvm/llvm-project/pull/206876
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

The main program is listed among the places that gain handling for a >8
byte return:

>   This patch adds handling for returns greater than 8 bytes in several
>   places: BPF subprogram returns (the main program, and both global and
>   static subprograms) and kfunc returns.

For the main program the patch does the opposite, though.
process_bpf_exit_full() gains an outright rejection:

	if (!cur_frame->subprogno && bpf_ret_reg_pair(env, 0)) {
		verbose(env,
			"return value larger than 8 bytes is not supported at program exit\n");
		return -EINVAL;
	}

That rejection and its error message are not described anywhere in the
changelog.  The only trace of it is the later backward reference:

>   an extension's own return is
>   capped at 8 bytes by the program-exit check above

which points at a check the changelog never introduced, and the extension
reject added in bpf_check_attach_target() rests entirely on that cap.

Could the changelog say directly that a >8 byte return from the main
program is rejected at BPF_EXIT, rather than listing the main program as a
place where such returns are now handled?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762
--===============1654576204027975341==--
