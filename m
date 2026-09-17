Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDD488763
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682920; cv=pass; b=QLuIbxpAu7to1xriYjBtJOmkAadpfOkgViP7artIAeFUCYt2MMa9rFtGSRYig57IgeukPQJR03w2LRk9px9zTfcGzfQ37dYuoKvEoWW6w5UxmZA2OaKvos1z8EPTI3sskwFdPljxHtMWOSYhxeuKX/WZsSlCMV+csTNN6jh+lMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682920; c=relaxed/simple;
	bh=WEffpYkzJdpcof7//vhZaWVBn1DV5Ei0c5Zv3VvmoH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEP03hKHmq2PFY8z6rOwY4e82fY5Z+QtMYMIafyd98iUEmamHt8bD1nKkEdFjf6Qi6v4xcvDkYguY6EJzGKSyD2VCRpWQ9aDSilgQI71XwksaPoSTGUUuVf7P6QkyA+Y8YSSUgLl9oNeEbI/A/xWFq30ZpHlQuV6S0+zHyEpmhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7679afj; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7679afj"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eefae4so209245ad.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 15:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789682917; cv=none;
        d=google.com; s=arc-20260327;
        b=gYJMZVBj9a8fJRPhtJSuszUFoZp7l7HiEe65xP6q3gdcC4z1N2Bmy77uxDEbpS5S2m
         POs8Lrm4ZDozV3FxXknZgyO2qCngzbJoY4X8k9lQ322raUlwifJLaP/9g93a21eBuY9V
         Z69i9/WQOCKxvzG9tGZH5PJ5CwCj0XVyvPcHDIE7U3RspbETumjRQsHWcygXMhpcyVnV
         8ljrIvL4cI9B5FdG34nnWZdX5fG5Zply4XTHyO2VIxy5epKfvXYq0RO1wHy3Wzbcyxou
         6BXpddMOwBSY9pRl1YYCezF2NJhv3/XRtd5oMuAkg+6KWbxnjxJem+gidxQPaNBimlWB
         7J7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2UAipQLiMZFJPFAN47iCUjg7J+/3vsroXmj0OXmT6U0=;
        fh=K0Xx2sNdATDdTEazM4lOuy4jN0FmnNrGewpbXY+dyqo=;
        b=TqMmSoCn0r/jPY2xqVR6ZqxGvaGbBrmeBuY5CyrBoMi3X8Y385ndzrqV5p3QAl6TOX
         YvpK4mkTymITfKVLn4eAsggwgXkNJ8Rj/g41zj8SgxHO18fGw8oMUgzQ5oxZIl2adJSB
         VHXHPZauYzBPepaV3LdQN2EBvooLZ0cAGua/k2taRcluG7XvrdkQ90vF9eWMZ2MZ6nhO
         aRuGJagzKfYrjsXsJWtZW2kzrsGjpoj526/T7oEZQrkKAVwhdMi1hMPTUR5PYrU0FiOX
         PQ096iHSM5eW8QAKV9nA7heBZwXo5ajsI1Kzf4fjFEyMEp5Aj0/5ejI5F24AM2fqL7YB
         1XoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789682917; x=1790287717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2UAipQLiMZFJPFAN47iCUjg7J+/3vsroXmj0OXmT6U0=;
        b=J7679afj9rPIw4TUBQEaHbEA6wt4hnb035+wsrXLAsNCfySxh+8KR+JLBBF1cf9Qxc
         CBqv1IsKwsW9orqE0ZyBYyut4JkRLBfXKXE8+mdvgA+2N8r2K9VvOTMgyvCD3AR2Z75G
         VsNgJOmojCnfxU/Hi2myDAFXusIHyKjmCQPrpcfyVhlwo9tKn9FIl1n+M1oz5Knr7zdg
         NIEsjxA9rvMC1RS8+eKK/Fy+oKATrhSOCJaHGy1YGIuE7lvGMYEE/ZtZVyJpeR5MZkx/
         Kerk7H0h1lBLvaDFQvaqB5oCEtRk650v99drbqtetUgrK5PoUsVBk2gVT8MZwwdPiyha
         zwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682917; x=1790287717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UAipQLiMZFJPFAN47iCUjg7J+/3vsroXmj0OXmT6U0=;
        b=pez/2AcGVdv8z2G47EC15YjNhoGsJhWFakumwQJwtd3dWJajkdsXq73Ldt5T5VmvQ5
         HspZrvHj/E4ca0rruesOGv5ND2O6BumS9TBScw+i1y1szqmisc/PGxOCbGQ1NNiDK+8n
         FQclPgDjVngf8wifh0fKab+cGU9QOLFqfR9mIHbA67LhcPxPR62EQSU2nz1qLqUEEBzx
         UF0eMHVltqs5IflfYjjsi/y7AZ4xmXeBnElw7LURyabEf5pHat17QFzfXLlbR5XWsoYX
         1M+jC/B/lE/O0t4SRK2QP4ZyLzCMM4kVAtlntFc6BgArIc967af+RHNaE2UXjnPQarlU
         C5iQ==
