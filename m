Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705890;
	b=5D1ggijQMJDk3/5jU5o/rViuRxUBnEnCsPkNUYdfYhTCRSYglLoOaXsQ8yFdIHL5Hs5E
	 t5uHCyHDvGTtnUFDuc5URLo2s4ymkF/hwEC7p5Ha9h7vHYvI84vC1cI6wLrgUl3BGOkb9
	 2GwI0n5vTU3JtAP2cLBmsahOVvGRqQwHudFcLPVawC5PpWNDOA9pniK6Wj9bAxz2tVObf
	 ZNAF9CE1J5khLzSOijOIFGVrplqvBYeSP740fk7YWc6Yb+CCkYJgKO1h8w13HmyHH8A1q
	 lm421t8+ZJWNkPHEexGJW14Vo4EGWNgEbl5WhnWLqjuQdoQ9Z/5a8sCffrEjn0ziZgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705890;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Gjr2+pPAGblbHF1y8nUa0xNJAXuC0lLCMWCKQm6UYtY=;
	b=gK3/6LaMsm0YYj6YIj/Ph51EDOAUFeyqGOq8kLvCTArf8U3Xjf4nvRRy9pHfG/gdA3CP
	 quPL1NSssR/UN4hNn7TgBhRbDL8HD0wb6tQkkoW0q5srAN7V0ZpL+NODOC4yhQ5vi2krP
	 8Bazji8cKiRX0FFZAiB+UW/gh3Njcx9YumGDI/iaqzsi7cU2LVrFCq0JzyacSLpVvJIkf
	 j0Omv9+732Thh8jThqoDZihsAlB6qJNye6ioDom2C8B4ggiLeKtgcnNV+nXxqZJSp/hAu
	 obUMWqwyJ1GBnmYMak+tJQvezoCDolpu7TduQtOCZTg3zMZ/qOFEnsrSOTTgPNCRyyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M/DB3AAK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1AF606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/DB3AAK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67C61F000C4;
	Thu, 26 Nov 2026 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705889;
	bh=Gjr2+pPAGblbHF1y8nUa0xNJAXuC0lLCMWCKQm6UYtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/DB3AAKzuH5fEaYj0ZmfuCxxStBx6FpBQfbqdBvd6xL55kD1Hqq0EDRMyhB1870o
	 V0U3lxVs6+quQRcvSUCSnbOzBcszYeYwI9+yd45WlslsKY0I1RMefYuY/kk2WtktGb
	 PBhL8/sfaNaGkUuRUw7WE4YJtdVkow9Gbx/F9zyai+jGJ8Ad3WRdRfQPq2Nt67YdCs
	 FOwNOTYpepk+1pudSc3yjYNmj+V+O6e2/O7NHuDKUEDy9AxUGGvrap1SKSnvXA6Z6H
	 AJDhrO6T/mTUPt4Z5flo8RBlyuTFNkk4g7huEfC5pEjY4wFsurkdqj1fbhEvEz7bxt
	 /QVd+Sb+KnD3g==
Message-ID: <sashiko-outbox-235780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 4/7] libbpf: Move bpf_object_prepare_token()
 to object creation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261126-bpf-relax-get-next-id-v3-4-338e1d3077e7@toke.dk>
References: <20261126-bpf-relax-get-next-id-v3-0-338e1d3077e7@toke.dk>
 <20261126-bpf-relax-get-next-id-v3-4-338e1d3077e7@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 15:11:29 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] libbpf: dead gen_loader check and host token probe in
  bpf_object_open()
--

commit bfc72a1132d0b5606c8e46c132afab5bec32d57f
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

libbpf: Move bpf_object_prepare_token() to object creation

This commit moves bpf_object_prepare_token() from bpf_object_prepare() to
bpf_object_open() and closes any acquired token fd in
bpf_object__gen_loader().

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 540daf7752b45..1f1569a35f92a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9281,6 +9281,7 @@ static struct bpf_object *bpf_object_open(const cha=
r *path, const void *obj_buf,
>  	err =3D err ? : bpf_object__init_maps(obj, opts);
>  	err =3D err ? : bpf_object_init_progs(obj, opts);
>  	err =3D err ? : bpf_object__collect_relos(obj);
> +	err =3D err ? : bpf_object_prepare_token(obj);
>  	if (err)
>  		goto out;
> =20
> @@ -9873,7 +9874,6 @@ static int bpf_object_prepare(struct bpf_object *ob=
j, const char *target_btf_pat
>  	}
> =20
>  	err =3D bpf_object_check_gen_loader(obj);
> -	err =3D err ? : bpf_object_prepare_token(obj);
>  	err =3D err ? : bpf_object__probe_loading(obj);
>  	err =3D err ? : bpf_object__load_vmlinux_btf(obj, false);
>  	err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
> @@ -10543,6 +10543,11 @@ int bpf_object__gen_loader(struct bpf_object *ob=
j, struct gen_loader_opts *opts)
>  	gen->opts =3D opts;
>  	gen->swapped_endian =3D !is_native_endianness(obj);
>  	obj->gen_loader =3D gen;
> +	if (obj->token_fd) {
> +		close(obj->token_fd);
> +		obj->token_fd =3D 0;
> +		obj->feat_cache->token_fd =3D 0;
> +	}
>  	return 0;
>  }

[Severity: Low]
Does moving bpf_object_prepare_token() into bpf_object_open() make the
obj->gen_loader check in bpf_object_prepare_token() unreachable and
reintroduce host bpffs probing during offline loader generation?

Commit d92defe04ad5 ("libbpf: Skip BPF token preparation when generating
loader") added an early return on obj->gen_loader to
bpf_object_prepare_token() so that offline loader generation (such as
bpftool gen skeleton -L) would not probe /sys/fs/bpf or honor
LIBBPF_BPF_TOKEN_PATH on the build host.  Because bpf_object_open() now
calls bpf_object_prepare_token() before returning obj to the caller,
bpf_object__gen_loader() cannot have been called yet and obj->gen_loader is
always NULL there.  If LIBBPF_BPF_TOKEN_PATH or opts.bpf_token_path is set
to a non-empty path that cannot be opened or does not allow token creation
on the host, bpf_object_open() fails before bpf_object__gen_loader() can be
reached.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-bpf-relax-=
get-next-id-v3-0-338e1d3077e7@toke.dk?part=3D4
