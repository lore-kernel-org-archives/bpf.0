Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FF1373
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769274072; cv=pass; b=Soig/JNvreDCKhDfSH/AiehCaz6lympJk6TiHCIGdf6xj3HJwijLtfjQQvFRWan0yGsJmIkJ+vvKFwmKMqVMditHb7tDPK91SKG7gOQ0DjmArjKw1Wn+8INqgrvYCgFs4sMVeESUKsh4LaVlruVr40vafy4msx9HIUKg+aB6jAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769274072; c=relaxed/simple;
	bh=nhB0kzt4a8HLM3B5OIvxbz/MUK+a/NJzQDcHuvemGSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhhP/4M0bxMgvYxZ1UcV2bqFU6X2XycifOtYnNTgsX4EB0hmVQDuHDlHqYYsrwjTmB+9UPCHbD/CrhOvY7O7I7s1yXl8VfWCO9Cq7mv7nQU/10dpjiOa5EMHVnMZ1JLpfOYWwTenniMmiRwLZb5QmH4TU6BTB2tpfFvOajvwTrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1uToMTV; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1uToMTV"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-794279c3b00so31335217b3.1
        for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 09:01:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769274069; cv=none;
        d=google.com; s=arc-20240605;
        b=C0OEgjq9g/aryISpKv22D2MazERPyqG3aBl03rcLXMFCQb4WiS23vDQcbRD9dDoQ5S
         5h+FAEugzGP2NY4v2wn08uyzgUX9Gvv05SJZ+h70eaTedCz1apbnCOLpcnKERGzzmZTA
         VskqvCXL3fGMwcdMcyr79PMNNNyDjzgAyR1ijCP2AqIkoMIS7IZJ9q2ozyuqpqeI4E2X
         6KuSmwIjXD18DQP+JtmRjF6Zvc4BaoYWZeCtZ25SGQ8ZoLtIf0GUET7HwsqjX1SfE9t7
         r6NEkSkD+PnJyzJJVrLAryMyJXZiYCARVKLtEDmjcTAhFTqzsBfszjVlPMipR2xn59uv
         ze6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y4cc8tN00CQfa5XTk2cZW8fKTY0gPHLFJSNtuF/PtRM=;
        fh=4KubPJPm/oify4h8BPjn9mdYAYp9R/C82vTyHZeZ5Mg=;
        b=gjccIsy5fX2m8Y/FYfZcMRbdCOapLrfXq8Y6fuZPArmsoz53tJG0PIx0wRbFlRYqQT
         BZTEEzV55zv8Tv5ASss39BZOicfeGW0zUZsgzQbURLnFET85h68f6i1BW6PGmGevmbdz
         Naojo+/l6W7oGXhOkRIEXOPHi/L0mECHqP/i2sRuPb1g4gmwkSDbLFqhaXGxSy2VaYSh
         mXF9cX7bTISjwIonchWP3CdOrCqNzOWhC7dOh2/AHqv0Hq3BJinwCgDp4Rt6If2fh5ts
         izjaAW0ifJFWJP9Dy6flIPSRJL1n2gY/RNjsrn1YclfMZWc7Kgj0Spsc8njzVPy5MJiU
         QFWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769274069; x=1769878869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4cc8tN00CQfa5XTk2cZW8fKTY0gPHLFJSNtuF/PtRM=;
        b=L1uToMTV3Fd+ziXhAvNqHM+OytqnhX4lYoyoMeRcDMSzpqPYkpy6b19VgLXkQ2ZwJs
         B1colttc90JO6KFdyC/q7v3HUC6nYtWG9ER+4fbnqROprhZXDgZpsHiHX4TiupCEv9xK
         DGNmu/EA2qxLBIvqwOIZmJCxIIyRMG+y49KAVMYGQMZk/V3a+uYk9fLNmHv1+uIDb0CW
         CKFgnfkJ5vfo362U9Tsk0nfBEtoGrPkDEEINtH8bKOAbjKai+JyllF0epMzWxkh7Gs+W
         DIm1T9PJ7M9SItAH1UHy5zIm96ru/rA2KTpTNOpmCbr2xvNJG/PVO3F09Yr4LrA+Lfa6
         pTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769274069; x=1769878869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y4cc8tN00CQfa5XTk2cZW8fKTY0gPHLFJSNtuF/PtRM=;
        b=rmzrqqalQjV7XX+TI7/TBV038QSLjtsp5m439r805P47fH0jUG/OxKXYv7YgjZz8JL
         HVgdbeMRQsGfxLjiX8DjKyMfR/f9+MYzyUpHD/w9YX2nB7YiDdZ/x9ylM4fvNLTthBV1
         iUcCtnRy1cXbZTig/2VpaH9TpLd6VGOP+8Lp9vwreQggwkfcY0bJH+Jntb7VVMxgGefQ
         se9D8IJcLK9xdl1mKuFwxRiii2KhfoUS3GOoUbuWwfJeGz6PtEAvshduDCD3V51vXMqo
         6i8wJX4EsQasR8zyn7pRzeb5z+m46j2cjq2Iv5sFwHnOMW5YEZnbaR2jfldVBgCznIvx
         fgsQ==
X-Gm-Message-State: AOJu0YwaPqeTs8QUnYDXiOrXCs4XwmObSljvTQ7JD6AhaNc5saq69n7t
	As1DtKnMplKBUjLbw8iJtJ1B1jG7MdvHsIen4ReUbSdYgWiJqJgp9oSlWZ3egE7eGnyNwqMtf09
	/OO6VXPCjzOKOSQMExkgEdSuYGdW/cxg=
