Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505065;
	b=bhWl27jHBctJ0Vv/gN/+WZY96+VZ874QloU5oHDSImWUIGIc7D4ljIMQy+52AOwVUGhO
	 GJSHfCU6EzqpZ4jB7bLKI8LxY1q+PyQUWUpYjVXqXTJmHiDecKkrzDbgFGgVAKyN1CZn5
	 LPN3lMd8zAjQ1oZfJhBSXvQNOpWzMQlZX1e4kRdvUNiG9Vt25m8Dl6fkgXXAJ8nZDntvW
	 EfTZZwo+PwVIl8id7rjk4otMJK9NMgu7ayuwb6L0sv/PJ06ZFAu7Ac91iMyxeZn5eUqaE
	 Mf/HsvZrAtbCxYC3K71iuu76HQNkXRsPFMIUhuHHgR6AfpuA5BKkX+dSY1pRKnrNfEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505065;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7r2+jmI9yLt+HU7/91BGv76dGLIgtVNmcuy+6F4aKzs=;
	b=4tPX8WbbL05RQnb/1NGrVkUwh0SzZfg0E5M3TQ8EI3hC4sKAbhp40pMLsxBGFe+Vknr3
	 /dR4fB5Wc7KIYhOMUBQYpNWdm0UKt3PbdVtc4Wve2z0k0IUloEv0wb13oMrihX4qZGrRY
	 PMrxolTYVhsybTnVUQDcL3x5yVp9vggok+rhsAr2eMqmcqVyaGy3E1JJxemFDYLO5uUyi
	 EGZwj0mkKYyazpfJ2qnFtXiN/yHVzP++dDQFoabb1Uzv1HY5t+eAEy0HSvWDqxhUQmrg8
	 oROEfSfI6piedMtGSikMaccKV/Z59U79NZcJckMp3dC2CW9ccvOG9qL77UJceTQmfYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3ehGHNV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D3606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3ehGHNV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EC11F000C4;
	Tue, 20 Oct 2026 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505064;
	bh=7r2+jmI9yLt+HU7/91BGv76dGLIgtVNmcuy+6F4aKzs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=d3ehGHNVV3ov7v5VqIZwAKN/3bHF8eDiWt5SkrI1vgWN8r6i9nR5r4u/V+POYk0pk
	 iz78b5RdDYo6U9nxaV4cDv2Oms9gwrmVjGbZF6n3UQKpFMXa8a7f2ls+Mr2OU+tf54
	 pzy2lBQ2RaT/Nsa4IyIjGCf8GizNmBCe3rqfvC6JvDTMr3nBLbhJroIkIsW8p4oY97
	 MdCwpM5cpgfCixQmFy1fWmtbhEijAoh+licR1EBxTvyhhT3Uc/i99NGBKL+iHfMiaZ
	 Ttr8QfO5GnG4JEiDCOcjat109SxlsIevSuTemvceY4hBN3FjfWJn6Oc3AMaXdrgymQ
	 +jX6Lrj7vjScg==
Message-ID: <sashiko-outbox-179079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 05/16] libbpf: Add the arena percpu chunk
 attribute to map creation options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
In-Reply-To: <e596c9878df94ac93c172d93106c8ebd2dac4bb7.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
 <e596c9878df94ac93c172d93106c8ebd2dac4bb7.1792503001.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:04:23 +0000
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
- [High] libbpf: ABI break in struct bpf_map_create_opts from field inserti=
on
--

commit c57f05a60ad40accdc31f88eec3828c5149f9136
Author: Xu Kuohai <xukuohai@huawei.com>

libbpf: Add the arena percpu chunk attribute to map creation options

This commit adds arena_percpu_chunk_off and arena_percpu_chunk_sz to
union bpf_attr and struct bpf_map_create_opts, and populates them when
creating an arena map.

> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 826d9cc9ab65d..15a544488eb59 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -70,6 +70,10 @@ struct bpf_map_create_opts {
>  	const void *excl_prog_hash;
>  	__u32 excl_prog_hash_size;
> =20
> +	/* offset and size of an arena percpu chunk */
> +	__u32 arena_percpu_chunk_off;
> +	__u32 arena_percpu_chunk_sz;
> +
>  	struct bpf_log_opts *log_opts;
> =20
>  	size_t :0;

[Severity: High]
Does inserting arena_percpu_chunk_off and arena_percpu_chunk_sz before
log_opts break binary compatibility for struct bpf_map_create_opts?

struct bpf_map_create_opts is a size-versioned LIBBPF_OPTS structure
validated and accessed through OPTS_VALID() and OPTS_GET() in
bpf_map_create():

tools/lib/bpf/bpf.c:bpf_map_create() {
	...
	if (!OPTS_VALID(opts, bpf_map_create_opts))
		return libbpf_err(-EINVAL);
	...
	attr.arena_percpu_chunk_off =3D OPTS_GET(opts, arena_percpu_chunk_off, 0);
	attr.arena_percpu_chunk_sz =3D OPTS_GET(opts, arena_percpu_chunk_sz, 0);

	log_opts =3D OPTS_GET(opts, log_opts, NULL);
	if (!OPTS_VALID(log_opts, bpf_log_opts))
		return libbpf_err(-EINVAL);
}

Prior to this change, log_opts was the last field in struct
bpf_map_create_opts (at byte offset 72 on 64-bit platforms, with
sizeof(struct bpf_map_create_opts) =3D=3D 80) and
bpf_map_create_opts__last_field was defined as log_opts:

tools/lib/bpf/bpf.h:
	struct bpf_log_opts *log_opts;

	size_t :0;
};
#define bpf_map_create_opts__last_field log_opts

Placing arena_percpu_chunk_off (offset 68) and arena_percpu_chunk_sz
(offset 72) ahead of log_opts shifts log_opts to offset 80 (with
sizeof(struct bpf_map_create_opts) =3D=3D 88).

If an existing binary compiled against the previous struct
bpf_map_create_opts layout (opts->sz =3D=3D 80, log_opts at offset 72) calls
the updated bpf_map_create(), OPTS_GET(opts, arena_percpu_chunk_sz, 0)
will read the lower 32 bits of the caller's log_opts pointer into
attr.arena_percpu_chunk_sz, while OPTS_GET(opts, log_opts, NULL) will see
opts->sz < offsetofend(struct bpf_map_create_opts, log_opts) and silently
drop log_opts.

Conversely, if a binary compiled against the new header sets
arena_percpu_chunk_sz and runs against an older libbpf.so, the older
bpf_map_create() will read the 32-bit arena_percpu_chunk_sz value at
offset 72 as a non-NULL struct bpf_log_opts *log_opts pointer and
dereference it in OPTS_VALID(log_opts, bpf_log_opts).

Should arena_percpu_chunk_off and arena_percpu_chunk_sz be appended after
log_opts, with bpf_map_create_opts__last_field updated to
arena_percpu_chunk_sz?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792503001.gi=
t.xukuohai@huawei.com?part=3D5
