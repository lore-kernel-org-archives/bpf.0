Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711E223C50A
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256035; cv=pass; b=FH960cR8CHn1sQniYKwE4b6UGcClOik/ZJwX20d6sjxRnhO6ij2+3PwseLVJj+EDjnj0aLmU1moCTc/INBy/cuoV/yxrfsowJkSQlLIxdEZUNOUX3jBxRBH8+kRTNYg1+o1bUXLzqnO9OiBnXB+Ta0qdDOzdUp5xxq+QOZ072S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256035; c=relaxed/simple;
	bh=hFRBK6KpwBBGpssFA73yb22Ddkh8qpZkts54f0kxqcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufoP1qZy7RMlT6HGc0T6fLjLuHXijPRL1vfiOmUZMNlfJo5XiDMfJDpVP4nwryULujaGh3qjJf+8r5I0u4LhTu+BC2+8y6yskaokcJ+asxWmxOqfRt1pnSLS0X1I2XFuuksFw4spM9Bf5LYYkM85X5OYF4VuuB94hYDN2z/VsSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwHENp+l; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwHENp+l"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82976220e97so142896b3a.3
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773256034; cv=none;
        d=google.com; s=arc-20240605;
        b=c+nz9SU5i4R6F8S+3qVNSPcu8Ee0zGJow5uNdWW7kzd3jQeVV8tDuQpLVqYAwT/jMl
         uj8/gJctizmpTHlyXB47EvenHrZ6YJtYSIiJ8RuhJNXpzL/LOXZ1mu4fwTfWW+X8yn7R
         UjfY5CwsoT6X/ap8+ekDIDc1UzL75hGTDtL9+gvu93+F7mYWIpfb0UOXf0NtUlgBNRYS
         pKcmT+mJoWlzuiaVX+Xayin1X+dbe6hjuL7oBzy7bzF2P2CEeF8vTnABXVSV5mBiFvBv
         z9Jmhhg5V162nkK2Wa/NDsDkeuzRbIMgiEVe7mXtl1aWr/JdhnR5+NrINyE0+v3fXwZ8
         4ubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u3mCcSLbcOcj1+TTvV6dKV23UK7ZIHGVZxAEOZvX0JQ=;
        fh=3JFULSt81QhP9ARgOVVWpn+UY1r04WcyvJhNnAO9JVY=;
        b=YoJ3MGPbf79Vz8AH6mqmBzlYSmYCoadhIgdT/8r4nNmk7KZscdZejWMHuT4gDcML5D
         mqpWvQj6KXeIlK5d0ZjP2wG9x3KQD0oHJn4pkO3uaQSI/MAaubwqNzchR5T78M6Li+5E
         +NKLou1mvlQgBWn81cXo+GuzLSkOaS/LsYKD/vguDAjZCxiMtQlGm7a2u8wPHfpWIpMw
         lwTitzzASqe1pW0Pk1WkxsOPsublDyS0hzn+MQGbxogkUAGZmE6b7XPI6jO7jrGQt3Y8
         EtN8nwjjYIncEYh69+Opnse1OtqjUJsovNbc48Sv2uL+yKomDUI/hn1ATAi5fkZVmj4k
         +RUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773256034; x=1773860834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3mCcSLbcOcj1+TTvV6dKV23UK7ZIHGVZxAEOZvX0JQ=;
        b=ZwHENp+lhYdcbVJYfHpCrLBxdXRKrwDB5Cyhto7XXDHfEeOsiW9dq5EGaEdiwm6hJG
         nW1JhN9lyfu9ucyYU8FZrpQoCVeGg5jQvXlQfrOQGzVIEVTYFIld5SKqWiy081cTtZDC
         YHLtAn7doB3R8X3g1pJZ+z30h+BIpOC56qSOLqXW+//LeFMRv/uqxa42sYzULbik+zF6
         bfb42L8tW9zRzU29G6Dgh3GMSOgxzSbPqJmr9k0DmNTjEfQXdU8gE0gKVwgWiXO04a9w
         nT+ZGlG28Z9Mdd1g97Sz1I5652kQGHXrAhbg22eUUKAYfGnz5R7sOTB54yb0sXud++Q6
         sAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256034; x=1773860834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u3mCcSLbcOcj1+TTvV6dKV23UK7ZIHGVZxAEOZvX0JQ=;
        b=oJ1gaGyxuaW0sBG+aEwHSlX2/1oBYCvdEOH69Q3nkNR9HrmLmkeKxRTjoLBepFQ7Xm
         ANUeGJntA9EcyBEkaj3frG5r5SJkMe+kqmipFvhj7hbJM7oipb0QZG8qienJpj/TG4O1
         Cx9p4ynfuPb/ret4L5ihhwME8tUNNcWbnKlr2p3Qcukn5q3/g1QaB4spesyHByRdBMHO
         FVgVvtq5WCs2icsVH9delTktbvQ+RbaSRRbqA2xPx8TEGnZR2OzBvYYhDMCHnZZQJXCy
         uF6k6X6VwTTcF4cPvgRojNrwM0+dEyMIIUR6AWi6GUFY7iT3c9tVor9Z1zpAHcDPqFTU
         rlFQ==
X-Gm-Message-State: AOJu0Yx1b4UQcg80xIg8zx2085KU6hyb/tyJbE2YE72vjl8sB6B0mjKo
	NE+7jXgUwWEh4r/kZ+PuBjroVsBBZFPeRnf51i3JvIWJ8vZJc7dh1k8gk3cjrJZLjwW8qx7d63K
	hmGo6N45r+r5eEgIuGsv/WxD/4HPmoJw=
