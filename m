Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621574;
	b=vlGS369bC8bDtD4ZUZ5IxYpWU2hVTcyhclmpOwOapAwggg28zzrMH6sDLRMPwPWCpA5a
	 NkSyPpNY+sEp1xec/b8+TkoUxHLtmwxJL3zDlGj5vstWKzTD0rm7QKtJeYxDH56GRizgR
	 x0dX0SUWjtVxwqTgNR/xjNHpB9hU5YLobqqF/xOMv6zUZC0rZVMEc0X0bBmDC8ghR6XT5
	 ZUnwTI/0sRIjjOaFT8iBvyF0MPA6S+KB++a3H0hCT3CtqPdwV0kQxCYscegi/gPP5DqXZ
	 PX/B+BuykpycQMZXABds0FV/Ezrnkg5wVIJSEiFRYoO9nsT+TXMX8r+jFUNKPbG/ekw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621574;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UGrMKZcxC/h2RUOSIJsCodcyf1+2iV6Gk9ph4yXhKIE=;
	b=YdccScnZi1gtSnXdX/b+toFOeaVSSdUYbujGtTgzCPEH4fycr8XDTjYJjds+k6hJv4KL
	 rPmH28/1Pq8avTS80NnOYTAlaa0XW+UmbpME6TnJZ2trOsMpoCSnSrlHoUm47YSJYzOZP
	 0nfZfa7Jn+boCog5zJ9GemTSfc6C5lkLxT+lDl2FcajVB/rqYQ+qXdCRO30WsN2w9yYH7
	 DCtIZPlaktYejwo5hiQcMwubJxYJ12dIWDN1EDAt47dHg7NXSiiBVZNuuGio3w1MaOS/E
	 yxACHrE6vsaIquHzrGajn27j0gsdun1QMdinw3W+Mdv0oY2FEqZJm5CaXNHVSY4hnrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGMlyZfj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A3606A32C
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGMlyZfj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0341F000CA;
	Wed, 25 Nov 2026 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621573;
	bh=UGrMKZcxC/h2RUOSIJsCodcyf1+2iV6Gk9ph4yXhKIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LGMlyZfjEl2E8CzRUL+V/SpmodfjVCoMTcXpIdSTk0Bkaol/FtXyJBEaqcXUobUrK
	 7Azj6OSMTNR3la9MBD0YLFrBtr3xIDEg1rreY/PmLNF86o4WG+QiSIIhtkoHwrEmyD
	 zB2e4RdX6pkK4xyBoBzdAYH7tBN9hSgBlKAgoG21cPdMhU01zh3CI2k2F1D8DIZ6Nv
	 q2XSCJi2UzOfhfRzHOTkoE3do0rA/ad7PSNIDYpNpXsdQbC+IW4fuKO3TIBCw80DW0
	 wJPZxRmzR/BIW5zahS415KvqUbKe99zPYIYJCtvsUEGQwBlAmZHiuBxNXRyEu1VhkH
	 4ho+Z0YA1jPgA==
Message-ID: <sashiko-outbox-233673@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/7] libbpf: Add bpf_*_get_next_id_opts()
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261125-bpf-relax-get-next-id-v1-2-49175227c8cf@toke.dk>
References: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
 <20261125-bpf-relax-get-next-id-v1-2-49175227c8cf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 15:46:12 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] libbpf: wrong opts struct type in OPTS_VALID() in
  bpf_obj_get_next_id()
- [Medium] libbpf: new bpf_*_get_next_id_opts() symbols placed in
  LIBBPF_1.8.0
--

commit b7df30f0fa741fff328c3a531ed16f0239f39016
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

libbpf: Add bpf_*_get_next_id_opts() functions

This commit adds opts-based variants of the bpf_*_get_next_id() functions
that accept a struct bpf_get_next_id_opts with a token_fd field.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 38dcb31e8c0ed..059c358c97444 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1149,14 +1149,21 @@ int bpf_prog_test_run_opts(int prog_fd, struct bp=
f_test_run_opts *opts)
>  	return libbpf_err_errno(ret);
>  }
> =20
> -static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd)
> +static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd,
> +			       const struct bpf_get_next_id_opts *opts)
>  {
> -	const size_t attr_sz =3D offsetofend(union bpf_attr, open_flags);
> +	const size_t attr_sz =3D offsetofend(union bpf_attr, get_next_id_token_=
fd);
>  	union bpf_attr attr;
>  	int err;
> =20
> +	if (!OPTS_VALID(opts, bpf_get_fd_by_id_opts))
> +		return libbpf_err(-EINVAL);

[Severity: Medium]
Should OPTS_VALID() check bpf_get_next_id_opts instead of
bpf_get_fd_by_id_opts?  struct bpf_get_fd_by_id_opts has an extra __u32
open_flags field before token_fd, so validating against it skips checking
that the 4 bytes following token_fd in struct bpf_get_next_id_opts are
zeroed.

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index a45666f546fae..899264fbb42d0 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -458,7 +458,11 @@ LIBBPF_1.7.0 {
> =20
>  LIBBPF_1.8.0 {
>  	global:
> +		bpf_btf_get_next_id_opts;
> +		bpf_link_get_next_id_opts;
>  		bpf_map__attach_cgroup_opts;
> +		bpf_map_get_next_id_opts;
> +		bpf_prog_get_next_id_opts;
>  		bpf_prog_stream_open;
>  		bpf_program__add_flags;
>  		bpf_program__attach_tracing_multi;

[Severity: Medium]
Should these new symbols be added to the LIBBPF_1.9.0 section rather than
the already-released LIBBPF_1.8.0 section?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-bpf-relax-=
get-next-id-v1-0-49175227c8cf@toke.dk?part=3D2
