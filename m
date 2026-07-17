Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283D3438B7
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325140; cv=none; b=nw30T3VBwOm+wK1ey8xpYzPVihtoZJMYNjPGaKW+CJISbthSpV7umq7315Qj8qXGsC6hgwvcj3TEF/J366dThOcTRsNIVwRcCelgkNKBWhFN0izj1ADk1zeYkKxOiWkm3hhCFgTA0rUlE6OKsNOA7BH4u9B+YvmkT5/inEf3oBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325140; c=relaxed/simple;
	bh=55EzlMufrn+hckL4EKFgbR5tUr6d3Envr0gIRu0iIkY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nMxp7x8QaGr0VyUqOzqWC/EaNfJGWh4NtUzxFhvTZhttJpDeff89m+wKOWjQV0SWdnlZD6gxBwRossbwkyVO97IMHJqaoixmKGBOAAoy3e4MSQgvZsG2XdBg//qVYzDltwiCCag3K4hOWf6GjJyO7jyrkQdX9N3SSPGPCa9ja8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=e5cCPdyh; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="e5cCPdyh"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso5551063a12.2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 14:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784325138; x=1784929938; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8xICSg/3uLQX5g2+LM6seI/bgJKFaOXV9vjEkcMgNPU=;
        b=e5cCPdyhQv13naxSZRKizKQe0oEO6Qqdgs/XUhtIhiKSlQUKN7HmfF0etVzoPQwaxi
         L7jCaDOLNntvkFZJzubi4KjJvueIKbJCEpXNNqy1GEeom6pOe4tCuAorVPZqStXn2zjM
         tP4w5DxsVqEJsJgMkZJ7lFnGu1gg3Dntg2YrbzjHMUFd/CHF8c4N04YbfyjcCRyIChPV
         F57458IO05z05o3yaTdTIUKhFuB9+2rLUIdvxIWvZOQXbusmjAEHMDyA401tNmIgIbPg
         utA9dlJw8deH9QP2tmbYg/Gqv/cpJsPrwoUKxIW7Ow7qN42H4VGYagkr+4o97WyV718H
         Vo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325138; x=1784929938;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xICSg/3uLQX5g2+LM6seI/bgJKFaOXV9vjEkcMgNPU=;
        b=khmx3UpFFVESYW5Us0BkvAl6sPSU7nioXAtyLNtqGU569AFMf7G5VMy3iJPUUf1GeS
         69UZydyFdwA1YUZhEd8TaVR/5Qmixe7ebhdBXdRVP26POilkokZ5pX2h0IPgNIeX3sUv
         bxokdz8ppqlEULaQJMjc8AVQJhQN0bMXafz0NoyZ5Az0OhBuLaaQBnCELg/82PsqEfGj
         l1Uu8Ae5bfIVcryIs6fWCfq6TP5Qs8Dm6F90ZKL/GNErO4O3MImppfx3w4mVvlNIGvrS
         ZAQNWyH6fQv58SuccZZBm8Hnj3IA/JdhzIYyjYT0IzxvmDGR43tcZhTj/eJFoeeNgk8f
         8qxw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0BndwGxvNVIHEkRl+UL2rPyPRadEi0/QwBjW0Wrhu5xrGxpicxhu/NC+vcg1D2msnQ9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlBOyOZ4cPF4bOrC3DWG5tZVM3B9tbPjJubbMTIZpeqy5YnX2
	1G8Ol3jrDjIh+zbrRoTeeZraY/EAouqrdeaQJ3MxrHPCNrFIxXH4WOjmqqAGnZy30+A=
