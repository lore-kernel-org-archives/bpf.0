Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E83314AE
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851642; cv=none; b=OMMHuvTLOSxY5UtjAt6LL3K8Yu1BtcJScP5ub7/8Leh4XJzj063uPi5IA6e5m3XQ+0M+17jbSk38/+HcLQ0UilqD+oBUNkHAojtWBpPiodQt8gqvX/nLakDx/exhyQbVUGkBJLD/ewp8rtfHyKrxD8o0VdGUyEX0JpT09mB3ZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851642; c=relaxed/simple;
	bh=K+2iJAZ4fESDDY4zfceASK8k+6Tt/T9HCP4s8SDeOKY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XsO2Km9to8NA/0d/VhwldwQXGimoln9kWWqMsnQU0OTO7ztHsFsWX/110Onm24NlSWBe5O5QJiUjgVquS/OUNum9qewjZd0Metp97v2hLosGcPJH3JcjAMnWNf+myl6owmMwIilwQsuh7C+MEBCv6yx9JbMsQNQGXWmYI4jT2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx9h9Wz4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx9h9Wz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F619C2BCB4;
	Wed, 22 Apr 2026 09:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776851642;
	bh=K+2iJAZ4fESDDY4zfceASK8k+6Tt/T9HCP4s8SDeOKY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Gx9h9Wz4dC0wuKUWe+BvvQht5oGAdQh7COlADqL2yrplVW+2E4lDP7bUix8tY2KR1
	 w9FCYFhKYNMLkSedU7pUF/EqqgI0miEVKH75fyC5H8tj4d+KCIq0k5TFcg2u+PkyZb
	 LXuahH7+cxQaDSw14vT9ZsdBoBrbxBGhscES0MS9xfBxZoAEFbhIzcTU2QnnCRGQ/w
	 2IlOAVPJatT5joLYLVJekrtKmDUxfqW41dsUmoYvPT72AQHNf7c3WniGgsNEygyZPB
	 hqT55q3t5uHM+NpjitoXDHuFywRy8PTWWPN4iOfp8obCi82sXG6iwdJo9SV/VFGB3x
	 UJHAzTRaUFG+w==
Content-Type: multipart/mixed; boundary="===============8613132370443475542=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9d23e38b3959d82eb6990913dee39f1f1b095528cfe2957caea4fe359ab01832@mail.kernel.org>
In-Reply-To: <20260421084806.1785541-1-kuniyu@google.com>
References: <20260421084806.1785541-1-kuniyu@google.com>
Subject: Re: Uninitialized Stack Variable / NULL Pointer Dereference in __sys_socket_create via BPF LSM hooks
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,2022090917019@std.uestc.edu.cn
Cc: M202472210@hust.edu.cn,bpf@vger.kernel.org,daniel@iogearbox.net,dddddd@hust.edu.cn,dzm91@hust.edu.cn,edumazet@google.com,hust-os-kernel-patches@googlegroups.com,jiayuan.chen@linux.dev,kuniyu@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 22 Apr 2026 09:54:02 +0000 (UTC)

--===============8613132370443475542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index c5c925f00202..c4b9e9d4de92 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -87,6 +87,13 @@ BTF_ID(func, bpf_lsm_socket_socketpair)
>  #endif
>  BTF_SET_END(bpf_lsm_unlocked_sockopt_hooks)
>
> +BTF_SET_START(bpf_lsm_negative_set_retval_hooks)
> +#ifdef CONFIG_SECURITY_NETWORK
> +BTF_ID(func, bpf_lsm_socket_create)
> +#endif
> +BTF_SET_END(bpf_lsm_negative_set_retval_hooks)

Should bpf_lsm_socket_post_create be included in this whitelist as well?
The same exploit pattern applies to security_socket_post_create() in
sock_create_lite(). If a BPF_LSM_CGROUP program attached to
bpf_lsm_socket_post_create calls bpf_set_retval(1) using the unguarded
helper from cgroup_common_func_proto, the positive return propagates out
and sock_create_lite() releases the socket:

    err = security_socket_post_create(...);
    if (err) goto out_release;

    out_release:
        sock_release(sock);

