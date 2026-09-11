Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90C3F8898
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153793; cv=pass; b=VqBngq8OxNtWK+TOtsHLrCJLbOS8iJ1PDc7OBvju1+NCbjhTLDF1wD7ylmdgPCZ8bUX+RwxHFuU/Wll/21gKNWPshesszQiFUSTipZOMD3IjCpRhnqPcB9T9l9r+vhPl/OWQTqxOUELPSXYrgY/l3Ui6DaLJAOHicwaqANkVKk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153793; c=relaxed/simple;
	bh=t68U1RhcMfyku4E1nHiQ0z7KjaiJOw8gSWlsWBs9Ulo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfqztwAm5/DfQmXYUaS3yglaWvuqRMlksGv62BSsQIsjZq4XlKLtCVpkVPnOSlQQDK5mn+2IEBpWtv3YtVQuPZthQ3kOOx59Q0ySQhcXC9eoldilpDkUhpgiFsydPEhduFPZNHIV2wSjRM2iudVKNfHuuPwEE+TY2z6VKLaTWpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUT96gMm; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUT96gMm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d58efc7356so18428055ad.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 12:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789153788; cv=none;
        d=google.com; s=arc-20260327;
        b=gp1LlUJpAadj4sqIxWvMDSOCAS2l1Y99re7Oj28T0brRZyy2jsxPve2UTvQIknHHl8
         viV4QYWgXTli72GmpwqQH0nIaSwnxgno6WgVmAloH3MwrzOpFsGUcs8Ws/l+3UK3l5K9
         SJIRsQHN1FHFHOLaZxq9xIjAGk4HirqziNcPUAVAIZV5/reGNEs+T4nUKJdUs8gxiF9d
         0tTNt+HFkeXeL6XO7ZrapHA4dLoDnyF8YD+4GIvmP2Nn2yKNql9K8Y4vXQwvVWMTdqdt
         fv5Br6Imj6XLENKPpfVKCURW1yLHY+Gkkt2GJq7Og6yLidjYTAZWcymJIHiEx3VVzDH+
         n95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HxBnYviaKnot3JD7Ip8qV0PmKuDvoY1dcqiPFDgt9VM=;
        fh=zDR7lc7fd0IPA0mjkPtyGEAByUJjbdvR+OYeIV4wiJ0=;
        b=RFG2fm+xYalNiV93sLU1Ntqm/nieGXHRuZ98Y0BIiIemltD91trr8KIkX6UIF/8G3J
         wQn7W8TdD96ojkWbwL1tFdbiybq5bjjLzEgnUxLoT6OSngjg7nv2Al3Tz41VNmZE8pJN
         i4X30TCtETbecqm44uygdQkN7ZVmeITuppINM8VGH7GLfTkSeVCieTGtu9a+M32WTkWD
         P6+9iv/CZPh7E5RalBiQHMFi2wdI0x9f5FBN1YrUda7sc8cGbUT08/R3c9zZ9/LWwtMj
         rFGax24CwjHyKQwbWMU4A1+U52L/vw7aEjlPOZeNp77/RK+/DK3Y8vFoVwNpDBbCe84k
         UOrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789153788; x=1789758588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HxBnYviaKnot3JD7Ip8qV0PmKuDvoY1dcqiPFDgt9VM=;
        b=RUT96gMmrSCY25YczBpHCEJT8NY8e8gU7TMg1AMkhwZXv+iYp7pj0G8xfqw7xQ78dC
         8nKv//Sf9SZWfEEwqae5t9tFoIesfqx2VRzOlEpDJkjjd87MpzFIqf12BfYjWyjhcRnM
         SvnmJIgkbC5+ZY5BjtRCRNFUcWTKCxrgR7795LKza1eUskHSNyPVM4TogN9VBTUFogRF
         pdD8mLwKjcwQvG/846NsMLZRrVNGg3eRJdeORkmSa8RxEo5Gmc4bHIzU6S89izuG2PgU
         6GiowsjTGhjm+gBLmNu1JQjLXfP7I39j9PbUO7Ou34j2gyDc+aHQGPy0osgIvJXsKcy0
         i/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789153788; x=1789758588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HxBnYviaKnot3JD7Ip8qV0PmKuDvoY1dcqiPFDgt9VM=;
        b=Ea7ToscEimzhWI4zoGfmDL2NkxtNmO9+oL9lUrsO+qFEImg78178sRBxWpSP+nh5/z
         vBRQTG+i2s9el+sQfEDZx2f/5AKxidw+Sq24D5kvMqa8CoN8CiUSNKhBl1e+RaSDJwsC
         rpPZFoE/AcSD0wBdH+vyClQUJqQD8TouslvHn4R9BhRz3hoBq2FcLc+xakxESsZE7G/p
         zhZYktbX3AyPXutkJoFuBv+rWafssHQ+vFKJPP8+x/59EiLGi1nSst/hySQ+wtbecbXe
         jVOaaiSk7GgjJExlaUeoAOdALuflELNbOpxsDm/DKILnBw061nWXHDw2RiyDFFKt+uxy
         aDVQ==
