Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BDC43CE5A
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878095; cv=none; b=D9WqxLKvDLczpkiFj5st0tm5ahzdKg2skRHbtKic7J17KYLZHqj9ZjDM1B6Mqrwr0bbkP2/uMGLl4tQ0S4ndh+HDjYgL1JmxcHjaS27JzuQqChPodpx2VuHzQK1U27CBOx/vCUHQtcr6ZdV3SjWZhFPWxnkwI2nVM4Z5dNfnZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878095; c=relaxed/simple;
	bh=DDx+6mjPPXClZSy3WJw5fsm9s3+F6LkejdvEvMlkllI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ql9T7I/Ax829SKmPeNHA8TNXwXtg6dnVHgLKJ8NaFJG/YIXUyEvO42eqg81foWPvoYusqygklVjJeIhk3xH6iUjIbs1nU+ULbmCdmzOxh1Y+2ZXh1QJwWSHiGRYgaymNOGQuTVtBF2oY53W2zQEUqKZ33koyg7iXpb13H8zYnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtmUDmqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtmUDmqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F621F000E9;
	Tue,  4 Aug 2026 21:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785878091;
	bh=7wxJvTrskCXuOS+ksRnX2EPl4gCBV5IxkiJdhjslZrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jtmUDmqtoK7OVTLbQczMYP8vTty2k9+qTT8U0qyd2oSAWHd4zL9Tc8/1AxGQimG4K
	 wFtyN0LGO+dlQ2xnqQ0Q+d/QVSGL2Dyi2agIb/MDAYdXPBg3+3/pmgYTU/rh8hHNTS
	 qF/LNVRX+ZJrm4woavN5KMe3lT+dgy4qLXNvadlE8JkBDQqmN1YiAFj9NK0e/KqWR2
	 PdUJAFnp5jYnrAKL5cSPXDHTTW3N9UBgVMaI2JEgj0hL/50TW8sj89Ey4zs7ydFGYE
	 Z+cLau95vjMzrruu3q9WQuiYQxscUngLIleP8c9IaR+q0Rcj2DTRE+BYO424DYeT7c
	 achsuMlLh5oSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 05/13] bpf: Account R2 of register-pair
 returns in live register analysis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804203548.1872337-1-yonghong.song@linux.dev>
References: <20260804203522.1869244-1-yonghong.song@linux.dev>
 <20260804203548.1872337-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 21:14:51 +0000
Message-Id: <20260804211451.A7F621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The verifier fails to check if BPF_REG_2 is initialized at BPF_EXI=
T for global subprograms returning > 8 bytes, which can lead to leaking uni=
nitialized memory.
- [High] The verifier fails to copy the callee's R2 to the caller's R2 in p=
repare_func_exit() for static subprograms returning > 8 bytes.
--

--- Patch [5]: [PATCH bpf-next v2 05/13] bpf: Account R2 of register-pair r=
eturns in live register analysis ---
commit 149c9afee6775ff575a63e08693b340337d96491
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Account R2 of register-pair returns in live register analysis

This commit updates the live register analysis in the BPF verifier to mark =
R2
as read at BPF_EXIT for subprograms returning a value larger than 8 bytes. =
It
uses bpf_ret_reg_pair() to determine if a subprogram returns its value in t=
he
R0:R2 register pair.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 0aadfbae0acc5..68df6d8db4bda 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
[ ... ]
> @@ -2174,7 +2179,7 @@ static void compute_insn_live_regs(struct bpf_verif=
ier_env *env,
>  			break;
>  		case BPF_EXIT:
>  			def =3D 0;
> -			use =3D r0;
> +			use =3D ret_reg_pair ? (r0 | BIT(BPF_REG_2)) : r0;

[Severity: High]
Does check_global_subprog_return_code() also need to check BPF_REG_2 when t=
he
subprogram returns a register pair?

If a global BPF subprogram returns a 16-byte value (e.g., an __int128 or
struct) but does not write to R2 before exiting, the verifier only validates
that BPF_REG_0 is initialized:

kernel/bpf/verifier.c:check_global_subprog_return_code() {
    ...
	return check_global_ret_scalar_reg(env, BPF_REG_0);
}

Although check_global_ret_scalar_reg() was refactored earlier in this series
so that it can be reused for R2, there appears to be no call added to check=
 R2
in check_global_subprog_return_code().

Can this allow a global subprogram to leak uninitialized kernel memory or
pointers in the CPU register corresponding to R2 back to the kernel caller?

[Severity: High]
Additionally, should prepare_func_exit() copy the callee's R2 to the caller=
's
R2 for static subprograms returning > 8 bytes?

Currently, prepare_func_exit() only copies R0:

kernel/bpf/verifier.c:prepare_func_exit() {
    ...
	} else {
		/* return to the caller whatever r0 had in the callee */
		caller->regs[BPF_REG_0] =3D *r0;
	}
    ...
}

If a BPF program calls a static subprogram that returns a 16-byte value, and
the caller attempts to use the upper 8 bytes returned in R2, won't the veri=
fier
reject the valid program with a read of uninitialized register error?=20

This happens because the caller's R2 was marked NOT_INIT prior to the call =
by
clear_caller_saved_regs(), but prepare_func_exit() does not propagate the
callee's R2 value back to the caller.

>  			break;
>  		case BPF_CALL:
>  			def =3D ALL_CALLER_SAVED_REGS;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804203522.1869=
244-1-yonghong.song@linux.dev?part=3D5
