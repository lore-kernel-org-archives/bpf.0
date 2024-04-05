Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBACE17334F
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712348070; cv=none; b=dIm2PPW8zFZDqG1+4ugMUGmz6ge37avvqXG5lonajD2RBJyHHnWgSgoDYovI8u/R2Iy+Jj+fJHJ8RcQxbJAJE6fg7uP9IeTRFUZb+lkBNeLkncWPDFslTXwkhqIKTWHj/lNRWK0IUV5s9zb1geO2P4vmZtZ3OTBUF6dUyt4KT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712348070; c=relaxed/simple;
	bh=XKbJl9/agIQcdKKtJpehnrVr0Kvbv+4WkJd2KMuyBl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaqOzX0OfmbB+dqWcWcx1oMn726cqx+GbuDoRnVuZng0m1JFb5WCSL8yBVaCx0hhz+dfNHelpMURSKRdHxH1q6H/w/jxU6plHj/HKEYbWid7OwljkPPShYgIZ3aseBSQyzsfoY4FUqlJmjG1aZEwX43C4Rdp/fRIbLz0qdWrJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHfR6n3d; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHfR6n3d"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a2d248a2e1so1628856a91.0
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 13:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712348068; x=1712952868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwOTW9R95lSEOVPo59KfFJBA2kGRjIcaVRI6rZOCAvA=;
        b=NHfR6n3dl/VJRsPgDB1xgQN2QSBzphHM9TvCy7s2Aq95/6qr1kxT4WrjxOZcmK8ODV
         bUdGbbe6/ZxXlxHUEGlRIttzirzFX6dhrh38IxoYHd1Rbx1KYpiJARy3Y+PZLYelO5vD
         A5c2i7UQC46SYgef6HmyMZLQLBz/U73iXGn+5rlQkooYV4nuUjRQ6n2PllrkySoYRJY1
         +fTEuiDqX4yYd3z0Gg8S+826suU6FO83j9egeDpB8ovL9xU7sVw13rGaMkmqlkkMVtXT
         HyMlXDYUaPlv9lnhAJSjw2UcmNcdq5mMB/6DNHGRn4cUb5vHIVXtKcttxQbDeoPbgjB7
         dRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712348068; x=1712952868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwOTW9R95lSEOVPo59KfFJBA2kGRjIcaVRI6rZOCAvA=;
        b=Rp2LK0F2R2Lf04xPsjVZrBlRSoH3x6MqHnaosFysFFPKP0IJoN6v6ShxqMU4vbg7qL
         ggr74xqrGf8s0cZ6fZFoL77LSqsr2jzpFs7YIuU+3gRBml5Pq43vQdKtywIXiOAIbL+W
         3a6ix4gUPQyZGo7KEZWLxoLnoFhfkGAAyYjVzOG9snY79edpWGGiBDvpBK9tXHw7FMUr
         D2587PYoOieFfYYBa2nD5Erh5lwrzWD0IFLQuyl2RjB5/p6fyMdGd4ga1xMpfNnBjD66
         uwxfDzsUO5dKWz7vrT+FGHuITsfAMTi/X/kWE2lPIjINHlr2EC7Zb55Egr8AVs/mjxpI
         xKeA==
X-Gm-Message-State: AOJu0YxlA4cb5NSU/Pc19YWjRY3QzMkLzcRx80iWjnFY0YDufFQ6X+XU
	twRknowIxb81C3tFlcm8clcjEmUtIzpFVrBDW5knzkbuN7p7ampCpDAWBxmBr2PZaWdWlpOiNE6
	WuaqzIj1FVcQrCg9e04InCS2QJs4=
X-Google-Smtp-Source: AGHT+IHtQ4dloIMll3JvrsJMFHMe2w1qhS412Sthgp5rOnjmSUd2F4UeOtk4BX+DmBODoim6wXF8laMPsq8rDCvfw9o=
X-Received: by 2002:a17:90b:3113:b0:2a2:1ec6:924 with SMTP id
 gc19-20020a17090b311300b002a21ec60924mr4760967pjb.3.1712348068075; Fri, 05
 Apr 2024 13:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404025305.2210999-1-yonghong.song@linux.dev> <20240404025316.2212069-1-yonghong.song@linux.dev>
In-Reply-To: <20240404025316.2212069-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 13:14:16 -0700
Message-ID: <CAEf4BzY-ekyrSs-Z7SXtWJtAgn4AoLfiVcYv6fip=9ay9a0obQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/5] libbpf: Add bpf_link support for BPF_PROG_TYPE_SOCKMAP
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 7:53=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Introduce a libbpf API function bpf_program__attach_sockmap()
> which allow user to get a bpf_link for their corresponding programs.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c         | 7 +++++++
>  tools/lib/bpf/libbpf.h         | 2 ++
>  tools/lib/bpf/libbpf.map       | 6 ++++++
>  tools/lib/bpf/libbpf_version.h | 2 +-
>  4 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b091154bc5b5..97eb6e5dd7c8 100644
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
> @@ -12533,6 +12534,12 @@ bpf_program__attach_netns(const struct bpf_progr=
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
> index 51732ecb1385..015737439007 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -411,8 +411,14 @@ LIBBPF_1.3.0 {
>  LIBBPF_1.4.0 {
>         global:
>                 bpf_program__attach_raw_tracepoint_opts;
> +               bpf_program__attach_sockmap;

leftover from the previous revision? please remove

with that:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>                 bpf_raw_tracepoint_open_opts;
>                 bpf_token_create;
>                 btf__new_split;
>                 btf_ext__raw_data;
>  } LIBBPF_1.3.0;
> +
> +LIBBPF_1.5.0 {
> +       global:
> +               bpf_program__attach_sockmap;
> +} LIBBPF_1.4.0;
> diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_versio=
n.h
> index e783a47da815..d6e5eff967cb 100644
> --- a/tools/lib/bpf/libbpf_version.h
> +++ b/tools/lib/bpf/libbpf_version.h
> @@ -4,6 +4,6 @@
>  #define __LIBBPF_VERSION_H
>
>  #define LIBBPF_MAJOR_VERSION 1
> -#define LIBBPF_MINOR_VERSION 4
> +#define LIBBPF_MINOR_VERSION 5
>
>  #endif /* __LIBBPF_VERSION_H */
> --
> 2.43.0
>