X-Gm-Message-State: AFuF++mmWz/TkoDMHafiENSD4kyyvXkH9gZ5MigzjxMzddlDwAs+WC4j
	1xxettBefJwUYSq+ubVcR/gB0YbBJRxyguVLkUhMvG1jZe2ogMnpAxtEKJ7FrE+G2dp+CzlWX93
	MyH66wH4HXdLnlqMhqzlTsKtlXiQkCnQ=
X-Gm-Gg: AYBFou1Gr+/2seBLChcHF8D0o95u18zboQXQywXPAHsH3OeMBUd9j2aZ7gUogviWI5l
	dpI0jb0Y8JxS7Yjxyldm+sxg2UJbJP6ssfdKkTv5KHJVB8Xk+2Zs51Gxi6zDGEgl5jvXez6vSfl
	LQ3Ox5UlPOvM8baiVKlUNaN1IezLlKzI7sLwsAX7qEQ55gpEk5dK3Lyx97xOOfrsMg/lnCsl4II
	iQXxUT+Ov0iX/jLwldYZPEdYrytkYI+vxCPVBix93TzX6y2CkKHwij35sTT6m19WT0cG4bso832
	AecaNYVX6jiuhlXB6Nowe4y2OoFcCLX2AOUtBpuuK/mrwmWR2gLXuBOUrf6bAZeaHhEh1fK/zc8
	b36Qw0VAgn6A/ftlW6JNMebUnBLCC8+IfDSZJstYLNjXfMHk=
X-Received: by 2002:a17:90b:2d03:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-39d9bc3f8c8mr9089834a91.6.1789153787860; Fri, 11 Sep 2026
 12:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911145914.23676-1-leon.hwang@linux.dev>
