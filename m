Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52542D746
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154344; cv=pass; b=L5D1Nk+9eYVHKo57BRWUpPG+Kz4zSow02pKmhatc2Z7uHl3zqySmGJeElqwtCfSQTmcxvXEGzfohKY7c/x4PEVXqo5iOaWQl7AN6hiTNkidBFdzdY0HAKCWRI7W/AqOTNI8or2l8yme7PS1xxzYmzRCRDucAG9EPIt6vbI0zu7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154344; c=relaxed/simple;
	bh=8dTPVK5zTUn5+CAz97Lf+XW3+b0Lur90wBZjQrZ+i9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwamuSlf3QXiXUL8YTxJIzMA8e5Iw+X2g64k+l8mvVo6SZSE8wswxuQk8WuGljf4LPzrLbgoaFzAX0PRkm+5YbbATEEJ741UTOquRh2OErIkX/B1cBCUXpb4YXRI+Elys5tu7VpZE1cX2B3wuhwhK0QxEyHsV0NO8fNHc+Px+CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6u6aQCA; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6u6aQCA"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1351544a91.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 12:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789154337; cv=none;
        d=google.com; s=arc-20260327;
        b=jzREQ9O/kqwLCP7udVyf9FU35aDfwyJeDu8hKEcSeDRjFu2xOkJ8VtiZf6XT3GEfAn
         xtPriUfnn5LABDngv2zEj/SAaML2cgMNiwQWqDFU6so0x6WkZL9Ct/rIWnLFMxDnQtGk
         ZDzmL655/4HA/nEVouQ68+4LQfGMevx9Cvck5BhTS3qCJwgygbqU8TtR9Hu9+2oBm86u
         u+FmkgBC7JUcOaOFAsuTwcOhNJTT7eDTG4q7CydLp/SPzZzhmnwsMm6mTZfjUXNtl6MQ
         Q9xwRdDUpCW39G39GFHItjSTsNqCUnuaCuhghAPjEXejze07X3ys6A0Dy22O0cOXiYeb
         j4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oE3Ul1qqMxtq5ttXP4sCVTjSb05miK34hj7ST3jfoQA=;
        fh=1UtBZlvMSndr6WRsxCPgbgneZEc+/UUSCiFYC4CU0Rw=;
        b=YSuj75pFNVl6E6sSTrc9mbMFzjW5CYKBUGKk9xzOvudpJaSqEypJ/Om6yjwx3dfTDn
         R4uR++56dmbraKLLut7eYfv+iM+EoGBQ/QFNU3Ig0O8M1usrkmXQ1FsePaDhAz1zovJd
         G3yGQ5T9KP6XHr5KTAv3aZ1Nnl4Mqoolhl2I7cNqbPJIp0NYEIJOk/ot0qVdXDnl2zur
         j1qEMPRBHW+xCRC2YeZml8aCbbNmK53BBdA4I61O74bXN7Dlc6OYsGrEEebAsf7wyxYk
         cCDRwaoESEzTJqw160M2tzknjVKyfbkqR8KeU4o3lS24/0wzTUw5KHzgfDRDun8drODm
         HayA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789154337; x=1789759137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oE3Ul1qqMxtq5ttXP4sCVTjSb05miK34hj7ST3jfoQA=;
        b=P6u6aQCAgJNRlPCfbhfew4r+dXA6pG3Bn4hr4/e9jbfu1puoSGyTH7hR46deQ/bYr2
         3VRJIz3PepYvD9fOeBjjQWG4CNZvoKgG45+DKei3DMjIYdXK16SwA53YC4v4Yo9R+9nn
         8avtSheI6NkBldv9//fiwqcThnF6pu+QIUtxFyuMTmoPxxzcqZFas3cyHBvhhA6xaJF0
         taCF69WpPnaKLwFWNdU/3yS8F95lbF5w5hixb+Xcg5RFdZPKVpU/y3ZJwsIrTU9vxIcD
         BTwhoj1jlsEzEO8ViiVNqKFCnSYU114OYeRpWJya8xbX56mZia/ZWPxJAz0tfJAInZVW
         C1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789154337; x=1789759137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oE3Ul1qqMxtq5ttXP4sCVTjSb05miK34hj7ST3jfoQA=;
        b=DP1/FGn1fwjoLpKA/hdhPRC7DBQv+PMfwD2tLeX8yoEKF24RVpBOZFUBDdWErzp1I2
         LV4Fbb3BGLTxXcy9Kp8OQ4HD8/RiLO9mgdKixPQppPkm+IoEh4UmN56nBB8+gbtTM7Md
         7KQaCNiANH4lr1r9mJfK/9K9DoTy0+sQZhd+dq1wcm2I/IQmmdCL5URdNfGHeORaTfFs
         WH9vJMGpSRUH17nENNObDyom+wcL+cDNnzfi86j0kGW1kJFAMjTyIT3dQ0LE2DUDCvRr
         c+qjlAZu7uzBUjY+KMvj8PYkG3ht9Ir023cVbBUHK5Rh3jPndUt3+ejKMo5OJVcj653F
         hb8A==
