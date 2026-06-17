Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A9367295
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695930; cv=none; b=tGUJj7wXpnlBDQSMoaHJBNsqsxLJUscx+9us8yWt8oGjIAXZwP5zsB402q0V0lkB1mHjV6XXAo/Cc56+x+KLfd4rnJh7/itXQjGRQwV1odw1Mir28Ff1+UVLDk9XP9SyWGj8Fk+aLB2QTc9KtegGNQWpssmYXDuow7Qzk0pS+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695930; c=relaxed/simple;
	bh=4UjqEemEQEdhAiPrV4dy6TW10mzTZCIo+T8wJoZauwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nmj7pmGkymvpqvVja2iVB/3vVJ0p0XtzjDYsdMVGeglYDPnvQGD1E8qSu2b2sMGlPeQq66KRExeItRwb5rMVXcq5vw1rilf64P3rzRPvvrPJmsTyYPvEhrAopAjkfJPwERiEHVSlXAjXPaNTX6OrPxbUWNdA30ABqI+NpywLsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9uKyqD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9uKyqD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4BA1F000E9;
	Wed, 17 Jun 2026 11:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781695929;
	bh=7WU16lMRuP/bpuNQ/cdoxCrJhza4LSZk1RiRRPRl0Vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L9uKyqD/+LhODxOJqWnYZsjwOEcgcVlBUvIrDGfZYfda3kJj953Dmi83K/jyaagEj
	 0UhSz2+i8zE2SOhHa3wxqSig2Rlf2dJpYt4dYaHKq3cvhMGUaUbQhYN2qJqQTZBQ8O
	 wney4TaujCGTYpX+iVtBI6+1Bw801R5UxM2DwhYhq76doeLfBMIVMclqgxctZATbAH
	 OC/uRyXYxZ1aqTCxIK4wIrbU7RyPI1oB189KVtqWsT8HKH9JM4juSazjQqceuyEPHF
	 1XRsvKDOTqnJ080L9EFsTkZYvgwoT9zTsnryWirStOicSK07rKvK+Twa2aAmHwx9NG
	 U87zJv+ppchFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] fs: Add bpf_sock_read_xattr() kfunc to read socket
 xattrs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
 <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 11:32:08 +0000
Message-Id: <20260617113209.8D4BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing READ_ONCE() on lockless access to sock->file can lead to a=
 TOCTOU NULL pointer dereference.
--

commit 9bf8c99c6cda345fa08537f5df5f36bc0aa367b9
Author: Christian Brauner <brauner@kernel.org>

fs: Add bpf_sock_read_xattr() kfunc to read socket xattrs

This commit introduces the bpf_sock_read_xattr() kfunc to allow BPF LSM
programs to locklessly read user.* extended attributes from a socket's
sockfs inode. The kfunc is registered as KF_RCU, and retrieves the
attributes using an RCU-protected rhashtable lookup.

Link: https://github.com/systemd/systemd/pull/40559 [1]

> diff --git a/net/socket.c b/net/socket.c
> index 9e8dc769ff7af..3566f8c8ea3fb 100644
> --- a/net/socket.c
> +++ b/net/socket.c
[ ... ]
> @@ -465,6 +465,31 @@ static const struct xattr_handler sockfs_user_xattr_=
handler =3D {
>  	.set =3D sockfs_user_xattr_set,
>  };
> =20
> +/**
> + * sock_read_xattr - read a user.* xattr from a socket's sockfs inode
[ ... ]
> +int sock_read_xattr(struct socket *sock, const char *name, void *value, =
size_t size)
> +{
> +	struct file *file =3D sock->file;
> +	struct sockfs_inode *si;
> +
> +	if (!file || sock_from_file(file) !=3D sock)

[Severity: High]
Can a concurrent close cause a NULL pointer dereference here?

Since bpf_sock_read_xattr() is registered with KF_RCU, BPF programs can
call it under RCU protection where the socket might not have a held file
reference. If the last file descriptor is closed concurrently,
__sock_release() can set sock->file =3D NULL without waiting for an RCU gra=
ce
period.

Because sock->file is read without READ_ONCE(), the compiler is permitted
to reload the pointer from memory. If the initial read for the !file check
sees a valid pointer, but a subsequent read for the inlined
sock_from_file(file) call sees NULL due to the concurrent modification,
sock_from_file() will attempt to dereference file->f_op on a NULL pointer.

Does this need struct file *file =3D READ_ONCE(sock->file) to prevent a
TOCTOU issue?

> +		return -EOPNOTSUPP;
> +
> +	si =3D SOCKFS_I(SOCK_INODE(sock));
> +	return simple_xattr_get(&sockfs_xa_cache, &si->xattrs, name, value, siz=
e);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-work-bpf-s=
ock-xattr-v1-0-a1276f7c9da3@kernel.org?part=3D1
