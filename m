Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793918347;
	b=401Mhd5LaLZHSrTflNNuYwza/LPtF1wm8yIYca84ibzPRoSeSgaL3Wd4XAADckOgbdeh
	 QhcdG2nndAnGASdANfMoKqCVLAUbD8d5U5zQqQrvNQAeEYCe2r5YL6wUGp3NPt2KqlMvn
	 Xbp0upl6pqGVzKNgebjsdoa4h+oGGFC4MBu9EENEP/zSU9PyiHCiOdu99E1bqRQlbho3k
	 rt3uTy2OCC4LI5ZtqcZt+VvpDG/RADBHjDeSSWV/rjt3pO7YW5OCgez1Nt9xLjcpXEoZ/
	 RHW6wt63opvd+9ySCAMd2mC/oYqgr9SswDR9tk5C4f1JuXTiAgfEGGN1+mZXs+Utr/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=oDndNahJ4GPwXzS6mAN/hM4nS6I9Tb8UbRoh7/ik/Wo=;
	b=uBR/RHwaCU8JN7KSG/LbIMf6FKGeEy+XMytDbnwnoqXUIH4aUDuHpuL/QLj2gsd0Aado
	 Jc7GobDl/Mgo82TN1MelVczP92UrvV+Opw/0b+QpnVwvlKAZhYOsaekrOR/8GzVqco9cL
	 N/kAC1eleoiwfxuxX1wCWlWmiFfo60jmgi2kK09E4yoLkDJpZBCWCWWyJt5MECGqDPmNE
	 mBqrFNYqt1cy5e9ecXiNHLCq0lWA+8BFLJUv+cxFWk+o87pwGRThQ8gp9CUpIvuOVhRA/
	 Emq+fZW8Rzsts3ONLoRuud3HobgNWfgM01UPCYiwRXy4uS8LTP+DYxdwUdMxMKCHc0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X8RvCxbb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE7606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 22:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FFE7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X8RvCxbb
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9ae391a05so350605ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 14:39:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793918346; cv=none;
        d=google.com; s=arc-20260327;
        b=PYKKxCMbjAjxRauUmNoonqOMLScLoHVicxegAO1x/YYVxZuPcnmrD4dT9PHh8u2V6N
         5b34/Z4UUX2VJWS329flpJ+Vcc+OUUfyPpJ75tq2jrNaJWLE17lS4GmhXPAR7wmHuV7P
         PQ7Sl4rWWOj8T4VBIY1RuEay4bbnQAeOtJlcYOVP2VmrY5FRkVMRB61FEYstrCQIGKcb
         N/Csb9YZ6mbqRwBJj7pWeu35SaDxLQZeP8NNh5oiFnHuKf49FHtbN2K1YPMB/ZuMimCP
         qrSvL64cihuR4Yw7NujFXnSZio2uAJW38wGCLQ+h1zxwOrTAFxF9E8QhWPmZI7geHC+a
         mSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oDndNahJ4GPwXzS6mAN/hM4nS6I9Tb8UbRoh7/ik/Wo=;
        fh=VsKF6V9Gj651Oiv+/6d16oSRq+IqwJhQpQTeOrDcKEo=;
        b=bJkOXtR3zYnQfX/uFGzFD9VRtG9mP5QXX2ED/aT91zTp0NyW9pIKUX1eKwFMA1S3mi
         FEXzCgHId3GPSKiRSGTIkJnyFYHy66sphaB1laYSblWBK+dCv+KOAMJ+/4ha8lTMcbNb
         vP2f3Dfk2nVQtxGlAImxMdksCeHMPBm/HepTaoBmKFluWW/TVuOmNHD14uwN6pM+JN/c
         kbW5HCTFex/4tx2LrHjhsGpJv1icZtAz2L3pGziSA7O+3gosdkvIOGMVa0XTbubQcXJe
         xuDwiWhIBp/UR/WymjJFqHSGWJpK/0UsGOxd+MQ49S8wSZ+PYPF3+3xYavZsXQl9Xqlf
         yzug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793918346; x=1794523146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oDndNahJ4GPwXzS6mAN/hM4nS6I9Tb8UbRoh7/ik/Wo=;
        b=X8RvCxbb0fgMfiJuxgYkbTlSNenMIX9VMd+8GJHelEbXFhvaMzxE51VJVCsJWUtV+T
         ldwIp2zd5Lceoi/zjn0mXUIPaUOelCvHfgX9wyPzqJyzCYcGETOqnzLi31OoTxI0d94e
         JbyD280QHR72bCCVy+FJyoj9OJF1fiIcqulnXHSH3DI6m7Rl1yUu0xFHrMO0ReyVZVNh
         mwZSr609aAHdDsVyHbFZ+Yv48XXn8JzDkYHMEOs4SWwOx3lkcfNrAvbxCYdnupV5ufgz
         eE//8kktDsYv6kefnVDEmLJIf3SEhOPSpsU45vLkk6ucMoozx2YJnOT2L+FOD4C3Aq8Q
         FOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793918346; x=1794523146;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDndNahJ4GPwXzS6mAN/hM4nS6I9Tb8UbRoh7/ik/Wo=;
        b=UYag/nV7i0uAPZHC/Wbf1hyyHXr1HSz6O/fwSuC/l9imU8X+XZHWRFIpxLkHuchu5C
         eMNa/dsfqlwCZges39UXd8JxWxtNQ1jgQNmuPggq5cYpA/3uIhcolq90SegbeZGTORIE
         yrhkQkEBD/5iKBuCyCgNWHUmvCJpMq998zmDDoB/fqDPnkzpK63Uiol/1O0WIvvgmZFf
         WY6hqYOX5Cir/+RGR3dcRECGtZ4itBpQyNfaeaN8fjINX3S6PLVtz0MPWznCYzd0232z
         C0rLUOanMiFu4lpFcNEO0lNwOZXHCORgBNe8j7CZhsNk9bPDi2N7FiVjDCj+Uk2iLaEv
         AEgw==
