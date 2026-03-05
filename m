Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF671F1534
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737408; cv=pass; b=gBGYCu5q5j7c6gvKN7K507a6TCbA4R0vTVWQVjQwGgWVf5FPlUOQd3O/IkqWb4JS1T3VT04pvBUX4MkK8Yh6KBb6pGEMKJ7u1D7q2+UUefMuos8GIyKwGasRKB2FghrG8HooRYHARJ5CzUlAhSPE1TDO/FCI7DPUovpivNpqXi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737408; c=relaxed/simple;
	bh=503VMwNLAFvNwMghIGOVkWDuOHzOKMGP6t9uRoIKsyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AktjHruWkL3lMNwhjBETKk90sDE2b5GZ6nS3gQcOi9xhd50tUVG/7VGr/IS8YTBor+BSiF8dwxL4VA86upadL3sq3Tu6bpwxjbEwinmnEtlm8TzdAWmf6vxNro3lb2EWhyZtLXAwGskKyqa0kkdod8UpSVVz+MzHEKkKBaugOLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQMQ2nt1; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQMQ2nt1"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-660ea8bcb96so3585423a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 11:03:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772737406; cv=none;
        d=google.com; s=arc-20240605;
        b=X9ZCtAFFDFygMYYjHNC2vwzL0m8VXV1WCeh9bM4cymxMV5lMKOfnvKo2C0ctAPkzGv
         QAcvmZGE+ytk883Wkw1m8Gpm1Hfm09GZowBaf1Nm/COPbgu6CL0X2KZ6lQ2UU/t7qsah
         F1S9yYbseKjSbkPc0cg0BU3BaL+9FniZjloA8JnFwFQCTsH3xQluxZt/pUNPaF+pvdGH
         sSRcHvbNjf8fATX5Gi24hfPfGc9DC277TLUhl+tTUBfw8NGhWc5SeskpoZJrfPCrSEB1
         a3j7dPzxP67PU4M2eIGA8/DJ89kSvFyAtbF+OHRLByvIi2cHQEZN1FLiu1MYc+ejrOcW
         /L3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9/9ZPvdplBnsqJ0qzxi33G2bjBxDFeZjr5Ei9vAWlPk=;
        fh=V2bTsbv6M94YX3O1oBaAkMJN+DpnN04JPyyf0fZ9tro=;
        b=dhIkpFAlY9DTXacrYFqT9Hn8kpNODw5KXETNjZalw4zSFrT/vE5pvXE/tEhdfIWmOn
         ohVXEv8RPuStY4JWWX605IJeMISbTf5qdTZbyesUdwaBOqEWMVoo9MUh6qcjSqYoE+6E
         v+CBuTopHsSVF2cydKBkDBpYHjoHiEGc3vWzQunQYx77mW4X1lyax71fGrS5YsJrp/Zf
         Z9z1bDBr+XSQh5FC3sbHBItIfPuvdvpAAb9XV2VR6AsnMH0c5MT2nbXrctsGz/OEV/R9
         AXmwc+A9zUUkkj5aMKvQmNxCXjGwHkHUyL5on810EOFuQnDqmcTCqipFnsVFBQJpSLGh
         ksRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772737406; x=1773342206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/9ZPvdplBnsqJ0qzxi33G2bjBxDFeZjr5Ei9vAWlPk=;
        b=lQMQ2nt1g2REaTyqGcKRI/kWFlKyW9fkm6J5azh/FzCzo7nr8DDdymuj9OElMuKFfX
         h3EIONbL8pGUSQuHG/DN94ifexWlGxZXb6PpaNrAhtg0N92I81eE8lpjhqwpXm/OYK5X
         p5+zHHto2hXXo+KkvK6oFwo+xS+BA3dfJfZB1ugfOWBN/qSSHJEnEIiRg1YPzQLKn7at
         eo+3Vzona+lVTAIum3TZYoWEi7ogM205mcgHa/8WdFj8W/lNFth/c4bSfv2tXVxn/b/n
         VrtMwcrU8T7636cIeEwi8crgcOi4sj0UTb/M+2/0kcW9SyGvMiESoPzc33FmQ8z2Sx6K
         Rd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772737406; x=1773342206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9/9ZPvdplBnsqJ0qzxi33G2bjBxDFeZjr5Ei9vAWlPk=;
        b=CpSnXlsEK4oEsW1LWdW6CaxxYnj30hma7W3gtLPNEECKCiNI33hAxnt8HazSqvWX4b
         iHTUKE/ocEytkhsE37+Io0BXUkzW857KPhPoU8rzP+ZerNlULYKQjO5teB3gueGs/FL3
         7/SHhPlw6TzGjHsZu9BGH59SQibItIhobi57O0USTzRRJ3apGk8+5w0N3RyAKjT/BbQB
         q7TVsh0LiLZwGEDL23ygFDLiJAqxsnmOmQy9/NbnlCK+1fbnybh0rlEP1+31Pb4yFAGT
         GBGYVw/+bzZmbjWU31e+J9ytFnwib4qe0IK21oZrq31V/g59+4IieBNGXydOfutGsTUj
         dnSw==
