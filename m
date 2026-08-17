Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC49314A90
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786941824; cv=none; b=r5ftjPyrZiynjt4YvHHE/J452CU5OkHglMllfkSCpiSJjP7m7t4V0UqM6DkYdGIvFVNXEs44ddlerAg5mUIDcLbCSx+gOViWxCkSYQS3Yg65M+2W6odBfCADlzrvLeksAFGd/6qZXRJpQhS9hWoXb9ZzKBCfKxtyeZT9AzVvpNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786941824; c=relaxed/simple;
	bh=rkSngvpKkMSlGl+N3myfWiVTRfdKv7zpmfKmUDDKh8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eQj5i67bmpc5jOVhAeCSDQKjfFkIr1r+91DaAo00R7i2k9wkbaxJsEo2Wxu60Baz1/yQp7IxcfIFLMIIoYPp3GahGR+1oZSmBdQmFZPqcRgWuZmLh+n2OT293cCHhq89GbMxPiNrIqguZR8W9GgGFAQkofutqtCKvV2c4Ny/py4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqfLSBfJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqfLSBfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D1E1F000E9;
	Mon, 17 Aug 2026 04:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786941822;
	bh=WahG4Urt+5nNHQUCLiIWRvf7Aipl0iF1mvH6yb6unho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OqfLSBfJpL1DyOe5FiXqeYEsqra/832WPB8pNgJODElX4nOxRKV4rMstmMumLGe8t
	 3J1+5Srvr4tq3MSCfsQ01XeadJGbXXj5ifiIMS9xP1AJAOqLZ+lOKACq0Vd8NN68Au
	 thM+x4ZNjXQXIt+ujxkr1npe/a2+PnpeyP69O9B4g9ZpuM7Tk/IigRb3pGYFxRG7O/
	 /4em+UPvSLNuHVfZiYpcZMgSaYLeO7KZhXPMyu6uSycdNh5qBm6htFSJVsJIHqrQvE
	 1Dh+MddfmJOFY9YjwvwMlEghKqcomLv5SP3dRd1tj8x8qsfPJOHWysJi3DfWRq90jY
	 K82mAjYMrmPEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 05/10] bpf: Account R2 of register-pair
 returns in live register analysis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817042207.2289995-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
 <20260817042207.2289995-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 04:43:42 +0000
Message-Id: <20260817044342.66D1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] When a BPF program with 16-byte returns falls back to the inte=
rpreter (e.g., if JIT is disabled), the interpreter silently discards the u=
pper 8 bytes (R2) of the return value, causing runtime data corruption.
- [High] The verifier fails to propagate or initialize BPF_REG_2 back to th=
e caller for subprograms and kfuncs returning 16-byte values, rendering the=
 feature unusable.
- [High] The verifier fails to validate the safety of BPF_REG_2 at the exit=
 of global subprograms returning 16-byte values, allowing potential pointer=
 leaks or returning uninitialized memory.
--

--- Patch [5]: [PATCH bpf-next v6 05/10] bpf: Account R2 of register-pair r=
eturns in live register analysis ---
commit 1e84baf022beac38fd11fa1a392f1c5622154586
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Account R2 of register-pair returns in live register analysis

This commit updates the live register analysis to account for subprograms
returning a 16-byte register pair. It modifies compute_insn_live_regs()
to mark BPF_REG_2 as read during BPF_EXIT when a subprogram returns a
register pair.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 74fc4b3f80d6e..71f998c6eb888 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
[ ... ]
> @@ -2191,7 +2193,7 @@ static void compute_insn_live_regs(struct bpf_verif=
ier_env *env,
>  			break;
>  		case BPF_EXIT:
>  			def =3D 0;
> -			use =3D r0;
> +			use =3D ret_reg_pair ? (r0 | r2) : r0;
>  			break;

[Severity: High]
How does the verifier propagate BPF_REG_2 back to the caller for subprograms
and kfuncs returning 16-byte values?

In kernel/bpf/verifier.c:prepare_func_exit(), only BPF_REG_0 is copied from
the callee's state to the caller's state:

kernel/bpf/verifier.c:prepare_func_exit() {
	...
	/* return to the caller whatever r0 had in the callee */
	bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], r0, BPF_DIAG_MOD_WRITE);
	caller->regs[BPF_REG_0] =3D *r0;
	bpf_diag_mod_end(env);
	...
}

Similarly, when returning from a non-void global subprogram or a kfunc, only
BPF_REG_0 is initialized as a scalar. For instance, in check_func_call():

kernel/bpf/verifier.c:check_func_call() {
	...
	/* All non-void global functions return a 64-bit SCALAR_VALUE. */
	if (!returns_void) {
		mark_reg_unknown(env, caller->regs, BPF_REG_0);
		bpf_diag_mod_end(env);
	}
	...
}

And in check_kfunc_call():

kernel/bpf/verifier.c:check_kfunc_call() {
	...
	if (btf_type_is_scalar(t)) {
		mark_reg_unknown(env, regs, BPF_REG_0);
	...
}

Since clear_caller_saved_regs() marks R1-R5 as NOT_INIT prior to the call,
would this leave the caller's BPF_REG_2 uninitialized, causing the verifier
to reject legitimate reads of the upper 8 bytes of the return value?

[Severity: High]
Is the safety of BPF_REG_2 validated at the exit of global subprograms
returning 16-byte values?

In kernel/bpf/verifier.c:check_global_subprog_return_code(), the return code
validation is only performed for BPF_REG_0:

kernel/bpf/verifier.c:check_global_subprog_return_code() {
	...
	return check_global_ret_scalar_reg(env, BPF_REG_0);
}

Could this omit BPF_REG_2 for register-pair returns, potentially allowing a
global subprogram to return an unreferenced pointer, a map value pointer, or
uninitialized memory without being caught by the verifier?

[Severity: Critical]
What happens if a BPF program with 16-byte returns falls back to the
interpreter?

If JIT is not requested, bpf_compute_subprog_ret_regs() exits early without
setting env->prog->jit_required =3D 1:

kernel/bpf/verifier.c:bpf_compute_subprog_ret_regs() {
	...
	if (!env->prog->jit_requested || bpf_prog_is_offloaded(env->prog->aux))
		return 0;
	...
}

This permits the program to fall back to the interpreter. However, the
interpreter handles subprogram calls via JMP_CALL_ARGS, which only propagat=
es
BPF_R0:

kernel/bpf/core.c:___bpf_prog_run() {
	...
	JMP_CALL_ARGS:
		BPF_R0 =3D interpreters_args[insn->off](BPF_R1, BPF_R2, BPF_R3,
						      BPF_R4, BPF_R5,
						      insn + insn->imm + 1);
		CONT;
	...
}

Since the PROG_NAME_ARGS macro generates functions that return a single u64,
does the interpreter silently discard the upper 8 bytes (R2) of the return
value, causing data corruption at runtime?

>  		case BPF_CALL:
>  			def =3D ALL_CALLER_SAVED_REGS;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817042141.2286=
086-1-yonghong.song@linux.dev?part=3D5
