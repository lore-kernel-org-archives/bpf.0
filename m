Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795290899;
	b=AEU9bAmk1SgTpDGvT3tNofuDdNoW5y1616sH/wZ07SQtpOQSVZv1Bz8f27WMEPJPGK0E
	 LHw82/n8ulnMPlhkz3ZUfXPQs2xcww7ghVpQuPcG/+ev/Vr11wGYiS1rd1Zl7KF8aQrfW
	 qEGU/X93whKtQCZWOeaAphuadUDW20wiLTcxuNhw4wEJtNNFiUFuPPCi+BUv0pZeIzSsA
	 BxnuGG3gF7gmHmiaDKvA5iblGE5TCA2OAWmf6gck8Lw0BfSCqo+VfmEQtEvz/KeeVPXam
	 Eik0JCRLXe4dr0sfAzgXAGdU8CLd1HOavCwDa0P5vGERd4NtcGJGl31+DlnTqi+LYJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795290899;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=/2rdAKb9Kl7Jr6OLYQTBTPMhOp6YXx72ma/e2e5OXCo=;
	b=A77qUEbeO9jmF/qJ3hCBXXbdh5zGCpzT/OBGzYm4XyWgkiOo/7ri6yG1ZT8Antz8sq09
	 QtEPsoi7ji9WKPiaqA1y+OW5zBDtX/4ljgRhgE05sazqYGUXyV1rtMykdzJO/3Sn67LLU
	 /SJhaAsJ9fL9IqtzRiWskuF480f77sL+PYan6bNyZ0TMVxNhHazNHo0DPPwlpaZcscxPu
	 7AScEesvXkJXWCeMgugihBthaqsdZFeQpuePB8fhsH3f6QyJbdo/y4K/bNgD7AxlPtSyU
	 RgO7npf8lxIi+Wu1XjEJde5oe71/gFWjGQMUKPE+pHACED0QNvsFmdKTcinycPi6k4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bJF/iIgK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0165606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJF/iIgK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E27F1F000C4;
	Sat, 21 Nov 2026 19:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795290898;
	bh=/2rdAKb9Kl7Jr6OLYQTBTPMhOp6YXx72ma/e2e5OXCo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bJF/iIgKMQFMy/kIhC9XrgvNAbpn6Y8bxDq0l3GA3i6RqnzvpCRozs65RB7eV7iem
	 HqXK2tHHOixhyIbGrZAAme91Zry2hYZqc1iwIjvV+667X1psrAGBep6IdwAT5BToWN
	 P43I/diPip0oIxhrsogYTpTelBPkTX7U3380DulUY/qCkkCATTyvEV1NFsll78SasZ
	 /VuvGPriNjoSVymORsRTqCBwADCsyjxkI1Mcm4PTDgaQrBjP5AuS23gRAfMSgIduqA
	 tJSAtX3o4l4j7bVrjt/cXDzKfE8CZ9fBY4hMlYEeZ3/rp8Gtw/Fopeifdk0xy7ynUk
	 R501v2A78TIkQ==
Content-Type: multipart/mixed; boundary="===============5984070508011541048=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <cf9e3d62ec7cd040f0bf0e847e77161e98726866dcca97c216eec346e18372c8@mail.kernel.org>
In-Reply-To: <20261121191343.3670609-6-alexei.starovoitov@gmail.com>
References: <20261121191343.3670609-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 5/7] bpf: Drop a path of a path-sensitive run that is out of frames
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 21 Nov 2026 19:54:57 +0000 (UTC)

--===============5984070508011541048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Drop a path of a path-sensitive run that is out of frames

TL;DR: The new err == -E2BIG check in do_check() may drop failing paths for
other -E2BIG errors, not just out-of-frames. Verdict is unchanged, but the
verifier may run more passes and log less.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -21970,10 +21970,13 @@ static int do_check(struct bpf_verifier_env *env)
>  		err = do_check_block(env, prev_insn_idx);
>  		if (env->bug)
>  			return -EFAULT;
> -		/* a pass had no error at this insn, possibly with a state that has more values */
> +		/*
> +		 * A pass had no error at this insn, possibly with a state that has more values.
> +		 * -E2BIG: a pass possibly does not have these calls in frames.
> +		 */
>  		if (err && env->path_sensitive && is_error_of_state(env, err) &&
>  		    (env->cur_state->infeasible || env->cur_state->equations.infeasible ||
> -		     !bpf_failing_path_may_end_at(env, env->insn_idx))) {
> +		     err == -E2BIG || !bpf_failing_path_may_end_at(env, env->insn_idx))) {
                      ^^^^^^^^^^^^^^

Does this test drop more paths than the out-of-frames case that the comment
and commit message describe?

do_check_block() returns -E2BIG for other errors that do not depend on
frames:

- bpf_renumber_ids() logs "too many ids" and returns -E2BIG.  It is reached
  through bpf_flow_deliver() -> bpf_clean_verifier_state() at the start of
  every basic block, and from do_check_insn() before check_func_call() and
  check_func_callx().

- btf_struct_walk() returns -E2BIG when push_array() goes past
  MAX_ARRAYS_WALK, and btf_struct_access() and check_ptr_to_btf_access()
  pass it on.

-E2BIG is not in error_is_recoverable(), so when a pass hits one of these
errors, note_error() stops the pass and bpf_note_unproven_insn() sets the
insn in err_insns.  A path of the run with the same state reaches the same
insn and fails the same way, for example in a main program that holds more
references than BPF_ID_MAP_SIZE.  Before this patch that path was the
failing path.  Now it is thrown away, so find_failing_path() returns 0 for
an error that is real.

In do_check_all() this means:

- path_err stays 0, so the max_cost = min(env->max_cost, env->cost +
  2 * bpf_precision_first_budget(env)) cut is skipped, and the verifier
  keeps partitioning and runs more passes before it rejects.

- log_failing_path() is not used, so the log has only the basic block from
  the for_log pass, not the full path.

- with !path_err, the message "the limit on cost or memory ended pass %u"
  can be printed when limit is set.

The verdict does not change.  The commit message accepts the lost log only
for programs that run out of frames in every pass, but these other errors
get the same loss without any mention.

Could the check be limited to the out-of-frames case, for example with a
flag set by setup_func_entry(), or a check that the failing insn is a call
at curframe + 1 >= MAX_CALL_FRAMES?

>  			bpf_free_verifier_state(env, env->cur_state, false);
>  			memset(env->cur_state, 0, sizeof(*env->cur_state));
>  			free_pushed_states(env);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44940968656
--===============5984070508011541048==--
