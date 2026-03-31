Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475B3A5E89
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997711; cv=pass; b=BpKKEOVn8u2rnAzJwg+rslcZJKRiJ8xZFCQqzaQCQksZKEvjmXhDR+D1YGKyjK6EAwaBCJYXWZipfu0jA10wVyZdhowy5YYdcg9RcSN0mWPrZRoAqdv0NXF1Z0c0c7sSb6j2zbaz21cBCFU8bcVS8INFi+3JdfnW1XL+wsANrgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997711; c=relaxed/simple;
	bh=G+kkfsLAg0SEnCn6gx0FYnpxG49cmhHD8ouYg4dsDJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hus84f187JSsd9+Dfx5SKuHMTiQalcKn20IGvDmo2A++oCIoNGMIEYGo3aatuz028Ek788Xsu3gyjlymOPe/M7edFdr/KzpaVbEMneu6U5epA3oBArESA/GpdX6hHNC8KeKV+T5eXMaYxOFhpnrDkqc/cEPO6LfoBhSxNq31Fy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpmokfB3; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpmokfB3"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c76b070f109so913937a12.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 15:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774997710; cv=none;
        d=google.com; s=arc-20240605;
        b=gf8nZvfqPZr0PL2U/dK72b3MddSpBO5syERNweJcAUtHgAPRpWyMs+7liLlFtjp/TB
         4wwERPyR54ZZia/iGl6gCrQlZYYesXS5Vw2AATeoMARFoJA9+h1v+tR1OfVn+evGRXZK
         Y5jcHtJ1Zcw2uDBfj/0XbvzXtfdBiS05yatZQDS9EpCNzsLJO3mw5IGeXuHwdOg1ZVc5
         VHGSGivFHUONXxX6R4Ujbw2VcY3+uE4b9iSwUMwszckHd7h1Sir2B13wOvM4OIfKkDHH
         F+GFQSUCS4htTCU35mmL0jQwrwZ6IKEtY3G5EmPZ4VWo8Md1XCkb5a3kKJs0FaTB/dpZ
         BBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PJWSb4M2QD4XlrwnVx/vLxmzMpHpIANjSEqk5kfISIg=;
        fh=0z7eV0SVrdGestYsQW/vHe7NOeLecbF3mybNQIacMZE=;
        b=KoMsULQmRhFLNViRUB2z9xVYivfWiag4JXryu0bYrqZimp8A/MJmmNx/jh1xM+hAqp
         gJ7plhJugAPfbLmwqmQvwm94cQzEjBqlNNB1BL4qNVyQ/nXL2YRy+DH2m/LerwP6gTsJ
         OUU+iNn1y9qjI0E7QdnEC2jwuTV0/ilwXYzapR6iGnK0m+KyG81tFJcOv4g/BSjhjJko
         J2uDvOsiEa7ONNnp8274bjnjvjXXrJruVFfkJcRtmhNp6RiWzbCC7lH0UmHTV1YmeHaz
         6F0MIXhIObCqGa8hAG165VSWCKUiy/z5JRvM6mVePTs5ySqFiTM9weL0L/wTcTDRAz9x
         27hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774997710; x=1775602510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJWSb4M2QD4XlrwnVx/vLxmzMpHpIANjSEqk5kfISIg=;
        b=DpmokfB3T7ZlIh7WpEBR6TxImpunLPhcPCHuwJnLI4sIRcjvYd1uKaTDyfT17jTruV
         dE/okTNpeJlZhRb92Rj4Pr70fvUlpkMp2j11jopRMPwQvNemqRn8drlbKj/rjTF2/URZ
         iEeKVRfRE016CHTbEr8tPq5p1xgxSuP+pItZ2oKVTFmSPlNckX75MzMmgMVyczEp9oz8
         OVmyRleHNwKzHIWH5Kn4DsHOAy2jb22TPavdr1+e570Uz8V2ho9nLyDh1A7qNlYx5O+4
         ygjqRD5NXbM6yPERDKyXveDDjtcm4dM+/DNAGR49FQBSuNXK0j1Cg6YB8Dqw72R110Pf
         pa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774997710; x=1775602510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJWSb4M2QD4XlrwnVx/vLxmzMpHpIANjSEqk5kfISIg=;
        b=YgiYPSU0j+G34wccqbFEMhlbgtQTEgBfdOTWEB6AyVVGF6UeWUaqEaIN+tQHurZxgs
         FowqUD7PBAgwhKlh7bjtRWjYWTd7Y+/H9cxydHQofEcN1TaOi6BpzjzDNqBOLg00YVYB
         7VmJUuZKi+pCkGcdydalt4XI+D2//f8aPRu1UsmG4/BGN2jG/M1dkZirWzUv4OAo/OfX
         fU5vOoviCHkokadRZKmQRAcSaUjNe2IfmmIurBNABxed/Jvj7Xssv36aLvZOPOGDSboG
         F4i8SBxzJV2cMA9HMDai/FiAXAGKQZQxCeNmFImxlJ89bxv7VXbVNkJZ8hXiPAPX1lFx
         WNnQ==
