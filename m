Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58533501F28
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799741; cv=none; b=kQCZPwMOKwHz+LVbDiQkCeyZIWgFYoMeTR3f+aaNcwisFr/NOfr9qCR1cqJxo6CCdQIn97VbJQWqurReulYGhukJ9v2mPAtGfd0dhG2r5p8dYweJgtyfUV/HdQuFgsKNftbm9Kr6bq27snQLrcYh0NNSwW5orHo5LJE1VgfDq9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799741; c=relaxed/simple;
	bh=KinLE9TpzG+4lHiHCuEp7MHNN2XPzHeP0+fIicsEMvk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E8ZBHO+l7emvkBOBrcEIQQuaA914zbNqC87u5QCITWBKcw57Vyz1b6sh2rPA/GQ8MfNg7DqgK5cD1HxlU1q0MtwLCtSNelg3wEr/UZY4dhkW438/cfMOdPVcipzdDUQa7H9j73If+XqT+fBE8xt7MyfSz55HYrCSyK0/kLxKFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnPKpSMK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnPKpSMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775831F0089A;
	Wed, 30 Sep 2026 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790799740;
	bh=km8jmhjzJPy/NTq804iWYP+qjvbC1DyRRsV9uI/KqDY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fnPKpSMKkEq4quv55iQePFKdiEPUBvl+nn6DmtAgvyBO9yecrGDuR0UDVQaP9D9E9
	 kYM5FyD6pF1zWOCZPPWK7c/c5tMGx+7vhMUFri5Hh+I003sKpr92LSHCOb1mTEEKp4
	 wpn8kxaV9dx1G9df6faOCPTyCw1UuVQk9SnzhsukEALHErLYJhEUuzQsYNb1ImdC5h
	 cmQzlmbJaHrvgHT46dilxwYjLqedNfY76kI6Zbur6eO2zDpKCx++YMYhwo0m06Fs0L
	 6+AxyU0CfV8s/Wx0CNoBczVHmlQ85Xl0sOQwYTBiJXV6BH6dwoQlWIHyjZhOaM7Bhp
	 Q7idG+/YQkCSA==
Content-Type: multipart/mixed; boundary="===============8887992651756693883=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e4bf816930960c25ce7449ed3bcf558f579aec2c93ab912bffc3a39a132e25c9@mail.kernel.org>
In-Reply-To: <20260930193127.2181684-12-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-12-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 11/14] libbpf: Keep global data in arena when the object has .arena.data
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 30 Sep 2026 20:22:19 +0000 (UTC)

--===============8887992651756693883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Keep global data in arena when the object has .arena.data

TL;DR: In libbpf, an object with __arena variables and .arena.data but no
.maps section may get its .data/.bss/.rodata copies placed over the __arena
variables at arena offset 0, silently aliasing them instead of failing to
load.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fdd69aac39bd..335cdafeb06c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -3081,6 +3119,129 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,

[ ... ]

> +static int bpf_object__init_arena_data(struct bpf_object *obj)
> +{
> +	const size_t page_sz = sysconf(_SC_PAGE_SIZE);
> +	size_t sz = obj->arena_data_sz;
> +	struct bpf_map *map;
> +	void *data;
> +	int i;
> +
> +	if (!obj->data_in_arena)
> +		return 0;
> +
> +	for (i = 0; i < obj->nr_maps; i++) {
> +		map = &obj->maps[i];
> +		if (map_data_goes_to_arena(obj, map))
> +			sz = map_arena_off(obj, map, sz) + map->def.value_size;
> +	}
> +	if (sz == obj->arena_data_sz)
> +		return 0;
> +
> +	if (obj->arena_map_idx < 0) {
> +		map = bpf_object__add_map(obj);
> +		if (IS_ERR(map))
> +			return PTR_ERR(map);
> +
> +		map->real_name = strdup("arena");
> +		map->name = strdup("arena");
> +		if (!map->real_name || !map->name) {
> +			zfree(&map->real_name);
> +			zfree(&map->name);
> +			return -ENOMEM;
> +		}
> +		map->sec_idx = -1;
> +		map->def.type = BPF_MAP_TYPE_ARENA;
> +		map->def.max_entries = roundup(sz, page_sz) / page_sz;
> +		map->def.map_flags = BPF_F_MMAPABLE;
> +		obj->arena_map_idx = map - obj->maps;
> +	}

When the object has __arena variables (.addr_space.1) and .arena.data, but
no SEC(".maps") section, doesn't this place the .data/.bss/.rodata copies
at arena offset 0, on top of the __arena variables?

The __arena bookkeeping only happens in bpf_object__init_user_btf_maps(),
and that function returns early when there is no .maps section:

bpf_object__init_user_btf_maps() {
    ...
	if (obj->efile.btf_maps_shndx < 0)
		return 0;
    ...
	if (obj->efile.arena_data && obj->arena_map_idx < 0) {
		pr_warn("elf: sec '%s': to use global __arena variables the ARENA map should be explicitly declared in SEC(\".maps\")\n",
			ARENA_SEC);
		return -ENOENT;
	}
    ...
}

So in that case neither init_arena_map_data() runs, which is what copies
.addr_space.1 into obj->arena_data and sets obj->arena_data_sz, nor does
the -ENOENT check above fire.

bpf_object__init_arena_data() then starts with sz = obj->arena_data_sz = 0,
creates the "arena" map, and gives the first data map arena_off 0.

Before this patch, bpf_program__record_reloc() failed such an object with
"no arena maps defined", because arena_map_idx was still -1:

bpf_program__record_reloc() {
    ...
	if (shdr_idx == obj->efile.arena_data_shndx) {
		if (obj->arena_map_idx < 0) {
			...
			return -LIBBPF_ERRNO__RELOC;
		}
		...
		reloc_desc->sym_off = sym->st_value;
    ...
}

Now arena_map_idx points at the auto-created map, so that relocation
succeeds and resolves to arena_data_off + st_value, which is the same
address range the .data/.bss/.rodata copies now occupy.  Data pointers to
__arena variables (targ_sec_idx == -1 in bpf_object__relocate_data_ptrs())
resolve the same way.

For example, an object with:

  char d SEC(".arena.data");
  int counter = 5;
  int __arena avar = 11;

and no maps: the program sees avar and counter at the same arena address.
avar starts out as 5 rather than 11, and a write to one variable changes
the other.  Previously this object was rejected at load.

Should bpf_object__init_arena_data() (or bpf_object__init_user_btf_maps()
without the early return) handle obj->efile.arena_data when there is no
.maps section?  It could either reserve the __arena variables first or keep
returning the -ENOENT error.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36768148430
--===============8887992651756693883==--
