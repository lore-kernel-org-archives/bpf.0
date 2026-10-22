Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792710697;
	b=xQQPcwdVLSFXR5VAe9R+6L4epGI+WR5HFUNsJan9unbhBp75qb9Nl/BGre6CbfCyJEqX
	 EWqmjHummbd6H2LYbhtxeS+8DsId6OkXd3LvQxMDFVdkRlhLHTYYrobkuITf0AyueH4nA
	 Q4f7WMZ6DVMXEntJfdhKCFA2oe1CvAN9mC7Se06KtnK2kPP5F1d68P6PQnAHaJ6EwKrRc
	 LMFdAJid5oaakxIc8QrTaioUDAB4PeaHTXqheSEFrBrlhmh5Qlea7XS1eHjNwlQILhcZ4
	 k0cVLFV9mOMY/UXbGXk9EvlolKODs7au5aA91NXZGRxPOct1aauFIgcDKLZhOnJQxUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792710697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=u9FF5OWfzsi4DyrpW60LLUMz1VcIwydXpbxb65LGd/A=;
	b=zSKqzV8rRRoXD7GLw7kwJnHWPTthEcXaqJwRxtO4dYSTkPzyWTazUNP7EeTp4Z+7FdVP
	 DXowfwvTmUpxOkWYQxVKgrFX9nfoOJ30YGTairEQA6vAK+GGV/9q/IhodT8CNwXphgt68
	 flS4tOqF8wMccNddYWBsmXtju7MAZh9dSwIAd0AzoEIR8c9Hw1/nMdQ+to9rKxSENFPot
	 +lLkKYOSL52Jve2nOfw2VauyQNBOMSTcHnSP+gZOkPGss3OysD9AHAiw5C3fS6bnX02pI
	 6dPiSHzu+qObs38giRg4woibkelb4Q0KAiBSrYZHoWtmlyMoO1ouNpeWSPnNeIc4YRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="L/tELMm6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BAE606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 23:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85BAE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L/tELMm6
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd623dfe420so232764a12.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 16:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792710696; cv=none;
        d=google.com; s=arc-20260327;
        b=T86fcPKOtFUuyrnkzjuwG89mQLWYj1gWvIxgA6SNq65OXUxgzIss+TYXlBJntdHZ/3
         iTBCs9ScswIoaw7+Z2khb4cdTs7tUx8BO3hSR/GGTNflzH38XBNBy+e/ToeFS2KWMka1
         4MsajhrQftABzmBKPdcZxEwI+vRByNAJmWzJF2T/hRQ554L1+WWIncxThmtgVAKZJkWE
         pRGM4vThzQkMZv8NjiXSw3Q4yXa/zjBqdWNowhHpJ65M0ct9+cAYy12yt0KLQS3Pehtt
         79bGkfxrWdwFMiJhDPSGhww/SkDdBbzQD60EGDHKBd9Ok9P+92ASiu2AvLqkwQQbiQH8
         RP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u9FF5OWfzsi4DyrpW60LLUMz1VcIwydXpbxb65LGd/A=;
        fh=udOD1tveZtqZS1AqzJ9M1k5A/RXBR+DCtWvogqwM1Yk=;
        b=ANW+NaedX4pBH5LtRMMO+anhxHPHwE+igbu4bR62CSfYcCOWfpvCNQgJ7Vu9PyEnAs
         7BdbehAaapJTeIxg1fk0LFVMnMkfKo+VlSGdZvRUSn/RgUb2JPqVjSsnAvdRJvfXQxQd
         xXfo65xyyX+xCrwRKFrcD5K26nwLhUYEGH7SxizDh567c/O2ckvc82VmEJ685/q+xekm
         XcGnPJ5rnDfSES7xSe9tNDx8WCAX1wXiRmFy4b+MHU0GNrmCbwfgj00Pf502GW5acP2J
         tkfQz+SQmmt+sYIEDToOxuhNBvja2TvzLuCA4GZD6l1oQGDUagZCbh+x35zmUqs1a0fJ
         zRyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792710696; x=1793315496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u9FF5OWfzsi4DyrpW60LLUMz1VcIwydXpbxb65LGd/A=;
        b=L/tELMm6jIUKzclV/xG4I2WKyVgupyfttBTneMTpnZLJvyszCXMB2wwnwH152cnFVs
         dpSEiFHs6xNYQfcv9A+ZV2tYBlmvDJAq2r3g/YNI8FUSpsXE/iXzKvNLmqDwEk5idJFU
         x9LIynNIIh0OkXHLLn3NZRvjV8su2mXrQp/LaKFaPLqkVQuZQ2YsWMyFOeSlJgDv0NZ/
         qm4hhC9sW2wNv5YQah5Dk/vdEkNJOu2lcDfXkvAW3OmFjb+zyoJJFpRNSa0g/7mvdCQO
         sO2a1U8zOsimUFUOhO9TEOEWozPst2Kr0SW+O5YVsa9//xIIAelVbuyfCgiuXtYtHFQo
         3AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792710696; x=1793315496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9FF5OWfzsi4DyrpW60LLUMz1VcIwydXpbxb65LGd/A=;
        b=S/h9/bzMkT0EgIIWnqZSwQovFlc03evD+6uxygleHuEeIPv10Mg6PQj61YKM/v1w+V
         3TqTZ9sPLaC0PERy9lOpKh8rtcaCAmcGzJVGXPvUlhMtm8A4AF1EX6A39czYhrhFwwht
         vCxursYOFewDy3SldMfBZa8qqoOi68O0fw/J6Sj0ZBWfEo4ik7+G486EXtjfhjiDkZDZ
         7G2pLUICMoohuHifcoI/a8wFXYlpBT17iEG1EsSKv74KSM5eAx5Rp/h7VTIScgvhn6bf
         NCxi+yU2QXMYqE9K+G5+EqM7aGYiVhHnKCaKMRUGKtOODv/7bQlkQooKf/rQqkA5Xohu
         ftCQ==
