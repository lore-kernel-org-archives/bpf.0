Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307211DED49
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792024407; cv=none; b=fa2l+yCMQLtNs0EEt3R9ccmt0YFQ8TYJPOkplNPs8Juhne+/oeX4SEie2sm7vCyfa/QklavS+sVO6UK++KJi+dFRNwrnT3h4pZ8Va0ezEz27ta/7z87+53lKpt2HaqbHdjlAAerY2WDh0oo+ZrHldHi6JjblI/itVH4ZeHIhQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792024407; c=relaxed/simple;
	bh=cKixVpKXtanuNd9nubWCPs66NHZV8Oi93GFtnOCxaqw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cAABFRtH6fGawXb0JLzt8LGjyEVniEh8uBHPXhfoa3pkh6pSPebfEgfeBsOspyIAPPht8iEh720HJ15l5LBQJlTKMzJvJyqdKV+C0DPgaMWDy9K7+Dixc0obAL6418xaCMMpQ4GGWz2F12jiAQC+cWEuOZHWnfDRQy3/6PJZsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bfza075t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bfza075t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A861F000C5;
	Thu, 15 Oct 2026 00:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792024405;
	bh=NC6bHAD7X4eaJWJ0SnPxt2yk97c1P9LeihULs6YpX64=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Bfza075tv0nH6uw8GwZ3fvcD6JsOTrCRFFrpF8PZ0/f+4Redor9JpIwsA/Nb9dP5K
	 P1G6o4szYI/RXq0IcbpvaA2Vk+NaKATN8h1ILbHbxp5EgHsnkZOhBoUyyvXgIOXdQY
	 DsEtVcG+QggZsj7O3xXL/s1kABTwB6w8nErnbf+I48NyPK8nlSu+o5E0RbRsuVPaq4
	 FDbTHDXDfnCPSTXayN3aKSMygEYk6TIKdEf2mH16pPrh1RKhlPIyEangcvMN2AlZj1
	 x4LEsrgF61Jaq07yr74VNJbUoIcUrEceqtsChlFqhzkCcTAJkAXdNATj9b5jibjyl3
	 Id2426XBvJ1DQ==
Content-Type: multipart/mixed; boundary="===============0943442245956187446=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7d5f77a9d307bc2cc1ae43aa3cf628757e2342a26b02ddc9daa0276ff2d6c094@mail.kernel.org>
In-Reply-To: <20261014233442.8392-2-emil@etsalapatis.com>
References: <20261014233442.8392-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Use mapping tree to zap arena VMAs
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 15 Oct 2026 00:33:24 +0000 (UTC)

--===============0943442245956187446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Use mapping tree to zap arena VMAs

TL;DR: Per-arena anon inode is no longer S_PRIVATE, so under SELinux arena
creation, mmap and fd passing may now be denied for existing policies. Was
this intended? Commit message doesn't mention it.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -326,12 +330,18 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
>  	if (err)
>  		goto err_free_scratch;
>  	mutex_init(&arena->lock);
> -	mutex_init(&arena->zap_mutex);
>  	raw_res_spin_lock_init(&arena->spinlock);
>  	err = populate_pgtable_except_pte(arena);
>  	if (err)
>  		goto err_destroy_rt;
>
> +	arena->file = anon_inode_create_getfile("bpf-map", &arena_backing_fops,
> +						NULL, O_RDWR, NULL);
> +	if (IS_ERR(arena->file)) {
> +		err = PTR_ERR(arena->file);
> +		goto err_destroy_rt;
> +	}
> +
>  	return &arena->map;

Does switching arena fds from the shared S_PRIVATE anon inode to a
per-arena inode from anon_inode_create_getfile() change LSM behavior in a way
the commit message doesn't mention?

anon_inode_create_getfile() creates a !S_PRIVATE inode and calls the
inode_init_security_anon() hook:

    inode = alloc_anon_inode(sb);
    inode->i_flags &= ~S_PRIVATE;
    ...
    error = security_inode_init_security_anon(inode, &QSTR(name), context_inode);

Under SELinux this looks like it has two new effects for
BPF_MAP_TYPE_ARENA.

First, map creation now runs the anon inode create check:

    map_create() -> map_create_alloc() -> arena_map_alloc()
      -> anon_inode_create_getfile()
        -> selinux_inode_init_security_anon()

    return avc_has_perm(sid, isec->sid, isec->sclass, FILE__CREATE, &ad);

A policy that doesn't grant the caller's domain anon_inode { create } on the
transitioned "bpf-map" type would now fail arena creation with -EACCES,
which the PTR_ERR() above returns to userspace.

Second, every arena fd built by arena_map_get_file() via alloc_file_clone()
of arena->file has an inode without S_PRIVATE.  Previously
inode_sid_has_perm() returned early for the shared anon inode:

    if (unlikely(IS_PRIVATE(inode)))
        return 0;

That early return no longer applies.  mmap() of the arena
(selinux_mmap_file() -> file_map_prot_check() -> __file_has_perm() ->
inode_has_perm()) and passing the fd over SCM_RIGHTS or binder
(selinux_file_receive() -> file_has_perm()) would now need anon_inode
{ read write map } permission on that label, including in the receiving
domain.

Other map types keep the old unlabeled behavior because they still use
anon_inode_getfd(), so only arena fds get these checks.  Existing
SELinux-enforcing setups whose policy was written for the old behavior, such
as a loader daemon that creates maps and hands the fds to confined
applications, could start seeing denials on arena creation or mmap.  The
later patches in this series still call anon_inode_create_getfile(), so this
isn't changed there.

Was the new LSM labeling intended?  If the goal is only a unique inode and
mapping, could the old S_PRIVATE, unlabeled semantics be kept instead, or
could the commit message at least document the new policy requirements?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38657686181
--===============0943442245956187446==--
