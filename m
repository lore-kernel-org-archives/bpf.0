Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754078;
	b=uzX5SA6dV72MdMR60uofOZJZA8izh8y7D1L7UZXa5jB0SgEyyBlotdnP5rlh3L6HH6JT
	 O0Hnva5zTGM+rwPZv2a12Wgz1qA+QsHsDJoOwgguNyiq43u/dp/2BSb6hZzkrPH0QKXV7
	 tPTe19CSk5dJgzb0eW5Ihdf47X5KorJimHuzSOppP8yq+6dhfxtEUxGlKBl4SeSIE84dm
	 hYLKhbALWH+YWnVZobk1sE/Hnf7OnQkxV5/kfxmH/v41m9SLhe5HbUVubcjJ9ODD+ewPk
	 PFsWJVOoN4RmwW5PrOW4RPNcFsZkQfPuWJUNBV+qFFkedjLw/v4cQ8v2u6WxcNGf0RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
	b=zxI9I9Etn99AufjFIfmW9gRHaa9JCyZn4RRZneeK1KIDh+isUBvy72ZQXy3C0eyXR1c1
	 1tfJmxyIo7yUHHY8qmQ1ihpWdEzyNqx2a4DiRvBCUqA2wLweHCFTDMNlNjnwMhaJ5c4TH
	 Y32OCPVD02Gdh+bYMUzZiUtPBwOZXie5GpmSteV1cOVpSbgJJKi5HN73l54vxVkOYPHV4
	 O8wcqljqjM8xTqqgRCtSnLVs4ecOoW71DDl4J69qm6dtinJluuRjFZXyeKMSu9+RLO1n0
	 DPkwlNN9aVVFw/+d4isxUrKfK9BGhdKfYivq/MpXU8VZQvnkkc3cf5j7EKRAHN+LGwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vdeJy6VC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912B606A323
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 14:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2912B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vdeJy6VC
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b5973a4b4cso3656520a12.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 06:47:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754076; cv=none;
        d=google.com; s=arc-20260327;
        b=coLA5/JterRQnKT+mFW6umFvpeYjheSe6bD+aZrM/+hWumF8C9Srgvpq8R3JUimYZU
         YV1RkI8AG7nIKPgbyQZ3+gj9283gWwUPh1/27o4VS1LEPmdauORbnliSz4nRUG62cvgv
         XQlld5JVJG0GFsjlVq9cnIVnKYqqcaemx8oY1uRX2uX9K0WIPKwrDLFz9jgJLLxJZP7+
         glViRUOdMstZzd8XdBXGo97tatm0Wd6Rq6sSYhcT03dXBqNM1aUknjLFLpVKTA1NKgmx
         zFt49ZluSX3RuUzx5KdDdAIMsXKwyusA1xAIxFMGJcE0rVqaOMJnfduA3NomALseQ+Jo
         EDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        fh=gFqrD1ZEnlpJmk7y+H+kEoo0qRCI2SCUl9CzkxE9Up8=;
        b=XyleEgWV1th7qr3HdPKNA7fpuXAfZaH4VkQ/I6zkhFjMsTeIig4jg6LiPzLe8Po9yF
         vSfQgqlrJdUiImeAlRUlHDVZZgSeCFSOnvkJLJDuveNhxxtEFgYax4cWemnW49kN0/ji
         t4pZbxr/ThEkunhv1zWGRxhPVQZG0tjbjUEOTB5rsoXrc54qb1Abi9es0jYyRbQSGkQv
         LzTV/iuKz5dzg2GXU7udeYMdWlVN9q3x95+zwscVpQQWzJ58J8K1Th0YEJM9yCfI9nKN
         RFWNllugPTevvBaDeD47P6YxFiGOGDqlyEqEdX1X9UMHmT4Hk4oR26fC5bk/oo8gnObS
         Qrhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754076; x=1795358876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        b=vdeJy6VCk2IGRpnrLWlGo4pWLhKneS7IPoBk81bLTW0iD2g50lPI0We72sIkSM0SV6
         cyTbNZB4O3d6VzvDDG9DPV5xAXhxmw4YkAyPQvdWI1M8aVPLRajltXh2AQAOKJY1EPeA
         J/3fQzDOEdKdl4Og0NnAs1e+UKlTuJcD65e+vWcNglfpyVM0bRYj3j545Ccvj/p07kIf
         RJxqw4iAkOZDz6lvhqxGAdC4rSJXKnOPRkFB2PlSiergeTKJSozBYsIqbEfROUxsRiwA
         +nC6LR2BKa2t52tGscFSOG6fqqncSzV6SKT9uOygWHxo9fsmCNg/KFWBsER32dA/LqAU
         Q4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754076; x=1795358876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        b=ox+TXM29yrZsu0Q1yMJcKqMUKTKrXRlgFMSY57BDsy86Hbi9peUAyz6/4MUZIJgnAE
         IXPj1ca8dqBfDZukvUZ7/FBV8tfXqTYXVmJOzBV+IlMJutPUtdzWQDM9NZDPlcxbPToT
         5QWieg/+31IQEPVOUTgt6HyDgS9zcM8Dz0oqWwYiz+yGNrGSegziv0arJlKeYzepA7Bg
         b5rwhBhlsEb24ZqlQvIMi5GLUypHGgVdK7GQOeXwX6EnV5wyt6uPR2zEYKAw7/P8kkrf
         LLK8o5pWnzHLNttyEppojpljbDxElgiYvAbaa4SwwuSKwCQoMzCdidKwityh5FryJEcK
         e/Gw==