X-Gm-Gg: AZuq6aJewUvgwESPTS+NwvWnBlz7cz8PtTkAG5Aw21/m/Ldver6sf1q5mSEBaHD7rxu
	odG+Iw0rza1J76bodFvU0aHia5r7Ah9EltYJVwK3DAsSUiue0CBBOKeKKuVY92Slu75NbT6MFfz
	HSSjbz505VPmGHGURXmGlZ5RIjIG2YIQKiOhQTi0r/MUaO/muIoKNT9vLsmMkBuN9eAi9U1qr8u
	EEQVNu8rfYyns32zSa5Fqc96Me7FwZrWBSNn7BcN8OUTgKC53uO1dW23E1HNQ96OIq+l3k=
X-Received: by 2002:a05:690e:4198:b0:649:6ae3:59d8 with SMTP id
 956f58d0204a3-6496ae35ec3mr1428513d50.16.1769274069448; Sat, 24 Jan 2026
 09:01:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123055122.494352-1-yonghong.song@linux.dev>
In-Reply-To: <20260123055122.494352-1-yonghong.song@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 24 Jan 2026 09:00:58 -0800
X-Gm-Features: AZwV_Qh5MiinBCrLn010tsNiLY6Cdg1hCXJ61QuhJw-2Gj2255BM7TxOLKykJGY
Message-ID: <CAMB2axMgvKB=_e59gHGM3MVvLotaDRuF0BJypv3GocQZ63JJBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] selftests/bpf: Fix task_local_data
 failure with 64K page
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 9:51=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> On arm64 systems with 64K pages, the selftest task_local_data has the fol=
lowing
> failures:
>   ...
>   test_task_local_data_basic:PASS:tld_create_key 0 nsec
>   test_task_local_data_basic:FAIL:tld_create_key unexpected tld_create_ke=
y: actual 0 !=3D expected -28
>   ...
>   test_task_local_data_basic_thread:PASS:run task_main 0 nsec
>   test_task_local_data_basic_thread:FAIL:task_main retval unexpected erro=
r: 2 (errno 0)
>   test_task_local_data_basic_thread:FAIL:tld_get_data value0 unexpected t=
ld_get_data value0: actual 0 !=3D expected 6268
>   ...
>   #447/1   task_local_data/task_local_data_basic:FAIL
>   ...
>   #447/2   task_local_data/task_local_data_race:FAIL
>   #447     task_local_data:FAIL
>
> When TLD_DYN_DATA_SIZE is 64K page size, for
>   struct tld_meta_u {
>        _Atomic __u8 cnt;
>        __u16 size;
>         struct tld_metadata metadata[];
>   };
> field 'cnt' would overflow. For example, for 4K page, 'cnt' will
> be 4096/64 =3D 64. But for 64K page, 'cnt' will be 65536/64 =3D 1024
> and 'cnt' is not enough for 1024. To accommodate 64K page,
> '_Atomic __u8 cnt' becomes '_Atomic __u16 cnt'. A few other places
> are adjusted accordingly.
>
> In test_task_local_data.c, the value for TLD_DYN_DATA_SIZE is changed
> from 4096 to (getpagesize() - 8) since the maximum buffer size for
> TLD_DYN_DATA_SIZE is (getpagesize() - 8).
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Cc: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Amery Hung <ameryhung@gmail.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/task_local_data.h      | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/test_task_local_data.c | 2 +-
>  tools/testing/selftests/bpf/progs/task_local_data.bpf.h       | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> Changelog:
>  v1 -> v4:
>    - v1: https://lore.kernel.org/bpf/20260120210930.2544950-1-yonghong.so=
ng@linux.dev/
>    - Restore '__u16 size' with adjusted TLD_DYN_DATA_SIZE (smaller than g=
etpagesize())
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
> index 2de38776a2d4..0f86b9275cf9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -94,7 +94,7 @@ struct tld_metadata {
>  };
>
>  struct tld_meta_u {
> -       _Atomic __u8 cnt;
> +       _Atomic __u16 cnt;
>         __u16 size;
>         struct tld_metadata metadata[];
>  };
> @@ -217,7 +217,7 @@ static int __tld_init_data_p(int map_fd)
>  static tld_key_t __tld_create_key(const char *name, size_t size, bool dy=
n_data)
>  {
>         int err, i, sz, off =3D 0;
> -       __u8 cnt;
> +       __u16 cnt;
>
>         if (!TLD_READ_ONCE(tld_meta_p)) {
>                 err =3D __tld_init_meta_p();
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.=
c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> index 9fd6306b455c..9556ad3d986f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> @@ -4,7 +4,7 @@
>  #include <test_progs.h>
>
>  #define TLD_FREE_DATA_ON_THREAD_EXIT
> -#define TLD_DYN_DATA_SIZE 4096
> +#define TLD_DYN_DATA_SIZE (getpagesize() - 8)
>  #include "task_local_data.h"
>
>  struct test_tld_struct {
> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/to=
ols/testing/selftests/bpf/progs/task_local_data.bpf.h
> index 432fff2af844..fed53d63a7e5 100644
> --- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> @@ -80,7 +80,7 @@ struct tld_metadata {
>  };
>
>  struct tld_meta_u {
> -       __u8 cnt;
> +       __u16 cnt;
>         __u16 size;
>         struct tld_metadata metadata[TLD_MAX_DATA_CNT];
>  };
> --
> 2.47.3
>
>
