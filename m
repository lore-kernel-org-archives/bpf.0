Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D034D384228
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786288899; cv=none; b=st2D/2sNR2iK+g7vWsAT4td7LdKsJpY/wMzXqKSLclUoEpCG3pTfaYTRiyrwRd9fxdjFIROkA+jzjyWSIxt/zKVJ3pG+WQvKYfXBSDGekWbhkJBVQuZ5kB+5auDpMS5NjuNt29ZWhTZdZ4NjvPQmZuRVz+Xzitm33f50dzEEddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786288899; c=relaxed/simple;
	bh=kBXpjaQg1TK55Wzf2i4bH9A3RP6iauY2/P2SivaKfks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iIKLcp8oo59YS1u38GYqiuCobD+rIQfc5+6k0d7aMzHIQ2eP0VIu42uG5ulLUplTbASr8xIVlYKk9QH/qM53Nk/YhtT9Ig42O7fdEVPeWvffMVPOdS5fQUW+O91n92Q1s3lHe99+x2dKYhdB/f99BtpvoU309VX0W7bTf2bc2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1c8vJ2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1c8vJ2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FA81F000E9;
	Sun,  9 Aug 2026 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786288898;
	bh=6uVZTqoxyk8+wL4LcE/D2S6O5fM9ugPX1qMLpd1onKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z1c8vJ2ENW9sdlxEwnTx8glFlvFVTN9CLJhyN21EJgYy/1HP8zHqXfhj1JJOhw2En
	 GJ42WtP3owNE6hlNxhI8F6NXXkHDsQUOAqP7JbbFLWm5kC31xKoxSYG6NuDXF3+VqL
	 mrKWJGgKVu5rTbTzlWiRwryIR2aQd3ap4goDuLgVAtH2CNqmo1P9pzUeg1zcXH08zL
	 OyKXbOw8dTggOT/TctsqwsPAWF6pwuhnNCXgKDzlA5Vvfyr9kHBB5IF99jnGsxif16
	 1XLWZsXotCXaCKNELIQaJ5YIl4xjN2gKTbIE18QhfcHcaK27O1PF3DDeWwj7BklD4a
	 6RUqkf+M9njng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 05/13] libbpf: Add tracing_multi link support
 for bpf progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260809150111.45000-6-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-6-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 15:21:37 +0000
Message-Id: <20260809152138.45FA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing input validation in `bpf_program__attach_tracing_multi` =
leads to a potential segmentation fault when a user-provided array element =
is NULL.
--

--- Patch [5]: [PATCH bpf-next 05/13] libbpf: Add tracing_multi link suppor=
t for bpf progs ---
commit bef5c103ea1916738efc32c272265795c04de90a
Author: Leon Hwang <leon.hwang@linux.dev>

libbpf: Add tracing_multi link support for bpf progs

This commit introduces tracing_multi link support for bpf programs in libbp=
f.
It adds fds and funcs fields to bpf_tracing_multi_opts to specify target
programs, translating the function names to BTF IDs before passing them to
the kernel.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514e4e9daa825..d698a64ff8002 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -12720,11 +12732,28 @@ bpf_program__attach_tracing_multi(const struct =
bpf_program *prog, const char *pa
>  		if (cnt =3D=3D 0)
>  			return libbpf_err_ptr(-EINVAL);
>  		ids =3D (const __u32 *) free_ids;
> +	} else if (fds) {
> +		size_t cap =3D 0;
> +		int i;
> +
> +		err =3D libbpf_ensure_mem((void **) &free_ids, &cap, sizeof(*free_ids)=
, cnt);
> +		if (err)
> +			return libbpf_err_ptr(err);
> +
> +		for (i =3D 0; i < cnt; i++) {
> +			err =3D libbpf_find_prog_btf_id(funcs[i], fds[i], prog->obj->token_fd=
);

[Severity: Medium]
Could funcs[i] be NULL here if the user-space application provided an inval=
id
string pointer in the array?

If it is NULL, this pointer gets passed down through libbpf_find_prog_btf_i=
d()
and eventually reaches btf_find_by_name_kind(), which performs this check:

tools/lib/bpf/btf.c:btf_find_by_name_kind() {
    ...
    if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=3D 0)
    ...
}

Calling strcmp() with a NULL type_name will cause a segmentation fault in
the application. Is it worth validating that funcs[i] is not NULL to safely
return an error code instead of crashing?

> +			if (err < 0)
> +				goto error;
> +
> +			free_ids[i] =3D err;
> +		}
> +		ids =3D (const __u32 *) free_ids;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809150111.4500=
0-1-leon.hwang@linux.dev?part=3D5
