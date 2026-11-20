Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183363;
	b=t8IT8cviPYN9MNSQ7vWuCg5CE5g4MTqz3CjhiM6xNt2IzmblyR/g9ELo7TYHLXfvUODv
	 S2K42tMB4Ucd9HdZI1yJSqqVqPEuKFpxcZ5IFh08JuSNOGHIbc7+HGOt4Yb9hrnFPzrVt
	 lbHvtY1WQqZHEBbXfNHeo6usqTGMOkAZJ5KxYjfi21kXKcwacTJgKPQJPn9t6xdYgk1l6
	 36/9Oaast19OCcmhDECZTnM3UiQ7c4MqdM5Na071UEtoL/qdV+atrX5/ilcOnsnZ/MdVv
	 0Zg8QySb4tlLIsLqt1gmT48AXMWQtFCfD0RdmKjwvXaY7oseHYh8WfL+4WFiEjsz2oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Rt0RtCssS6m9x3qIGE05pU4mRxZ/g5pdTkvBx4YxX0M=;
	b=tVVHJDc3aamDFWE4smSUX/Fuy+KeyCDDQ+C90DbjKUvFc7wvA7xpn1Og4n2y84MmNPL5
	 kNzixI5zvWqOAVyWdmT8Iz/388cT73WXSL+nZFz84UtiEziC85HK5JfPYh2+693BhVBed
	 NX7HVbEZ6K0OLY9jh/MY2RGNTEJAYRIQ9M+Y5GEaNiOb6NlhhGMMrvJDmb+MVOjNdZPx+
	 SB5nXM+7zi1L7Ys3P3CReDgfE56ztnpVD5WVJ27QpwgfRPpFdX5TBQ0+eKaYprxUhxl63
	 b75bc2txHKCMXITPY/e8DgkCwYxQyFKkl14XgVEDohlbF7rdK913m1s0yMZ0O7qLiaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="LtzukpA/";
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00E606A326
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 14:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB00E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LtzukpA/
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so427162166b.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795183360; x=1795788160; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Rt0RtCssS6m9x3qIGE05pU4mRxZ/g5pdTkvBx4YxX0M=;
        b=LtzukpA/0jvvfr5IGHmG5eW/AvDJ5zy/rQ6+dvM4F2RpJAWjNLDa2Y4G8e+sqh3/D1
         fjBZpl8QQS7+jyRSThKW3091/kr/97HWHpQl5AGvlH+SL6p/BJUMJ7GLqbXaHE4sfY3o
         SE7YIky4Qxsupb42QS8OsBGTQ2x6Rt4W7bBX2Y021GvNAYGzW0+TXQqTOCjI6etMkIdr
         yZ4JsLbV17sU1Phs1U08GZpsGfz8eRPN9Tb7qqLc5E928B8EMhwPPaYxN0/J7TV5cHCU
         EApaErnhp7rWGukwpBhVDkD2jx3q2rWdm+thPH+86/Wep9jsPjn4GOyKrjXlCWbnVr2s
         81yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183360; x=1795788160;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rt0RtCssS6m9x3qIGE05pU4mRxZ/g5pdTkvBx4YxX0M=;
        b=CSGkAZp0FhcR+DqskWJV3QIsUv5jSA3y806PfHLmSuPNK3lmPzcF8Gxeh0hLT/U4Oo
         XH7ga9YWvmFjVwiiW9BO9q8cjCCHsNF9WPhQ8i5NN11jnQ0/WwYShjCjBccJu5UHK1Cw
         xKJcA6JQAIAovA1EQCWtw0qD6751eVPBGuCUvObw+IMWfoHrNHWm9B6hQrrhHnkbyKnq
         oV0nVK5eLXsr2GW6zVE2qbz1Kp2yPFSCK6cIpqlC40KE3ZEB1J90zQU45yFvTR65AAxI
         suXYg44PNBJm8e7oFKeyTOxZHR1i4oyeMwqmJxpravcXYKhK4pHIL8+v1TfMjrZYU4Cc
         5Ogw==
