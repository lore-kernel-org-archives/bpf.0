Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F334D389
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467613; cv=pass; b=Lk3A/vV1KjkhGfT2SePBXMqzuhMbQLIhnWmn9oY+3NacxCSP0xwTjZiaLL8uSjDlqcg/YKODyPWowNAMGJUIi/pcuSvner44ySFGtrgk7Rv9DYEP1NlgAvVJmxTMPy2NrLe+QaC7AdYzBt9O4dPnl7ZUAd1yn6FjK04KuFL13sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467613; c=relaxed/simple;
	bh=oeicwxjwchcF9WqvWg1RQaqLIIuLCbf8G0N4FWHt8Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfL08Frwr5PPO3w7NpXTgg13mxttGBL4hGqOj4cMkcmO2eAu8npi6poRUgXIOojn5mOidt+mhd1XqUZtVtkcCYIifI+HUd9D39ZgvbCyEsJm/g76lm/f+nlu6SEQW+N8aK1xG6XXVawPGSi/X6Ytfko48gOLCRiSHHB8tf4s1S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qk2iy/p5; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk2iy/p5"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b467dcf0bso848147f8f.0
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 12:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774467611; cv=none;
        d=google.com; s=arc-20240605;
        b=eTXBIwwYv4hgju6a5qgmxHmAZwvubVNoQD6r/nm3wRQON/hP7TLlPDaKOMp7jn4B7Y
         jvHIPWQtVdalLFYEwa3mJLdunTzcVzFYyIF0KIh/DMLIpHdmOQr0SkEh1PXNvueHAhWV
         UQgkiuyWWAtIgEvgIuOCZHNmuMC91ip/z4ZA0zdcKn3x2ntYXbAYDBhnvIHR0RmJExcY
         /XSuRisr2yBE4W2yG/E37UJA5PA2rcff1xFn9V7UrVUmpjB2fqkCd2l0J7fdYu0MSTkS
         7LK8qadAroPUlHFbg9jd0Gp/Fwhb3nZJHFFrgtpVwnrwm+ZK3EG1xHAtyK289r7XwJyb
         llCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1jaRlaeffeDJBGaCdxhQ4LgTNj3RIqYHRelemKVaRzI=;
        fh=LW4tal2/VBYc0l0MxeNgrFyEqHJg4b+NmJhYvLofnN0=;
        b=GRtDl4nJA8Fw4JzGNpyFzZa9swtb3BLbd+Wyj/lmfgMXkve1PNvwi5zMYnN1/tIDAA
         UHGcv7O6XYGz/1xmP/D5Tr+dITVORnRecDsXxxshCrhEJuwTyEsWDjUpNjKPU5HLei9J
         04kYTqxDxjV4zV48aRIyi1AbiHuDbqSC+sim0EOcUWgm+I1oE7lIoI2KOw2o+QbS8gqU
         VASdC1L0HgMm+oFZ2q6uGb51qHTuVocMuI6Vx2YrN5HIKKHLk5K5O3U36z5+LM9/GduK
         txMobm/oK4HWcngZUUwE2/lAvbchMpOXPy0VCAF68GM522MzDW3xGTK2HW9Ut6+DOWzL
         KkGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774467611; x=1775072411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jaRlaeffeDJBGaCdxhQ4LgTNj3RIqYHRelemKVaRzI=;
        b=Qk2iy/p54elQLzB8JP2+xrdLuCL06Leb5yvd7tCXwqvJRJOB6fmelu3xzcweMSL5eK
         DdVCpx+PZCs6S4+56dn6/gS5fJG4EC4jY1LoabApjKwhKgXCKhpqzrnJ3Um8rLiIy/It
         7PWJX+JcBqMdgAvc2MFZSqnJvUW4JR0SkNUwELdDjt4o4zC5n+00/A2bubKsq6WNfEA2
         Btomix0C1N7pitC5lxxWn+AtUMWNjCuwtttJHozTLDHhiuQrnfNCYMWx452FtkTB6qHX
         tTA5v8kooQyM8eb4D7EbbuHlxdCHK5SFbPf8c7c2PbVk0fcDNgoalA29DAvSxh9FOe4N
         4Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467611; x=1775072411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1jaRlaeffeDJBGaCdxhQ4LgTNj3RIqYHRelemKVaRzI=;
        b=GzO87F4Ll5eMUjqWcApzo0As6rnYf/lrurYD6gRR3wORD7uaRu8mVaZgydjWmGw0/U
         Cvt/VJxKfh5HbviVpG9h+VXwi3pDM9BVCt1bE9DBvTuO0YNDmOs+e0wXckUy68aV7EKc
         jAxP+t3zYmmAottVJqpxd8xDeNcUwtuJTMS7Nq9XzDbduRRBXjmtDHNDxRRTVQP5ru/c
         uUwoBW+jN8yCVK4tvoaHPR4cuWVd9TGvGBpPrqvuMcBASzwdJ3PL2Eo7oQghTLxX7xum
         EaEN8wyHUB5/N5OO7vLsJVWCGgnVUBnVDUbayZIohGf1/kCLuZJdi67ZW6N9ODC2ryQE
         eccw==
