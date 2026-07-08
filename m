Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFBE3B42EC
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488553; cv=pass; b=C4eQ4QtRN8qn0yw8tMAGTUV2S+8rjnTJCNxo4fquK1muNyIxrS2RrttylHkrgdTnOhboWcMInFgzBgllW73aAVZF6t/w6C/r1HweXihZCWmEQWxk3/sli7oKu0HV0tYNIOoZnWaZ/nh1ZAsRTJvm6T6+d7nLvDR92hXb/w/4LVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488553; c=relaxed/simple;
	bh=TLT3hQ59il1dajY0K+GBJku8kalLqDmAJlXRMAZ+xCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuU4Nja7PCTJHmiGkqMXcSDm4f/N1lc+WXlKpwLLSQMD3HSf71aOCu7W4CnQU/8YVy7Fe7tpcMZtEvGaasYp3SDJ/J3J+I40W2VTp4WLNuRw8BCCnCRCad1XCCsgb0q7eRv+jTs9Akda56uxZmhT0Ib7cmUnt/vE+ZNn6fdFvbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhdKOyLT; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhdKOyLT"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-471eeac43bfso250618f8f.3
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 22:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783488550; cv=none;
        d=google.com; s=arc-20260327;
        b=jxPNJ5GtfI+p7pTWGKRlb4TbPET5wcOOdnG5CHevYib8TpUeTJl0KOM/6wdX6cvVIW
         fDzpyaBkntgJJu2BaeFIRFIK3tHdiEElV4DWpuSq2i4ZP32JiDtZsSAH/Ua5GrBlurxq
         McciBtGrvzLTvcZ248XwPiDanNANS7qoKKsINu5/wthhJmiv9sEQYFY3ysK8k977OKyu
         WhLVpr/YXctS4tOJEII1MHF2nJvS9UlDezZcrcc9XOUSgfCtdAaLAS6aEhqpzw2u20JO
         1WTpQr5WHWOGber3Z/c4ehgzdqcdA3X2PM6wrErCkWCFEipGhhWTtuGLcxqoVVbV1pnz
         i36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yvhv1e/pb7dAE7IyHK30kRUiYyHJKejR1HIJW3rZ5GI=;
        fh=6J0jqrIfSVZGNkzG5kl6b01fVKIcvfmbkBjJk1V8Vt8=;
        b=Wa7v11Jy0c+seODkdFqDSsQvmEgAOlfECAQIoywgeYlq7vchvlVhqztmDT0K/GubzJ
         +3jYoTyupKflTGJOhZbSdljV7mfPkJ+SjgHXzZwXH8dTNTfsYdQh41CWoPqC0LzPraHy
         dtUMTXfok97J3wWMWDZjUG9IgfbcjeqcM4NAUqggGDFDP03OU3pQDDY1m4vk5YV1UywI
         VDvtfuVWJgM6/tDOupKzVBmXECiZZHBh7xAO7OeCVY354llCWD3qlBmAsNOFeTTXiva8
         zy203EVPRbH35/MtN2KdaFFSPBTdTY991oWj6Vo1+cR5Y4XOeSVH9N/F+SgMJ24T+9+M
         XnOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783488550; x=1784093350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yvhv1e/pb7dAE7IyHK30kRUiYyHJKejR1HIJW3rZ5GI=;
        b=jhdKOyLTiEIdrYX/f9vxnGTaIgz943qM6Xqjl4GJ3bVtnQX0jjHV2dtRGejY5EqgwF
         6ThHy3tkbslunM0K4vV/l+BiaANN1Jg3xVhQi7B/Fi3OcGotO6yYpT4pmDVGPLkERscx
         Gx3TTvTe4PUMqQCJ0GLnY3o6TQsgS3Rv8QIblO2VcJjNu2U8fldX7F9H/ciPM4ta4c0c
         3GVfNb4XSZieYp66CI2WU5E3eLkFuwWLJ939CaZRk3OJ2eCB2kuT/z+HFVJmprg/Um3o
         63Nz+/f/tjJLaZGDLSFrG+an+jYpR3mVYAJ2dOp1n3UJ4KmiAVbjwXmmH/H6YJI8O9gC
         2/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488550; x=1784093350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yvhv1e/pb7dAE7IyHK30kRUiYyHJKejR1HIJW3rZ5GI=;
        b=gVJ7aBaQ3GlKm5I3QCvDUe6OFnXqU6ZgwYWZyMEd7qC9k4UsMH3Y/fcPkpBcaoxPCR
         0Q5B1BEvGZaa2m9Q0Ns66780Yv25QCtSczqFLbF3TVNw/MqYJmIzanHFlfv9fkLJ/EhX
         /2D4/8xJCUKb8NjKbTklThHu2POF4Yjg3xgdmjpxZbHCbW/vX8YXwdDcH6IdSRsPWnJ4
         wnXDgtvxK4ohrj4fS2zy9STIwVwQrqgpRyC2TJtsTq7H92t0VEB/AObkF2Spz86JDcXF
         9xoS+9keHxVNdHPCk+vS2PXsx0sJpy6RiMeajEh7QOxjJ9U0sOIZGr1/XFE8hjAPzLDD
         SKxw==
