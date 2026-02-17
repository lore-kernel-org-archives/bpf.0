Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73719625
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355049; cv=pass; b=hVU9K7g5kpu31eq5iy17WEazncs4FMTWzeQwZetiJu/6Y3uWUutFnSOo5bA61pmkQxod3ng9d4qQg4JRaOf2ih2LPvwfceY3Pi49NrvSRsh26HPGt5U/pSk7SrhC6LzxCxZU51DXCTW5IXXrJqtFWzEgD0juUy4lEdSBxwv5w+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355049; c=relaxed/simple;
	bh=aNTC6ITGPfV/BJ+vHWm7NjW/vn00Y3xxPtrhNCTGl84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJulPwgbgjgj/pOAYHBFogylw8+rTiRTr9dFmOm4Mpp5bRcrizJG2ucAtmjb/H+idfLEz/XwGafH4XPvTwaCe63XeuZSUTwzH+jHOAUKKS5abiE8GHQ6d1yVmfhYLx02WcCJSFQA4n66oKtUDPrGExZdXzravT6HszwxgTqVdP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uz7D29sk; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz7D29sk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aaf5d53eaaso28071465ad.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 11:04:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771355048; cv=none;
        d=google.com; s=arc-20240605;
        b=bK36QM445GyWtr/kuh423QaTIiB9GO8VDLD2DLTphxVd+sh5TuDIi9sri23ZqDGNDg
         9FuYowW6UIvv3nOPsw1TwNP2WX2q1Gcq3swfJWX8id3XAwMQ0aVYAuXpdFGpLB31v8Rf
         gXgz8d7irE59Vdn7vXSwYnVNts9g8Hld4cnjIHjBn9699/p8oquAXepSRSHxNAybJBb1
         Vj9N12RNKPC43CXrIhUjl2sK1T5MUhen55xhC53FMQIFyCb0d3pRYGak3VM+xX9lJKAO
         kUied+uRVZD5aYSL8eOtdzsSDwxER91sLILxhvqBHMKQogz4Vvg+bLZGYX9Kq8KYcGmb
         ExjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cIzXWvJW3gTgj3tbXop58Iuft7SR/IuYSvAwAIZIAE0=;
        fh=kQJoHmciZhFE410Bsj90HR7sS6L9VfCXE26CeirnTkI=;
        b=DHPQqSgpW2yQBAe07wOMv5GjYhOrSZrKUzLxDjo2LuzM2i41db5ssvjwKEFgggu395
         bNP1/jXikupSBH6D8UJZ6JzzINNy3l71bpBQx8/vKfsuwWYTOK6zGNfED8fb6wEFYC7a
         6GDlX2yOtqRVO/iP5Jq6IOOl6XKiUI0oz0WQcdJl+219tZtSHEPwbV0zP/2cMGUkMhXD
         35tDvOdzl6WApmsoTQOorNadJhGy2Il8zsuQGiEOZjKbvz14q3i+pOfXUFA40bbbEC8Y
         km2bP04Vil6/l+Z6z7I8u7j1MlUGBQXDgUzbarBq+Gt81VzHPp9LXmgnnTcfFDIGc7J0
         KnEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771355048; x=1771959848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIzXWvJW3gTgj3tbXop58Iuft7SR/IuYSvAwAIZIAE0=;
        b=Uz7D29sko7XQyYqB+mJXvOXLz/stqkAzzd0wmA7pCdP72r52E3GMM/XtrWE9LJP5Xp
         +ckIjWJuFd3KsmOgelHS8KcIC+A+QgL0OJheFm54QlZn6LxNxRyhrrdkXmvT3azMwkeK
         FOvt22VYrP2JYxEp+lMbz/smXpQF2IvYTl2vlMUi2gYsImZ3AwOQBuFvuOVMTOTSlg4I
         JBXRexSio43yZFZIvET3neMxCinlQhGLTEbd5I7CZmRMAy6Uuii15Fd039NtBRIIWRby
         bUF58xyoclSEffSYt8Fme02LqEGueJ9EE2fM4Fb338tkSw8gcfhNyo+T2GZ8G+kESL4a
         +RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771355048; x=1771959848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cIzXWvJW3gTgj3tbXop58Iuft7SR/IuYSvAwAIZIAE0=;
        b=szkpefHFnz+ivf1g7zRb2HYVaFt/DFtigNgwhUV2NhNPAHIxDFiOw2hdglwcjHHeOy
         cqmvmfrXWfKW0MUOana2/B6t4e3SHcMOGWJ6hEJdWdd7ZNaORnD3fqaKNJhA6znYxN/8
         qWmDO0UAO0YbpeWz/4D0HRQprzplbEyfYWmfUsb+tA7BEmGLgXFRRtEdWuC1uAVl+kNT
         24LZEijqKsw5vbDuOdtt7Okbn+/MGA8nH19sMp6DMQ+D8ZwHqtQzZWMVNVdDomuOh+8x
         dynd/teA+QDPIWmESDIDPE5IGknncAOndbisyyHvE+ci/ap5rks2KjREMbnZHP9DTu3V
         L+zw==