X-Gm-Message-State: AOJu0Yx9NO6JO2phgdmDT+I9A4kezoqlzRWcbVhclJ6Ms7Fmc8eN+YqN
	83WvnBljNjcKljP6Ao4mgrZcTlVeDoG7Rnk0aozuRkV+o8dy4HNZgC9jjD0wgYj5oZTxi8+WvYe
	PnU3A3RBzd/msyHh9tW99JGL77k9/S7w=
X-Gm-Gg: ATEYQzx2H09j9Lv288/HM4VgNv1OXHYzHdezeQxR6Gu6y9xb/UZkape18g+bIC/jl99
	WL+q+Nu1ZJpqe0b1vLGfiD9PcvWEEDvL3BhstRYJ5vXT4hgVAnw7d4qCriqxbPxv5xMHqEaVUvI
	Ai27xuekoDRy6vpKfDX8FZHwdaRmrn/xV0exn0MmVFdPequ52F4pRMu7MFQ1jUOeI8FrzkcV5qi
	HxAI71xWyF/S4jat3FcwgwdWv1b0M+jbOJQNaCOrlmzY7URoIaFcmZwo9rKfI7UM+rUixh4wDUi
	VJh9eDugY5CmoJhMaMHBzG8=
X-Received: by 2002:a05:6a20:1582:b0:398:7874:35d3 with SMTP id
 adf61e73a8af0-39ef721768dmr1063136637.10.1774997709515; Tue, 31 Mar 2026
 15:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331172634.57402-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260331172634.57402-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Mar 2026 15:54:57 -0700
