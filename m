Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A12D9792
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341978; cv=pass; b=MopPKxe6M8HCNDP7wgNIvBXt4SYge/9Qt46Y/Zv+1HkMwlwp07y4AH+IYN0it5vmCc+5FaOI/Edijmuncd/2GtZ1xtw0dCgjCrnHMFLjBNVKanHPKZcDwL5wziaFp2RBrCpRzDL7nG5js74cKqoMX0SCh48kF2wyAl9qH+q/qTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341978; c=relaxed/simple;
	bh=SnKQAy4ryaVHU37EB0MreTs2voS4T4xBNuc5Ub8JIHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ecz1xKAFPJyX55xy/Rjnxj00sS4jzhn8fyHMdLqhNPA79w4w2LX9EzhvzfQPC/2iCtlVspWmMYg8gOWT6KU7qO8nDyvJpXir5nlHfzP3Hzsfqy/tTVaPxeuyTYfPylsU2Nh1gKRx/oRTpNGK1qCYaIDjoibKRUYMUWUCb/nX9gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXbz86LK; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXbz86LK"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1203797a12.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 12:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787341975; cv=none;
        d=google.com; s=arc-20260327;
        b=ZCwZgqAiGDkZPOeib3DZkEOO5fNcf+GOZVFwdJBtFjvTEtJoTLy6bRMxEIj1fJFkl0
         oaHuxdg1Cb2O7Fbaq5K2kyd+pu7dW5Q9RQnm4jQfPcGe69dYgUjOw3lxv9yeAw3IOrkA
         Li/4/eR+gz/TlHFnfa60z8953euqR+1wO4OpbVttO5xdU7uPl3qanpd2+Beq+5YCurDT
         UMu6CTNNneaG3qNr9hzyvYGwwfiR9FrrYej3M9XkQNDiF6fLUnDzzbUBcEUimMyRhGkt
         tPqE2k9FYK0tb4Rn31v6j8etrnTBL2yw9hn7OD5hthEU4sR3ChVrhmx0KT2Dm3iHBojI
         E2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KidtnQB/eYDDRfHgfBWu/wvFzRWxKzN8GJX8+RxP7Rg=;
        fh=WV/XN5X1oEf527+V7W8SMtugzL9N6qpwP4JTepq8Hy0=;
        b=hWY1Md7mAdQeS5ETFOTE+AQiqf/EK8dqmXHMHshELRe4QI5U2fEOsk3QtuXDbvXHpY
         hqhaUmxT0bYN0kdVXKyMqgEDp+ZmEWziLfTfMWpsXNENJ84zhUeqSGJ/TJj72CxaclMw
         HKf0FE6uMCqQkebO3xJL6I4W8dZNhjIXC7j+fnXlPwl9UhExZ+G/yc6RmyLYZBF3nKLc
         l39NHLz6MCJCge/IGVXFsRvNIMdAsim5KmB7Z+VFHQ7u1yE3QXKbxukAehWxJosTW2s4
         NbgSGFrJUZwWmU1MonvPCY4fJhm84jegHlzFsJjdfWi9HJtqD4piDk/HyCTHhEg8yJ0e
         DmQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787341975; x=1787946775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KidtnQB/eYDDRfHgfBWu/wvFzRWxKzN8GJX8+RxP7Rg=;
        b=bXbz86LK5KjNG5EcT5fxHHKkyhF/4R9FHatgg2zQafWVgEyfDra/0CygNwJrcY8EsT
         tLI/o4cnu8GxXWVRSLHguT5/VmJfqKwT0aEc4aa2sNyqwOQnxEavUaO4rqyrfmzDH27c
         nNJbFFp13eUPsRZtMrSt3UNDwbnQGL+oy9MrJSBarB6QBfKCyCGFn/SCJ2Rfe4XF9vGv
         AYssl7fwSF+r5j+o0e5ze730MiQl5OuvGcHLfLYlz3n8+PfYOcfcrEQfDzA2a6jyLRtT
         6+ZKJeVwycKw9E8CJKTYfuZREtoy0YKtRHjIF1JzIYhB035Vk/HvkqXUhTtg/PN4iIhP
         hl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787341975; x=1787946775;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KidtnQB/eYDDRfHgfBWu/wvFzRWxKzN8GJX8+RxP7Rg=;
        b=CshhtzjzZUehbFcsmePztqlLUJGU1C2F8U1RMVs0SEBLWbVPgW1t36H8YhiD9255QP
         hvcOdH5/Jri+rX1zAbyviW6V85cQRVc0/TozmoVKAzBQ5sq8hegvCKQZGiOHftDiHiAm
         /PslapIQITmvWDmm2APpkJNy4Se4uk69K6ikz5IZsGFZ7lRqHpzCKbknaA+kGURgqq4m
         cBr+3VYsa9P1SQ2B7VecVF/qGWOm3xC3hgJ0LgyH9v7FONpSq65KwHJWNNSaN3GU4f68
         jceL4uv5bXILDsDej8f1pGkzcTyhn3jHvY2yHodTf37XpYdhR3Asf58xrTo1iJHdoR8W
         8Gtg==
X-Gm-Message-State: AFuF++m1bT0FYl4NDmi88V+hAPRYdwUDgu2cN2iNv6tEoJ4/IW5bOIxC
	wgZ1D/z39Qh86XCR2h19wl2HF3rEJRXlLkV8UZ8c01Av2Q5ZBzYFLSHp91wy+TY9GCizbUPPMY4
	E1ptBSGCD2+4UhxBQlKIhRB1a0/rAUXM=
