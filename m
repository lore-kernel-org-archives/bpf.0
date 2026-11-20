Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183391;
	b=bUMw4tgds0ZPmUw+TnfSV4Naz2nB3xw5YcLMacNNZxE+F8KeuXtGC3fgN6khrqV0657e
	 aPsf3EpRjsZJQQIbRSoqwLC//h/xuMMgHUW7Z5KlwaZtIi930hXZO6uq7EbJtucsSMpYX
	 sUi1+cZ4DPpcanz2aOh6fMSlLAq7iLff53Q9QyawgO5onLyWvxK9rZrHJgNnWYwUvSWW9
	 eO0kMDi0OwEWp/wxfQ7osHErg9oq4cI/57iSowAIwGZsXH9Di8HJ8oNDouMNMwOh+tJKV
	 h1D+Db93CRvt6uDw/2qjd9Aoaxnalatvof20V4DIepRRHV9dkFDApRx26U1oUv+fOSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=D98RljPeJIlkIJBWYWPihvZLS/ylF7xKs07IaIfeuMA=;
	b=wk2sZsfmAHqkkn+VgGZQmSP3jzRv+eX5RB5Sfstrk1/LuTNhvibsrUvjIdHjIauxj6EL
	 NEZNubUWXAtjd12HrpwPEXjl4NPIv4VwTinZ+CKinPz1LV4UeDXHV4/dgCKwmPXoYiN4h
	 7mDALf8X8pn8c0paAQRGumP5x0TX3bldrISbmHsjRVyqaRXfVM3pUnaOMdMVwh0r4uB1l
	 ncHM6K1MEOskT5tI1Qt4LP0thIXR2k5Qgr9xYSrU4OFFEdxeuYXWZNFyIBLa8H91UOF9Z
	 AROF3eqOO7/UOjJbYconkZ08gW2DPn2vlcctgL53RargPujVOey4TzqKlZW/rKPVXVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=h5Ehnf9j;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9BC606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 14:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC9BC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=h5Ehnf9j
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dee593f18so799497f8f.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 06:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795183389; x=1795788189; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=D98RljPeJIlkIJBWYWPihvZLS/ylF7xKs07IaIfeuMA=;
        b=h5Ehnf9jIz3LtPeuuxWNWibJhcsgYdo6LbDCPxb7qbCEacvBepFAN1vaFoFBY9g/+/
         M5zYm2SfcxgriuwHyR6RP+vhr5nLR/Lvj8UgVoHi8bsU2ZhHSGjhNYPZeDS0f9OJWdC0
         h2wl2uU4zG2vUgDvJuu3UiWXmcpL5feNQz9D6q60a/mhU3ecNzAQM5knbzkVQWxZCVPJ
         W5vCfSyV2bRoX5TyZd5GtFRFTSNoQ81FsuhLDOc1D0PP2uYg9cWvwpLiDJTCxeI/c6JC
         uPkZXZa+acVx8vOQXRxYIg4E5nGe0wgaw7bZB6lJZBg8TUfJDjTR+bXVcIUxkun0SMQV
         Rvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183389; x=1795788189;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D98RljPeJIlkIJBWYWPihvZLS/ylF7xKs07IaIfeuMA=;
        b=1ZikOxIC34gSV+NlBedabe86c7Z7RDcQPOK5By/3gBEVGNAeNx1w0W+BksNRY9Hsi4
         qjX6H6aT4Yr9FYLTXkdgsMHVAxHnrMoz0hHgTPbI6X9BVWJfthBv4b8TN5fPhJevghlg
         IX7aX04kHOD1PyjN/NqzxXrd0QsipgOGhMZejDEwwkHV7p1FVPwO3xbp20eUSPJfQDUt
         Jdm8Cwno0ZbuoB6uzss4s20Vp9r/coz7QFBLm3RLlNGLVOFH/L9VZoYZblAI+mEi9voJ
         ABfHJW65Ous7gTjgY0IG2dQ82FJDDFAX+jMdogT4K1C941enwIK8Eb8/l7gKAM7+fHD0
         Vfyg==
X-Forwarded-Encrypted: i=1; AL+hErGveTQr8ggJvuINGgPrVjwUYuXAOUrMxk9rAeha/UsaczqJmDCI6QMYxzPGCJZJsBkepdo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8K8ynhZan18rxyoDSAKsC++5qIoW1LBCfJjstjOVyh6LwKPbPy
	6Pq/8TIMrZWio+1ZTiKhNkvaUA0m0zeYEl/sa2wRZsAssLulWvL/gY1dsu4i9NWsFb4y
