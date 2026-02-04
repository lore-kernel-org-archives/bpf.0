Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084B7365A0A
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234530; cv=pass; b=R9GgVui0oTYHcCDGim0t67TFVqtnlrf0O5G8AObtX3R9F//a0zye4WRLCWUjVZVLdUc4XPb2rQLU6Ghdeao8J933cTf5g8GrKgmEveqeisDCg+oUXC+AEI47nIMsaB9bCxc8kJsytIjKrorGJl2JAwzDeFC2OhbCsSOd75zGs50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234530; c=relaxed/simple;
	bh=JSaxY0XhGcOSeu31HU5l9vEV9baQLzqFjwH/9t5p01Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTm3mLLzsSjLAcZD5V14OA0N1MovQN3ZWJkcY2R7NIdVzmd5jVpLMGtOQsHQduoAhLCiHF4HMoZj/GjH91255wDJNrhqSzwmh7JUYA5tRxTiSiRXg+m/PvQMKOm4DuCeWKd5p3bsn8ACQQxgPqX1kxnDg/qQ0C+s1+ZscxwM2WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZSCuhXh; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZSCuhXh"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3541fd9dacdso105138a91.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 11:48:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770234529; cv=none;
        d=google.com; s=arc-20240605;
        b=Vxy44x60TCpS9khABo5XhlxUL6Cd1OfsHUv+iMmGio8vTSs4QUgD3Wh9oKiWD5DtWN
         fUVk2SvHf3nvD4eABFl+AH7kqak4ZqBo1NCKKx24Dkm6fyjwgNqpZFAZvi34OCT3ABgN
         hoKQnKHB05pFXxbtGPpSLdPgjHMjbQwCxH5uanunze1ZknMQm/gCje2B/95Ds1x3T0rt
         m92MMSABaKWnRPQubBqEHSJygH69AtnYn2iKwQs/AQPkBs+M1IlTblPcxfoRbBDEibaI
         TosHHjfGTSXCZRwnwt0G1CPyHblXyHbxxPnTBwdq0bJOBiV6p2ODRnb2HyKz158DCvKD
         yA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BqaY+jlyASjji0VRhimoxVMsJ9WH26mRw0zvhRsW3No=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=AyxG6mYARav9hCSRaUHL8fOd/laNNmigYkOxzeJIhTK/FVovRgSeFdOF2br2ayXqCS
         wo1nWoeDVWu4d4IOV0cbpIYONdokGf7fmRA+aJrhiJwbk2eN8QVpXtWpJGSwpZpa+888
         gM7i4Ii6lBjUBY852NStUCDiPaBG9TLxnmrdOSfVKWHw5xdI+FDy2RE5bhDSxHYSo/R3
         pn7bNdyEMVNg0czG6qwu9m7BnUQxq9/fvV/BM3Glco1k4/0Q0sofC/TzSECHBdBahP+m
         pXMoaMQs6bmysB9vuw4YKedgXAWMPSZKTF0cjLUSI0O3YxiMDx+Nmq9pJmJryHX+wk4X
         6yaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770234529; x=1770839329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqaY+jlyASjji0VRhimoxVMsJ9WH26mRw0zvhRsW3No=;
        b=cZSCuhXhrLuGSUtbz2sXoaUexxUrdVT5NLcOZSxKfRSXz2r40fpreN8Uyr0IpV6SA4
         s0f+W3L3Spda6QeznSPfysNNysYSlHtXFyhK+RtrsPQCEgQKDz+EnqgAlp4iuYLFeLvy
         uN8nvfj9kIkn1C0RrONtWHbIeOZGRLbl/J2RDyl94fHK6K/CB5ZDz0dZQf8TDU6dTHqc
         6ksOOv8UlMzrOh/4yJN7X+zKB/0EPBMml9cjCYp0cpZMpOHxVLU3mV+MDcA9/IBxQC/0
         e2+QdyWUkeHwzoUuqFOvoy+veth0Tv5a2zLDvFgsStpVT+iN/KxCuBYvD5pjlIc7NaUA
         Kxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234529; x=1770839329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BqaY+jlyASjji0VRhimoxVMsJ9WH26mRw0zvhRsW3No=;
        b=duKoVp4VRqgQXWZ52A+Q2MTVrq+eg77Do7/VBkbsFpO0TPi/QSJky8SUpav57rrgK+
         HyM54zkWHfugDmEaE18vD7JkW6QjnDh44arxhFIKmhH8Y4quAG4y6tosjHP3mx2stVcp
         thCD87DjmUm4L95p8G9jGFzk/b8FwjbL51kYXGku9yTIhxNUL2zi71znQ1T2pKREAqzD
         HGI3GVeeKrZ/PNbUf1pkzOGKAVp0XONM0zbNzT8M7V/DJAVvJx6+flWPPaSyZsz5Y86q
         eYjQKrzIPrT1t1iAwRkux6DMMDG94WlvL45YnhGBZRJl6h7xYEdL+inCJOqCM2+wIkMy
         DPSQ==