X-Gm-Message-State: AOJu0YxUwxZ3Bke235vyWixxCK2LzSpnXhbE+tuw/zMayZ/qrHBHV3BE
	2SdnoWsjquPIvqrpzftZq6pEpfj1Ahyicv9zHzKnnzH0L0e6w7pJ//a0dPvdPU9MTUUOieivU81
	AQ2oBFq4gnvU6xTPtDO+x5+79gDK7wk0=
X-Gm-Gg: ATEYQzw5u/3bxUlDcCKEysvNuG8Osh2QrDpRcF2gj7tuJdhT+Wv7ctZwrz1d7iPx3FI
	+tfs+ioyczaVdagBra66/yyd8A3yWuO6kXlgSgUMLN4F4FrAwQEjI1KDipAPnyCzPXGjJ+rYwbw
	ZbVbajTm21PkQSm6oLNMhxTIx/sqlyLz1UI/eVRSr8/YWxbc1+Ld2MPqX4ESAo4TAyb8kAuBNgf
	DtmT7GFWrF64uZgbFndgnlGmdbDtDVeh7QTjXunICK2imbmxufPKZrcLeGyUsbxV56A8WjjSqLY
	KYl2h+tPBt2Qchshn8wKSkM=
X-Received: by 2002:a17:907:7f8f:b0:b93:8e7f:3d3f with SMTP id
 a640c23a62f3a-b94229da881mr57497066b.32.1772737405335; Thu, 05 Mar 2026
 11:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304142026.1443666-1-puranjay@kernel.org> <20260304142026.1443666-4-puranjay@kernel.org>
 <87h5quxg3e.fsf@gmail.com>
