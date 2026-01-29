Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A3366054
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665874; cv=pass; b=JyIl70xfWtHKb3K85gjFT+VuAAAZiz1FA+a+3+PjWNgHjCSW8txGjwGE0YA4xdy5Q8MAJdXsbA8OX09r8VHsMsrn2ebwGJnj0vWxZr/cL8bnjaN8UK5ffTxPrkFZCw+AFs8JNkLVUgCMwdwT9VjuSC+muHGzTnUQqfDj6O+h6cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665874; c=relaxed/simple;
	bh=DtwpsDvwoifFlfoJ9md916ulMioOuh8cy0bLmld/VEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7aQLHJce402AVvXgdojLwHEpOScI4b+fhMtbZ0bpy1ZuMYkYUktx238esDqjw+4ZPyuT7YlWBqBFdhEpJeBFu5acbq5yjBjEW0cabxp0PDnUvRiXy61LcqaGGsLUi58MDpATPPNctcAcAjbPZqNGBn00HSweghYHXEv6V9rUbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e55rY1cm; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e55rY1cm"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5014b5d8551so199051cf.0
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 21:51:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769665868; cv=none;
        d=google.com; s=arc-20240605;
        b=U9cMTHJuazpKfVSVsTHYV9UCaKmExhc32khmRHORZiQv0lHk8QSU/a8ZEL7IqIXyFw
         ULH0EWO93+ARE96u07Q6cPmeo+e9oiaGQBYQjpRbOrGHzEJfbHaOwelLjkjdK3fPpK91
         g4FFPfCLZjfVGwGOJgkLZrVYt7skjIg1WkmFASHQ+Rze28XXDZl38ns/n6VvYMvf8Wm+
         TPbvSeGsZz83Q033cgciX4sGU6MI+k/f3KCdM8Xfm262rv5TY8qsdS3urz+DikPvWZ+p
         /qXZnXkMHk2W4gogMBePOnfYEaezg5efHP1jrRO4Pd8ffB5QVHB3pdQkzBUMkm7u45br
         3k2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G+I4M1s3j0bMSWuPz3rg0oxzV9B9B+nerZzojLunNls=;
        fh=pqlYFQjxcJ0zlhwHmjmfbAVbOXgGaEQFhAOMQFqKaoo=;
        b=IPvsiug+8Rx7E5aqXCQSh711oSiKNafQtWnEOZ8D+YHIgRCEOMWuOhsGj/z2CpYocN
         xGaqvROu2aTHH+rYijpSgNEadGjSLeDwLDLMxnj6a8hGKIH5tNClyXkXAZVci30UBv0A
         ioeOAB9Bm+/M3Oiwcw/kK6BRu/HS+beH/Tt34gp9eFaVLdv7F07neFzedYv0n1i2me6t
         cU9GB5vPxyj6CcuKMLj7AKVF+BhOJno1VD2iLgZxvSBHrEzJiyaYJWwE672ESKUUjnQy
         lme+9tO88oc6rxiwNpjyODh+P51IJXWEsNmspMBAKFWi2HiAwfssOStX1nHYzCzuNto0
         aZsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769665868; x=1770270668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+I4M1s3j0bMSWuPz3rg0oxzV9B9B+nerZzojLunNls=;
        b=e55rY1cmAS/HgFiy/WaLFutsgTjNB3pRYgI+ROnbIr/e45LmNHUkKFWqF0A89XzB/l
         MQyfUMFayvwSBnlOE6Y5mnLzmGyjNMAgo6z22aov03RnwPCqyQyG+jyZqgJw6HrbLlvR
         32hloTQcNecjRnmrvLVZKRzOAzhfFcAjcvM30nIvqHEdQPqVY2UgVzlVhlfay3i/QtT9
         7siGgR6l81HK1ESJpTlEzEPmLfZByOVcSuoGHCYeJsYENVQatTzXdPsVVkl+XCiDPcWw
         gnv0IyS1PvVNwGgmeHuUmS/JhwN+dwQdKJ27TfihTrWANbWNiYNwaf/cijQCAhMj/d6L
         C/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769665868; x=1770270668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G+I4M1s3j0bMSWuPz3rg0oxzV9B9B+nerZzojLunNls=;
        b=fY8afHd73iITsAdniDq/16oq/a0bz3KE2k4J7mILJabeJX/Sn9knXEtDDIlfXwmYXM
         bvXG+3fYTNMtxS7Tk7Gbqv5xSCjdpWYX3gvoLjY9yCQVdMpYPtrjjj0iqkAofYU2WnFI
         gi+1rCbFoEGzArTU0WP77l+e4EfKAzziJojbNo3ZtfcGylyePktp5kNhLZKWgtJjofsH
         IBX/+cyJ7b8l1Lq8aAkc51xKM8BfPTuKnje5ZvYoTKX0/R0lNdXsy/lHlCyjir/2d9Ex
         WdMLv5UNw+Q1rk9CHzUZJBA+ixVujxhCTtvJIow4EQvxvK3IAy61mJ9rwU0tS2dCvoBr
         4RAg==
