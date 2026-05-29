Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996533A718D
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 06:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035633; cv=pass; b=vGGicS/aP544kZAFE6ycp8sSqLevab+JlFZc2hpWDtx9TA+WXafqKOgVNpCXA0+MFxqp8ePKAwCkmZWHzkHeamCP4EmbF+r7A3OJOtZAgba87Y1ad1b9ibYx9PPZE2vmakTfjsN53I1cxqd+z3em1YervKo9DY7kgtGWeipeskE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035633; c=relaxed/simple;
	bh=WXnkJrvxAcLNs2It07Hu4MDmWkJ9Z62fkJ2Km/cnLjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCzrLyD/+p1GnMT++Jd4NVvxBjghYUxK3GjNMCEYdGiY6qgLyYLKBZWv8Zzw0CWFx1CZ1DWPSjjlYMMb3u1sci5xgKHneIf87tJOxZEH2djGxpgc7Ibgce0UWSTISG/amsFxFmBrZlaCaxi2ZzIozLIbZFzlKNM0Gi5pns8Jb/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKY51Fe5; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKY51Fe5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so85711465e9.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 23:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780035630; cv=none;
        d=google.com; s=arc-20240605;
        b=Yvzxi/V7eKyoPcrvwj/St3VXsL2igt7k4pjMAz9SzGsqH/AXID8q/djmeBzo18LLNJ
         y3d2qWubJ8YaI2a2Kn+RdGgmTugmTltwLPDW8gDhtg9Kv9ODb1tR0PQE30Lyl2jFZmTV
         Pd+5TH48gFoJLG4ErYpsRYACn6WMndqb6qOcR+DKG0m25gxLZ6y39b8L2V2utp8PDrm1
         PAg7RmKlnCEXHO+JCnqjwS3cErnkoe174MiGmDcPhHm6yJ4IL1oPG6MnBY8iY3uR9JnK
         06A528sQ6iH3XJ22p0ZWZU6XzmxPyMnLJBwtGdEsM1lCejY5dN4hM4qzAnvuGeGqd3xc
         ATRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XMRQtkgtVF9cIwl/+aRzWJsjOYum99WxjW3hvgcQ5DY=;
        fh=euEEEsmAS2hvtRLVZGoSrkxb58/sqY/DWHkzCjwkqMY=;
        b=hhCDefRXOjb3Qe8zGswfT8dh9eMGqOAq8gvfl3YKniUGY1p9udhc4KY1I8x6lSmQhH
         3Vyf5yQOqYYfSmE3SCfxa65i9V+YOmCs/LTW+xjujH3yKpNV+3tm7JYF3dFsqtgY7evY
         g4/ImVyPJi0/vyzCgZHop4p2BNs+bumCY1LaNUDXbN9XJkZSrFaOa1jVYJNVCkD6hnpp
         Ep0VCkMD0gF2JMaz6SHVJ0UNkSH+jSj8xpTjlPjvKhTddah4ZFEAzVy8TSG8HIYA1NGB
         8oIoYhSfQ+dqCAG+eLkUCbyEEO10BNh1QPlrbcSnvBvGr6kSYouinQcmoxgF6jf0kUHL
         MfaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780035630; x=1780640430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMRQtkgtVF9cIwl/+aRzWJsjOYum99WxjW3hvgcQ5DY=;
        b=NKY51Fe5aH5EYD7FppqUtkGsiXKcgfwJ4YuBDm5mQfavFkrMi4phqt0+91yWmYT6VN
         mEpzn2EAFFUnRnyumgNcn3lWXwYFS7fc7etZYiA/36XH9ZLLzs4cs7xBb5LYm03os+aJ
         zLIw1VO2z1vvPslx592oqorSATYrR5IQRRkEYS33tLpAUUxbcr4ThGTHJUnFEjPQb4RG
         5jwTWrczORHfL8vg8kNm2sGkJoooHcviq5yUTRseuanuO75rztj3kujIX1dUt62ohF22
         TIyi6wTnbJOGUb9CYGgeSpO2kDyvwpEexkw6ETyrxIpYAWpPaFJcKR/fYFGVdpyXd25u
         nLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780035630; x=1780640430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XMRQtkgtVF9cIwl/+aRzWJsjOYum99WxjW3hvgcQ5DY=;
        b=SXOajs7CYeHrVdD3axZVw2PP5g/Njk4uYTEmJISn//sycSWP2ueWq8lL3xJrGpP1BF
         EVCcGwm4tTTc7SP4qcMq3GeB/POPEjLStH82MmbL59NTtooYgXHiXIJvTJmHG+Sj3cbH
         tdjfA9m3OsTU5FvV3TNbfzyrjZeTK5jgmEU5NssJhyN4FODpuINyilCNOa+EdH94Gt/M
         1z9RMbm4rN0DUKyis/VZ2J15W2+WeAyASN4l8J2pAomOHZN4QnXaqP7IZF25j+8IrTdx
         hAmVMBAe3KHYasicP0q9uRrr+EFzZGG4e+n5ioOO7exCOoX8hyvQ98XuRzU+dUo4ZL8P
         58NQ==
