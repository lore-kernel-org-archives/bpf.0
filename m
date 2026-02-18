Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3452FC006
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771440455; cv=pass; b=JuQtmsB6Dk5MEmhBB0GvCRtu6pz1hk6e5du9bdYy/FbdBZ3s13gwe0vLT+HXP2f5ZaxiM32rnotJwehE4tExJnoiPX2WDW8By8f1HomGhkaQZ51ap7dCC9cxP2oNPiwCRcbtamyqu7VVLeb0P7dWcRiH4kLbZiRPso8lt4vPUNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771440455; c=relaxed/simple;
	bh=esdytp9nJyLy28GBTDLWMzzUeG3UZRNAHEiduHlF3wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5rmMPZiok28lEYYM3H3A80Kq2uUlFlZ8fRp11w/w2Ma9U7xSGsO4Xjt2f8bu1DBG80M3+qrKgq94uqy7pLEB3vykrMdlxVM2fYsqExjr0RUMn1dqULuYDORTlNlLEKI3EzrwiwuQyX4Rr5tpe0uglG+0RNHdSkBqW4yNg68ldE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn8rP0a9; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn8rP0a9"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-408778a8ec4so93406fac.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 10:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771440452; cv=none;
        d=google.com; s=arc-20240605;
        b=S2U4GIvCisgRALIfUnLzhx3sea84PgNldQpaoFzdf/faVLfqyY3kjT+HOU3Wc45bnI
         hyn1k/ntAXZ5biyGNNHEQ7vFipZIJt74+zSLhDtDqQAzVFPYzn4Lzar1L5xrnkfl74NE
         owQ/Rfs2lTCXcBd220h2QU71HIL0YirpH4i3r7unSxlR7a4b3TaqMNu2d3V9sk89TmKd
         1h8XxoKeQms3HnLZ07omcew2rBf04anJYfZpEDIkod/X1wnHNPkcJ744m5BebkrMEW4B
         hgTkqO7jZQHoGqgeGKxz3bVi/ERGdfgHJRoTKaUjunPlqOfgQGr11CxOLxlrrHq4rJBr
         IwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qEZ9vKOmk1e0x45arlBPiaAtulYTUKrpCHwBanjGaXk=;
        fh=tzBTEOLQNX7wTu1m+cznF/8cziRKBcTDJd+eSV7qIAw=;
        b=gY0+mSeYvtM9OnleMbF2iZYIRdy67yRUjx/D1GLKtFaHyPp/ziWhlalgFDtQsVDAtP
         LephcbzqGu6lfPzWurhflPyzlH65fqwoZT87F1OAperqnORvNP9Gq0RPrRXlxhua2PZf
         oy5pvsC5Niu/tzDouxn9PT4o1NYZ5kEUydbqBHuuBz2oVbdF+4MBQhPkgpXRIuamx116
         5yb6Gh7pnUIaga6z7U4jMip7tCV3V10kGltZFB7JqVTiJGVB+Fi2WEHLH6EqcGpGQPe4
         Z9IE6U7OdAOHmsYiaSExUPy9UKvngCbXnCkKgN+b5HnQ7X1zunVwl7x844LuWUbWPxi7
         1reQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771440452; x=1772045252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEZ9vKOmk1e0x45arlBPiaAtulYTUKrpCHwBanjGaXk=;
        b=fn8rP0a97bfGoprpXQ1yU9AOu4pmSHttgR3R8De/Ukr4ba1K3ma4NG7nPgwhID5xEc
         333KDLO0FgbRJKii3PMSN8ircVxEKcp7De/tSCNRDhIJg/6M8Uts/TqGc6LpBFnjDX+n
         BlCDwnR677g3+k12zTgYRbd2xreEYWLk0StpSYSfemJGaXb9MRkwtFB2TUgh1XcRjhv4
         NA2AFQcUTDWD17YYtzNpf5FxTfsaxzNr/7BrvXbwV11QVq7K68dKgn7Ziy1QWwUkIBAt
         yAZGirJFvZ201FmJjvS1iggz3j/OzSCSP88DSaCDS4iwxDGiKDxGERMZmQIOPTFEY5bg
         ewbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771440452; x=1772045252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEZ9vKOmk1e0x45arlBPiaAtulYTUKrpCHwBanjGaXk=;
        b=a42SNAPYcIPO/VZxkMvMPfdkma2H8aCSZw9MzHa9EXPI9HHIh/+FQFKmb8eSBpORKp
         OpRd14plHCgxkA6HTgP8rXuCZTjz0a+NrmdBzhMsjrtwISpWetC76JM0eM6Umiq8Kw7e
         pd5ivS74Q5PKGQmx5GyN6yV4quh2i3KXhkjFDJHeUOmF0DjTbUh7/yv9qa8fefRFdh/D
         b9SbmMD6tufvQMb4jcAlp2JNH6PqmXk9SMPQx8pxVyfm6SHa1223yzG5z2iJyqHNWOOB
         HhKyC3iAQoJMyYv9T+xohB9xJ+WqdV2SIQaYpXInuTebTNL7rVGYADJ/KOhdGRy6wnK8
         P2pQ==