X-Gm-Message-State: AFq9FYIbl4cWM2VFfwoplShujeK9Ckaze85uuPP5H5nd/6thSsEreVDb
	J0EPRoO5RiYuZwlZgonYeSYmKr4wCkFCLDPRovmTFtivi2B9bog+rPSqEjF64yraRKFzscxgQur
	5DluUBf+k0QmYVKFv0pGd9mZhVP5Pb3s=
X-Gm-Gg: AYBFou2+J/KSBbN7BSM6f9j0khRZLk/7773tO6rM6B0/X80/Jim5qZSQs+/kBCKwkY3
	Gy2F5lr5IbYsfS5OvOJcKAm4sX6Hsc06tU3UNepGbDldRmx03kvSn1wpnAh1yX2XBZEB5MpZ+Pc
	oyMLVXThMs5ka10pyPR+Z5/AbyR11ryDq1z63+te7/vJWuexWEIz/axIIGgR8oiGFtZlevcxowd
	7nKx0CtxZV61Z8XDdB9hCplWng83ApFWdUsaeFD2KgM0JEYVQibqOe2eqVmlUJORPg0uhBDO442
	2StLL2I/uEq9ydCxkaYWii23063O+XascGEPlxCQ/BoigVr+k0s8WNaY6QRS4NzrQY5GN5Vk/em
	bFfGSpA/rRiMqM8FhDC+QwPuxphhCSEChV8Mck/cbaqY2Cy5FqNj45KPvaru7uyipKW0PuDTJ1L
	doHIfyvIkAj524eZX2StPWF1dRiAnHCQQWxg==
X-Received: by 2002:a17:90b:3fcc:b0:3ac:7377:fd48 with SMTP id
 98e67ed59e1d1-3adce14f242mr304117a91.56.1792710695710; Thu, 22 Oct 2026
 16:11:35 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com> <20261022015712.1297331-6-alexei.starovoitov@gmail.com>
In-Reply-To: <20261022015712.1297331-6-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Oct 2026 16:11:20 -0700
X-Gm-Features: AclHuK8s6DwZCvueetumGiOa-ygE3J-xVZ2OzdSVggL1R0XHASR0IqYhKSbBJKQ
Message-ID: <CAEf4BzYs_Kis9ghhwnM3qWSCWRBwEtaZy5Xk+CJjYH3q0E9bNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/9] uprobes: Don't sleep on mmap_lock under dup_mmap_sem
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, 
	mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, 
	liam@infradead.org, ljs@kernel.org, surenb@google.com, david@kernel.org, 
	vbabka@kernel.org, jannh@google.com, hughd@google.com, kees@kernel.org, 
	mingo@redhat.com, tglx@kernel.org, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 6:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> register_for_each_vma() takes dup_mmap_sem for writing, collects mms that
