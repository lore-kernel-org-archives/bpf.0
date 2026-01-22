Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8AF3A5C10
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116711; cv=pass; b=tfNFeH5LU1vOx19ybnX5WyLLmWdm1jpXqWqJyE8DXm5fu9/3HdkODztIut0ZTSVcEVRiPexRWl1RgcYTNKhw6OZItYWKyx4dG/ZpRJQhFUVrw+3hJUULtzDEmHkrPrGHoYMTl96xrMLGFcrVQ5PkPDwZT6+J+HLtZ5osksV3Ulk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116711; c=relaxed/simple;
	bh=gPm1iwy5GGdb8BBpg/Z4zuuZR7E3/KF/q8Ip1HJXlv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSyMpdEJsvwOHgZ+AchexH8cWXxT0Pe9JvvCH9vb512xTeEUCB7jkFt3vjzvBceePHJuUiwbVXNJLAlSKDJzKQCCWdkidubTgKycggM5F3rxMpl0q6KGH3CXRH7AOpia8JPdgEfevECFgB1ozTg4UhrE1kvt5wUyjTPyarNNNfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5XrENKi; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5XrENKi"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649166a96a9so1627047d50.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 13:18:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769116699; cv=none;
        d=google.com; s=arc-20240605;
        b=bxMR8X6nixpQXJi7A6wWT5tusN/PwA458ogouv0EJvomiekaIaC39Y0za7wcQTCbSG
         ZBxdVzP5FnFBexLOl2Cq5uOjd2xIiQg1sJ3iqB/WpeVleB5ob6CSIN/E2e9Xl2AN0oEP
         1VqOe0nlFB49LPNYUawA2dbcD+0WD7tOLhevsZoZtRT/mGMKkA18jvcYVoanOjE/CJto
         kh9Lp9OjByts/en+Zr5rEOu2R0auZM3SsQkSQDCbrouRXXc0ZLx8PoY5Q2gtCu5wES9W
         eHwmW0bCrxU/pmBjHfZLISfPBP3RH43sjL8GtdgkWoZe0ftO2OVtRxGwOy8UCfXpKsYd
         EPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P+5eD6pB5pClNTMb7TagLUbOzPdxkJ/ospa7leEqNoA=;
        fh=4KubPJPm/oify4h8BPjn9mdYAYp9R/C82vTyHZeZ5Mg=;
        b=YaazesbmfGLxoKLBSkneJfwXjyitjQ+Vmrplslu8cVRsa0iPL3HBUnR/Ltu1uWSgRZ
         dXapQ3IGgKY96XhjIieAqUp4r7IyKDvYQG8LyWIqRbLHfJIqefEyzCZJ8Jkvx5ajtc3Z
         E4FJhaTWM8myLkRd/X1U3v5cLUT4406TtegtSgKjF99Cgb13Qwk/OAfinQRi5LNgt21b
         P+HR8zvY/gTA5WRcutrw2ERilHTvJFzTfpCzrG1Mxsd27c340k4sROgE0iHcXI6ddfBZ
         9uDXeKqi8jDNN4py2EIcHA+ww0sO8qXlvWOrWjgxJbv0GVqsf+HSVLn+4g8DdJ+FM7uM
         tmjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769116699; x=1769721499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+5eD6pB5pClNTMb7TagLUbOzPdxkJ/ospa7leEqNoA=;
        b=O5XrENKiPOVGZIdXfkel3C2RCDHATsDcXwJiawhyG3mj512kXdXkzvoVsYkNO2+trV
         ItkDj95rxvtkAar0eGa9GVRpG9tHC1IjvuzZkpieh2jf/jAV9gmMnKC7wXlFJQGRAZ0f
         fxbAoXBIuVOXoBPeCn0a01sZuruC3gHzjZXN4Y+R3VaYmVD7GSQ+PXnvGNO99C5gI2uK
         slN0tEJwXZHKm6a23PbQ42b2bBgLH6lPXPkg8jNDVlrTdesfBQlO8OZ2oV59rt7JvHMg
         iPHA9dS05JcUfjG269wZ77AJHHYKPGFZRYj6YzCQjXpYrjHrISFJbtRs4f40s36rM0Xx
         fx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769116699; x=1769721499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P+5eD6pB5pClNTMb7TagLUbOzPdxkJ/ospa7leEqNoA=;
        b=qdxkBzpzql1pIzgbibGkyvm3sFqHZll4K4S9oPpsoj0PTYCcB3dZL6EHVwyThurpla
         TWs4ghvFdRUQeEH9blGNFFJZr9xxP9xhLPIzGiFybTuNtO/jRLvh32nx330MC93cAbsS
         sXlhHTEwVv43WEsDZwKdSjwW70ugLTb+qJOkutJfWyj/Cl333YBEhnx0tU/G4QkqBfwg
         bO9HWJEBDKEdVnqcuVLEBvZUlmgFuqf+3/Cm3mEh4sTy7ALenrmzQ/1d9cfKMaO6H9Pt
         UG8nAs/pgnDTSxSEF+8Myzk2bUpgiRyRyBFj6vJkCp6J9psXNzJUBRXBWmqCoqIN3Vsh
         1GaQ==
X-Gm-Message-State: AOJu0Yyn8V4+LVgAsJ7XAhga7Bb0rhAJs6wOPXPWweZ3XG1dGHHhBUsC
	u42FPCYxnwpm0Yp87Ai4r4HGmzRnU9wPpJ6njcsE+E6BJeiWVwyo3+m1c3LmbuzaeF+Lw9mtw6e
	hIH0xg8jDurzwPzUzgYSSKsjAN76kEbQ=