X-Gm-Message-State: AFuF++mfgk4b0LvYDcHFIARGVmtugrVCPipfhyZq+AY53qAcs0b4j0MK
	mFiBXrLx17yhXCX3F/b6pl4bGtMsFA3+vpLHj1LAr6FLS/rGlKYH9n2p1vaNu+kdHW1vMzBfkcu
	qHI2IV+nMcdn8cQjM6jPxFCLTZqq/AUniAMsW
X-Gm-Gg: AYBFou3aP/hDzwuc7CGpRtYjx0vinpdJJackHZ3yLsxIM0zDvTVlaTi0aa40yZZWOsA
	1cFX8LexSwE1m1fJr0CVkRfIu/lC4gtyZhnk66nKKDj+nmSzQv8LiYX770daQ2aOpMA6o00LyT4
	u+YF6aIFWy2LxfWjUJWuMMcS8aMoGo4A/2vE13BLhoXfroXhnb+eGWxY/Jx7H06mREPWjSPwhzO
	m4ufZR+cOJeoaPpDkrdy24QMy5xJSJWQ+8+sv1mxrgZSBVyRNlFRhcBmcDRy/QwSMxLAdUP7LnF
	mEXez/5WRnZ6lHihdzCjbzmGV0VeBMGqnm3JmEprB21BPJ2dS1NBtItm0kmEbPzhjBawQ7gTs3c
	aVMKXipcSTi44XaT6/JMEYdhoaadwTR5O4aevpEGzHj+RhMB8dz+p
X-Received: by 2002:a17:90b:574b:b0:39e:3221:aff5 with SMTP id
 98e67ed59e1d1-39e5551f5d1mr433476a91.9.1789682917122; Thu, 17 Sep 2026
 15:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915080255.48929-1-tasos.papagiannnis@gmail.com> <20260915080255.48929-2-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260915080255.48929-2-tasos.papagiannnis@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Sep 2026 15:08:22 -0700
X-Gm-Features: AcwNN1Xx3soFgybIiTwKKrBQJfTZVl5aXHZvWrQvKnskNl68sL311oeUiJ_wUSM
Message-ID: <CAEf4BzaH=PJh7QUhh7szGL+gCieYLOSbhriFWaZG92xFWDeGig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/5] mm: Add copy_remote_mm_str()
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@kernel.org, 
	akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	brauner@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	kpsingh@kernel.org, ljs@kernel.org, matt@bobrowski.net, memxor@gmail.com, 
	song@kernel.org, sun.jian.kdev@gmail.com, utilityemal77@gmail.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:03=E2=80=AFAM Anastasios Papagiannis