X-Gm-Features: AQROBzCD4BzDgRFKJAnMydUAwV9oSbN0VFvXVQAUsiDzsj8hzkcCMt5ty4k34l0
Message-ID: <CAEf4BzYfQ_E+JA8PMma5-vg3+3=Sz9HZBM5Ew26D-caqE-WdzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Fix BTF handling in bpf_program__clone()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 10:26=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Align bpf_program__clone() with bpf_object_load_prog() by gating
> BTF func/line info on FEAT_BTF_FUNC kernel support, and resolve
> caller-provided prog_btf_fd before checking obj->btf so that callers
> with their own BTF can use clone() even when the object has no BTF
> loaded.
>
> While at it, treat func_info and line_info fields as atomic groups
> to prevent mismatches between pointer and count from different sources.
>
> Move bpf_program__clone() to libbpf 1.8.
>
> Fixes: 970bd2dced35 ("libbpf: Introduce bpf_program__clone()")
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c   | 66 ++++++++++++++++++++++++++--------------
>  tools/lib/bpf/libbpf.map |  2 +-
>  2 files changed, 45 insertions(+), 23 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9ea41f40dc82..d1358ca0a15a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9852,7 +9852,7 @@ int bpf_program__clone(struct bpf_program *prog, co=
nst struct bpf_prog_load_opts
>  {
>         LIBBPF_OPTS(bpf_prog_load_opts, attr);
>         struct bpf_object *obj;
> -       int err, fd;
> +       int err, fd, prog_btf_fd;
>
>         if (!prog)
>                 return libbpf_err(-EINVAL);
> @@ -9865,8 +9865,9 @@ int bpf_program__clone(struct bpf_program *prog, co=
nst struct bpf_prog_load_opts
>                 return libbpf_err(-EINVAL);
>
>         /*
> -        * Caller-provided opts take priority; fall back to
> -        * prog/object defaults when the caller leaves them zero.
> +        * Caller-provided opts take priority; fall back to prog/object d=
efaults when the
> +        * caller leaves them zero. 0/NULL means "use default". Callers c=
annot explicitly
> +        * clear an inherited non-zero value by passing 0.
>          */
>         attr.attach_prog_fd =3D OPTS_GET(opts, attach_prog_fd, 0) ?: prog=
->attach_prog_fd;
>         attr.prog_flags =3D OPTS_GET(opts, prog_flags, 0) ?: prog->prog_f=
lags;
> @@ -9878,27 +9879,45 @@ int bpf_program__clone(struct bpf_program *prog, =
const struct bpf_prog_load_opts
>         if (attr.token_fd)
>                 attr.prog_flags |=3D BPF_F_TOKEN_FD;
>
> -       /* BTF func/line info */
> -       if (obj->btf && btf__fd(obj->btf) >=3D 0) {
> -               attr.prog_btf_fd =3D OPTS_GET(opts, prog_btf_fd, 0) ?: bt=
f__fd(obj->btf);
> -               attr.func_info =3D OPTS_GET(opts, func_info, NULL) ?: pro=
g->func_info;
> -               attr.func_info_cnt =3D OPTS_GET(opts, func_info_cnt, 0) ?=
: prog->func_info_cnt;
> -               attr.func_info_rec_size =3D
> -                       OPTS_GET(opts, func_info_rec_size, 0) ?: prog->fu=
nc_info_rec_size;
> -               attr.line_info =3D OPTS_GET(opts, line_info, NULL) ?: pro=
g->line_info;
> -               attr.line_info_cnt =3D OPTS_GET(opts, line_info_cnt, 0) ?=
: prog->line_info_cnt;
> -               attr.line_info_rec_size =3D
> -                       OPTS_GET(opts, line_info_rec_size, 0) ?: prog->li=
ne_info_rec_size;
> +       prog_btf_fd =3D OPTS_GET(opts, prog_btf_fd, 0);
> +       if (!prog_btf_fd && obj->btf)
> +               prog_btf_fd =3D btf__fd(obj->btf);
> +
> +       /* BTF func/line info: only pass if kernel supports it */
> +       if (kernel_supports(obj, FEAT_BTF_FUNC) && prog_btf_fd > 0) {
> +               attr.prog_btf_fd =3D prog_btf_fd;
> +
> +               /* Treat func_info fields as an atomic group */
> +               if (OPTS_GET(opts, func_info, NULL)) {

let's actually validate that either all three related fields are
specified or not, and error out otherwise

same for line_info group


pw-bot: cr

> +                       attr.func_info =3D OPTS_GET(opts, func_info, NULL=
);
> +                       attr.func_info_cnt =3D OPTS_GET(opts, func_info_c=
nt, 0);
> +                       attr.func_info_rec_size =3D OPTS_GET(opts, func_i=
nfo_rec_size, 0);
> +               } else {
> +                       attr.func_info =3D prog->func_info;
> +                       attr.func_info_cnt =3D prog->func_info_cnt;
> +                       attr.func_info_rec_size =3D prog->func_info_rec_s=
ize;
> +               }
> +
> +               /* Treat line_info fields as an atomic group */
> +               if (OPTS_GET(opts, line_info, NULL)) {
> +                       attr.line_info =3D OPTS_GET(opts, line_info, NULL=
);
> +                       attr.line_info_cnt =3D OPTS_GET(opts, line_info_c=
nt, 0);
> +                       attr.line_info_rec_size =3D OPTS_GET(opts, line_i=
nfo_rec_size, 0);
> +               } else {
> +                       attr.line_info =3D prog->line_info;
> +                       attr.line_info_cnt =3D prog->line_info_cnt;
> +                       attr.line_info_rec_size =3D prog->line_info_rec_s=
ize;
> +               }
>         }
>
> +       /* Logging is caller-controlled; no fallback to prog/obj log sett=
ings */
>         attr.log_buf =3D OPTS_GET(opts, log_buf, NULL);
>         attr.log_size =3D OPTS_GET(opts, log_size, 0);
>         attr.log_level =3D OPTS_GET(opts, log_level, 0);
>
>         /*
> -        * Fields below may be mutated by prog_prepare_load_fn:
> -        * Seed them from prog/obj defaults here;
> -        * Later override with caller-provided opts.
> +        * Fields below may be mutated by prog_prepare_load_fn(). Seed th=
em from prog/obj
> +        * defaults here; re-apply caller overrides afterwards
>          */
>         attr.expected_attach_type =3D prog->expected_attach_type;
>         attr.attach_btf_id =3D prog->attach_btf_id;
> @@ -9910,16 +9929,19 @@ int bpf_program__clone(struct bpf_program *prog, =
const struct bpf_prog_load_opts
>                         return libbpf_err(err);
>         }
>
> -       /* Re-apply caller overrides for output fields */
> +       /* Re-apply caller overrides for fields that prog_prepare_load_fn=
 may have modified */
>         if (OPTS_GET(opts, expected_attach_type, 0))
> -               attr.expected_attach_type =3D
> -                       OPTS_GET(opts, expected_attach_type, 0);
> +               attr.expected_attach_type =3D OPTS_GET(opts, expected_att=
ach_type, 0);
>         if (OPTS_GET(opts, attach_btf_id, 0))
>                 attr.attach_btf_id =3D OPTS_GET(opts, attach_btf_id, 0);
>         if (OPTS_GET(opts, attach_btf_obj_fd, 0))
> -               attr.attach_btf_obj_fd =3D
> -                       OPTS_GET(opts, attach_btf_obj_fd, 0);
> +               attr.attach_btf_obj_fd =3D OPTS_GET(opts, attach_btf_obj_=
fd, 0);
>
> +       /*
> +        * Unlike bpf_object_load_prog(), we intentionally do not call bp=
f_prog_bind_map()
> +        * for RODATA maps here to avoid mutating the object's state. Cal=
lers can bind the
> +        * required maps themselves using bpf_prog_bind_map().
> +        */
>         fd =3D bpf_prog_load(prog->type, prog->name, obj->license, prog->=
insns, prog->insns_cnt,
>                            &attr);
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 346fd346666b..dfed8d60af05 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -452,12 +452,12 @@ LIBBPF_1.7.0 {
>                 bpf_map__set_exclusive_program;
>                 bpf_map__exclusive_program;
>                 bpf_prog_assoc_struct_ops;
> -               bpf_program__clone;
>                 bpf_program__assoc_struct_ops;
>                 btf__permute;
>  } LIBBPF_1.6.0;
>
>  LIBBPF_1.8.0 {
>         global:
> +               bpf_program__clone;
>                 btf__new_empty_opts;
>  } LIBBPF_1.7.0;
> --
> 2.52.0
>
