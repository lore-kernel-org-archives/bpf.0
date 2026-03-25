Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BB3358B9
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463766; cv=pass; b=gJXMk6c7FZMnHKzPc6NM0j7OYLNt0OWJXqV2Ka75pr9GquPhntuzUSXPPHZTOyVW8E78XAdMdXKw2SH4AgrNinJafuj5mGG16RW/WK4MY3vymX/8rFhhzPdVs1DPqQi7GDI5h8+Omzr0DN8vsPQ/gXkk9ufbf5PZbG9+mjYdfT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463766; c=relaxed/simple;
	bh=DU09dneRr/GRbp2qrwsAbEux7gUhzS7AtKG/4sqMSBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kigL0R7ILNtNeiUGRkLP3MNMHo8GBM19v69Hj9yJ2V16eFdwlBuucZGr3Fdpm0p5fFcJoNeDhMjC9pbJ5Qt0g3oxFLB2Kq27m9iHfh6/YK5Oz7gQRTYfwTADvYgBeUJD/Aka3gTmTfZF0u7tk4lHEZYhkcPj/ChaFu1+ZLvkiJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYj9J+tR; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYj9J+tR"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b48ac2727so77008f8f.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 11:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774463759; cv=none;
        d=google.com; s=arc-20240605;
        b=jk71Y6nc+tsFOTPR1lH5YyrKwp8mpDHNBP2vEZhQtfgvh6BxGMGOqsRoWuo/jESLfp
         dMlhG69gCHlDIF8i94eiLh4j1jo21CdM65j6sXoEQIAr8afGKFXvlk4prL3PrYV94ixv
         wi8FhfSoPi7Pj91o6bQjPQLK2i6kANY3E6UhlFxgcGyBCBhyPMJnDHxennpcelLbwue5
         6tSywl0HuuFmPhF5E08FLj072BYf1kzfXxgR/uXWDERQzxxChjkGDAa3KYzrvIrabXic
         Arl73ULHQOQ9kOswwqXMRihRB4Se59h5Owc4wpOz5hC6cljc/kzieWZKKJJPv+ZQv+NL
         GMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9QtV8GBTb6YR4jdqHUX7Sv2eVsBl1fbWiLDxSj4EukQ=;
        fh=4QWkRdx3K+0qJCZLtN+luFvkoalcc6pSnfCMbWRfn1k=;
        b=hZmqLF//goGQHizwC9gIR+gyIOg9FcTUmzprq+OR5Y/nDGt0KJKKi4tt1l/OZztzlU
         g2lJxysgYd+4awp0tWXrWwrER42R/YQxXH4eDAkhbol0V/sk3tnyzwkNmzsdNMKUg3XN
         IDkgdgXrUw/xCuoi6TRw0vNfmpYc1x7tU8sYvqtpJcW/EcNqRw9SoOC5FdaaQs4Jh+6j
         xDTchrxsScMXeHreUQZOrxd766WtVextkU3kmxMqfyNiRa64XIU7XzqV9j41XrhRrIRy
         4Z/wYuMkA3akYc0tOTSAlKBdkHT/+Nf2X5WT9qOl+Y5lsTkNiFxhAP8dcEiiFHrbldOB
         DCJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774463759; x=1775068559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QtV8GBTb6YR4jdqHUX7Sv2eVsBl1fbWiLDxSj4EukQ=;
        b=VYj9J+tRwEhyTKu1jFztIIyyKnSDqOC+nG/430snVSAMKZ23q3hy+/SYZlM77fAD43
         E0PZ5FG6eiApjsCDYocstimrEeDBoQ5UlxRPdT7k/PiHutdlTGzN2FHJrQSCe2rnP09/
         OARSS14vSE/zkQXqPAxP//9aclw+5uvv6/g8NELs8z/XKedJ96lKjOHcmzhGN7bRoI7F
         nj/rqFYtA0qMq5gq9nFt+wuxkMPL13zAh1Pdx36ImO2BdFb7P2YmO9Y+24fAu81Cg8sB
         M2VCdB97L+oxY+5+rZV73XMAGiPSbNRbEi6o2Shqh+6Bnk1vo2uhfDbgFIK8xaxZ1hBB
         VFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774463759; x=1775068559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9QtV8GBTb6YR4jdqHUX7Sv2eVsBl1fbWiLDxSj4EukQ=;
        b=I5XI0IB/+ww1vJOQahqDtoFrVDEJu1gHfX4v9OeEbcVv5pKfFVE9r1wXrTVOHKuImQ
         jUy6grZdNzPGnwO62AwnkLNjbT45ab6cPJTZjqKbq6iaYJFNqVrSaWn9lSreNYrQRh0o
         fV12XoXued6Fl74LhWhmrXSD1hHAU5IqX+VaOGUv/uGQyIoMgWDe8V7stRHs3QDi7RZp
         ScpaWcNASNVtiwa8usihKKWA8bFZTq8SM/cj1Hpm1yzuLNOTgAZl0HYzXNBV6As8JiNX
         CeltF2Shrhrl1tNDpO/ImQ+KiJuzAvb51ViN2AqGGXz+58OLMi8U5EHmhObCatCxRFvL
         XJWg==
