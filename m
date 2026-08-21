Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB329CE9
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341895; cv=pass; b=TQ8t2YVQ8mj6Sf6IX9+5EJxIYlY5i2lwaZcBR+3sUeCUqT/f1uWoVF4IOYCNJcaDK1wz/q7risoVY8oHruSuEtTa8JSTp63vBEtPwAmKEbrcrr//N5e8Au+ThqeyMdDSy4wpLzSWEUydee88eJ/2fBa2MiJI+xNNDTh2ToEh+/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341895; c=relaxed/simple;
	bh=h0kkDa2rvVLhZIQPnoDIC9boBb61vxYNVVyshIAfwBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHLMoCF1ecgqfbtBEEmANpQJIqgGj35dNYTVwHgahLLejoADUjwnDl20HkmhiHsuYxH5WsbXet8thd38SqFvZ7dE3WHsqN/kWZ5CAhuXw9eBBgKAtcXunu6UTnAHuBTymAyqBh4AXhhuG3SQBkQ0lPpTLP357O+KqdyrbG8UPu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGmMJ+BN; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGmMJ+BN"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so990712b3a.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 12:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787341894; cv=none;
        d=google.com; s=arc-20260327;
        b=jkohmnSz2AQz/n3BlCMXhWw7S5RNsoKP64IHTgaDr2PWBsYmU2y1bS3Pqs7QIN3Y/E
         B14zHyqktVWsv5pwhZ4LSV84Iq+wUblxRLGl3qowfh7kIDCWjxCjWCeirrYTU+MC3B9D
         Jt8OMG3WMfR7c5fz01wfOpWqqX0ARwhSCmoBKzyL40vIFMaQYzi2lBBwFkjd5/6L3Kzj
         28GeZPtx1BzyC9FaVB9lsNBTdxiZKX7jl20CRvdIQQhQRRADJQwIv06svqbygm6Xoao5
         kDBHFkOwA0+za+fUKk6Nk9Bc7ZoqE5JMk5nXxdaLRhizBjkcChA5H8VGQddi5zp9RfPa
         4dJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SzKLdRzgtAdfhltrrDFuuJzcJUuv3uu5ISrFgqsjcpk=;
        fh=WV/XN5X1oEf527+V7W8SMtugzL9N6qpwP4JTepq8Hy0=;
        b=YPQiibhYz7Ly/J5/3KxuYfcENk/NwDopr9t+AEc/mLi+AVhEedHWzc4ZBoK5v+3uKx
         CveYXkfjbf54qzXB28QA/Rp25mjW+eTMPxb1E8hNhJUGG/jnlWXJsVwWhiLEB8ys+v6d
         V6QH0Ws3xGz3+gzD0+28xywhrfoUEvgxhHJn5fKJYZw96lAKMKPr5W0qrqJyP0dKEnlO
         E17+AeDV5hU3gbMt9bb6qP1BDtGeJ+h6Q3P+cx+UdjcMQX/Kc7dCF38KGGb8QQv8dGJ2
         T7NnCwJV8+c9O0VVph4Ur0RNmSWiWXtuu8rGpXp/j86g4mWKdE3cpBIx4HWAaGIoNYFj
         F6Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787341894; x=1787946694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SzKLdRzgtAdfhltrrDFuuJzcJUuv3uu5ISrFgqsjcpk=;
        b=SGmMJ+BNSGlO2NJ3EuBAjMLwKVI1wKYU1K+WHt8nnBUqYSmXL+AYVNnCSuVp0aiNIg
         vyElFojzwapX9DYL/KAWpStg7UqQpYJF9eLZzYlAGvQIlOs75IzGoHWyoBMBh4bwqzaU
         3ZKuigVH24EOSGtpVGt/GdXvZlaKrmgVEb61tVnEEy2DtFFWk8kaCPrAg2oqQJH1uArX
         fhtsqFMlVfWZ9RWmvJSXBQOdzmLLAXDFCbuDVejBX+vuemriXFXq94O5x5TnPrk9nct5
         d5qhT2u0CxbBaoMo5eeSoNJvjB3+ankVkK+3kXS86ToIVBtp6rShoPbdWmXo87DR8BlD
         GsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787341894; x=1787946694;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzKLdRzgtAdfhltrrDFuuJzcJUuv3uu5ISrFgqsjcpk=;
        b=FaFwa10g5q03Lf4tkvVX5aJDHtlGhlQgVHlWSiLVz298yzRu4v985wyMLcc2NfJSC/
         TTzZpYtp/OT7BWoDiug7k+uZPPLg2+NEfvjzzIhq3vuMpSHkzmdY1w64MPCUrWAcZw0T
         bjE7idO7h/b70TGZEFFohwxPXruvzoY4kjYNEmFTNFHRUTjSZxvSYhcTaWV0CPamm44J
         Wnfx2T+8IS8KoGn1sFOTWVaZ+Bhnk4jMnAQ+uV8geYRpoY1/+4OxNcqE/e59Psd41UQJ
         IGS3V5seD3EmVAxhKAA38dnjwX2hG/h9EOE9iRD44n8TP440JY8boq22s87xaLHpN2wa
         Lx+g==