X-Gm-Gg: AYBFou3veRIbruzCczZjm4r8QX6xt1hOGRfYWPgbPuFK6uqZRTdcuuquf1jOGdIB6Cx
	Ft2ry7Nb3zgYxlaD52JyUTaLs5chI85p8WXgW1pC4TCypqaI2/wDmXnUmakfhqddS6BbJ2ZqCoD
	+K/gg0hbwW6nmlDQVZxRLVZS4nG74SlAntlUU3TBLCWSU2H8oivZO47TlxpJMe4HFaY+/lF/yIO
	A/EfcoGqDtZxQzrXki87Wgoux9DYy2bK8GYHL93MVudLhKGLGtccPIK8K+GT+Lonx9WH1npgbhp
	zcSOW1wT82img/9Xzyk/j1Ju0moS0ZZzw438ifHGvOUL+RlhWpxV3nRH44UJ4k2k896t/1uusT6
	lpNW+sjH9ncnCGUlhEeXWIuXeNa+DQy8rqzK2mZB+UIE5JEi6Oc+hqU1/Amm2wHEy9OlzxkyloJ
	mdZW9NmyKRwDz6vg7LV9ieMk3f+bKlAbGgNoAF79/lM0XveaNcLf+Uwxhz/vaAvRfsWcUsgQlW7
	a3ULV7VIG1OZUJ4ajPgmDqlqEV7ipq5w7LDM3H+i/X1cEiK+SoaJBV9zYKwnHIc9PvzyXITtBfC
	mo5zxvWwa5HARejU6n+X+t/ShwrkQfcmEXi7wyFL1ZMIM10IIVgW0V9+XEwyhyjgO7rRZqGj0sS
	y5PJ03Snuhc8=