<tasos.papagiannnis@gmail.com> wrote:
>
> copy_remote_vm_str() gets the target address space from a struct
> task_struct. This does not work for an address space that exists but is
> not yet associated with a task_struct, such as the mm held by struct
> linux_binprm during exec.
>
> Add copy_remote_mm_str(), which operates directly on a struct mm_struct.
>
> Use a common internal interface for the MMU and NOMMU implementations
> and define both public wrappers in mm/util.c. Preserve the existing
> copy_remote_vm_str() behavior, including handling zero-length requests
> before acquiring the task's mm.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  include/linux/mm.h |  8 +++---
>  mm/internal.h      |  3 +++
>  mm/memory.c        | 41 ++----------------------------
>  mm/nommu.c         | 41 ++----------------------------
>  mm/util.c          | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 73 insertions(+), 82 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dd09c438fa23..63f40e615754 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3325,10 +3325,10 @@ extern int access_process_vm(struct task_struct *=
tsk, unsigned long addr,
>  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>                 void *buf, int len, unsigned int gup_flags);
>
> -#ifdef CONFIG_BPF_SYSCALL
> -extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long add=
r,
> -                             void *buf, int len, unsigned int gup_flags)=
;
> -#endif
> +int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +               void *buf, int len, unsigned int gup_flags);
> +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +               void *buf, int len, unsigned int gup_flags);
>
>  long get_user_pages_remote(struct mm_struct *mm,
>                            unsigned long start, unsigned long nr_pages,
> diff --git a/mm/internal.h b/mm/internal.h
> index 38b1165212c9..557b29381355 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -25,6 +25,9 @@
>  struct folio_batch;
>  struct hstate;
>
> +int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +                        void *buf, int len, unsigned int gup_flags);
> +
>  struct huge_bootmem_page {
>         struct list_head list;
>         struct hstate *hstate;
> diff --git a/mm/memory.c b/mm/memory.c
> index 8b0c2c735d3d..fe2f5e988fb9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7331,8 +7331,8 @@ EXPORT_SYMBOL_GPL(access_process_vm);
>   * Copy a string from another process's address space as given in mm.
>   * If there is any error return -EFAULT.
>   */
> -static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr=
,
> -                               void *buf, int len, unsigned int gup_flag=
s)
> +int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +                        void *buf, int len, unsigned int gup_flags)
>  {
>         void *old_buf =3D buf;
>         int err =3D 0;
> @@ -7407,43 +7407,6 @@ static int __copy_remote_vm_str(struct mm_struct *=
mm, unsigned long addr,
>                 return err;
>         return buf - old_buf;
>  }
> -
> -/**
> - * copy_remote_vm_str - copy a string from another process's address spa=
ce.
> - * @tsk:       the task of the target address space
> - * @addr:      start address to read from
> - * @buf:       destination buffer
> - * @len:       number of bytes to copy
> - * @gup_flags: flags modifying lookup behaviour
> - *
> - * The caller must hold a reference on @mm.
> - *
> - * Return: number of bytes copied from @addr (source) to @buf (destinati=
on);
> - * not including the trailing NUL. Always guaranteed to leave NUL-termin=
ated
> - * buffer. On any error, return -EFAULT.
> - */
> -int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> -                      void *buf, int len, unsigned int gup_flags)
> -{
> -       struct mm_struct *mm;
> -       int ret;
> -
> -       if (unlikely(len =3D=3D 0))
> -               return 0;
> -
> -       mm =3D get_task_mm(tsk);
> -       if (!mm) {
> -               *(char *)buf =3D '\0';
> -               return -EFAULT;
> -       }
> -
> -       ret =3D __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
> -
> -       mmput(mm);
> -
> -       return ret;
> -}
> -EXPORT_SYMBOL_GPL(copy_remote_vm_str);
>  #endif /* CONFIG_BPF_SYSCALL */
>
>  /*
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 498e01ee40b0..98596e60311f 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1746,8 +1746,8 @@ EXPORT_SYMBOL_GPL(access_process_vm);
>   * Copy a string from another process's address space as given in mm.
>   * If there is any error return -EFAULT.
>   */
> -static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr=
,
> -                               void *buf, int len)
> +int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +                        void *buf, int len, unsigned int gup_flags)
>  {
>         unsigned long addr_end;
>         struct vm_area_struct *vma;
> @@ -1781,43 +1781,6 @@ static int __copy_remote_vm_str(struct mm_struct *=
mm, unsigned long addr,
>         mmap_read_unlock(mm);
>         return ret;
>  }
> -
> -/**
> - * copy_remote_vm_str - copy a string from another process's address spa=
ce.
> - * @tsk:       the task of the target address space
> - * @addr:      start address to read from
> - * @buf:       destination buffer
> - * @len:       number of bytes to copy
> - * @gup_flags: flags modifying lookup behaviour (unused)
> - *
> - * The caller must hold a reference on @mm.
> - *
> - * Return: number of bytes copied from @addr (source) to @buf (destinati=
on);
> - * not including the trailing NUL. Always guaranteed to leave NUL-termin=
ated
> - * buffer. On any error, return -EFAULT.
> - */
> -int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> -                      void *buf, int len, unsigned int gup_flags)
> -{
> -       struct mm_struct *mm;
> -       int ret;
> -
> -       if (unlikely(len =3D=3D 0))
> -               return 0;
> -
> -       mm =3D get_task_mm(tsk);
> -       if (!mm) {
> -               *(char *)buf =3D '\0';
> -               return -EFAULT;
> -       }
> -
> -       ret =3D __copy_remote_vm_str(mm, addr, buf, len);
> -
> -       mmput(mm);
> -
> -       return ret;
> -}
> -EXPORT_SYMBOL_GPL(copy_remote_vm_str);
>  #endif /* CONFIG_BPF_SYSCALL */
>
>  /**
> diff --git a/mm/util.c b/mm/util.c
> index bf0513d1d3d0..47c2e3ae8496 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1061,6 +1061,68 @@ int get_cmdline(struct task_struct *task, char *bu=
ffer, int buflen)
>         return res;
>  }
>
> +#ifdef CONFIG_BPF_SYSCALL

AI has a point, declarations in mm.h are not guarded by #ifdef
CONFIG_BPF_SYSCALL, no? These look generic, I'd remove BPF_SYSCALL
guard

pw-bot: cr

> +/**
> + * copy_remote_mm_str - copy a string from a remote address space.
> + * @mm:         the remote address space
> + * @addr:       start address to read from
> + * @buf:        destination buffer
> + * @len:        number of bytes to copy
> + * @gup_flags:  flags modifying lookup behaviour
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destinati=
on),
> + * not including the trailing NUL. If @len is zero, return 0 without acc=
essing
> + * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
> + * -EFAULT.
> + */
> +int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +               void *buf, int len, unsigned int gup_flags)
> +{
> +       if (unlikely(len =3D=3D 0))
> +               return 0;
> +
> +       return __copy_remote_mm_str(mm, addr, buf, len, gup_flags);
> +}
> +
> +/**
> + * copy_remote_vm_str - copy a string from another process's address spa=
ce.
> + * @tsk:       the task of the target address space
> + * @addr:      start address to read from
> + * @buf:       destination buffer
> + * @len:       number of bytes to copy
> + * @gup_flags: flags modifying lookup behaviour
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destinati=
on),
> + * not including the trailing NUL. If @len is zero, return 0 without acc=
essing
> + * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
> + * -EFAULT.
> + */
> +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +               void *buf, int len, unsigned int gup_flags)
> +{
> +       struct mm_struct *mm;
> +       int ret;
> +
> +       if (unlikely(len =3D=3D 0))
> +               return 0;
> +
> +       mm =3D get_task_mm(tsk);
> +       if (!mm) {
> +               *(char *)buf =3D '\0';
> +               return -EFAULT;
> +       }
> +
> +       ret =3D __copy_remote_mm_str(mm, addr, buf, len, gup_flags);
> +
> +       mmput(mm);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(copy_remote_vm_str);
> +#endif /* CONFIG_BPF_SYSCALL */
> +
>  int __weak memcmp_pages(struct page *page1, struct page *page2)
>  {
>         char *addr1, *addr2;
> --
> 2.55.0
>