X-Forwarded-Encrypted: i=1; AL+hErGnV5O+R+xpvGb5tcPEW8gD2wc3umDKiy0P5Ia/Vh+pDtlMe5a+qD+ZDQJxZNUYZLFJAOM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pSx57zMpjKWmVZS7tf3QSD2ybzctV4EE4o4c3d20gwPv5sPgR
	ZX8VeEOMbOEcRakWFk7bDcdBuPGr9Qf1l8BpytEUhlsfVvgg6U7BJkWvuOBnM/AQL5F9
X-Gm-Gg: AYBFou2iooLamjwYwhwtOQDsZ0HfMk22Cb/bHY2kkWDz6TL8Klrl3mUcK7fKmL7qERy
	FJfc03XpkHFNzKWfT5mxOzxbnOkeRIWoiMmRXxZyZ+ncYRreA1GsHSN4c7+Os6ER7OQ63z9rlrI
	XvSGI48U6WlWVctS/xM6ro480uKCLUhg+PmL+6AyAWlZP5foCPB7tjXH4ZbkMcDOS2gJCyWsxkg
	V+qSvtFz2rJO6h1yQ5h9HDECFcKtRg9n2HXfg2D4OALJ2lX/roqr1wNhy0evi9SFasTiR5NzR8q
	sr0gYFnl8mKFcUFK/tDQmASjwBSdgbDrI/4sdrXqcucBbWHgTzF74rWX+YUQVWCClqPJLENfkXH
	pwoDzJLLE2EZqzgFX2Fn2MBCi3MwuBIOy810nGF82qXZNtfEMfu3LFj06HMU2N8svss6WQNEWKL
	yPRNjTjPDSpOlPPOCkYPjgoytUsuoGhwYgfxdI9I1e5WJpsBPLXa9utxo60N+pB2v+7dXdFFCUf
	ilyegi9sPfuTUaQ2SbB1wSvRcpz9NwiuKglpmfdJrIqKlVickAdU55WzUKsWCgvU3+P76pAdXRw
	ClMkOtpKVKCNtLooPtMQEnqS21oY172EN5qFvlthRI8va8pwxUs24Ainrj2ZkOB5dA==