X-Gm-Gg: AR+sD13Dn+J79stagt0aUPEmCPHX8fdLgUhY9muCyl+xkkK7clyuArJqFJLA7hUsdGW
	gb1OpvlxMOLwpVPalQi1iIfDcF+w0E0gxoHM7LocAAgDTspQQ1nlTCaImSLtlqoN+uDgFcP4a3u
	Foltz5Y8ULmyVbLHDUh6EKYiCrT1SD2/qOAFoqdSsupQ0xHw3MhSyqTG5kJ9LrUA80om5SB0vxP
	WqoRS8ubhuAfqn0aG2E5ANY6HWIymcbV1mVFGcGx/5sPmti/y1Fh8o5zIYPRUjzsbL8qgp/ilYf
	Hvi4GZv0vYzM7FNkLjziNtCrrVv/prYhsZbrfk5tNnkDueUR0xbX4qIZFV0z+OhtU75micsR0YV
	uUNrjc3+fKKF0A9eD/dYKNJ6z9w==
X-Received: by 2002:a05:6a21:6492:b0:3cb:853e:850e with SMTP id
 adf61e73a8af0-3cd4bbe8aa6mr2217187637.13.1787341975075; Fri, 21 Aug 2026
 12:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820131801.68759-1-tasos.papagiannnis@gmail.com> <20260820131801.68759-2-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260820131801.68759-2-tasos.papagiannnis@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 12:52:42 -0700
X-Gm-Features: AcwNN1WiobjREO1ATp2ZQpfgWCtJVvDwcD8UEwKRu-9pDckvpVIFCNaWpSBtzYk
Message-ID: <CAEf4Bzb-43E7JSc5aNBEi4y1PKfQvjRi_FwTUyP7cYaQ+-JqXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] mm: Add copy_remote_mm_str()
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
> copy_remote_vm_str() gets the target address space from a struct
> task_struct. This does not work for an address space that exists but is
> not yet associated with a task_struct, such as the mm held by struct
> linux_binprm during exec.
>
> Add copy_remote_mm_str(), which operates directly on a struct mm_struct.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> ---
>  include/linux/mm.h |  2 ++
>  mm/memory.c        | 26 +++++++++++++++++++++++++-
>  mm/nommu.c         | 26 +++++++++++++++++++++++++-
>  3 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 485df9c2dbdd..eede435bf4a3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3222,6 +3222,8 @@ extern int access_remote_vm(struct mm_struct *mm, u=
nsigned long addr,
>                 void *buf, int len, unsigned int gup_flags);
>
>  #ifdef CONFIG_BPF_SYSCALL
> +extern int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +                             void *buf, int len, unsigned int gup_flags)=
;
>  extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long add=
r,
>                               void *buf, int len, unsigned int gup_flags)=
;
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index 6b8280cfc1db..da0010c4475d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7218,6 +7218,30 @@ static int __copy_remote_vm_str(struct mm_struct *=
mm, unsigned long addr,
>         return buf - old_buf;
>  }
>
> +/**
> + * copy_remote_mm_str - copy a string from a remote address space.
> + * @mm:        the remote address space
> + * @addr:      start address to read from
> + * @buf:       destination buffer
> + * @len:       number of bytes to copy
> + * @gup_flags: flags modifying lookup behaviour
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
> +                      void *buf, int len, unsigned int gup_flags)
> +{
> +       if (unlikely(len =3D=3D 0))
> +               return 0;
> +
> +       return __copy_remote_vm_str(mm, addr, buf, len, gup_flags);

we should rename __copy_remote_vm_str into __copy_remote_mm_str

> +}
> +
>  /**
>   * copy_remote_vm_str - copy a string from another process's address spa=
ce.
>   * @tsk:       the task of the target address space
> @@ -7247,7 +7271,7 @@ int copy_remote_vm_str(struct task_struct *tsk, uns=
igned long addr,
>                 return -EFAULT;
>         }
>
> -       ret =3D __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
> +       ret =3D copy_remote_mm_str(mm, addr, buf, len, gup_flags);
>
>         mmput(mm);
>
> diff --git a/mm/nommu.c b/mm/nommu.c
> index ed3934bc2de4..1fca0bb7f042 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1752,6 +1752,30 @@ static int __copy_remote_vm_str(struct mm_struct *=
mm, unsigned long addr,
>         return ret;
>  }
>
> +/**
> + * copy_remote_mm_str - copy a string from a remote address space.
> + * @mm:         the remote address space
> + * @addr:       start address to read from
> + * @buf:        destination buffer
> + * @len:        number of bytes to copy
> + * @gup_flags:  flags modifying lookup behaviour (unused)
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
> +                      void *buf, int len, unsigned int gup_flags)
> +{
> +       if (unlikely(len =3D=3D 0))
> +               return 0;

I'd just move this len check into __copy_remote_mm_str()


> +
> +       return __copy_remote_vm_str(mm, addr, buf, len);
> +}
> +
>  /**
>   * copy_remote_vm_str - copy a string from another process's address spa=
ce.
>   * @tsk:       the task of the target address space
> @@ -1781,7 +1805,7 @@ int copy_remote_vm_str(struct task_struct *tsk, uns=
igned long addr,
>                 return -EFAULT;
>         }
>
> -       ret =3D __copy_remote_vm_str(mm, addr, buf, len);
> +       ret =3D copy_remote_mm_str(mm, addr, buf, len, gup_flags);
>
>         mmput(mm);
>
> --
> 2.55.0
>
