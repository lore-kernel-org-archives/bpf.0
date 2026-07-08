Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A066B1BD9C9
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783470682; cv=pass; b=VNZH+WO2vKX4B18iRgE7JroUOJ910IfgUCkR2A//JbZ5Rnm8ax0u+KAC0f5CnJibh+bx3blWYDRzlOAj2MEyw57FkS4TeowITcR7O9uqICN8SP9jKQEEsJeZFqcoRTzxyPHM2Se12fMP6JArV6aXviZ9EuJpeYz34EDXId1R5IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783470682; c=relaxed/simple;
	bh=3GQy5XeGx5dlqKdbk+YAzFV9pAUtw+CAm7QkZ9oa7K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoY60u9rHR6vZvPR45wR11u+ZuUeK9XQ4C22VfMsfJI9NQca39wW7p3ADC6iwsLiL20f6BnKaVCIA5Zbgf6SSqnET2BKJheft8oWx8omIN2fgzN5LyeZUHN5TrkiA1wT+e95vAx+cI36HqK4bYsQO4Dc9Dw8JWbPIycdY+l4UeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnWeCk4C; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnWeCk4C"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ea70ca4fc8so619706d6.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 17:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783470678; cv=none;
        d=google.com; s=arc-20260327;
        b=MrwCNGm/YYGQFMB2HMcvVClGh8HTlb9NRR2rVo0j4W1vyhreTOB7qPpsRCFRY94E8n
         YcsqzQ2dfWYqTOXO4kTxh4+Rp0GeJhsJYuGguPrU54xQ+Pz8hZGxmZ5BfBVxwBQbeR4e
         tXNFT+zheYR2KMm5jPOt43fWaxX4nLE/9RqoSgpKHmVVf1ji9B3/oM4Jf19lsqzfC8eo
         hwzX059nT2CFJVcZUiJjljGj0vpx4ZRqJ3DMM8EJ7HO5P/lm60+vJhhU3vscxJH0yf+w
         Ao6SIz37a37OrzAvwQzC9sGgID9lanuPLdBkDu2Yh4MXjZL2OfyugZ8XG2/SUN/aVEaq
         PlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7NuRayk8ACZHpU4jrCHbSE1b606laboR4aTU0FVg8Pw=;
        fh=KtW17fl3l6MDM/mpLwj562wRAYxeimcILfJL5MQorJ8=;
        b=HPqO3CYpRsGA9dvfkKqcpXjMO5qk1zZGooZ4QD4WM4guT5ppFndj1dvaSA88nWohuh
         f2EkUlcR1qGjYzaocFiEaynM4u7EZ5fBeyu2VROyP/sy43P9N6Tpa9VxVRy8gFiilKI4
         27AZSKwPgExTQTWCp3PaBqT954RPbro+/m6jif0ICIMR5u8NG3FU3HRIQuEEKpyLPMgP
         MB0p5KHmBztcrSKSIuc6n2v5+ajopeRHeam9PCnihOyKgvjEiO2piaW2cuNAs566ztCa
         d1GGTps8zuxnW2C3QQMTY6q5bfSWXRIF6Yz+EB3UO5FRx5Ku+5XB/aFVa3QxXEvDoBKL
         csew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783470678; x=1784075478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NuRayk8ACZHpU4jrCHbSE1b606laboR4aTU0FVg8Pw=;
        b=hnWeCk4CLRCcyna84m2gJp6bz6KUTKNIHmGru2Ew1h5QUPXMhGR9Emu1g0IaCIlL5+
         Y+uxtS/pjs8uQAWF7M77ymQG+61p1v5bU0ckwlx+7mt2+INiA9ZIVe+cE41a+PVPnwzK
         j+qJPrY+Ywjx/8a5k+KHsMxQhSCW9F0AbtpV+sCHGgPy0rGC22HBGS84w3DxrQE2qUv5
         8dLPf5rv9ws8je2eqATR8H7cguYgRcweujYrTVyKZCnBfX1pykNdRuo7WgiHP9etePTl
         sBYbW7JAlCoFmiLVshbrQAU8LAXf5j5LXuhzD0FXpK8DnW5v1RbxzJ+YYXm82DytcY4F
         ufxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783470678; x=1784075478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7NuRayk8ACZHpU4jrCHbSE1b606laboR4aTU0FVg8Pw=;
        b=SbByLYkDYseu5b9j5uk9QoAo6ll67hzfGAu4mjwBcruJQ97fZ3Wx/BzjfURTd4wVpC
         9tAnCz1g8HhzPmh1PqW/gdTGxVdZBJjF9V0Aw0JBCOpiTxPiqeoconiFwIVrblMq5Cde
         8Lp1NmV8/98TK7kRreFvdm7P/hYiXjoZ7H8DPsYVxJcYouyfX4Adf1aUD6g2zzm0HXeF
         gBNxg5/1Df8pqJ9aghVk7XjbR0emAvigfXs3Nie7/6d7m7BzAaCk+Ol2EtBF3JSw14E3
         S6Z+WZS3J7iOdgjYymL3t3rn6E2Cx6yghDUF+X36dfqxEWZqpEUAJYXgBBj34w4hz91D
         a9cw==