X-Received: by 2002:a05:600c:6749:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4bb8881a294mr70028995e9.25.1795183388769;
        Fri, 20 Nov 2026 06:03:08 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-188.customers.d1-online.com. [80.187.84.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm126078465e9.11.2026.11.20.06.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:03:08 -0800 (PST)
Message-ID: <ecb63d95f150bd91bbd8a3c83211055461bc9594.camel@amutable.com>
Subject: Re: [PATCH 2/2] ns: don't call the namespace LSM hooks for
 kernel-internal namespaces
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org,
 Zhiqi Zhang <zhiqizhangg@gmail.com>
Date: Fri, 20 Nov 2026 15:03:07 +0100
In-Reply-To: <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
References: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>
	 <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-20 at 13:29 +0100, Christian Brauner wrote:
> mount_subtree() allocates a private anonymous mount namespace so that
> automounts triggered while it looks up the path have somewhere to go.
> That namespace never becomes anyone's namespace and it's gone again
> before mount_subtree() returns. btrfs goes through it on every mount:
>=20
> =C2=A0 btrfs_get_tree()
> =C2=A0 -> btrfs_get_tree_subvol()
> =C2=A0=C2=A0=C2=A0=C2=A0 -> mount_subvol()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> mount_subtree()
>=20
> and NFS on every NFSv4 mount and whenever it follows a referral:
>=20
> =C2=A0 nfs4_try_get_tree() / nfs4_get_referral_tree()
> =C2=A0 -> do_nfs4_mount()
> =C2=A0=C2=A0=C2=A0=C2=A0 -> mount_subtree()
>=20
> But __ns_common_init() calls security_namespace_init() for it like
> for
> any other namespace. Since commit 15dd86021b57a ("landlock: Enforce
> namespace use restrictions") Landlock enforces
> LANDLOCK_PERMISSION_NAMESPACE_USE in its namespace_init hook. So a
> task
> in a domain that handles that permission without allowing CLONE_NEWNS
> can't mount btrfs or NFSv4 anymore. mount(2) fails with EPERM even
> though the caller never asked for a mount namespace.
>=20
> Mark such namespaces as kernel-internal and don't call the namespace
> LSM hooks for them at all. That includes namespace_free. Currently
> security_namespace_free() only calls the hook if an LSM requested a
> namespace blob and none does. But we shouldn't rely on that.
> Otherwise
> a bpf program attached to namespace_free would see namespaces go away
> that it never saw being created.
>=20
> The anonymous mount namespaces created by open_tree(OPEN_TREE_CLONE)
> and fsmount() are handed to userspace and keep going through the
> hooks.
> Landlock covers them on purpose.
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Reported-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
> Closes:
> https://lore.kernel.org/20261114141323.19029-1-zhiqizhangg@gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me.

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/namespace.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 9 +++++++--
> =C2=A0include/linux/ns/ns_common_types.h |=C2=A0 2 ++
> =C2=A0include/linux/ns_common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 20 +++++++++++++-------
> =C2=A0kernel/nscommon.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++++---
> =C2=A04 files changed, 28 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 756f9011cbf1d..82738b818c1d0 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2355,6 +2355,7 @@ void drop_collected_paths(const struct path
> *paths, const struct path *prealloc)
> =C2=A0
> =C2=A0enum mnt_ns_flags_t {
> =C2=A0	MNT_NS_ANON	=3D (1 << 0),
> +	MNT_NS_KERNEL	=3D (1 << 1),
> =C2=A0};
> =C2=A0
> =C2=A0static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *,
> @@ -4377,10 +4378,14 @@ static void free_mnt_ns(struct mnt_namespace
> *ns)
> =C2=A0static struct mnt_namespace *alloc_mnt_ns(struct user_namespace
> *user_ns,
> =C2=A0					=C2=A0 enum mnt_ns_flags_t flags)
> =C2=A0{
> +	enum ns_common_flags_t ns_flags =3D 0;
> =C2=A0	struct mnt_namespace *new_ns;
> =C2=A0	struct ucounts *ucounts;
> =C2=A0	int ret;
> =C2=A0
> +	if (flags & MNT_NS_KERNEL)
> +		ns_flags |=3D NS_COMMON_KERNEL;
> +
> =C2=A0	ucounts =3D inc_mnt_namespaces(user_ns);
> =C2=A0	if (!ucounts)
> =C2=A0		return ERR_PTR(-ENOSPC);
> @@ -4392,7 +4397,7 @@ static struct mnt_namespace
> *alloc_mnt_ns(struct user_namespace *user_ns,
> =C2=A0	}
> =C2=A0
> =C2=A0	if (flags & MNT_NS_ANON)
> -		ret =3D ns_common_init_inum(new_ns, MNT_NS_ANON_INO);
> +		ret =3D ns_common_init_inum(new_ns, MNT_NS_ANON_INO,
> ns_flags);
> =C2=A0	else
> =C2=A0		ret =3D ns_common_init(new_ns);
> =C2=A0	if (ret) {
> @@ -4515,7 +4520,7 @@ struct dentry *mount_subtree(struct vfsmount
> *m, const char *name)
> =C2=A0	struct path path;
> =C2=A0	int err;
> =C2=A0
> -	ns =3D alloc_mnt_ns(&init_user_ns, MNT_NS_ANON);
> +	ns =3D alloc_mnt_ns(&init_user_ns, MNT_NS_ANON |
> MNT_NS_KERNEL);
> =C2=A0	if (IS_ERR(ns)) {
> =C2=A0		mntput(m);
> =C2=A0		return ERR_CAST(ns);
> diff --git a/include/linux/ns/ns_common_types.h
> b/include/linux/ns/ns_common_types.h
> index 47a5cfe2326a3..5f8b0930ae065 100644
> --- a/include/linux/ns/ns_common_types.h
> +++ b/include/linux/ns/ns_common_types.h
> @@ -102,6 +102,7 @@ extern const struct proc_ns_operations
> utsns_operations;
> =C2=A0 *=C2=A0=C2=A0 __ns_ref_active =3D 1 and remain active forever.
> =C2=A0 *
> =C2=A0 * @ns_type: type of namespace (e.g., CLONE_NEWNET)
> + * @ns_flags: NS_COMMON_* flags
> =C2=A0 * @stashed: cached dentry to be used by the vfs
> =C2=A0 * @ops: namespace operations
> =C2=A0 * @inum: namespace inode number (quickly recycled for non-initial
> namespaces)
> @@ -113,6 +114,7 @@ struct ns_common {
> =C2=A0		refcount_t __ns_ref; /* do not use directly */
> =C2=A0	} ____cacheline_aligned_in_smp;
> =C2=A0	u32 ns_type;
> +	u32 ns_flags;
> =C2=A0	struct dentry *stashed;
> =C2=A0	const struct proc_ns_operations *ops;
> =C2=A0	unsigned int inum;
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index e8b2bf0da5ede..524b77904d3b4 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -8,9 +8,14 @@
> =C2=A0#include <uapi/linux/sched.h>
> =C2=A0#include <uapi/linux/nsfs.h>
> =C2=A0
> +enum ns_common_flags_t {
> +	/* Kernel-internal namespace. The LSM namespace hooks never
> see it. */
> +	NS_COMMON_KERNEL	=3D (1 << 0),
> +};
> +
> =C2=A0bool is_current_namespace(struct ns_common *ns);
> =C2=A0int __ns_common_init(struct ns_common *ns, u32 ns_type, const struc=
t
> proc_ns_operations *ops,
> -		=C2=A0=C2=A0=C2=A0=C2=A0 int inum, u64 ns_id);
> +		=C2=A0=C2=A0=C2=A0=C2=A0 int inum, u64 ns_id, enum ns_common_flags_t
> flags);
> =C2=A0void __ns_common_free(struct ns_common *ns);
> =C2=A0struct ns_common *__must_check ns_owner(struct ns_common *ns);
> =C2=A0
> @@ -47,13 +52,14 @@ static __always_inline bool is_ns_init_id(const
> struct ns_common *ns)
> =C2=A0		=09
> ns_common_type(__ns),				\
> =C2=A0		=09
> to_ns_operations(__ns),			\
> =C2=A0			 (((__ns) =3D=3D ns_init_ns(__ns)) ?
> ns_init_inum(__ns) : 0), \
> -			 (((__ns) =3D=3D ns_init_ns(__ns)) ?
> ns_init_id(__ns) : 0))
> +			 (((__ns) =3D=3D ns_init_ns(__ns)) ?
> ns_init_id(__ns) : 0), \
> +			 0)
> =C2=A0
> -#define ns_common_init_inum(__ns, __inum)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> -	__ns_common_init(to_ns_common(__ns),=C2=A0=C2=A0=C2=A0=C2=A0 \
> -			 ns_common_type(__ns),=C2=A0=C2=A0 \
> -			 to_ns_operations(__ns), \
> -			 __inum, 0)
> +#define ns_common_init_inum(__ns, __inum, __flags) \
> +	__ns_common_init(to_ns_common(__ns),=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> +			 ns_common_type(__ns),=C2=A0=C2=A0=C2=A0=C2=A0 \
> +			 to_ns_operations(__ns),=C2=A0=C2=A0 \
> +			 __inum, 0, __flags)
> =C2=A0
> =C2=A0#define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
> =C2=A0
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index 4438c6b663f91..20fc0d0e98212 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -55,7 +55,7 @@ static void ns_debug(struct ns_common *ns, const
> struct proc_ns_operations *ops)
> =C2=A0#endif
> =C2=A0
> =C2=A0int __ns_common_init(struct ns_common *ns, u32 ns_type, const struc=
t
> proc_ns_operations *ops,
> -		=C2=A0=C2=A0=C2=A0=C2=A0 int inum, u64 ns_id)
> +		=C2=A0=C2=A0=C2=A0=C2=A0 int inum, u64 ns_id, enum ns_common_flags_t
> flags)
> =C2=A0{
> =C2=A0	int ret =3D 0;
> =C2=A0
> @@ -66,6 +66,7 @@ int __ns_common_init(struct ns_common *ns, u32
> ns_type, const struct proc_ns_ope
> =C2=A0#endif
> =C2=A0	ns->ops =3D ops;
> =C2=A0	ns->ns_type =3D ns_type;
> +	ns->ns_flags =3D flags;
> =C2=A0	ns_tree_node_init(&ns->ns_tree_node);
> =C2=A0	ns_tree_node_init(&ns->ns_unified_node);
> =C2=A0	ns_tree_node_init(&ns->ns_owner_node);
> @@ -85,7 +86,8 @@ int __ns_common_init(struct ns_common *ns, u32
> ns_type, const struct proc_ns_ope
> =C2=A0	/* Allocate the id before the LSM hook so it can track the
> namespace by it. */
> =C2=A0	__ns_tree_gen_id(ns, ns_id);
> =C2=A0
> -	ret =3D security_namespace_init(ns);
> +	if (!(flags & NS_COMMON_KERNEL))
> +		ret =3D security_namespace_init(ns);
> =C2=A0	if (ret) {
> =C2=A0		if (!inum)
> =C2=A0			proc_free_inum(ns->inum);
> @@ -106,7 +108,8 @@ int __ns_common_init(struct ns_common *ns, u32
> ns_type, const struct proc_ns_ope
> =C2=A0
> =C2=A0void __ns_common_free(struct ns_common *ns)
> =C2=A0{
> -	security_namespace_free(ns);
> +	if (!(ns->ns_flags & NS_COMMON_KERNEL))
> +		security_namespace_free(ns);
> =C2=A0
> =C2=A0	if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
> =C2=A0		proc_free_inum(ns->inum);
