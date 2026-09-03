Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986164E80BD
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450770; cv=none; b=ORKrNEbfD8CYTyT4hTXzykxUfVqDyg6D7wwtfzsqM9CXazrDpKMwDuB5u8ddKLubfrRbxY8xPtSH2JlnpUO4pWwdD/LUPbk35QhEYCQuScrucdKUGiVxvMDQaBSHfW/bDFWbl2QGcfwkL9uAf74FmOxlYI21YE8tgimp4sqyHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450770; c=relaxed/simple;
	bh=8l+HjuNvTzMJJi+h5Nnv6LuA3xYLJiazUGfGkEYSerI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nlCYQ3TAEn/IVzL0XZR1mDDetsFdXW5nVlbUlt4YtcqL10b9cz3g+AE9NT0zSnEcJNaRCQK06GZ40rGSQYXwkNAPPVHzhUkix/rgL3oeOcihfSJtLr9fm30sRr5gMjph/BiO7Bnz8w7/G7H0BfvCSmMb11tlmAIk2aF/7Q8JNUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVgfU7q3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVgfU7q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69AE1F000E9;
	Thu,  3 Sep 2026 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450769;
	bh=M+unLmleMj/r6dzHdVQgvPJ0MFQuVyAGckbBlrv0aTM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nVgfU7q39VwDbbCCfLOCCRFmF7pUIts7sdH6d/Nqsh2FS0Jk2O1Pj80qIet5IlkQo
	 Zt2S+d07lqAxWA36ATcYO3lLHwLVyQkB0IxItYyfxs8AHIOUqaMN4lAjTbhVqVCZqx
	 ql+9lDOvov/IcS/GvtgxsKsVPzr8OULfadYSV7hBl22IuNFJ9hc7aC96KBPVAAIg6L
	 PAvXO77HOymqvLh7RpMxTXdkTkqN8lCUpZuuO9TLq/p0s5b/BQmJH+UOooOeeQkjOQ
	 Ahzbi8Wq8L2rhLMKRuApOJeBk2k0Gbp2dDoHTg2DUHyUxxfMy9Nc+N6Pp0pZ3no/2Q
	 znt9GKux0anKg==
Content-Type: multipart/mixed; boundary="===============7995678498931071589=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a89693901bf8eda8ad84b8191ae121aa6ac4cfa6c333ad78eab358d28968c8ff@mail.kernel.org>
In-Reply-To: <20260903144433.1716731-7-memxor@gmail.com>
References: <20260903144433.1716731-7-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 06/10] selftests/bpf: Reject resilient unlock in rbtree callback
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 15:52:48 +0000 (UTC)

--===============7995678498931071589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add a load-only verifier regression for a resilient lock operation in an
> rbtree comparison callback. The program holds the rbtree's regular spin
> lock and a separate resilient lock, then releases the resilient lock from
> the callback. This isolates the missing kfunc policy check without running
> a concurrent tree mutation.
>
> Release the resilient lock before the regular lock on the outer
> fall-through. The broken verifier therefore accepts the balanced program,
> while the fixed verifier rejects the resilient unlock specifically while
> verifying the callback.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

The commit message states "The broken verifier therefore accepts the
balanced program." Does the pre-fix verifier actually accept this program?

Tracing through the verifier's behavior before the parent commit's fix: the
added program structure is

    bpf_spin_lock(&glock);
    if (bpf_res_spin_lock(&res_glock)) { ... }
    bpf_rbtree_add(&groot, &n->node, less__bad_res_spin_unlock);
    bpf_res_spin_unlock(&res_glock);
    bpf_spin_unlock(&glock);

with the callback doing only bpf_res_spin_unlock(&res_glock).

Without the parent commit's check, the callback's unlock succeeds and the
release is recorded in the verifier state, not in the callee frame. Locks
live in struct bpf_verifier_state (state->refs, state->active_locks,
acquire_lock_state() and release_lock_state() in verifier.c, and
process_spin_lock()).

Nothing catches the imbalance at the callback boundary either:
process_bpf_exit_full() passes check_lock = exception_exit ||
!env->cur_state->curframe, which is false for a callback frame.
check_reference_leak() returns 0 immediately when cur_func(env)->frameno is
non-zero.

prepare_func_exit() then does, for in_callback_fn:

    if (in_callback_fn)
        *insn_idx = callee->callsite;

so the frame is popped and verification resumes at the bpf_rbtree_add
callsite carrying the callback's state, in which res_glock is no longer
held. is_state_visited() cannot prune that state against the pre-call state
at the callsite, because refsafe() bails on old->active_locks !=
cur->active_locks (2 vs 1).

Verification therefore falls through past the callsite and reaches the outer
bpf_res_spin_unlock(&res_glock), where process_spin_lock()'s
find_lock_state(cur, REF_TYPE_RES_LOCK, reg->id, ptr) finds nothing and
emits "bpf_res_spin_unlock of different lock" with -EINVAL.

The result is: pre-fix the load fails with "bpf_res_spin_unlock of different
lock," while post-fix it fails with "can't res_spin_{lock,unlock} in rbtree
cb."

The __failure __msg("can't res_spin_{lock,unlock} in rbtree cb") assertion
does still discriminate a fixed kernel from a broken one, so the test itself
is functional. However, should the changelog say the pre-fix verifier accepts
this program when it actually rejects it with a different message?

A case that the pre-fix verifier would actually accept is one where the
callback leaves the lock state balanced at exit (for example, unlock then
re-lock the same resilient lock inside the callback), which is also closer
to the use-after-free window the parent commit describes.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33770534313
--===============7995678498931071589==--