X-Forwarded-Encrypted: i=1; AJvYcCVPuiHeomAo9BziYOLwP4NuB9sQiuJSYaoga85rOpM44Ez5TqW1ijXDILWJbe8KNHGNr9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhYqmageHePf3hHzMnAtmedjhbf4Yyz5LcydCLGjwfbf6jEU2W
	6eiRls0LfnDvkwMumWhfGbwnJ7Wb+S3il+6ZV22Z0OeSVE45SyBz7l57xXwEDIXnjpRu6ZRiCy8
	gonuZxrinE6rkR01hAyN0XmNyNnv831wg949LpSw=
X-Gm-Gg: ATEYQzz7Lsuzn0kylc46Tri8ci9PK5SzXrY+x5WhKwaydqvU1eV8im9mnByQJCFOCjL
	/qX9R3B2yOlIbgTnMhc6hR7exKbVzjj4P/RGCp/fk7lXhqboYTKKndxpPFjc4nH2rKHeCDx9Fvc
	okfDH2LSh94q2DHBpWqppBQnR9pJ/dYHrRFcFBRXvJhQ5zjBUndPjF5HNIZWSVFfkrDzm3z+Gbm
	IKQ1cFNLE2AtrlAzkuK3fnY+Hrdpm6ZdpIMSyZbHD/83vmjlO8Fs4q3mrKj+2lpFhw9ELOu7RPX
	sxZ1QQ==
X-Received: by 2002:a5d:5846:0:b0:43b:4703:9dd5 with SMTP id
 ffacd0b85a97d-43b883be2admr7963481f8f.18.1774467610501; Wed, 25 Mar 2026
 12:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733196.3935219.3172887920210313838.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733196.3935219.3172887920210313838.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 25 Mar 2026 12:39:57 -0700