X-Gm-Message-State: AOJu0YyGBW7ObTHqtw/prikOc8/TzEAMW+ShQBg+7P4WlC2aA2HB7qGn
	jUb+1w9r/mWggHjGYh8P++o6B8cLZO9K6+hWT9hlzAjaJalYmuHjjLLcuK1ZhQ/jDzbDAqI0o7B
	9m6rbl5rJDK7OZmivcTH6z9V7ebmwi/Q=
X-Gm-Gg: Acq92OE5asC5Hwhi9hEaVh85A5WbjfNw7J6iRV62Jnv6dn05umvKdw6Bwz4EM2oIiyj
	yk1HBC51ASmwBKsb5j11p1UmLqW1pq6ttPWGukmyCyYN00e2mAJiD0oBBDZtrfPqVWA/fQRsa2R
	hY1rfRlJMguU46gvOl6OZ6EiJRl8iUqM3wE48D90amO0G8lVodEQaqHs5qzR6QXE6fSHFQ3dmd/
	X8jTQoIqQA1bGH8AwImexdpuXkFv0CYZgMUhpNbIRGq1EefqBsm/4XTX4GoSrR0wflWvu6T+39d
	QbswlyEfkwsnmR93HsYZnyqR+El8VQk8WMw3D5pCsx3XbLjZfgB3ijvEuco3WYgd+OVH3d3Zqk1
	yoQom2PljiFvnN80XD/qgrLgch9i56FrW1QMg
X-Received: by 2002:a05:600c:3556:b0:490:44eb:c1e5 with SMTP id
 5b1f17b1804b1-4909c0f8487mr25739045e9.31.1780035629763; Thu, 28 May 2026
 23:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528222014.38980-1-alexei.starovoitov@gmail.com> <DIUWW97NOAG2.N0U9S6VNDIQ7@etsalapatis.com>
