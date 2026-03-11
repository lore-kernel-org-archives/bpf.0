Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5836F405
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257263; cv=pass; b=AcE8XBU3oS2caxa17hDAkbO3F4ewiXJfCR1hCNuVM5+DJAzgsDxWZAVh2gSskMBGwNesgBsF+nTavTIECEuxxb19RD2EEZXcEW2F65Y53bvpX5yvvjdskosgMQ1nN63fDKpJ/u52O/w9MQXSdq8z60/g2ZohtSoTC5CrClQ+om8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257263; c=relaxed/simple;
	bh=aeYNbnwM8iQgxbelNkNmAbI5i3dILCBd2Ta85t9RCpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTsXAiuxee0pVrIk8DNPmy/8Q+y1RDsm840ywvwEL50htowAcu0CEi8NTbcP7tWooR3JCrebUC2GRr7ttuHArnoZVOyXVwvGgsJQFWc5gwWo8dBEXUUBkQz1O6XdCmjOWXAuwLGp60fOTh2mvkIjtNdlT2FQZS5AJfeTh3Qz8NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyYvFw+8; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyYvFw+8"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9358dd7f79so28162066b.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773257260; cv=none;
        d=google.com; s=arc-20240605;
        b=SVzQw5n7YahzErKrrYuqxXph5Q11OmJVLNpLYRt3A3bK2qa4AD8tKNu48dPM2Bkeik
         XYXwktyFMzX+/HdgHtawDMWqdfzPCj08PYjO6WwQ4tZb1gaxhaKFbSR4VifVN1rG+QjZ
         WFP7CAiGundqs5BL0CcV7HBBPaoZzldRh/EEZvh0B4w2f9zZnHNqINbvdJO+OSZJEdgE
         04lAMlFKRzu5lQi17m7H2KIyC3njfQWZ2DzYcPlvrMxZMVz4RxbyQ+dfZDTz6TTGrIkt
         yb5ojhyk1baa/sjPEu6kthnO8zlCghO92f9/IizGny/jfPz5zLxyDQHquwYdtAuIqU82
         sahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lvRLIYKkOJy41ZEtPVcuHTQhIZU9AewvKbEHCYCxAk4=;
        fh=s/U2tX1QyS+6Cr3UC+tsC37VXjN1NmMqAyctztF2ai4=;
        b=ADizytKr3p12bzj7h0ulApIDcvOSXEz6fhxG5WE1b5OZf0pvJBkzNLAQbKe+wGJWmq
         +9IFaCucK9hIwaED3up5Hm4F0INIF3IAbf18yYY1YV7OUicRujNCJNsG0HSJMAbJZpgC
         BSjceUi1wXYhdm1MtP+Ovgtcue0OWnFlOYvCpHo3IamQCiBpAk8Jy5WLICaHpCK+Ml6F
         rF/uod2OnU4wyHFH2K7pO7URJpUsEFhLE7CIt7bDBVvCLuvoIVmqaJve76gOHNiT/das
         Gb02BTSf2RtKxkGP/PgfrSnzHv8ovcSJCZeYoJo72dUalYp2rJ7iA9Ggj5tIWrTQ41FM
         QAgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773257260; x=1773862060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvRLIYKkOJy41ZEtPVcuHTQhIZU9AewvKbEHCYCxAk4=;
        b=iyYvFw+8Fy6BoySRiqc+HYelSV1L0QFc28yuy7xOJBhwz+b4aSWy1ELIoT81eawaiY
         w3IJtNDk9kRO/swooDPXXFG+oxkp8gAJYhURhYb3twOIlWAB0i0axI1Gn8XfH0HtMHM6
         jlIJtUxbofNm4Shof+H7x9XP0YT+xVEYAXHxKacD+1hrXJVoo/eI1DxYoPJTBrc6xOOi
         /g3GH974T4r5PwxRDQddlpGaRR1o4q2VudTHrORLd/WTsysCe9yOq+ez0D58lNJVpa8R
         WKy5IidtUJKoxJmnvC1Jy2BmlJj6OlryVKG2jebKwQ84yl/Orefdl3muB0z6qvQzG0z/
         jxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773257260; x=1773862060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lvRLIYKkOJy41ZEtPVcuHTQhIZU9AewvKbEHCYCxAk4=;
        b=GxavcXhlz7jbMXAYOSRm+W65hi2O/FT7UHPEMf5X74RGjgIQ+Mc8kCbh6Eca2WxNfa
         3ykpdrYZ3MpZpTgsiVQQ1mq+4GluatGE9WIrIPjWzMGM35D2YhmgiLvs2taOVxwE2sUW
         VtkTG+H1YY3IJLhcAjeBRXLsrXeL6TIY+XmUP8BPNLlXe6LmHwUebgmAWiarGn5nXMBL
         9AGlIN52W4SCXdEj2ywGKVrNxSZs4dVscC+SpB9NSO5p17YpZt0oo1rSUQtZ9TZUeR8r
         uHh4NFm0rmoSJ7LwQC7UpMi/u730IofYiqA/+Bu93quQLZdN52PmTb8oo4gaglZGLIlD
         85BA==
X-Gm-Message-State: AOJu0YwHh0a8u5ypreucSDIETS0lSh7pQkzFXEIuqGQoIDZd5hYPRupK
	sJoghn7Okm8yklzr8QX/4DFRGEykegspiM+tumSjUtoGZeudiiCUITeLH3NjRM9NU1wKlrjF5Zi
	Hx+r7VEdo3m4OxON317Qp4fP1tnAELp4=