X-Forwarded-Encrypted: i=1; AJvYcCUvCb/HUq0l4GzHEj+JeDz7emENPFiqvYPBKdRN/fA4FjDVHZYbL6rSjFgwlAgPlRSNoUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNmU4TNTpPMU1loK49zPgc/qvHNZwKAplBi4UQn6bSh+Fj59/U
	hU5Se+a2QyMvBYzudoMcgPCANtaruvN8MIFQUfZJVX598iHMqZCUZpfSpXsbD9fOTET0SkXKI0h
	LM194mmaIOttLqBWWGdxor8hD5ujfNqI=
X-Gm-Gg: ATEYQzz/uS4JnE52x7CvKdO9nwbAgTmA836a9WyWOv4bni2aT5aji9SvWaC1GYBokTL
	5PkyrIMINmb8uJWpHPCGAerxGVEIKON7Tuaag9im3gWfqZydjfkdg2ufO8TY1b+wH35aC4eEPSy
	N7v/7mqO50Aco8XnG182jHXsy2PQcFI8QsC0UlMQOi7+oVYM8eAT+tEW2LmwQKi1R77Po8POe/E
	OEWOiLtlV8gtVkQ8Mdvr6f2aJiNKN7lfdQXhaPnLygA5tF83lzG15/R4K/X0nxdMnZp7IiPfjqr
	uK1ttw==
X-Received: by 2002:a05:6000:4381:b0:439:b6f1:cd8d with SMTP id
 ffacd0b85a97d-43b88a100a3mr6484733f8f.28.1774463758965; Wed, 25 Mar 2026
 11:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733175.3935219.14499232455997407711.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733175.3935219.14499232455997407711.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 25 Mar 2026 11:35:47 -0700
