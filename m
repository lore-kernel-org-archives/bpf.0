Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14985489880;
	Thu, 13 Aug 2026 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638407; cv=none; b=cKNAAXlKA4Xtyac2jiwnloNYeKcM65A13vsBdt39BGtpAgnYrts3EUZ/4iV/PinzCWEkCDs0iys0tHwBRFAPpIGBokrtuen2XK00Kih2arM9+9fS2uUk5wcagWrUtJgjTQKkrSNXSy5M+qBVeYxT4+OElhM/z6T8EpmU0T6o7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638407; c=relaxed/simple;
	bh=lyk+mSteQ2Peo544/KCaOrvbeGnpf5tyWmVu/wVqE14=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=toPjPQnL2XU9AoQn1oOcylnoA3OfBUny9woS7GQfJe9foY1hmCsRTqUKG1F8aTE5847fSpL4JUlpfQxYhcuAIVszlAhD+XzIK7F27cmEQ4LuByfRSAlU9l9WtxL3fbvxfAUAnrXtURHiM+DrbQv1EhHF8YJ2WF1Gg0Jcc0OiJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWewqiHh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWewqiHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC6C1F000E9;
	Thu, 13 Aug 2026 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638403;
	bh=m7fjvJpEcb3srTJ/wZaexYP/c0fmbNjp1d2uhjOJ3MI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bWewqiHhigasNQBkXxfNc/memKap77w7Dx5PadfPUkJx1b5+1MGM+dhpqhhWcT33t
	 v13Z0bZDCexWlYwlPrfwbEJMIw5thma9CO4ZJMApUIEpbIVRHyVV5RNkRxm+qOHp7J
	 51FIszhkDOBEASox2tCQbSJNuWOCnCPStvgi+5v9yP9pbzBAo0tS+W0M5aIHKEukPI
	 EvHMoslrN4PnkpFzhD0Y/8pt3mxpS68CMKsIwU4rAQsMpkRuCuGWxTqjI5/ZSZUYVX
	 nr/et3aGKl968M7s9mmkyG5iVeVIJWof/BV24WNYpoE+npFWFi56uEEvo854bzdYKB
	 OLHHpdi4reRPA==
Content-Type: multipart/mixed; boundary="===============3357266440292250793=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <501ee3521cfb2843d9dd1b8bc1823c3816f010e08274099664137b5989c3bed2@mail.kernel.org>
In-Reply-To: <20260813152324.97937-6-leon.hwang@linux.dev>
References: <20260813152324.97937-6-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v12 05/10] libbpf: Add support for global percpu data
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 16:26:42 +0000 (UTC)

