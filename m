Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FEF341654
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723341; cv=pass; b=JwsarJcfSoBHeIohGEpMxWJSA+rl3flZxlXeIAS30oPA44ziBjopkh9SDor5PLWS4sQD0dEIWI1Es3hMhY+3ecykq6eJ0EZVSjYqS61i98FMvpG0W2LF5ajiwLz5fRCGGQLz/fBkmW+ws2p6XHm2UugEnjXYXmGGzIeW4AivPOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723341; c=relaxed/simple;
	bh=J3z1OJ5N8wkaoonfU031DzjD8V4gRpQkebv/CwLhKr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVu/MM4dozz+f+4u6gxHl+5KSrEeoUZl599Em+mCYH9y0ngasSqtUWwkIOrkVsZAjVi3xvNMQ6d+h+/h1LwiQE03/FEsO78Zu0oyFeMDDtN14JYBMV3crDY5z0DFUhJ1+Lhigjui2Ci3pVvPi3rYx0WDKUyON+Y8QKsNa+ciZVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAsMQtFY; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAsMQtFY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81dab89f286so733874b3a.2
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 13:49:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769723340; cv=none;
        d=google.com; s=arc-20240605;
        b=OyjFPT6cNp4Uqi+kzEunibgIbmBxClSgGsm5kTPG3Kl1Zg2o53YEJ3IGySKKDN3lee
         tte598ByqtUf2S/TZr9Ga6BpBMxgzlpugZLqXwTPL9/YNcmK+Qh9D0MdHtznOAy/3ezo
         UBgfzVlAnuU10Zy/VLmRiKWHMw+NFgG4JQ2mseOwPesWutCbDi3yogxEjiEoRbvoTJN2
         gNVeXmmOACr71cwKE/GQG9JwKYAePpfrqPb6eHpf3ZizJoB7BvU6BqRhUiI1T7XtDe/v
         Db1tlU8xpLTJfF5wTYPy1W4L1pdheC1Ll0XAtttJXVPixeYuD2oLneNZ6wVcweeJyKFO
         CelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=httfifXiFd5uWoo/mGZ7s9cURALbGmXfpP+U9cGf6QY=;
        fh=c2n3xWcp2Ei//8HWgBNe3ShotdRPs9ZcJD1C9DXRrF0=;
        b=KfdQe8oKWpbd/5l1qqKOovMRjGiNoH3dhpePdbDmLNGtkCQPA/hesDGtoNIELPfrVC
         blojWts0GL1Zlx+uDitCMJkP9lLFMhtGDe/tD7I4iaBdh47F5TGdYpMzCEL36y9smboW
         P4V5KERucl1FsXInQVjKU1mRLItbag0UKR70rf25BJgwLHdTOCf26A2aN52ytuLw0D+F
         RSogWbfMg4rwEPJ4mig2/il1ph3Po4mXOrBJ6P9SBClfc0LTw8Tcyb/fGt97VCp4x9qT
         oX6JnNmO3i3vpwQKMW1HkTneYHwkqwnGdMf0MSxDge8z7Vg4db9p30+uDotZxQ4O0zBc
         6THg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769723340; x=1770328140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=httfifXiFd5uWoo/mGZ7s9cURALbGmXfpP+U9cGf6QY=;
        b=IAsMQtFYqnW49cu/IIgfqNGFPeMdAhN8Fmwu0SQ59+UIdW/3XOPKu6H/dZPcIfu/2I
         5QJssLIT85jZxBNJEcaLztSVaFBt9v2X/llImvXJfWyM6+WWkFrpIBlBk+/LVp2OhC2A
         KvQ+MCv0QwEQnnh2a2INtBHv7sAQTz+24JhDbnuNSuK1o+dXFWguOMrpqP6SNEQ3WDhs
         nAqanHKVmXvlb39cQMHEGl3UFzppWwrN5c3J/rVA22CkMZKXbw7QY2YfYqWGJ9ATtpPL
         FGosyL5MqK02lxAOv9YLgji4r9hJhy9f7eOFrr7M1TFWtAuTclQBneVL4+eVwAwdCT8h
         D85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723340; x=1770328140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=httfifXiFd5uWoo/mGZ7s9cURALbGmXfpP+U9cGf6QY=;
        b=o2CbhusZ3PupjJiEmpO+D6y5li1suV6WX/7G9fAwUXB5r3HJtgfamrDyvS5XfTKo5P
         UV6TWADmJdKWBS+O/39ExlTcA9qutpkMnrUWrpF4vv8BaIobHTjkzn2gQNmRjFl7ByaT
         DN45xvrLyUtKlt/H7jZqx1k5Pn4azNqXKHoNNRpqVgRe9fHkE2XNac6LUGLlueQCZ9Aa
         U2s24+g31SzN2SKk4lM+Z7UjwmFcEILD8RlGPVN/x9/VPsrFunWjiEUQJKZgYAJDKnPd
         jhjIw9AOdEH9tnfXMAzUVwd5ZzHyDkwr0UBnqxEmjODxlWaXbd8qHcerGNh8VL8wJ6fj
         Jp8w==