X-Gm-Gg: AZuq6aLYrU/0WDdfgfD2LKGZvWFRtyfwuhBdYyUc0ueS2dCfRFiW2SXuPOOasJXqGNx
	RM9iGFJPqwno5BUn7h5gd0g3F3uXbHWmuNrmUltBgh6zpImDeu9XLjvV8YWBoppf+IkPXgknTLX
	Ssnhaffl4XpHopVVoT3/xCcT4B09FlpCNyijSD9TSCp3Fq0f3UDSs4eWD33YKFVxOvA3MtfHj0D
	VJm0a/WGaPu2B18/g4GMaSM0sBh1dZPehawTJPLhqnuGyJiKdy/p3lCmv1C2nTmWVyCArxZ5hXN
	bm363G3E8yc=
X-Received: by 2002:a05:690e:134b:b0:649:393a:431f with SMTP id
 956f58d0204a3-6495bd6e030mr760310d50.0.1769116698736; Thu, 22 Jan 2026
 13:18:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122162616.3578898-1-yonghong.song@linux.dev> <20260122162621.3579387-1-yonghong.song@linux.dev>
In-Reply-To: <20260122162621.3579387-1-yonghong.song@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 22 Jan 2026 13:18:07 -0800
X-Gm-Features: AZwV_Qh6JBLqHLq66d0NQxY4n5WL-sKEPHcBe8YhUrlX67LnlsQWWHpV0X8o0dc
Message-ID: <CAMB2axP_AaoiZB9BSQ3Mz_M0e0t1S-y3u8KnBx1FY1nCq3qN6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Fix xdp_pull_data failure
 with 64K page
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 8:56=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> If the argument 'pull_len' of run_test() is 'PULL_MAX' or
> 'PULL_MAX | PULL_PLUS_ONE', the eventual pull_len size
> will close to the page size. On arm64 systems with 64K pages,
> the pull_len size will be close to 64K. But the existing buffer
> will be close to 9000 which is not enough to pull.
>
> For those failed run_tests(), make buff size to
>   2 * pg_sz + (pg_sz / 2)
> This way, there will be enough buffer space to pull
> regardless of page size.
>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Cc: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../testing/selftests/bpf/prog_tests/xdp_pull_data.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> Changelog:
>  v1 -> v2:
>    - v1: https://lore.kernel.org/bpf/20260120210930.2544950-1-yonghong.so=
ng@linux.dev/
>    - Use pg_sz to simplify buff_len calculation.
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/too=
ls/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> index efa350d04ec5..35f0eb5b43f3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> @@ -114,12 +114,14 @@ static void test_xdp_pull_data_basic(void)
>  {
>         u32 pg_sz, max_meta_len, max_data_len;
>         struct test_xdp_pull_data *skel;
> +       int buff_len;
>
>         skel =3D test_xdp_pull_data__open_and_load();
>         if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
>                 return;
>
>         pg_sz =3D sysconf(_SC_PAGE_SIZE);
> +       buff_len =3D 2 * pg_sz + pg_sz / 2;

Thanks for fixing the test. Just curious if there is an issue with 1.5
pg_sz as suggested by Alan?

>
>         if (find_xdp_sizes(skel, pg_sz))
>                 goto out;
> @@ -140,13 +142,13 @@ static void test_xdp_pull_data_basic(void)
>         run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1025, 1025);
>
>         /* multi-buf pkt, empty linear data area, pull requires memmove *=
/
> -       run_test(skel, XDP_PASS, pg_sz, 9000, 0, 0, PULL_MAX);
> +       run_test(skel, XDP_PASS, pg_sz, buff_len, 0, 0, PULL_MAX);
>
>         /* multi-buf pkt, no headroom */
> -       run_test(skel, XDP_PASS, pg_sz, 9000, max_meta_len, 1024, PULL_MA=
X);
> +       run_test(skel, XDP_PASS, pg_sz, buff_len, max_meta_len, 1024, PUL=
L_MAX);
>
>         /* multi-buf pkt, no tailroom, pull requires memmove */
> -       run_test(skel, XDP_PASS, pg_sz, 9000, 0, max_data_len, PULL_MAX);
> +       run_test(skel, XDP_PASS, pg_sz, buff_len, 0, max_data_len, PULL_M=
AX);
>
>         /* Test cases with invalid pull length */
>
> @@ -154,7 +156,7 @@ static void test_xdp_pull_data_basic(void)
>         run_test(skel, XDP_DROP, pg_sz, 2048, 0, 2048, 2049);
>
>         /* multi-buf pkt with no space left in linear data area */
> -       run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, max_data_len,
> +       run_test(skel, XDP_DROP, pg_sz, buff_len, max_meta_len, max_data_=
len,
>                  PULL_MAX | PULL_PLUS_ONE);
>
>         /* multi-buf pkt, empty linear data area */
> @@ -165,7 +167,7 @@ static void test_xdp_pull_data_basic(void)
>                  PULL_MAX | PULL_PLUS_ONE);

We should also change these two cases above to use buff_len to make
sure we are testing the right logic in bpf_xdp_pull_data().

>
>         /* multi-buf pkt, no tailroom */
> -       run_test(skel, XDP_DROP, pg_sz, 9000, 0, max_data_len,
> +       run_test(skel, XDP_DROP, pg_sz, buff_len, 0, max_data_len,
>                  PULL_MAX | PULL_PLUS_ONE);
>
>  out:
> --
> 2.47.3
>
>
