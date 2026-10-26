Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030810;
	b=s6hzQMRprcAMxtRY9oUv0LdlaWG53rqhCNg0WcK1Fq3JTPUFuJ0nxXdAd7T86ibOuLFu
	 eyxQQ0Iy52XhYgUEOqWIlTbpUho/o2bO6Wig+TBYl3qNwJ+pSGDzzVL2m9yaCpP4cTZkm
	 dSgIAwDtRKn1xiH+x3Ftvh07NTTCvH5y2RPPlMIqonHgpd229MaAx0sB5ehbdK03V4zAS
	 ZgXvgpMpDD3nmx/neP5HHtVl13bpbU+ZFlrUX42k3SMzc7NIzejdSMkS76/ph7zsxT+M2
	 izwuA2UUf7fITI5JgfhAcgnCJZ3IOoA5hu+BqZzLwEugVLI6hmYeX6MfUSegYEWsV7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030810;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q2504dBjupO3FBfjQT1IaeS/YKt4BaICmOiy1i+7Ec4=;
	b=VQ9jjnjNez4Hhw2gVoQK8QSLJFdh3bdL+IvQWtqoNUSNW/uQ9N7UODlS5nrvmlyc3e5/
	 5EcqoLl2vvyFNyqLIABIMMldLa4Iup9X4Iv8GUGW/cwc0FoMhRlofGMMn6M095RGaau44
	 QL3IKOufOiAqYJB5aP5UT8S64sSIGoxS9gHRXLklpT6Rvya5ibjzVUlxwqB8AoxQkvJhv
	 RNG83WI2L32G0+Pb6d69zyglYxjCd9bbwDTRoFlSK0nOOmXiwhHuEvwLtapM3onm1tYL8
	 OIrLBLjGVMZHSydjEcYDRnEXBAlxsyNPNWc06PgnvCXOIiYw6ZuJI7xuJ0NEsWLo1vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQ20mfiG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2816606A31F;
	Mon, 26 Oct 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQ20mfiG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9921F01828;
	Mon, 26 Oct 2026 16:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030809;
	bh=q2504dBjupO3FBfjQT1IaeS/YKt4BaICmOiy1i+7Ec4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AQ20mfiGtZB6uzWs7Kxushh1rsbLNtzWWtNTg+1AM+6Kut72rzNL++4+DmzHLg8WW
	 AwyeO58kYaYFYkMYNboo+1owtA8IVwWGDOPsilvCrBFA/3TF0Ial9ubyvEGBLVEZC2
	 F5OBtjwmRwPMXzgSMbnAIqPO4ZlVB7RsLx+pkOcEDOT3nQmI1eLsH0wuijOgkK7XCs
	 93nkffo/f4cHeiqJUL5c0Y7zxc0LEtqJwIvLNoYhwZnzlmpQyXEc4kSskW5/rt4EmC
	 KGYhLRDuq1HpOakJieO1oPYnoX31CeFGjkcP/ySCy7VDsmm/QF+jgEWLH5Ed2PpaiD
	 ME69Sff6PZ0BA==
Message-ID: <sashiko-outbox-185494@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 1/6] bpf: Add syscall common attrs support
 for link_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261026154948.99408-2-leon.hwang@linux.dev>
References: <20261026154948.99408-1-leon.hwang@linux.dev>
 <20261026154948.99408-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 16:06:48 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: inaccurate attach_type and prog_type error logging in link_=
create()
--

commit bc490436683f8010bb5c27c3e3a1582ddc24a909
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add syscall common attrs support for link_create

This commit adds syscall common attributes support to link_create() in
kernel/bpf/syscall.c, initializing and finalizing a bpf_verifier_log
instance to report errors for invalid prog_fd, attach_type, and prog_type.

