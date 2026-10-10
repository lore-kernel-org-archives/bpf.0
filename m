Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1F37F319;
	Sat, 10 Oct 2026 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791675648; cv=none; b=DzSiJOPBuN7A8cXwyxGidjIQs4TOYkT5ySkTuAeUDPoPRHIsFFuQBr4D5BBCqNJ5AXnR2RN/b7brBI6+xq4gbI+cRKveoqZtn5YvQ6VK6X/h8peKk3ykDNi65qs9us4ohmT5IMuCL6ynZfTbVbg/lOSr7OGCGUeCtWmEXah7NRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791675648; c=relaxed/simple;
	bh=cCGVpa3cjIorPjYe7dv2CaBei4qsdGmMTfRi40sDobM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Krbde1NYreAvQNdvsrrBU1AadJBH1qOTs6eTsb4uN2nvk5b9khTNvoBUxMrPYO4GwMQ2xrrt/Vs7Jd8++OHWQTQMInHWvZvzituB7Cp85rMhvBStWN0EU9uABApiWx/YesMS4AazdpARobKl+WmomDxwfktvoJzRwmkjdG1TyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlPaTm1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlPaTm1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051DD1F000FF;
	Sat, 10 Oct 2026 23:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791675647;
	bh=OreBSGS80y/hd6Y5endPjEJzRHLPPEwd3kdmF9dj9PA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HlPaTm1+jQW6IpXrCcUZ6tuWzxOrlIkNXJFgxjk+IQ7f59BTYPYcxYfEOhmY1mNB9
	 0MWkzHAkYHwYOVJONAWZb1MOR49V24+1yvAu4efCV/yQk06SjoPXRKGxcvdeRr5PHu
	 m+FuKXaE73EQRGClbQspuPpIxpp2qXmA5pVscnL587VTmsoa1GtCPxZtPfMWVbCCID
	 U+CHAN1ZW6Wf+H5gW92kMSc4e1zlIWxLO77JvTP4DQybaxOOI4lOfueEnNzlLI7fpG
	 dBTMo0buitR4BuJZlUdf9N62haF93TuvvmWmaZ1G3ps4ru6Znj/tij6PZx2v4Bgm5i
	 ZhSU4ea8i6ZQg==
Content-Type: multipart/mixed; boundary="===============0129429668757689411=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <88f1b3b6f56a9b090cb25116c323256cc936b2f2ae2fd310221e4d7e5d77564b@mail.kernel.org>
In-Reply-To: <20261010224902.1232178-3-arighi@nvidia.com>
References: <20261010224902.1232178-3-arighi@nvidia.com>
Subject: Re: [PATCH 2/5] bpf: Expose pinned arenas as sized bpffs files
From: bot+bpf-ci@kernel.org
To: arighi@nvidia.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,joshdon@google.com,vineethrp@google.com,balbirs@nvidia.com,skolothumtho@nvidia.com,himadrics@protonmail.com,royfru44@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 10 Oct 2026 23:40:44 +0000 (UTC)

--===============0129429668757689411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Expose pinned arenas as sized bpffs files

TL;DR: Nits only in bpf_mkmap() in kernel/bpf/inode.c: the nested ternary
could be an early return, continuation indentation is off, and the
arena-export predicate duplicated in bpf_map_setattr() could be shared.

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 7837968c0842..d3dc6f70e32a 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c

[ ... ]

> @@ -390,16 +469,20 @@ static int bpf_mkobj_ops(struct dentry *dentry, umode_t mode, void *raw,
>  static int bpf_mkprog(struct dentry *dentry, umode_t mode, void *arg)
>  {
>  	return bpf_mkobj_ops(dentry, mode, arg, &bpf_prog_iops,
> -			     &bpffs_obj_fops);
> +			     &bpffs_obj_fops, 0);
>  }
>
>  static int bpf_mkmap(struct dentry *dentry, umode_t mode, void *arg)
>  {
>  	struct bpf_map *map = arg;
> +	bool shared_arena = map->map_type == BPF_MAP_TYPE_ARENA &&
> +			    (map->map_flags & BPF_F_ARENA_EXPORT);
>
>  	return bpf_mkobj_ops(dentry, mode, arg, &bpf_map_iops,
> -			     bpf_map_support_seq_show(map) ?
> -			     &bpffs_map_fops : &bpffs_obj_fops);
> +			    shared_arena ? &bpffs_arena_fops :
> +			    bpf_map_support_seq_show(map) ?
> +			    &bpffs_map_fops : &bpffs_obj_fops,
> +			    shared_arena ? (loff_t)map->max_entries * PAGE_SIZE : 0);
>  }

This isn't a bug, but would it read more simply to handle the exported arena
case with an early return in bpf_mkmap(), rather than testing shared_arena
twice inside a nested ternary in the argument list?

The continuation lines here are also indented one column short of the open
parenthesis, unlike the matching call in bpf_mklink().

The same 'map->map_type == BPF_MAP_TYPE_ARENA && (map->map_flags &
BPF_F_ARENA_EXPORT)' predicate is repeated in bpf_map_setattr().  Could it be
shared through a small helper, or could bpf_map_setattr() check
inode->i_fop == &bpffs_arena_fops instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38093513563
--===============0129429668757689411==--
