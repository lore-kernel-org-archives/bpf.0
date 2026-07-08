Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DF3AA510
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 05:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783489128; cv=none; b=XTLUHNOVe9BOVyZXsi2XWuTXQTvZGv+zr5ND+8jHdkSCJoLOZ9T1DoY8SFe/D8bWpJ1LlnYoy4io+AL80uHA4X2CdVwraCIUQX1yv/RidXV4WqAhnD8sRQHDQjGG0cqAC6wk9tiXgX0PssdzKT6zcU1d774wd7Tl3zQL/9do0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783489128; c=relaxed/simple;
	bh=M7EasDgFdwe2wKlA/Xcb/xGQY9xr1kDs5eTf9YwG4t4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KqeHRpO8pLMm3mqPzKKX+WWj9KumOeLl0FR7+A5XtyqZrXkwQKr3k/CYEIPOYmaOdpdf7ttkZnKw2P7ieT0+qrmfV1e6Q9K2Sz1FaKRofSBylNNCrRdRjgAqGa1OQ6Ge/oZiYGXNh1Py/Pp6e8DLmunNtD4tE43WBZ7F10yP0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNFTbneG; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNFTbneG"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493b4af7976so1575025e9.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 22:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783489125; x=1784093925; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTTheAhlIxpIbm6yj8zsEe6uPaF2F+fnjj/Td1Qqkgk=;
        b=dNFTbneGBmovmKEqiAquVFyhOhrmrd8YK8zqwds1Sx460ZEr7dGoGHMnDz44Lv9ZBP
         dtefJx9QSpOtM0NcJcrXY6K3eQWDLcN4MvI1NKWet2KBNyTlHW9y9RTQCFaMErwTMOOk
         Zk4/nnNHcxXTp3P5S3y0T0GFm1x7iv7zSXYcGw0fy6bh9KL98ZEEvN3lwarGiekVWhzF
         eflVkwE1HXjIpf2zIHzCGiRAsrGjmLKQKQhCu6lBlBRCsp7Rf2by44Zv99kcbyJyJqhI
         T0poeJ6nj1Cgv48xi2hwwTgLXENtLM/SfTP7JjjosyYqF44P6dEwkNX43r6Im3IGvz8e
         9msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783489125; x=1784093925;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTTheAhlIxpIbm6yj8zsEe6uPaF2F+fnjj/Td1Qqkgk=;
        b=kAJJ0EEz0vFdi+0dNv9lEyq8+IlolK8y6cpfmQGrZroP0dSlmkBBL43NkowrSkHSOW
         9X53UL68sU2+KsNP8wf20DaRYjfkB5MZ7dmR6zdid7aTbbAlh+ebO9Vd3w7QWqXRGUUp
         ZfnM9mg+lfKyzo2rvmd3jfNGJ4oL1Ls1dkQm9pGk06j3x8JdRmNs2XWP9wjvu/LaK0lF
         +Sejug0kfb08gX9l7aoAhWsq/5j/Zj4dE+8lgBqbOXuOZ672lVYdr0KCGydcel5MMSmC
         1V/SSGO3rLePp40xUSnqNYiS9MFWBFDpA8Rvh82SQo7qdFQwg7ZNIkWDAyjWH88f9t5k
         IHbQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPyG/9NiqEFN9TwlG3Ssrc0zcgVXVLQfGIpi3RFTGSCWMXaBlaxp42m1NRlnUh6sqTUWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPbsztcQyFPDI917owQNWZwwB+LitUnRCAs6508v2/LPBueAGb
	+m58vpsjo18E5KZqv4FPvc32yVN+D9RFtuWj9xdA7wL5sdeAqwLygusu
X-Gm-Gg: AfdE7clBHqsO4xYp1jg7aSEbAKRdFLcxOqmdIokmlIgUbiK9TnbXGXBtl6SzjYbOa/g
	nE2IcixtIDTfN2S9NKFVfXL0+yC+52+8N5h8vEBRdGnvuRhj56XDLY5aVrjFQZNrHkaNq/aS/qd
	nbjKoonO1gtUh3Wb66CwKFTNneUZhzjwYUPXKRayzGm0axluhWG74fUzoToMgCDbzSbNqFm9FqQ
	FaJeV+zad4hOxwxnjTzpivg3/58oehpXZ5QUCopaGnut85vMCIvDaoakNjVyzCVOwmTh6MVxeLL
	F+ds127QjFV9SiwKn4eOp3DzPEoDfWSDOubQN0RIMXFPzW9HASKoZVhwrz8UtXf5m9t/iLxFXRs
	+be+X5knN437aIORy5tnCSwbYcAxBiCTH3YvDc+207+LBUWR7zziex6wHgxY2kVF4MBvdw5+Wv9
	UJZPJaEtU6o1/ovaCg6QH6gdHLVv8TyiKpcAiQFde8cJe3S3FCqQI7FNpwq1pslpoPCiVk1NtEJ
	L+qSc7xjkR35j9u44C/5Ptmsh7IitZx81Q+136LPZiA9sNVs5NwXdg=
