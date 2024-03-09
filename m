Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD0EA4
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946081; cv=none; b=kXLAsI2ouFTlafYjsnHqrsurhCRvpVb0GlOCcCyWosBCTAs1XSaO90oPstWawLKKpA6+Yb/AHweIOgX0sH/EJPR2eWWju3/+DWI/Z29IN3SjmPc5gAf3FAZpRuxtbV+wsgi+IS49qrKU6qr6hWnEsHlxxCDeF579dFZl70RuqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946081; c=relaxed/simple;
	bh=02JDVDiubz78KYRygPqWa0M2HgO+RcW+Fn36gm9ITCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sn+7+MA65PAT/CSpb4HjMHeF5aClxdcrENNPl21F+HOsA4rSdqpUlyg/huPvOG0TgmdGwfYz2Wx+ZR97oFcC7yzpX0R3j+MXqxkIYwgkDsrciXcrYKTe9m3rWSYAYU9CXHIDlKVrZKQdDPbLwmqcFJMJZTOpgNC99viBsk/AuYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxKrDauw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxKrDauw"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a45cdb790dfso306371966b.3
        for <bpf@vger.kernel.org>; Fri, 08 Mar 2024 17:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709946077; x=1710550877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZAm0Tgx98b87jNznQKbIh24x5ADZ/9jsinWkEdrtEU=;
        b=cxKrDauwXkpRkErOTS60RnDxptNLeahFQNoO+vWEIiyqr7hTTgUi/52p4TTjN5egbR
         NgCknBvK+Cyo7qMDujOnrHL372BdtTL6BTdMmTJ01lMW3tw8wlKbNAAKd4KV5O1xaiFh
         5DCZbN+1p+RQUSKupVsKp5+Qir5rf8QpHIPa6PJ8+01WII2j5YIZRQeXk8IUfJtgkWPm
         V6R7XUsBmZFobv2vd8GFFs5m2GXFBsP1l/nzLxkUAfacR8oZpSvW0mPkuVoNwfueibWA
         wFR0XuvGtuR+u0WRbzFGh0MZpc3fnZXs9l1aCjVc9WYLwYwwwAr8xXoU0BS7i/hl6WWZ
         WrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709946077; x=1710550877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZAm0Tgx98b87jNznQKbIh24x5ADZ/9jsinWkEdrtEU=;
        b=TEuHjgdLfX6f13KYwOgcDGmtNWfA2pZnHRa8B/goMybxuCkz2iJutflOnDpP2QJqDm
         0A80+/jsRSw4PAfHNHkN3e0e/HQsIHCOm38YaSc1Y8KLCEZV6Ab7oYWfTzuMk4Tfuoo9
         /o4DKffnckpRxZzYTGj0/1WoLEXfu6KlGc59oc8iz7yLdjFoJeVnZplz0H08NoZ7YjWW
         uA4DPeXe6PkuNJo39sjIbtTkwmZJ9xPzMZBwcMtfKmzUuohuLdLyGNchTL5wbrJz6ODN
         pCIFipM3CBNexfheSIWGygLOyqRQ3f0P9h/t6d01cVQMZfghaB0uC0Jt4i4290+Qtayc
         qbYA==
X-Gm-Message-State: AOJu0YxZoULC+Qa3+uQRLCmCrrtZ0qaETJlPvOdojP/6aMe9+ric3u2y
	e6f+9nZ+pjvXhKNz2fFIJn0zunlj7yv9r6tBKWhHjKaAGWy/QyCFPcsKoJ1D7XbtSYwS2bfj5rr
	rXEb4pWYwFoLyjF9fRW50NwMDZQ6d1Xd2
X-Google-Smtp-Source: AGHT+IEEhHT+dCC9sqCgMkSB4gi9NF7aFWkgHWAxEcmwZVyWeuaKq9NKvqLO/p/K6kUD6sCvhH7esgXf/zV2yvp9Ybs=
X-Received: by 2002:a17:906:81ca:b0:a45:ad2c:6f57 with SMTP id
 e10-20020a17090681ca00b00a45ad2c6f57mr168972ejx.56.1709946077240; Fri, 08 Mar
 2024 17:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305202155.3890667-1-yonghong.song@linux.dev> <20240305202211.3891663-1-yonghong.song@linux.dev>
In-Reply-To: <20240305202211.3891663-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Mar 2024 17:01:02 -0800
Message-ID: <CAEf4Bzb1TpvMU8V9PrO9j35H=z4j4bqvdVGE2JfF4gGzVnGGPA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/5] libbpf: Add link support for BPF_PROG_TYPE_SK_MSG
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:22=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Introduce a libbpf API bpf_program__attach_sk_msg() which allows
> user to get a bpf_link. The API makes auto-deletion easier and
> also allows user space application easier as link based APIs
> are used for all programs.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c   | 8 ++++++++
>  tools/lib/bpf/libbpf.h   | 3 +++
>  tools/lib/bpf/libbpf.map | 1 +
>  3 files changed, 12 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 97b573516675..b3982bb3f979 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -149,6 +149,7 @@ static const char * const link_type_name[] =3D {
>         [BPF_LINK_TYPE_TCX]                     =3D "tcx",
>         [BPF_LINK_TYPE_UPROBE_MULTI]            =3D "uprobe_multi",
>         [BPF_LINK_TYPE_NETKIT]                  =3D "netkit",
> +       [BPF_LINK_TYPE_SK_MSG]                  =3D "sk_msg",
>  };
>
>  static const char * const map_type_name[] =3D {
> @@ -12280,6 +12281,13 @@ bpf_program__attach_netkit(const struct bpf_prog=
ram *prog, int ifindex,
>         return bpf_program_attach_fd(prog, ifindex, "netkit", &link_creat=
e_opts);
>  }
>
> +struct bpf_link *
> +bpf_program__attach_sk_msg(const struct bpf_program *prog, int map_fd,
> +                          enum bpf_attach_type attach_type)

Why do we need to allow users to override attach_type? Why can't it
come from bpf_program's expected attach type?

> +{
> +       return __bpf_program_attach_fd(prog, map_fd, attach_type, "sk_msg=
", NULL);
> +}
> +
>  struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *=
prog,
>                                               int target_fd,
>                                               const char *attach_func_nam=
e)
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 5723cbbfcc41..c8448f05e8d6 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -786,6 +786,9 @@ bpf_program__attach_netns(const struct bpf_program *p=
rog, int netns_fd);
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
>  LIBBPF_API struct bpf_link *
> +bpf_program__attach_sk_msg(const struct bpf_program *prog, int map_fd,
> +                          enum bpf_attach_type attach_type);
> +LIBBPF_API struct bpf_link *
>  bpf_program__attach_freplace(const struct bpf_program *prog,
>                              int target_fd, const char *attach_func_name)=
;
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 86804fd90dd1..c59986c6dbc5 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -410,6 +410,7 @@ LIBBPF_1.3.0 {
>
>  LIBBPF_1.4.0 {
>         global:
> +               bpf_program__attach_sk_msg;
>                 bpf_token_create;
>                 btf__new_split;
>                 btf_ext__raw_data;
> --
> 2.43.0
>