X-Forwarded-Encrypted: i=1; AJvYcCVPbOU16y8xFL0JsBIPtNC9s11vs6rVVOIk/9Ntm3ZB/UOIbQCGkAk4WPKOHAKiJJYqHEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn26B2Ac7Mfa5OnJDdLMWA4PzXmEvVfSZVPmq4qwN9dSqhhjd3
	PZJ6b67cEXxu2pBRaQbL1ejai11jL+61BOc49u608P9pQf0xx0N4Eueg7I2HaM1/0D374mR4Hrz
	C3aIJT0To2fBp9lD88N1Rxtcl5wkWvWU=
X-Gm-Gg: AZuq6aLLK+yygdvfMZx7KZl3FYYhTgbZy/i8Z0uyBuyzb8RVlgXWJ8c+c2xURIttDJT
	izFPFfJpFsZc8bhg1A7mccOaRp6jAyssf7DkZ+jNDA5fX5W7u4biylnLHimjN9VpMB860raI5Dd
	ilOeRaRopdu4jf6JMGA+iMJxgwCIpoo+cuQ4IlWFYuR8VM+n2htrWEzbqpZylcRLelEWVRfwL/z
	TxK20nYS6slTzSY60qexgWvhTS1AWbmGuD1KwRvkZN6Jzp4u8X1syIrTPYUdXWzsSI0VU24qPtf
	kL/PLWd0KNg=
X-Received: by 2002:a05:6a21:9f17:b0:387:9522:b667 with SMTP id
 adf61e73a8af0-392e01a9ba9mr436688637.78.1769723339613; Thu, 29 Jan 2026
 13:48:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128183232.2854138-1-andrii@kernel.org> <a1214f2e-dbf7-41d9-ad8a-703193c84b67@linux.dev>
In-Reply-To: <a1214f2e-dbf7-41d9-ad8a-703193c84b67@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Jan 2026 13:48:47 -0800
X-Gm-Features: AZwV_QjLHC0kasaHM3AkD2XKoLB6u8t98t0cWiOvnfOHfn8IRgpugerxu8FUGsk
Message-ID: <CAEf4BzbvQ2wAaf61kGF7Wa2UUk4FvXBMxv2S4qReZ8Pr2eQW_g@mail.gmail.com>
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org, linux-mm@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 7:52=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 1/28/26 10:32 AM, Andrii Nakryiko wrote:
> > Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_l=
ock or
> > per-VMA lock, whichever was used to lock VMA under question, to avoid d=
eadlock
> > reported by syzbot:
> >
> >   -> #1 (&mm->mmap_lock){++++}-{4:4}:
> >          __might_fault+0xed/0x170
> >          _copy_to_iter+0x118/0x1720
> >          copy_page_to_iter+0x12d/0x1e0
> >          filemap_read+0x720/0x10a0
> >          blkdev_read_iter+0x2b5/0x4e0
> >          vfs_read+0x7f4/0xae0
> >          ksys_read+0x12a/0x250
> >          do_syscall_64+0xcb/0xf80
> >          entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >   -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
> >          __lock_acquire+0x1509/0x26d0
> >          lock_acquire+0x185/0x340
> >          down_read+0x98/0x490
> >          blkdev_read_iter+0x2a7/0x4e0
> >          __kernel_read+0x39a/0xa90
> >          freader_fetch+0x1d5/0xa80
> >          __build_id_parse.isra.0+0xea/0x6a0
> >          do_procmap_query+0xd75/0x1050
> >          procfs_procmap_ioctl+0x7a/0xb0
> >          __x64_sys_ioctl+0x18e/0x210
> >          do_syscall_64+0xcb/0xf80
> >          entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >   other info that might help us debug this:
> >
> >    Possible unsafe locking scenario:
> >
> >          CPU0                    CPU1
> >          ----                    ----
> >     rlock(&mm->mmap_lock);
> >                                  lock(&sb->s_type->i_mutex_key#8);
> >                                  lock(&mm->mmap_lock);
> >     rlock(&sb->s_type->i_mutex_key#8);
> >
> >    *** DEADLOCK ***
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
> > ---
> >   fs/proc/task_mmu.c      | 42 ++++++++++++++++++++++++++--------------=
-
> >   include/linux/buildid.h |  3 +++
> >   lib/buildid.c           | 34 +++++++++++++++++++++++++--------
> >   3 files changed, 56 insertions(+), 23 deletions(-)
> >

[...]

> >   /*
> > @@ -348,7 +347,26 @@ int build_id_parse_nofault(struct vm_area_struct *=
vma, unsigned char *build_id,
> >    */
> >   int build_id_parse(struct vm_area_struct *vma, unsigned char *build_i=
d, __u32 *size)
> >   {
> > -     return __build_id_parse(vma, build_id, size, true /* may_fault */=
);
> > +     if (!vma->vm_file)
> > +             return -EINVAL;
> > +
> > +     return __build_id_parse(vma->vm_file, build_id, size, true /* may=
_fault */);
> > +}
> > +
> > +/*
> > + * Parse build ID of ELF file
> > + * @vma:      file object
>
> Should this be
>       @file:    file object
> ?
>

yep, thanks, fixed

> > + * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
> > + * @size:     returns actual build id size in case of success
> > + *
> > + * Assumes faultable context and can cause page faults to bring in fil=
e data
> > + * into page cache.
> > + *
> > + * Return: 0 on success; negative error, otherwise
> > + */
> > +int build_id_parse_file(struct file *file, unsigned char *build_id, __=
u32 *size)
> > +{
> > +     return __build_id_parse(file, build_id, size, true /* may_fault *=
/);
> >   }
> >
> >   /**
>