X-Forwarded-Encrypted: i=1; AHgh+RrP2S454MqdcrY0+LP58mSHgdZZPqCXIYQQrEPsrDp1m6A5sm3RR/3TA1BXnvoimOMt+1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/zvMHjQ8OhY6Ff/iyO2aHQVU8axd5zjzuhtzijoP3QDH2IoP
	MVRj2YU53mcJyNXVvE0/hF9/tv6ZKylVwV+DkfDMRdk54ixTG3O/nuh2TSaxA01Gq3BeQe1yGJ6
	DTqJnb1NChETUap8Wn/NfmA+C9iADXDQ=
X-Gm-Gg: AfdE7clA0wfVYveSNrNvKH71jMa3REO3LZCioX1J0vL/WJHeRUDbbRF8DGrD0xj2MI4
	E6onVFRIyP2Ds2qFtnKMLRpTWlSQ5HlT9VmqZDAof4xhydxbZ/7v8nSQufDgjlS9Ho5rJgGq0BX
	XNMxAmKSe09aSfbPeMdXhbSFjti45Tgh2rX3bU2CJ1y3N4xx+eoNdWjb/8CxtsliqNh6idNIpMi
	mlDgVXiN34wmt2H5Xsjfle/JrX/LPbWSTGZpoA++RaqCBGi2lsmI6NATwelr1TZJV469CV/6O0O
	gJThe66gkj4wD1EiweVocWGRzt1w
X-Received: by 2002:a05:6000:4012:b0:472:c330:e3a5 with SMTP id
 ffacd0b85a97d-47df07894e3mr690697f8f.29.1783488549956; Tue, 07 Jul 2026
 22:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com>
 <CAEf4Bzby1M8OPRomzEq-xvciK-Zq2zoL0AoSn=iSR02t=wdNOg@mail.gmail.com>
 <CANk7y0g+tk_C9jF6c0420NDEyeM7LYgYyoCkKxy1utB46GnDUw@mail.gmail.com> <4d09e590-9b03-4025-b334-ea2351770b57@iogearbox.net>
In-Reply-To: <4d09e590-9b03-4025-b334-ea2351770b57@iogearbox.net>
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Date: Wed, 8 Jul 2026 14:28:32 +0900
X-Gm-Features: AVVi8Ccxs5MekUJDopjAxYqfxNJm7EYBfjF9oK99JOVEjG2UQM2POY7-v63PfW4
Message-ID: <CAOrxSK6mjYcCOAXqhxXw6MyfurcjZqkOjYn5ofhAFX+n8e2aNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure,

I=E2=80=99ll take a look at that issue once the current patch is sorted out=
.

2026=EB=85=84 7=EC=9B=94 7=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 4:44, Da=
niel Borkmann <daniel@iogearbox.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 7/6/26 1:28 PM, Puranjay Mohan wrote:
> > On Wed, Jul 1, 2026 at 8:48=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Mon, Jun 29, 2026 at 8:25=E2=80=AFPM Sanghyun Park
> >> <sanghyun.park.cnu@gmail.com> wrote:
> >>>
> >>> bpf_find_vma() reads task->mm and calls mmap_read_trylock(mm) without
> >>> holding a reference on the mm. On a foreign task, a concurrent exit_m=
m()
> >>> can free the mm_struct between the lockless read and the trylock,
> >>> resulting in a use-after-free. mm_struct is not SLAB_TYPESAFE_BY_RCU.
> >>>
> >>> For the current task, task->mm is stable. For a foreign task, pin the=
 mm