then sets *res to NULL and returns the positive err to kernel_accept():

    err = sock_create_lite(...);
    if (err < 0) goto done;

The positive err is not caught, so kernel_accept() continues to
ops->accept(sock, *newsock, ...) with *newsock being NULL, triggering a
NULL pointer dereference in the protocol's accept handler.

This is the same class of vulnerability your commit addresses.

The commit message notes: "I guess all (most?) places suppose LSM to return
0 or a negative value, and the btf_id_set_contains() check would be
unnecessary?" - this suggests the issue may be more widespread than just
bpf_lsm_socket_create.

> +
> +
>  #ifdef CONFIG_CGROUP_BPF
>  void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
>  			     bpf_func_t *bpf_func)
> @@ -221,12 +228,37 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto = {
>  	.arg1_type	= ARG_PTR_TO_CTX,
>  };
>
> +BPF_CALL_1(bpf_lsm_set_retval, int, retval)
> +{
> +	struct bpf_cg_run_ctx *ctx;
> +
> +	if (retval > 0)
> +		return -EINVAL;
> +
> +	ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
> +	ctx->retval = retval;
> +
> +	return 0;
> +}
> +
> +const struct bpf_func_proto bpf_lsm_set_retval_proto = {
> +	.func		= bpf_lsm_set_retval,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_ANYTHING,
> };
>
>  static const struct bpf_func_proto *
>  bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
>  	const struct bpf_func_proto *func_proto;
>
>  	if (prog->expected_attach_type == BPF_LSM_CGROUP) {
> +		if (func_id == BPF_FUNC_set_retval &&
> +		    btf_id_set_contains(&bpf_lsm_negative_set_retval_hooks,
> +					prog->aux->attach_btf_id))
> +			return &bpf_lsm_set_retval_proto;
> +
>  		func_proto = cgroup_common_func_proto(func_id, prog);
>  		if (func_proto)
>  			return func_proto;

The retval > 0 guard is only applied to hooks in
bpf_lsm_negative_set_retval_hooks. For any BPF_LSM_CGROUP program
attached to hooks not in that set, bpf_lsm_func_proto falls through
to cgroup_common_func_proto which returns the unguarded
bpf_set_retval_proto that unconditionally writes any integer (including
positive values) into ctx->retval.

The commit message describes the root cause as a generic issue wherever
security_* callers use "if (err < 0)" instead of "if (err)". The fix
protects a single hook but leaves the unsafe bpf_set_retval_proto
reachable for all other BPF_LSM_CGROUP hooks.

Would it be safer to unconditionally reject retval > 0 for all
BPF_LSM_CGROUP contexts, or alternatively fix the underlying socket
layer return-value checks?

---

The commit lacks a Fixes: tag. This fixes a major security vulnerability
(NULL pointer dereference/privilege escalation) introduced when
bpf_set_retval() was enabled for BPF_LSM_CGROUP hooks without validating
that positive return values could skip allocation while appearing to
succeed.

Suggested: Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")

The commit also lacks a Signed-off-by: tag from the author, which is
required per Documentation/process/submitting-patches.rst.

---

Two review comments from the v1 discussion have not been addressed:

Matt Bobrowski suggested also making __sys_socket_create() more
defensive by initializing sock to NULL and checking both return code
and pointer validity after sock_create(). This would protect against
failures from any source (BPF, other LSMs, or bugs in protocol family
->create() functions). The current patch only implements the BPF-side
fix.

Reference: https://lore.kernel.org/bpf/aedAqdeuVqLq4hDQ@google.com/

Xu Kuohai suggested checking the return value directly against the
hook's valid return range using bpf_lsm_get_retval_range() in the
verifier, rather than making a socket_create-specific change. This
approach would validate retval for all LSM hooks. Matt Bobrowski agreed
this should be added as a separate patch. The current implementation
only checks for positive values in the helper function itself, not in
the verifier.

Reference: https://lore.kernel.org/bpf/ea1d6de6-55b0-4478-94e3-83733788e7c9@huaweicloud.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24770372681
--===============8613132370443475542==--