X-Gm-Gg: AfdE7cnLhRv1mfKwoAwlMDbE5ozmWUUKRD1Qf2CKuMYni8C4Yo1ogC3APp6N8TL5919
	U90YUVCkaERue8//LEaYEdb+8cQwO6BYFKlqdI5hFdp1WCwvlI6WIb2PywYGwBvcWGlYb4DR1m+
	e7iFgjNbn6nVR9mMbTP/8Qqj/asfDkur7k5ZJql1KxAtM1h7nxsta1CCROgkUBbqptY8czwSuEw
	9wU1mjHGfLl5T76yIwAPjepFx6s0WoeCkSPvl0Q0USHBVjaE273EHvPtB+Wd2AMbMS4ybxMkQRY
	fmJzMfAiUy57r1fglwLwYxWiNaLwstOELBSDycGtUQj5YYybfagwVbnUQjN46TT66PtXRmDunGI
	kS+ppOOBPPW99adMM6m+McupA6n5p2NT2KGdCb+uG8Z7Q81ce6H7eRYbdir8=
X-Received: by 2002:a05:6a20:9630:b0:3bf:8de9:c647 with SMTP id adf61e73a8af0-3c3ad355d6dmr5251707637.0.1784325138039;
        Fri, 17 Jul 2026 14:52:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::f5f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1ddeb6sm12396518eec.20.2026.07.17.14.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 14:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 17:52:15 -0400
Message-Id: <DK16GZ1CVRYZ.1ZKXOISH3846Z@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Quentin Monnet"
 <qmo@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v10 5/9] bpftool: Generate skeleton for global
 percpu data
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260715153254.92010-1-leon.hwang@linux.dev>
 <20260715153254.92010-6-leon.hwang@linux.dev>
In-Reply-To: <20260715153254.92010-6-leon.hwang@linux.dev>

On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:
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
> 	struct bpf_object_skeleton *skeleton;
> 	struct bpf_object *obj;
> 	struct {
> 		struct bpf_map *percpu;
> 	} maps;
> 	// ...
> 	struct test_global_percpu_data__percpu {
> 		int data;
> 		char run;
> 		struct {
> 			char set;
> 			int i;
> 			int nums[7];
> 		} struct_data;
> 		int nums[7];
> 	} *percpu;
>
> 	// ...
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
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/bpf/bpftool/gen.c       | 76 +++++++++++++++++++++++++++--------
>  tools/lib/bpf/skel_internal.h | 24 ++++++++++-
>  2 files changed, 81 insertions(+), 19 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a01d06d22d1a..b60db1108149 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -101,6 +101,12 @@ static bool get_map_ident(const struct bpf_map *map,=
 char *buf, size_t buf_sz)