--===============3357266440292250793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
> index 0425691877521..6c5ad6c55e8a6 100644
> --- a/tools/lib/bpf/bpf_gen_internal.h
> +++ b/tools/lib/bpf/bpf_gen_internal.h

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514e4e9daa825..e574870fb7169 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -1839,6 +1842,8 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
>  	switch (map->def.type) {
>  	case BPF_MAP_TYPE_ARRAY:
>  		return array_map_mmap_sz(map->def.value_size, map->def.max_entries);
> +	case BPF_MAP_TYPE_PERCPU_ARRAY:
> +		return map->def.value_size;
>  	case BPF_MAP_TYPE_ARENA:
>  		return page_sz * map->def.max_entries;

This isn't a bug, but bpf_map_mmap_sz() is documented as returning the
length to pass to mmap()/munmap()/mprotect(), and both other arms return
page-granular lengths (array_map_mmap_sz() rounds up to page_sz, ARENA
multiplies by page_sz).

The new PERCPU_ARRAY arm returns the raw, unrounded value_size. This
creates an asymmetry visible in bpf_map__set_value_size(), which compares
mmap_old_sz = bpf_map_mmap_sz(map) (unrounded for percpu) against
mmap_new_sz = array_map_mmap_sz(size, max_entries) (page-rounded), so even
a no-op resize performs a redundant mmap() + memcpy() + munmap() cycle.

Would using array_map_mmap_sz(map->def.value_size, map->def.max_entries)
for the PERCPU_ARRAY case be more consistent with the ARRAY case?

[ ... ]

> @@ -1866,7 +1871,8 @@ static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, size_t new_sz
>  	return 0;
>  }
>
> -static char *internal_map_name(struct bpf_object *obj, const char *real_name)
> +static char *internal_map_name(struct bpf_object *obj, const char *real_name,
> +			       enum libbpf_map_type type)
>  {
>  	char map_name[BPF_OBJ_NAME_LEN], *p;
>  	int pfx_len, sfx_len = max((size_t)7, strlen(real_name));
> @@ -1907,8 +1913,11 @@ static char *internal_map_name(struct bpf_object *obj, const char *real_name)
>  	if (sfx_len >= BPF_OBJ_NAME_LEN)
>  		sfx_len = BPF_OBJ_NAME_LEN - 1;
>
> -	/* if there are two or more dots in map name, it's a custom dot map */
> -	if (strchr(real_name + 1, '.') != NULL)
> +	/*
> +	 * Don't prefix the bpf_object name if this is a custom dot map
> +	 * (containing two or more dots) or a percpu data map.
> +	 */
> +	if (strchr(real_name + 1, '.') != NULL || type == LIBBPF_MAP_PERCPU)
>  		pfx_len = 0;
>  	else
>  		pfx_len = min((size_t)BPF_OBJ_NAME_LEN - sfx_len - 1, strlen(obj->name));

Emil Tsalapatis raised a design question in v10: Why does .percpu get
special treatment in internal_map_name() instead of following the same
prefixing logic as .data and .rodata?

He noted "it seems like we're singling out the .percpu section for highly
nonbvious reasons" and asked "@Andrii Wdyt?" You responded that you prefer
excluding PERCPU "to avoid the legacy naming convention for new internal
maps" but said "Let us wait for Andrii's comment."

Andrii didn't publicly respond to this design question in the lore threads,
and v11/v12 proceeded with the same special treatment. The related
map_uses_real_name() function also treats PERCPU differently (always
returns true for PERCPU, while DATA/RODATA check against their base section
names).

Should this naming convention uniformity concern be addressed, or is there
a technical reason for .percpu's special handling that could be documented
in the comment?

[ ... ]

> @@ -1941,6 +1950,13 @@ static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
>  	if (!map->btf_value_type_id)
>  		return false;
>
> +	/*
> +	 * The internal PERCPU maps are not mmapble because the underlying
> +	 * percpu_array maps do not have mmap support.
> +	 */
> +	if (map->libbpf_type == LIBBPF_MAP_PERCPU)
> +		return false;
> +

This isn't a bug, but there's a typo: "mmapble" should be "mmappable".

[ ... ]

> @@ -5293,18 +5326,20 @@ static int
>  bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>  {
>  	enum libbpf_map_type map_type = map->libbpf_type;
> +	bool is_percpu = map_type == LIBBPF_MAP_PERCPU;
> +	const __u64 update_flags = is_percpu ? BPF_F_ALL_CPUS : 0;
>  	int err, zero = 0;
>  	size_t mmap_sz;
>
>  	if (obj->gen_loader) {
>  		bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps,
> -					 map->mmaped, map->def.value_size);
> +					 map->mmaped, map->def.value_size, update_flags);
>  		if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG)
>  			bpf_gen__map_freeze(obj->gen_loader, map - obj->maps);
>  		return 0;
>  	}
>
> -	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
> +	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, update_flags);
>  	if (err) {
>  		err = -errno;
>  		pr_warn("map '%s': failed to set initial contents: %s\n",

[ ... ]

> @@ -5349,6 +5384,13 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>  			return err;
>  		}
>  		map->mmaped = mmaped;
> +	} else if (is_percpu) {
> +		if (mprotect(map->mmaped, mmap_sz, PROT_READ)) {
> +			err = -errno;
> +			pr_warn("map '%s': failed to mprotect() contents: %s\n",
> +				bpf_map__name(map), errstr(err));
> +			return err;
> +		}
> +	} else if (map->mmaped) {
>  		munmap(map->mmaped, mmap_sz);
>  		map->mmaped = NULL;

This isn't a bug, but unlike every other internal map, the percpu
initialization image is deliberately kept mapped and turned read-only with
mprotect() instead of being munmap()ed.

The skeleton pointer that bpftool generates for this map is a plain,
non-const 'struct <obj>__percpu *', so a perfectly ordinary post-load
assignment such as 'skel->percpu->var = 1;' now faults with SIGSEGV in the
user process rather than failing in a diagnosable way.

The behaviour is intentional and described in the commit message, but would
a const-qualified generated pointer (as is done for .rodata) express the
restriction at compile time instead of at runtime?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31716447858
--===============3357266440292250793==--
