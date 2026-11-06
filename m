Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939075;
	b=1XI4PrhIaSvAgyJ826x837ff5JitdK3fwzIvEAKkEZwwadLTKnFsocg5JggjEB5AO9vv
	 m88jMooWSUr2IuvC71nrV80ZJxkO+2WQCrZpMZHGQjf2o7AjKm3KdeuENsBSmrEREI58X
	 8aD8CXqus1a2ZZgg8Fh2kKIHXerSScU0wVKxBhgHg9Et8b7YU7abVHAU5BPa9um7Qded1
	 gFmaTZI0KMREE7MASrJFUPx1Ro7RVk2CIS5TGh5SZ4ZZYJJfDyjag2684sjgJi694OAkG
	 X6DBAYwGl2fme1gvO2ZvwTXVsmzCvHZhNzx+cd02mGAjAU+3/BJXnCVsZvqXlIO4cbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939075;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=uKZRR1tzNqBRulBr1wvbvMbgC59UGI1ZJUfg8Q3Mp08=;
	b=4CNtOeKYG8cMzFcOKtafa/No9MoqkCBASJSDr6DzQe78a2m6Ho5yV+tdUD6ck3hkYFD3
	 +Zt4BlLB/2oppzg7dSduV9dLxCu5gOWAOyA37QmElUYWb735U+ROqHVDsUxzKmcSjmBNw
	 Ju1Xy3KZlim3WPHkvcIZ5NPMpBNyhHvMN7fmGizbtznk5y3P3vj+Oh1lTkQtBNGFP2kf4
	 Lub+N67l9QwwICsJ0WqlJnvSmFK1Uckd2yh/zbyjdd47vRNBIaFBLfZOEkXwY9OzBx7qK
	 VCYLdgCBSLYWsRB+Rp7vWdnrJtwhzCa7g7qbNRJI3DUp4AwhHYywLNfPCHfjc2NOrKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1AZktwY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22EF606A328
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1AZktwY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF37E1F0089F;
	Fri,  6 Nov 2026 04:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939074;
	bh=uKZRR1tzNqBRulBr1wvbvMbgC59UGI1ZJUfg8Q3Mp08=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=o1AZktwYWQsZ6AkiKzJubbPc9/jMA82NOUKipBl58Jk8AYNVXG4XH6pT7ObGfpXEA
	 0fNgXFziXoMFlPIZ+h564+l1jQgRoPbBj/TS01XTmuJFGs40SLmbJDqb/6C1A9c0pi
	 yPZA50q7QNFUtOzG6NGxcJtmP/dgC1m5Kiu8IRD3RGzsb2dHm7fHPv/oOY8acDf8m9
	 Kfj7mtstJlHRT9HnevdsPkHyDIC2wIKNnU15KInCDE/dYQmyWFmri5fEg0Ok4T79vV
	 d/0iFRppIAgFGcdD7EdB0HY6+ujrfrz4YDIfaaWj+nr3ZffqMCpSfH26SgjhviLoHP
	 gkqeAxbw+9AAQ==
Content-Type: multipart/mixed; boundary="===============3804598984505174341=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2df7313a6f07e86946dd41ed07e69b62077dd6c748d389b959451fd5affbe9fb@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-27-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-27-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 26/45] bpf: Update comments about paths, pruning and explored states
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:24:33 +0000 (UTC)

--===============3804598984505174341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Update comments about paths, pruning and explored states

TL;DR: Nits only, comment-only patch: some comments still describe the
verifier walking all paths (loop_stack_safe() comment, regsafe() check_ids()
example); should they be reworded too?

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

[ ... ]

> @@ -659,29 +658,17 @@ static bool loop_stack_safe(struct bpf_verifier_env *env, struct bpf_func_state
>  
>  /* compare two verifier states
>   *
> - * all states stored in state_list are known to be valid, since
> - * verifier reached 'bpf_exit' instruction through them
> - *
[ ... ]
> + * The state that gets to an insn doesn't have to be looked at when there is
> + * a state at that insn that is more conservative in registers and in the
> + * stack: if the program is fine with the old state it's fine with the current
> + * one.
>   * Example:

This isn't a bug, but this patch is meant to remove comments that describe
a verifier walking all paths, and a few are still left.

The block comment above loop_stack_safe() in the same file still says:

 * The walk of a loop with two entries is meant to get to the end of the
 * loop, like today's walk of all paths.

Since the verifier no longer walks all paths, should this wording be
updated as well?

The check_ids() example in the regsafe() comment also still describes the
case in DFS-path order:

  First verification path is [1-6]: ...
  Next verification path is [1-4, 6].

Under the fixpoint pass, the two states of that example meet at the start
of a basic block instead of being verified one path after the other.  Should
that example be reworded too?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============3804598984505174341==--
