Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD664D8DBA
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448909; cv=none; b=Y3lxBq/0E3zipnAsNTactjwCozaduRQ125oXz0Qz2Mgbg3dGTCfyA+lePowunAy4glycorvd/2Rg1zi9VQPxhKUQ1JxrAPXYLPDcrOH6+/uTUt7KfHmZEK+t3oyK8OvP9h9K5VY8vORDsAzIotxsB9H6b7xTOQGax3TqRxKREBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448909; c=relaxed/simple;
	bh=w6dcHEZ9BhnkVwqPxf2+MUjxMqtJlf5oAeh/sz6jvyw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tzvBvHah/0dpdy26FTG24iN8l7cgMlIHkQZnKH773CYSkqsBqQQQpP90oZ3/Jp5GdNNt/5LjllD0M4uI8gXPHBtnIcb6oZsta31uBbcrFOHLf4a0+FlfwweVeU3jGw581BFKwU8DO9omLd97G82dxIeKzQ3xekv8RlCQALpwiNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKEGAFiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKEGAFiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E241F00A3A;
	Thu,  3 Sep 2026 15:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788448908;
	bh=3OOM+kvk4xwgYE7t24rAxoQ09QnetIVD73VUgjrboks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QKEGAFiImkYvtwbFs1aljNJxwnPJ8wzuum1gvkIFf+8GWl2P2qcLJSWsoKR8fWFzq
	 JYswU4eRedqYdGfu16TdsKG0dXoaGoSJHGF3qZueOefCkdjqgZJjLL9vDRpNXoGAX1
	 RQHlsQvZu985/h/YcCaoEyJ2vTSTGrHx5ugDGiH3iw3Mf/TUvMILZ2mP9fCqE/94C9
	 sOMkpxEAxV9AAQHkrhBDDXmWF0QT0TS1Qokyh5lrOzt24DK13Ol10pWgQdqQEBlgy3
	 nCA4aGDUVMM+N3AKJlVL8geJoIJgPK2e30idclXZqi4j/ImcVHl5jXdRjFe2YzOSND
	 3vMVpmMykBg8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 03/10] bpf: Reject tail calls directly from
 callback frames
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903144433.1716731-4-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
 <20260903144433.1716731-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 15:21:47 +0000
Message-Id: <20260903152147.C0E241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch prevents bpf_tail_call within a callback to fix the 'cal=
lback unexpected regs' verifier bug, but misses that BPF_LD_ABS and BPF_LD_=
IND trigger the exact same bug via the same prepare_func_exit() path.
--

commit a25ccc5cdb72d9330414949c17ecac5156595510
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

    bpf: Reject tail calls directly from callback frames

    A tail call from a non-zero frame is modeled as a return from that fram=
e,
    synthesizing R0 and calling prepare_func_exit() for the taken branch.
    When the current frame is a synchronous callback, prepare_func_exit()
    enforces the callback return-value contract and marks R0 precise, trigg=
ering
    the "callback unexpected regs" verifier warning during precision backtr=
acking.
    This patch rejects a tail call made directly by a callback before
    constructing the inconsistent return state.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7d8ddb1bee00c..f540279ff4abb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11228,6 +11228,17 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  		if (env->cur_state->curframe) {
>  			struct bpf_verifier_state *branch;
> =20
> +			/*
> +			 * A taken tail call is modeled as a return from the current
> +			 * frame. A callback frame cannot be left that way because
> +			 * prepare_func_exit() would apply its return contract to the
> +			 * unknown R0 synthesized below. Stack-depth validation rejects
> +			 * this construct anyway.
> +			 */
> +			if (cur_func(env)->in_callback_fn) {
> +				verbose(env, "cannot tail call within callback\n");
> +				return -EINVAL;
> +			}

[Severity: High]
This isn't a bug introduced by this patch, but doesn't BPF_LD_ABS inside a
subprog trigger the exact same bug via the same prepare_func_exit() path?

Looking at check_ld_abs() in kernel/bpf/verifier.c:

    if (env->cur_state->curframe) {
        struct bpf_verifier_state *branch;

        mark_reg_scratched(env, BPF_REG_0);
        branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, false);
        if (IS_ERR(branch))
            return PTR_ERR(branch);
        mark_reg_known_zero(env, regs, BPF_REG_0);
        err =3D prepare_func_exit(env, &env->insn_idx);
        if (err)
            return err;
        env->insn_idx--;
    }

If a CAP_BPF user loads a SCHED_CLS program (where BPF_LD_ABS is allowed),
invokes bpf_loop(), passes PTR_TO_CTX through the stack to the callback_ctx
argument, loads the context into R6 inside the callback, and executes
BPF_LD_ABS, it appears check_ld_abs() will synthesize R0 and call
prepare_func_exit().

Since the callback frame lacks instruction history for R0, won't precision
backtracking fail and hit the exact same "callback unexpected regs" verifier
warning? Does check_ld_abs() need a similar rejection for callbacks?

>  			mark_reg_scratched(env, BPF_REG_0);
>  			branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, false);
>  			if (IS_ERR(branch))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903144433.1716=
731-1-memxor@gmail.com?part=3D3
