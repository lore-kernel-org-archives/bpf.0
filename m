Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98DA3803F1;
	Thu, 13 Aug 2026 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638387; cv=none; b=A1fvGqvEYeiESgWBBcKECHXILdmbxtK9ezikNUT82LPJoOcWTBaYqWdefo8uROP7u01GEj7KeAtwUgqM7oiTzhwkzydpt47k9Y455z3367QWc3z7tCMn/W//OLrd+dl9eAjP/EIoQPTNv1QT2HSGVPl5LuCQjpTfsHFGX3N6tcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638387; c=relaxed/simple;
	bh=0zNs6VxyHoPCC04WihUe79Rh0i5CPI6/8FfLTOd3x2s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WyWNlkHPDL38iDWZbYgwo0aj7voNU0HexFzW0jlzWTDs2LcP2wWxDck+jWcnHCxpsP8l4ke7FgMt2LUmqE+wgylxDkmXfy+dYcetxGFrbdMBdXREAPFEh23ZTgpvluMLBdsFrk/uvaZn8UYysthtREG1r4tsjgU59nkiQc71kiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md0EOscu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md0EOscu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210D61F000E9;
	Thu, 13 Aug 2026 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638383;
	bh=U7dYvMVT+92Gq4e+NEjD9WL0ngCQ7boRgOo6E4+Oyb4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=md0EOscuHH9+cC8SuF7tVcuHQU6Iw6VZ4s18vENVf362Hc5NpBnHb82++UcOnidln
	 wU/LKctU0Pz7WaQhA2ZuFLk+8/0kvHE2sPrVYZQT63MlQPeiYSZLd1Kvz7hPP0MwoW
	 xbQ0Sb9yEXJuL9TCGX+sp8bpMUf6ZBQD2H7tuU+eeQDAJ/kIgYchJHqGEt5r0Ghjpf
	 vqutyWgSFvRlS9VSwadEFCB7JOgAgBzOje29Mt1aGlw+G6OASQQPlX7v72jT2G1WYY
	 liv/Tg35MP62z3fVpCJxMCgZ/ApfkuHX6ndJ4N09Bffzl8nZ7OOt7GtgBEH5aOsOO/
	 MZigyrQoeMewA==
Content-Type: multipart/mixed; boundary="===============3439356630173476319=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5e196fcd4e2ac190d9232398274607860c07747f6d5adf39fb41db4f0a8d0167@mail.kernel.org>
In-Reply-To: <20260813152324.97937-7-leon.hwang@linux.dev>
References: <20260813152324.97937-7-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v12 06/10] bpftool: Generate skeleton for global percpu data
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 16:26:22 +0000 (UTC)

--===============3439356630173476319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a01d06d22d1a3..a50540ef6521c 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[ ... ]

> @@ -254,7 +260,7 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
>  	return NULL;
>  }
>
> -static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
> +static bool is_skel_data(const struct bpf_map *map, char *buf, size_t sz)
>  {
>  	size_t tmp_sz;
>
> @@ -263,13 +269,24 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>  		return true;
>  	}
>
> -	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> +	if (!bpf_map__is_internal(map))
>  		return false;
>
>  	if (!get_map_ident(map, buf, sz))
>  		return false;
>
> -	return true;
> +	if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
> +		return true;
> +
> +	if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
> +		return bpf_map__btf_value_type_id(map) != 0;
> +
> +	return false;
> +}
> +
> +static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
> +{
> +	return is_skel_data(map, buf, sz) && bpf_map__type(map) != BPF_MAP_TYPE_PERCPU_ARRAY;
>  }
>
>  static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
> @@ -287,7 +304,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>
>  	bpf_object__for_each_map(map, obj) {
>  		/* only generate definitions for memory-mapped internal maps */
> -		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
> +		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
>  			continue;

The comment here says "only generate definitions for memory-mapped
internal maps," but is_skel_data() now also returns true for
BPF_MAP_TYPE_PERCPU_ARRAY maps. Those percpu maps are never
memory-mapped: map_is_mmapable() in tools/lib/bpf/libbpf.c returns false
for LIBBPF_MAP_PERCPU, which is why this patch had to add mprotect() for
the init buffer rather than relying on shared mmap.

When you removed the identical comment from codegen_maps_skeleton()
(line 988), should this one have been updated to say "skeleton data maps"
or "internal maps exposed as skeleton data" to match what is_skel_data()
actually checks?

The same wording also appears at line 534 in codegen_asserts():

>  	bpf_object__for_each_map(map, obj) {
> -		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
> +		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
>  			continue;

where the comment above (line 513) says "Emit type size asserts for all
top-level fields in memory-mapped internal maps." That comment now covers
percpu maps too.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31716447858
--===============3439356630173476319==--
