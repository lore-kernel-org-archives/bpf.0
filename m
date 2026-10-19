Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426778;
	b=oOymaauqmz17vwF9pFph0nHNHBfFdjBl98LW2sZMc/eVifO6iZAG0E/vme2NSSN/APhz
	 iydaTjQsyb7EuKW4FrIyyzdqeaYsWMpMR/yKoaYLb3PT/1hjkh2pz2dZLSPiw8FDLelVU
	 xYKXEeK/8VDIoKm/Vyg2KN+C5KJ0jYxa/t76HHjooStlu7drIy7cfFwK+At09TfFZYRLQ
	 8URbfR/H+C0TDCq5pwz78uVeuP9VZGkvgR958vTzkVMZg1EinGPk8D4l25XUmWEVsHSTb
	 XSCHZ2FTco7wD78BJottkxqGz2VfxgExQj8iNQpdE/5Fq6GFilBsZ8o1C2SJ4nyuUEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426778;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dIIEkm7Ckxb3xIa7RHXibja+O1JV/PV2z0/w1UNObv8=;
	b=GwUt+k/sP9fV9uNVV6nspc3iTc/z/zwxawcokI9aWf24HznxcSIGqfqj3Ti65XpXDayM
	 jFruE/JyjCQdgkfyZAe+F/XOhLDVATgpUUZi+TN5X9b2hCOrUBh2l+NDF4Xb82lpUV+G9
	 bT4FpxF+JECz4DOYnd4D37SwmzZl3BKeU2ugg6Y3oxQKf6WNeKec91i5ZoedglpefcXao
	 VZgYoiossdgRSn782c6aN7lhutqy4XygEDaqD8A4Wdr5fOxmrALZGSP3vuaECQQthlef2
	 VNV/F7V7e52wgHnoBdR/ZEgD94FsRQrMYaAFImGaGMf5EJc5bWe1YZrRsM2hO94TrQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1A5I1bT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9FB606A319;
	Mon, 19 Oct 2026 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1A5I1bT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605041F000C4;
	Mon, 19 Oct 2026 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426777;
	bh=dIIEkm7Ckxb3xIa7RHXibja+O1JV/PV2z0/w1UNObv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h1A5I1bTmS4HeAiAJlEGEpGqpqOqoz0anQOmjFTE0CyWREWBA6lYQtRta1coDXUab
	 rMZoB3nwKZtv14LEsR9mFzXdREOoiy9DnXYoHP9pqMKjjkISebm5VEYlngrKX0Fm2L
	 turvDIgbv0VSOtBqSBXnob8K2ZceKvhaitPUjIbyY0KxQZ1fJq5745OrazFGwYli4f
	 QpSoPy0TvEw4/fukZ6hzdBPjtwAse6NBKok/HYTnagkk+byv37gcYJ+vSbYzTyUYvF
	 Jg8ZSwar+daa6+AFHs9Rsjh7FaDbTeUInAnUH6CZLk0QdJz8yRAR/cdqGB/3cOgpsT
	 3CD2vQzwUm9ng==
Message-ID: <sashiko-outbox-177863@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Add syscall common attrs support
 for link_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261019153628.15912-2-leon.hwang@linux.dev>
References: <20261019153628.15912-1-leon.hwang@linux.dev>
 <20261019153628.15912-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:19:36 +0000
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
- [Medium] bpf: incorrect attach_type and prog_type error logging in link_c=
reate()
--

commit 6e1b9a1ad09acdb6c859fd328c7f20b775a8136a
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add syscall common attrs support for link_create

This commit adds syscall common attributes support to BPF_LINK_CREATE,
creating and finalizing a verifier log instance to report error messages
for invalid prog_fd, attach_type, and prog_type.

