Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99DA35F8B9
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723022; cv=pass; b=kLy4FBbNYO7S9qg8dUPTsYFGSVX6+Yyav9XhQ5ksZ0k7DWpe7qKMzMbafZ/v7DKpEEZI+3GxNZMUJh0xFuwbyrPpJGxv4dzN5jDMK/E48ObmuHqKre/m2ra76v1Q3pXUcMFuHohPHIO0dQ1ZpVJElI4wtBfoo02ZurYWd/78vMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723022; c=relaxed/simple;
	bh=y6XWMs1r4hckqtW7c34PktfaqJpQcexMz1w5IT3tDqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Js8RiAgh+CxDFUngEU8YodWcoBA0uQleLUD8kuuwHm1mkLM0A/wSR4TdQk227Rbe+LZGCJ+arNuHeF1v8XYWV6aydUjGgiW3OHBzJJNQbgfVte5cDd1DvYESe58XIeiIAAiyC/UW5g+VnojK/jsh4GR0PkF7TOWqo2y+vT7usCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrSMPSI4; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrSMPSI4"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso847728b3a.1
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 13:43:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769723020; cv=none;
        d=google.com; s=arc-20240605;
        b=X9Rs+QQCvLFhnupoxPjh6bQlvOlq/t7DmMHriju6xhXlQ2CewRaALDKev/qF7k/ktB
         Ocm4koQfzlrZPVIYK3v2mzs59HHiNa0U0wb50hTlWQVPkiaRjZrjm0NuijEKrSHLOnG5
         YJJmX88NaC/UJpmN49Nh+9bsbatin5S01Xl45ooGoGZM1TrFXb0DdyV8xP3tRZfhnXgO
         jm2xL4w+GOdpAkFh8vgUtVMI5wYiHCJX85KWWVABv/2lyOof771UwUmiz4vYEYXAGxYg
         l1sXiXXvesonDYYRtv3iTFnkFWw6snQyvU+lbK29LhXQuZrPihiEdFyJC3TZgUPwISQK
         vloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2gb09q6P8bpGuxTLEw0ruU1CQYj/z7WcdS0uDTFHvoE=;
        fh=KbMNGJBb52vgvePVUs93DAQWWbjAGwRvSW1plBGPyV4=;
        b=lYdEzisRr5JdHfZeaDyuwB98B/7qa9HmbIZdE4UJ9Jk8qQ9FbSrCfKhAdkVezg+aPk
         tLqerXYHFJypw7Z4yEXf7UhYDDN7WiRwvrrfpBUjoEZTN2AqmeYR3+x1MuN2x1pwVy8v
         vchS86DWek89MD1lxRpnp5th82YycK1JZZ7zsCfR+vTKq+9m23GPFhazCaLNwONZkExJ
         guhX6ChwGJ6rfUXN6+EcvxzM0s1Ed/6ZO5lm+Frb08XS4YYD8T5WL1+NzFrbon5ZHUam
         V5EhJ3jy+Dp9h8IjxMP9q2t405lxJZB/slDwqTNNtP3wudbygrx1PLFmE0v5mZ2Yg5k2
         Kw4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769723020; x=1770327820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gb09q6P8bpGuxTLEw0ruU1CQYj/z7WcdS0uDTFHvoE=;
        b=JrSMPSI461R85bFT2KI+LFzPwdq/To8hjSwqKTCh1l1gIE9hEp5I/t5yDJG644/NhB
         +LsDFhpkFqK/olTievuGaKPYc9f4AMmJaJWXrVmjiz5i6trMJRragtKgSyIiAzt4jNIV
         sNjMzfXh1sgWR56Sz6+8Xyw356wt7Z32ciOINb8XOzziaM0wcR6jGnG/rp9eWJyphO1k
         7pLIrlgNkV+HEk+8LZu/ePctSyZSVde8kzwMGXsGA9HSg1gmmi+BxaLMN7iSVXOxDUFn
         a0dB3K6m1aQK+sXPQdy0gD26x2UbGH6aBAYCx1CAvlLZMceYfoKBixg4k6E/Z55j9eWu
         awHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723020; x=1770327820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gb09q6P8bpGuxTLEw0ruU1CQYj/z7WcdS0uDTFHvoE=;
        b=Am6wqxij4cPucYFS4+BSlHBmcRbXjjuhBGo3k888Zf8IpF1azzOECF2SE+/N423s4I
         r0SZANNpXa6Ir4COibkLBPS4J4aXgKjdMmj81dyYJWqFyU8LGEvSxvufkXG/3mI4Y1Yi
         kiFw2cwFLXO9KUpXj6aT6gZ1jYdMMZrsZramwe9NpXQCnxj9AxfuX+XbO6dJot5zhqWg
         cYEtSjA6rR8I4Y7W89haxlx43bHACvWvoC7YkHYivlAvGhb0VyueHnZ6KQE2aGwzSmx9
         5x2qfLA5RiZ1d18Z3nR1F8UGVj0RNeeiDWJOx/bb+AFAmQU5UDTOutDwinOBnqSkns5O
         ZWdg==