X-Gm-Message-State: APuU4Z+Lq0gKjBjq0eWVm3aFXEaliSuSCp4Hc6xZQya26Kbhc9gDFwcn
	xxcQs4bnBCr6phULL3Cj3wMcp9nb+PUmMsvW+vrSgOX2bUjXdjDZFlBOstBbcbl0GJ/TfK88QN3
	aCMWgBCzwQONORXd8PxuCt7CUr+5LzIw=
X-Gm-Gg: AYBFou0dUfCI9/vgPPyEU0vCscF3d3dzML32RC/Z/ewsCN/VpafuD6V3pXFlJFtUa1U
	3N6dHdelIne9LHJA2JZK0+sqT4c3jwxHyZN3AfemG8vP72AuqoYzSjmb4/7MSfYRLflUu7bNG02
	rIRxZ3zZCFcSX7T7nhrYVkAksCAZ3FnFfkR68q9pBUo8hP3MPjgDjrCCsQETlJFDiL6QoVj/ofT
	C64ypY6M6qJYJXZrFq/zPlPkGU6sPK59DR8R+4bdaCmeGI+oKK4p4IEnxjXQ2QEnpKQBMG+5Zr7
	XQLzHk3j3nHYVfNCp5JuxbclAa4D+yDPi7LkmYfve9Dd/39C9lsWq9cRNhHiN41SOaq3gWc0oKj
	oqvuWrtHWiSZ1ftTuslVl4nhT7kus0J+pMH7nZwbIrhQqyJNkNE3UQcp52PFbIyA7sPTZ5irKnn
	JUkfx2roA0l5LdvJEHI+OFo/QUqORNvhsOBw==
X-Received: by 2002:a17:903:32d0:b0:2d8:d4d2:d136 with SMTP id
 d9443c01a7336-2ed240dce1cmr26334985ad.18.1793918345889; Thu, 05 Nov 2026
 14:39:05 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_E59540D7752F97C21F5A0EA91E4C1BD57908@qq.com>
In-Reply-To: <tencent_E59540D7752F97C21F5A0EA91E4C1BD57908@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 14:38:53 -0800
X-Gm-Features: AclHuK_yQ4WGyAXuMBeajlh9Ox4S-3eEjxLFLK4E7_zGR9wTFDeXUDJyaqoclOQ
Message-ID: <CAEf4BzYDmzNoN-5Rnfj4RrAU8wKnZe+tDFApng61L0mubXqung@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: check cpu_possible() in per-cpu helpers
To: bo cao <treebacker@foxmail.com>
Cc: bpf <bpf@vger.kernel.org>, ast <ast@kernel.org>, daniel <daniel@iogearbox.net>, 
	andrii <andrii@kernel.org>, netdev <netdev@vger.kernel.org>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 9:59=E2=80=AFPM bo cao <treebacker@foxmail.com> wro=