X-Gm-Message-State: AFuF++kS4CGfcptyf/5BXWnoweW7ynHIJILyQMuZVmmpSfH3wIij8GnS
	Y60D+Us6f+ssB0E8fnIeswkBmxA8Nv+Zp/0NWzTVh5TWel67nZR4SzN4m35+8g7OFyoSt+7LoPB
	tW3KjlvZxJe/ZmNKvbB3J5TsNmHV5Fd4xnx+e
X-Gm-Gg: AYBFou3HyHfJB9f5FL1Jar1lXNDH/hBYWvs/lEj2qY9k0Wx5BqX0A4QxZYhjozl1WkR
	wY6L5cZOU8bCBRpy7z02uggAQUYZxu69ZDKzRv6TiXdRmkiAsRMaBmSMtlPE6QC8anKX+ajnzlq
	Alkl0xKIE6HNyNpdpdtg5jRzJxd9EZ0MJiIt58LiiXSGSrZq4pNR+lkia68OjH4IWSr7GqwE3av
	O+SUm7LhACW1WkhbgaVmZxkVRBp8Y+54QSAWKF2lB4kS2lBVdea4CqR+rdUiHo1JaXOSQTmuF0U
	zL/wjQ6wLyXnDZMTGbMsKDDalClgxPeMwXSlIVClrlAZPEVfYmNwIyxCkyrPK/X1V7+xUFx0Crw
	2/YnYzUoHMvG7KT0jffTjRBbR75yozU2ATsHs
X-Received: by 2002:a17:90b:3ecc:b0:39b:4877:ae90 with SMTP id
 98e67ed59e1d1-39d9c352654mr8818460a91.22.1789154336660; Fri, 11 Sep 2026
 12:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911120820.46900-1-zhaofuyu@vivo.com> <20260911120820.46900-2-zhaofuyu@vivo.com>
In-Reply-To: <20260911120820.46900-2-zhaofuyu@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 12:18:43 -0700
X-Gm-Features: AcwNN1UhbRDYeM_rWKGd9EPNDyqhKSNY6NtAMmZrvAGVB6RpCJVmB007op-PGW0
Message-ID: <CAEf4BzYkY3ehPGei5Ra2xUJZHu-JcKLfPOuKeo3Ckks8w=OrEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, alan.maguire@oracle.com, 
	olsajiri@gmail.com, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 5:08=E2=80=AFAM Fuyu Zhao <zhaofuyu@vivo.com> wrote=
:
>
> Add btf_module_allowlist and btf_module_allowlist_cnt fields to
> bpf_object_open_opts to limit which kernel module BTFs libbpf is
> allowed to load.
>
> When the option is not specified, the existing behavior remains
> unchanged. An explicitly specified empty allowlist prevents libbpf from
> consulting any kernel module BTFs.
>
> The allowlist limits which kernel module BTFs libbpf will consult
> wherever module BTF might be needed.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
> ---
>  tools/lib/bpf/libbpf.c | 72 +++++++++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h | 16 +++++++++-
>  2 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c036e8a91ed8..4ab7ddc3b4cc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -751,6 +751,8 @@ struct bpf_object {
>         bool btf_modules_loaded;
>         size_t btf_module_cnt;
>         size_t btf_module_cap;
> +       char **btf_module_allowlist;
> +       int btf_module_allowlist_cnt;

please use size_T for this count, just like other counts (both
internally in bpf_object and in public UAPI opts struct)


other than that, looks good, I was about to apply before that `int j`
in bpf_object__close() caught my attention

pw-bot: cr

>
>         /* optional log settings passed to BPF_BTF_LOAD and BPF_PROG_LOAD=
 commands */
>         char *log_buf;

[...]

>         err =3D bpf_object__elf_init(obj);
>         err =3D err ? : bpf_object__elf_collect(obj);
>         err =3D err ? : bpf_object__collect_externs(obj);
> @@ -9626,6 +9691,7 @@ static void bpf_map__destroy(struct bpf_map *map)
>  void bpf_object__close(struct bpf_object *obj)
>  {
>         size_t i;
> +       int j;

you don't need j with count defined as size_t

>
>         if (IS_ERR_OR_NULL(obj))
>                 return;

[...]
