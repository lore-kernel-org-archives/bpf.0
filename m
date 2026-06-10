Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D112D299A82
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781133690; cv=none; b=RGkNbJUgkpmPJ270xkMRJrQo5YLT97P4it4NcwOJyr0Mge1x/X6s+hmeHyktb0XlDeL76XTsnwZ9MfIlThfQO2z3LVvj6+/7F5H8DPjwK+B2OZ0c50GcPb22V6uwv5QhCVBen/ik3AiX7R7DV/uXLK1yfg5zD2hzkl4vcOaECXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781133690; c=relaxed/simple;
	bh=B1N2Nl/0qYFDO2Urlt3dfeloGRN/8PyJTghbGR3FGAQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jL1Og6zDYkoMPouSiSunoC6gdEmomCvki31IMzNj4x6CkdOr7NqpEeqoCJRAYBFHzAPvqO8+qGs2L0+iTZBt+GRsVA1U8cYyy8EC6G/50ppB7HvDr6I0Zt51FPxkWkk5L7oZa6CUTb1GiUy16riuEEy8E2WXZd5vJt6s4mFu/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEMOdsNw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEMOdsNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E29C1F00893;
	Wed, 10 Jun 2026 23:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781133689;
	bh=B2G6iXrbrxyGTGotD6RpRuIaEkgk4qtzyUnMVNyE+J8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PEMOdsNwPQRYhKP0gAtifGZqFM5gBdHfJXJXl6ZuMZ48B5cwbyQvESM/abCTQvdaq
	 LhuD9QjjgqrZOPgX7hXV4keiWGqP5nOin5AzkCoyvgsfezoNOO/IGhZKZ124Cai0ke
	 bQIIqSS0yd9h8hIDj0szzE0xv6vkBOXpzM+CmZsrPzxHAq6RTpils8mMNZ4tpXT7kU
	 u9Ge9n9OVEiLTMs1UtZtU6CNMxHNjrJ1htiqKtRCo0bTEwz+VaiHuK6C233LYMXtct
	 Uxq0mH28Fat/2wHwKfMHPZ8VG7XcKJAFd4pNocv4MTOek86sVpiwgs5JHyNVNA3U0V
	 QQHbNIMwoTDcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/5] bpf: Verify signed loader metadata at load
 time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610230329.727075-2-daniel@iogearbox.net>
References: <20260610230329.727075-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 23:21:28 +0000
Message-Id: <20260610232129.5E29C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] A Time-Of-Check to Time-Of-Use vulnerability in fd_array proce=
ssing allows an attacker to bypass BPF signature verification by substituti=
ng an exclusive map with a non-exclusive map.
- [High] bpf_prog_verify_signature() improperly uses map_direct_value_addr(=
) to fetch map contents, leading to kernel panics or out-of-bounds reads wh=
en BPF_MAP_TYPE_ARENA or BPF_MAP_TYPE_INSN_ARRAY maps are used.
--

commit 53c54a272b54e4ba83fb4ba3b249a8d1b18a6abd
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Verify signed loader metadata at load time

This commit modifies the BPF loader to verify the contents of metadata maps
at program load time. It collects exclusive maps from the fd_array and appe=
nds
their contents to the instruction data before PKCS#7 signature verification.

Link: https://lore.kernel.org/bpf/CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuu=
LT_i--GskQ@mail.gmail.com [0]
Link: https://lore.kernel.org/bpf/2f71d6c03698eb17d51f7247efde777627ee578a.=
camel@HansenPartnership.com [1]
Link: https://lore.kernel.org/lkml/ecf0521ed302db672672ebfbc670ecfba36a6e00=
.camel@HansenPartnership.com [2]
Link: https://lore.kernel.org/bpf/88703f00d5b7a779728451008626efa45e42db3d.=
camel@HansenPartnership.com [3]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7ed949f70f82c..1afe2c48130ef 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -2900,13 +2900,81 @@ static enum bpf_sig_keyring bpf_classify_keyring(=
s32 keyring_id)
> +static int bpf_prog_collect_excl_maps(union bpf_attr *attr, bool is_kern=
el,
> +				      struct bpf_map ***mapsp, u32 *cntp)
> +{

[ ... ]

> +	for (i =3D 0; i < attr->fd_array_cnt; i++) {
> +		struct bpf_map *map;
> +
> +		if (copy_from_bpfptr_offset(&fd, fds, i * sizeof(int),
> +					    sizeof(int))) {

[Severity: Critical]
Is there a time-of-check to time-of-use (TOCTOU) race condition here?

The fd_array is read from user space via copy_from_bpfptr_offset() to
collect the exclusive maps for signature verification. However, later in the
load process, bpf_check() calls process_fd_array(), which reads the exact
same attr->fd_array from user space a second time:

kernel/bpf/verifier.c:process_fd_array() {
    ...
    if (copy_from_bpfptr_offset(&fd, env->fd_array, i * size, size))
    ...
}

A malicious user space thread could overwrite an entry in fd_array with a
file descriptor pointing to an attacker-controlled, non-exclusive map
between these two reads.

Because the subsequent check in bpf_prog_check_excl_used_maps() explicitly
ignores non-exclusive maps:

kernel/bpf/syscall.c:bpf_prog_check_excl_used_maps() {
    ...
    if (!map->excl_prog_sha)
        continue;
    ...
}

Could this allow the attacker's non-exclusive map to be silently accepted,
bypassing the signature's integrity protection?

> +			err =3D -EFAULT;
> +			goto err_put;
> +		}

[ ... ]

> +static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_at=
tr *attr,
> -				     bool is_kernel, s32 *keyring_serial)
> +				     bool is_kernel, s32 *keyring_serial,
> +				     struct bpf_map **excl_maps, u32 excl_cnt)
>  {

[ ... ]

> +	for (i =3D 0; i < excl_cnt; i++) {
> +		struct bpf_map *map =3D excl_maps[i];
> +		u64 addr;
> +
> +		err =3D map->ops->map_direct_value_addr(map, &addr, 0);
> +		if (err)
> +			goto out;
> +		memcpy(data + off, (void *)(unsigned long)addr, map->value_size);

[Severity: High]
Does this safely handle all map types that support map_direct_value_addr()?

For BPF_MAP_TYPE_ARENA maps, arena_map_direct_value_addr() returns a user
space virtual address (arena->user_vm_start). Executing a direct memcpy()
from this user space address could trigger an unhandled page fault or an
SMAP violation.

Additionally, for BPF_MAP_TYPE_INSN_ARRAY maps, the allocated size can be
smaller than map->value_size. If max_entries is 1, the allocation is 8
bytes, but map->value_size is fixed at 12 bytes. Could the memcpy() read
past the end of the allocation and cause an out-of-bounds read?

> +		off +=3D map->value_size;
> +	}
> +
> +	bpf_dynptr_init(&data_ptr, data, BPF_DYNPTR_TYPE_LOCAL, 0, data_sz);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610230329.7270=
75-1-daniel@iogearbox.net?part=3D1