In-Reply-To: <DIUWW97NOAG2.N0U9S6VNDIQ7@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 May 2026 23:20:18 -0700
X-Gm-Features: AVHnY4Ky5dync1qELFymxfiPpmCefoJniOMNVKuCvZS3I6XgX5qmQSxMWTBIYpw
Message-ID: <CAADnVQJK2=VTU-spL0T+HxQSiJKg7XYtkqv5LgnQmsyFOgJcxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Take mmap_lock in zap_pages()
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 10:30=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> On Thu May 28, 2026 at 6:20 PM EDT, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > zap_vma_range() requires the owning mm's mmap_lock to be held.
> >
> > Taking mmap_read_lock under arena->lock would AB-BA against
> > arena_vm_close() and arena_map_mmap(), both of which run with
> > mmap_write_lock held and then acquire arena->lock. Instead drop
> > arena->lock, mmget_not_zero() the vma's mm, take mmap_read_lock, and
> > re-resolve the vma via find_vma() since it may have been unmapped or
> > replaced while waiting.
> >
> > Track processed vmls with a per-call generation in vml->zap_gen and
> > serialize zap_pages() callers with a new arena->zap_mutex so
> > concurrent callers on different uaddr ranges do not mark each other's
> > vmls processed before the zap is done.
> >
> > Reported-by: David Hildenbrand <david@kernel.org>
> > Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/bpf/arena.c | 61 +++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 57 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 1727503b25d8..9b2dea229b38 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -60,6 +60,8 @@ struct bpf_arena {
> >       struct list_head vma_list;
> >       /* protects vma_list */
> >       struct mutex lock;
> > +     u64 zap_gen;
> > +     struct mutex zap_mutex;
> >       struct irq_work     free_irq;
> >       struct work_struct  free_work;
> >       struct llist_head   free_spans;
> > @@ -289,6 +291,7 @@ static struct bpf_map *arena_map_alloc(union bpf_at=
tr *attr)
> >       if (err)
> >               goto err_free_scratch;
> >       mutex_init(&arena->lock);
> > +     mutex_init(&arena->zap_mutex);
> >       raw_res_spin_lock_init(&arena->spinlock);
> >       err =3D populate_pgtable_except_pte(arena);
> >       if (err)
> > @@ -391,6 +394,7 @@ struct vma_list {
> >       struct vm_area_struct *vma;
> >       struct list_head head;
> >       refcount_t mmap_count;
> > +     u64 zap_gen;
> >  };
> >
> >  static int remember_vma(struct bpf_arena *arena, struct vm_area_struct=
 *vma)
> > @@ -403,6 +407,7 @@ static int remember_vma(struct bpf_arena *arena, st=
ruct vm_area_struct *vma)
> >       refcount_set(&vml->mmap_count, 1);
> >       vma->vm_private_data =3D vml;
> >       vml->vma =3D vma;
> > +     vml->zap_gen =3D 0;
> >       list_add(&vml->head, &arena->vma_list);
> >       return 0;
> >  }
> > @@ -746,12 +751,60 @@ static long arena_alloc_pages(struct bpf_arena *a=
rena, long uaddr, long page_cnt
> >   */
> >  static void zap_pages(struct bpf_arena *arena, long uaddr, long page_c=
nt)
> >  {
> > +     unsigned long size =3D (unsigned long)page_cnt << PAGE_SHIFT;
> > +     struct vm_area_struct *vma;
> > +     struct mm_struct *mm;
> >       struct vma_list *vml;
> > +     unsigned long vm_start;
> > +     u64 my_gen;
> >
> > -     guard(mutex)(&arena->lock);
> > -     /* iterate link list under lock */
> > -     list_for_each_entry(vml, &arena->vma_list, head)
> > -             zap_vma_range(vml->vma, uaddr, PAGE_SIZE * page_cnt);
> > +     /*
> > +      * Taking mmap_read_lock() under arena->lock would deadlock again=
st
> > +      * arena_vm_close(), which runs with mmap_write_lock held and the=
n
> > +      * acquires arena->lock. Drop arena->lock for mmap_read_lock().
> > +      *
> > +      * Use per-call my_gen, recorded in vml->zap_gen, to remember whi=
ch
> > +      * vmls this invocation has already processed across the lock dro=
p.
> > +      * Hold zap_mutex around the whole walk so concurrent zap_pages()
> > +      * callers cannot overwrite each other's marks on shared vmls --
> > +      * otherwise call B's mark would make call A skip a vml that A ha=
s
> > +      * not yet zapped for A's uaddr range.
>
> One thing I'm fuzzy on: If the vml gens are to mediate between zap_pages
> calls on the same arena, doesn't the zap_mutex already serialize those
> calls? In that case, since zap_gen is only used for zap_pages(), do we
> actually need gen counting?

hmm. Good question!
That was an evolution of the patch over several revisions.
The algorithm can be changed to:
        mutex_lock(&arena->lock);
-       my_gen =3D ++arena->zap_gen;
+       list_for_each_entry(vml, &arena->vma_list, head)
+               vml->zapped =3D false;
        for (;;) {
                mm =3D NULL;
                list_for_each_entry(vml, &arena->vma_list, head) {
-                       if (vml->zap_gen >=3D my_gen)
+                       if (vml->zapped)
                                continue;
-                       vml->zap_gen =3D my_gen;
+                       vml->zapped =3D true;

which I think is less pretty since an extra walk of the list is needed.
We cannot remove zap_gen completely, since arena_vm_close() can list_del() =
it.
So vml->zapped or some kinda marker under arena->lock is still needed.

Another option would be to move processed vml-s into stack local link list:
grab the element from arena->vma_list under arena->zap_mutex,
processed it without holding arena->lock, and then at the end
add it back to arena->vma_list.
Feels more convoluted.
