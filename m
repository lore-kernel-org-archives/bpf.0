Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1B472F73;
	Thu, 13 Aug 2026 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625963; cv=none; b=cz8pn11FkcY/d2gC/PvK3jmi1Jhq675UkTv5Qdxk2itY0vuWRsgggcAB8CZghmJgK/Ko0ortGrgNpT8XoK/tv9Zwxjaj+kkXJaxiRCLaklDmdXMsDCYNOhVULu2tKXH7GBkf6t87EVTIIOwzdfAb59+WdOQ8s8y5owpjSnMRJps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625963; c=relaxed/simple;
	bh=R/TdCUsGnnRJ8S21ArMI8rn0BaNeYJp35glrrlC16XQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pDA9/AD1fhHVTOHSznAnbcnYWg/snuInmjpD5qNZUkDqGfnX7XuI5KCKAk8lXjmDkjBWch9RN4riW/kbyVNLLayqzzbRYCGDx/P2bBEJyWasOKIqgSyPW3Xf68nSVS0/46CYe6pLS8ULOzCh9F2xnAOqP6mx2HQE3IsEjpB2myE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug4Wx3lq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug4Wx3lq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FE21F000E9;
	Thu, 13 Aug 2026 12:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786625962;
	bh=TvTpj7DmndHOysVuNmn1xL06iJe2TyCYeqaPXMp9bhs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ug4Wx3lqVl6THcsM+gpAVPWX0luAKyFYJGGGLMzIjbTnqAsgW+2L189nR1wBiLes2
	 08K28ykvEk+Q6LRCngwW42pdFxVWXcb7E5N08QhsqWt1+XA/zCCNJOmuorWL/kjE8S
	 lbO/LxxLE5b+Ja8w3cZ/v0QcOL/RVQ45GerUeF/c4vfjbmW3cRnKbKnsepKdVdDj38
	 Qg6taeB5LDMdMLtrlZ8/SQNqrdh8ohaXESrdIlNKSmjhzZkdDsBraQoqitawMOmxiF
	 u3dkDzQpiNlJGbHt21x8kg5bpEpN/wc502TVevxu5tJEzQWBXSGW4US8kQ3NN5rbQw
	 uKprrlUSo+46A==
Content-Type: multipart/mixed; boundary="===============1528963269429470544=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0cff49d1e60dd2651d7c93beb8e5594bdea638548a3136204d588cbfda11c826@mail.kernel.org>
In-Reply-To: <20260813112039.247862-1-maze@google.com>
References: <20260813112039.247862-1-maze@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Support cgroup {get,set}sockopt hooks for compat syscalls
From: bot+bpf-ci@kernel.org
To: maze@google.com,zenczykowski@gmail.com,ast@kernel.org,daniel@iogearbox.net
Cc: netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,maze@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 12:59:21 +0000 (UTC)

--===============1528963269429470544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ffd96e8b920bd..15f712b5b1645 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7616,6 +7616,7 @@ struct bpf_sockopt {
>  	__s32	optname;
>  	__s32	optlen;
>  	__s32	retval;
> +	__s32	is_compat;
>  };

[ ... ]

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 8fbc942a1cc3a..910878e991a04 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

> @@ -2705,6 +2707,9 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
>  		else
>  			*insn++ = CG_SOCKOPT_READ_FIELD(optlen);
>  		break;
> +	case offsetof(struct bpf_sockopt, is_compat):
> +		*insn++ = CG_SOCKOPT_READ_FIELD(is_compat);
> +		break;
>  	case offsetof(struct bpf_sockopt, retval):
>  		BUILD_BUG_ON(offsetof(struct bpf_cg_run_ctx, run_ctx) != 0);

Appending __s32 is_compat to struct bpf_sockopt grows the UAPI structure
from 40 to 48 bytes due to 8-byte alignment required by the __bpf_md_ptr()
unions. This creates 4 bytes of unoccupied tail padding at offsets 44-47.

Can the verifier accept a 4-byte load at ctx offset 44?

Looking at cg_sockopt_is_valid_access() in kernel/bpf/cgroup.c, the bounds
check allows any offset under sizeof(struct bpf_sockopt), with alignment:

	if (off < 0 || off >= sizeof(struct bpf_sockopt))
		return false;
	if (off % size != 0)
		return false;

A 4-byte load at offset 44 passes (44 < 48, 44 % 4 == 0), but
cg_sockopt_convert_ctx_access() above has no case for offset 44 and no
default arm. When bpf_convert_ctx_accesses() sees zero instructions
returned, it calls verifier_bug() and triggers WARN_ONCE under
CONFIG_DEBUG_KERNEL, letting any user with cgroup-sockopt load permission
trigger a kernel warning via a BPF_PROG_TYPE_CGROUP_SOCKOPT program with
r0 = *(u32 *)(r1 + 44).

Before this patch every accepted offset had a matching conversion case:
offsets 0-23 (pointer fields) require size 8, and 24, 28, 32, 36 (level,
optname, optlen, retval) were all handled; sizeof was exactly 40 with no
tail padding.

Should the hole be reserved in the UAPI struct (e.g. __u32 :32 or a named
reserved field) and rejected in is_valid_access, or should
cg_sockopt_convert_ctx_access() add an explicit case list or default arm
to reject non-enumerated offsets?

[ ... ]

The patch updates __cgroup_bpf_run_filter_getsockopt() to accept compat
and populate ctx.is_compat, but __cgroup_bpf_run_filter_getsockopt_kern()
was not updated.

This matters because __cgroup_bpf_run_filter_getsockopt_kern() is the only
hook that runs for getsockopt(TCP_ZEROCOPY_RECEIVE). The outer
BPF_CGROUP_RUN_PROG_GETSOCKOPT in do_sock_getsockopt() is bypassed for
that optname via tcp_bpf_bypass_getsockopt(), and do_tcp_getsockopt()
instead calls BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN() at net/ipv4/tcp.c.
Unlike the two hooks this patch fixes, that kernel-side hook was never
gated on compat, so it already ran for 32-bit callers.

Now it reports ctx->is_compat == 0 for them, violating the documented
contract that the field is "1 for compat syscalls and 0 otherwise." A BPF
program that keys its optval layout decisions off ctx->is_compat will
misparse the compat struct tcp_zerocopy_receive request from a 32-bit task.

Should compat be threaded into
__cgroup_bpf_run_filter_getsockopt_kern() as well, or at minimum should the
documentation clarify that is_compat is unreliable on the kern hook?

[ ... ]

This looks like a bug fix for code introduced in 55db9c0e8534 ("net: remove
compat_sys_{get,set}sockopt"). Should this include:

  Fixes: 55db9c0e8534 ("net: remove compat_sys_{get,set}sockopt")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31696027015
--===============1528963269429470544==--