X-Forwarded-Encrypted: i=1; AJvYcCU1oeVMAS6s4ycALX2W8//8ItO4jyj/RPg+29iUdSNg0O4/0HOokNMH0wRMgnZ4J0iDHuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwZCw/qEqWcFitfRMC/e6PBTYdgF4uxymONt9CICMEtOyxcQM
	rWM73l43KIdN0n96+vnYAp82dL/YdqNQBBKpa6Wyd/v4cYuO2xMs+g/24F1qvJ/o8SGepQoWE3r
	m+c2tx9DbiWkxZpJrjcSnFOiwKqNMR0U=
X-Gm-Gg: AZuq6aJynk4ucp02x9hHhmnf3YjJo8rbb4oxhtd4uR+kfnENBVwNbust95SB2TAdbx/
	TrszeXijOUbhaoPUzhvMLn0UneKTpf4Y26URcEk4l8UJRIz/V7CH/Fz6Rer41MWB3NLrPsCfYDc
	SzgLyxtRgoBW+DchoUJhs3kXe4baSXzP8bwLDcdC8n08ogpmGFMGVZtZumB4ECkIWq+EULG/+q4
	T62Jcfkw9ezgUvOqnDIaN+plP+X0QZLKKjHBv35fBsrwLA4Ig/a4F+OYcSbxY9bs2xWzm6qhwhA
	IeU+7sR5xyhWOgARmIHVKg==
X-Received: by 2002:a17:90b:28c5:b0:341:c964:125b with SMTP id
 98e67ed59e1d1-3543b3b0416mr615755a91.31.1769723020161; Thu, 29 Jan 2026
 13:43:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128183232.2854138-1-andrii@kernel.org> <CAJuCfpETSCvD8m+q5upFKb5pCf2P7ffMMJs8p-y=V9fjdh73GQ@mail.gmail.com>
