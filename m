Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C7343D8A
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815416; cv=none; b=Ewp1wdNpaZp6BOecsQdC4tVgdF4V0IXKSy5VCA0E4bWM5iO0r5YFMGkId8rH9rIxh2qUlcorhlef0/LWH/8jjjK8cS1ED/5byJzphH6bbUADGDN3GATLrbkDwdEgp9izadQtSnwHinGTik87wAlT/w+Bpd3Ccm+6dbvgcxZsTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815416; c=relaxed/simple;
	bh=B0+Z0O4E5WRB+/uuJxvY/VVwARzSsuqx2UuMgRk8urI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZV08BMpPFU9FSWOIhNAr1wNxHoTrsP700rKcvcfrkLJHww4KWi+HDXyFM9E4e0LIxR4VIzOxye6TA5HnBChqnMOlyD+vxOcazI7NLGaICmBWWReAVATjBVQxqs+exwQNtvJeyc1Iiz8fhw0p8vKUlXIeLN6JLWCzxr58Jc+W1Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wlqxd+Cm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wlqxd+Cm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD241F000E9;
	Thu, 18 Jun 2026 20:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781815415;
	bh=duNN/odcP4eI3KsaEShriMtMjDVO020ICiyVe9+B+IQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wlqxd+CmouqFeIt3IKWTXi6lLSo3+o/sSfpXrGnuhKxfAQxxgFkY5uj+bzkT4obhn
	 jhxkZF28JnNX9uTw/XEjKBVVd0iOEFQWEIv+HPl/vMLWBnxkQZKhtL0j+IGXae47JC
	 5OelT4bGZlLjuw/KB7Pq64bHiJezJEh0bq1QzodJzqHsUCkW9QPf5+Kkw6dYmxfa3y
	 cS55iMgBznX7oU1VUQl47YOJ0YtRWKrvuvCK842nxlaJTTLVMbglvka7g3c9yd9qiI
	 56gC/6ZHEPXwrog5snwxa9EtFcGM7rLtOUOXkOC0QD1nuvxbiNrvT2UfuFyGEBgBE/
	 G2sITrzKr4IbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, paul@paul-moore.com
In-Reply-To: <20260618203411.73917-2-dwindsor@gmail.com>
References: <20260618203411.73917-1-dwindsor@gmail.com>
 <20260618203411.73917-2-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 20:43:34 +0000
Message-Id: <20260618204335.1AD241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf_init_inode_xattr incorrectly uses GFP_KERNEL when allocating x=
attr_value inside the inode_init_security hook, which can trigger filesyste=
m reclaim deadlocks.
--

commit 90409fcd43737306bcca3704874f44073960a65f
Author: David Windsor <dwindsor@gmail.com>

bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling

This commit adds the bpf_init_inode_xattr() kfunc for BPF LSM programs to
atomically set xattrs via the inode_init_security hook. It updates the hook
interface to use a single xattr_ctx context object rather than separate
arrays and counts.

Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-Octo=
ber/034878.html [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D6bcdfd2cac55 [2]

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f03..7abc3f3d1a678 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
[ ... ]
> @@ -374,6 +375,97 @@ __bpf_kfunc struct inode *bpf_real_inode(struct dent=
ry *dentry)
[ ... ]
> +static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> +				  const char *name__str,
> +				  const struct bpf_dynptr *value_p)
> +{
[ ... ]
> +	value =3D __bpf_dynptr_data(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	/* Combine xattr value + name into one allocation. */
> +	xattr_value =3D kmalloc(value_len + name_len + 1, GFP_KERNEL);

[Severity: High]
Can this cause a filesystem transaction deadlock?

The inode_init_security hook is called during inode creation, which often
happens while filesystems like ext4 or btrfs hold critical filesystem locks
or an active journal transaction.=20

If kmalloc is called with GFP_KERNEL here, the memory allocator can enter
direct reclaim. The reclaim path may re-enter the filesystem to write back
dirty pages or shrink caches, attempting to acquire the same locks that are
already held by the active file creation path.

Other LSMs and the core security framework explicitly use GFP_NOFS during
the inode_init_security hook to avoid these reclaim deadlocks. Should this
allocation use GFP_NOFS instead?

> +	if (!xattr_value)
> +		return -ENOMEM;
> +
> +	memcpy(xattr_value, value, value_len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618203411.7391=
7-1-dwindsor@gmail.com?part=3D1
