Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F0736F426
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254784; cv=pass; b=TliYKIOQo/f3gGLQ/tBrA+cTrYoDBLuPKnjKgeAyVl0jdtokqt1pWXzEjdov6z0tuweq3MqJEY/Dpy0zyydRlJ078L4GO62hIkB9pE1sj7kGvxM7HtB1RVCTu2zEAUfYJfuCJ2B+8HZu2GyQj5HCtwksOOdiJqPZnMni5O1VTSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254784; c=relaxed/simple;
	bh=2KfuZmVM/gMcaXgErOb5bxKkcTPuwXT7L/88bA0HkXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tURt7oLvlaVVZOAnAK/7hsvuZPpgCEIJbDpu7rtJJUR9G4kcQ3Yveq9G5Sbafxx34TPV34B3e6Pssc4Nh70LZzuysjKwuCKXoubyNbtLImzA/yHKGCx4rfvOn1eWvhpyldzFwN+eVbj5cypGwuCWvwOOIEZldIB2At7mMAH7BnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/A32Cje; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/A32Cje"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c7d329fe93so2002655ad.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 15:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782254782; cv=none;
        d=google.com; s=arc-20240605;
        b=WRUhfc6l4KkUOzN8K/Dv/EdViOIOpqJtNQUw3ImQWnD7EB1tT/Bm6R3OJ056Ij3dft
         sMLBF/SQkT0FMtOXCHium46RasN/O7GQpXUHw0HebBHuSTxQBpGEetfXTaQF0DoiDdte
         uYN0iDfSmhEW2ow8vl8/6uS2/mq8NdgXub0oMdRx57rAASkOxcyJko2R7wORFZqPvXPD
         sUhC/upCU3BC09+J4nYjPX5a+sLHLdJ+gLySkXvGkVcgaWfi4gP8UBJ2X1qUgsawy1OF
         TF34walBj+wEaDfHThi0g9DasDqF7w5UEOoMnHGCSNlbfCvPb6LdOIhJd3MjI/c50np7
         ri2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LG2kX0FyH0fi9b0fEy2d9lpzMp4yF/LqqDGrDnJk65A=;
        fh=IqI/Cp1xYGcfpyBgkhc6h3oFTMbeXOsSrhhlFByRLHg=;
        b=kpa8go0Nkb2VdCX/Gn+aPCoP94STcRvwsTP9C/NIwqKTRnn8P547ryA9b0wunGlIZJ
         +oFAz7ImBJi+62E4iFFcdshIgMb6exW1V+V4XyirjVyIo0ZMrWTpr2qzsRG0Qhy2GB9Y
         F6hAV6/V484K1Lt54puSPLI7dGJJM9J+/Nh0kBmwqzxMs+UZ2C1xMSAFdNFDlCrjgRAw
         wWupwHIzR/KjwC1o/Fn4N5bTtfTLyghpe8OFA1gDTgwmWCo8KKf3agBYTNcJqfuYvtum
         C1ZsdCWLmya178aZFmBK/w9JL77kYYfH+MMuKvbAFrdFxzyvVcNSduc9xsqP1w2JeguD
         v/ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782254782; x=1782859582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG2kX0FyH0fi9b0fEy2d9lpzMp4yF/LqqDGrDnJk65A=;
        b=R/A32Cjerpc/032rWMm9ZS/T7o81vkYKOWDTydhy9ANYA2qxavW5TBtMTGjJoBGvtP
         4yGMoPH+QZ4vmoYsdIvVQ6URjxoHeTwSBX8ghkUDj663WQrN5xmMxxxqdsjk/ed8TEXV
         nYQuDLHx/zJ8p3o6V3iLTiJcVXToj74tEadXEqplabrf7iOUvSHoQPIlbKw6KV26EXVJ
         cqxo2lJ5sLqZJ26+5yxX8l/Y+4gGUnPF5mqCD0COYIgcON9oojB/YGWiPfr6xLXQjqRk
         ZlBOyg1rbaUtcZMBqL50f50X5ghX6FdNXmtaQbyaPNNiXbX0e5dS3eAGfUraVhTetPoA
         9Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782254782; x=1782859582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LG2kX0FyH0fi9b0fEy2d9lpzMp4yF/LqqDGrDnJk65A=;
        b=bU8YjP4+5U8lDBu+Ywro/K2/dOazayUe86LIiLhsXBZRfF0fRtV9ukMi3oPiifBllR
         KM4cPZFxo8z2P8O1ydFlxeGJ1fVQZk93haIgHceTxO+GK0AgYn2fc+TY58SssRkMOZe2
         KZwbXUUcxn6H1y12nfyuEbWSWG51d6n5eXIw3EAaAsMOQawJJ557KPBlu7bwPeGKK9Rf
         ax0mO7tywothH/APa5Tyj9uyZw+yKirkCab3uJJD0l/ysPUOcsuwgskU0y2Mga1lpqp0
         vZlDjdkeFUnW+/nVMKXoq5rbRHL/oFrAixKlNUimNWOxj9p7pkL7vkLfaU7YIta9Ed0A
         //bQ==
X-Gm-Message-State: AOJu0YxZjhhc2DjYKNEdDTP71QoJ0NZo9YDoP/Cn9XZ8nhmqWgi6PxHp
	96yZ5Gptj5/O+yM+v+llnRWnIBA8RNBQ4HILoQdHocpMk2wbrjf0m0oCTBRz4vjJGK1QZ6coNIM
	6hVXJT6hGvEaUXEXrCLYiwf9BOLFb5Fk=