X-Forwarded-Encrypted: i=1; AJvYcCUzDK8Oy3cwXfbTKESN7QRmRd0Yjr0sjChAXTtq+uEdXEft/XVaWUPtxH1f4KoorsGASXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK5ohyxff9ZQtVhASktzix+bl+KjhyPTK0v58t70iglZ8oCDiy
	Zzdobfa1NsFRuVRsrb1X8Pt8o1mHKwGwBNcZjUtAaMbt05bMHFhO5y51d5ukGVOv6F7uAlaSYzt
	R05JpM3ERa5ddO7k0mYBsgvX6Um/GvIhyv4xB/2ry
X-Gm-Gg: AZuq6aLnu/q9+gXFKy7qIgXAWjpRhRV43azKcK5LsBy1Z4I3/n/No9sbpJgLky1ap5k
	6U/1gFqTQacNLCkbCYswXo7UnTlDsp0bbQ3T3YwmBC6biV/f9knJpwcITtYVfQaCmRNsurFf/dd
	bFJsPKgQsYQXLatnNXkGMRekFrw326f+8d/IipzPpPGvVWexHwcoFHtvJOcNQV32pbxbFITZtPJ
	XhppaYncZ8VwAZMRJ2sdkc4qyiBGRQdeVSOUBc+8m/de184r5MYX9egQrIeZPejDdC26w==
X-Received: by 2002:a05:622a:1306:b0:4ed:a65c:88d0 with SMTP id
 d75a77b69052e-503b66a55c4mr7810771cf.6.1769665868137; Wed, 28 Jan 2026
 21:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128183232.2854138-1-andrii@kernel.org>