X-Gm-Gg: ATEYQzwsW3GB1i1TC3reCOAa+OQsPzy4p2cuZNVW2eXaNJG/F34TfLrysoTf4Zzt3SI
	zOIIJ2/CO4Ymby3ejkX0KqcsDq7GsZTEGgP9RW4L0uWmVL+gJM+spHgXNxBBVXa3sKYcv6ku5Xn
	coPgHGmz1Tv56qCnCn80gx3/shY+qlF0U2NO2/FEpfocFLmQ7yKv3mN2f4JBXS9TlQ7b1+bC/J0
	FDxoQXIajDqr81l/Jw1RCi8xnHkZbkpUwJrPdxmn+gPVHadYf8LpaMu7g5w0yWMao0IUouHnGQ0
	jdiZnx4=
X-Received: by 2002:a05:6a00:1c8f:b0:823:1570:1e81 with SMTP id
 d2e1a72fcca58-829f715cf82mr3085330b3a.53.1773256033638; Wed, 11 Mar 2026
 12:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155506.23490-1-puranjay@kernel.org> <20260309155506.23490-5-puranjay@kernel.org>
In-Reply-To: <20260309155506.23490-5-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 12:07:01 -0700
X-Gm-Features: AaiRm53WRb3jbJxeVvktbY1LTV549iBkkY4mAK09vo1n_RFbyB3aubJZg0c0wCo
Message-ID: <CAEf4Bzb9aPiAxOfo+_L6iaZPGrk3mPQ+6yuA6msTUHOV=xbGfg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 4/4] bpf: return VMA snapshot from task_vma iterator
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:55=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> Holding the per-VMA lock across the BPF program body creates a lock
> ordering problem when helpers acquire locks that depend on mmap_lock:
>
>   vm_lock -> i_rwsem -> mmap_lock -> vm_lock
>
> Snapshot VMA fields under the per-VMA lock in _next(), then drop the
> lock before returning. The BPF program accesses only the snapshot.
>
> Copy vm_start, vm_end, vm_flags, vm_pgoff, vm_page_prot, vm_file, and
> vm_mm. vm_file is reference-counted with get_file() under the lock and
> released via fput() on the next iteration or in _destroy(). vm_mm uses
> the mm pointer already held via mmget().
>
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs"=
)
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/task_iter.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index e20c85e06afa..f04d6e310fd3 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -799,7 +799,7 @@ const struct bpf_func_proto bpf_find_vma_proto =3D {
>  struct bpf_iter_task_vma_kern_data {
>         struct task_struct *task;
>         struct mm_struct *mm;
> -       struct vm_area_struct *locked_vma;
> +       struct vm_area_struct snapshot;
>         u64 last_addr;
>  };
>
> @@ -895,8 +895,8 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter=
_task_vma *it,
>                 goto err_cleanup_iter;
>         }
>
> -       kit->data->locked_vma =3D NULL;
>         kit->data->last_addr =3D addr;
> +       memset(&kit->data->snapshot, 0, sizeof(kit->data->snapshot));
>         return 0;
>
>  err_cleanup_iter:
> @@ -954,23 +954,33 @@ bpf_iter_task_vma_find_next(struct bpf_iter_task_vm=
a_kern_data *data)
>  __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_ite=
r_task_vma *it)
>  {
>         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> -       struct vm_area_struct *vma;
> +       struct vm_area_struct *snap, *vma;
>
>         if (!kit->data) /* bpf_iter_task_vma_new failed */
>                 return NULL;
>
> -       if (kit->data->locked_vma)
> -               vma_end_read(kit->data->locked_vma);
> +       snap =3D &kit->data->snapshot;
> +
> +       if (snap->vm_file) {
> +               fput(snap->vm_file);
> +               snap->vm_file =3D NULL;
> +       }

we do the same in _destroy, and we might get more "trusted" stuff
added, so to keep all that in sync, let's add a common function that
will "clean up" vma snapshot?

>
>         vma =3D bpf_iter_task_vma_find_next(kit->data);
> -       if (!vma) {
> -               kit->data->locked_vma =3D NULL;
> +       if (!vma)
>                 return NULL;
> -       }
>
> -       kit->data->locked_vma =3D vma;
> +       snap->vm_start =3D vma->vm_start;
> +       snap->vm_end =3D vma->vm_end;
> +       snap->vm_mm =3D kit->data->mm;
> +       snap->vm_page_prot =3D vma->vm_page_prot;
> +       snap->flags =3D vma->flags;
> +       snap->vm_pgoff =3D vma->vm_pgoff;
> +       snap->vm_file =3D vma->vm_file ? get_file(vma->vm_file) : NULL;
> +

let's just memcpy() entire vma, and then get_file(vma->vm_file) for
the explicitly trusted pointers? All other pointers are still useful
even if untrusted (e.g., I can easily see useful application of
vm_ops+vm_private_data and, separately, anon_vma). It's safe and
correct to have those pointers, we just can't declare them as trusted.
PROBEMEM semantics works fine here.

>         kit->data->last_addr =3D vma->vm_end;
> -       return vma;
> +       vma_end_read(vma);
> +       return snap;
>  }
>
>  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
> @@ -978,8 +988,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf=
_iter_task_vma *it)
>         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
>
>         if (kit->data) {
> -               if (kit->data->locked_vma)
> -                       vma_end_read(kit->data->locked_vma);
> +               if (kit->data->snapshot.vm_file)
> +                       fput(kit->data->snapshot.vm_file);
>                 bpf_iter_mmput(kit->data->mm);
>                 put_task_struct(kit->data->task);
>                 bpf_mem_free(&bpf_global_ma, kit->data);
> --
> 2.47.3
>