In-Reply-To: <20260911145914.23676-1-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 12:09:36 -0700
X-Gm-Features: AcwNN1XpdaLHjnOIrzt8AsZjQzusOGkcm82c6vNUfKKJSZjajLO4amshejVAhjA
Message-ID: <CAEf4BzZQW2=gxMRQVtMpCF3pA2N-O6Z0o5POBzHGQG6rc3sdrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Compute map size of light skeletons at runtime
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 7:59=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> bpftool rounds memory-mapped data map sizes to the host page size when
> generating a light skeleton. The generated code therefore uses a 64K
> mapping size when bpftool runs on a 64K-page host, even if the skeleton
> runs on a 4K-page target. The target rejects the oversized map mmap(),
> causing failure of loading the light skeleton.
>
> When try to run 64K-page selftests on 4K-page VM, the error message does
> not provide the reason about page size.
>
>  test_atomics:PASS:atomics skeleton open 0 nsec
>  test_atomics:FAIL:atomics skeleton load unexpected error: -12 (errno 22)
>  #15      atomics:FAIL
>
> Pass the original map value size to the generated code and round it to th=
e
> runtime page size in the user-space light skeleton helpers. This keeps
> generated light skeletons independent of the build host page size.
>
> Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" =
and "gen skeleton" command.")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/bpf/bpftool/gen.c       | 27 ++++++++-------------------
>  tools/lib/bpf/skel_internal.h | 18 +++++++++++++-----
>  2 files changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a50540ef6521..77f04c28fee9 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -500,16 +500,6 @@ static void print_hex(const char *data, int data_sz)
>         }
>  }
>
> -static size_t bpf_map_mmap_sz(const struct bpf_map *map)
> -{
> -       long page_sz =3D sysconf(_SC_PAGE_SIZE);
> -       size_t map_sz;
> -
> -       map_sz =3D (size_t)roundup(bpf_map__value_size(map), 8) * bpf_map=
__max_entries(map);
> -       map_sz =3D roundup(map_sz, page_sz);
> -       return map_sz;
> -}
> -
>  /* Emit type size asserts for all top-level fields in memory-mapped inte=
rnal maps. */
>  static void codegen_asserts(struct bpf_object *obj, const char *obj_name=
)
>  {
> @@ -686,8 +676,8 @@ static void codegen_destroy(struct bpf_object *obj, c=
onst char *obj_name)
>                 if (!get_map_ident(map, ident, sizeof(ident)))
>                         continue;
>                 if (is_skel_data(map, ident, sizeof(ident)))
> -                       printf("\tskel_free_map_data(skel->%1$s, skel->ma=
ps.%1$s.initial_value, %2$zu);\n",
> -                              ident, bpf_map_mmap_sz(map));
> +                       printf("\tskel_free_map_data(skel->%1$s, skel->ma=
ps.%1$s.initial_value, %2$u);\n",
> +                              ident, bpf_map__value_size(map));
>                 codegen("\
>                         \n\
>                                 skel_closenz(skel->maps.%1$s.map_fd);    =
   \n\
> @@ -771,13 +761,12 @@ static int gen_trace(struct bpf_object *obj, const =
char *obj_name, const char *h
>                 \n\
>                 \";                                                      =
   \n\
>                                                                          =
   \n\
> -                               skel->%1$s =3D (__typeof__(skel->%1$s))sk=
el_prep_map_data((void *)data, %2$zd,\n\
> -                                                               sizeof(da=
ta) - 1);\n\
> +                               skel->%1$s =3D (__typeof__(skel->%1$s))sk=
el_prep_map_data((void *)data, sizeof(data) - 1);\n\
>                                 if (!skel->%1$s)                         =
   \n\
>                                         goto cleanup;                    =
   \n\
>                                 skel->maps.%1$s.initial_value =3D (__u64)=
 (long) skel->%1$s;\n\
>                         }                                                =
   \n\
> -                       ", ident, bpf_map_mmap_sz(map));
> +                       ", ident);
>         }
>         codegen("\
>                 \n\
> @@ -871,14 +860,14 @@ static int gen_trace(struct bpf_object *obj, const =
char *obj_name, const char *h
>                 if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) =
{
>                         codegen("\
>                 \n\
> -                       err =3D skel_protect_map_data(skel->%1$s, &skel->=
maps.%1$s.initial_value, %2$zd);\n\
> +                       err =3D skel_protect_map_data(skel->%1$s, &skel->=
maps.%1$s.initial_value, %2$u);\n\
>                         if (err)                                         =
   \n\
>                                 return err;                              =
   \n\
>                 #ifdef __KERNEL__                                        =
   \n\
>                         skel->%1$s =3D NULL;                             =
     \n\
>                 #endif                                                   =
   \n\
>                         ",
> -                       ident, bpf_map_mmap_sz(map));
> +                       ident, bpf_map__value_size(map));
>                         continue;
>                 }
>
> @@ -890,11 +879,11 @@ static int gen_trace(struct bpf_object *obj, const =
char *obj_name, const char *h
>                 codegen("\
>                 \n\
>                         skel->%1$s =3D (__typeof__(skel->%1$s))skel_final=
ize_map_data(&skel->maps.%1$s.initial_value,\n\
> -                                                       %2$zd, %3$s, skel=
->maps.%1$s.map_fd);\n\
> +                                                       %2$u, %3$s, skel-=
>maps.%1$s.map_fd);\n\
>                         if (!skel->%1$s)                                 =
   \n\
>                                 return -ENOMEM;                          =
   \n\
>                         ",
> -                      ident, bpf_map_mmap_sz(map), mmap_flags);
> +                      ident, bpf_map__value_size(map), mmap_flags);
>         }
>         codegen("\
>                 \n\
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.=
h
> index 1f3f332dffbe..5787911f17f5 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -11,6 +11,7 @@
>  #include <linux/bpf.h>
>  #else
>  #include <unistd.h>
> +#include <sys/param.h>
>  #include <sys/syscall.h>
>  #include <sys/mman.h>
>  #include <linux/keyctl.h>
> @@ -138,7 +139,7 @@ static inline void skel_free_map_data(void *p, __u64 =
addr, size_t sz)
>          */
>  }
>
> -static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, =
size_t val_sz)
> +static inline void *skel_prep_map_data(const void *val, size_t val_sz)
>  {
>         void *addr;
>
> @@ -149,7 +150,7 @@ static inline void *skel_prep_map_data(const void *va=
l, size_t mmap_sz, size_t v
>         return addr;
>  }
>
> -static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_=
sz, int flags, int fd)
> +static inline void *skel_finalize_map_data(__u64 *init_val, size_t val_s=
z, int flags, int fd)
>  {
>         struct bpf_map *map;
>         void *addr =3D NULL;
> @@ -193,13 +194,19 @@ static inline void skel_free(void *p)
>         free(p);
>  }
>
> +static inline size_t skel_map_mmap_sz(size_t sz)
> +{
> +       return roundup(sz, sysconf(_SC_PAGE_SIZE));

original code had this logic:

map_sz =3D (size_t)roundup(bpf_map__value_size(map), 8) *
bpf_map__max_entries(map);
map_sz =3D roundup(map_sz, page_sz);

you completely ignore max_entries in a new code now, which works for
global data because that have max_entires 1, but at the very least we
should add some check or assert for that so that we don't miss a case
when max_entries is not 1

pw-bot: cr

> +}
> +
>  static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
>  {
> -       munmap(p, sz);
> +       munmap(p, skel_map_mmap_sz(sz));
>  }
>
> -static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, =
size_t val_sz)
> +static inline void *skel_prep_map_data(const void *val, size_t val_sz)
>  {
> +       size_t mmap_sz =3D skel_map_mmap_sz(val_sz);
>         void *addr;
>
>         addr =3D mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
> @@ -210,8 +217,9 @@ static inline void *skel_prep_map_data(const void *va=
l, size_t mmap_sz, size_t v
>         return addr;
>  }
>
> -static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_=
sz, int flags, int fd)
> +static inline void *skel_finalize_map_data(__u64 *init_val, size_t val_s=
z, int flags, int fd)
>  {
> +       size_t mmap_sz =3D skel_map_mmap_sz(val_sz);
>         void *addr;
>
>         addr =3D mmap((void *) (long) *init_val, mmap_sz, flags, MAP_SHAR=
ED | MAP_FIXED, fd, 0);
> --
> 2.55.0
>