X-Gm-Message-State: AFuF++m9RCbMxwH5j4nDXRhTs2bMMNATef2l23YtOCK4jvlvdT9H/C29
	hJv9Y3wsk9NV8LabbuD0ePO/UlXa8X1E5jOm1mJxkEzevbZI5dcrjHQMK31mOWAGO1TVNIuYYkq
	lI4uJeFk115NHsXpE1DZdaUqqvC8jSIg=
X-Gm-Gg: AR+sD132VZuX2i+w/ByWTh1wF/au0TRc+qOK94WvLFrV68f8ejeYe/bh2vbsEVgPSV4
	9xqRm507eJj+UELRsHfsv7QL99pJwuZstiag5oiY+w41/UV98yABYKbIKw7gK+jzDO/UXbz1zUX
	H8cj1MDiK9ekOfrPEJGRFyJKNNMpXkyADfGCKxd5tGdYyXFz/x46YRtJoKTBQkc7IZ3axD/y8qw
	uahy9lyTNrvRzeQBFQSHp24HxZLEP/LElkXNY9+pw7iGv6ItVgP6FHyqcSqPdY/iR5eGp27Jh+h
	d2boLlPt3FoO59vnsoHSYtFVS+JuoDFa1eUmTGuUZPocW7G92b698KZiMQ3Wnb9rMuQZxPOGzVk
	O/9YpHDbZjNWQi5ce3+QXjOJVdQ==
X-Received: by 2002:a05:6a21:a41:b0:3c3:68b0:e273 with SMTP id
 adf61e73a8af0-3cd4bbf659dmr2252454637.15.1787341893121; Fri, 21 Aug 2026
 12:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820131801.68759-1-tasos.papagiannnis@gmail.com> <20260820131801.68759-3-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260820131801.68759-3-tasos.papagiannnis@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 12:51:21 -0700
X-Gm-Features: AcwNN1XWB_nq5Mq_nLbpufPwO46TiYdXCycQY7yskOQpHdsg462Mk-gXUf3OPbg
Message-ID: <CAEf4BzZTM5SehNnM83U3Kj0cz=NN=JwUtG-pcvSHdvZBsHdM3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Add user memory access kfuncs for linux_binprm
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	kpsingh@kernel.org, matt@bobrowski.net, song@kernel.org, 
	utilityemal77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 6:18=E2=80=AFAM Anastasios Papagiannis
<tasos.papagiannnis@gmail.com> wrote:
>
> When security_bprm_check runs, the arg and env strings for the exec have
> been copied into bprm->mm. The new address space has not been associated
> yet with a task_struct until exec_mmap(), so existing BPF user memory
> helpers can only read from the calling task's old address space.
>
> This patch adds bpf_copy_from_user_bprm() and
> bpf_copy_from_user_bprm_str() kfuncs. Both use the mm_struct provided by
> struct linux_binprm.
>
> Register these kfuncs on both MMU and NOMMU systems. On NOMMU systems,
> exec arguments are staged in bprm->page[] rather than mapped in bprm->mm,
> so the kfuncs return -EOPNOTSUPP.
>
> bpf_copy_from_user_bprm() has similar semantics as
> bpf_copy_from_user_task(). bpf_copy_from_user_bprm_str() copies one
> NUL-terminated string and returns its size including the NUL terminator.
> It accepts BPF_F_PAD_ZEROS to clear unused destination bytes on success.
>
> This patch registers both kfuncs with KF_SLEEPABLE because accessing the
> remote address space can fault. This allows BPF LSM programs attached to
> security_bprm_check to read arguments beginning at bprm->p and reject an
> exec based on its command-line arguments.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c | 128 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index f1863a891db6..1cd06f9e4890 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2024 Google LLC. */
>
> +#include <linux/binfmts.h>
>  #include <linux/bpf.h>
>  #include <linux/bpf_lsm.h>
>  #include <linux/btf.h>
> @@ -379,6 +380,131 @@ __bpf_kfunc struct inode *bpf_real_data_inode(struc=
t file *file)
>         return d_real_inode(file_dentry(file));
>  }
>
> +/**
> + * bpf_copy_from_user_bprm - Copy data from a binary parameter address s=
pace
> + * @dst:             Destination address, in kernel space
> + * @dst__sz:         Number of bytes to copy
> + * @unsafe_ptr__ign: Source address in the binary parameter address spac=
e
> + * @bprm:            Binary parameters whose address space will be used
> + * @flags:           Reserved for future use; must be zero
> + *
> + * Copies data from the nascent address space associated with @bprm. Thi=
s is
> + * useful for reading the argument and environment strings before the ne=
w
> + * address space is installed by exec_mmap(). For example, at the
> + * bprm_check_security LSM hook, @bprm->p points at the first argument s=
tring.
> + *
> + * The destination is zeroed if the requested number of bytes cannot be =
copied
> + * in full.
> + *
> + * Return: 0 on success, -EINVAL if @flags is non-zero, -EOPNOTSUPP on
> + * NOMMU systems, or -EFAULT if the copy fails or is partial.
> + */
> +__bpf_kfunc int bpf_copy_from_user_bprm(void *dst, u32 dst__sz,
> +                                       const void __user *unsafe_ptr__ig=
n,
> +                                       const struct linux_binprm *bprm, =
u64 flags)