X-Forwarded-Encrypted: i=1; AHgh+RqubuUZINJe+5Xp1xA380+LvYlcBtOtEVmDqlaYbTLVUiUHckKH37qI3BuBDcbscCW2kvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjnBTwNbn/nRmf4j0CMh1P63zViL/HfFKW6nGE/9x1edyabjZ
	18kR740I2k6IITfwpue7O4CIhTBpFLUjCR9x868+RzSz+g4nOLBnxNuacHzDlhejrSd4ayO/LsC
	sLgPhbGbtIACVEquEPreyzsFKUH/Daz4=
X-Gm-Gg: AfdE7cnIAGSvOwQGiOWn87FjxxbJM0Bj62uQEwAO9Y6lfE7CbAcytXMJZP5Lx/f/IB0
	GCxzSg9SrXw9xhCrcdSLzqRYFQnlfygcnY5QSOniGDmPAdAXXt3vDItcXpa38bxWlAKjedz+fYd
	wmYKZvr65Wtd1MBwHDowlx5oUC1SSybxoa1z34amvi23edZE5EA4FQZ25Hn96pQxu3Ei5voywTR
	82mYwqE0LlPkDbfFyuBaN0+Eg6izxFpb3IosVH/aundQgfzLZh+nU3BdVDO4CXCFcRmOe1EKgNm
	wubxv402DTWbDw/fo4tBQYoWzmc=
X-Received: by 2002:a05:6214:554a:b0:8ef:8533:9651 with SMTP id
 6a1803df08f44-8fd3d111ae4mr65102316d6.36.1783470678614; Tue, 07 Jul 2026
 17:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-1-dwindsor@gmail.com> <20260708000956.46138-2-dwindsor@gmail.com>
 <20260708002030.53D9A1F000E9@smtp.kernel.org>
In-Reply-To: <20260708002030.53D9A1F000E9@smtp.kernel.org>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 7 Jul 2026 20:31:07 -0400
X-Gm-Features: AVVi8Cfeu7iTLKV4sdczNvssWGTRJZ9W34OAQImna28tK2X9fG0WUboNzUfP1yk
Message-ID: <CAEXv5_hyXHEKTfFCb9sSi=Z6B3W-PEue=x07sh_-Y56M7V=esA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] security: rework inode_init_security
 xattr handling
