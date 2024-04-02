Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1C15AAA6
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079998; cv=none; b=XpRW4m8OLQLwKHDxhXjpKNCYZ/0CLehUThjMdQIEiE7PLL/s7Kd+fuiU/NEDm3/ZHZyYVDoK3HFSiWik5XEXDvWBwxwxF8eahTQ2KwGxcDI7tpsxZJMb+Ob5Z6uGgabTLmZRFLoG3u3xapTcKysNow4u7Gz4QbYV8hltBzVyYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079998; c=relaxed/simple;
	bh=6mi3pVAvD3Q4PM+OZ1GVCrMhMfiqrphwtAcgjan/OSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLburIG9ZPp2uDzzyPULlG+WuMNGDBUnFaUzcMJis/h1YOV0519b3WU6oTAevDOY2tRMI8tmUlMEeEdS8vRI8UosBI6HhAB0P45S7Ste6WQ4vGswxwm5gljjburuaK2Qol3lMy9cGo1DrvT6MaGOMl+QUDmaGO2HosoLCekbrf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moP5+1Xw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moP5+1Xw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0878b76f3so1015955ad.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712079996; x=1712684796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpPh5IKM9rnUapg2pm24l/YbDoz9NLFl44TL+FMMvdc=;
        b=moP5+1Xw1E6Arm390j0N3AGKrxHn44S0nqL+JNQGHWkqV/Tt3WosuhTlOuRsGAelnI
         X31CaRyQwcgVhdx7hpkroDytPPdzxXqzz9jDjjNfD2stVpuzMSLd/8J8MSfI9NImrYtS
         wu5MznT7Aev4TrnVTE8f0chTj/dxMKeW5qHOAcSDuXu+Ue/2kzG6VOK/ev47aO1pXCbu
         CjRv/H5Wi1lEt2IIxRNs6wSIb+uolsqkqb0creczdu/+ol1mABTbXAp9cutw0ZNMjCXK
         gbBD75zT1T9ICjvS6AzUdvoLg0m/Zy49STGkbohoTuTJ0YCOAokLUAT2lySE5cp7h0Yt
         TKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079996; x=1712684796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpPh5IKM9rnUapg2pm24l/YbDoz9NLFl44TL+FMMvdc=;
        b=g30VnSS/vaUDByCBQRzjUPXiuFx1fhQwZYdebV2PrSpXBYSWrINhVLzzogU0vQBqSH
         Xh6CiACFVIBH74OizMXMP2k1aQOHZjG7tF/4zjEI53BVWT8rVzbhfRAyYNeYjKB2Hi88
         QLlsPuvNmOeZIPl5yOK11p8MpX5soeP5gzoQGH4VureKR6RWoZcUEvYcHN/5WZQRSGZk
         gPIcmKfkIMT7V9v5Q6drWX3YK+tojv+n80xml1+cwYOqUE8lw+/lX8YFTc+ZQS9BE0aV
         y3OsjQ3Z9MPPJkF+M9TUEUmwwM7mMi9rmTPhyJSwcZ/NjYiNHxdFEIQbqOc/fp3LZJce
         wrRw==
X-Gm-Message-State: AOJu0Yz8kW1NP2Bkq4bGCVs1N3w9ZCbiVc47+ScHhQiygybIImz5QbGF
	sYCgWj2QGvwR2JjfCVxblCRU5+M3Aa3snW2fz0XwKVbhiQVakrY7b0LBjO+rH6YM+JbBBDLcTkV
	hqRAczXV2e6OqXiJfnz/8m6n5U9Y=
X-Google-Smtp-Source: AGHT+IEIrCHuGWuJs6Tef8C6KdwOJr49GpUP/c4fi337HviYKlhxkDil6EUSvXdRQ7ZGcqFb8JE5WBZIj14daXn0KbA=
X-Received: by 2002:a17:902:e747:b0:1e0:cea:257e with SMTP id
 p7-20020a170902e74700b001e00cea257emr334374plf.2.1712079996138; Tue, 02 Apr
 2024 10:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326022153.656006-1-yonghong.song@linux.dev> <20240326022203.656793-1-yonghong.song@linux.dev>
In-Reply-To: <20240326022203.656793-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 10:46:24 -0700
Message-ID: <CAEf4BzZg3_D68dsb=SSasBewZ661rsZSusqoGtRQ6DDJUC-L4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] libbpf: Add bpf_link support for BPF_PROG_TYPE_SOCKMAP
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 7:22=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Introduce a libbpf API function bpf_program__attach_sockmap()
> which allow user to get a bpf_link for their corresponding programs.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c   | 7 +++++++
>  tools/lib/bpf/libbpf.h   | 2 ++
>  tools/lib/bpf/libbpf.map | 1 +
>  3 files changed, 10 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8eb2cd4ef288..e1bb9ba3d1a5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -149,6 +149,7 @@ static const char * const link_type_name[] =3D {
>         [BPF_LINK_TYPE_TCX]                     =3D "tcx",
>         [BPF_LINK_TYPE_UPROBE_MULTI]            =3D "uprobe_multi",
>         [BPF_LINK_TYPE_NETKIT]                  =3D "netkit",
> +       [BPF_LINK_TYPE_SOCKMAP]                 =3D "sockmap",
>  };
>
>  static const char * const map_type_name[] =3D {
> @@ -12507,6 +12508,12 @@ bpf_program__attach_netns(const struct bpf_progr=
am *prog, int netns_fd)
>         return bpf_program_attach_fd(prog, netns_fd, "netns", NULL);
>  }
>
> +struct bpf_link *
> +bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd)
> +{
> +       return bpf_program_attach_fd(prog, map_fd, "sockmap", NULL);
> +}
> +
>  struct bpf_link *bpf_program__attach_xdp(const struct bpf_program *prog,=
 int ifindex)
>  {
>         /* target_fd/target_ifindex use the same field in LINK_CREATE */
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index f88ab50c0229..4c7ada03bf4f 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -795,6 +795,8 @@ bpf_program__attach_cgroup(const struct bpf_program *=
prog, int cgroup_fd);
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd);
>  LIBBPF_API struct bpf_link *
> +bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd);
> +LIBBPF_API struct bpf_link *
>  bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_freplace(const struct bpf_program *prog,
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 51732ecb1385..2e5c3429b974 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -411,6 +411,7 @@ LIBBPF_1.3.0 {
>  LIBBPF_1.4.0 {
>         global:
>                 bpf_program__attach_raw_tracepoint_opts;
> +               bpf_program__attach_sockmap;

we are now in 1.5 development cycle, for next revision please put it
into a new section

>                 bpf_raw_tracepoint_open_opts;
>                 bpf_token_create;
>                 btf__new_split;
> --
> 2.43.0
>