X-Gm-Message-State: AOJu0YyaQvOeDnIwl1cTTbQlKB29gIPsdbQ3MmSrhZwf4WmMq9Sf/Sab
	QI5cw59VJdWzdIJnBdQNtaj1rKjju19+X8tY+oxNk64VcUke1sbtLcuT+b06lB41qcgoMIfdg1k
	VSXxIR8f+aC6NhICe5DxB3ZbjzZMnxPlUjWuD
X-Gm-Gg: AZuq6aKUU/8nBws/zW7Bsd02sF93woZUznDY+p2oXSzTt6peQ0NAv9Fj9/cLmrm+WUr
	j/zRgRonyyeJDi+Ja6wm12kvYQ5Oa3vsmShI29/kbtc7ywqmXCwIjUsnssU4NM/ygkxmziuVORF
	VtZludfZS4u/JfWSf9GBJzmT6oXr9I8B47ZWkzJ1ATbpBIUt1ZOAFgj97iZVI1lqJbUuaDCfQQC
	cVLccYPQ4+ODvsRmtzcd063663i+aq5/4jRn/ir+ptaJI7sj7qBy1G3mCL8hqWIkBr5nf9F/ztX
	8UWNDOTgCt6UlI3SgKMG8MY=
X-Received: by 2002:a17:903:41cc:b0:2aa:e7fe:63b8 with SMTP id
 d9443c01a7336-2ad174dd3b7mr122815105ad.33.1771355047692; Tue, 17 Feb 2026
 11:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214021014.15670-1-emil@etsalapatis.com> <20260214021014.15670-3-emil@etsalapatis.com>
