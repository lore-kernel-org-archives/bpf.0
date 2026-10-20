Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511099;
	b=Cdc+I7/Szbm5jtZJvDhoOiM9DWCWopGoHBVOWrsyh2MGbNu88ypgmAzIP+gp98U6XcgO
	 bi3u/ifZHe6PmTigaAabS949Uq/y9TnJDVBRzk9cfBJMVtZxbIKRXhzfzn8n8HuNN/PLz
	 Epph8g3nrDKVuXkuwNLtnVM40RFvNLVrbWpbg0xLuTQIls3ok+EwOLzngQFTuwhKc/v58
	 IOKkpyVeY+jEq/6VDtwAMwaQYgHDP7iK0mpfUSEA1motcNuTum0CA1jK1FbHr+cFKhJo9
	 Kn4xhh798GHEJCh5MHb1CDlh3RRC4RCdqGmKax2jgApVtThGKBPfeHROKndOyMZaKFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511099;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S94tQwLKrfcIMPTV4lryuRD1Ev5X46gOWY4v+tdNcUU=;
	b=bwLqDeyoXlZQQPQyyt9dONyQ8R1pdl82PyuxEuXnAf8ic0cU1/KNOetbfOcx6ggTZpcC
	 ur7MxnXkHgPKjGS5g8t4tzHJHopxdo0OHIdW+IfMw/gGB7OPqodTju+Y3SPNFSeZLd6Eb
	 4PoU0FC+/Y3VKg8tYeihQTAsRQvKLST/fGsy4GShMK0ExTPeLRXQFbr/0/M0m4Ab8llza
	 o0E+Mm9SpzJfAPQSQ/VPZnamqrVF3gT5iL2gTjKsD+eCV6d0y92cHfwIKzlQbPH12xlf5
	 QyKuJZbXUh/NooR2am75xmuvhvNqSQ4uq/3Qb1jlrOgXZgYKQPmeaxxHH0J3iKnPi1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7A606A325;
	Tue, 20 Oct 2026 15:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10651F000C5;
	Tue, 20 Oct 2026 15:44:58 +0000 (UTC)
Message-ID: <sashiko-outbox-179280@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Add syscall common attrs support
 for link_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261020152804.39863-2-leon.hwang@linux.dev>
References: <20261020152804.39863-1-leon.hwang@linux.dev>
 <20261020152804.39863-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:44:28 +0000
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
- [Medium] bpf: misreported attach_type and prog_type errors in link_create=
()
--

commit 64df6223de5ef67537b774b5db553b0530d3bf6e
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add syscall common attrs support for link_create

This commit adds syscall common attributes support to link_create() so that
an internal verifier log instance is created and finalized to report error
messages for invalid prog_fd, invalid attach_type, and invalid prog type.

Link: https://lore.kernel.org/bpf/20260514004634.3DA09C19425@smtp.kernel.or=
g/

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 849bc9136299d..61d100e794b45 100644
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
> @@ -5867,14 +5870,24 @@ static int link_create(union bpf_attr *attr, bpfp=
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
> @@ -5953,12 +5966,19 @@ static int link_create(union bpf_attr *attr, bpfp=
tr_t uattr)
>  			ret =3D bpf_uprobe_multi_link_attach(attr, prog);
>  		break;
>  	default:
> +		bpf_log(log, "Invalid prog type.\n");
>  		ret =3D -EINVAL;
>  	}

[Severity: Medium]
Does calling bpf_prog_attach_check_attach_type() before checking prog->type
in link_create() cause unsupported program types and permission errors to
be misreported as "Invalid attach_type." instead of reaching the default
"Invalid prog type." branch?

In kernel/bpf/syscall.c, bpf_prog_attach_check_attach_type() handles any
prog->type not explicitly listed in its switch via:

kernel/bpf/syscall.c:bpf_prog_attach_check_attach_type() {
	...
	case BPF_PROG_TYPE_CGROUP_SKB:
		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
			return -EPERM;
	...
	default:
		ptype =3D attach_type_to_prog_type(attach_type);
		if (ptype =3D=3D BPF_PROG_TYPE_UNSPEC || ptype !=3D prog->type)
			return -EINVAL;
		return 0;
}

This leads to three cases where the logged message does not match the actual
failure:

1. When a caller passes a valid prog_fd for an unsupported program type
(such as BPF_PROG_TYPE_SOCKET_FILTER, BPF_PROG_TYPE_SCHED_ACT,
BPF_PROG_TYPE_RAW_TRACEPOINT, or BPF_PROG_TYPE_SYSCALL),
attach_type_to_prog_type() never returns that prog->type. As a result,
bpf_prog_attach_check_attach_type() returns -EINVAL, and link_create() logs
"Invalid attach_type.\n" and jumps to out, leaving the default "Invalid prog
type.\n" branch unreachable for almost all unsupported program types (except
BPF_PROG_TYPE_LIRC_MODE2 when CONFIG_NET=3Dy, or networking types when
CONFIG_NET=3Dn).

2. For BPF_PROG_TYPE_CGROUP_SKB, bpf_prog_attach_check_attach_type() checks
!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN) and returns -EPERM.
Because link_create() unconditionally logs "Invalid attach_type.\n" whenever
bpf_prog_attach_check_attach_type() returns non-zero, a permission failure
with a valid attach_type also logs "Invalid attach_type.\n".

3. Conversely, for BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_TRACING,
bpf_prog_attach_check_attach_type() only verifies that
attach_type_to_prog_type(attach_type) =3D=3D prog->type. If a caller passes=
 an
attach_type in the same family that does not match prog->expected_attach_ty=
pe
(for example, BPF_TRACE_FEXIT for a BPF_TRACE_FENTRY program), it passes
bpf_prog_attach_check_attach_type() and fails later in link_create():

	case BPF_PROG_TYPE_LSM:
	case BPF_PROG_TYPE_TRACING:
		if (attr->link_create.attach_type !=3D prog->expected_attach_type) {
			ret =3D -EINVAL;
			goto out;
		}

which jumps to out without logging "Invalid attach_type.\n".

[ ... ]

>  	return ret;
>  }

[ ... ]

>
> --=20
> 2.51.2
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020152804.3986=
3-1-leon.hwang@linux.dev?part=3D1