X-Gm-Gg: ATEYQzzhpwAsVff0pM46VAFTWV0Z1VsDx6BJ0m1PPMpyC/k61KO+cQSY28WJMBhntj5
	xS0iYYNp8en46jfAZPWjLnWbjrMeRb/PDBfOcvEAWYBFgypKAKjw6o1RhbDxAm64CCZaxcGupj6
	zAzd0QS2j32vsCBzwULAIobsK18sPstYeeWjnCHw2sIGQJD7Zl/J+odpm4lcVsJR2wvFt91G9pg
	GJDrLrEhbTsEVZ5kX8+/hE4v8VbO5TJYXkMKewI+s/WmoIcnvzsRZmtWAg009aplmBzguqj2mm9
	H5K7K/V3gXyvfQoeQGGCfZg=
X-Received: by 2002:a17:907:7b84:b0:b97:72d:67d with SMTP id
 a640c23a62f3a-b972e58e8c9mr220408366b.50.1773257260236; Wed, 11 Mar 2026
 12:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155506.23490-1-puranjay@kernel.org> <20260309155506.23490-5-puranjay@kernel.org>
 <CAEf4Bzb9aPiAxOfo+_L6iaZPGrk3mPQ+6yuA6msTUHOV=xbGfg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb9aPiAxOfo+_L6iaZPGrk3mPQ+6yuA6msTUHOV=xbGfg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 11 Mar 2026 19:27:28 +0000
X-Gm-Features: AaiRm530N_-QdKMAPgy-3hhpyntUOrW8wEixcj1ii9dy3zOOz_RR3ldzCkwlO4Q
Message-ID: <CANk7y0i9vDgT5nX7ZK=FvFF1CYR3HoVzsp4d+cecAZPfLDsXEw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 4/4] bpf: return VMA snapshot from task_vma iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 7:07=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 9, 2026 at 8:55=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
> >
> > Holding the per-VMA lock across the BPF program body creates a lock
> > ordering problem when helpers acquire locks that depend on mmap_lock:
> >
> >   vm_lock -> i_rwsem -> mmap_lock -> vm_lock
> >
> > Snapshot VMA fields under the per-VMA lock in _next(), then drop the
> > lock before returning. The BPF program accesses only the snapshot.
> >
> > Copy vm_start, vm_end, vm_flags, vm_pgoff, vm_page_prot, vm_file, and
> > vm_mm. vm_file is reference-counted with get_file() under the lock and
> > released via fput() on the next iteration or in _destroy(). vm_mm uses
> > the mm pointer already held via mmget().
> >
> > Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfunc=
s")
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/bpf/task_iter.c | 34 ++++++++++++++++++++++------------
> >  1 file changed, 22 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index e20c85e06afa..f04d6e310fd3 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
> > @@ -799,7 +799,7 @@ const struct bpf_func_proto bpf_find_vma_proto =3D =
{
> >  struct bpf_iter_task_vma_kern_data {
> >         struct task_struct *task;
> >         struct mm_struct *mm;
> > -       struct vm_area_struct *locked_vma;
> > +       struct vm_area_struct snapshot;
> >         u64 last_addr;
> >  };
> >
> > @@ -895,8 +895,8 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_it=
er_task_vma *it,
> >                 goto err_cleanup_iter;
> >         }
> >
> > -       kit->data->locked_vma =3D NULL;
> >         kit->data->last_addr =3D addr;
> > +       memset(&kit->data->snapshot, 0, sizeof(kit->data->snapshot));
> >         return 0;
> >
> >  err_cleanup_iter:
> > @@ -954,23 +954,33 @@ bpf_iter_task_vma_find_next(struct bpf_iter_task_=
vma_kern_data *data)
> >  __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_i=
ter_task_vma *it)
> >  {
> >         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> > -       struct vm_area_struct *vma;
> > +       struct vm_area_struct *snap, *vma;
> >
> >         if (!kit->data) /* bpf_iter_task_vma_new failed */
> >                 return NULL;
> >
> > -       if (kit->data->locked_vma)
> > -               vma_end_read(kit->data->locked_vma);
> > +       snap =3D &kit->data->snapshot;
> > +
> > +       if (snap->vm_file) {
> > +               fput(snap->vm_file);
> > +               snap->vm_file =3D NULL;
> > +       }
>
> we do the same in _destroy, and we might get more "trusted" stuff
> added, so to keep all that in sync, let's add a common function that
> will "clean up" vma snapshot?
>
> >
> >         vma =3D bpf_iter_task_vma_find_next(kit->data);
> > -       if (!vma) {
> > -               kit->data->locked_vma =3D NULL;
> > +       if (!vma)
> >                 return NULL;
> > -       }
> >
> > -       kit->data->locked_vma =3D vma;
> > +       snap->vm_start =3D vma->vm_start;
> > +       snap->vm_end =3D vma->vm_end;
> > +       snap->vm_mm =3D kit->data->mm;
> > +       snap->vm_page_prot =3D vma->vm_page_prot;
> > +       snap->flags =3D vma->flags;
> > +       snap->vm_pgoff =3D vma->vm_pgoff;
> > +       snap->vm_file =3D vma->vm_file ? get_file(vma->vm_file) : NULL;
> > +
>
> let's just memcpy() entire vma, and then get_file(vma->vm_file) for
> the explicitly trusted pointers? All other pointers are still useful
> even if untrusted (e.g., I can easily see useful application of
> vm_ops+vm_private_data and, separately, anon_vma). It's safe and
> correct to have those pointers, we just can't declare them as trusted.
> PROBEMEM semantics works fine here.

Yes, doing that in the next version.
