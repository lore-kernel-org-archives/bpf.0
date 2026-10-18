Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE9280309
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792287135; cv=none; b=rrxguQOHvUYPqmX4AohPtJkK1oYzeQD/caWYC1XGAZujBEtMS3+FJXhJ5s80djgVh4cNl6+ymrQVb6nFDDVZa7dLipUBTn1qcKl+QF0JR1IwG6CeWSAAuW37PBLnHKF8vZwKpDFLHZuAssrhvx5Yo7Hw86lRHfWRFy/JydBST6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792287135; c=relaxed/simple;
	bh=Pi2Io73fRMNqLpI/ckZkOnNFnW2zOtKYTLx5BooDpvw=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=ZwpGHgyPmQy0uS59mJLWA8+aeUAxTrPTr3zlpl7lPA3K02tMJk/gRV2MHlI79o6tNrhSangKDe7C11aHwcygJPod2vGWEegVIUa2EYR+sU1TWte1Z8onrCJvMx+RpmBsu2ianT1yzZcsbKeHCF+sMcag243tYqAoVedDiB4nbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dToURYTt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dToURYTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E15B1F000C4;
	Sun, 18 Oct 2026 01:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792287133;
	bh=jqzP+lStdm/Tcabu9mVF6Cs76LYuSZ5uw5oQ7vTGN8k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dToURYTtuDPj/4eL9tGRlIqvtZCFSz3x820lBFDFa3vXycj2Ij5mGqVzmRJcg1zTZ
	 C65nJWSgtS0CFyOdSOQ1Z5mF1xrKYQAGD5HBvKgZ8maWG7E6bwIGeBNAMkLg8fpcM2
	 XrsNFG2oWjvGDs6nJ4GbaUC/zPgDBQahMDfpv54WhymNHuqZdSGb2OSfFUuPhxtca5
	 ocUyyVEEHXDNgMBS1QByr6QGNCdyooGhpHOgHSpVLUQA/ZD2jAC/dbqsxI2jKvtuze
	 9YpgnSBdLHwyI9NEp9M0TL+8P6yWqJjERKEg5efHVL8IB9dg7CwLuoJz7BPnwLRKIQ
	 t9UsBsIFi9dfw==
Message-ID: <sashiko-outbox-175872@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/5] bpf: Support unwinding via r3
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261018010246.1643877-2-alexei.starovoitov@gmail.com>
References: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
 <20261018010246.1643877-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 01:32:13 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: missing r3 unwind check for async and exception callbacks i=
n process_bpf_exit_full()
--

commit 2eb5a83ebef2f014ae77160f4cea6d3a54b2f738
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Support unwinding via r3

This commit adds verifier and JIT support for subprograms annotated with the
BTF decl_tag "unwind", which use r3 (BPF_REG_UNWIND) at exit to indicate
whether they return normally or unwind to a caller's landing pad.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2c812a5f1da87..7f1aefafa0b9b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11961,6 +11983,16 @@ static int prepare_func_exit(struct bpf_verifier=
_env *env, int *insn_idx)
>  					       "At callback return", "R0");
>  			return -EINVAL;
>  		}
> +		/* the helper that called it does not look at r3 */
> +		if (ret_unwind) {
> +			if (!bpf_register_is_null(&callee->regs[BPF_REG_UNWIND])) {
> +				verbose(env, "callback cannot unwind\n");
> +				return -EINVAL;
> +			}
> +			err =3D mark_chain_precision(env, BPF_REG_UNWIND);
> +			if (err)
> +				return err;
> +		}
>  		if (!bpf_calls_callback(env, callee->callsite)) {
>  			verifier_bug(env, "in callback at %d, callsite %d !calls_callback",
>  				     *insn_idx, callee->callsite);

[Severity: Medium]
Does this check in prepare_func_exit() miss asynchronous callbacks and
exception callbacks that are annotated with the "unwind" BTF decl_tag?

When a subprogram is verified as an asynchronous callback (via push_async_c=
b()
with in_async_callback_fn =3D true) or as an exception callback (via
do_check_common() with in_exception_callback_fn =3D true), it runs at
curframe =3D=3D 0.

When BPF_EXIT is reached in process_bpf_exit_full():

kernel/bpf/verifier.c:process_bpf_exit_full() {
	...
	if (env->cur_state->curframe) {
		/* exit from nested function */
		err =3D prepare_func_exit(env, &env->insn_idx);
		...
	}
	...
	if (cur_frame->subprogno &&
	    !cur_frame->in_async_callback_fn &&
	    !cur_frame->in_exception_callback_fn)
		err =3D check_global_subprog_return_code(env);
	else
		err =3D check_return_code(env, BPF_REG_0, "R0");
}

Both prepare_func_exit() and check_global_subprog_return_code() are skipped,
and check_return_code() only validates R0:

kernel/bpf/verifier.c:check_return_code() {
	...
	if (frame->in_async_callback_fn) {
		exit_ctx =3D "At async callback return";
		range =3D frame->callback_ret_range;
		goto enforce_retval;
	}
}

Because llvm lowers unwind paths to r0 =3D 0; r3 =3D 1; exit, R0 satisfies =
the
callback return range while BPF_REG_UNWIND (R3) is never checked in
check_return_code(). Meanwhile, bpf_compute_live_registers() marks
BPF_REG_UNWIND as live at BPF_EXIT for all subprog > 0 with ret_unwind set.

Should check_return_code() (or process_bpf_exit_full()) also enforce that
BPF_REG_UNWIND is 0 when subprog_info(env, frame->subprogno)->ret_unwind is
set for async and exception callbacks?

[ ... ]

> @@ -19335,6 +19383,12 @@ static int check_global_subprog_return_code(stru=
ct bpf_verifier_env *env)
>  	u32 i, nregs;
>  	int err;
> =20
> +	if (subprog_info(env, subprog)->ret_unwind) {
> +		err =3D check_global_ret_scalar_reg(env, BPF_REG_UNWIND);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (subprog_returns_void(env, subprog))
>  		return 0;
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018010246.1643=
877-1-alexei.starovoitov@gmail.com?part=3D1
