Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B143A71AD
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937952; cv=pass; b=fjLWh3aaj/N+vr9WbgaTW059GQgbupWtrJPIjVvV7Uf/zbylqWxlQLKgQFGY9MoyQFk8XK4/titW+ShPOa9WNGGcW+oQ7F/gHcUd4ldmIZCm8Lmjsoc3ktuTN3spwRkfYQVQSLuDJ/Rjpm0sqO2WzPn3bC8xJCmUPQuOufWE268=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937952; c=relaxed/simple;
	bh=7/sHJHaXSYF+upxkU4mAxLjNkxjly/ZvWaONQwnzSIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MI3EN9k3KVKN6qF6P7fi9D5cut/d3f/rrQkIOfhCDIqUdFTRRiCZcbRrA0iHz0Mt8SWk5gMAmt7veV1gV1Nj5UTSQXXNvjscvlIQ8nOh1WMvySRwpigJ9Cn/kesXdK0cA+QOu9WIR1+gEYBsRyKoDO88+bbmM3uoQ2CJSyC8lD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssHKnqUD; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssHKnqUD"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37fc01881f2so1077773a91.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 13:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782937949; cv=none;
        d=google.com; s=arc-20260327;
        b=QsFlg5m+OtTyEyJJaZHoMLxHu9ZXY7eqoH55BNoVJpA1ecsWCkllELOM2Rcp5JKi/k
         KQ9BEO26gMaN+60JEXfHFqaFz3koqxERzyu+7DMWdqpAPE/EtDSbG7UtedLICHdofcbl
         UJ9WM9N7T9KAGX4830jX4mwMPoK+3lCrzSChlFwR3IIUgJl348DPZKMcTkQLUseCLoV/
         323blfFB1/tnuer9eObJ1XbtvBooshxWshX/qA5L1Jco6JwCbkNZo+JVgLrl4JYehwEQ
         wdDNmJzsLPjl205ytI+bFDGNQ+fUhcwDudKpX8RRoMqg2xzJH4R5HwkZ97SNbnJgmx+t
         uPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MNRUwb98CGj20jMOUNCoIeWSRqWstmMnRVlQAu295kk=;
        fh=s8QdQtxftUlaYHOX2Bpmks3+9l4ZxMUJEmvv2haRIg4=;
        b=exFo/R49YDGTAtoHyD8MVbMBIknCrkl2DtbYsDt0fjXpHIS9Fj+1HAU17oalhKOrOR
         Li/FauFlup61MY3Ln0CQ6mfohetae1+txq4I1OFwCso/80jGSXF0z1MuZBn+mfjnGAQ6
         VElrHFNqz8eq9SEI9gLNuK1eUi+53wlHJN4cQimpFdy0nOgBp44xmm3bbzC9y0bQ3fah
         M/G1IuGY+KZ3Uafev2TB94nKwkr9JAoYxArvavjb3TnoiQN7O3vPeQtVvKN5+6AFpNYB
         6qJ+UAw79Zc2lMq7TOFkLgxiWYXKP0p8lYbivDEVzAJP3+uLn2rtHkItlF+LIpqmp0GE
         Prrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782937949; x=1783542749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNRUwb98CGj20jMOUNCoIeWSRqWstmMnRVlQAu295kk=;
        b=ssHKnqUDPxfs9qh230Lt760/9PO/pwSsAXaDlNJXgqodiYErQVkdf+pVsEvdESvT2X
         hKKLmuZQlMwRa79EuBEe8NsutlCcySVDgzGaGGdahzRuE+d5BjjsQrspOzLkAXJX0L5j
         E0wUyfewUOy1xpwFU1SBi7cDFW96Cd5YfmnnbEjvl9Zf6RlJ9ZY79RubBsHn4DNHeN7S
         8EDM15reCVe5anvxdUzURYH0/lr/PUlBz4jJ4f2q/vCY1Xi3rXNjhLXX0DPcyaAtEjmV
         NGrZKNVA5bdrOGQeg+jagcPQlrvzIM55sjiMGdqZa43G/CBOwjdm8SBLdzTbG68bT3wp
         nBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782937949; x=1783542749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNRUwb98CGj20jMOUNCoIeWSRqWstmMnRVlQAu295kk=;
        b=eRGLl4QsuXRDpcxDPIqTlEAtPuVKP5muSlbbSKwKBYaKZtPBHL7OgvI+xldcSTaWkI
         C0VC+4GIkDH2mQ+VIdzLgzBHPYRVZn4XpnHjQ07Mp7yi16IyKsxSPNH2fVzeUjcZz1c5
         g15ALFoAUE0RHGXMhNMfm/S7jbm9/7efE9EB75jEH+51MOje9EICpnXFJmAgMsVfMdWw
         fMVSqB9ZGoORJGZLmgg67fcuBvw1TZZaY8Qpwrd1NYvo9NvMKkXXXGHYwvFFd+Iyzc/L
         avNluqDn5Y2gQXRzDmW0dks0PYj/Uet1bWeUXwfCPkFPwHNBVzlru0qYz6VnfBR7qlQ/
         5O9g==