> map the file and takes mmap_lock of every mm. fork() takes dup_mmap_sem f=
or
> reading. When mmap_lock of one mm is busy every fork() in the system wait=
s
> for it:
>
>   A:       mmap(MAP_POPULATE) -> mmap_read_lock(A)
>   tracer:  percpu_down_write(&dup_mmap_sem), mmap_write_lock(A) sleeps
>   others:  fork() -> percpu_down_read(&dup_mmap_sem) sleeps
>
> Only trylock mmap_lock under dup_mmap_sem. Leave mms with busy mmap_lock =
in
> the list, drop dup_mmap_sem and then wait for them.
>
> dup_mmap_sem makes sure that mm doesn't fork between build_map_info() and
> install_breakpoint() or remove_breakpoint(). Otherwise the child misses
> the breakpoint, or inherits the breakpoint of uprobe that is gone and get=
s
> SIGTRAP. Now mm in the list can fork. dup_mmap() holds mmap_lock of
> the parent, so uprobe_dup_mmap() does what the walk is going to do to thi=
s
> mm before vmas are copied. The walk sees info->done and skips it.
>
> The error in uprobe_dup_mmap() is the error of the walk, unless fork() is
> being killed. Such fork() fails in copy_process() and there is no child, =
so
> leave mm to the walk. With ref_ctr_offset the walk can update the counter
> twice in this case.
>

fwiw, none of the above blurb was really helpful, I had to read code
to actually get the high level idea of the patch. If anything, commit
message would be more helpful if it had less technicaly precise
description of what is being done, but rather a more high-level idea
to get the reviewer started. I don't know how much persuasion you'd
need to make your AI do this, but I think it would be helpful going
forward, especially for some dense stuff like this uprobe
registration/unregistration piece.

But as for the fix itself, it feels like the real problem is global
dup_mmap_sem lock, no? What if instead of one fancy (per-cpu) global
rwsem, we just have a per-mm rwsem. register_for_each_vma() will take
each mm's uprobe dup per-mm rwsem first, and keep it for the duration
of uprobe registration. In dup_mm() we only ever take mm-specific
rwsem, while register_for_each_vma() does a more heavy multiple lock
taking. But other than that we don't have a global uprobe walk list,
we don't have to handle registration/unregistration in two places,
etc.

I might be missing some remaining races, but I thought I'll propose
this and see if this idea has legs?

