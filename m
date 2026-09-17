Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD14A64CF;
	Thu, 17 Sep 2026 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680858; cv=none; b=uy4uOVf66N4mS9IhTdDIJ1Xj4d7U5O7vDVDiZsx9Mmqj77fQFugm2+ekguPmYi1+1iPolWIFVlPZyQDtrp1NWw2Sp88kKBhdqF6bXX9okTRYxnXTcrU2SK8bDCRLrRL1NAjcwK0uz89FhC9+yF2tUYmU+ERy+YzNN2VQWh+R/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680858; c=relaxed/simple;
	bh=k+sUSqPyyZsvSVmPlAe/ICrBsM2C7B2RDwQ2cSpYeIw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dVn8AWQZNhHgnP4/8ueVRVAyW0lKdnoaZAKOiL7OXsuRKRElQFMsESfw3d169Ll8oWG9fo62ShjcQVMAJ2GUrdFuO4oqXRfq5CnTwRE3j+NiK3YAdF6aBwK1rdR1ABGgEYUgOI8a7pqwUHZQgqVr3iPFjg4abilZZHwzoVd1pE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQVt9tIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQVt9tIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD8D1F000FF;
	Thu, 17 Sep 2026 21:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680856;
	bh=DRKTXEM8hQg2RCXFVpDgdvnjpCoANpJncZE+HSNxSho=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RQVt9tIFtJM39hOZF9lvaJifOJ3rorrtUCTYX5oh2HdMiCu2ws+w+v/LXkU14Uu08
	 JkoXZBb1nAkFLBiH2fnjaxfSoCHlKqNu42Rj4VfGVFyuyYBxwOjBeu3JHGhpjM4OQE
	 mG8J5Xy1s2mJc7S1wmgecl9bzGiKTARE8D9PhM6JH4+mN/BI1uHVhZkBmMI7+3TAbh
	 33GRCKSLdpEcwXA425MjiwsNObZIppgx0k95DvB3gcRHLx4AOqyZXgI4MXGRp3P1Cs
	 UGXksNEY1B5bpXU/ubqIwXyyS+Zs8+/PimS54+slejWpOsat7Qxl09TYZqh3Ia9C+c
	 qVeJHebsQXegA==
Content-Type: multipart/mixed; boundary="===============7605950183679678339=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <68a34be902cb46bf0ae19b9ecabb05956491a7180e37471ae81804734a7c62f2@mail.kernel.org>
In-Reply-To: <20260917200542.3689605-12-ameryhung@gmail.com>
References: <20260917200542.3689605-12-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 11/15] bpf: tcp: Support selected sock_ops callbacks as struct_ops
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,shakeel.butt@linux.dev,roman.gushchin@linux.dev,kuniyu@google.com,kerneljasonxing@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 21:34:15 +0000 (UTC)

