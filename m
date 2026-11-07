Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025198;
	b=Y5hmy7RNB6ieIx0Smg/N7O2Sl0KfBndX3taQh5bJK7oOVB2U0011mkTO5vFIDvU9WiEU
	 FgF1DWlZ03IOSIh58n2YiFDIjlaGhc6jwemDVxftRlofGo2PEk61g4SYUjIz+E65hZwr9
	 uKL6e37qOlXftFPsj99igs6kKphfvX9htfwg5NtoHOPuZuaxCt4vLWz9DBG0+LF4HPTMa
	 GNpFFT2mJQuitg0O5WpKByOjeYvY5j82NwKfEV0fnrYpuNJ2m3LpcrcV3B3y2CDclNJ7y
	 ZjP+VP3WRSDX8pASIAu49//kiZ8Y6lrYcDBZBTlGmZ8FEMPDLQDiACn5aYSXcGqYBdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025198;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=rEZU/UlPV7sod+W8TyPgXa8Zg0gMjh+wAhZBSvUeTHM=;
	b=FTu5frjMbokmVMY8XywWN4WoHo/G7NxceWDSpD1VuxKnKSKycdg1l2eTxYRjfP/Swspc
	 J1S+8GOEQgwpcN0jxw+cURV7gR04TpYAKOpcLaX73b1h06X++Jz8mFQwDthFl1CnAGq57
	 vEcXza3SFHdX7c4YEBXGEduTeaBoD3XxPFFhq+/1y0ZyllH13HinUdhcrkeWPjewvglml
	 yejTo7/RzXo3JPR1xeMXvI/6NpqQxXxbbABSb6uO080IQGi8MOwZuvR+2EL1EGXYf4aeM
	 M9bqeC+MNq8zFAQ8S0/4JqUcG71rbd5JFBe9jgGVd7FN89TiwWpY9K+EC/XWLbqTXnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4OWDKHj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38297606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4OWDKHj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17931F0089F;
	Sat,  7 Nov 2026 04:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025197;
	bh=rEZU/UlPV7sod+W8TyPgXa8Zg0gMjh+wAhZBSvUeTHM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=A4OWDKHj6MbD0oHG7liCWYBrWRweFPCvUg0BPxRAFfQcwVzixTPx8nefUpQUoZFEm
	 O+gw769EF3yD1mZAm0ytZ65ezljQI84SbahNdyYgsh3hQ4ozjVDZjERuDgGrqGR+Qa
	 7K4efIV9ZNFPpG7NFflBkQB3Vm9GpL3bLuWyO1cXqKTmjxJIvnVMvic9jIdCgtFTJd
	 Wbit56LjOZGmxy43OL0Z/y9W0TnG62iLqzasgxB3F2htEVXRisfViwFaKCqNcD3fzQ
	 fNkeG3xE8+XenDSK5qQ+/Xeo2VQpoBblenVBi4QkBQkr+GDhxnxt1YqJL+hCxDnQfC
	 5kIL9Yv3/wEnA==
Content-Type: multipart/mixed; boundary="===============0532326159388719158=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7f04421e478de97f63310ac215132d46af57af6fef4cdf246312078e133cf2e3@mail.kernel.org>
In-Reply-To: <20261107033758.1547725-16-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-16-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v4 15/46] bpf: Move states along edges, into loops and subprogs and out of them
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  7 Nov 2026 04:19:57 +0000 (UTC)

--===============0532326159388719158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Move states along edges, into loops and subprogs and out of them

TL;DR: Speculative exit states may lose their speculative flag when returning
from a subprog, so programs that previously got a nospec fix may now be
rejected (stricter, not unsafe); suggests carrying the flag over.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c

[ ... ]

> +int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int exit_idx)
> +{

[ ... ]

> +	x = kzalloc_obj(*x, GFP_KERNEL_ACCOUNT);
> +	if (!x)
> +		return -ENOMEM;
> +	x->st = *st;
> +	memset(st, 0, sizeof(*st));
> +	x->joins = joins;
> +	list_add_tail(&x->node, &entry->exits);
> +
> +	list_for_each_entry_safe(w, wn, &entry->calls, node) {
> +		err = flow_apply_exit(env, w, x);

Can a speculative exit state lose its speculative flag here?

bpf_flow_exit() accepts any state that reaches BPF_EXIT in frame 0 with a
flow_entry, including states pushed by sanitize_speculative_path().  Those
states are kept apart from the non-speculative ones by bpf_state_subsumes()
and join_check_state(), so they end up as their own flow_exit.

flow_apply_exit() then builds the continuation from a copy of w->st.  That
copy is never speculative, because func_is_on_its_own() returns false when
state->speculative, and bpf_flow_return() copies R0 and the refs from the
exit but not the speculative flag.  The result is delivered to call_idx + 1
as an ordinary state.

Before this series, a speculative path that reached the callee's exit went
on in the caller through prepare_func_exit() with speculative still set,
so do_check_block() could set insn_aux->nospec for a failure that was
recoverable with nospec:

    error_recoverable_with_nospec(err) && state->speculative

With this code the same value reaches the caller in a non-speculative
state, so the error rejects the program.  For example, a loader with
CAP_BPF but without CAP_PERFMON calls a static subprog with a constant
flag, and inside it "if (flag == 1) return 0; return 1000;" is decided, so
the fallthrough is pushed speculatively and exits with R0 = 1000.  If the
caller uses the returned value as a map value offset, that access used to
get a nospec and now fails with "invalid access to map value".

This makes the verifier stricter rather than unsafe.  Would carrying the
flag into the continuation work, for example:

    st.speculative |= x->st.speculative;

before bpf_flow_deliver() in flow_apply_exit()?  No later commit in the
series appears to carry the flag across the return.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42335829855
--===============0532326159388719158==--