> dup_mmap_sem protects the list of walks. mm in the list is kept by
> mm_count. The walk takes mm_users only for the visit, so the process that
> exits meanwhile frees its memory.
>
> Busy mms are visited last. The tracer that is killed while it waits for o=
ne
> of them has installed the breakpoint in all other mms and cannot remove i=
t.
> "uprobes: Don't leak the breakpoints if the unregistering task is killed"
> fixes that.
>
> Process A loops over mmap(4G, MAP_POPULATE) and munmap(). A and 10 idle
> processes map the file. Process B calls fork() in a loop. 32 cpu VM.
> Median (max) of 15-25 runs, msec:
>
>                          the longest fork() in B    attach
>                          before      after          before  after
>  uprobe_multi, 1 uprobe  197 (209)   0.33 (0.70)       210    233
>  uprobe_multi, 4 uprobes 421 (429)   0.38 (0.60)      1467   1532
>  perf_event, 4 uprobes   422 (439)   0.43 (0.59)      3135   3289
>
> During detach: 264-423 -> 0.35-0.47. Attach and detach still wait for
> mmap_lock of A. B doesn't.
>
> The tracer pays when traced processes fork all the time. mm that forks
> holds its mmap_lock, so the walk sleeps on many mms in turn. Fork storms =
of
> 1200, 2000 and 5000 processes, 6 cpu VM, msec, without and with the serie=
s:
>
>  enable uprobe event    105 -> 205   201 -> 481   207 -> 784
>  disable uprobe event   225 -> 294   354 -> 579   407 -> 893
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/events/uprobes.c | 178 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 143 insertions(+), 35 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 6792004be6fa..a9274016c55d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1192,8 +1192,29 @@ struct map_info {
>         struct map_info *next;
>         struct mm_struct *mm;
>         unsigned long vaddr;
> +       bool done;
>  };
>
> +/*
> + * Every fork() waits for dup_mmap_sem, so register_for_each_vma() must =
not
> + * sleep on mmap_lock while it holds dup_mmap_sem. It leaves mms with bu=
sy
> + * mmap_lock in ->busy, drops dup_mmap_sem, and only then waits for them=
.
> + *
> + * Such mm can fork before its turn comes. dup_mmap() holds its mmap_loc=
k, so
> + * uprobe_dup_mmap() does what the walk is going to do to this mm, and
> + * the child has the same breakpoints as the child of mm that wasn't bus=
y.
> + */
> +struct uprobe_walk {
> +       struct list_head list;
> +       struct uprobe *uprobe;
> +       struct uprobe_consumer *new;
> +       struct map_info *busy;
> +       int err;
> +};
> +
> +/* dup_mmap_sem protects the list and ->busy of every walk in it */
> +static LIST_HEAD(uprobe_walks);
> +
>  static inline struct map_info *free_map_info(struct map_info *info)
>  {
>         struct map_info *next =3D info->next;
> @@ -1242,6 +1263,7 @@ build_map_info(struct address_space *mapping, loff_=
t offset, bool is_register)
>
>                 info->mm =3D vma->vm_mm;
>                 info->vaddr =3D offset_to_vaddr(vma, offset);
> +               info->done =3D false;
>         }
>         i_mmap_unlock_read(mapping);
>
> @@ -1271,26 +1293,79 @@ build_map_info(struct address_space *mapping, lof=
f_t offset, bool is_register)
>         return curr;
>  }
>
> -static int
> -register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new=
)
> +/*
> + * mmap_lock of info->mm is held for writing. info->done is set under it=
.
> + * The walk also tests it without mmap_lock, to skip mm.
> + */
> +static void register_one_mm(struct uprobe_walk *walk, struct map_info *i=
nfo,
> +                           bool in_fork)
>  {
> +       struct uprobe_consumer *new =3D walk->new;
> +       struct uprobe *uprobe =3D walk->uprobe;
> +       struct mm_struct *mm =3D info->mm;
> +       struct vm_area_struct *vma;
>         bool is_register =3D !!new;
> -       struct map_info *info;
>         int err =3D 0;
>
> +       if (info->done)
> +               return;
> +
> +       if (is_register && READ_ONCE(walk->err))
> +               goto done;
> +
> +       if (check_stable_address_space(mm))
> +               goto done;
> +
> +       vma =3D find_vma(mm, info->vaddr);
> +       if (!vma || !valid_vma(vma, is_register) ||
> +           file_inode(vma->vm_file) !=3D uprobe->inode)
> +               goto done;
> +
> +       if (vma->vm_start > info->vaddr ||
> +           vaddr_to_offset(vma, info->vaddr) !=3D uprobe->offset)
> +               goto done;
> +
> +       if (is_register) {
> +               /* consult only the "caller", new consumer. */
> +               if (consumer_filter(new, mm))
> +                       err =3D install_breakpoint(uprobe, vma, info->vad=
dr);
> +       } else if (mm_flags_test(MMF_HAS_UPROBES, mm)) {
> +               if (!filter_chain(uprobe, mm))
> +                       err =3D remove_breakpoint(uprobe, vma, info->vadd=
r);
> +       }
> +
> +       if (err) {
> +               /*
> +                * fork() was killed meanwhile. This is not the error of
> +                * the walk. See uprobe_dup_mmap().
> +                */
> +               if (in_fork && fatal_signal_pending(current))
> +                       return;
> +               WRITE_ONCE(walk->err, err);
> +       }
> + done:
> +       WRITE_ONCE(info->done, true);
> +}
> +
> +static int
> +register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new=
)
> +{
> +       struct uprobe_walk walk =3D { .uprobe =3D uprobe, .new =3D new };
> +       struct map_info *info, *next;
> +
>         percpu_down_write(&dup_mmap_sem);
> -       info =3D build_map_info(uprobe->inode->i_mapping,
> -                                       uprobe->offset, is_register);
> +       info =3D build_map_info(uprobe->inode->i_mapping, uprobe->offset,=
 !!new);
>         if (IS_ERR(info)) {
> -               err =3D PTR_ERR(info);
> -               goto out;
> +               percpu_up_write(&dup_mmap_sem);
> +               return PTR_ERR(info);
>         }
>
> -       while (info) {
> +       for (; info; info =3D next) {
>                 struct mm_struct *mm =3D info->mm;
> -               struct vm_area_struct *vma;
>
> -               if (err && is_register)
> +               next =3D info->next;
> +               /* If install failed the caller is going to undo it */
> +               if (new && walk.err)
>                         goto free;
>                 /*
>                  * We take mmap_lock for writing to avoid the race with
> @@ -1299,38 +1374,56 @@ register_for_each_vma(struct uprobe *uprobe, stru=
ct uprobe_consumer *new)
>                  * is_trap_at_addr() true right after find_uprobe_rcu()
>                  * returns NULL in find_active_uprobe_rcu().
>                  */
> -               mmap_write_lock(mm);
> -               if (check_stable_address_space(mm))
> -                       goto unlock;
> -
> -               vma =3D find_vma(mm, info->vaddr);
> -               if (!vma || !valid_vma(vma, is_register) ||
> -                   file_inode(vma->vm_file) !=3D uprobe->inode)
> -                       goto unlock;
> -
> -               if (vma->vm_start > info->vaddr ||
> -                   vaddr_to_offset(vma, info->vaddr) !=3D uprobe->offset=
)
> -                       goto unlock;
> -
> -               if (is_register) {
> -                       /* consult only the "caller", new consumer. */
> -                       if (consumer_filter(new, mm))
> -                               err =3D install_breakpoint(uprobe, vma, i=
nfo->vaddr);
> -               } else if (mm_flags_test(MMF_HAS_UPROBES, mm)) {
> -                       if (!filter_chain(uprobe, mm))
> -                               err |=3D remove_breakpoint(uprobe, vma, i=
nfo->vaddr);
> +               if (!mmap_write_trylock(mm)) {
> +                       /*
> +                        * uprobe_dup_mmap() compares info->mm until list=
_del().
> +                        * Keep mm_struct, but not the memory of the proc=
ess.
> +                        */
> +                       mmgrab(mm);
> +                       mmput_async(mm);
> +                       info->next =3D walk.busy;
> +                       walk.busy =3D info;
> +                       continue;
>                 }
> -
> - unlock:
> +               register_one_mm(&walk, info, false);
>                 mmap_write_unlock(mm);
>   free:
>                 /* exit_mmap() of the last user must not run under dup_mm=
ap_sem */
>                 mmput_async(mm);
> -               info =3D free_map_info(info);
> +               kfree(info);
>         }
> - out:
> +
> +       if (!walk.busy) {
> +               percpu_up_write(&dup_mmap_sem);
> +               return walk.err;
> +       }
> +
> +       list_add(&walk.list, &uprobe_walks);
>         percpu_up_write(&dup_mmap_sem);
> -       return err;
> +
> +       for (info =3D walk.busy; info; info =3D info->next) {
> +               struct mm_struct *mm =3D info->mm;
> +
> +               /* Don't wait for mm if its fork() did it or if install f=
ailed */
> +               if (READ_ONCE(info->done) || (new && READ_ONCE(walk.err))=
)
> +                       continue;
> +               /* All users are gone, like in build_map_info() */
> +               if (!mmget_not_zero(mm))
> +                       continue;
> +               mmap_write_lock(mm);
> +               register_one_mm(&walk, info, false);
> +               mmap_write_unlock(mm);
> +               mmput(mm);
> +       }
> +
> +       percpu_down_write(&dup_mmap_sem);
> +       list_del(&walk.list);
> +       percpu_up_write(&dup_mmap_sem);
> +
> +       for (info =3D walk.busy; info; info =3D free_map_info(info))
> +               mmdrop(info->mm);
> +
> +       return walk.err;
>  }
>
>  /**
> @@ -1841,6 +1934,21 @@ void uprobe_end_dup_mmap(void)
>
>  void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
>  {
> +       struct uprobe_walk *walk;
> +       struct map_info *info;
> +
> +       list_for_each_entry(walk, &uprobe_walks, list) {
> +               /*
> +                * fork() that is being killed fails in copy_process().
> +                * There will be no child. Leave oldmm to the walk.
> +                */
> +               if (fatal_signal_pending(current))
> +                       break;
> +               for (info =3D walk->busy; info; info =3D info->next)
> +                       if (info->mm =3D=3D oldmm)
> +                               register_one_mm(walk, info, true);
> +       }
> +
>         if (mm_flags_test(MMF_HAS_UPROBES, oldmm)) {
>                 mm_flags_set(MMF_HAS_UPROBES, newmm);
>                 /* unconditionally, dup_mmap() skips VM_DONTCOPY vmas */
> --
> 2.55.0
>