In-Reply-To: <20260128183232.2854138-1-andrii@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 28 Jan 2026 21:50:57 -0800
X-Gm-Features: AZwV_QhnZUXKlUFFOl2DJidKj3WCTCYNluIJH-xXN0ab4mRyISg9ZyWQ5ss0onA
Message-ID: <CAJuCfpETSCvD8m+q5upFKb5pCf2P7ffMMJs8p-y=V9fjdh73GQ@mail.gmail.com>
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
To: Andrii Nakryiko <andrii@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 10:32=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_loc=
k or
> per-VMA lock, whichever was used to lock VMA under question, to avoid dea=
dlock
> reported by syzbot:
>
>  -> #1 (&mm->mmap_lock){++++}-{4:4}:
>         __might_fault+0xed/0x170
>         _copy_to_iter+0x118/0x1720
>         copy_page_to_iter+0x12d/0x1e0
>         filemap_read+0x720/0x10a0
>         blkdev_read_iter+0x2b5/0x4e0
>         vfs_read+0x7f4/0xae0
>         ksys_read+0x12a/0x250
>         do_syscall_64+0xcb/0xf80
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>  -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
>         __lock_acquire+0x1509/0x26d0
>         lock_acquire+0x185/0x340
>         down_read+0x98/0x490
>         blkdev_read_iter+0x2a7/0x4e0
>         __kernel_read+0x39a/0xa90
>         freader_fetch+0x1d5/0xa80
>         __build_id_parse.isra.0+0xea/0x6a0
>         do_procmap_query+0xd75/0x1050
>         procfs_procmap_ioctl+0x7a/0xb0
>         __x64_sys_ioctl+0x18e/0x210
>         do_syscall_64+0xcb/0xf80
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>  other info that might help us debug this:
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    rlock(&mm->mmap_lock);
>                                 lock(&sb->s_type->i_mutex_key#8);
>                                 lock(&mm->mmap_lock);
>    rlock(&sb->s_type->i_mutex_key#8);
>
>   *** DEADLOCK ***
>
> To make this safe, we need to grab file refcount while VMA is still locke=
d, but
> other than that everything is pretty straightforward. Internal build_id_p=
arse()
> API assumes VMA is passed, but it only needs the underlying file referenc=
e, so
> just add another variant build_id_parse_file() that expects file passed
> directly.
>
> Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for=
 /proc/<pid>/maps")
> Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

One nit below, otherwise LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  fs/proc/task_mmu.c      | 42 ++++++++++++++++++++++++++---------------
>  include/linux/buildid.h |  3 +++
>  lib/buildid.c           | 34 +++++++++++++++++++++++++--------
>  3 files changed, 56 insertions(+), 23 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 480db575553e..dd3b5cf9f0b7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -656,6 +656,7 @@ static int do_procmap_query(struct mm_struct *mm, voi=
d __user *uarg)
>         struct proc_maps_locking_ctx lock_ctx =3D { .mm =3D mm };
>         struct procmap_query karg;
>         struct vm_area_struct *vma;
> +       struct file *vm_file =3D NULL;
>         const char *name =3D NULL;
>         char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf =3D NULL;
>         __u64 usize;
> @@ -727,21 +728,6 @@ static int do_procmap_query(struct mm_struct *mm, vo=
id __user *uarg)
>                 karg.inode =3D 0;
>         }
>
> -       if (karg.build_id_size) {
> -               __u32 build_id_sz;
> -
> -               err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
> -               if (err) {
> -                       karg.build_id_size =3D 0;
> -               } else {
> -                       if (karg.build_id_size < build_id_sz) {
> -                               err =3D -ENAMETOOLONG;
> -                               goto out;
> -                       }
> -                       karg.build_id_size =3D build_id_sz;
> -               }
> -       }
> -
>         if (karg.vma_name_size) {
>                 size_t name_buf_sz =3D min_t(size_t, PATH_MAX, karg.vma_n=
ame_size);
>                 const struct path *path;
> @@ -775,10 +761,34 @@ static int do_procmap_query(struct mm_struct *mm, v=
oid __user *uarg)
>                 karg.vma_name_size =3D name_sz;
>         }
>
> +       if (karg.build_id_size && vma->vm_file)
> +               vm_file =3D get_file(vma->vm_file);
> +
>         /* unlock vma or mmap_lock, and put mm_struct before copying data=
 to user */
>         query_vma_teardown(&lock_ctx);
>         mmput(mm);
>
> +       if (karg.build_id_size) {
> +               __u32 build_id_sz;
> +
> +               if (vm_file)
> +                       err =3D build_id_parse_file(vm_file, build_id_buf=
, &build_id_sz);
> +               else
> +                       err =3D -ENOENT;

Before this change we returned EINVAL when vma->vm_file=3D=3DNULL, now we
return ENOENT. Probably not critical but is there a reason for this
change?

> +               if (err) {
> +                       karg.build_id_size =3D 0;
> +               } else {
> +                       if (karg.build_id_size < build_id_sz) {
> +                               err =3D -ENAMETOOLONG;
> +                               goto out;
> +                       }
> +                       karg.build_id_size =3D build_id_sz;
> +               }
> +       }
> +
> +       if (vm_file)
> +               fput(vm_file);
> +
>         if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_n=
ame_addr),
>                                                name, karg.vma_name_size))=
 {
>                 kfree(name_buf);
> @@ -798,6 +808,8 @@ static int do_procmap_query(struct mm_struct *mm, voi=
d __user *uarg)
>  out:
>         query_vma_teardown(&lock_ctx);
>         mmput(mm);
> +       if (vm_file)
> +               fput(vm_file);
>         kfree(name_buf);
>         return err;
>  }
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index 831c1b4b626c..7acc06b22fb7 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -7,7 +7,10 @@
>  #define BUILD_ID_SIZE_MAX 20
>
>  struct vm_area_struct;
> +struct file;
> +
>  int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, =
__u32 *size);
> +int build_id_parse_file(struct file *file, unsigned char *build_id, __u3=
2 *size);
>  int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *bu=
ild_id, __u32 *size);
>  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf=
_size);
>
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 818331051afe..dc643a6293c1 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -279,7 +279,7 @@ static int get_build_id_64(struct freader *r, unsigne=
d char *build_id, __u32 *si
>  /* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests */
>  #define MAX_FREADER_BUF_SZ 64
>
> -static int __build_id_parse(struct vm_area_struct *vma, unsigned char *b=
uild_id,
> +static int __build_id_parse(struct file *file, unsigned char *build_id,
>                             __u32 *size, bool may_fault)
>  {
>         const Elf32_Ehdr *ehdr;
> @@ -287,11 +287,7 @@ static int __build_id_parse(struct vm_area_struct *v=
ma, unsigned char *build_id,
>         char buf[MAX_FREADER_BUF_SZ];
>         int ret;
>
> -       /* only works for page backed storage  */
> -       if (!vma->vm_file)
> -               return -EINVAL;
> -
> -       freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, may_fa=
ult);
> +       freader_init_from_file(&r, buf, sizeof(buf), file, may_fault);
>
>         /* fetch first 18 bytes of ELF header for checks */
>         ehdr =3D freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
> @@ -332,7 +328,10 @@ static int __build_id_parse(struct vm_area_struct *v=
ma, unsigned char *build_id,
>   */
>  int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *bu=
ild_id, __u32 *size)
>  {
> -       return __build_id_parse(vma, build_id, size, false /* !may_fault =
*/);
> +       if (!vma->vm_file)
> +               return -EINVAL;
> +
> +       return __build_id_parse(vma->vm_file, build_id, size, false /* !m=
ay_fault */);
>  }
>
>  /*
> @@ -348,7 +347,26 @@ int build_id_parse_nofault(struct vm_area_struct *vm=
a, unsigned char *build_id,
>   */
>  int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, =
__u32 *size)
>  {
> -       return __build_id_parse(vma, build_id, size, true /* may_fault */=
);
> +       if (!vma->vm_file)
> +               return -EINVAL;
> +
> +       return __build_id_parse(vma->vm_file, build_id, size, true /* may=
_fault */);
> +}
> +
> +/*
> + * Parse build ID of ELF file
> + * @vma:      file object
> + * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
> + * @size:     returns actual build id size in case of success
> + *
> + * Assumes faultable context and can cause page faults to bring in file =
data
> + * into page cache.
> + *
> + * Return: 0 on success; negative error, otherwise
> + */
> +int build_id_parse_file(struct file *file, unsigned char *build_id, __u3=
2 *size)
> +{
> +       return __build_id_parse(file, build_id, size, true /* may_fault *=
/);
>  }
>
>  /**
> --
> 2.47.3
>
