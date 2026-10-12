Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C262F531B
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815231; cv=none; b=eyzF2nYbIuoZl0mTatpZ7qNF4tXYFwklU/7tLVbepopKR/MdeUOzz6uVvtvNl0OGsljymbQsfoKnN+iB5WUYrlYsRjOHrQOWlvZBoXH0AJVXtBptnpamHmlSwmh3C4/7wrSYLtCg9DqQ4BpnQvN3b1CLBCrCkaZUMtuytxhaxUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815231; c=relaxed/simple;
	bh=996t+/Ln205gw08IkUU/gmdMw+CwdCDntWJfCKSZjBk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PV/pQuceFbFiMBH/SyRmP7D2DmkPPLzX7vWbjx11BBfUbQD6iK9qVGXX8DzJ6QygNjVyRTmWO5Rt9/YdgqmnQcIkjk9LHJvi2FwaGmqtrjkLiVNA+k2mZflTb+Ak7hnZRCMVKiRA0p2FlkjffBDn3w0mddLBmHBA9S2Q9w/pV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYwdvov5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYwdvov5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F69E1F0089B;
	Mon, 12 Oct 2026 14:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815230;
	bh=ldLPZZ+c1+9meuxGd9Ft1SCl1/KrtyypCs3MZ9MpTC8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CYwdvov5jL7b/pxgDmfijqVftXlL7FpCQUYzXzXE/YvNGsa34yZ6i4CuVB0Q11UJ2
	 vLdE8jjUoB5LR8oFFkkA07u0F3qlTFEHYJQQeiGYpmFvMLlo+MZxYx7NSnWRoKKC2+
	 ZmeMbopTpS66zmiEAbkePkZO1ljzYMEISOs5dZL5ZOfHN0FU6tE1LuNxNYDaQiqFJe
	 LDs0NgnkKIOlxbqwsdaHuBY1Av/rLIyWyyVeTEXr8iYsABIrL1+9n2H4q3iLYg9RSD
	 wMOxVrPEzS+CTkvxKugsczM4SvJ3K9IxNolG9qSXN14jkWiD2q3Xq3O2yLWgQJym3q
	 Qn9niS7FkXfTA==
Content-Type: multipart/mixed; boundary="===============5004165538961855072=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <786e5b36ab677253e457a1f8040080ac8f708ccf44fe7935c7df4bfdd5cf1359@mail.kernel.org>
In-Reply-To: <20261012133711.4030594-7-memxor@gmail.com>
References: <20261012133711.4030594-7-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 06/10] libbpf: Bind the arena of an object to every program in it
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 14:27:08 +0000 (UTC)

--===============5004165538961855072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Bind the arena of an object to every program in it

TL;DR:
- libbpf arena binding may make every program in an object fail to load
  (-EINVAL/-EACCES) when the arena isn't autocreated or is exclusive
- bpf_program__clone() may fail on loaded arena objects

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +static int bpf_object__bind_arena(struct bpf_object *obj, struct bpf_prog_load_opts *load_attr)
> +{
> +	struct bpf_map *map;
> +	int err;
> +
> +	if (obj->arena_map_idx < 0 || !kernel_supports(obj, FEAT_FD_ARRAY_CNT))
> +		return 0;
> +	map = &obj->maps[obj->arena_map_idx];
> +	if (map->fd < 0)
> +		return 0;

Is this check able to trigger?  bpf_object__add_map() always sets
map->fd = create_placeholder_fd(), and bpf_object__create_maps() skips maps
with !map->autocreate without closing or resetting that placeholder, so
map->fd is never negative here.

If the arena has autocreate set to false, the placeholder memfd ends up in
fd_array[0] with fd_array_cnt = 1.  On kernels with FEAT_FD_ARRAY_CNT,
process_fd_array_continuous() -> add_fd_from_fd_array() then rejects it:

    verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
    return PTR_ERR(map);

and every program in the object fails to load with -EINVAL.  Before this
patch those programs loaded fine as long as they did not touch the arena.

This looks reachable from the in-tree selftests.  In unpriv mode,
test_loader.c calls:

    bpf_map__set_autocreate(map, !unpriv || is_unpriv_capable_map(map))

and is_unpriv_capable_map() returns false for BPF_MAP_TYPE_ARENA.
progs/verifier_ldsx.c declares an arena map next to SEC("socket") programs
marked __success_unpriv, so their unpriv runs would now fail when the object
is loaded.  Users who turn off the arena and the programs that use it, for
example on architectures whose JIT does not support arenas, would hit the
same failure.

Should the check be "if (!map->autocreate)", matching what
bpf_object__relocate_data() does when it poisons ldimm64 insns that refer to
a map that was not created?

> +
> +	if (!obj->fd_array_cnt) {
> +		err = libbpf_ensure_mem((void **)&obj->fd_array, &obj->fd_array_cap, sizeof(int), 1);
> +		if (err)
> +			return err;
> +		obj->fd_array_cnt = 1;
> +	}

After this, obj->fd_array_cnt is 1 for every object that has an arena.
bpf_object_post_load_cleanup() frees the array with zfree(&obj->fd_array)
but leaves obj->fd_array_cnt at 1.

bpf_program__clone() accepts objects in the OBJ_LOADED state and fills the
attributes from the object:

    attr.fd_array = OPTS_GET(opts, fd_array, NULL) ?: obj->fd_array;
    attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0) ?: obj->fd_array_cnt;

With obj->fd_array NULL and obj->fd_array_cnt 1, the kernel's
process_fd_array() rejects this with "fd_array_cnt %u without fd_array is
invalid" and returns -EINVAL.  Before this patch, an arena object without
module kfuncs kept fd_array_cnt at 0, so cloning one of its programs after
bpf_object__load() worked.

Can cloning a program from a loaded arena object still succeed on kernels
that support fd_array_cnt?

Related to this, bpf_program__clone() on a prepared object, which is how
veristat uses it, does not call bpf_object__bind_arena() at all.  Programs
that now load through bpf_object__load(), such as a struct_ops callback that
only touches __arena arguments, would still fail when loaded through clone.
Is that intended?

> +	obj->fd_array[0] = map->fd;
> +	load_attr->fd_array = obj->fd_array;
> +	load_attr->fd_array_cnt = obj->fd_array_cnt;

This binds the arena to every program, including programs that cannot accept
it.  One case libbpf can see for itself is an exclusive arena.  If the user
calls bpf_map__set_exclusive_program(arena, progA), bpf_object__create_map()
creates the arena with excl_prog_hash set to progA's hash.

Binding that arena to any other program reaches
__add_used_map() -> check_map_prog_compatibility(), which does:

    if (map->excl_prog_sha &&
        memcmp(map->excl_prog_sha, prog->digest, SHA256_DIGEST_SIZE)) {
            verbose(env, "program's hash doesn't match map's excl_prog_hash\n");
            return -EACCES;
    }

So every other program in the object, and with it bpf_object__load(), would
now fail with -EACCES, where programs that did not refer to the arena loaded
normally before.

check_map_prog_compatibility() also rejects hardware-offloaded programs
(prog_ifindex set) with "offload device mismatch between prog and map", and
binding the arena makes programs that never touch it require CAP_PERFMON and
an enabled JIT.

Should bpf_object__bind_arena() skip the binding when
"map->excl_prog && map->excl_prog != prog"?  It may need to skip it for
offloaded programs as well.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38258617362
--===============5004165538961855072==--