making this linux_binprm-specific seems short-sighted and overly
specialized, why not pass `const struct mm *` and call new kfuncs
bpf_copy_from_user_mm[_str] ?

and this seems to belong right next to bpf_copy_from_user_task_str()
and others in kernel/bpf/helpers.c (and bpf_copy_from_user_task
variants should just delegate to this mm-based APIs and minimize code
duplication)

pw-bot: cr

> +{
> +#ifdef CONFIG_MMU
> +       struct mm_struct *mm;
> +       int ret;
> +#endif
> +
> +       if (unlikely(flags))
> +               return -EINVAL;
> +
> +       if (unlikely(!dst__sz))
> +               return 0;
> +
> +#ifdef CONFIG_MMU
> +       mm =3D bprm->mm;
> +       if (!mm) {
> +               memset(dst, 0, dst__sz);
> +               return -EFAULT;
> +       }
> +
> +       ret =3D access_remote_vm(mm, (unsigned long)unsafe_ptr__ign,
> +                              dst, dst__sz, 0);
> +       if (ret !=3D dst__sz) {
> +               memset(dst, 0, dst__sz);
> +               return -EFAULT;
> +       }
> +
> +       return 0;
> +#else
> +       memset(dst, 0, dst__sz);
> +       return -EOPNOTSUPP;
> +#endif
> +}
> +
> +/**
> + * bpf_copy_from_user_bprm_str - Copy a string from binary parameter mem=
ory
> + * @dst:             Destination address, in kernel space. This buffer m=
ust be
> + *                   at least @dst__sz bytes long
> + * @dst__sz:         Maximum number of bytes to copy, including the trai=
ling NUL
> + * @unsafe_ptr__ign: Source address in the binary parameter address spac=
e
> + * @bprm:            Binary parameters whose address space will be used
> + * @flags:           The only supported flag is BPF_F_PAD_ZEROS
> + *
> + * Copies a NUL-terminated string from the nascent address space associa=
ted
> + * with @bprm. If the string is too long, @dst is still NUL-terminated u=
nless
> + * @dst__sz is zero.
> + *
> + * If BPF_F_PAD_ZEROS is set, the unused portion of @dst is cleared on s=
uccess
> + * and all of @dst is cleared on failure.
> + *
> + * Return: The number of copied bytes including the NUL terminator on su=
ccess,
> + * or a negative error code on failure. On NOMMU systems, -EOPNOTSUPP is
> + * returned.
> + */
> +__bpf_kfunc int bpf_copy_from_user_bprm_str(void *dst, u32 dst__sz,
> +                                           const void __user *unsafe_ptr=
__ign,
> +                                           const struct linux_binprm *bp=
rm,
> +                                           u64 flags)
> +{
> +#ifdef CONFIG_MMU
> +       struct mm_struct *mm;
> +       int ret;
> +#endif
> +
> +       if (unlikely(flags & ~BPF_F_PAD_ZEROS))
> +               return -EINVAL;
> +
> +       if (unlikely(!dst__sz))
> +               return 0;
> +
> +#ifdef CONFIG_MMU
> +       mm =3D bprm->mm;
> +       if (!mm) {
> +               if (flags & BPF_F_PAD_ZEROS)
> +                       memset(dst, 0, dst__sz);
> +               else
> +                       *(char *)dst =3D '\0';
> +
> +               return -EFAULT;
> +       }
> +
> +       ret =3D copy_remote_mm_str(mm, (unsigned long)unsafe_ptr__ign,
> +                                dst, dst__sz, 0);
> +       if (ret < 0) {
> +               if (flags & BPF_F_PAD_ZEROS)
> +                       memset(dst, 0, dst__sz);
> +
> +               return ret;
> +       }
> +
> +       if (flags & BPF_F_PAD_ZEROS)
> +               memset(dst + ret, 0, dst__sz - ret);
> +
> +       return ret + 1;
> +#else
> +       if (flags & BPF_F_PAD_ZEROS)
> +               memset(dst, 0, dst__sz);
> +       else
> +               *(char *)dst =3D '\0';
> +
> +       return -EOPNOTSUPP;
> +#endif
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> @@ -390,6 +516,8 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_bprm, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_bprm_str, KF_SLEEPABLE)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
> --
> 2.55.0
>