In-Reply-To: <87h5quxg3e.fsf@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 5 Mar 2026 19:03:14 +0000
X-Gm-Features: AaiRm51Caa88oTUzPbgUqDmYxYhVnpbJi5KvCs-SCJZn2ZdzvCTsHDTt-w6bq1s
Message-ID: <CANk7y0gPamvbYmiCRRcp3UOd-yP-18ViRmjKMQMqj6G_fGfi=w@mail.gmail.com>
Subject: Re: [PATCH bpf 3/3] bpf: return VMA snapshot from task_vma iterator
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 6:53=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Puranjay Mohan <puranjay@kernel.org> writes:
>
> > Holding the per-VMA lock across the BPF program's loop body creates a
> > lock ordering problem when helpers acquire locks with a dependency on
> > mmap_lock (e.g., bpf_dynptr_read -> __kernel_read -> i_rwsem):
> >
> >   vm_lock -> i_rwsem -> mmap_lock -> vm_lock
> >
> > Snapshot VMA fields into an embedded struct vm_area_struct under the
> > per-VMA lock in _next(), then drop the lock before returning. The BPF
> > program accesses only the snapshot, so no lock is held during execution=
.
> > For vm_file, get_file() takes a reference under the lock, released via
> > fput() on the next iteration or in _destroy(). The snapshot's vm_file i=
s
> > set to NULL after fput() so _destroy() does not double-release the
> > reference when _next() has already dropped it. For vm_mm, the snapshot
> > uses the mm pointer held via mmget().
> >
> > Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfunc=
s")
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/bpf/task_iter.c | 31 +++++++++++++++++++++----------
> >  1 file changed, 21 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index ff29d4da0267..4bf93cff69c7 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
> > @@ -798,7 +798,7 @@ const struct bpf_func_proto bpf_find_vma_proto =3D =
{
> >  struct bpf_iter_task_vma_kern_data {
> >       struct task_struct *task;
> >       struct mm_struct *mm;
> > -     struct vm_area_struct *locked_vma;
> > +     struct vm_area_struct snapshot;
> >       u64 last_addr;
> >  };
> >
> > @@ -908,8 +908,8 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_it=
er_task_vma *it,
> >               goto err_cleanup_iter;
> >       }
> >
> > -     kit->data->locked_vma =3D NULL;
> >       kit->data->last_addr =3D addr;
> > +     memset(&kit->data->snapshot, 0, sizeof(kit->data->snapshot));
> >       return 0;
> >
> >  err_cleanup_iter:
> > @@ -923,15 +923,19 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_=
iter_task_vma *it,
> >  __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_i=
ter_task_vma *it)
> >  {
> >       struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> > -     struct vm_area_struct *vma;
> > +     struct vm_area_struct *snap, *vma;
> >       struct vma_iterator vmi;
> >       unsigned long next_addr, next_end;
> >
> >       if (!kit->data) /* bpf_iter_task_vma_new failed */
> >               return NULL;
> >
> > -     if (kit->data->locked_vma)
> > -             vma_end_read(kit->data->locked_vma);
> > +     snap =3D &kit->data->snapshot;
> > +
> > +     if (snap->vm_file) {
> > +             fput(snap->vm_file);
> > +             snap->vm_file =3D NULL;
> > +     }
> >
> >  retry:
> >       rcu_read_lock();
> > @@ -939,7 +943,6 @@ __bpf_kfunc struct vm_area_struct *bpf_iter_task_vm=
a_next(struct bpf_iter_task_v
> >       vma =3D vma_next(&vmi);
> >       if (!vma) {
> >               rcu_read_unlock();
> > -             kit->data->locked_vma =3D NULL;
> >               return NULL;
> >       }
> >       next_addr =3D vma->vm_start;
> > @@ -961,9 +964,17 @@ __bpf_kfunc struct vm_area_struct *bpf_iter_task_v=
ma_next(struct bpf_iter_task_v
> >               goto retry;
> >       }
> >
> > -     kit->data->locked_vma =3D vma;
> > +     snap->vm_start =3D vma->vm_start;
> > +     snap->vm_end =3D vma->vm_end;
> > +     snap->vm_mm =3D kit->data->mm;
> > +     snap->vm_page_prot =3D vma->vm_page_prot;
> > +     snap->flags =3D vma->flags;
> > +     snap->vm_pgoff =3D vma->vm_pgoff;
> > +     snap->vm_file =3D vma->vm_file ? get_file(vma->vm_file) : NULL;
> Are you omitting some fields when copying to snapshot? How do
> you decide what fields are needed and what not? If your intention is
> to copy everything and bump refcnt for file, why not memcpy() +
> get_file(vma->vm_file)?

I looked at the usage of the vma across bpf programs and these were
the most important fields. I couldn't find a bpf program that uses a
field other than these. so, I only copy these and others stay 0.