X-Received: by 2002:a05:6000:18a9:b0:475:f0f0:9f00 with SMTP id ffacd0b85a97d-47df0788276mr718549f8f.55.1783489125113;
        Tue, 07 Jul 2026 22:38:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm38187651f8f.23.2026.07.07.22.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 07:38:44 +0200
Message-Id: <DJSY4OV8B4K3.EAC42NYKYZTL@gmail.com>
Cc: "Puranjay Mohan" <puranjay12@gmail.com>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v6] bpf: Fix use-after-free on mm_struct in
 bpf_find_vma()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Sanghyun Park" <sanghyun.park.cnu@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>
X-Mailer: aerc 0.21.0
References: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com>
 <CAEf4Bzby1M8OPRomzEq-xvciK-Zq2zoL0AoSn=iSR02t=wdNOg@mail.gmail.com>
 <CANk7y0g+tk_C9jF6c0420NDEyeM7LYgYyoCkKxy1utB46GnDUw@mail.gmail.com>
 <4d09e590-9b03-4025-b334-ea2351770b57@iogearbox.net>
 <CAOrxSK6mjYcCOAXqhxXw6MyfurcjZqkOjYn5ofhAFX+n8e2aNA@mail.gmail.com>
In-Reply-To: <CAOrxSK6mjYcCOAXqhxXw6MyfurcjZqkOjYn5ofhAFX+n8e2aNA@mail.gmail.com>

On Wed Jul 8, 2026 at 7:28 AM CEST, Sanghyun Park wrote:
> Sure,
>

Please avoid top-posting.

> I=E2=80=99ll take a look at that issue once the current patch is sorted o=
ut.
>

We had to drop this from the tree because of build-time warnings [0], since
mmput_needed will not be used in case CONFIG_MMU is unset. It should be eas=
y
to address by adding __maybe_unused to the mmput_needed's declaration. Coul=
d
you make that fix and respin?

  [0]: https://lore.kernel.org/bpf/202607080951.rMUtVX8X-lkp@intel.com