X-Forwarded-Encrypted: i=1; AL+hErEJYG5O0FYjaQvG7VKdq1/YzDnlxl56L0gLHO1sd1JMhNHN4mxMCr93Ew4muGITYw6y33A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SxwYi7H/c9I8L8o+0chf7VzP68F9Uw6iPh24yoxfw+jYSGWp6
	u1BNAvRWrMQpRdCpJ9evy7PuD1/MDSzZ5DDO6aUSjqMWm3yJkps2CCQKLEruiq3kiFUOcaK8w7E
	7tS7TOlTtv+lz6M6tfOP54V/7ZomwLfY=
X-Gm-Gg: AYBFou0/EePQzO9rWISTpweRQrCAJZiGykybhk9tJIS/l4vm2iL1wtX4Vl5haxL9awj
	cFExPona+0Q3lj/9ELEAuvDg5TbOI0YILkvj/8dLGY0LN9i/O0Uy32SqGLjI6muJdRH8suA/gd3
	Mh+naSEAtLOK2ZjgTTeYcv2N4jtblB+E0fGL1Vk534Te9JNqT4vML8totEZYmWEL0AS5Pkqsc6M
	YRhYzf9/iHofoDH5ZSfXN9SiCCU7962dnWbFAKP+EYA23xMtWKPd/jUkxlgaUujDzhHP6aGIOYd
	ePMoGJrj9iU2T8Zn1aKNGsdv+wHlnOpxxM+wAJIzCiDstYYI/mOxHBBo/WtXNR9RxlCGRj1FZ7J
	M2ExBKXJFff0WXyBwb3j11vz5SenaVPfgsaiMKROWMvPwRP0gWjAv9CWfb/qhn5BVGvrqtg==
X-Received: by 2002:a05:6402:1d4c:b0:6b7:e12e:7f1f with SMTP id
 4fb4d7f45d1cf-6b7e12e824fmr3426650a12.10.1794754076394; Sun, 15 Nov 2026
 06:47:56 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-10-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-10-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:47:45 +0100
X-Gm-Features: AclHuK_at8qVhKBNN0WXPGQ7F2lmyjSQgMjlfNE9nQtuQriTEXeBZE7dwGmSTD8
Message-ID: <CAOQ4uxggW+UifxBJDY8fAb+g5EWrsD+rELwXa1ngZ_5X_OZx0g@mail.gmail.com>
Subject: Re: [PATCH 10/13] ovl: return the error from the lazy lowerdata
 lookup in ovl_d_real()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> All callers have been converted to d_real_data_inode() and handle an