--===============7605950183679678339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f34b410f903ec..3abde9a2a375e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2634,6 +2634,7 @@ struct bpf_trace_run_ctx {
>  struct bpf_tramp_run_ctx {
>  	struct bpf_run_ctx run_ctx;
>  	u64 bpf_cookie;
> +	int retval;
>  	struct bpf_run_ctx *saved_run_ctx;
>  };

[ ... ]

> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> new file mode 100644
> index 0000000000000..3febbc8dd1a06
> --- /dev/null
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/bpf_verifier.h>
> +#include <net/bpf_sk_storage.h>
> +#include <net/tcp.h>
> +
> +static int timeout_init_stub(struct sock *sk, struct request_sock *req__nullable)
> +{
> +	struct bpf_tramp_run_ctx *ctx =
> +		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
> +
> +	return ctx->retval;
> +}
> +
> +static int rwnd_init_stub(struct sock *sk, struct request_sock *req__nullable)
> +{
> +	struct bpf_tramp_run_ctx *ctx =
> +		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
> +
> +	return ctx->retval;
> +}

[ ... ]

> +BPF_CALL_0(bpf_tcp_ops_get_retval)
> +{
> +	struct bpf_tramp_run_ctx *ctx =
> +		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
> +
> +	/* bpf_get_retval() is only exposed to timeout_init/rwnd_init, which
> +	 * always run via bpf_tcp_ops_call_int(). Its run_ctx carries the int
> +	 * return value chained across the bpf_tcp_ops attached to the cgroup
> +	 * and is this program's saved_run_ctx.
> +	 */
> +	if (WARN_ON_ONCE(!ctx->saved_run_ctx))
> +		return 0;
> +
> +	return container_of(ctx->saved_run_ctx, struct bpf_tramp_run_ctx,
> +			    run_ctx)->retval;
> +}
> +
> +const struct bpf_func_proto bpf_tcp_ops_get_retval_proto = {
> +	.func		= bpf_tcp_ops_get_retval,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +};
> +
> +static const struct bpf_func_proto *
> +get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +{
> +	u32 moff = prog->aux->attach_st_ops_member_off;
> +
> +	switch (func_id) {
> +	case BPF_FUNC_sk_storage_get:
> +		return &bpf_sk_storage_get_proto;
> +	case BPF_FUNC_sk_storage_delete:
> +		return &bpf_sk_storage_delete_proto;
> +	case BPF_FUNC_setsockopt:
> +		/* The listener is not locked. */
> +		if (moff == offsetof(struct bpf_tcp_ops, rwnd_init) ||
> +		    moff == offsetof(struct bpf_tcp_ops, timeout_init))
> +			return NULL;
> +		return &bpf_sk_setsockopt_proto;
> +	case BPF_FUNC_getsockopt:
> +		if (moff == offsetof(struct bpf_tcp_ops, rwnd_init) ||
> +		    moff == offsetof(struct bpf_tcp_ops, timeout_init))
> +			return NULL;
> +		return &bpf_sk_getsockopt_proto;
> +	case BPF_FUNC_get_retval:
> +		if (moff == offsetof(struct bpf_tcp_ops, timeout_init) ||
> +		    moff == offsetof(struct bpf_tcp_ops, rwnd_init))
> +			return &bpf_tcp_ops_get_retval_proto;
> +		return NULL;

Does this expose BPF_FUNC_get_retval with incorrect verifier bounds?

Looking at kernel/bpf/verifier.c's do_refine_retval_range(), it hardcodes
the assumption that bpf_get_retval() returns an errno. For BPF_FUNC_get_retval
it only exempts BPF_PROG_TYPE_CGROUP_SOCKOPT/BPF_CGROUP_GETSOCKOPT and
BPF_PROG_TYPE_LSM/BPF_LSM_CGROUP. Every other prog type falls into the else
branch that sets range = [-MAX_ERRNO, 0] and then calls
reg_set_srange64()/reg_set_srange32() on R0, which *assign* the range rather
than intersect it.

The value bpf_tcp_ops_get_retval() actually returns is the chained int from
bpf_tramp_run_ctx.retval, which for these two members is positive by design:

tcp_timeout_init() seeds it with tcp_call_bpf(BPF_SOCK_OPS_TIMEOUT_INIT) (a
timeout in jiffies) and tcp_rwnd_init_bpf() seeds it with the receive window
in packets. Each earlier bpf_tcp_ops program in the cgroup chain overwrites
it with its own positive return value.

Two consequences:

1. Functional: a program that inspects the chained value with a positive test,
   e.g. 'v = bpf_get_retval(); if (v > 0) return v; return my_default;', has
   the 'v > 0' branch proven dead and hard-wired away by
   opt_hard_wire_dead_code_branches(). The documented chaining semantics
   silently stop working at runtime instead of failing to load.

2. Verifier soundness: because the bound is asserted not enforced, a program
   can launder a large positive value into a register the verifier believes
   is negative. For example:

   long v = bpf_get_retval();
   if (v < -100)
       return 0;
   arr[-v] = 1;  /* out-of-bounds access */

   This passes bounds checking with smin/smax in [-100, 0] while -v is a
   large negative/positive value at runtime, giving an out-of-bounds map or
   stack access.

Could this be addressed by either introducing a new helper with its own
func_id (so do_refine_retval_range() does not apply), or exempting
BPF_PROG_TYPE_STRUCT_OPS for BPF_FUNC_get_retval in do_refine_retval_range()?

> +	default:
> +		return bpf_base_func_proto(func_id, prog);
> +	}
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35271288839
--===============7605950183679678339==--