To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 8:20=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Heap buffer overflow in `security_lsmxattr_add()` due to xattr q=
uota bypass by BPF programs.
> - [Medium] `security_lsmxattr_add()` incorrectly returns `-EINVAL` instea=
d of `-EOPNOTSUPP` when the xattr array is not allocated.
> --
>
> --- Patch [1]: [PATCH v5 bpf-next 1/3] security: rework inode_init_securi=
ty xattr handling ---
> commit 871b3020e8c69372708886992716ee08d2e36bc2
> Author: David Windsor <dwindsor@gmail.com>
>
> security: rework inode_init_security xattr handling
>
> In preparation for bpf_init_inode_xattr(), a kfunc that lets bpf LSM
> programs atomically label new inodes, rework how inode_init_security
> xattrs are managed.
>
> > diff --git a/security/security.c b/security/security.c
> > --- a/security/security.c
> > +++ b/security/security.c
>
> [ ... ]
>
> > +/**
> > + * security_lsmxattr_add() - Add an xattr during inode_init_security
> > + * @xattrs: xattr state shared by inode_init_security hooks
> > + * @lsm_id: LSM_ID_* value identifying the calling LSM
> > + * @name: xattr name suffix
> > + * @value: xattr value
> > + * @value_len: length of @value
> > + *
> > + * Claim an xattr slot in @xattrs on behalf of the LSM identified by
> > + * @lsm_id and fill it with a copy of @name and @value. Callers can in=
voke
> > + * this function from non-sleepable context.
> > + *
> > + * Return: Returns 0 on success, -ENOSPC if the calling LSM's slot bud=
get
> > + *         is exhausted, negative values on other errors.
> > + */
> > +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> > +                       const char *name, const void *value,
> > +                       size_t value_len)
> > +{
> > +     struct xattr *xattr;
> > +     void *xattr_value;
> > +     size_t name_len;
> > +
> > +     if (!xattrs || !xattrs->xattrs || !name || !value)
> > +             return -EINVAL;
>
> [Severity: Medium]
> Should this return -EOPNOTSUPP instead of -EINVAL when the xattrs array
> is not allocated?
>
> During file creation on filesystems without xattr support,
> security_inode_init_security() is called with initxattrs =3D=3D NULL,
> deliberately leaving xattrs.xattrs unallocated.
>
> If a BPF program then calls security_lsmxattr_add(), it will receive
> -EINVAL. If the BPF program propagates this error, it will abort the
> inode creation entirely because security_inode_init_security() only
> treats -EOPNOTSUPP as a graceful fallback.
>
> > +
> > +     name_len =3D strlen(name);
> > +     if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> > +             return -EINVAL;
> > +     if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> > +             return -EINVAL;
> > +
> > +     switch (lsm_id) {
> > +#ifdef CONFIG_BPF_LSM
> > +     case LSM_ID_BPF:
> > +             if (lsm_xattrs_used(xattrs, XATTR_BPF_LSM_SUFFIX) >=3D
> > +                 BPF_LSM_INODE_INIT_XATTRS)
> > +                     return -ENOSPC;
>
> [Severity: High]
> Can this limit check be bypassed, leading to a heap buffer overflow?
>
> If a BPF program repeatedly calls security_lsmxattr_add() with a name
> that does not begin with XATTR_BPF_LSM_SUFFIX, lsm_xattrs_used() will
> not count them.
>

Sorry, all paths to calling this function are guaranteed to have
XATTR_BPF_LSM_SUFFIX.

> This allows bypassing the BPF_LSM_INODE_INIT_XATTRS limit. Since
> lsm_get_xattr_slot() does not check against the actual allocated heap
> size, it will increment ctx->xattr_count and return out-of-bounds
> pointers:
>
> include/linux/lsm_hooks.h:lsm_get_xattr_slot() {
>     ...
>     return &ctx->xattrs[ctx->xattr_count++];
> }
>
> Could this cause out-of-bounds writes when assigning xattr->value and
> xattr->name further down in this function?
>
> > +             break;
> > +#endif /* CONFIG_BPF_LSM */
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Combine xattr value + name into one allocation. */
> > +     xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOWAIT);
> > +     if (!xattr_value)
> > +             return -ENOMEM;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708000956.46=
138-1-dwindsor@gmail.com?part=3D1
