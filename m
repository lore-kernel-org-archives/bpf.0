Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908DF2C08D4
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723770; cv=none; b=uWN4EgnA6GzcU6H93IbWYAzkyphmjd/wE73I0JhpvMvvCfCfswarQHKuy2eXR9eKKB6GCSipFFMwsMkyLoTFUVp8gf/CJIONcfYXTInpll3T6taFHzqSF8tsN00bn+ug0DwIkXY0GTrjdypFLi6RLSHE767gFj7HbLYA49ik98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723770; c=relaxed/simple;
	bh=XEkk+5AffsDxJBKowAqLnnijjyEegBSWzUYhIEqFACg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bt3uMGUCVbi2Qlher0J2q4O8TPMG7e3NB6yKpgjlrP8N5btsdS991nUgWaCjk38/rOZQ2Oe/kl66Rs5pUqdL7SbEEmYMzQh2HDvFVW02Ndq1/CuEhRvohmnOyQV0v4UxPlAE1/pF3LLQl9WEFN0jwUjHk57wmu6TtfHC/7sch18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtQ1ygWE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtQ1ygWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D339C19425;
	Thu, 14 May 2026 01:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723770;
	bh=XEkk+5AffsDxJBKowAqLnnijjyEegBSWzUYhIEqFACg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CtQ1ygWETW/H2mMbqn93V96nsPKwO8DdfjOQ91HqJWRuABB6zGnHJ2aux/3OEpOZx
	 +ApTQ+oTxhTF2S/71nk85xI9n/BV3beiSRLLVWc/sEolOdfwd0ND3+tVzeBoFBdMMT
	 mkkjLs8QiUt4IT7MALdqj1JjwNhWcyN4JOXoIc0ha8v8Afz41GVpWr7NXx67U9PVIr
	 QsahBJGluKT+4GVaXirwuYxCur/SXeS6FItLpLExwV8chT1hWdhzwhfSNBvn6T17hB
	 cCLrkvoWVZ4U23TYRjd0ISs0cZ5Z8DlS0SV6xC1hZUx9z2lDBeK3YN80glxwuUNqIb
	 RvcJSSGa6d6Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] libbpf: Use strscpy() in kernel code for
 skel_map_create()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kees Cook" <kees@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513050806.do.620-kees@kernel.org>
References: <20260513050806.do.620-kees@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:56:09 +0000
Message-Id: <20260514015610.1D339C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The use of the 2-argument `strscpy` macro in `skel_internal.h` b=
reaks compilation of light skeletons for out-of-tree kernel modules on kern=
els older than 6.8.
--

commit 056f88b29a55562ae428a73e0cbb771aa82987a6
Author: Kees Cook <kees@kernel.org>

libbpf: Use strscpy() in kernel code for skel_map_create()

This commit replaces a deprecated strncpy() call with strscpy() in
skel_map_create() when building for the kernel, leaving the user-space
version unchanged.

Link: https://github.com/KSPP/linux/issues/90 [1]

> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
[ ... ]
> @@ -243,7 +243,12 @@ static inline int skel_map_create(enum bpf_map_type =
map_type,
>  	attr.excl_prog_hash =3D (unsigned long) excl_prog_hash;
>  	attr.excl_prog_hash_size =3D excl_prog_hash_sz;
> =20
> +#ifdef __KERNEL__
> +	if (strscpy(attr.map_name, map_name) < 0)

Does this break backwards compatibility for out-of-tree kernel modules using
generated light skeletons on kernels older than 6.8?

The 2-argument strscpy macro was introduced in Linux 6.8. Older kernels like
6.1 LTS and 6.6 LTS only provide the 3-argument version:
ssize_t strscpy(char *dest, const char *src, size_t count).

Compiling this generated skeleton code on older kernels will result in a
compiler error due to too few arguments.

Would it be better to use the 3-argument version here instead?
strscpy(attr.map_name, map_name, sizeof(attr.map_name))

> +		return -EINVAL;
> +#else
>  	strncpy(attr.map_name, map_name, sizeof(attr.map_name));
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513050806.do.6=
20-kees@kernel.org?part=3D1
