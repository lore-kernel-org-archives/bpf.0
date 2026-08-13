Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FDF4756AF
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658180; cv=pass; b=nqXyOX1GhFo+KGkldX4+NG4Ux8kG8DlAlZzWWaFEypY0WBOsOpVnlefnIYydnwbLN8SX6PjQeYSdONOVgziM4cRntT3s/tXsI7zb7GPlv32mBc1ux8IKZTza/Rt2KTtdulIzhpHXElMU1Y/LZFgibhpcCF56QGXm/8XvDqc3GdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658180; c=relaxed/simple;
	bh=muumyhIl9f1IYDOMRJfrBpuxCj3NB4nZD2jktBqzqbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGm2F47jcCgKkv5/3ZNPFJaBIbnRDHnnV4MT8SruxCRLM41Bcyk5ScL+sQwJKVdtE0gNUWQIl72E+bO19D5TMHTEbwk0Lf45SAGaszLVvq4YtVnUvG05OobfOEluqcaCKedSGNTa1sHdig4QxZEEufZnQyGlwjBY1ijOgMzipf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AP1Gf50e; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP1Gf50e"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso216626a12.2
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786658178; cv=none;
        d=google.com; s=arc-20260327;
        b=KjPMtlwQC34/4GDnQjYyMQnQo5H3dndmjmXLbVkMOoXOr5PpgyOhNMgeeoBLLJOEVI
         k6+k43luacvMVDqsjpcsFxx1hYUgdqFRR3wfyXu1FA6PnKoPenQg1QWfOHo3mgRRXXZ2
         FLFbf3IfKp45ZyPIaCF7iEWU+ZH6+dgqZ8RJZNgNfDmnpia1anbU+Ecft4hm43/R2i7d
         XFwAaKLenBNmOpqIxGR+/RzD6aTw0lsBRFTzMT9OihMZq6hL2rFWjN3Dat7JxGuheaaP
         rSbCTXfTOgFrvbV69nrG+AV4Hpg8Aru/npNTsvaHy0b49oFCerIDrvDbSBtM37Am1QiT
         yt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1wHxrnrtaEIvtLxw94Zf2NeRdOVpMxJFJE3qVdibgoc=;
        fh=2g8ZyObSs38UhAj8kd80vpxj+W332ieoAyB+PfA9NvA=;
        b=NaZzaC721ncjBej/fi5amY2j+rvLFSwAGwXA1YK3LaVydONQfuO0LYG1FQzT2klPRo
         qYlhXc4QLKeZ14jOJf/hZVz7P5g/BADX7E+f584qplnCoTT3ZVcmjJEZOHM7AIntTRLj
         4YmcctTuayHknnrq9Lgsn+rarQRcYWEI9EnaojZb3AV+EY1EG+ot/KEchr711C1qK1Ks
         Pk1ICETw4D0AeJARKirLbAa/HqJZao2IrFe5MBMhcM/OFTY6yc8OrXPCUkpsDtsFjnLH
         jM7YTP84zUzVvImUnSJjwZTYUEg0R6SPZUXtbnxDeOQeY7BZN5JE5mjDDpM6PPzrfFI2
         tP/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786658178; x=1787262978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1wHxrnrtaEIvtLxw94Zf2NeRdOVpMxJFJE3qVdibgoc=;
        b=AP1Gf50e9kcnYwPUuwU0kNz+JeuyN+Ts8suo+AlSmb6NQ3bgh7M5BIK//7qppb4NXG
         2v4ZpGRV+J8wwDDqV/fQ3j/Nyu3MCJnAk8UZGKGczTe1ol9wL34606xgZ1zYqov1Myxt
         rFXcBSFJpVR8IdR9PZj1f/oBaa2BKh2ULkBfo7RGAI3f+Z4dYSvQv1NGsNW3kgSJQ+kR
         rIKsKitwIToV6p++GNUvLpfSktbtH82Vwk+RdlXxC6iFlhCf22MVnBcHMlqOkbzWCX4r
         aTN6sFuPOo5vLE3i4Q3TPZWuOfuxC72tgG/4z+G0DiuQUJoy9/5MMvLg2BJQ36F3Aq1b
         C8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658178; x=1787262978;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wHxrnrtaEIvtLxw94Zf2NeRdOVpMxJFJE3qVdibgoc=;
        b=YJcRvmnW7ttjHusziFdjQOn8xjRmN0QY8d9+P9yHMpgO6o8sE0LPIR0mnBGTCmSCHb
         m+DEXa4WfLj7BYgFr/bYOSaI6jUIQ6UzJRWpBd5h2LDZNWQrytrEo2juTtX11W4xjbqi
         feXe7kMcxuKb/Q6PCeDmfcLBd0RDBq7L/ARKCUK0UxLeV0ZS7Ae0Pis8dhmzkvLpsUzU
         exMPhqbG4SGodUfOuMuhDpTE8g/XbsBpxz+S3XqrnD134gWZLfJ1dCWA4mjKXeSw2s6+
         3oYIw/9BX3DzbfbBlO2g1YXJXBRx7O4yz7+ArooA9SReoXPh8HpSyVaYk9BPQ8SFAYN7
         RoTA==