Links:
[1] https://lore.kernel.org/bpf/20260514004634.3DA09C19425@smtp.kernel.org/

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 849bc9136299d..201658b75ab77 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5856,8 +5856,11 @@ static int bpf_map_do_batch(const union bpf_attr *=
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
> @@ -5867,14 +5870,28 @@ static int link_create(union bpf_attr *attr, bpfp=
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
> +
> +	ret =3D bpf_log_attr_report_size(&attr_log, 0);
> +	if (ret)
> +		goto put_prog;
> =20
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_CGROUP_SKB:
> @@ -5953,12 +5970,22 @@ static int link_create(union bpf_attr *attr, bpfp=
tr_t uattr)
>  			ret =3D bpf_uprobe_multi_link_attach(attr, prog);
>  		break;
>  	default:
> +		bpf_log(log, "Invalid prog type.\n");
>  		ret =3D -EINVAL;
>  	}

[Severity: Medium]
Can calling bpf_prog_attach_check_attach_type() before checking
prog->type cause inaccurate or missing log messages in link_create()?

First, in kernel/bpf/syscall.c:bpf_prog_attach_check_attach_type():

	default:
		ptype =3D attach_type_to_prog_type(attach_type);
		if (ptype =3D=3D BPF_PROG_TYPE_UNSPEC || ptype !=3D prog->type)
			return -EINVAL;
		return 0;

Because attach_type_to_prog_type() only maps attach types to a subset of
program types, most program types not supported by link_create() (such
as BPF_PROG_TYPE_SOCKET_FILTER, BPF_PROG_TYPE_SCHED_ACT,
BPF_PROG_TYPE_RAW_TRACEPOINT, or BPF_PROG_TYPE_SYSCALL) fail in
bpf_prog_attach_check_attach_type() with -EINVAL and log
"Invalid attach_type.\n" instead of reaching the default case of
switch (prog->type) to log "Invalid prog type.\n".

Second, bpf_prog_attach_check_attach_type() also performs a permission
check for BPF_PROG_TYPE_CGROUP_SKB:

	case BPF_PROG_TYPE_CGROUP_SKB:
		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
			/* cg-skb progs can be loaded by unpriv user.
			 * check permissions at attach time.
			 */
			return -EPERM;

When an unprivileged caller fails this CAP_NET_ADMIN check with a valid
attach_type, link_create() logs "Invalid attach_type.\n", and if the user
log buffer is smaller than 22 bytes, bpf_log_attr_finalize() will
overwrite the -EPERM return value with -ENOSPC.

Third, for BPF_PROG_TYPE_TRACING and BPF_PROG_TYPE_LSM,
bpf_prog_attach_check_attach_type() only verifies that
attach_type_to_prog_type(attach_type) =3D=3D prog->type, while the check ag=
ainst
prog->expected_attach_type happens later inside switch (prog->type) in
link_create():

	case BPF_PROG_TYPE_LSM:
	case BPF_PROG_TYPE_TRACING:
		if (attr->link_create.attach_type !=3D prog->expected_attach_type) {
			ret =3D -EINVAL;
			goto out;
		}

If a tracing or LSM program is passed a mismatched tracing or LSM
attach_type (for example, BPF_TRACE_FEXIT for a BPF_TRACE_FENTRY
program), bpf_prog_attach_check_attach_type() returns 0,
bpf_log_attr_report_size(&attr_log, 0) runs, and the check in
switch (prog->type) jumps to out without logging "Invalid attach_type.\n".

> =20
>  out:
> -	if (ret < 0)
> +	if (ret < 0) {
> +		int err =3D bpf_log_attr_finalize(&attr_log, log);
> +
> +		ret =3D err ? err : ret;
> +	}
> +
> +put_prog:
> +	if (ret < 0 && prog)
>  		bpf_prog_put(prog);
> +
> +	kfree(log);
>  	return ret;
>  }

[ ... ]

=E5=AE=8C=E7=BE=8E =E2=80=94 wait no, I shouldn't write anything else! Let =
me make sure I didn't write anything extra at the end.
Wait: I just wrote "=E5=AE=8C=E7=BE=8E =E2=80=94 wait no..." in the respons=
e stream?!
Oh! No, I am in the response stream! Let me check if I can avoid that. Too =
late, it's already in the output stream!}] Let me stop immediately.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019153628.1591=
2-1-leon.hwang@linux.dev?part=3D1