X-Gm-Message-State: AOJu0Yy3SIQ+LRI2qszfoNqsZ1rsNuqPf8SdiQpF/ARhiP1QZp+deKUF
	sLKFmZlYqyyuS9B15gzkow4CBz2PcONcmE0BIJWOSXLzRmUlbiEpGnk5leUrmcjAn/JKUJHEw93
	jQYKdb9w5fCM+obnM/RSWnxRQjfKfaog=
X-Gm-Gg: AfdE7cmcfOG66408A2Fx7mynzo/l2//ggtsBY5RycEFe/iqBV7sn/95DHSJ5meb/U2k
	8MfZlop3t9c3wYTEHJSoH1Mys/SLnA8p4evIzembwGZ7LjobINV+SV/HJ3QDH7fdYm4u6xmwSuf
	N14RkZbiHYV4BkAvF8PPB/Xe7QpvtLwt+AkSwkw7sMUH9AwfQZz1flpq3dIa4/GL1RCmlIsFPDG
	1qAowmztL9hWqz+UuDT4gQkwWDKDHSv/d2TFr2iTX8wqful2zWnEPzZ3ZyQuuH4LJvicw2x6fU4
	Zmoavv6n8V6PdUa/sV7h7RQTNPAz9timyY5r/+r4m5cBRsLJmQNiKnXwl/d0Qb9G
X-Received: by 2002:a17:90a:e7cd:b0:37f:133a:3e02 with SMTP id
 98e67ed59e1d1-380ba74883fmr2259236a91.0.1782937949401; Wed, 01 Jul 2026
 13:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623175006.3136053-1-ameryhung@gmail.com> <20260623175006.3136053-14-ameryhung@gmail.com>
In-Reply-To: <20260623175006.3136053-14-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 13:32:16 -0700
X-Gm-Features: AVVi8CfcQa6IBvQSgCXyIce6uAtzmIMLNbYaYjbp5x30Mu2NEKAwhZgDNROhdQw
Message-ID: <CAEf4BzZ9Mf7-o6JNnqbTDTDC4mYjRCNh8o6cfN=TKqe8D=Sz+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 13/15] libbpf: Support attaching struct_ops to
 a cgroup
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 10:50=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Add bpf_map__attach_cgroup_opts() to attach a struct_ops map to a cgroup
> through a BPF link.
>
> Also extend struct bpf_prog_query_opts with a type_id field so a
> BPF_STRUCT_OPS query on a cgroup can select the struct_ops type to
> enumerate.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/lib/bpf/bpf.c            |  2 ++
>  tools/lib/bpf/bpf.h            |  3 +-
>  tools/lib/bpf/libbpf.c         | 59 ++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h         |  3 ++
>  tools/lib/bpf/libbpf.map       |  5 +++
>  tools/lib/bpf/libbpf_version.h |  2 +-
>  6 files changed, 72 insertions(+), 2 deletions(-)
>

[...]

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..0e5f4e9bba41 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -960,6 +960,9 @@ bpf_program__attach_cgroup_opts(const struct bpf_prog=
ram *prog, int cgroup_fd,
>  struct bpf_map;
>
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
> +LIBBPF_API struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf=
_map *map,
> +                                                       int cgroup_fd,
> +                                                       const struct bpf_=
cgroup_opts *opts);
>  LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct =
bpf_map *map);
>
>  struct bpf_iter_attach_opts {
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index b731df19ae69..1b01d49e58eb 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -462,3 +462,8 @@ LIBBPF_1.8.0 {
>                 bpf_program__clone;
>                 btf__new_empty_opts;
>  } LIBBPF_1.7.0;
> +
> +LIBBPF_1.9.0 {
> +       global:
> +               bpf_map__attach_cgroup_opts;
> +} LIBBPF_1.8.0;

v1.8 hasn't been released yet, this new API should go into LIBBPF_1.8.0 sec=
tion

> diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_versio=
n.h
> index c446c0cd8cf9..57b74ef3618c 100644
> --- a/tools/lib/bpf/libbpf_version.h
> +++ b/tools/lib/bpf/libbpf_version.h
> @@ -4,6 +4,6 @@
>  #define __LIBBPF_VERSION_H
>
>  #define LIBBPF_MAJOR_VERSION 1
> -#define LIBBPF_MINOR_VERSION 8
> +#define LIBBPF_MINOR_VERSION 9
>
>  #endif /* __LIBBPF_VERSION_H */
> --
> 2.53.0-Meta
>
