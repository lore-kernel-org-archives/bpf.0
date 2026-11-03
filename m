Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699656;
	b=wzSNVPsJz26W67Y9qC/tlqaML/5w3odo66qEIwLCaGRKwKzoS46aaHabUh0EOnpAUawe
	 UXAzZ54hcGxnboUOKI4Ux8YHzMf9VK3k+U+7TTbVaGp7CKKuWrXygCngqsxNwjB7npgY4
	 TLw8kWZLbVDl2aSRho0cDASbTztPTpsqBYBhYSxy0B65ZhmaUahMJhgXKsxNccvNVtRhX
	 I5LItqfJKLkvRqA3XwFDjMPLg6LIgA34k6WepoTxzuUau5MeIj/1W8AUsZhc3Nm2+vT2H
	 xVKXho5Wl4GDn0O1UqD8d3uEPPgUm6wUi+NDi4tYmeUZ9qd/cDRELK/4xacmtuaUpBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699656;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GM3SqG7BK1zP8y6kzedvjOBhXxI8GlFNtGrpW7qR3bo=;
	b=jsqZGHuTTJ3VuVI5MJt/imiQYqCrd9Zv+qHSS1hbM3Q81XdAxOOaZ//QpVi8j403MsaG
	 0weu7tiYy1LrMYV8jPsrn+XDEu/UjrmYlh6yt8KtRIyoZs1xril2SHyHDzk/t5sgLrMW5
	 2mJTg2RnIrwz+ZQDkPzUni+ApTVjSWnU6MYV4ZCJqfqAHHtOGuENrwQVBSwPmXtWL3RK/
	 HyFHP0nHajVrBQaZOTkhpURfXcdf78AYUgbWxq2UMo6OAle2oqs2VdH60k12Tgl9CzAkb
	 sfC99Fn5nu+3WhntUPmPV/ZKpmDzGsE/u4CeuayoyEvE8mfd/ijCmw3lvcQNVvL9r8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHqRKbrN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160A60A2619
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHqRKbrN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1951F00A1F;
	Tue,  3 Nov 2026 09:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699656;
	bh=GM3SqG7BK1zP8y6kzedvjOBhXxI8GlFNtGrpW7qR3bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UHqRKbrNtBfr7GRy3a4Y44HP6guCp3cax7N9uwkwbEJByGuxXW8aI3s8lpC+2igEO
	 3eky5oArCEBgOY7mJDjTx0yDSrG4Sz/+sShmMil3YUrEWWJIjVG6O69Gx5cDvwYFkQ
	 fmkyCDdRvfvvNHWJIwq/OZS1PJURIuRRlxGgslrLMz+o2wGRO24Lemh+KkxGvZpOzN
	 jmraWIohGeLMzCyHUVDju9kfUaHSwiDjWseaREmEwBrX9M5XcdhiQR8HkRyp1g/9d/
	 mWAWuo5UUwERUeDZtX93jKIvBrGP1zEElAr2qjwhh4BQi2zh8egOPu1zMEkerBeFj3
	 CXmxWzSVNXJaw==
Message-ID: <sashiko-outbox-194982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/4] libbpf: Detect BPF_TRACE_UPROBE support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261103093400.112178-4-jolsa@kernel.org>
References: <20261103093400.112178-1-jolsa@kernel.org>
 <20261103093400.112178-4-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:54:15 +0000
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
- [Medium] libbpf: broken BPF_TRACE_UPROBE detection in probe_kern_uprobe_a=
ttach_type()
--

commit daaaf792d9bbc9ce6b848daf8f14739d2eddbab7
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Detect BPF_TRACE_UPROBE support

This commit probes whether the kernel supports BPF_TRACE_UPROBE as the
expected attach type for BPF_PROG_TYPE_KPROBE programs and sets it for
uprobe, uretprobe, and usdt sections when supported.

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index adb5d2e7fdfa2..175d96c0a5012 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -318,6 +318,24 @@ static int probe_kern_exp_attach_type(int token_fd)
>  	return probe_fd(fd);
>  }
> =20
> +static int probe_kern_uprobe_attach_type(int token_fd)
> +{
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts,
> +		.expected_attach_type =3D BPF_TRACE_UPROBE,
> +		.token_fd =3D token_fd,
> +		.prog_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
> +	);
> +	struct bpf_insn insns[] =3D {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	int fd;
> +
> +	fd =3D bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns,
> +			   ARRAY_SIZE(insns), &opts);
> +	return probe_fd(fd);
> +}

[Severity: Medium]
Does probe_kern_uprobe_attach_type() actually detect whether the running
kernel supports BPF_TRACE_UPROBE?

In kernel/bpf/syscall.c, bpf_prog_load() does not reject
attr->expected_attach_type >=3D __MAX_BPF_ATTACH_TYPE, and
bpf_prog_load_check_attach() has no case for BPF_PROG_TYPE_KPROBE, so it
falls through to the default branch and returns 0:

kernel/bpf/syscall.c:bpf_prog_load_check_attach() {
    ...
	case BPF_PROG_TYPE_SYSCALL:
	case BPF_PROG_TYPE_EXT:
		if (expected_attach_type)
			return -EINVAL;
		fallthrough;
	default:
		return 0;
	}
}

Because BPF_PROG_LOAD has accepted any expected_attach_type value for
BPF_PROG_TYPE_KPROBE since Linux 4.17 (when token_fd is 0),
probe_kern_uprobe_attach_type() will return 1 even on older kernels that do
not know about BPF_TRACE_UPROBE.

When bpf_object__load() -> bpf_object_load_prog() ->
libbpf_prepare_prog_load() then sets prog->expected_attach_type and
opts->expected_attach_type to BPF_TRACE_UPROBE on those older kernels:

tools/lib/bpf/libbpf.c:libbpf_prepare_prog_load() {
    ...
	if ((def & SEC_UPROBE) && kernel_supports(prog->obj, FEAT_UPROBE_ATTACH_TY=
PE)) {
		prog->expected_attach_type =3D BPF_TRACE_UPROBE;
		opts->expected_attach_type =3D BPF_TRACE_UPROBE;
	}
    ...
}

can this cause regressions for existing programs? For example:

1. In kernel/bpf/core.c, bpf_prog_map_compatible() requires matching
expected_attach_type values for BPF_MAP_TYPE_PROG_ARRAY:

kernel/bpf/core.c:bpf_prog_map_compatible() {
    ...
		if (ret &&
		    map->map_type =3D=3D BPF_MAP_TYPE_PROG_ARRAY &&
		    map->owner->expected_attach_type !=3D fp->expected_attach_type)
			ret =3D false;
    ...
}

Sharing a tail-call map between a SEC("uprobe") program (loaded with
expected_attach_type =3D=3D BPF_TRACE_UPROBE) and a SEC("kprobe") program
(loaded with expected_attach_type =3D=3D 0) will now fail.

2. Callers checking bpf_program__expected_attach_type() will observe
BPF_TRACE_UPROBE on kernels that neither enforce uprobe-only attach nor
disable the private stack for BPF_TRACE_UPROBE.

3. If FEAT_UPROBE_ATTACH_TYPE is cached without a token and later used when
loading a program with a BPF token on kernels 6.9+ prior to
BPF_TRACE_UPROBE, bpf_token_allow_prog_type() in kernel/bpf/token.c will
reject the load because attach_type >=3D __MAX_BPF_ATTACH_TYPE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103093400.1121=
78-1-jolsa@kernel.org?part=3D3