X-Gm-Features: AQROBzAsyuIOQL6cuDHl9wKI-61KU4hUBnmgoj2gOGt1Tina83tHjQ4Mtdg7-gk
Message-ID: <CAJnrk1ZZV=nf2ZvsFz2gCEdFanK2c=_4X8hH5PyZ4ys-b5T8kQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bpf@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 3:07=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Actually copy the attributes/attributes_mask from userspace.  Ignore
> file attributes bits that the VFS sets (or doesn't set) on its own.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/fuse_i.h |   37 +++++++++++++++++++++++++++++++++++++
>  fs/fuse/dir.c    |    4 ++++
>  fs/fuse/inode.c  |    4 ++++
>  3 files changed, 45 insertions(+)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 1d4beca5c7018d..79793db3e9a743 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -147,6 +147,10 @@ struct fuse_inode {
>         /** Version of last attribute change */
>         u64 attr_version;
>
> +       /** statx file attributes */
> +       u64 statx_attributes;
> +       u64 statx_attributes_mask;
> +
>         union {
>                 /* read/write io cache (regular file only) */
>                 struct {
> @@ -1236,6 +1240,39 @@ void fuse_change_attributes_common(struct inode *i=
node, struct fuse_attr *attr,
>                                    u64 attr_valid, u32 cache_mask,
>                                    u64 evict_ctr);
>
> +/*
> + * These statx attribute flags are set by the VFS so mask them out of re=
plies
> + * from the fuse server for local filesystems.  Nonlocal filesystems are
> + * responsible for enforcing and advertising these flags themselves.
> + */
> +#define FUSE_STATX_LOCAL_VFS_ATTRIBUTES (STATX_ATTR_IMMUTABLE | \
> +                                        STATX_ATTR_APPEND)
> +
> +/*
> + * These statx attribute flags are set by the VFS so mask them out of re=
plies
> + * from the fuse server.
> + */
> +#define FUSE_STATX_VFS_ATTRIBUTES (STATX_ATTR_AUTOMOUNT | STATX_ATTR_DAX=
 | \
> +                                  STATX_ATTR_MOUNT_ROOT)
> +
> +static inline u64 fuse_statx_attributes_mask(const struct inode *inode,
> +                                            const struct fuse_statx *sx)
> +{
> +       if (fuse_inode_is_exclusive(inode))
> +               return sx->attributes_mask & ~(FUSE_STATX_VFS_ATTRIBUTES =
|
> +                                              FUSE_STATX_LOCAL_VFS_ATTRI=
BUTES);
> +       return sx->attributes_mask & ~FUSE_STATX_VFS_ATTRIBUTES;
> +}
> +
> +static inline u64 fuse_statx_attributes(const struct inode *inode,
> +                                       const struct fuse_statx *sx)
> +{
> +       if (fuse_inode_is_exclusive(inode))
> +               return sx->attributes & ~(FUSE_STATX_VFS_ATTRIBUTES |
> +                                         FUSE_STATX_LOCAL_VFS_ATTRIBUTES=
);
> +       return sx->attributes & ~FUSE_STATX_VFS_ATTRIBUTES;
> +}
> +
>  u32 fuse_get_cache_mask(struct inode *inode);
>
>  /**
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 7ac6b232ef1232..10fa47e969292f 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1464,6 +1464,8 @@ static int fuse_do_statx(struct mnt_idmap *idmap, s=
truct inode *inode,
>                 stat->result_mask =3D sx->mask & (STATX_BASIC_STATS | STA=
TX_BTIME);
>                 stat->btime.tv_sec =3D sx->btime.tv_sec;
>                 stat->btime.tv_nsec =3D min_t(u32, sx->btime.tv_nsec, NSE=
C_PER_SEC - 1);
> +               stat->attributes |=3D fuse_statx_attributes(inode, sx);
> +               stat->attributes_mask |=3D fuse_statx_attributes_mask(ino=
de, sx);
>                 fuse_fillattr(idmap, inode, &attr, stat);
>                 stat->result_mask |=3D STATX_TYPE;
>         }
> @@ -1568,6 +1570,8 @@ static int fuse_update_get_attr(struct mnt_idmap *i=
dmap, struct inode *inode,
>                         stat->btime =3D fi->i_btime;
>                         stat->result_mask |=3D STATX_BTIME;
>                 }
> +               stat->attributes =3D fi->statx_attributes;
> +               stat->attributes_mask =3D fi->statx_attributes_mask;

Do these need to be |=3D so we don't overwrite any vfs attributes stored
in stat already?

Thanks,
Joanne

>         }
>
>         return err;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 58c3351b467221..ff8b94cb02e63c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -286,6 +286,10 @@ void fuse_change_attributes_common(struct inode *ino=
de, struct fuse_attr *attr,
>                         fi->i_btime.tv_sec =3D sx->btime.tv_sec;
>                         fi->i_btime.tv_nsec =3D sx->btime.tv_nsec;
>                 }
> +
> +               fi->statx_attributes =3D fuse_statx_attributes(inode, sx)=
;
> +               fi->statx_attributes_mask =3D fuse_statx_attributes_mask(=
inode,
> +                                                                      sx=
);
>         }
>
>         if (attr->blksize)
>