> error now. So return the error from ovl_verify_lowerdata() just like
> ovl_open() does. The lowerdata dentry missing after a successful
> ovl_verify_lowerdata() would be an overlayfs bug, so keep warning about
> that but return -EIO like ovl_open() does when it has no real path.
> D_REAL_METADATA never looks anything up and still can't fail.
>
> Update the comment in ovl_d_real() and the documentation of d_real() in
> dcache.h and vfs.rst accordingly.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Nice!
Thanks for cleaning up this mess.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  Documentation/filesystems/vfs.rst |  6 ++++++
>  fs/overlayfs/super.c              | 17 +++++++++--------
>  include/linux/dcache.h            |  6 ++++++
>  3 files changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystem=
s/vfs.rst
> index 1824462a43711..6953f399672f3 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1374,6 +1374,12 @@ defined:
>         for returning the real underlying dentry that refers to the inode
>         hosting the file's data or metadata respectively.
>
> +       For D_REAL_DATA the filesystem may have to look up the data first=
,
> +       e.g., for a file that was never opened.  If that fails an ERR_PTR=
()
> +       is returned and callers must handle it.  D_REAL_METADATA must not
> +       fail.  Most callers should use d_real_data_inode() or
> +       d_real_metadata_inode() instead of calling d_real() directly.
> +
>         For non-regular files, the 'dentry' argument is returned.
>
>  ``d_unalias_trylock``
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 1985b553a47b7..39d4d57dec230 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -42,7 +42,7 @@ static struct dentry *ovl_d_real(struct dentry *dentry,=
 enum d_real_type type)
>         }
>
>         if (!d_is_reg(dentry)) {
> -               /* d_real_inode() is only relevant for regular files */
> +               /* d_real() is only relevant for regular files */
>                 return dentry;
>         }
>
> @@ -57,17 +57,18 @@ static struct dentry *ovl_d_real(struct dentry *dentr=
y, enum d_real_type type)
>         }
>
>         /*
> -        * Best effort lazy lookup of lowerdata for D_REAL_DATA case to r=
eturn
> -        * the real lowerdata dentry. Callers may ask for files that were=
 never
> -        * opened, e.g. for uprobes or O_PATH files, so the lookup can fa=
il
> -        * here. Return the overlayfs dentry then.
> +        * Lazy lookup of lowerdata for the D_REAL_DATA case to return th=
e real
> +        * lowerdata dentry. Callers may ask for files that were never op=
ened,
> +        * e.g., for uprobes or O_PATH files, and the lookup or the verit=
y
> +        * validation can fail. Return the error then, just like ovl_open=
()
> +        * would. Callers of d_real() have to deal with that.
>          */
>         err =3D ovl_verify_lowerdata(dentry);
>         if (err)
> -               return dentry;
> +               return ERR_PTR(err);
>         lower =3D ovl_dentry_lowerdata(dentry);
> -       if (!lower)
> -               goto bug;
> +       if (WARN_ON_ONCE(!lower))
> +               return ERR_PTR(-EIO);
>
>  real_lower:
>         /* Handle recursion into stacked lower fs */
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 674bc50b81827..5b3b34d271bd0 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -638,7 +638,13 @@ static inline struct inode *d_backing_inode(const st=
ruct dentry *upper)
>   * If dentry is on a union/overlay, then return the underlying, real den=
try.
>   * Otherwise return the dentry itself.
>   *
> + * For D_REAL_DATA the union/overlay may have to look up the data first.=
 This
> + * can sleep and it can fail. D_REAL_METADATA never fails.
> + *
>   * See also: Documentation/filesystems/vfs.rst
> + *
> + * Return: The real dentry, or an ERR_PTR() for D_REAL_DATA if the data =
can't
> + * be resolved.
>   */
>  static inline struct dentry *d_real(struct dentry *dentry, enum d_real_t=
ype type)
>  {
>
> --
> 2.53.0
>
