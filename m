Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB9314D17
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723217; cv=pass; b=BQevjttfZ6MiN98vz1p8Auby4lmYUPEqYrfhXonR41NzOad8iGMwHTAa4w4F+SY2sxNcskAyqfq1bgM+RHNRN6fFg7buiMg4n4F97d0VvnttNFu4aib/WCzMROAtNdlbWFA+s4ig2ObxQd01P3IqndQZ06YrgGsnqkXF1xnoiEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723217; c=relaxed/simple;
	bh=qhe95xVbcPZRLyRR+0r23A1X1RCC8vQgQtAs7G0rqe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcGqjS1IJ0q5Rhjyryo8ekH/WeeVM7FBa+rqzPvTfPlWgsLhI48D14UXRFM/LVjw5ZJu1JHwY9C45JqRVXoWeL9yRPOQ52LamtMOd7RxX1bWVJpkPpyDlnVL075QKjUDP/0OgrEV+jere3mkVhFdKISm1+Jbe6LCm7SVtnKgOz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QC4eD9Dh; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC4eD9Dh"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34abc7da414so918460a91.0
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 13:46:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769723215; cv=none;
        d=google.com; s=arc-20240605;
        b=CU/rA2zyMF6Qe3yiOSMXIuf0shGdmbr4PLVd+jDTPTY58ahQqyvUIU7OSSh/YSHnsy
         JdKH0aYx9Z80ro6eJDFsZY9rsg/l2gXMX1R2cXIHFCovK8HCxocFYutH/zxbZo89gbnG
         cmJB4Sl++U7pfMzSKJ//oddanhnKotzWZStIf8G3vkv73CznmZbV8xadRWTVOWU5uvuq
         C7z2HnyyD9jPa77v/0UHGlHixJalFJv8/cozkrbSStfd6rIIu13paW67DUMnuUpfrM+p
         DVQMqEDV5NFotuTU6WAVkCf6QLMiqSL0EcqW9zj2IQ41pM2lYnVC5oXoVmEYLp4NYHeZ
         n+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lY5BD0l6EtRntEAm7NaVteaI0ajCRxytAk3hjF+vju0=;
        fh=xR7tPDIUE2hgG5lIMR9LrNU3NlTAAa3As/g1kCmrqQs=;
        b=P3HpjfS+uErbx5ogj9aw8voA5us5RsQkol1Hlv5u9p8W37f714cXuBFX1dYDC/cSw8
         TgPJfzEniMhRTarHP+8r79mc5tcYWUV0Jl8LbV37pBrsz9uYcJ/CxYC1rkl+U9aFyvt7
         X6CaoyWsFOsEHr+Vr3+icNs6wQoy34wr0Dul9rZXPTjXaAp2ucCYnRQHR4EaRyC6A7Qf
         x2IacaG6f6Bmv/4fhWx0wCBLVqRjgUhyaaHTZNIFfaWIMMxthhhcqbxDpEsZPZwP/OHC
         wozbuPApowzRbd0DMRs1gz4H5HYLcmCcOe7/fXv+x9bc9oP5bHP4mZKlkxQcqwRNAPjl
         Zf8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769723215; x=1770328015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY5BD0l6EtRntEAm7NaVteaI0ajCRxytAk3hjF+vju0=;
        b=QC4eD9DhQeoc1JfCTTM/32whAN+Bg45Mv9+3exJDujs611GEazNEUyU4hmtN0kgBNr
         U958Ot1eE6WYOwfxBy+vdp/WobewlwhnZh3Tx1hNSq81RT4emIOv4i6O7u7aDtexsL2n
         tv4P/votVrNcPrJWJve9iBOWmuhu+R3yr9KZbjMPHVCJ9rtXI/Y43136cSbNncsLJ8LI
         8pTfY9eGQ3Jbdyw5zKvBGW40sno7W9fEcoHRhfZ6+dm2zhTORK0YR91D/P/FrFkkb1SW
         TWK/CMJigXR4sYqaXh9AUWcbz22HkeTeHl15GfV8QFrFCb79HXMvwvIJgztBj47tCyrO
         bwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723215; x=1770328015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lY5BD0l6EtRntEAm7NaVteaI0ajCRxytAk3hjF+vju0=;
        b=X85xwKURi2fWN6lWmCx6Uu4Wq0OTQDXSBUnP+O454cZW5W6+9NecTQIfegtovHe2V+
         byhQImK8u1UFB3vSMhiGsAVt0EbzlNDIs4eOsTy6xTS8AE1qh3B06bkk7NX9vTog0ee4
         gAkxxrGb8e7PRmHfwDzXFdXRooWu//xG6s2Fl//ozd2NtAYc1RMd2y307XMxpO9LvAvF
         7CQrF1vzWRNyNiLl1Eu9auWdMjtL/c+6QcOiven3HzxMIN7Cu6ppqMPWUqjc/3ggVwU+
         qM6KOmj1LgqrezCpEIr8CCP/DNspBJITwhs0QOKU/o0lGvo0GuAoptSrSJ+VDL95KE8J
         OICQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDuGBYwrEYi9VX/zNlUAyX/C3ieb0XKkWWK/ttwVaIqlZNJ2KklVhDvF8EuVO3G7ezLTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zOBJP+Ns9JaJfRf1gesEECOGJT1Ve4uUq5OzPkmnEZKUwOWB
	8R5x1j5ZWYTHniyWsoqlrflpb11cxWIooOZRsGQgdPoOJLQVdNjYVgqXjwGJVim9ctqOkmpdtml
	XWAGlf2JHpr9oc9f0WhGgS8ruPfwaFCk=