>  		return true;
>  	}
> =20
> +	if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
> +		snprintf(buf, buf_sz, "%s", name + 1);
> +		sanitize_identifier(buf);
> +		return true;
> +	}
> +
>  	for  (i =3D 0, n =3D ARRAY_SIZE(sfxs); i < n; i++) {
>  		const char *sfx =3D sfxs[i], *p;
> =20
> @@ -117,7 +123,7 @@ static bool get_map_ident(const struct bpf_map *map, =
char *buf, size_t buf_sz)
> =20
>  static bool get_datasec_ident(const char *sec_name, char *buf, size_t bu=
f_sz)
>  {
> -	static const char *pfxs[] =3D { ".data", ".rodata", ".bss", ".kconfig" =
};
> +	static const char *pfxs[] =3D { ".data", ".rodata", ".bss", ".percpu", =
".kconfig" };
>  	int i, n;
> =20
>  	/* recognize hard coded LLVM section name */
> @@ -254,7 +260,7 @@ static const struct btf_type *find_type_for_map(struc=
t btf *btf, const char *map
>  	return NULL;
>  }
> =20
> -static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t=
 sz)
> +static bool is_skel_data(const struct bpf_map *map, char *buf, size_t sz=
)

Here we change the function to take PERCPU_ARRAY into account, but then=20
immediately turn around and add checks of the form is_skel_data && type
!=3D BPF_MAP_TYPE_PERCPU_ARRAY. If we keep both the existing mmapable_map
and add a separate is_skel_data map (possibly using is_mappable_map),
we can remove those additional checks.

>  {
>  	size_t tmp_sz;
> =20
> @@ -263,13 +269,19 @@ static bool is_mmapable_map(const struct bpf_map *m=
ap, char *buf, size_t sz)
>  		return true;
>  	}
> =20
> -	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMA=
PABLE))
> +	if (!bpf_map__is_internal(map))
>  		return false;
> =20
>  	if (!get_map_ident(map, buf, sz))
>  		return false;
> =20
> -	return true;
> +	if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
> +		return true;
> +
> +	if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +		return true;
> +
> +	return false;
>  }
> =20
>  static int codegen_datasecs(struct bpf_object *obj, const char *obj_name=
)
> @@ -286,8 +298,11 @@ static int codegen_datasecs(struct bpf_object *obj, =
const char *obj_name)
>  		return -errno;
> =20
>  	bpf_object__for_each_map(map, obj) {
> -		/* only generate definitions for memory-mapped internal maps */
> -		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
> +		/*
> +		 * Only generate definitions for internal maps that have
> +		 * mmapped data.
> +		 */
> +		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
>  			continue;
> =20
>  		sec =3D find_type_for_map(btf, map_ident);
> @@ -339,8 +354,14 @@ static int codegen_subskel_datasecs(struct bpf_objec=
t *obj, const char *obj_name
>  		return -errno;
> =20
>  	bpf_object__for_each_map(map, obj) {
> -		/* only generate definitions for memory-mapped internal maps */
> -		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
> +		/*
> +		 * Only generate definitions for internal maps that have
> +		 * mmapped data.
> +		 */
> +		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
> +			continue;
> +
> +		if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
>  			continue;

Case in point, the old is_mmapable_map would work fine here.

> =20
>  		sec =3D find_type_for_map(btf, map_ident);
> @@ -493,7 +514,10 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *=
map)
>  	return map_sz;
>  }
> =20
> -/* Emit type size asserts for all top-level fields in memory-mapped inte=
rnal maps. */
> +/*
> + * Emit type size asserts for all top-level fields in internal maps that
> + * have mmaped data.

I do not think the new comment makes it any clearer, the difference is
"memory-mapped internal maps" and "maps that are memory-mapped initially
but actually inaccessible after loading because there's no way to=20
represent them as a mapping of the skeleton" AFAICT which is not easy
to infer currently.

> + */
>  static void codegen_asserts(struct bpf_object *obj, const char *obj_name=
)
>  {
>  	struct btf *btf =3D bpf_object__btf(obj);
> @@ -517,7 +541,7 @@ static void codegen_asserts(struct bpf_object *obj, c=
onst char *obj_name)
>  		", obj_name);
> =20
>  	bpf_object__for_each_map(map, obj) {
> -		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
> +		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
>  			continue;
> =20
>  		sec =3D find_type_for_map(btf, map_ident);
> @@ -669,7 +693,8 @@ static void codegen_destroy(struct bpf_object *obj, c=
onst char *obj_name)
>  		if (!get_map_ident(map, ident, sizeof(ident)))
>  			continue;
>  		if (bpf_map__is_internal(map) &&
> -		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> +		    ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) ||
> +		     bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY))

I think this gives us a hint on how we could structure is_skel_data
above, we now have a special calss that is "mappable maps + PERCPU_ARRAY
whose initial representation in userspace is mappable, but the loaded
map isn't".

>  			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_valu=
e, %2$zu);\n",
>  			       ident, bpf_map_mmap_sz(map));
>  		codegen("\
> @@ -741,7 +766,7 @@ static int gen_trace(struct bpf_object *obj, const ch=
ar *obj_name, const char *h
>  		const void *mmap_data =3D NULL;
>  		size_t mmap_size =3D 0;
> =20
> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
> +		if (!is_skel_data(map, ident, sizeof(ident)))
>  			continue;
> =20
>  		codegen("\
> @@ -849,8 +874,22 @@ static int gen_trace(struct bpf_object *obj, const c=
har *obj_name, const char *h
>  	bpf_object__for_each_map(map, obj) {
>  		const char *mmap_flags;
> =20
> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
> +		if (!is_skel_data(map, ident, sizeof(ident)))
> +			continue;
> +
> +		if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
> +			codegen("\
> +		\n\
> +			err =3D skel_protect_map_data(skel->%1$s, &skel->maps.%1$s.initial_va=
lue, %2$zd);\n\
> +			if (err)					    \n\
> +				return err;				    \n\
> +		#ifdef __KERNEL__					    \n\
> +			skel->%1$s =3D NULL;				    \n\
> +		#endif							    \n\
> +			",
> +			ident, bpf_map_mmap_sz(map));
>  			continue;
> +		}
> =20
>  		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
>  			mmap_flags =3D "PROT_READ";
> @@ -955,8 +994,7 @@ codegen_maps_skeleton(struct bpf_object *obj, size_t =
map_cnt, bool mmaped, bool
>  				map->map =3D &obj->maps.%s;	    \n\
>  			",
>  			i, bpf_map__name(map), ident);
> -		/* memory-mapped internal maps */
> -		if (mmaped && is_mmapable_map(map, ident, sizeof(ident))) {
> +		if (mmaped && is_skel_data(map, ident, sizeof(ident))) {
>  			printf("\tmap->mmaped =3D (void **)&obj->%s;\n", ident);
>  		}
> =20
> @@ -1740,7 +1778,9 @@ static int do_subskeleton(int argc, char **argv)
>  		/* Also count all maps that have a name */
>  		map_cnt++;
> =20
> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
> +		if (!is_skel_data(map, ident, sizeof(ident)))
> +			continue;
> +		if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
>  			continue;

Another instance of what I was talking about.

> =20
>  		map_type_id =3D bpf_map__btf_value_type_id(map);
> @@ -1863,7 +1903,9 @@ static int do_subskeleton(int argc, char **argv)
> =20
>  	/* walk through each symbol and emit the runtime representation */
>  	bpf_object__for_each_map(map, obj) {
> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
> +		if (!is_skel_data(map, ident, sizeof(ident)))
> +			continue;
> +		if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
>  			continue;
> =20
>  		map_type_id =3D bpf_map__btf_value_type_id(map);
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.=
h
> index 53fee53d36d5..1f3f332dffbe 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -131,8 +131,10 @@ static inline void skel_free_map_data(void *p, __u64=
 addr, size_t sz)
>  {
>  	if (addr !=3D ~0ULL)
>  		kvfree(p);
> -	/* When addr =3D=3D ~0ULL the 'p' points to
> -	 * ((struct bpf_array *)map)->value. See skel_finalize_map_data.
> +	/*
> +	 * When addr =3D=3D ~0ULL the init buffer has already been released.
> +	 * For skel_finalize_map_data(), 'p' points to
> +	 * ((struct bpf_array *)map)->value.
>  	 */
>  }
> =20
> @@ -170,6 +172,15 @@ static inline void *skel_finalize_map_data(__u64 *in=
it_val, size_t mmap_sz, int
>  	return addr;
>  }
> =20
> +static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t=
 sz)
> +{
> +	(void)sz;
> +
> +	kvfree(p);
> +	*init_val =3D ~0ULL;
> +	return 0;
> +}
> +
>  #else
> =20
>  static inline void *skel_alloc(size_t size)
> @@ -208,6 +219,15 @@ static inline void *skel_finalize_map_data(__u64 *in=
it_val, size_t mmap_sz, int
>  		return NULL;
>  	return addr;
>  }
> +
> +static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t=
 sz)
> +{
> +	(void)init_val;
> +
> +	if (mprotect(p, sz, PROT_READ))
> +		return -errno;
> +	return 0;
> +}
>  #endif
> =20
>  static inline int skel_closenz(int fd)