X-Gm-Gg: AfdE7cl+RZeDxnhfvseHObCqDlIoJlS0PpO9+SGMPptaPnfz+phGJ+Qhhohm92grKYM
	GfC/srdJCDxS9eL6qB6MTmzhLBxgdDSTkStuzljaytNQlF2xORex5Lh1lemV5s4zL21cM3p8Tax
	3YYHeF1xTm40ru9UUAltIwRcBM3kCBMyNd4rJ8D2p1byId5eWcPE4KuGmE9QjtTnnjO/sRQObUF
	dWNssEKvj+DZG9T+qpwuApYm1AWJM0nYU1z9zTIHwJfRgN4v3ztoORnlvPUyWxpnL3Ft8UNQAm3
	db6GXeGFGX9sVlH93RaxB0OokfmyHz9lkstw4aJ1arJUhFzB6Atdny2xdmpyWPVKFkTvAw==
X-Received: by 2002:a17:902:ccca:b0:2bd:9803:9308 with SMTP id
 d9443c01a7336-2c7e1599b6bmr7966225ad.36.1782254782100; Tue, 23 Jun 2026
 15:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622143557.22955-1-leon.hwang@linux.dev> <20260622143557.22955-8-leon.hwang@linux.dev>
In-Reply-To: <20260622143557.22955-8-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 15:46:03 -0700
X-Gm-Features: AVVi8CcgnEvwwbjcYZujttXeSs_xcAFmcG2-55vXm4A13ZgA43xyrkXYm4hX8Rw
Message-ID: <CAEf4Bzay2Wssj1J4fEq3T7iTOBDswEZunm1OQNDJvPr2Cz2Usg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 07/11] bpftool: Generate skeleton for global
 percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 7:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Enhance bpftool to generate skeletons that properly handle global percpu
> variables. The generated skeleton now includes a dedicated structure for
> percpu data, allowing users to initialize and access percpu variables mor=
e
> efficiently.
>
> For global percpu variables, the skeleton now includes a nested
> structure, e.g.:
>
> struct test_global_percpu_data {
>         struct bpf_object_skeleton *skeleton;
>         struct bpf_object *obj;
>         struct {
>                 struct bpf_map *percpu;
>         } maps;
>         // ...
>         struct test_global_percpu_data__percpu {
>                 int data;
>                 char run;
>                 struct {
>                         char set;
>                         int i;
>                         int nums[7];
>                 } struct_data;
>                 int nums[7];
>         } *percpu;
>
>         // ...
> };
>
>   * The "struct test_global_percpu_data__percpu *percpu" points to
>     initialized data, which is actually "maps.percpu->mmaped".
>   * Before loading the skeleton, updating the
>     "struct test_global_percpu_data__percpu *percpu" modifies the initial
>     value of the corresponding global percpu variables.
>   * After loading the skeleton, "maps.percpu->mmaped" has been marked as
>     read-only in libbpf. If users want to update the global percpu
>     variables, they have to update the "maps.percpu" map instead.
>   * For lightweight skeleton, "lskel->percpu" will be protected by
>     "mprotect(p, sz, PROT_READ)".
>   * For subskeleton, those variables of global percpu data will be
>     skipped.
>
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/bpf/bpftool/gen.c       | 43 +++++++++++++++++++++++++++--------
>  tools/lib/bpf/skel_internal.h | 24 +++++++++++++++++--
>  2 files changed, 56 insertions(+), 11 deletions(-)
>

[...]

> @@ -263,13 +268,12 @@ static bool is_mmapable_map(const struct bpf_map *m=
ap, char *buf, size_t sz)
>                 return true;
>         }
>
> -       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF=
_F_MMAPABLE))
> -               return false;
> -
> -       if (!get_map_ident(map, buf, sz))
> -               return false;
> +       if (bpf_map__is_internal(map) &&
> +           ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) || bpf_map_is_per=
cpu_data(map)) &&
> +           get_map_ident(map, buf, sz))
> +               return true;
>

just add `if (bpf_map_is_percpu_data(map) return true;`? maybe also
move get_map_ident check a bit earlier. I think that will be a bit
cleaner, this condition is quite hard to follow

> -       return true;
> +       return false;
>  }
>
>  static int codegen_datasecs(struct bpf_object *obj, const char *obj_name=
)
> @@ -343,6 +347,9 @@ static int codegen_subskel_datasecs(struct bpf_object=
 *obj, const char *obj_name
>                 if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
>                         continue;
>
> +               if (bpf_map_is_percpu_data(map))
> +                       continue;
> +
>                 sec =3D find_type_for_map(btf, map_ident);
>                 if (!sec)
>                         continue;
> @@ -669,7 +676,7 @@ static void codegen_destroy(struct bpf_object *obj, c=
onst char *obj_name)
>                 if (!get_map_ident(map, ident, sizeof(ident)))
>                         continue;
>                 if (bpf_map__is_internal(map) &&
> -                   (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> +                   ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) || bpf_ma=
p_is_percpu_data(map)))

also we can add a helper to check if it's an internal map with a
dedicated data section in the skeleton (too lazy to think of a good
name right now.. ;)

>                         printf("\tskel_free_map_data(skel->%1$s, skel->ma=
ps.%1$s.initial_value, %2$zu);\n",
>                                ident, bpf_map_mmap_sz(map));
>                 codegen("\

[...]
