Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76B3C8700;
	Sat, 10 Oct 2026 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791674365; cv=none; b=sZq3LoeDNjLwxJymy/V7PtjVFmtcMlTp/J16O0R3aGfVgNKPJiMmH3mCZ4smXjq4x2N5Ne1Kv3QyGkVQwGXJegfe3D4eerxKKCLIPFu5ObLH+rfiW3zYnYhMPoqJbIlx2Aw8xGDyMOBwPblucaQlXoytwRU4sdi+hJpR6lhYL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791674365; c=relaxed/simple;
	bh=klsv+927BEz0ZOMCOfc8ZvqlqX1a/rG55BPm6LyAncU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IfziqTpV9SPM8jAusyvinn6c41DWUx3cWtOwHlCcKE2cZbukEOEmGLHywWDO9BvQDka5N7AEQwJOsHHp3ptFQ6KzbKGxJeRUJca4ni/tOtEwl0YTGFwECb8RLwxYWmQ3CMiMB6L0FGFSmG5pamJ/eY546MJiZ+H70em4EngzPYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUvClx3k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUvClx3k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290C61F000FF;
	Sat, 10 Oct 2026 23:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791674363;
	bh=JzRLB9Jgf0vjV1OL8x6TmVv/zMR76ZUeGDTk8MpMKs4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WUvClx3k9F9rnMOQVCeks5ysldSm5HofWm7XgXjl6P7sX5CCanaEHgzcUzOe0/DDA
	 XrW2Y9iDP6W5t4aKr9nLr2TF7WFfCm4ul3z68f99NzPM9HXDEZ9Fg8PAVAZ9Rza34i
	 keuEvbpsc1P4Gols7xH0jjXTMASQbrZI8MLiGJBpg9U56dCKoCzN6cjce4Z2KPomzj
	 atPRJaSxOD7FFXJYIuif53NFcdr2GSEBA+FzbUP6uus6ZU6yOb3kSmocIJ93/hVN7t
	 LR01d3VXKJYaQFyzhOv20PbYgy2Zg/L9G3VUUPdckndT9ebEMT+zZ6WqvTFa0z+B8O
	 J5Y3dgGFtxCag==
Content-Type: multipart/mixed; boundary="===============4233118329015196967=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <31db1dd519d2e803caa13210ece9a4c5bbe9e857f7cbe5e8c97152dd72d1c6e7@mail.kernel.org>
In-Reply-To: <20261010224902.1232178-4-arighi@nvidia.com>
References: <20261010224902.1232178-4-arighi@nvidia.com>
Subject: Re: [PATCH 3/5] docs/bpf: Document pinned arena file mappings
From: bot+bpf-ci@kernel.org
To: arighi@nvidia.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,joshdon@google.com,vineethrp@google.com,balbirs@nvidia.com,skolothumtho@nvidia.com,himadrics@protonmail.com,royfru44@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 10 Oct 2026 23:19:21 +0000 (UTC)

--===============4233118329015196967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> docs/bpf: Document pinned arena file mappings

TL;DR:
- Doc says a canonical arena mapping may start at address zero, but the
  verifier may then reject programs using it
- Doc claim about shorter mappings of non-exported arenas looks wrong when
  map_extra is nonzero
- Doc mentions an unreachable read-only restriction

> diff --git a/Documentation/bpf/map_arena.rst b/Documentation/bpf/map_arena.rst
> new file mode 100644
> index 000000000000..1b9eadd5fb3a
> --- /dev/null
> +++ b/Documentation/bpf/map_arena.rst
> @@ -0,0 +1,131 @@

[ ... ]

> +* Alternatively, leave ``map_extra`` zero and mmap the map FD first. This
> +  mapping establishes the canonical address and must cover the full map
> +  capacity. Shorter canonical mappings fail with ``EINVAL``.
> +
> +A canonical map FD mapping may start at address zero if the system's
> +low-address mapping policy permits it.

Can a BPF program use an arena in that state?  The BPF_MAP_TYPE_ARENA
handling in kernel/bpf/verifier.c still treats user_vm_start == 0 as unset:

    if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
        verbose(env, "arena's user address must be set via map_extra or mmap()\n");
        return -EINVAL;
    }

Consider an arena created with BPF_F_MMAPABLE, BPF_F_ARENA_NO_FREE and
BPF_F_ARENA_EXPORT, with map_extra == 0, followed by:

    mmap(0, capacity, ..., MAP_SHARED | MAP_FIXED_NOREPLACE, map_fd, 0)

With mmap_min_addr == 0 this succeeds, since arena_get_unmapped_area() and
arena_map_mmap() in kernel/bpf/arena.c now test user_vm_end for an
established range.  That leaves user_vm_start = 0 and user_vm_end = capacity,
and loading any BPF program that references the arena then fails with
-EINVAL.

Should the verifier check use the same "established" test, or should this
paragraph say that such an arena cannot be used by BPF programs?

[ ... ]

> +Once the canonical range is established, it covers the entire capacity
> +reported by ``fstat()``. Consumers can map the full file or smaller slices.
> +Establishing the full canonical mapping reserves virtual address space;
> +it does not populate every arena page. Arenas without
> +``BPF_F_ARENA_EXPORT`` can still establish shorter canonical mappings.

Is that last sentence true for every arena without BPF_F_ARENA_EXPORT?

For a non-exported arena created with a nonzero map_extra,
arena_map_alloc() sets user_vm_end = map_extra + max_entries * PAGE_SIZE at
creation, so the canonical range is already the full capacity.

arena_get_unmapped_area() then takes the "if (arena->user_vm_end)" branch and
rejects any len != user_vm_end - user_vm_start with -EINVAL (-E2BIG if
larger), and arena_map_mmap() returns -EBUSY when user_vm_end !=
vma->vm_end.  A shorter map FD mapping of such an arena fails, which also
conflicts with the earlier bullet saying a nonzero map_extra makes the range
cover the full map capacity.

Should the sentence be qualified with "when map_extra is zero"?

[ ... ]

> +Opening the pin uses ordinary filesystem permissions and file LSM checks,
> +as well as ``security_bpf_map()`` for the requested access mode. Mapping it
> +also passes the ordinary mmap LSM checks. Writable mappings remain subject
> +to the BPF map's frozen state and program-read-only restrictions.

Can the "program-read-only restrictions" apply to an arena?

bpf_map_mmap() does reject writable mappings of maps with BPF_F_RDONLY_PROG
(-EACCES), but arena_map_alloc() only accepts BPF_F_SEGV_ON_FAULT,
BPF_F_MMAPABLE, BPF_F_NO_USER_CONV, BPF_F_ARENA_NO_FREE and
BPF_F_ARENA_EXPORT.  Creating an arena with BPF_F_RDONLY_PROG fails with
-EINVAL, and nothing sets the flag afterwards.

Only the frozen state (BPF_MAP_FREEZE, -EPERM on a writable mapping) is a
live restriction for exported arena mappings.  Should the phrase be dropped,
or reworded to say that only the frozen state applies?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38093513563
--===============4233118329015196967==--