> >>> under task->alloc_lock and release it with mmput_async(), mirroring c=
ommit
> >>> d8e27d2d22b6 ("bpf: fix mm lifecycle in open-coded task_vma iterator"=
).
> >>> Use spin_trylock() instead of get_task_mm() so BPF context does not b=
lock
> >>> on alloc_lock. Reject irqs-disabled contexts and !CONFIG_MMU on the
> >>> foreign-task path because dropping the mm reference is not safe there=
.
> >>>
> >>> Race:
> >>>
> >>>    CPU0 (BPF program)                  CPU1 (exiting task)
> >>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>    bpf_find_vma(foreign_task):
> >>>      mm =3D task->mm
> >>>                                        exit_mm():
> >>>                                          task->mm =3D NULL
> >>>                                          mmput(mm) -> frees mm_struct
> >>>      mmap_read_trylock(mm)
> >>>          // UAF on mm
> >>>
> >>> Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
> >>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >>> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> >>> ---
> >>
> >> Puranjay, PTAL, I think you've been fixing similar issue in
> >> bpf_iter_task_vma_new(), would be nice for you to check this fix as
> >> well. Thanks!
> >>
> >>> v6:
> >>>   - Restore bpf_iter_mmput_async() because bpf_iter_task_vma_destroy(=
)
> >>>     still uses it.
> >>>   - Keep the direct mmput_async() call in bpf_find_vma(), but guard i=
t with
> >>>     CONFIG_MMU because mmput_async() is declared only for CONFIG_MMU =
builds.
> >>> v5: https://lore.kernel.org/bpf/20260630023443.3026627-2-sanghyun.par=
k.cnu@gmail.com/
> >>>   - Replace bpf_iter_mmput_async() with mmput_async() directly as sug=
gested
> >>>     by Yonghong.
> >>>   - Add Yonghong's Acked-by.
> >>> v4: https://lore.kernel.org/bpf/20260610024637.343364-1-sanghyun.park=
.cnu@gmail.com/
> >>>   - Use [PATCH bpf-next] subject as requested by Alexei.
> >>>   - Add the missing BPF maintainers/reviewers to Cc.
> >>> v3: https://lore.kernel.org/bpf/20260609105216.3536839-1-sanghyun.par=
k.cnu@gmail.com/
> >>>   - Drop get_task_mm()+mmput(); mirror d8e27d2d22b6 with alloc_lock
> >>>     trylock + mmput_async(). (Yonghong Song)
> >>>   - Reject irqs-disabled contexts on the foreign-task path.
> >>>   - Reject foreign-task path when !CONFIG_MMU: bpf_iter_mmput_async()
> >>>     falls back to mmput() which may sleep, and bpf_find_vma() can run
> >>>     in non-sleepable context.
> >>>   - Shorten the foreign-task rationale comment and trim the changelog=
 body.
> >>>   - Fix the v2's whitespace damage.
> >>> v2: https://lore.kernel.org/bpf/CAOrxSK5_7e4114VyfEU9htGi+UneuNt88fGV=
KOAa3_ZenPOFkA@mail.gmail.com/
> >>>
> >>>   kernel/bpf/task_iter.c | 36 +++++++++++++++++++++++++++++++++---
> >>>   1 file changed, 33 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> >>> index fc5f463ca529a..1d56193caf5e4 100644
> >>> --- a/kernel/bpf/task_iter.c
> >>> +++ b/kernel/bpf/task_iter.c
> >>> @@ -760,6 +760,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, ta=
sk, u64, start,
> >>>          struct mmap_unlock_irq_work *work =3D NULL;
> >>>          struct vm_area_struct *vma;
> >>>          bool irq_work_busy =3D false;
> >>> +       bool mmput_needed =3D false;
> >>>          struct mm_struct *mm;
> >>>          int ret =3D -ENOENT;
> >>>
> >>> @@ -769,14 +770,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, =
task, u64, start,
> >>>          if (!task)
> >>>                  return -ENOENT;
> >>>
> >>> -       mm =3D task->mm;
> >>> +       if (task =3D=3D current) {
> >>> +               mm =3D task->mm;
> >>> +       } else {
> >>> +               /*
> >>> +                * Foreign task: pin task->mm against a concurrent ex=
it_mm().
> >>> +                * Use trylock on alloc_lock instead of get_task_mm()=
's
> >>> +                * blocking task_lock() to avoid deadlocking the targ=
et task.
> >>> +                */
> >>> +               if (!IS_ENABLED(CONFIG_MMU))
> >>> +                       return -EOPNOTSUPP;
> >>> +               if (irqs_disabled())
> >>> +                       return -EBUSY;
> >>> +               if (!spin_trylock(&task->alloc_lock))
> >>> +                       return -EBUSY;
> >>> +               mm =3D task->mm;
> >>> +               if (mm && !(task->flags & PF_KTHREAD)) {
> >>> +                       mmget(mm);
> >>> +                       mmput_needed =3D true;
> >>> +               } else {
> >>> +                       mm =3D NULL;
> >>> +               }
> >>> +               spin_unlock(&task->alloc_lock);
> >>> +       }
> >>>          if (!mm)
> >>>                  return -ENOENT;
> >>>
> >>>          irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
> >>>
> >>> -       if (irq_work_busy || !mmap_read_trylock(mm))
> >>> -               return -EBUSY;
> >>> +       if (irq_work_busy || !mmap_read_trylock(mm)) {
> >>> +               ret =3D -EBUSY;
> >>> +               goto out;
> >>> +       }
> >>>
> >>>          vma =3D find_vma(mm, start);
> >>>
> >>> @@ -786,6 +811,11 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, t=
ask, u64, start,
> >>>                  ret =3D 0;
> >>>          }
> >>>          bpf_mmap_unlock_mm(work, mm);
> >>> +out:
> >>> +#ifdef CONFIG_MMU
> >>> +       if (mmput_needed)
> >>> +               mmput_async(mm);
> >>> +#endif
> >>>          return ret;
> >>>   }
> >>>
> >>> --
> >>> 2.48.1
> >
> > Thanks for this, it looks good to me.
> >
> > Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
>
> Applied, thanks! Could either you or Sanghyun look into the pre-existing
> sashiko-reported issue as well?
