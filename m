Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393D4BE45D
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064796; cv=none; b=pGN28W+UDPYs9LRZSML3/RiZh2vVvt++LZGwajjcW/5WeASpClhq3Oq5ADoywPT36i5LofAbDRp36sUaaozW3Sljq+E9rAAzPROwp8v+gE/0+rjb/uOdSC9MhN4pYGtyvJ0EufBSkpNzXoW0LjOEqaGk0/oBDsWm/IsYei5X0wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064796; c=relaxed/simple;
	bh=L9ZVnYLx+80JTL3HFIUZDQiDPjW/WKyUtP4c72jx4a4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=H7vu0UHxm6TJwyzHdnS9F3W4HQ3RPuHPiDdYDr8D+5v5ZC+a9AfRP28Ev2AQ5+MEWRwujx0L0W/HJcOhg0VboA27QPz12LAbiHX/vUjXEggEqAVjwCIBB7O+2QkJV/vsrOfIgF5FGDOQdqHvWEVUCNjdvKfKsFGYi1n0pkBL37E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BudIREQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BudIREQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA55F1F00893;
	Thu, 10 Sep 2026 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789064793;
	bh=BTvvgTPGK4FSSVRtlSiCteaK4HpCsS5LZXlM9kgE/tA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BudIREQmNP7V1uWPrtXvdT1JQJABDiuwGoFdQkC2wbG1bDSmB5YpalV6jIpZSTkQq
	 ZBe46wjJxxJ9n9S9/+9Jtg4WzyLz+2bHnLPFMh124Kvm9w/nuj9YmFyu2ZBpiGE6tn
	 UpA/OrUuhtJwT6OFrhXOgTjL//yopAKHP71tmeO6BjoyHGd82Xqt01yQGnlxazSRkh
	 yZz5BQH9j1DYh1ekhW36f5PF2/lPlZ/KtdQ9R+ckI7Qt6nqGfocHhGeRVX1bWkLjoL
	 hXC/KCxj+KhjyTOvZJ+B6EYglLjpPu6p80Hmo+DexUrfpJYUBYq6m8BFLOfa2j6WN5
	 /5nBsBqcR6NFg==
Content-Type: multipart/mixed; boundary="===============5039265452617411727=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f7de19edd155dc147030e6d648e75c2a239e3970772c83e2b6d2679ebba25bb3@mail.kernel.org>
In-Reply-To: <20260910172340.1467764-2-caomingpei@gmail.com>
References: <20260910172340.1467764-2-caomingpei@gmail.com>
Subject: Re: [PATCH bpf 1/2] libbpf: Reject struct_ops bitfields before accessing data
From: bot+bpf-ci@kernel.org
To: caomingpei@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,caomingpei@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 18:26:32 +0000 (UTC)

--===============5039265452617411727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Reject struct_ops bitfields before accessing data
>
> A Clang-generated struct_ops mirror with an all-zero private bitfield can
> crash libbpf. With kind_flag set, the BTF member offset also encodes the
> bitfield width.
>
> bpf_map__init_kern_struct_ops() divided this encoded value by eight
> before rejecting bitfields. A 31-bit field therefore selects
> data + 0x3e00000, where libbpf_is_mem_zeroed() triggers an ASan SEGV.
>
> The issue was found by comparing the same ELF in JIT and interpreter
> configurations. JIT+BTF reached the faulty struct_ops path, while the
> interpreter configuration rejected the object before this code.

This isn't a bug, but is the JIT/interpreter distinction load-bearing
here, or was the real difference kernel BTF availability?
find_struct_ops_kern_types() bails out with "struct %s is not found
in kernel BTF" when vmlinux BTF is unavailable, which matches the
"+BTF" half rather than the JIT half.

> Reject local bitfields before calculating the data pointer. Preserve the
> existing all-zero compatibility path for ordinary private fields.
>
> Fixes: c911fc61a7ce ("libbpf: Skip zeroed or null fields if not found in the kernel type.")
> Assisted-by: LLM
> Signed-off-by: Mingpei CAO <caomingpei@gmail.com>

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee..1738a42220f0 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1223,6 +1223,12 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
>  		const char *mname;
>
>  		mname = btf__name_by_offset(btf, member->name_off);
> +		if (btf_member_bitfield_size(type, i)) {
> +			pr_warn("struct_ops init_kern %s: bitfield %s is not supported\n",
> +				map->name, mname);
> +			return -ENOTSUP;
> +		}
> +
>  		moff = member->offset / 8;
>  		mdata = data + moff;
>  		msize = btf__resolve_size(btf, member->type);

A subsystem pattern flags this as potentially concerning: the fix
guards only the bitfield-width half of the kind_flag member offset
encoding; the bit-offset half is still used unvalidated to form the
pointer that libbpf_is_mem_zeroed()/memcpy() read from.

st_ops->data is sized to the local struct in init_struct_ops_maps():

  st_ops->data = malloc(type->size)

But moff comes straight from BTF:

  moff = member->offset / 8

BTF_MEMBER_BIT_OFFSET is the low 24 bits, so moff can be up to
0x1FFFFF (~2 MiB) even with bitfield_size == 0 (or with kflag clear,
where btf_member_bitfield_size() returns 0 by construction).

libbpf does not bound-check member offsets against the struct size.
btf_sanity_check() in btf.c calls btf_validate_type(), whose
BTF_KIND_STRUCT/UNION case validates only m->name_off and m->type:

  for (i = 0; i < n; i++, m++) {
          err = btf_validate_str(btf, m->name_off, "field name", id);
          err = err ?: btf_validate_id(btf, m->type, id);

m->offset is never checked. So the same ASan SEGV the changelog
describes is still reachable from bpf_object__open_file() with a
crafted .BTF that gives a struct_ops member a large bits_offset and
bitfield_size == 0: mdata lands up to ~2 MiB past a small malloc()
and libbpf_is_mem_zeroed(mdata, msize) walks it.

This is pre-existing and was introduced by the same commit named in
the Fixes: tag. The diff does not make it worse. It is noted here
because the patch's stated purpose is to stop this expression from
producing a wild pointer, so a reviewer will reasonably ask whether
a single bound such as:

  if (moff >= type->size || msize > type->size - moff)
          return -EINVAL;

would cover the whole class rather than just the bitfield encoding?

> @@ -1259,8 +1265,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
>  		}
>
>  		kern_member_idx = kern_member - btf_members(kern_type);
> -		if (btf_member_bitfield_size(type, i) ||
> -		    btf_member_bitfield_size(kern_type, kern_member_idx)) {
> +		if (btf_member_bitfield_size(kern_type, kern_member_idx)) {
>  			pr_warn("struct_ops init_kern %s: bitfield %s is not supported\n",
>  				map->name, mname);
>  			return -ENOTSUP;

This isn't a bug, but now that this check is split in two, would it
help to distinguish the two warnings so the log says which side of
the comparison has the bitfield? Everywhere else in this function the
warnings are distinct enough to identify which side failed ("Cannot
find member %s in kernel BTF", "kernel member %s is not a func ptr",
"%zd != %zd(kernel)").


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34510539779
--===============5039265452617411727==--
