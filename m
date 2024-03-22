Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1C64CC6
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133751; cv=none; b=uLGCvq78xs/0Q2Z9E80774RCfwMmtP0LlfQNVbEZzUDtZoF0/iiwrGTa2npHh3X66JpNaHNG3dY46/eMu3k4m2Kx+6Wf7ZGvcedp+Q6k1etXvE41D+cVjBgfZPxUzAWhrMPLJ5xR7YxCtXQlxSaeArsmCTky0rvyIWTTL5SCGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133751; c=relaxed/simple;
	bh=wpaQOiUoOllDVZ9y71+y41TR4Mlze1xrf/ybWkWEHXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuM71q1ybBXfQrqxpMfL5mrqFczxEy9KE+1jDWbXhNTAm/aRbTwpMkj18TYupN3u8pgwZZUF5GtEg/hSBNdtAh0zMlML3NGBwJSsRCj26E6aT+5vBS0SkQ9NBu2uTM/x3F7K9zyQo4HPi2KT3O1vLrdWt24OHupCkC/Rt468IPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuDzJzy/; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuDzJzy/"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e6ad82cf17so1332141a34.3
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 11:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711133749; x=1711738549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGtmuQ0FChoo2Rmig9I78xpI6lrGcJnRaxyw4tTLYjE=;
        b=XuDzJzy/yCi30lqC0SgG/CCcoeAi67S0COKz7hVU5t2tFDI/LnOnkV0HEXunGK9Ri0
         xUTzMak2FKE1LxlPSDO4t1x1u4/Kxt+Sz7tnHP3sRVX72xz+sCRs2vzOZkxvEq/QTZA/
         A9V73xgnvzVboRZ+8d88UL+u3ciNqomtOGl7BQ+1tD9vdbX+u0sfIImoy4XUCRCIJl7K
         CqrDWxpeIV0gP/2whh8mv/iiguZtOLq5ZKASNFb2BL6Vwn30A2MERc7Hu+Ykpi4S0Ztv
         PYvu68dFbfEl1viBjSIwwAUEpRF/D3oQafYHt1Lma5leFlbxjJMMsneGSPd9eOqGoXPC
         m/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711133749; x=1711738549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGtmuQ0FChoo2Rmig9I78xpI6lrGcJnRaxyw4tTLYjE=;
        b=lraPYf+4+uWHtLVICdxwXyeQym/a6ys/JhXtX5z7P+hl8gaE5C6WBl03y92mCXvnsg
         rQx6b1w6/uBeHqvjcFK3dw6t+n7UBRkEn/6dL/3buwGlg34VhaeNlJGatFPRl73le3EE
         AhxsFR5J5gLuEyEH297e142f/NKdPJ8VL0znzEp8MMtyLhPPdqDF1vWJ3N8wbeyfe8EE
         Y3DC8g5Fi/YCqjvjNQjweB29wujhIZkzI6Gb+Pt4Y5fJVDRutT17iCWBCrGIzQIcZxqW
         4ZPnsjb2e64aCzJyP4Hqp1+D59PgjfkdzOEQk/HQrV1vRuLIbLPkL+r1Pjr8B7B15E+G
         eNRQ==
X-Gm-Message-State: AOJu0YwlGbtuyA1Rhtt5UQohpKHfil9Uq+Bh1wxMaXza7BKs8CBYyTQK
	x1ou7Jq8zHl5JhED6/BRGy6KiuT0XkbkVN6oZ1H5kHIkUpRAq+9i055CJCxnMBjhHWd3dhw8no2
	qn2uPvn1w2zXt9Lc5VO2eYmWP2MEY+yJz
X-Google-Smtp-Source: AGHT+IGSLbv5oRtd0cI4jVrsrogUJJDUWorevphU+OJOP/GPvVSAjcsfkAGscpEvBajLr4NGfs77a7su5i/Y82dzpzw=
X-Received: by 2002:a05:6a20:c303:b0:1a3:2de0:b00d with SMTP id
 dk3-20020a056a20c30300b001a32de0b00dmr382764pzb.59.1711133333502; Fri, 22 Mar
 2024 11:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319175401.2940148-1-yonghong.song@linux.dev> <20240319175417.2941417-1-yonghong.song@linux.dev>
In-Reply-To: <20240319175417.2941417-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 11:48:41 -0700
Message-ID: <CAEf4BzaYVG7dRMwrLWndem5XZr_r5doz+k3GHg8zsVuQ9HQhLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] libbpf: Add bpf_link support for BPF_PROG_TYPE_SK_{MSG,SKB}
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:54=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> Introduce two libbpf API functions bpf_program__attach_sk_msg()
> and bpf_program__attach_sk_skb() which allow user to get a bpf_link
> for their corresponding programs.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c   | 14 ++++++++++++++
>  tools/lib/bpf/libbpf.h   |  4 ++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  3 files changed, 20 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 7d413415d0d5..1b8e1f47a5e6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -149,6 +149,8 @@ static const char * const link_type_name[] =3D {
>         [BPF_LINK_TYPE_TCX]                     =3D "tcx",
>         [BPF_LINK_TYPE_UPROBE_MULTI]            =3D "uprobe_multi",
>         [BPF_LINK_TYPE_NETKIT]                  =3D "netkit",
> +       [BPF_LINK_TYPE_SK_MSG]                  =3D "sk_msg",
> +       [BPF_LINK_TYPE_SK_SKB]                  =3D "sk_skb",
>  };
>
>  static const char * const map_type_name[] =3D {
> @@ -12493,6 +12495,18 @@ bpf_program__attach_netns(const struct bpf_progr=
am *prog, int netns_fd)
>         return bpf_program_attach_fd(prog, netns_fd, "netns", NULL);
>  }
>
> +struct bpf_link *
> +bpf_program__attach_sk_msg(const struct bpf_program *prog, int map_fd)
> +{
> +       return bpf_program_attach_fd(prog, map_fd, "sk_msg", NULL);
> +}
> +
> +struct bpf_link *
> +bpf_program__attach_sk_skb(const struct bpf_program *prog, int map_fd)
> +{
> +       return bpf_program_attach_fd(prog, map_fd, "sk_skb", NULL);
> +}
> +
>  struct bpf_link *bpf_program__attach_xdp(const struct bpf_program *prog,=
 int ifindex)
>  {
>         /* target_fd/target_ifindex use the same field in LINK_CREATE */
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 7b510761f545..4a2c04a9c6c3 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -784,6 +784,10 @@ bpf_program__attach_cgroup(const struct bpf_program =
*prog, int cgroup_fd);
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd);
>  LIBBPF_API struct bpf_link *
> +bpf_program__attach_sk_msg(const struct bpf_program *prog, int map_fd);
> +LIBBPF_API struct bpf_link *
> +bpf_program__attach_sk_skb(const struct bpf_program *prog, int map_fd);
> +LIBBPF_API struct bpf_link *
>  bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_freplace(const struct bpf_program *prog,
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 86804fd90dd1..11a1ad798129 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -410,6 +410,8 @@ LIBBPF_1.3.0 {
>
>  LIBBPF_1.4.0 {
>         global:
> +               bpf_program__attach_sk_msg;
> +               bpf_program__attach_sk_skb;

same suggestion, it seems like having a more generic
bpf_program__attach_sockmap() or something along those lines would be
better?

please also see what changes need to be done in bpf_link_create() API

>                 bpf_token_create;
>                 btf__new_split;
>                 btf_ext__raw_data;
> --
> 2.43.0
>