X-Gm-Message-State: AOJu0YyGpgF5y136DLx50KjXbK8giamn1c+4W8rkyPczfegnSAVXSavi
	od+lbv9oHDeBSJzJryFbFusCEOK9YYVyOKI07nkh+BZ/lDh3+ObtZXA6Rw94luDqzNsa/q2DhlM
	P+K78FpTvaclMq+2L1nFrJF9pRTuhPOY3dMQ6
X-Gm-Gg: AZuq6aJbRNE16AkeozbuOuxPG59yeAFdFiOXAA7E5TH6Vx2i35X5DNhtlULpaOFXZpA
	RFDQljd0Y5lld6kJFByFRRpQMLipGllKr2gdCVF3UIGf78+VG5r/NzwhGQkXrRmO2SoOB8LpNpJ
	F26qdzvmSznFnJCHsg8R/8BiWlkkO0a9lgrXyTTPGvjs8J+Hu2nJP1G9vKL7+8+ZmvPL4Bjm8cq
	mq7NXPY5D82QXCn2R29k00JywOgX4sM/JutB9qedTcf7NQsh3irbJwcGMKrTwzM45N3CVC7tzyj
	aijzld845UOZiOs8sfZ0NA==
X-Received: by 2002:a17:90b:1fc4:b0:341:315:f4ec with SMTP id
 98e67ed59e1d1-358890a0557mr2879996a91.7.1771439988161; Wed, 18 Feb 2026
 10:39:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212-veristat_prepare-v1-0-c351023fb0db@meta.com> <20260212-veristat_prepare-v1-1-c351023fb0db@meta.com>
