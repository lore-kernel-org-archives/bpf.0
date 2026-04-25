Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472581509AB
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 04:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777091649; cv=none; b=hCPrhc4xFwRjCWvFQG5c4MkR0WbUdhmKmSse80fmSgm8sf2FPKRg2R93954A4QcMD55xVDrYIT4xBFqWFyu7/+Zfy5wDKoT/T7W+DIbRb4i3blYuTVKmOIET15wkhD29phfXKGjz4nd8e3qFqlCGwWz4Yf5Z0iB87gur4HesygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777091649; c=relaxed/simple;
	bh=IDiNRPUBxLRK8UQoiAwIRm2k+khq0iO49YGEB43oLvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QJiUKZwZ25qPuqR9Lmsr1hTjRoI04zFq/+fkGmvgfsJFWfrc4DF5KaATVnUmFqCv/hM56WoDOrlqdxlM6ZgtmSDI+nC4wwA119yV5L/SzNVN7jEfsQoIV230TFlhbdj0e9+7VK9Wn+elrFqErrKc4bhY14w+Ha41sEx8xQy+AJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiv/5r3s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiv/5r3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B058AC2BCB3;
	Sat, 25 Apr 2026 04:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777091648;
	bh=IDiNRPUBxLRK8UQoiAwIRm2k+khq0iO49YGEB43oLvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uiv/5r3snLJWKeSY/OHlFxbzRAhDIPW7wf1jonmZsM91EPuQi0POfpM8IE1PLOyIF
	 rkaQr6tiLI0HB/Aw+nTEbPnrkAF7oI0V0TjlEHJLX5y1RYqATThXYGfJcw+z8UkBkO
	 ZDPT63C/9NRRpenKf5xdV8UIZbwe00zuhi7bO8NKi7YPXCVp2+uF4k+LH9VPEzUe0x
	 wo8gCpJqxq6RYSXf9Jz/6HJmbumAlIHYqWkE8mLCOAPwbshRa6vy5hezCux1yeob1H
	 ewmuTBOnCDDrqGH6OT7RtBWYoGZtUHeqQ4cz1qMq9Ll4jpxLVS4sfcUWhcSCwSb12c
	 IyxkYtWv2YV9A==
From: sashiko-bot@kernel.org
Subject: Re: Uninitialized Stack Variable / NULL Pointer Dereference in
 __sys_socket_create via BPF LSM hooks
Reply-To: sashiko@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421084806.1785541-1-kuniyu@google.com>
References: <20260421084806.1785541-1-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 04:34:08 +0000
Message-Id: <20260425043408.B058AC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Incomplete fix for LSM cgroup return value bypass leaves other=
 hooks vulnerable
--

commit 9f0f3f7cd06f4ada568fc6000ce559112bec1c80
Author: Quan Sun <2022090917019@std.uestc.edu.cn>

Uninitialized Stack Variable / NULL Pointer Dereference in __sys_socket_cre=
ate via BPF LSM hooks

This commit introduces a new bpf_lsm_set_retval helper to prevent
bpf_lsm_socket_create from returning positive values and bypassing error
checks. It restricts the return value for this specific hook to avoid an
uninitialized stack variable dereference in __sys_socket_create.

> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index c5c925f002021..c4b9e9d4de922 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
[ ... ]
> @@ -87,6 +87,13 @@ BTF_ID(func, bpf_lsm_socket_socketpair)
>  #endif
>  BTF_SET_END(bpf_lsm_unlocked_sockopt_hooks)
> =20
> +BTF_SET_START(bpf_lsm_negative_set_retval_hooks)
> +#ifdef CONFIG_SECURITY_NETWORK
> +BTF_ID(func, bpf_lsm_socket_create)
> +#endif
> +BTF_SET_END(bpf_lsm_negative_set_retval_hooks)
> +

Does this fix leave other cgroup LSM hooks vulnerable to the same class
of bypasses?

For example, if a program attaches to bpf_lsm_socket_post_create and calls
bpf_set_retval(1), won't __sock_create() return 1 without initializing the
out-parameter? This would cause __sys_socket_create() to bypass its error
check and pass an uninitialized stack pointer to sock_map_fd(), triggering
the exact memory corruption this patch intends to fix.

Similarly, if a program returns 1 from bpf_lsm_socket_accept, do_accept()
will return ERR_PTR(1). The caller __sys_accept4_file() checks for errors
using IS_ERR(). Since IS_ERR only evaluates true for values >=3D -MAX_ERRNO,
ERR_PTR(1) bypasses the check, and the invalid pointer is installed into
the file descriptor table.

>  #ifdef CONFIG_CGROUP_BPF
>  void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
>  			     bpf_func_t *bpf_func)
[ ... ]
> @@ -221,12 +228,37 @@ static const struct bpf_func_proto bpf_get_attach_c=
ookie_proto =3D {
>  	.arg1_type	=3D ARG_PTR_TO_CTX,
>  };
> =20
> +BPF_CALL_1(bpf_lsm_set_retval, int, retval)
> +{
> +	struct bpf_cg_run_ctx *ctx;
> +
> +	if (retval > 0)
> +		return -EINVAL;

Can a BPF program still bypass caller error checks by passing a large
negative value?

Because this check only blocks values greater than 0, a program could call
bpf_set_retval(-5000). Since -5000 is less than -MAX_ERRNO (-4095),
ERR_PTR(-5000) also evaluates to false under IS_ERR(). This completely
bypasses error checks in callers expecting standard error codes.

Should bpf_set_retval for cgroup LSM programs globally validate the return
value against the allowed range for the specific hook being called, rather
than relying on a single-hook allowlist that only checks for positive value=
s?

> +
> +	ctx =3D container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
> +	ctx->retval =3D retval;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421084806.1785=
541-1-kuniyu@google.com?part=3D1
