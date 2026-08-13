Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017F3CB2FA
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658426; cv=pass; b=N4MMWJjxikeOU1nsRmPQlbGWfVQ+72+pISMyvSCs8oOGGJXlidQwKY6q7Uq+nLm+hvfm/+r+A/5kMV6zgkX2Z1oDkrmJZ6EY/MHFoomU9E7IsrY2rv6+/n7TMzuvUYhniEbuBT9HHpPzhHYqnKAKdheNuVP6LrRYUxYZh48ToxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658426; c=relaxed/simple;
	bh=5nekVy28ubmsTAs+dzaYrbAn/O2Wfyk3/PZkyv6JlhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uypF4mgblhoikFoHEzLpkb21T1ymJBhh5Pj3wiDzksJTrvkET2eHWhs4Bk2PJnvd58HBf5BoqTP1nr8pCLgMBKes2zyy71JcE7JIrCeeNmaPZRANESv/EEMheMCs4WEei7aD+8nsdSl2VYj0z8J1oFnsxTl09LFrrtXQWyhaRHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2BTmaTp; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2BTmaTp"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485ef63b68so361179b3a.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786658425; cv=none;
        d=google.com; s=arc-20260327;
        b=OREYpRiiP7Q/CHYvH2xljzfHWy5pHnMmGfw2u4OwTGeCsF2Cj69xw1UKfNEf5Fmklo
         7Qzx0P5u+Zh8Jf/zrNvDWbcZcHnydxsokYVhpVHPGfyNtelQPPur6Qb/fQeOwr1125lk
         9mdsFEBMTYM0VNsNFCPIbmHi0lE/M23uEUlR9lYJisc0iCH3CJLsvGjx5Z9KZGg1Xtna
         oZ9lXiqdIdLF+Vpo6zTvE+OeQ1ES0XROVKRkipE4A8gwlJ0SdiqwPz/9pVmEwNXeAAV5
         GTpVWS6d2cCOKZlt+QcFKALOWFFn80I4nvZ0115xBZhFsJcNrjj5ncT9hDfndWWCGoON
         OpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsHG9X4LKDpidQ0lZnkR2jTteM2KBumLlfXgv3JR1Ug=;
        fh=2g8ZyObSs38UhAj8kd80vpxj+W332ieoAyB+PfA9NvA=;
        b=r13gZNGNukb10ksgnr/UJ0O9cOK1uo/JWqTx+dSWKBcqEWGOS5YXnY4JwM2PwThPbJ
         l90AJHZnyrnJXbMw7aepSl4ArddVoaGqCZ3MKJB+UxYLi5NQz8XBqv2HQwnsdNJg2x8l
         1Wo0T0S7mRgP1u7aHWbiZdmmGZRR7pRqWuO0lkQBV7YAIihZkF5AfWP3qtD6kGcKEcO0
         17eTHKbZlnZTt/06kuOifbgNiz052mQFux9AAXyM7a+YW4bdo5xmeFcU5CEs5UOnPagJ
         UdFO41NkCePIMVQtAPB3XWgxIgt2Bu/sGnGQRbzkehJbkSK60DsndWp49t12QZbGkPje
         lazg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786658425; x=1787263225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsHG9X4LKDpidQ0lZnkR2jTteM2KBumLlfXgv3JR1Ug=;
        b=G2BTmaTpJuQsuMuOUXzLQF0mPWPH7xN7uG0WvZaTDZEchJY1VLGdl/Pmwp+JHTsezF
         N2TVgRgJMz8Vrxkmso3bjfxKps0X7TOXo0pNrJDCMBkIBpAXvLfLsvCSc724COZiPiu+
         R4EkBHEs8s6dgR1RxZkZQ7Pek8SeJ0GECVvQuK5r+tf+ZrlH8OSX9z2hKycV4sKHVIRI
         HhqXtkvRQ8JRs7IRK6bgjbU0b42N1yAu4Q2Y0VZYVjlq6dU3MxNZ0OfpbFn83a3I53ab
         V7AX4D76St/QDX5oqTXrV59WKRO1fEraJ7GWDUDQuZ5LmCHRwYkauGfYfhrlZnvopNqB
         hqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658425; x=1787263225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsHG9X4LKDpidQ0lZnkR2jTteM2KBumLlfXgv3JR1Ug=;
        b=gWEkNRVyJ9F+SMh239xEfd6VFgZ4CsU8UtDCufvJSuAGij8i9wRtluXdz/uQuvtx3+
         9Rn/BNY/vVN9CzLA/YJPa1w+cWDSNB0TWiisdp7S2jfpD2anmVyJi7vlGDLprF1wxIjG
         x7UD1layznoKVyF5p0rauTNb02poMWIY3YMi3Yi0rDh9BaYvzq1P0KTl9z4fRv1jyG7p
         7a1o7tvthZcHZSZ6Tc/VXaCjXQkothl6dwy0NwCBlAS9mRfSDFC2+XMrdztrA9aGHXsM
         XkvZH87W7SM+uf9evk3cye7oVr3seVBo6+rthMs/jUTezwAui8l2I4FNyA3JQwhCs74H
         hgIg==
X-Gm-Message-State: AOJu0YyLsbvyABZCAh2ftfHuLwCxPUU27KoUyRd/FmtBoDnT3g/8qhMK
	aLEPY4B3lw0LWeYahYtNcvLRE0lgPobsDlztKcniXlGRTPCvcU/gRcIHtT1wp8aBasT9qG6J9km
	RpQgrJP1oe56jWtsn6MPjFjpg/nHhP+E=
