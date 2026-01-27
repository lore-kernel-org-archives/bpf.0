Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925B2D7BF
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481828; cv=pass; b=lz20tpUOazb4EjN1e5sNrYrmOR6abCouWPvPOkM85629on8v7s/aLKFhpetqrvAoFTUJhElasmwHzHfD+H1LjEmfF3PMgSqwpfTgAL17JM41d5DEkbKbTQRQpU/H090CEPu89pS71hnJJw0xQkUTpOssDNNKkx5vDzkGJJMwqFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481828; c=relaxed/simple;
	bh=BvbEr7o+FAIoZ+8+sAFL5GGnCQGVrASlVNUsngs9qy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqPEyGm0Nd/G9BQh0spHuFlIwe3oqE92U+Laom+s8nwNz5h48dp7vCWSkGC2nLITDf5/aNsV/1Fm8iWE7Hb98eO5u+69Sdu0oKLp2FVP9zLmxuDwEbhD+jRtNCAKp2bx4Y1Dzruu+gpxukyS0vgQ59oL1SL6d7K1QY0y3PiADgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmYFXohr; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmYFXohr"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4359a302794so3177440f8f.1
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 18:43:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769481825; cv=none;
        d=google.com; s=arc-20240605;
        b=NThloQV+FuOLigK5Db0Ftpgn/gzO6kkk7/VGTdHh9MBf9rbze7xAxOBtg6DsPipWmX
         jKkZeNGGnYeJSrCWejgSIif82U7Kkg5LoTX1ccXNR4Gccdg2KQoRoHJfk12CfnRwxvf+
         8bRooQHDwu+ITa1qm1uyr0gub5OrOab8o/WH3IqNDnpvGkHDmuybq8GcfcijMislj6sx
         r7egb5H37AvFfuOx+l5z1ubOygCsrKErBeIJfFun/CztBN/HgvzHc2tRFX7+nEbFHUWb
         Lijkn71od2Xok/8VKI69iv0XSBVFZGecBnCc2AkplEl9dP4lT232lXOppMQm6HB15R0C
         znWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sNWYftb3y5oZnnbsPB6EKKeLAdQS5y4v0pCFC0lgynQ=;
        fh=Qwi4bkM/TcZNakyBIOP2hHL6j49r9ebjziY5QnZErxA=;
        b=j2hU8O4mqvHR3DU4weYVrWUXR8357w7vwyD3baet7fiBE5HH+ldyA3U17tf3Spl9sL
         f73iq/af+bhRuksr9Ktor+gwVjLRBcOvkKYYJm4M7PLaHbT+kBaOcqzH7tRYbvdhJvvi
         hNCzzcwmhg7YRuW1bO86ihpWyWlctZEMTXBAvShZDjs4mGW6m0P0C3oGqQEh35cLq6PL
         vQQQxxZypKMIzV81fY7R5LT07BHMw1bBYOJbIfjEVZ8/Y9yPwX24UG8QLBGx9JSoiXcv
         +26c9j+PDmeFeagnzC5vdJ/LrrYYARKUO/Zdyim2B0Ag+soTGrrXRLcNOuEXsW3ssrPA
         nK6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769481825; x=1770086625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNWYftb3y5oZnnbsPB6EKKeLAdQS5y4v0pCFC0lgynQ=;
        b=mmYFXohrl4Wb8lb3KVBWlYEjhtkt6DQAYXgiZEeYsgQb8Q7d5KKbgZnL0b5dids1hh
         HcF6B5chDd1sgwqXinDQGS22V24TpJNDauCMwztWln3V9ad6UJD+KUaZjT9aAqrlkMd4
         OA1yQ+IBK58EAaVFs8IiR1hVqbjDU5kf+om+Udkd/CYiYuIFzTfN8BcefAfzfQmmQiJL
         vhWJjO9tQnu9sXnrCBD4GnR4dyeki0Te2Qyojyan2s9qHXmDqa4GES234LPRTLcHm6gp
         eZGdf42XjAMSa3osUk5fDNzzlZwH9mI8gAGZDagbVfSQc3faP0mJ8o33dKr6ApXMcUCu
         pYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769481825; x=1770086625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sNWYftb3y5oZnnbsPB6EKKeLAdQS5y4v0pCFC0lgynQ=;
        b=Yzk0M3ZlFUAb1DQE1XXtWFAhnxzYN//Tz4z4ruiuJf/DNENCyCROCCGLqhRDXrLOLy
         fi0pU3srQc/3jDweiQTfB6yUpYLBgoO7pzXYvd0+7/lJ0MJE5E8K74FoA/a9D9QotnUS
         41IssJSlM1ca5jQWX1FReegPayzARBSc4Oxwiof8LHl9LRP/Cm6Rn7lHyQ9hBRIPpYJB
         Ls0UyGaF8wKdvJLaxgu4LGOcn0tZu6OaGl+fr+aSdVTA2dvtgJ0rqezcUjUo8G3ws1FF
         JjUzHnO1Tjvofp8FJmuzLLN2WyH77sBMvPK2It1tGAKwgdMJfztiMkZmmh1wxs8TobY2
         jKBQ==