X-Gm-Message-State: AOJu0Yx1pOKNXeDuIFASOA9bg7engKunytWn9+WmD5v8w+uEw1BdcCwV
	m4d04IWEWpsAdTi/5n1cjpT4NaAG2WhG4FZhjy0/7GQnzVFfVQ6rkOHC6HywD07lImcZKGwk1ep
	j4NCCGfVGOYTZPgHPQVTT5JL/Np2PpVM=
X-Gm-Gg: AZuq6aLiA3lBdz2QzZbSPtpzeUrHthYZ7l6icF1FlD0aFw8BpRhfVjzSbqGPI3WRJm9
	kbwvJ8ChYj5xJb56dSFUrUrpUzze3kPqrWj0CozCy0a47sCG/hgZcpz9x4ApYy8jWv/fdS4oJOc
	2G5rT6frIrUgpdG+cVXzhDZNOfQC8szuYCsaWN8+GZqrV3zmv5tD9fFphnmtZHpCbtafOHCgp+k
	HHn2+PRAIfcosybynqQ9136+dcNTVEbUhpOhvdBBwRtDhfJp5zigc5uSkVkxT+5vKECFo5guYw1
	DeVYqF7V03Q=
X-Received: by 2002:a17:90b:2b43:b0:352:d0cf:9d18 with SMTP id
 98e67ed59e1d1-3549bafc8d5mr399008a91.5.1770234529339; Wed, 04 Feb 2026
 11:48:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-9-leon.hwang@linux.dev>
In-Reply-To: <20260202144046.30651-9-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:48:35 -0800
X-Gm-Features: AZwV_QgJy7fB-V7u2aIUi_WBvMRT4bLPItNSz_ncka0FXGNgBUOJOI58gJ1sfVA
Message-ID: <CAEf4Bzb=96Ja38VGBr9YGGSSjaWwhkfH_oWjMJULykA-a7jZxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 8/9] libbpf: Add syscall common attributes
 support for map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 6:43=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> With the previous commit adding common attribute support for
> BPF_MAP_CREATE, users can now retrieve detailed error messages when map
> creation fails via the log_buf field.
>
> Introduce struct bpf_log_opts with the following fields:
> log_buf, log_size, log_level, and log_true_size.
>
> Extend bpf_map_create_opts with a new field log_opts, allowing users to
> capture and inspect log messages on map creation failures.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c | 16 +++++++++++++++-
>  tools/lib/bpf/bpf.h | 17 ++++++++++++++++-
>  2 files changed, 31 insertions(+), 2 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9d8740761b7a..0c3e40844d80 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -209,6 +209,9 @@ int bpf_map_create(enum bpf_map_type map_type,
>                    const struct bpf_map_create_opts *opts)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, excl_prog_ha=
sh_size);
> +       const size_t attr_common_sz =3D sizeof(struct bpf_common_attr);
> +       struct bpf_common_attr attr_common;
> +       struct bpf_log_opts *log_opts;
>         union bpf_attr attr;
>         int fd;
>
> @@ -242,7 +245,18 @@ int bpf_map_create(enum bpf_map_type map_type,
>         attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog_hash,=
 NULL));
>         attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_size, =
0);
>
> -       fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +       log_opts =3D OPTS_GET(opts, log_opts, NULL);
> +       if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTR=
S)) {
> +               memset(&attr_common, 0, attr_common_sz);
> +               attr_common.log_buf =3D ptr_to_u64(OPTS_GET(log_opts, log=
_buf, NULL));
> +               attr_common.log_size =3D OPTS_GET(log_opts, log_size, 0);
> +               attr_common.log_level =3D OPTS_GET(log_opts, log_level, 0=
);
> +               fd =3D sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &at=
tr_common, attr_common_sz);
> +               OPTS_SET(log_opts, log_true_size, attr_common.log_true_si=
ze);
> +       } else {
> +               fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +               OPTS_SET(log_opts, log_true_size, 0);
> +       }
>         return libbpf_err_errno(fd);
>  }
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 2c8e88ddb674..59673f094f86 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -37,6 +37,18 @@ extern "C" {
>
>  LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
>
> +struct bpf_log_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibil=
ity */
> +
> +       char *log_buf;
> +       __u32 log_size;
> +       __u32 log_level;
> +       __u32 log_true_size;

please mention in the comment here that this is an out parameter set
by the kernel

> +
> +       size_t :0;
> +};
> +#define bpf_log_opts__last_field log_true_size
> +
>  struct bpf_map_create_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>
> @@ -57,9 +69,12 @@ struct bpf_map_create_opts {
>
>         const void *excl_prog_hash;
>         __u32 excl_prog_hash_size;
> +
> +       struct bpf_log_opts *log_opts;
> +
>         size_t :0;
>  };
> -#define bpf_map_create_opts__last_field excl_prog_hash_size
> +#define bpf_map_create_opts__last_field log_opts
>
>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>                               const char *map_name,
> --
> 2.52.0
>