In-Reply-To: <20260212-veristat_prepare-v1-1-c351023fb0db@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 18 Feb 2026 10:39:36 -0800
X-Gm-Features: AaiRm535yhz6IeNow-TmUg4DhtI-DfaWE2-7OMSe1qUEwAnYdpbNnJoB-t1qIZk
Message-ID: <CAEf4BzYREkjMtuuicyp7og1LPtQnTp_wcsPCmWcpO3eZqTsiig@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Introduce bpf_prog_clone()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	ameryhung@gmail.com, puranjay@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 4:45=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add bpf_prog_clone() API that loads a single BPF program from a
> prepared BPF object into the kernel, returning a file descriptor owned
> by the caller.
>
> After bpf_object__prepare(), callers can use bpf_prog_clone() to load
> individual programs with custom bpf_prog_load_opts, instead of loading
> all programs at once via bpf_object__load(). Non-zero fields in opts
> override the defaults derived from the program and object internals;
> passing NULL opts populates everything automatically.
>
> Internally, bpf_prog_clone() resolves BTF-based attach targets
> (attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
> func/line info, fd_array, license, and kern_version from the
> prepared object before calling bpf_prog_load().
>
> Program-containing maps (PROG_ARRAY, DEVMAP, CPUMAP) track the owner
> program type in the kernel. When loading programs with different
> attributes (e.g. sleepable vs non-sleepable) from the same prepared
> object, the shared map would reject incompatible programs. To handle
> this, bpf_prog_clone() creates temporary copies of program-containing
> maps for each load and patches the instruction references, so each
> program gets a fresh map without owner conflicts.
>

Aren't we going a bit too far here? I don't think we should just
randomly re-create some maps. If program type is incompatible with the
map, so be it, cloning should fail.

> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c   | 139 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  tools/lib/bpf/libbpf.h   |  18 ++++++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 158 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce44462414e99a958260e940148e818..b2d8277a3ef04d266148c3fc0=
cf5f907b357358b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9793,6 +9793,145 @@ __u32 bpf_program__line_info_cnt(const struct bpf=
_program *prog)
>         return prog->line_info_cnt;
>  }
>
> +static bool map_type_contains_progs(enum bpf_map_type type)
> +{
> +       return type =3D=3D BPF_MAP_TYPE_PROG_ARRAY ||
> +              type =3D=3D BPF_MAP_TYPE_DEVMAP ||
> +              type =3D=3D BPF_MAP_TYPE_CPUMAP;
> +}
> +
> +/*
> + * Clone program-containing maps to avoid owner compatibility conflicts.
> + * PROG_ARRAY, DEVMAP, and CPUMAP maps track the owner program type; loa=
ding
> + * programs with different attributes (e.g. sleepable vs non-sleepable) =
against
> + * the same map fails. Create fresh maps and patch instruction reference=
s.
> + */
> +static int clone_prog_maps(struct bpf_object *obj, struct bpf_insn *insn=
s,
> +                          size_t insns_cnt, int *temp_fds)
> +{
> +       int i, j, old_fd, new_fd, num_fds =3D 0;
> +
> +       for (i =3D 0; i < obj->nr_maps; i++) {
> +               struct bpf_map *map =3D &obj->maps[i];
> +
> +               if (!map_type_contains_progs(map->def.type))
> +                       continue;
> +
> +               old_fd =3D map->fd;
> +               if (old_fd < 0)
> +                       continue;
> +
> +               new_fd =3D bpf_map_create(map->def.type, map->name,
> +                                       map->def.key_size, map->def.value=
_size,
> +                                       map->def.max_entries, NULL);
> +               if (new_fd < 0)
> +                       return -errno;
> +
> +               for (j =3D 0; j < insns_cnt; j++) {
> +                       if (insns[j].code !=3D (BPF_LD | BPF_IMM | BPF_DW=
))
> +                               continue;
> +                       if (insns[j].src_reg !=3D BPF_PSEUDO_MAP_FD &&
> +                           insns[j].src_reg !=3D BPF_PSEUDO_MAP_VALUE)
> +                               continue;
> +                       if (insns[j].imm =3D=3D old_fd)
> +                               insns[j].imm =3D new_fd;
> +               }
> +
> +               temp_fds[num_fds++] =3D new_fd;
> +       }
> +
> +       return num_fds;
> +}
> +
> +int bpf_prog_clone(struct bpf_program *prog, struct bpf_prog_load_opts *=
opts)


we should call it bpf_program__clone(), as it works on higher-level
struct bpf_program entity (even if it return "low-level" FD as a
result)