te:
>
> Two BPF helpers take a target CPU id as a raw u32 (arg_type
> ARG_ANYTHING, so the verifier does not constrain it) and only reject
> cpu >=3D nr_cpu_ids before the value is used as a per_cpu_ptr() index.
>
> bpf_map_lookup_percpu_elem() dispatches to the per-cpu map
> implementations, and all three of them (percpu array, percpu hash,
> percpu LRU hash) check nothing beyond that upper bound:
>
>         if (cpu >=3D nr_cpu_ids)
>                 return NULL;
>         ...
>         return per_cpu_ptr(..., cpu);
>
> bpf_per_cpu_ptr() has the same weak check before returning
> per_cpu_ptr(ptr, cpu).
>
> Note that the verifier rewrites calls to bpf_map_lookup_percpu_elem()
> with a known map into direct calls to the map callback
> (kernel/bpf/fixups.c, BPF_FUNC_map_lookup_percpu_elem case), so a
> check in the helpers.c wrapper alone does not cover JITed programs;
> the callbacks themselves must reject the hole CPU id.
>
> Per-cpu memory is only allocated for possible CPUs, and
> __per_cpu_offset[] is only initialized for them (on arm64,
> setup_per_cpu_areas() walks for_each_possible_cpu).  On a system
> with a sparse possible mask - e.g. an arm64 guest with a device-tree
> CPU hole, possible mask 0,2-3 with nr_cpu_ids =3D 4 - a call with the
> hole CPU id passes the weak checks, and per_cpu_ptr() computes the
> returned pointer from the uninitialized __per_cpu_offset[hole].
>
> For bpf_map_lookup_percpu_elem() the returned pointer lies outside
> any valid per-cpu chunk of the map: reads leak the stale bytes
> through the map value, and writes corrupt whatever the offset
> happens to land on.  For bpf_per_cpu_ptr() on a ksym the result is
> read-only (the proto marks it MEM_RDONLY), but on a percpu kptr
> allocated with bpf_percpu_obj_new() the result is writable, so a
> hole CPU id let a program write through a bogus address as well.
>
> Reproduced on an arm64 guest with possible mask 0,2-3 (Ubuntu
> 7.3.0-9-generic): a socket filter program passes the pointer
> returned by bpf_map_lookup_percpu_elem(map, key, 1) on as the value
> argument of bpf_map_update_elem(), and the copy inside
> array_map_update_elem() faults on it:
>
>   pc : __pi_memcpy_generic+0x3c/0x230
>   lr : array_map_update_elem+0x148/0x2a8
>   Call trace:
>    __pi_memcpy_generic+0x3c/0x230 (P)
>    bpf_prog_835a4ba2ea6755f0_poc+0x90/0xc0
>    bpf_test_run+0x2d0/0x460
>    bpf_prog_test_run_skb+0x4ac/0x920
>    __sys_bpf+0x614/0xbe8
>    __arm64_sys_bpf+0x38/0x78
>
> the memcpy source (x1 =3D 0000b7737ec7dc88) being the out-of-bounds
> pointer the lookup returned for the hole CPU.
>
> The syscall side of the same problem (BPF_F_CPU map operation flags)
> was fixed by ed54bf564ac5 ("bpf: Fix BPF_F_CPU validation for sparse
> CPU IDs"), which added cpu_possible() validation to
> bpf_map_check_op_flags().  These paths do not go through that
> function, so the same class of hole CPU id needs to be rejected here
> as well.
>
> bpf_per_cpu_ptr() has returned NULL for cpu >=3D nr_cpu_ids since its
> introduction, but for a percpu obj the verifier drops PTR_MAYBE_NULL
> from R0 (check_helper_call(), returns_cpu_specific_alloc_ptr path),
> so a program that skips the NULL test and writes through the result
> passes verification and oopses on NULL + offset at run time - a
> problem on its own since 01cc55af9388, no sparse CPU mask required.
> Keep PTR_MAYBE_NULL on R0 in that path so the verifier requires the
> NULL test; the existing selftests already check, so they keep
> passing.  This also makes the new NULL return for a hole CPU safe.
>
> Add the check to the three map callbacks (so the verifier's direct
> call path is covered), keep it in the helper dispatch as a central
> fallback, fix bpf_per_cpu_ptr() in place, and keep PTR_MAYBE_NULL
> on R0 for percpu obj results.

please trim the commit message down, it's way too verbose

>
> Fixes: 07343110b293 ("bpf: add bpf_map_lookup_percpu_elem for percpu map"=
)
> Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
> Fixes: 01cc55af9388 ("bpf: Add bpf_this_cpu_ptr/bpf_per_cpu_ptr support f=
or allocated percpu obj")
> Cc: stable@vger.kernel.org
> Signed-off-by: bo cao <treebacker@foxmail.com>
> ---
> Changes in v3:
> - rename author and Signed-off-by to match the sender (bo cao).
> - drop the incorrect "MEM_RDONLY, so reads only" claim for
>   bpf_per_cpu_ptr(): it only holds for ksym arguments; percpu kptr
>   results are writable.
> - keep PTR_MAYBE_NULL on R0 for bpf_per_cpu_ptr() on percpu obj:
>   check_helper_call() drops the flag on the
>   returns_cpu_specific_alloc_ptr path, so the NULL return (for
>   cpu >=3D nr_cpu_ids since 01cc55af9388, and now also for a hole
>   CPU) let a non-checking program oops on NULL + offset.  With the
>   flag kept, the verifier requires the NULL test; existing selftests
>   already check.
>
> Changes in v2: add the cpu_possible() check to the three per-cpu map
> callbacks as well, because the verifier rewrites helper calls with a
> known map into direct calls to the callbacks (kernel/bpf/fixups.c)
> and thus bypasses the helpers.c wrapper.
>
> Link: https://lore.kernel.org/bpf/b3ddc3a43512b33fb503585d34dd75ef62420ea=
0e0d9f0ceecd6262f79fcb9d0@mail.kernel.org/
> ---
>  kernel/bpf/arraymap.c | 2 +-
>  kernel/bpf/hashtab.c  | 4 ++--
>  kernel/bpf/helpers.c  | 6 +++++-
>  kernel/bpf/verifier.c | 3 ++-
>  4 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 133f189bf6d2..eab03f985280 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -327,7 +327,7 @@ static void *percpu_array_map_lookup_percpu_elem(stru=
ct bpf_map *map, void *key,
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         u32 index =3D *(u32 *)key;
>
> -       if (cpu >=3D nr_cpu_ids)
> +       if (cpu >=3D nr_cpu_ids || !cpu_possible(cpu))
>                 return NULL;
>
>         if (unlikely(index >=3D array->map.max_entries))
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index bf78e09f4d51..007279c16b77 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2670,7 +2670,7 @@ static void *htab_percpu_map_lookup_percpu_elem(str=
uct bpf_map *map, void *key,
>  {
>         struct htab_elem *l;
>
> -       if (cpu >=3D nr_cpu_ids)
> +       if (cpu >=3D nr_cpu_ids || !cpu_possible(cpu))
>                 return NULL;
>
>         l =3D __htab_map_lookup_elem(map, key);
> @@ -2696,7 +2696,7 @@ static void *htab_lru_percpu_map_lookup_percpu_elem=
(struct bpf_map *map, void *k
>  {
>         struct htab_elem *l;
>
> -       if (cpu >=3D nr_cpu_ids)
> +       if (cpu >=3D nr_cpu_ids || !cpu_possible(cpu))
>                 return NULL;
>
>         l =3D __htab_map_lookup_elem(map, key);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 648abe1ba63a..f9f2bd665038 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -133,6 +133,10 @@ const struct bpf_func_proto bpf_map_peek_elem_proto =
=3D {
>  BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, ke=
y, u32, cpu)
>  {
>         WARN_ON_ONCE(!bpf_rcu_lock_held());
> +
> +       if (cpu >=3D nr_cpu_ids || !cpu_possible(cpu))
> +               return 0;
> +
>         return (unsigned long) map->ops->map_lookup_percpu_elem(map, key,=
 cpu);
>  }
>
> @@ -753,7 +757,7 @@ const struct bpf_func_proto bpf_copy_from_user_task_p=
roto =3D {
>
>  BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
>  {
> -       if (cpu >=3D nr_cpu_ids)
> +       if (cpu >=3D nr_cpu_ids || !cpu_possible(cpu))
>                 return (unsigned long)NULL;
>
>         return (unsigned long)per_cpu_ptr((const void __percpu *)(const u=
intptr_t)ptr, cpu);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5601d2056218..0cedf39ee226 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12957,7 +12957,8 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>                         regs[BPF_REG_0].mem_size =3D tsize;
>                 } else {
>                         if (returns_cpu_specific_alloc_ptr) {
> -                               regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | =
MEM_ALLOC | MEM_RCU;
> +                               regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | =
MEM_ALLOC | MEM_RCU |
> +                                                      (ret_flag & PTR_MA=
YBE_NULL);

not sure this is right, bpf_per_cpu_ptr_proto specifies

 .ret_type      =3D RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,

it already is marked as maybe_null

pw-bot: cr


>                         } else {
>                                 /* MEM_RDONLY may be carried from ret_fla=
g, but it
>                                  * doesn't apply on PTR_TO_BTF_ID. Fold i=
t, otherwise
> --
> 2.39.5 (Apple Git-154)
>