X-Gm-Message-State: AOJu0Yz3FaS/gbJ2sw2cXPi1gr0Wj6TOjW94WLBm8cTcsM5OT4iuqWFb
	NrA3HkN++Ta2WY1nf8mPF9JfSiXnJtUYTPRWdguZyJYhuhbKKh0EdlkssjLhYs6liiAxTHwCXxJ
	rQjtsbgTIeNxv7WNThlv+v4I/3c4eFt4=
X-Gm-Gg: AR+sD11aH2ryr6W+qHrPW08vxk6tZcRnJOvgLyGoCJfxPp6S5aX1E8mO+x8jxlWF1Jq
	NUhKhYpI4Agt5mX+8srqV7l6ZSuI+ErfL/+of4XsdVEcwoS17G39F8UxYxtBkG6vNXUCA3Jxipk
	AFf9zpLOCnjbuj/kn3nXIePBL9dJ0srW2MtDsomrlovmBeKgsTN9Te7YRNU7KyojAwtELHhPn5F
	7qtQVayjmK57lURqSvtlETUOM1rXGw3BDwmChBPOgIfke8pm1W0Mb8AlMbrHPk9m0Ffh7GR/K9R
	avrhOHRGeZosNmk/48RncnKZL1j2JNL2d88gUfprECAAr3uuubIZbYHkqCxbg7GZ5Br6iqeS8TJ
	qthinbIvKS/V9a43ZEZoj6I2gIZUOx5Omso2XMObfODOfsvRPBW+V
X-Received: by 2002:a05:6a20:914c:b0:3b4:5c70:ca3e with SMTP id
 adf61e73a8af0-3cc71da42f8mr710836637.25.1786658178306; Thu, 13 Aug 2026
 14:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810142224.2907373-1-chenyuan_fl@163.com> <20260810142224.2907373-3-chenyuan_fl@163.com>
In-Reply-To: <20260810142224.2907373-3-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 13 Aug 2026 14:56:03 -0700
X-Gm-Features: AUfX_mzeOFQPwzoSq4YrTmNVLwpulAmsNla1zHlXylDtdTlGA3wDJSRi02lPEU8
Message-ID: <CAEf4BzbT9_X8drBx9ioa5cDL-Voe+KC7oApNJCSgdV6-ZqyRQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] bpftool: fix spurious batch file read error
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
> do_batch() checks errno after the read loop to detect read failures,
> but fgets() does not clear errno on success, so a stale errno left by
> a previously executed command (e.g. map dump's EBADF from a double
> close) makes bpftool report a batch file read failure and exit with an
> error even though every command succeeded. Use ferror() instead, and
> track the too-long-line case explicitly.
>
> Since do_batch() no longer inspects errno to detect read failures, drop
> the USE_LIBCAP errno reset in main() that existed only to keep errno
> clean for the batch mode.
>
> Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  tools/bpf/bpftool/main.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index c91e1a6e1a1e..0bbb2e198450 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -336,6 +336,7 @@ static int do_batch(int argc, char **argv)
>         char buf[BATCH_LINE_LEN_MAX], contline[BATCH_LINE_LEN_MAX];
>         char *n_argv[BATCH_ARG_NB_MAX];
>         unsigned int lines =3D 0;
> +       bool line_too_long =3D false;

it feels wrong to track this specific error explicitly. we already
have err, so we can check that err is set and then look at errno. or
clear errno before fgets(), some variant of that maybe. but not
explicit bool like what you did here.

I've applied the first patch, but please iteration on this one

>         int n_argc;
>         FILE *fp;
>         char *cp;
> @@ -371,7 +372,7 @@ static int do_batch(int argc, char **argv)
>                         *cp =3D '\0';
>
>                 if (strlen(buf) =3D=3D sizeof(buf) - 1) {
> -                       errno =3D E2BIG;
> +                       line_too_long =3D true;
>                         break;
>                 }
>
> @@ -429,7 +430,10 @@ static int do_batch(int argc, char **argv)
>                 lines++;
>         }
>
> -       if (errno && errno !=3D ENOENT) {
> +       if (line_too_long) {
> +               p_err("reading batch file failed: %s", strerror(E2BIG));
> +               err =3D -1;
> +       } else if (ferror(fp)) {
>                 p_err("reading batch file failed: %s", strerror(errno));
>                 err =3D -1;
>         } else {
> @@ -467,16 +471,6 @@ int main(int argc, char **argv)
>
>         setlinebuf(stdout);
>
> -#ifdef USE_LIBCAP
> -       /* Libcap < 2.63 hooks before main() to compute the number of
> -        * capabilities of the running kernel, and doing so it calls prct=
l()
> -        * which may fail and set errno to non-zero.
> -        * Let's reset errno to make sure this does not interfere with th=
e
> -        * batch mode.
> -        */
> -       errno =3D 0;
> -#endif
> -
>         last_do_help =3D do_help;
>         pretty_output =3D false;
>         json_output =3D false;
> --
> 2.54.0
>