> 2026=EB=85=84 7=EC=9B=94 7=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 4:44, =
Daniel Borkmann <daniel@iogearbox.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>>
>> On 7/6/26 1:28 PM, Puranjay Mohan wrote:
>> > On Wed, Jul 1, 2026 at 8:48=E2=80=AFPM Andrii Nakryiko
>> > <andrii.nakryiko@gmail.com> wrote:
>> >>
>> >> On Mon, Jun 29, 2026 at 8:25=E2=80=AFPM Sanghyun Park
>> >> <sanghyun.park.cnu@gmail.com> wrote:
>> >>>
>> >>> bpf_find_vma() reads task->mm and calls mmap_read_trylock(mm) withou=
t
>> >>> holding a reference on the mm. On a foreign task, a concurrent exit_=
mm()
>> >>> can free the mm_struct between the lockless read and the trylock,
>> >>> resulting in a use-after-free. mm_struct is not SLAB_TYPESAFE_BY_RCU=
.
>> >>>
>> >>> For the current task, task->mm is stable. For a foreign task, pin th=
e mm
>> >>> under task->alloc_lock and release it with mmput_async(), mirroring =
commit
>> >>> d8e27d2d22b6 ("bpf: fix mm lifecycle in open-coded task_vma iterator=
").
>> >>> Use spin_trylock() instead of get_task_mm() so BPF context does not =
block
>> >>> on alloc_lock. Reject irqs-disabled contexts and !CONFIG_MMU on the
>> >>> foreign-task path because dropping the mm reference is not safe ther=
e.
>> >>>
>> >>> Race:
>> >>>
>> >>>    CPU0 (BPF program)                  CPU1 (exiting task)
>> >>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>>    bpf_find_vma(foreign_task):
>> >>>      mm =3D task->mm
>> >>>                                        exit_mm():
>> >>>                                          task->mm =3D NULL
>> >>>                                          mmput(mm) -> frees mm_struc=
t
>> >>>      mmap_read_trylock(mm)
>> >>>          // UAF on mm
>> >>>
>> >>> Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
>> >>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> >>> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
>> >>> ---
>> >>
>> >> Puranjay, PTAL, I think you've been fixing similar issue in
>> >> bpf_iter_task_vma_new(), would be nice for you to check this fix as
>> >> well. Thanks!
>> >>
>> >>> v6:
>> >>>   - Restore bpf_iter_mmput_async() because bpf_iter_task_vma_destroy=
()
>> >>>     still uses it.
>> >>>   - Keep the direct mmput_async() call in bpf_find_vma(), but guard =
it with
>> >>>     CONFIG_MMU because mmput_async() is declared only for CONFIG_MMU=
 builds.
>> >>> v5: https://lore.kernel.org/bpf/20260630023443.3026627-2-sanghyun.pa=
rk.cnu@gmail.com/
>> >>>   - Replace bpf_iter_mmput_async() with mmput_async() directly as su=
ggested
>> >>>     by Yonghong.
>> >>>   - Add Yonghong's Acked-by.
>> >>> v4: https://lore.kernel.org/bpf/20260610024637.343364-1-sanghyun.par=
k.cnu@gmail.com/
>> >>>   - Use [PATCH bpf-next] subject as requested by Alexei.
>> >>>   - Add the missing BPF maintainers/reviewers to Cc.
>> >>> v3: https://lore.kernel.org/bpf/20260609105216.3536839-1-sanghyun.pa=
rk.cnu@gmail.com/
>> >>>   - Drop get_task_mm()+mmput(); mirror d8e27d2d22b6 with alloc_lock
>> >>>     trylock + mmput_async(). (Yonghong Song)
>> >>>   - Reject irqs-disabled contexts on the foreign-task path.
>> >>>   - Reject foreign-task path when !CONFIG_MMU: bpf_iter_mmput_async(=
)
>> >>>     falls back to mmput() which may sleep, and bpf_find_vma() can ru=
n
>> >>>     in non-sleepable context.
>> >>>   - Shorten the foreign-task rationale comment and trim the changelo=
g body.
>> >>>   - Fix the v2's whitespace damage.
>> >>> v2: https://lore.kernel.org/bpf/CAOrxSK5_7e4114VyfEU9htGi+UneuNt88fG=
VKOAa3_ZenPOFkA@mail.gmail.com/
>> >>>
>> >>>   kernel/bpf/task_iter.c | 36 +++++++++++++++++++++++++++++++++---
>> >>>   1 file changed, 33 insertions(+), 3 deletions(-)
>> >>>
>> >>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> >>> index fc5f463ca529a..1d56193caf5e4 100644
>> >>> --- a/kernel/bpf/task_iter.c
>> >>> +++ b/kernel/bpf/task_iter.c
>> >>> @@ -760,6 +760,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, t=
ask, u64, start,
>> >>>          struct mmap_unlock_irq_work *work =3D NULL;
>> >>>          struct vm_area_struct *vma;
>> >>>          bool irq_work_busy =3D false;
>> >>> +       bool mmput_needed =3D false;
>> >>>          struct mm_struct *mm;
>> >>>          int ret =3D -ENOENT;
>> >>>
>> >>> @@ -769,14 +770,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *,=
 task, u64, start,
>> >>>          if (!task)
>> >>>                  return -ENOENT;
>> >>>
>> >>> -       mm =3D task->mm;
>> >>> +       if (task =3D=3D current) {
>> >>> +               mm =3D task->mm;
>> >>> +       } else {
>> >>> +               /*
>> >>> +                * Foreign task: pin task->mm against a concurrent e=
xit_mm().
>> >>> +                * Use trylock on alloc_lock instead of get_task_mm(=
)'s
>> >>> +                * blocking task_lock() to avoid deadlocking the tar=
get task.
>> >>> +                */
>> >>> +               if (!IS_ENABLED(CONFIG_MMU))
>> >>> +                       return -EOPNOTSUPP;
>> >>> +               if (irqs_disabled())
>> >>> +                       return -EBUSY;
>> >>> +               if (!spin_trylock(&task->alloc_lock))
>> >>> +                       return -EBUSY;
>> >>> +               mm =3D task->mm;
>> >>> +               if (mm && !(task->flags & PF_KTHREAD)) {
>> >>> +                       mmget(mm);
>> >>> +                       mmput_needed =3D true;
>> >>> +               } else {
>> >>> +                       mm =3D NULL;
>> >>> +               }
>> >>> +               spin_unlock(&task->alloc_lock);
>> >>> +       }
>> >>>          if (!mm)
>> >>>                  return -ENOENT;
>> >>>
>> >>>          irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
>> >>>
>> >>> -       if (irq_work_busy || !mmap_read_trylock(mm))
>> >>> -               return -EBUSY;
>> >>> +       if (irq_work_busy || !mmap_read_trylock(mm)) {
>> >>> +               ret =3D -EBUSY;
>> >>> +               goto out;
>> >>> +       }
>> >>>
>> >>>          vma =3D find_vma(mm, start);
>> >>>
>> >>> @@ -786,6 +811,11 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, =
task, u64, start,
>> >>>                  ret =3D 0;
>> >>>          }
>> >>>          bpf_mmap_unlock_mm(work, mm);
>> >>> +out:
>> >>> +#ifdef CONFIG_MMU
>> >>> +       if (mmput_needed)
>> >>> +               mmput_async(mm);
>> >>> +#endif
>> >>>          return ret;
>> >>>   }
>> >>>
>> >>> --
>> >>> 2.48.1
>> >
>> > Thanks for this, it looks good to me.
>> >
>> > Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
>>
>> Applied, thanks! Could either you or Sanghyun look into the pre-existing
>> sashiko-reported issue as well?

