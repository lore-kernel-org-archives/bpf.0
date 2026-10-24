Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792857026;
	b=aegMvM7tK7fn4qNCMMXO5gYQaa+ZOsPbx042p44FG5tEZc0iKO4c6M9Fg02RxIIos6Ro
	 fWo7cvpIh1RVtjhW7f9u8MWBnpwMOQjviAyQ5y+4z/f3z4O/27mX1bJ8ByeNYvSdJJN41
	 LSJZtXycue4modZj/cZEg+t/guTjEDk0wDBWY5WTsfOsC3J/gllizOFZ4h36z2ZRrjQNQ
	 5SWYELBqFM4Cvm1w/vIkr2onDYSPH5ARaPM7Sj5tBRvvRXWDvk1abzBwVcVFzsCy7MeKp
	 izgpwaUg8SmqWtxTG7pRIWLhV4Nbwrll5rscHZJfWWHQ08pmbI/d8O2ueJIsAlR/6KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792857026;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QuEcmckjn1bH0vLDTThMnlHrk/QCYnuUxCX8RFo1zUQ=;
	b=I7qIIyoUbfyndmjsqFH+t8FN6cPRgpBJZQXqpwD/fgL9vAmb5XihJYMs6XXWNCPU8I05
	 I23vQRnHRkdEfL2GXJqPWgWBkI0Nq3OZ72wPibWcP/44R3EaRPb5fWGa6/2EyymLeyrxg
	 qDdTPEnTL0LrmtrJ4vZLzCgUZV/nENnC7+F4403+PH8K8Kl2pLL4YqXVZ/LyaPd858ls1
	 zpCcLPnorHIEU1BMVlvoDPlCVPl4IAKAXgPqypCMW8pXT7pD5+1750q870zSylr9mRL7b
	 NXZ9QOHhaTKOeasUHpvgfuBi1dKqrkUfBBrX7SGoV1P/LntmW0h/O1AMQnzttZGrnMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKBtCfiL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61506606A31A;
	Sat, 24 Oct 2026 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKBtCfiL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31ED1F01825;
	Sat, 24 Oct 2026 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792857026;
	bh=QuEcmckjn1bH0vLDTThMnlHrk/QCYnuUxCX8RFo1zUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OKBtCfiL88VqWQhLb7QMraDGHIOpsPV1wrPPhZ736VCqXnGPxcVCkhCwjh5Ouxe6U
	 WtUgO2He5xLqQDvb9NyWhvHQKg1fzH4SjA8aPKwACRUxoi+Myr8Qp3Yaw6U9G9TgT5
	 Ni1EoLA8Ej1xTeC3M5iMI1dQV5faD79b4o+qs1m58mI81nTXrMsAH+SS2OyspOalxw
	 ydz+SHNmArrlBlV1wpCtxY7u8rxUi6e3U4cMKHbFg0YK8EBMOlhh5cWpWHY+cHkzm9
	 +8vj99i7jcK85dMD2VoHWO3HPCjSerbDocMNI5bwxeoLPKnqzyW9+vWBdZyWWXonV5
	 UlA7LqiaqytHA==
Message-ID: <sashiko-outbox-183784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] bpf: Add syscall common attrs support
 for link_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261024153608.58569-2-leon.hwang@linux.dev>
References: <20261024153608.58569-1-leon.hwang@linux.dev>
 <20261024153608.58569-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 15:50:25 +0000
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
- [Medium] bpf: incorrect error log messages and ordering in link_create()
--

commit f2293d2ca04aeb83f219d17a0904b9b58058c572
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add syscall common attrs support for link_create

This commit adds syscall common attributes support to link_create(),
creating and finalizing a verifier log instance to report errors for invalid
prog_fd, attach_type, and prog type.

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
Can calling bpf_prog_attach_check_attach_type() before switching on
prog->type cause link_create() to log the wrong error message or skip
logging on mismatched attach types?

First, in kernel/bpf/syscall.c:bpf_prog_attach_check_attach_type(), a
cgroup skb program checks permissions before validating the attach type:

	case BPF_PROG_TYPE_CGROUP_SKB:
		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
			/* cg-skb progs can be loaded by unpriv user.
			 * check permissions at attach time.
			 */
			return -EPERM;

When that capability check fails, link_create() still logs
"Invalid attach_type.\n" even though attach_type may be valid.

Second, for program types that are not supported by link_create() and have
no mapping in attach_type_to_prog_type() (such as socket filter, sched act,
raw tracepoint, or syscall programs), bpf_prog_attach_check_attach_type()
hits its default branch and returns -EINVAL before link_create() reaches
switch (prog->type):

	default:
		ptype =3D attach_type_to_prog_type(attach_type);
		if (ptype =3D=3D BPF_PROG_TYPE_UNSPEC || ptype !=3D prog->type)
			return -EINVAL;
		return 0;

Doesn't that cause link_create() to log "Invalid attach_type.\n" and jump
to out, leaving the new default branch that logs "Invalid prog type.\n"
unreachable for almost all unsupported program types?

Third, for tracing and lsm programs, bpf_prog_attach_check_attach_type()
only checks that attach_type maps to prog->type in
attach_type_to_prog_type(), while the check against
prog->expected_attach_type happens later inside switch (prog->type) in
link_create():

	case BPF_PROG_TYPE_LSM:
	case BPF_PROG_TYPE_TRACING:
		if (attr->link_create.attach_type !=3D prog->expected_attach_type) {
			ret =3D -EINVAL;
			goto out;
		}

Should that mismatch also log "Invalid attach_type.\n"?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024153608.5856=
9-1-leon.hwang@linux.dev?part=3D1
