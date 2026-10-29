Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271343;
	b=vfLo0ujrcuRk9fBz/13ZNCE4Z48Le6ToSV0Oliw00EyBF9NhOhDzwUVJsmQcLzaurSjo
	 rGh89z3ap+jKMQtRIaPEl7T7Lq37emcuOPdcil2HMymjzce5qR09HGRftccbf15+7HNsQ
	 SINtc92/1flGV13ALp9sDyVFIvShfQpNKpBWw3I9HyTO2IKYiugtOXq2L+mn7P/deMX76
	 gy2PijMc28v3+PtuJWxSwegqjx9xe54lO2lqeIBLwJYBdUG1vGkE9oEQRhsSZPaMKlAzj
	 IEUH2+qy0wbIQIAwZixpDXby6fptHksHyhMAVtnD/XgnNZLmlyq4jWSC9xRc3gVBtUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271343;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=NvnljmgbnBlOv1DEvqIa1FgrKIN6RbZnjAXg2eeyxSU=;
	b=d6GWaYkLxMeq2cS71qNRimAAuICSEg4b4tYfvNd4DWopcB3WqAvor9ZKOUDKGUeakzvW
	 OYsoIPpFymvvqKxj9YiFqtWjJrq/Rd5Epb5+R9R9KCoyWpmaK1xCPu70egMS5KHWA2xFq
	 4LmVyRCaOf2Txb/PWYZJXJqxvNDGpqGWAACDz40Klv6SZ5dS3Aqxf4nsBy+uzN3IgI2rq
	 MLNzTLb0fnyiZsCyWB+PmFuwqsowFiNxEEzsBKPZ3x0iSwqBScUN5cDIGrCVDZAtKfpsU
	 lRY3piNGaaDyZYiup0Hfwff/gCoA19/djY/8pP/GDaSU9raU40G0UksIiWgfzAvvgag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrlNWsHx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5F606A31D;
	Thu, 29 Oct 2026 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrlNWsHx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122A41F01828;
	Thu, 29 Oct 2026 10:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793271342;
	bh=NvnljmgbnBlOv1DEvqIa1FgrKIN6RbZnjAXg2eeyxSU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jrlNWsHxJc+V5iyfej1FVgJwA5tfwzqBfsmnUTJwPr28awzp7Y+YV/8qwU/KWR6ge
	 1OP51FKzUR0ZIESBsJWPsCwPrnodrQHnvDPVkA/s8j1sK70BUFTRDX2wuqHk3Y5vWz
	 81JuflAw2Gw8Ftl7pNypC/CiyPoEV9oGueAvbIvT+gjKLBPBgx9trmAeQwVU0l3tKj
	 oLfEqa0PMb1uPHekw4lQmRNz3w/zVaLuUrxZBNPVdKLU/l+t7AhwGIJ464kmvES9rV
	 EI1YARJeDlIoS1nqmy5bGfs1KgLw2EbvQ7iDSENhRssHsb29LsPnjp4RBv0S2TSj+E
	 TVQ+eT6XrMIUA==
Content-Type: multipart/mixed; boundary="===============4788279925260915448=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <bc648f822c04dff3b0c594e7892fbae5a667df99bf4c59a69987594dbd33904b@mail.kernel.org>
In-Reply-To: <20261029095952.44833-2-tasos.papagiannnis@gmail.com>
References: <20261029095952.44833-2-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add bpf_path_getattr()
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-fsdevel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,viro@zeniv.linux.org.uk,brauner@kernel.org,jack@suse.cz,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 29 Oct 2026 10:55:42 +0000 (UTC)

--===============4788279925260915448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add bpf_path_getattr()

TL;DR: Design nit only: bpf_path_getattr() near-copies the mount ID and
mount-root handling from vfs_statx_path(), so the two may drift; suggests a
shared helper in fs/stat.c and avoiding VFS-private headers.

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 35ccd98a4de6..95d7b0de2453 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c

[ ... ]

> @@ -1,23 +1,127 @@
>  #include <linux/xattr.h>
>  
> +#include "internal.h"
> +#include "mount.h"
> +

[ ... ]

> +	if (request_mask & STATX_MNT_ID_UNIQUE) {
> +		out->mnt_id = real_mount(path->mnt)->mnt_id_unique;
> +		stat.result_mask |= STATX_MNT_ID_UNIQUE;
> +	} else {
> +		out->mnt_id = real_mount(path->mnt)->mnt_id;
> +		stat.result_mask |= STATX_MNT_ID;
> +	}
> +	out->size = stat.size;
> +	out->attributes = stat.attributes & ~STATX_ATTR_CHANGE_MONOTONIC;
> +	if (path_mounted(path))
> +		out->attributes |= STATX_ATTR_MOUNT_ROOT;
> +	out->attributes_mask = stat.attributes_mask | STATX_ATTR_MOUNT_ROOT;

this isn't a bug, but could the mount ID and STATX_ATTR_MOUNT_ROOT handling
be shared with vfs_statx_path() through a small helper in fs/stat.c?

This block looks like a near-verbatim copy of the post-getattr part of
vfs_statx_path(), plus the STATX_ATTR_CHANGE_MONOTONIC masking from
cp_statx().

The kernel-doc says 'Results follow statx(2)', so a later change to
vfs_statx_path() (a new mount attribute, a different mount ID rule) would
have to be mirrored here by hand.

The copy is also why this file now includes the VFS-private headers:

	#include "internal.h"
	#include "mount.h"

just to reach real_mount() and path_mounted().  A helper in fs/stat.c that
applies the mount ID and mount-root fields to a kstat would keep the two
in sync and keep struct mount inside fs/.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40857522501
--===============4788279925260915448==--