X-Gm-Gg: AR+sD10jB3A1SAMQT9cquxwJeRenC4IEwcDBLnlf5awmc3bguPZ6tjlJQ4/23ckOO+3
	lhIJ1aPWafdRJnJrrWRGoy2Q9Jsyj+FTzMRPZQlkBbMjnGThYqX7HrBLXJzEnyI89lUI8bGgL5x
	qoPR23Xu/5hnCDPmdCL3Z3lvpIXJJQeFI0u5iwlChU64/dKxyijoh6TCp6zkO4asvDUaeRFbIpu
	vvefE2OD4PJsmN8GT4i9Zht0c/Q8H90AQOVrOcyhs+PYriadSGlN30NGH2ZzVDdWhT0FeNQaGIa
	YUjHvbO6xJ+qSMoCPs2wqBuTz+jlkB46T+2TOh1GJEAZ97lWc5PsHob/uXGIT2WxMPBMOPVYHJ2
	SMWfsQ1E7cp3zOySe03G4UYAAeFBoseaRwOjQ4t1cmA==
X-Received: by 2002:a05:6a20:7343:b0:3c3:a722:59cc with SMTP id
 adf61e73a8af0-3cc71cc65camr919970637.22.1786658424611; Thu, 13 Aug 2026
 15:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810142224.2907373-1-chenyuan_fl@163.com> <20260810142224.2907373-4-chenyuan_fl@163.com>
In-Reply-To: <20260810142224.2907373-4-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 13 Aug 2026 15:00:09 -0700
X-Gm-Features: AUfX_mx1zLwRSFSgJHEZPI-dhLz6l7sGh0nTDR8aw3Qm6WAzKqdyZ2jS5SAPkPA
Message-ID: <CAEf4Bza9pXdT0agLs81Hqqti1vB51F01mA-MnQiEOdR3a5SBWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] bpftool: Fix bypass of the batch line
 length check by comments
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yuan Chen <chenyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 7:23=E2=80=AFAM <chenyuan_fl@163.com> wrote:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> do_batch() strips trailing comments by truncating the line at '#'
> before checking whether fgets() filled the buffer. If a batch line
> longer than the buffer contains a '#' within the first
> sizeof(buf) - 1 bytes, the truncation makes strlen(buf) smaller and the
> line-length check is bypassed. The unread remainder of the line then
> stays in the file stream and is parsed and executed as a separate
> command on the next loop iteration.
>
> Continuation lines handled below are affected the same way: an overlong
> continuation line containing '#' bypasses the "command is too
> long" check, and its unread remainder is executed as a separate command.
>
> Detect the truncated read before stripping the comment, using memchr()
> to look for a newline (instead of strlen(), which is also fooled by an
> embedded NUL byte) and feof() to tell an overlong line apart from a
> final line without a trailing newline. A line that fills the buffer
> exactly (the byte after the read is a newline) is not treated as
> truncated, so valid maximal-length lines are no longer rejected. Use the
> result for the line-length checks, so overlong lines are rejected
> regardless of comments or NUL bytes.
>
> Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  tools/bpf/bpftool/main.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 0bbb2e198450..337fbf1ec596 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -367,11 +367,27 @@ static int do_batch(int argc, char **argv)
>         if (json_output)
>                 jsonw_start_array(json_wtr);
>         while (fgets(buf, sizeof(buf), fp)) {
> +               bool truncated =3D !memchr(buf, '\n', sizeof(buf) - 1) &&=
 !feof(fp);
> +
> +               if (truncated) {
> +                       /*
> +                        * fgets() filled the buffer. If the very next by=
te is
> +                        * a newline, the line fits the buffer exactly an=
d is
> +                        * not truncated.
> +                        */
> +                       int c =3D fgetc(fp);
> +
> +                       if (c =3D=3D '\n')
> +                               truncated =3D false;
> +                       else if (c !=3D EOF)
> +                               ungetc(c, fp);
> +               }
> +
>                 cp =3D strchr(buf, '#');
>                 if (cp)
>                         *cp =3D '\0';
>
> -               if (strlen(buf) =3D=3D sizeof(buf) - 1) {

just move this check before you overwrite buf contents. even with
comments, a reasonable line shouldn't be 64KB long, no?

pw-bot: cr

> +               if (truncated) {
>                         line_too_long =3D true;
>                         break;
>                 }
> @@ -380,6 +396,8 @@ static int do_batch(int argc, char **argv)
>                  * with '\' in the batch file).
>                  */
>                 while ((cp =3D strstr(buf, "\\\n")) !=3D NULL) {
> +                       bool cont_truncated;
> +
>                         if (!fgets(contline, sizeof(contline), fp) ||
>                             strlen(contline) =3D=3D 0) {
>                                 p_err("missing continuation line on comma=
nd %u",
> @@ -388,11 +406,15 @@ static int do_batch(int argc, char **argv)
>                                 goto err_close;
>                         }
>
> +                       cont_truncated =3D !memchr(contline, '\n', sizeof=
(contline) - 1) &&
> +                                        !feof(fp);
> +
>                         cp =3D strchr(contline, '#');
>                         if (cp)
>                                 *cp =3D '\0';
>
> -                       if (strlen(buf) + strlen(contline) + 1 > sizeof(b=
uf)) {
> +                       if (cont_truncated ||
> +                           strlen(buf) + strlen(contline) + 1 > sizeof(b=
uf)) {
>                                 p_err("command %u is too long", lines);
>                                 err =3D -1;
>                                 goto err_close;
> --
> 2.54.0
>
