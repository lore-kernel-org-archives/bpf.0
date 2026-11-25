Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580904;
	b=shq6EhpdmexbECcpaSd1lyO13EK9SsO0srUdN3NqStNUTzjcN6GttWU2CMbdxwJ8/oTA
	 ffGgljaxPJxl6X6D+meTlcyEGD1yamdlupV/nkHeK8ohtXA7NoDDPYvHpAoF3DYEDr/GP
	 P9sVILRAy1nSiwI7QoJaRMAQUNnU3x9vEbqkIswLqoiOSq3cFFEtZaR47FWT/O8WbC/3o
	 l5S+nqAmWeGzW0o0bhhXGk27q6YqOuDbVLMPiBpFAR4RSTL7h9BdbQyf43/wKxVPKATXa
	 DGU6ZIxLdawGLXENReSr9t7cykV3SBDFDMTDBJWWiCaZzcB2TQHBc0tgRIQj91VTaPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580904;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=AZPvKTf8eqmcYptOR83OKtkpr1wNg5Qvak36Nb1Z0bY=;
	b=miZpeotBeC5gtyK7FMrta/49TOH18gEy5CEkoOhSN7IilcDNcavOB+FY3hCQImdWypbx
	 fQVnleDvMzWMU1oWTjGOD2+OJmLXhL2h1CeUvjdrFEmaKuEEtO/0iXoHmlIR3Xf+xrvZb
	 Vy2wlOW9s7OImXkRSMeUvSjLfxTCV/gSc6toNNzZ2eV+GJib232fZzq3QBZ1oMiYkle8+
	 e1wASGGPTlSKHEVIpeA7JxB7hRrzZdUOfED6QX662OkM0mC7bH8UJ1wY4AjfmfY8acG5b
	 J2fOdR7CIdorS70RYe09G3OxJQWNt7BRbQJfbV4dnb1Q80V1WG8raHevTQJuu9LBStA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ma0Up4NT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF6606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ma0Up4NT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7691F000CA;
	Wed, 25 Nov 2026 04:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795580903;
	bh=AZPvKTf8eqmcYptOR83OKtkpr1wNg5Qvak36Nb1Z0bY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ma0Up4NTnSO70mhLw1YMN92GIE5p0RLIJkWHT6WFt/UD83MbW50BuwG6sy+JReizL
	 Sq0VcolRuvTvfzGAzQ+4E5DcDwcIx7I3PclETcDKZjfVASh1woCQORK9ABwBqwy9sw
	 6yeFis97xImqgGl446sB8eckBza2bTm0Mg7clbd2gyjQ2bF1Kygp1gBNpidb1VaEWy
	 8UP4Z8MFHu8nl82eUwHOH/qFgH4/+HhT6h4jfOWTUytY/DKYAEEgyOUcqOSY27YttL
	 fkMPcRARFj9FsQSojThGzO8wwm5PoV1l1T2uLMlRoyWFifdxLWgYalS56IZ+Y2lMra
	 bc9gQXJEFDYsA==
Content-Type: multipart/mixed; boundary="===============8627883770755827572=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <36e5f45950b698ea8f3223f6fe87b10c0c3e77fbcb7b2a2473fa26fbfd0b6a91@mail.kernel.org>
In-Reply-To: <20261125032938.670542-8-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-8-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 07/47] bpf: Compare what a hook tells next to its prototype at tail calls
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 04:28:22 +0000 (UTC)

--===============8627883770755827572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Compare what a hook tells next to its prototype at tail calls

TL;DR: bpf_prog_hook_key() is 0 for fentry/fexit on kernel functions, so a
prog using bpf_d_path() may share a prog array with one on a function sharing
its prototype that disallows it, possibly causing a use-after-free.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> +/* What the verifier took from the hook, next to its prototype */
> +static u64 bpf_prog_hook_key(const struct bpf_prog *fp)
> +{
> +	if (IS_ENABLED(CONFIG_BPF_SYSCALL) && fp->aux->attach_btf_trace)
> +		return btf_raw_tp_null_mask(fp);
> +	if (fp->type == BPF_PROG_TYPE_TRACING && fp->expected_attach_type != BPF_TRACE_ITER)
> +		return fp->aux->saved_dst_ctx_type;

For fentry/fexit on a kernel function, saved_dst_ctx_type is always 0, so
two such programs are compatible whenever they share the same FUNC_PROTO.

The commit message says "tracers of kernel functions, share a prog array as
before", but the verifier does assume something about the hook for these
programs.  bpf_d_path_allowed() depends on attach_btf_id and on
expected_attach_type:

    if (btf_id_set_contains(&btf_allowlist_d_path, prog->aux->attach_btf_id))
        return true;
    if (btf_id_set_contains(&btf_allowlist_d_path_fentry, prog->aux->attach_btf_id))
        return prog->expected_attach_type == BPF_TRACE_FENTRY;

filp_close() is allowed for every attach type, while filp_close_sync() is
allowed for fentry only.  Both have the prototype
int (struct file *filp, fl_owner_t id), so they share one FUNC_PROTO and
the same attach_func_proto.

Consider program X attached with SEC("fexit/filp_close_sync"), where
bpf_d_path() is refused, and which calls bpf_tail_call().  It becomes the
owner of the prog array in bpf_check_tail_call() with TRACING, FEXIT, the
shared proto and hook_key 0.

Program Y attached with SEC("fexit/filp_close") calls
bpf_d_path(&f->f_path, ...), which is allowed for it.  Inserting Y passes
__bpf_prog_map_compatible(): same type, same expected_attach_type, same
attach_func_proto, hook_key 0 == 0 and st_ops NULL == NULL.

Y can then run at the exit of filp_close_sync() and call d_path() on a path
that may already be freed.  vfs_getattr() (allowlisted) and
vfs_getattr_nosec() (not allowlisted) also share one prototype.

Should the key for tracers of kernel functions include what
bpf_d_path_allowed() decided, or should the statement in the commit message
be narrowed?

> +	if (fp->type == BPF_PROG_TYPE_TRACING || fp->type == BPF_PROG_TYPE_LSM)
> +		return fp->aux->attach_btf_id;
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45542192835
--===============8627883770755827572==--
