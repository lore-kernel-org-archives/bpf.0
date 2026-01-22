Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9534F472;
	Thu, 22 Jan 2026 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097736; cv=none; b=Zp2W+re9vIxpLdnAleLLelbIwsZmk/RPbpRzoXbI6ke37ioojv0QaDXjN0NtAxVysOZhFQ3gS6H8LZow+/Xz7VBXa5mUlZLF9OKWF7Z6znet7dugAxnL286bswdFCI93sJLiYWpsli2qRRLkaHi3o0J8yT4BH8zmkOFbRpWr3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097736; c=relaxed/simple;
	bh=IrHcyedQGo0qLm6aBIsO6/oqyQpXGwxTdLybEDdlwgc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CuJ6uSvv/9z+1QtAtUFPu74tS5k923eBVqlwXv8IIaZeymQpAmBojppVwr6DwEJDcyj61SYxoK7hgJ6iQT5h+E12SWEdXc1Lp0ZuNolSVsqLjwqkGlkBgKac0X88FOG1sZVtdClgSj4vdpLQKqvUvMgoLk+4MkA3T09a2pZKwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3V/oARy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3V/oARy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02E9C19425;
	Thu, 22 Jan 2026 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769097734;
	bh=IrHcyedQGo0qLm6aBIsO6/oqyQpXGwxTdLybEDdlwgc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=O3V/oARyTLx9nPs6TolS9zMpsw6WQ7RdlXNAk11hTMDUU5FisL17BY/unrFcT3mri
	 mTCQ73Env68145EJRNB9hdncSoX9WYtiF7TT4UMrxOIfWtagA9UOevNa7KWyME4GZ7
	 o/S+SyqeH6AU/84GIF/2K1lIphHdg8lOw9zyS4RO4YhcZQN0Yg/FPRbaDtl8YxzQh/
	 0y265zeimbKRUWoX23JnD6RW2xtbCgAZJE364KbdRGQAjTKDxvaTiklIjRNEi9kFsr
	 cPD7UnRcCNFkq85L8Dvfp+nuSbiXhTPRbRWAbP+EoTDDuoOdSeX+Nscc+Gd9MzBixo
	 Z9q/jD71OM45Q==
Content-Type: multipart/mixed; boundary="===============3118955334998125414=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <df8fb7dc501dd081fcba56b592cba94e5aecd614ea4d3b595155dec551ecbca5@mail.kernel.org>
In-Reply-To: <20260122153120.69249-2-leon.hwang@linux.dev>
References: <20260122153120.69249-2-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: Disallow BPF_F_LOCK with mixed special fields and centralize flag checks
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 22 Jan 2026 16:02:11 +0000 (UTC)

--===============3118955334998125414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5936f8e2996f..c5863487ee73 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3935,9 +3935,16 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
>  	if ((u32)flags & ~allowed_flags)
>  		return -EINVAL;
>
> +	/* BPF_NOEXIST and BPF_EXIST are mutually exclusive. */
> +	if ((flags & (BPF_NOEXIST | BPF_EXIST)) == (BPF_NOEXIST | BPF_EXIST))
> +		return -EINVAL;
> +
>  	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>  		return -EINVAL;
>
> +	if ((flags & BPF_F_LOCK) && btf_record_has_field(map->record, ~BPF_SPIN_LOCK))
> +		return -EOPNOTSUPP;
> +
>  	if (!(flags & BPF_F_CPU) && flags >> 32)
>  		return -EINVAL;

[ ... ]

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index e2fe6c32822b..80b50091cbbf 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -493,13 +493,6 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>  	unsigned long flags;
>  	int err;
>
> -	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
> -	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
> -	    /* BPF_F_LOCK can only be used in a value with spin_lock */
> -	    unlikely((map_flags & BPF_F_LOCK) &&
> -		     !btf_record_has_field(smap->map.record, BPF_SPIN_LOCK)))
> -		return ERR_PTR(-EINVAL);
                ^^^^

This validation was removed from bpf_local_storage_update() but it appears
that no call to bpf_map_check_op_flags() was added in the local storage map
update functions. For array and hash maps, calls to bpf_map_check_op_flags()
were added in array_map_update_elem() and htab_map_update_elem(). However,
the local storage update functions like bpf_cgrp_storage_update_elem(),
bpf_fd_inode_storage_update_elem(), and bpf_fd_sk_storage_update_elem() pass
map_flags directly to bpf_local_storage_update() without calling
bpf_map_check_op_flags() first.

The syscall path does call bpf_map_check_op_flags() in map_update_elem() with
allowed_flags set to ~0, which catches the NOEXIST/EXIST mutual exclusion and
BPF_F_LOCK validation. But with allowed_flags=~0, the check for unknown flags
((u32)flags & ~allowed_flags) always passes zero, meaning unknown flags like
8 or 16 would not be rejected.

The old check (map_flags & ~BPF_F_LOCK) > BPF_EXIST rejected any unknown flag
bits. Is there a missing call to bpf_map_check_op_flags() in the local storage
update functions that should specify the allowed flags?

> -
>  	if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
>  		return ERR_PTR(-EINVAL);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21254704407

--===============3118955334998125414==--