In-Reply-To: <CAJuCfpETSCvD8m+q5upFKb5pCf2P7ffMMJs8p-y=V9fjdh73GQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Jan 2026 13:43:27 -0800
X-Gm-Features: AZwV_Qjmq-o4gruq32Jt_kJNZlusLMF_UzzkH3pmRCDmhIFboAuwX-4OB_1XhYo
Message-ID: <CAEf4BzazUY0deKN9HOWNbazuC3tnk0OgV_p-UzA1bDUqPKVq9g@mail.gmail.com>
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org, linux-mm@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 9:51=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jan 28, 2026 at 10:32=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_l=
ock or
> > per-VMA lock, whichever was used to lock VMA under question, to avoid d=
eadlock
> > reported by syzbot:
> >
> >  -> #1 (&mm->mmap_lock){++++}-{4:4}:
> >         __might_fault+0xed/0x170
> >         _copy_to_iter+0x118/0x1720
> >         copy_page_to_iter+0x12d/0x1e0
> >         filemap_read+0x720/0x10a0
> >         blkdev_read_iter+0x2b5/0x4e0
> >         vfs_read+0x7f4/0xae0
> >         ksys_read+0x12a/0x250
> >         do_syscall_64+0xcb/0xf80
> >         entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >  -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
> >         __lock_acquire+0x1509/0x26d0
> >         lock_acquire+0x185/0x340
> >         down_read+0x98/0x490
> >         blkdev_read_iter+0x2a7/0x4e0
> >         __kernel_read+0x39a/0xa90
> >         freader_fetch+0x1d5/0xa80
> >         __build_id_parse.isra.0+0xea/0x6a0
> >         do_procmap_query+0xd75/0x1050
> >         procfs_procmap_ioctl+0x7a/0xb0
> >         __x64_sys_ioctl+0x18e/0x210
> >         do_syscall_64+0xcb/0xf80
> >         entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >  other info that might help us debug this:
> >
> >   Possible unsafe locking scenario:
> >
> >         CPU0                    CPU1
> >         ----                    ----
> >    rlock(&mm->mmap_lock);
> >                                 lock(&sb->s_type->i_mutex_key#8);
> >                                 lock(&mm->mmap_lock);
> >    rlock(&sb->s_type->i_mutex_key#8);
> >
> >   *** DEADLOCK ***
> >
> > To make this safe, we need to grab file refcount while VMA is still loc=
ked, but
> > other than that everything is pretty straightforward. Internal build_id=
_parse()
> > API assumes VMA is passed, but it only needs the underlying file refere=
nce, so
> > just add another variant build_id_parse_file() that expects file passed
> > directly.
> >
> > Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API f=
or /proc/<pid>/maps")
> > Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> One nit below, otherwise LGTM.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Tested-by: Suren Baghdasaryan <surenb@google.com>
>
> > ---
> >  fs/proc/task_mmu.c      | 42 ++++++++++++++++++++++++++---------------
> >  include/linux/buildid.h |  3 +++
> >  lib/buildid.c           | 34 +++++++++++++++++++++++++--------
> >  3 files changed, 56 insertions(+), 23 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 480db575553e..dd3b5cf9f0b7 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -656,6 +656,7 @@ static int do_procmap_query(struct mm_struct *mm, v=
oid __user *uarg)
> >         struct proc_maps_locking_ctx lock_ctx =3D { .mm =3D mm };
> >         struct procmap_query karg;
> >         struct vm_area_struct *vma;
> > +       struct file *vm_file =3D NULL;
> >         const char *name =3D NULL;
> >         char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf =3D NULL;
> >         __u64 usize;
> > @@ -727,21 +728,6 @@ static int do_procmap_query(struct mm_struct *mm, =
void __user *uarg)
> >                 karg.inode =3D 0;
> >         }
> >
> > -       if (karg.build_id_size) {
> > -               __u32 build_id_sz;
> > -
> > -               err =3D build_id_parse(vma, build_id_buf, &build_id_sz)=
;
> > -               if (err) {
> > -                       karg.build_id_size =3D 0;
> > -               } else {
> > -                       if (karg.build_id_size < build_id_sz) {
> > -                               err =3D -ENAMETOOLONG;
> > -                               goto out;
> > -                       }
> > -                       karg.build_id_size =3D build_id_sz;
> > -               }
> > -       }
> > -
> >         if (karg.vma_name_size) {
> >                 size_t name_buf_sz =3D min_t(size_t, PATH_MAX, karg.vma=
_name_size);
> >                 const struct path *path;
> > @@ -775,10 +761,34 @@ static int do_procmap_query(struct mm_struct *mm,=
 void __user *uarg)
> >                 karg.vma_name_size =3D name_sz;
> >         }
> >
> > +       if (karg.build_id_size && vma->vm_file)
> > +               vm_file =3D get_file(vma->vm_file);
> > +
> >         /* unlock vma or mmap_lock, and put mm_struct before copying da=
ta to user */
> >         query_vma_teardown(&lock_ctx);
> >         mmput(mm);
> >
> > +       if (karg.build_id_size) {
> > +               __u32 build_id_sz;
> > +
> > +               if (vm_file)
> > +                       err =3D build_id_parse_file(vm_file, build_id_b=
uf, &build_id_sz);
> > +               else
> > +                       err =3D -ENOENT;
>
> Before this change we returned EINVAL when vma->vm_file=3D=3DNULL, now we
> return ENOENT. Probably not critical but is there a reason for this
> change?
>

This error code is not returned to the caller. Even if build ID
parsing returns an error, all we do is `karg.build_id_size =3D 0;` and
proceed (successfully). So -ENOENT doesn't matter, but it felt like
"there is no file -> ENOENT" as the internal signal made more sense.
I'll keep it as is, I still think it makes sense.

> > +               if (err) {
> > +                       karg.build_id_size =3D 0;
> > +               } else {
> > +                       if (karg.build_id_size < build_id_sz) {
> > +                               err =3D -ENAMETOOLONG;
> > +                               goto out;
> > +                       }
> > +                       karg.build_id_size =3D build_id_sz;
> > +               }
> > +       }
> > +
> > +       if (vm_file)
> > +               fput(vm_file);
> > +
> >         if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma=
_name_addr),
> >                                                name, karg.vma_name_size=
)) {
> >                 kfree(name_buf);

[...]