In-Reply-To: <20260214021014.15670-3-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Feb 2026 11:03:54 -0800
X-Gm-Features: AaiRm51DRNA0shiHFI68AcxoaAaCBDalre3EKZTXRci9-PLmSpJ29_DqMB5YCV8
Message-ID: <CAEf4BzYVWzQJ5p2ryGZGj-s6BfxS+qrKyKCS6JrMbVJZGd5KTQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] libbpf: Delay feature gate check until object
 prepare time
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 6:11=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> Commit 728ff167910e ("libbpf: Add gating for arena globals relocation fea=
ture")
> adds a feature gate check that loads a map and BPF program to
> test the running kernel supports large direct offsets for LDIMM64
> instructions. This check is currently used to calculate arena symbol
> offsets during bpf_object__collect_relos, itself called by
> bpf_object_open.
>
> However, the program calling bpf_object_open may not have the permissions=
 to
> load maps and programs. This is the case with the BPF selftests, where
> bpftool is invoked at compilation time during skeleton generation. This
> causes errors as the feature gate unexpectedly fails with -EPERM.
>
> Avoid this by moving all uses of the FEAT_LDIMM64_FULL_RANGE_OFF feature =
gate
> to BPF object preparation time instead.
>
> Fixes: 728ff167910e ("libbpf: Add gating for arena globals relocation fea=
ture")
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  tools/lib/bpf/libbpf.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>

This works, but see some suggestions for a follow up to contain
feature-checking a bit better

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 93e59ed8d9a1..ff38a9db1b13 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3009,11 +3009,11 @@ static int init_arena_map_data(struct bpf_object =
*obj, struct bpf_map *map,
>         memcpy(obj->arena_data, data, data_sz);
>         obj->arena_data_sz =3D data_sz;
>
> -       /* place globals at the end of the arena (if supported) */
> -       if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
> -               obj->arena_data_off =3D mmap_sz - data_alloc_sz;
> -       else
> -               obj->arena_data_off =3D 0;
> +       /*
> +        * possible offset for arena globals into the arena,
> +        * if supported at load time
> +        */
> +       obj->arena_data_off =3D mmap_sz - data_alloc_sz;

I'd keep this obj->arena_data_off at zero at this point (we don't use
it until prepare step, skeleton also just uses obj->arena_data
directly without offset during open phase)...

>
>         /* make bpf_map__init_value() work for ARENA maps */
>         map->mmaped =3D obj->arena_data;
> @@ -4672,7 +4672,7 @@ static int bpf_program__record_reloc(struct bpf_pro=
gram *prog,
>                 reloc_desc->type =3D RELO_DATA;
>                 reloc_desc->insn_idx =3D insn_idx;
>                 reloc_desc->map_idx =3D obj->arena_map_idx;
> -               reloc_desc->sym_off =3D sym->st_value + obj->arena_data_o=
ff;
> +               reloc_desc->sym_off =3D sym->st_value;

this is good, relos don't need to record this offset...

>
>                 map =3D &obj->maps[obj->arena_map_idx];
>                 pr_debug("prog '%s': found arena map %d (%s, sec %d, off =
%zu) for insn %u\n",
> @@ -5556,6 +5556,7 @@ bpf_object__create_maps(struct bpf_object *obj)
>  {
>         struct bpf_map *map;
>         unsigned int i, j;
> +       char *arena_globals;
>         int err;
>         bool retried;
>
> @@ -5633,7 +5634,15 @@ bpf_object__create_maps(struct bpf_object *obj)
>                                         return err;
>                                 }
>                                 if (obj->arena_data) {
> -                                       memcpy(map->mmaped + obj->arena_d=
ata_off, obj->arena_data,
> +                                       /*
> +                                        * Only relocate the globals to t=
he end of the arena
> +                                        * if the kernel supports it.
> +                                        */
> +                                       arena_globals =3D map->mmaped;
> +                                       if (kernel_supports(obj, FEAT_LDI=
MM64_FULL_RANGE_OFF))
> +                                               arena_globals +=3D obj->a=
rena_data_off;

and here I'd instead set arena_data_off to its final value (zero or
proper offset), something like

if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF)
    obj->arena_data_off =3D bpf_map_mmap_sz(map) -
roundup(sysconf(_SC_PAGE_SIZE), sysconf(_SC_PAGE_SIZE));

(note, we did all the correctness checks early in init_arena_map_data,
we don't have to do any more here)

and then the rest of the code stays exactly the same, down to the
original memcpy(map->mmaped + obj->arena_data_off, ...), and no extra
variables


> +
> +                                       memcpy(arena_globals, obj->arena_=
data,
>                                                 obj->arena_data_sz);
>                                         zfree(&obj->arena_data);
>                                 }
> @@ -6386,6 +6395,12 @@ bpf_object__relocate_data(struct bpf_object *obj, =
struct bpf_program *prog)
>                 case RELO_DATA:
>                         map =3D &obj->maps[relo->map_idx];
>                         insn[1].imm =3D insn[0].imm + relo->sym_off;
> +
> +                       if (relo->map_idx =3D=3D obj->arena_map_idx &&
> +                           kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_=
OFF)) {
> +                               insn[1].imm +=3D obj->arena_data_off;
> +                       }
> +

here too we don't need feature checking, our obj->arena_data_off
should have a valid value (might be zero, that's fine)

>                         if (obj->gen_loader) {
>                                 insn[0].src_reg =3D BPF_PSEUDO_MAP_IDX_VA=
LUE;
>                                 insn[0].imm =3D relo->map_idx;
> @@ -14456,7 +14471,7 @@ int bpf_object__load_skeleton(struct bpf_object_s=
keleton *s)
>                 if (!map_skel->mmaped)
>                         continue;
>
> -               if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA)
> +               if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA && kernel_sup=
ports(*s->obj, FEAT_LDIMM64_FULL_RANGE_OFF))
>                         *map_skel->mmaped =3D map->mmaped + map->obj->are=
na_data_off;

and here as well, no need to expose feature check here, we have
map->obj->arena_data_off set correctly

>                 else
>                         *map_skel->mmaped =3D map->mmaped;
> --
> 2.49.0
>