X-Gm-Message-State: AOJu0YwnbbjSX0E/coZXPy8G0MADaEwzrQJEW1r9ubNgYEyo3WBEAJ6f
	IETdaJJPFvME9lciudkr5p2O5UJP6n51MMXW2qlDosqsx6k++fe6dqoCpibZ+mSWcSpNHIJLOUx
	i93mlPNrqz/rgo7QDF0LDoy+HCwzWksg=
X-Gm-Gg: AZuq6aI7I3UhAlgfoRzmst5gdSA01dTp24mcaPz1ltKmbHpuiUZ1TcY1rDUDThAQLgA
	IYrLiMbUyQSSxJZswyH2n1vZsTjzTmGi6bEgPfJ8RG4K/8xFcmNMb6/dmOr1aYmhDya9eD95Qqv
	1Y9Pz8UQUjO+129SBniQo85aoRVQ1zna0x/EI92M2zA1B4ziKzQbIqsl9ru7YbCJGbG5ehMRteB
	LdE8uhL5y4YBcRVBKmzCgT+Adkx8UFmS3hoel0yEjgvnq4IPQe9SwxXSBPZiUnp0FsVo5h7TZTD
	KikZlFQ0btnIEZjgcAn4trIcdHgIdMNK5JyypaY8LzNs5M8gu9hDLlEmlQDr39uI1vpvzFvAPyA
	MCCmyprnrJY7vHuxr3VRnSTCh
X-Received: by 2002:a05:6000:a8c:b0:435:bbd7:185f with SMTP id
 ffacd0b85a97d-435dd029a52mr105023f8f.9.1769481824811; Mon, 26 Jan 2026
 18:43:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126151409.52072-1-leon.hwang@linux.dev> <20260126151409.52072-5-leon.hwang@linux.dev>
In-Reply-To: <20260126151409.52072-5-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 26 Jan 2026 18:43:33 -0800
X-Gm-Features: AZwV_Qjob0hpI61E7bKlmlYJJVAtwCwP_z812BtK6il96WSFPg5NoRPUSzKlj9k
Message-ID: <CAADnVQ+PDCV=YrFhxG3gXPC3jDPdbTmsaAOKBsFceKgEware0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/9] bpf: Add syscall common attributes
 support for prog_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
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
	Rong Tao <rongtao@cestc.cn>, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

,


On Mon, Jan 26, 2026 at 7:15=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> The log buffer of common attributes would be confusing with the one in
> 'union bpf_attr' for BPF_PROG_LOAD.
>
> In order to clarify the usage of these two log buffers, they both can be
> used for logging if:
>
> * They are same, including 'log_buf', 'log_level' and 'log_size'.
> * One of them is missing, then another one will be used for logging.
>
> If they both have 'log_buf' but they are not same totally, return -EINVAL=
.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf_verifier.h |  4 +++-
>  kernel/bpf/log.c             | 29 ++++++++++++++++++++++++++---
>  kernel/bpf/syscall.c         |  9 ++++++---
>  3 files changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4a0c5ef296b9..7eb024e83d2d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -637,9 +637,11 @@ struct bpf_log_attr {
>         u32 log_level;
>         struct bpf_attrs *attrs;
>         u32 offsetof_log_true_size;
> +       struct bpf_attrs *attrs_common;
>  };
>
> -int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bp=
f_attrs *attrs);
> +int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bp=
f_attrs *attrs,
> +                               struct bpf_attrs *attrs_common);
>  int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_veri=
fier_log *log);
>
>  #define BPF_MAX_SUBPROGS 256
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 457b724c4176..c0b816e84384 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -865,23 +865,41 @@ void print_insn_state(struct bpf_verifier_env *env,=
 const struct bpf_verifier_st
>  }
>
>  static int bpf_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_a=
ttrs *attrs, u64 log_buf,
> -                            u32 log_size, u32 log_level, int offsetof_lo=
g_true_size)
> +                            u32 log_size, u32 log_level, int offsetof_lo=
g_true_size,
> +                            struct bpf_attrs *attrs_common)
>  {
> +       const struct bpf_common_attr *common =3D attrs_common ? attrs_com=
mon->attr : NULL;
> +

It seems the only point of struct bpf_attrs is to pass the attrs
here and remember them in bpf_log_attr.
It looks unnecessary. Also the cast to void and back to actual
type doesn't look pretty.
It seems all of it is to do two copy_to_bpfptr_offset() of log_true_size
in different places,
but libbpf will use only one, so let's do only one
copy_to_bpfptr_offset() and simply the whole thing.
struct bpf_log_attr only needs
  u32 offsetof_true_size;
  bpfptr_t uattr;

No need to introduce bpf_attrs and bpf_attrs_init() either.
When bpf_log_attr is inited make the choice of uattr and offset.
uattr will point at either new bpf_common_attr or old bpf_attr,
and offsetof_true_size will have 3 possible offsets.

pw-bot: cr