X-Received: by 2002:a17:906:184e:b0:c51:b2d:acf4 with SMTP id a640c23a62f3a-c513a856e78mr234468166b.14.1795183359156;
        Fri, 20 Nov 2026 06:02:39 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-188.customers.d1-online.com. [80.187.84.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae6780esm99588766b.17.2026.11.20.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:02:38 -0800 (PST)
Message-ID: <a999a6a9f593638228c93f90aec7425a0c6a8215.camel@amutable.com>
Subject: Re: [PATCH 1/2] mount: pass flags to alloc_mnt_ns()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org,
 Zhiqi Zhang <zhiqizhangg@gmail.com>
Date: Fri, 20 Nov 2026 15:02:37 +0100
In-Reply-To: <20261120-work-ns-mount_subtree-v1-1-06337377f94a@kernel.org>
References: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>
	 <20261120-work-ns-mount_subtree-v1-1-06337377f94a@kernel.org>
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
> Turn the anon argument of alloc_mnt_ns() into a flags argument. The
> next patch needs to pass another property of the new mount namespace
> and two booleans in a row would make the callers unreadable.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/namespace.c | 24 +++++++++++++++---------
> =C2=A01 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index aecd05ac01705..756f9011cbf1d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2353,7 +2353,12 @@ void drop_collected_paths(const struct path
> *paths, const struct path *prealloc)
> =C2=A0		kfree(paths);
> =C2=A0}
> =C2=A0
> -static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *,
> bool);
> +enum mnt_ns_flags_t {
> +	MNT_NS_ANON	=3D (1 << 0),
> +};
> +
> +static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *,
> +					=C2=A0 enum mnt_ns_flags_t);
> =C2=A0
> =C2=A0/* Consumes the caller's reference to @mnt. */
> =C2=A0void dissolve_on_fput(struct vfsmount *mnt)
> @@ -3149,7 +3154,7 @@ static struct mnt_namespace
> *get_detached_copy(const struct path *path, unsigned
> =C2=A0	struct user_namespace *user_ns =3D mnt_ns->user_ns;
> =C2=A0	struct mount *mnt, *p;
> =C2=A0
> -	ns =3D alloc_mnt_ns(user_ns, true);
> +	ns =3D alloc_mnt_ns(user_ns, MNT_NS_ANON);
> =C2=A0	if (IS_ERR(ns))
> =C2=A0		return ns;
> =C2=A0
> @@ -3230,7 +3235,7 @@ static struct mnt_namespace
> *create_new_namespace(struct path *path,
> =C2=A0	if (foreign)
> =C2=A0		copy_flags |=3D CL_SLAVE | CL_COPY_UNBINDABLE;
> =C2=A0
> -	new_ns =3D alloc_mnt_ns(user_ns, false);
> +	new_ns =3D alloc_mnt_ns(user_ns, 0);
> =C2=A0	if (IS_ERR(new_ns))
> =C2=A0		return ERR_CAST(new_ns);
> =C2=A0
> @@ -4369,7 +4374,8 @@ static void free_mnt_ns(struct mnt_namespace
> *ns)
> =C2=A0	mnt_ns_tree_remove(ns);
> =C2=A0}
> =C2=A0
> -static struct mnt_namespace *alloc_mnt_ns(struct user_namespace
> *user_ns, bool anon)
> +static struct mnt_namespace *alloc_mnt_ns(struct user_namespace
> *user_ns,
> +					=C2=A0 enum mnt_ns_flags_t flags)
> =C2=A0{
> =C2=A0	struct mnt_namespace *new_ns;
> =C2=A0	struct ucounts *ucounts;
> @@ -4385,7 +4391,7 @@ static struct mnt_namespace
> *alloc_mnt_ns(struct user_namespace *user_ns, bool a
> =C2=A0		return ERR_PTR(-ENOMEM);
> =C2=A0	}
> =C2=A0
> -	if (anon)
> +	if (flags & MNT_NS_ANON)
> =C2=A0		ret =3D ns_common_init_inum(new_ns, MNT_NS_ANON_INO);
> =C2=A0	else
> =C2=A0		ret =3D ns_common_init(new_ns);
> @@ -4394,7 +4400,7 @@ static struct mnt_namespace
> *alloc_mnt_ns(struct user_namespace *user_ns, bool a
> =C2=A0		dec_mnt_namespaces(ucounts);
> =C2=A0		return ERR_PTR(ret);
> =C2=A0	}
> -	new_ns->is_anon =3D anon;
> +	new_ns->is_anon =3D flags & MNT_NS_ANON;
> =C2=A0	refcount_set(&new_ns->passive, 1);
> =C2=A0	new_ns->mounts =3D RB_ROOT;
> =C2=A0	init_waitqueue_head(&new_ns->poll);
> @@ -4422,7 +4428,7 @@ struct mnt_namespace *copy_mnt_ns(u64 flags,
> struct mnt_namespace *ns,
> =C2=A0
> =C2=A0	old =3D ns->root;
> =C2=A0
> -	new_ns =3D alloc_mnt_ns(user_ns, false);
> +	new_ns =3D alloc_mnt_ns(user_ns, 0);
> =C2=A0	if (IS_ERR(new_ns))
> =C2=A0		return new_ns;
> =C2=A0
> @@ -4509,7 +4515,7 @@ struct dentry *mount_subtree(struct vfsmount
> *m, const char *name)
> =C2=A0	struct path path;
> =C2=A0	int err;
> =C2=A0
> -	ns =3D alloc_mnt_ns(&init_user_ns, true);
> +	ns =3D alloc_mnt_ns(&init_user_ns, MNT_NS_ANON);
> =C2=A0	if (IS_ERR(ns)) {
> =C2=A0		mntput(m);
> =C2=A0		return ERR_CAST(ns);
> @@ -4699,7 +4705,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned
> int, flags,
> =C2=A0		return FD_ADD((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC
> : 0,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_new_namespace(&new_path,
> MOUNT_COPY_NEW));
> =C2=A0
> -	ns =3D alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, true);
> +	ns =3D alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns,
> MNT_NS_ANON);
> =C2=A0	if (IS_ERR(ns))
> =C2=A0		return PTR_ERR(ns);
> =C2=A0	mnt =3D real_mount(new_path.mnt);