X-Gm-Features: AQROBzCZjUmNW3mHEyd1fr7dhM1RSyURYPV4Z6yvt_FMTpVeDdj7JRXwFxnTYS0
Message-ID: <CAJnrk1YL3KnON-WtNjNi+2GZ+6rYvnVUnYwCk5efv0o41XkxcA@mail.gmail.com>
Subject: Re: [PATCH 4/5] fuse: update file mode when updating acls
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
> If someone sets ACLs on a file that can be expressed fully as Unix DAC
> mode bits, most local filesystems will then update the mode bits and
> drop the ACL xattr to reduce inefficiency in the file access paths.
> Let's do that too.  Note that means that we can setacl and end up with
> no ACL xattrs, so we also need to tolerate ENODATA returns from
> fuse_removexattr.
>
> Note that here we define a "local" fuse filesystem as one that uses
> fuseblk mode; we'll shortly add fuse servers that use iomap for the file
> IO path to that list.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h |    2 +-
>  fs/fuse/acl.c    |   43 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> index cbde6ac1add35a..f2b959efd67490 100644
> --- a/fs/fuse/acl.c
> +++ b/fs/fuse/acl.c
> @@ -11,6 +11,18 @@
>  #include <linux/posix_acl.h>
>  #include <linux/posix_acl_xattr.h>
>
> +/*
> + * If this fuse server behaves like a local filesystem, we can implement=
 the
> + * kernel's optimizations for ACLs for local filesystems instead of pass=
ing
> + * the ACL requests straight through to another server.
> + */
> +static inline bool fuse_inode_has_local_acls(const struct inode *inode)
> +{
> +       const struct fuse_conn *fc =3D get_fuse_conn(inode);
> +
> +       return fc->posix_acl && fuse_inode_is_exclusive(inode);
> +}
> +
>  static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
>                                         struct inode *inode, int type, bo=
ol rcu)
>  {
> @@ -98,6 +110,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentr=
y *dentry,
>         struct inode *inode =3D d_inode(dentry);
>         struct fuse_conn *fc =3D get_fuse_conn(inode);
>         const char *name;
> +       umode_t mode =3D inode->i_mode;
>         int ret;
>
>         if (fuse_is_bad(inode))
> @@ -113,6 +126,18 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct den=
try *dentry,
>         else
>                 return -EINVAL;
>
> +       /*
> +        * If the ACL can be represented entirely with changes to the mod=
e
> +        * bits, then most filesystems will update the mode bits and dele=
te
> +        * the ACL xattr.
> +        */
> +       if (acl && type =3D=3D ACL_TYPE_ACCESS &&
> +           fuse_inode_has_local_acls(inode)) {
> +               ret =3D posix_acl_update_mode(idmap, inode, &mode, &acl);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         if (acl) {
>                 unsigned int extra_flags =3D 0;
>                 /*

I think this sentence in this comment block "Fuse userspace is
responsible for updating access permissions in the inode, if needed"
needs some updating now, since this is only now true for non-local
fuse servers

> @@ -139,7 +164,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dent=
ry *dentry,
>                  * through POSIX ACLs. Such daemons don't expect setgid b=
its to
>                  * be stripped.
>                  */
> -               if (fc->posix_acl &&
> +               if (fc->posix_acl && mode =3D=3D inode->i_mode &&

Maybe a bit verbose but imo it'd be clearer if we had a separate
boolean tracking the case where the kernel updated the mode bits,
instead of using "mode =3D=3D inode->i_mode" here and below for the
fuse_do_setattr() logic block. That makes it more clear here to reason
about (eg it'd at least make it more obvious here that we don't need
to strip sgid since the kernel already did that when it updated the
mode bits earlier)

>                     !in_group_or_capable(idmap, inode,
>                                          i_gid_into_vfsgid(idmap, inode))=
)
>                         extra_flags |=3D FUSE_SETXATTR_ACL_KILL_SGID;
> @@ -148,6 +173,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct den=
try *dentry,
>                 kfree(value);
>         } else {
>                 ret =3D fuse_removexattr(inode, name);
> +               /* If the acl didn't exist to start with that's fine. */
> +               if (ret =3D=3D -ENODATA)
> +                       ret =3D 0;
> +       }
> +
> +       /* If we scheduled a mode update above, push that to userspace no=
w. */
> +       if (!ret) {
> +               struct iattr attr =3D { };
> +
> +               if (mode !=3D inode->i_mode) {
> +                       attr.ia_valid |=3D ATTR_MODE;
> +                       attr.ia_mode =3D mode;
> +               }
> +
> +               if (attr.ia_valid)
> +                       ret =3D fuse_do_setattr(idmap, dentry, &attr, NUL=
L);
>         }

I think this logic reads clearer if it's restructured to

if (!ret && mode !=3D inode->i_mode) {
    struct iattr attr =3D {
            .ia_valid =3D ATTR_MODE,
            .ia_mode =3D mode,
     };

    ret =3D fuse_do_setattr(idmap, dentry, &attr, NULL);
}

>
>         if (fc->posix_acl) {
>

For local / exclusive servers, the kernel already has / sets the
refreshed attributes, so we could probably skip the invalidation logic
here for that case since the cache is already uptodate?

Thanks,
Joanne