Link: https://lore.kernel.org/bpf/20260514004634.3DA09C19425@smtp.kernel.or=
g/

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 90bc7230afa8a..db870e795d044 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5862,8 +5862,11 @@ static int bpf_map_do_batch(const union bpf_attr *=
attr,
>  }
> =20
>  #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.path_fd
> -static int link_create(union bpf_attr *attr, bpfptr_t uattr)
> +static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_=
common_attr *attr_common,
> +		       bpfptr_t uattr_common, u32 size_common)
>  {
> +	struct bpf_verifier_log *log;
> +	struct bpf_log_attr attr_log;
>  	struct bpf_prog *prog;
>  	int ret;
> =20
> @@ -5873,14 +5876,24 @@ static int link_create(union bpf_attr *attr, bpfp=
tr_t uattr)
>  	if (attr->link_create.attach_type =3D=3D BPF_STRUCT_OPS)
>  		return bpf_struct_ops_link_create(attr);
> =20
> +	log =3D bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, =
size_common);
> +	if (IS_ERR(log))
> +		return PTR_ERR(log);
> +
>  	prog =3D bpf_prog_get(attr->link_create.prog_fd);
> -	if (IS_ERR(prog))
> -		return PTR_ERR(prog);
> +	if (IS_ERR(prog)) {
> +		bpf_log(log, "Invalid prog_fd.\n");
> +		ret =3D PTR_ERR(prog);
> +		prog =3D NULL;
> +		goto out;
> +	}
> =20
>  	ret =3D bpf_prog_attach_check_attach_type(prog,
>  						attr->link_create.attach_type);
> -	if (ret)
> +	if (ret) {
> +		bpf_log(log, "Invalid attach_type.\n");
>  		goto out;
> +	}
> =20
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_CGROUP_SKB:
> @@ -5959,12 +5972,20 @@ static int link_create(union bpf_attr *attr, bpfp=
tr_t uattr)
>  			ret =3D bpf_uprobe_multi_link_attach(attr, prog);
>  		break;
>  	default:
> +		bpf_log(log, "Invalid prog type.\n");
>  		ret =3D -EINVAL;
>  	}

[Severity: Medium]
Does calling bpf_prog_attach_check_attach_type() before switch (prog->type)
in kernel/bpf/syscall.c:link_create() cause misleading or missing log
messages in a few cases?

First, for almost all program types that are unsupported by link_create()
(such as BPF_PROG_TYPE_SOCKET_FILTER, BPF_PROG_TYPE_SCHED_ACT,
BPF_PROG_TYPE_RAW_TRACEPOINT, or BPF_PROG_TYPE_SYSCALL),
link_create() -> bpf_prog_attach_check_attach_type() hits the default
branch:

kernel/bpf/syscall.c:bpf_prog_attach_check_attach_type() {
	...
	default:
		ptype =3D attach_type_to_prog_type(attach_type);
		if (ptype =3D=3D BPF_PROG_TYPE_UNSPEC || ptype !=3D prog->type)
			return -EINVAL;
		return 0;
}

Because attach_type_to_prog_type() never returns those program types for any
attach_type, bpf_prog_attach_check_attach_type() returns -EINVAL and
link_create() logs "Invalid attach_type.\n" instead of reaching the default
branch of switch (prog->type) to log "Invalid prog type.\n".

Second, for BPF_PROG_TYPE_CGROUP_SKB, bpf_prog_attach_check_attach_type()
also performs a capability check:

	case BPF_PROG_TYPE_CGROUP_SKB:
		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
			return -EPERM;

When this check fails with -EPERM, link_create() still logs
"Invalid attach_type.\n" even when attach_type is valid.

Third, for BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_TRACING,
bpf_prog_attach_check_attach_type() only checks that attach_type maps to the
general program type. The stricter expected_attach_type check happens inside
switch (prog->type) in link_create():

	case BPF_PROG_TYPE_LSM:
	case BPF_PROG_TYPE_TRACING:
		if (attr->link_create.attach_type !=3D prog->expected_attach_type) {
			ret =3D -EINVAL;
			goto out;
		}

If a caller passes an attach_type of the same program type that does not
match prog->expected_attach_type, link_create() jumps to out without logging
"Invalid attach_type.\n".

Should the program type validation and attach_type logging be ordered so
that unsupported program types, -EPERM failures, and expected_attach_type
mismatches report accurate messages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026154948.9940=
8-1-leon.hwang@linux.dev?part=3D1