X-Gm-Gg: AZuq6aJ4nFln9DKhUUGE5XRKfwHH+FYrEXi61+b0IBEJbTu4XZD+pD6CaPDjhgjCysD
	QWwbIYfFvgypV0lgQhGwwMNzzc8QzJ91caVRRDRO4v85kLUkLc8cMdgrZeyjzqhlhJY3BP6sV+E
	Lbpc0oI0FnRucgdINa6WfAE0CQB3BqA78ZQGTK3a9F0VGhX8H5XBjkxfepPgSG33fS5F3Jo1nTN
	lnoVpeDqbj2Ui9r1MNIS8pK0L6XLpVPEycofri42II0EhoKMifTuXQ7bV0k50ZycNfYfqM0wvCX
	1Nthb4Cu8HY=
X-Received: by 2002:a17:90b:4c0e:b0:349:7f0a:381b with SMTP id
 98e67ed59e1d1-3543b2f2da1mr717271a91.8.1769723214863; Thu, 29 Jan 2026
 13:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128183232.2854138-1-andrii@kernel.org> <a1214f2e-dbf7-41d9-ad8a-703193c84b67@linux.dev>
 <c8e3d519-234a-4192-9759-fc4560ad0433@gmail.com>
In-Reply-To: <c8e3d519-234a-4192-9759-fc4560ad0433@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Jan 2026 13:46:42 -0800
X-Gm-Features: AZwV_QhVvw6dEFTskOefj4mpIJ__wVe9d5in9MkVOBXLsQsqAZYE9V9TkWj-ApE
Message-ID: <CAEf4BzaqAWeObPzaVoxCU7-JB2h6UwiMme_TDiv85wOH=Y+48g@mail.gmail.com>
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	akpm@linux-foundation.org, linux-mm@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 9:14=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 1/29/26 15:52, Yonghong Song wrote:
> >
> >
> > On 1/28/26 10:32 AM, Andrii Nakryiko wrote:
> >> Fix PROCMAP_QUERY to fetch optional build ID only after dropping
> >> mmap_lock or
> >> per-VMA lock, whichever was used to lock VMA under question, to avoid
> >> deadlock
> >> reported by syzbot:
> >>
> >>   -> #1 (&mm->mmap_lock){++++}-{4:4}:
> >>          __might_fault+0xed/0x170
> >>          _copy_to_iter+0x118/0x1720
> >>          copy_page_to_iter+0x12d/0x1e0
> >>          filemap_read+0x720/0x10a0
> >>          blkdev_read_iter+0x2b5/0x4e0
> >>          vfs_read+0x7f4/0xae0
> >>          ksys_read+0x12a/0x250
> >>          do_syscall_64+0xcb/0xf80
> >>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>
> >>   -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
> >>          __lock_acquire+0x1509/0x26d0
> >>          lock_acquire+0x185/0x340
> >>          down_read+0x98/0x490
> >>          blkdev_read_iter+0x2a7/0x4e0
> >>          __kernel_read+0x39a/0xa90
> >>          freader_fetch+0x1d5/0xa80
> >>          __build_id_parse.isra.0+0xea/0x6a0
> >>          do_procmap_query+0xd75/0x1050
> >>          procfs_procmap_ioctl+0x7a/0xb0
> >>          __x64_sys_ioctl+0x18e/0x210
> >>          do_syscall_64+0xcb/0xf80
> >>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>
> >>   other info that might help us debug this:
> >>
> >>    Possible unsafe locking scenario:
> >>
> >>          CPU0                    CPU1
> >>          ----                    ----
> >>     rlock(&mm->mmap_lock);
> >> lock(&sb->s_type->i_mutex_key#8);
> >>                                  lock(&mm->mmap_lock);
> >>     rlock(&sb->s_type->i_mutex_key#8);
> >>
> >>    *** DEADLOCK ***
> >>
> >> To make this safe, we need to grab file refcount while VMA is still
> >> locked, but
> >> other than that everything is pretty straightforward. Internal
> >> build_id_parse()
> >> API assumes VMA is passed, but it only needs the underlying file
> >> reference, so
> >> just add another variant build_id_parse_file() that expects file passe=
d
> >> directly.
> >>
> >> Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API
> >> for /proc/<pid>/maps")
> >> Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> >> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >> ---
> >>   fs/proc/task_mmu.c      | 42 ++++++++++++++++++++++++++-------------=
--
> >>   include/linux/buildid.h |  3 +++
> >>   lib/buildid.c           | 34 +++++++++++++++++++++++++--------
> >>   3 files changed, 56 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >> index 480db575553e..dd3b5cf9f0b7 100644
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> >> @@ -656,6 +656,7 @@ static int do_procmap_query(struct mm_struct *mm,
> >> void __user *uarg)
> >>       struct proc_maps_locking_ctx lock_ctx =3D { .mm =3D mm };
> >>       struct procmap_query karg;
> >>       struct vm_area_struct *vma;
> >> +    struct file *vm_file =3D NULL;
> >>       const char *name =3D NULL;
> >>       char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf =3D NULL;
> >>       __u64 usize;
> >> @@ -727,21 +728,6 @@ static int do_procmap_query(struct mm_struct
> >> *mm, void __user *uarg)
> >>           karg.inode =3D 0;
> >>       }
> >>   -    if (karg.build_id_size) {
> >> -        __u32 build_id_sz;
> >> -
> >> -        err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
> >> -        if (err) {
> >> -            karg.build_id_size =3D 0;
> >> -        } else {
> >> -            if (karg.build_id_size < build_id_sz) {
> >> -                err =3D -ENAMETOOLONG;
> >> -                goto out;
> >> -            }
> >> -            karg.build_id_size =3D build_id_sz;
> >> -        }
> >> -    }
> >> -
> >>       if (karg.vma_name_size) {
> >>           size_t name_buf_sz =3D min_t(size_t, PATH_MAX,
> >> karg.vma_name_size);
> >>           const struct path *path;
> >> @@ -775,10 +761,34 @@ static int do_procmap_query(struct mm_struct
> >> *mm, void __user *uarg)
> >>           karg.vma_name_size =3D name_sz;
> >>       }
> >>   +    if (karg.build_id_size && vma->vm_file)
> >> +        vm_file =3D get_file(vma->vm_file);
> >> +
> >>       /* unlock vma or mmap_lock, and put mm_struct before copying
> >> data to user */
> >>       query_vma_teardown(&lock_ctx);
> >>       mmput(mm);
> >>   +    if (karg.build_id_size) {
> >> +        __u32 build_id_sz;
> >> +
> >> +        if (vm_file)
> >> +            err =3D build_id_parse_file(vm_file, build_id_buf,
> >> &build_id_sz);
> >> +        else
> >> +            err =3D -ENOENT;
> >> +        if (err) {
> >> +            karg.build_id_size =3D 0;
> >> +        } else {
> >> +            if (karg.build_id_size < build_id_sz) {
> >> +                err =3D -ENAMETOOLONG;
> >> +                goto out;
> >> +            }
> >> +            karg.build_id_size =3D build_id_sz;
> >> +        }
> >> +    }
> >> +
> >> +    if (vm_file)
> >> +        fput(vm_file);
> >> +
> >>       if (karg.vma_name_size &&
> >> copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
> >>                              name, karg.vma_name_size)) {
> >>           kfree(name_buf);
> >> @@ -798,6 +808,8 @@ static int do_procmap_query(struct mm_struct *mm,
> >> void __user *uarg)
> >>   out:
> >>       query_vma_teardown(&lock_ctx);
> >>       mmput(mm);
> >> +    if (vm_file)
> >> +        fput(vm_file);
> >>       kfree(name_buf);
> >>       return err;
> >>   }
> >> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> >> index 831c1b4b626c..7acc06b22fb7 100644
> >> --- a/include/linux/buildid.h
> >> +++ b/include/linux/buildid.h
> >> @@ -7,7 +7,10 @@
> >>   #define BUILD_ID_SIZE_MAX 20
> >>     struct vm_area_struct;
> >> +struct file;
> >> +
> >>   int build_id_parse(struct vm_area_struct *vma, unsigned char
> >> *build_id, __u32 *size);
> >> +int build_id_parse_file(struct file *file, unsigned char *build_id,
> >> __u32 *size);
> >>   int build_id_parse_nofault(struct vm_area_struct *vma, unsigned
> >> char *build_id, __u32 *size);
> >>   int build_id_parse_buf(const void *buf, unsigned char *build_id,
> >> u32 buf_size);
> >>   diff --git a/lib/buildid.c b/lib/buildid.c
> >> index 818331051afe..dc643a6293c1 100644
> >> --- a/lib/buildid.c
> >> +++ b/lib/buildid.c
> >> @@ -279,7 +279,7 @@ static int get_build_id_64(struct freader *r,
> >> unsigned char *build_id, __u32 *si
> >>   /* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests *=
/
> >>   #define MAX_FREADER_BUF_SZ 64
> >>   -static int __build_id_parse(struct vm_area_struct *vma, unsigned
> >> char *build_id,
> >> +static int __build_id_parse(struct file *file, unsigned char *build_i=
d,
> >>                   __u32 *size, bool may_fault)
> >>   {
> >>       const Elf32_Ehdr *ehdr;
> >> @@ -287,11 +287,7 @@ static int __build_id_parse(struct
> >> vm_area_struct *vma, unsigned char *build_id,
> >>       char buf[MAX_FREADER_BUF_SZ];
> >>       int ret;
> >>   -    /* only works for page backed storage  */
> >> -    if (!vma->vm_file)
> >> -        return -EINVAL;
> >> -
> >> -    freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file,
> >> may_fault);
> >> +    freader_init_from_file(&r, buf, sizeof(buf), file, may_fault);
> >>         /* fetch first 18 bytes of ELF header for checks */
> >>       ehdr =3D freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
> >> @@ -332,7 +328,10 @@ static int __build_id_parse(struct
> >> vm_area_struct *vma, unsigned char *build_id,
> >>    */
> >>   int build_id_parse_nofault(struct vm_area_struct *vma, unsigned
> >> char *build_id, __u32 *size)
> >>   {
> >> -    return __build_id_parse(vma, build_id, size, false /* !may_fault
> >> */);
> >> +    if (!vma->vm_file)
> >> +        return -EINVAL;
> >> +
> >> +    return __build_id_parse(vma->vm_file, build_id, size, false /*
> >> !may_fault */);
> >>   }
> >>     /*
> >> @@ -348,7 +347,26 @@ int build_id_parse_nofault(struct vm_area_struct
> >> *vma, unsigned char *build_id,
> >>    */
> >>   int build_id_parse(struct vm_area_struct *vma, unsigned char
> >> *build_id, __u32 *size)
> >>   {
> >> -    return __build_id_parse(vma, build_id, size, true /* may_fault */=
);
> >> +    if (!vma->vm_file)
> >> +        return -EINVAL;
> >> +
> >> +    return __build_id_parse(vma->vm_file, build_id, size, true /*
> >> may_fault */);
> >> +}
> >> +
> >> +/*
> >> + * Parse build ID of ELF file
> >> + * @vma:      file object
> >
> > Should this be
> >      @file:    file object
> > ?
> kernel-doc comment should start with
>
> /**
> instead of
> /*
>
> (additional asterisk). Not sure if that is important,
> but it gets different highlight color in my editor.

Ah, I just copied a similar comment from another variant of that
helper. I'll fix this one up (but we'll leave with the others intact
for now, to minimize any conflicts across trees)

>
> >
> >> + * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
> >> + * @size:     returns actual build id size in case of success
> >> + *
> >> + * Assumes faultable context and can cause page faults to bring in
> >> file data
> >> + * into page cache.
> >> + *
> >> + * Return: 0 on success; negative error, otherwise
> >> + */
> >> +int build_id_parse_file(struct file *file, unsigned char *build_id,
> >> __u32 *size)
> >> +{
> >> +    return __build_id_parse(file, build_id, size, true /* may_fault
> >> */);
> >>   }
> >>     /**
> >
> >
>