> +{
> +       LIBBPF_OPTS(bpf_prog_load_opts, local_opts);
> +       struct bpf_insn *insns =3D NULL;
> +       int temp_fds[256], num_fds;
> +       struct bpf_object *obj;
> +       int i, err, fd;
> +
> +       if (!prog)
> +               return libbpf_err(-EINVAL);
> +
> +       obj =3D prog->obj;
> +       if (!obj || obj->state < OBJ_PREPARED)

can obj be NULL?

> +               return libbpf_err(-EINVAL);
> +
> +       if (!opts)
> +               opts =3D &local_opts;

???

see how opts are used in libbpf: OPTS_VALID, OPTS_GET, etc.

> +
> +       /* Fill unset fields from prepared program/object */
> +       if (!opts->expected_attach_type)
> +               opts->expected_attach_type =3D prog->expected_attach_type=
;
> +       if (!opts->attach_btf_id)
> +               opts->attach_btf_id =3D prog->attach_btf_id;
> +       if (!opts->attach_btf_obj_fd)
> +               opts->attach_btf_obj_fd =3D prog->attach_btf_obj_fd;
> +       if (!opts->attach_prog_fd)
> +               opts->attach_prog_fd =3D prog->attach_prog_fd;
> +       if (!opts->prog_flags)
> +               opts->prog_flags =3D prog->prog_flags;
> +       if (!opts->prog_ifindex)
> +               opts->prog_ifindex =3D prog->prog_ifindex;
> +       if (!opts->kern_version)
> +               opts->kern_version =3D obj->kern_version;
> +       if (!opts->fd_array)
> +               opts->fd_array =3D obj->fd_array;
> +       if (!opts->token_fd)
> +               opts->token_fd =3D obj->token_fd;
> +       if (opts->token_fd)
> +               opts->prog_flags |=3D BPF_F_TOKEN_FD;

modifying user-provided opts in place? why?

pw-bot: cr


> +
> +       /* BTF func/line info */
> +       if (obj->btf && btf__fd(obj->btf) >=3D 0) {
> +               if (!opts->prog_btf_fd)
> +                       opts->prog_btf_fd =3D btf__fd(obj->btf);
> +
> +               if (!opts->func_info) {
> +                       opts->func_info =3D prog->func_info;
> +                       opts->func_info_cnt =3D prog->func_info_cnt;
> +                       opts->func_info_rec_size =3D prog->func_info_rec_=
size;
> +               }
> +               if (!opts->line_info) {
> +                       opts->line_info =3D prog->line_info;
> +                       opts->line_info_cnt =3D prog->line_info_cnt;
> +                       opts->line_info_rec_size =3D prog->line_info_rec_=
size;
> +               }
> +       }
> +
> +       /* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
> +       if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
> +               err =3D prog->sec_def->prog_prepare_load_fn(prog, opts,
> +                                                          prog->sec_def-=
>cookie);
> +               if (err)
> +                       return libbpf_err(err);
> +       }
> +
> +       /* Clone program-containing maps to avoid owner compatibility iss=
ues */
> +       insns =3D malloc(prog->insns_cnt * sizeof(*insns));
> +       if (!insns)
> +               return libbpf_err(-ENOMEM);
> +
> +       memcpy(insns, prog->insns, prog->insns_cnt * sizeof(*insns));
> +
> +       num_fds =3D clone_prog_maps(obj, insns, prog->insns_cnt, temp_fds=
);

nope, let it fail

> +       if (num_fds < 0) {
> +               err =3D num_fds;
> +               free(insns);
> +               return libbpf_err(err);
> +       }
> +
> +       fd =3D bpf_prog_load(prog->type, prog->name, obj->license,
> +                          insns, prog->insns_cnt, opts);
> +
> +       for (i =3D 0; i < num_fds; i++)
> +               close(temp_fds[i]);
> +
> +       free(insns);
> +       return libbpf_err(fd);
> +}
> +
>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {                    =
   \
>         .sec =3D (char *)sec_pfx,                                        =
     \
>         .prog_type =3D BPF_PROG_TYPE_##ptype,                            =
     \
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index dfc37a6155786f325935aaac1508eed679151f0d..e6a0bb881cd2d1e69f9089c94=
dc4158a89620591 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -2021,6 +2021,24 @@ LIBBPF_API int libbpf_register_prog_handler(const =
char *sec,
>   */
>  LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
>
> +/**
> + * @brief **bpf_prog_clone()** loads a single BPF program from a prepare=
d
> + * BPF object into the kernel, returning its file descriptor.
> + *
> + * The BPF object must have been previously prepared with
> + * **bpf_object__prepare()**. If @opts is provided, any non-zero field
> + * overrides the defaults derived from the program/object internals.
> + * If @opts is NULL, all fields are populated automatically.
> + *
> + * The returned FD is owned by the caller and must be closed with close(=
).
> + *
> + * @param prog BPF program from a prepared object
> + * @param opts Optional load options; non-zero fields override defaults
> + * @return program FD (>=3D 0) on success; negative error code on failur=
e
> + */
> +LIBBPF_API int bpf_prog_clone(struct bpf_program *prog,
> +                              struct bpf_prog_load_opts *opts);
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index d18fbcea7578d5f75d5fc925ea9edff52e423faf..515c26b0a139394048fd2b241=
74363b65a0ee644 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -452,6 +452,7 @@ LIBBPF_1.7.0 {
>                 bpf_map__set_exclusive_program;
>                 bpf_map__exclusive_program;
>                 bpf_prog_assoc_struct_ops;
> +               bpf_prog_clone;
>                 bpf_program__assoc_struct_ops;
>                 btf__permute;
>  } LIBBPF_1.6.0;
>
> --
> 2.53.0
>
