Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7C56C623
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882838; cv=pass; b=P3Ap/jQ3hKh81a+rJywSxLW3AhIU5zVaGZ/lPPNwmpFAZgBFZ+9JsmM79CIj1q0M3GMwXikv1pTcx3w8b5q+K4skPFmOgsYPC0kGgZllg4jS37Ookt7lIFxjvMW9D0kkTOZBmbkKbLSdz9D3sakAztDh4vSrFVJ++Fxd+fENSVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882838; c=relaxed/simple;
	bh=Ikp0uhvztH30GrbIL3DQZHFxBp8d0BvUmBQvOxRGVOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHce3KoGOvX1vrf/NoP5PiRmaFT0mT80Cceu5bxzIretsAGLPLILYo96485QoYsr1lls3Z/0dEaQ2CSEPrWddun+sLNMIpDOeAX53QUtqCrsMFZn2hddvzR96/mZJ4EbqNjlRphv6YF8nlDfDvIi75jnwYTp3SCPqRoiioMmA4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=uugbFlWb; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="uugbFlWb"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-861feb6d61bso43157417b3.2
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 08:53:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788882835; cv=none;
        d=google.com; s=arc-20260327;
        b=XfR+mM/qevt2GQBuaoSxDOBigiA8HaP9GIXaZbEdRGkuyjDQy2HjAc9WmtH/Agsjn4
         9DjLB5udFUXt0bHaH9HIMuXYKTf4bmFsPyYj6hj7HPjLSmTl4cYE+lVoc6ix65EuK9GK
         gX7IX4bmtPeBCJesA01Ilu0XR9gdQQjsThY52oof7Cw87GmQlZiz06eFczmxIca3JH+5
         uatVCgimSWxgNPDMciVcuKy/Vp1Y/G/66T4ry0A7KX6eA7HYdARHF2DatkrJ+NcgmeT3
         0msciFVgVTTXBebtlmponZLzyH4KalfQQNNTyJmSrOYGSJ77gwjy35FlDmhvUf/sCebD
         gItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mdlaDsd+kR4vJx7ggmKQI0XmbSPk1lGx0nVrQ9Q8nlw=;
        fh=XfMQlEiLir1bnLuoKvJjiiRNRzyPn4E17UAtxFA+21Y=;
        b=Ru6OoFo59JjoLbqfhZ4bxKYbgjjlhsCtIgD3ffNX1pW+NQniZbxtAZ5XuLFDw4nafM
         RCjB09HZ8zXxoyq7+Lapgvu36jvxgIyS3hz+/3F3purlX4k06u1sOTyRCgz9J951tfux
         yBAKgc7ETTp/RjEiaUxOL0RgTRy44MhRmc5tXrfos5HNlhbFiIOsbtMIsCksmtJQlUH0
         oynQNrRFa6VPy5544bOpfDEtolqTanGnQet35j9W/HZE6yXyIwzTRu/Enqkuy7jBM3QZ
         3ERwB+a4Jk4TwLxHRU9zpWVWdP69Rrt0nI8nHrUml+fOKCgUhA6xWZKeXpaB6z0LQDcO
         3X4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788882835; x=1789487635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mdlaDsd+kR4vJx7ggmKQI0XmbSPk1lGx0nVrQ9Q8nlw=;
        b=uugbFlWblDg9SPdF39T/5IEK0lfWebAYthdBEWn92oy2sAGn7QmGKTwCwgJsMqD9C/
         TJQI1eQigCtA0r3QV8ZuTR4JpHjHJRu2OuncVU64RlzON82KW/4shdV+G1PXW8uCgFA1
         VceYm6wEQudt6lyd3TfRKw+4ScCnAvp+NdMXgGmOLxT5aqboIbVVWvzRaUjm9Gvt1WQs
         YconI4K/9chhI7G2aYz4J6YtaYe3m/+k9R0QbZ4EJbFJg6I3KCFreMD3BnBubu8S0gOD
         MhWFmmRfG1ZwwmuIigjShhr75+XYAEfMrxAvuZhyjU5mntbu1BC1QUVWTrMVMfXaALNr
         Dvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882835; x=1789487635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mdlaDsd+kR4vJx7ggmKQI0XmbSPk1lGx0nVrQ9Q8nlw=;
        b=O/xcM4nw/IYAc25CaSnv1GWll0qK0GcTQfwxoIOmH88KwyxaTKirj+zSuYhYZjIzus
         9otDi96wo6fNTxq4fx1Ef8Y7oFTJbB0wEsJQSCvb+Z7rAErVPSWdhc6cZNaDd0KBfa52
         pO5Yb1tNdplcE3FmI9//3VsseAHt1I2P7+lMi+sXogQA+g/hZvnD4Xlm9y3KHF7ZrbMj
         NFDCVzAE5kSN+2l9GQDP94RcgSQM1mVycOkJXAr/HrRTJdM01sJnoYJFp6l+qyreBybA
         zKyhAnuknGn+UyRUYb0g0QY+T9+IzqcwEWDJMLOs8UQLeYHQF+aft8zuNzyv/EgEpejs
         Uvlw==
X-Gm-Message-State: AFuF++kTMNAosa/X9YOTmxc6CfMB9xOx7Pom8Yc6Wlx3mUTOJYHufUdu
	DjqkMDs68tIYyx8NheOkywxKPE68ZtkXf+LwNS64L+z+5vPdrslwVvVA+amUWR2pwXx5bMt5EqZ
	aeBD2GzkHP/oMHxdWuuLuge5m6v3d9+Bu0Kn8wE0+Dg==
X-Gm-Gg: AYBFou2rcCRRWCzHKK6kZ4TJ5qet0j4+CN7k6tkD/k9Vu5yu2YULCTDJmfIoEPV/AQn
	BgyB3J1MtVy6H/R2YiVcGx5IffMGv1fJXxgEPZZ2Qa0qYPFn61ueXnDE9itJcBOsvQPqXL6OwZA
	xgmBdFWFuV8K7kPn1cYvcuqLm4Wj2TvwVEz7v+RgX5f+CBS2kPiYBbvMhesx1PQHYTo/JILblzp
	5r1iXKpqEsgUNtVtiCzpQmwjmUWYFtqIwAi4TIS29/mLJ6S8x/y9WZpRuRdpEkRfgsp9UuWauWS
	0roka3xF3pqPOJI+XuIakWPyUEQSJ0adfwOG/9nTryUO
X-Received: by 2002:a05:690c:6207:b0:859:9c98:b8b4 with SMTP id
 00721157ae682-8712b9890d5mr136194947b3.31.1788882834469; Tue, 08 Sep 2026
 08:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKPSWBzaEc7QBT39C_N_32Gu5_P5Cob9G0rxcDgiSQg6g@mail.gmail.com>
 <20260902093740.2338724-1-chenyuan_fl@163.com> <20260902093740.2338724-4-chenyuan_fl@163.com>
In-Reply-To: <20260902093740.2338724-4-chenyuan_fl@163.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 8 Sep 2026 11:53:43 -0400
X-Gm-Features: AcwNN1U-iPQaheRLInhEbsEshSGnEHGKkH0P6Hqp8LfgSXuZsUyD_7-306XyuWU
Message-ID: <CABFh=a6QOjBv1c7B0fw0AEqaBXiQJRh=8on5DUfqPC7hYuGBxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] bpf, arena: handle range_tree_set
 failures in alloc/free paths
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yuan Chen <chenyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 5:38=E2=80=AFAM <chenyuan_fl@163.com> wrote:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> arena_alloc_pages(), arena_free_pages() and arena_free_worker() now
> handle range_tree_set() errors. arena_free_pages() aborts the free on
> error, and arena_free_worker() moves range_tree_set() before PTE
> clearing so that a failed tree update leaves the PTEs intact instead of
> freeing pages that the arena free tree does not track.
>
> Also check the range_tree_set() return value in arena_alloc_pages()'s
> error path, which restores the unpopulated tail of a partially
> allocated range; log a warning instead of silently leaking the virtual
> range when the tree update fails.
>
> range_tree_set() is failure-atomic (it pre-allocates the node before
> touching the tree), so on -ENOMEM the range stays tracked as allocated
> and the pages remain mapped and accessible. A failed free is therefore
> retryable, and arena_map_free() reclaims any retained pages at map
> destruction; aborting the free avoids clearing PTEs for pages the
> arena free tree does not track.
>
> In arena_free_worker() a failed tree update used to leave the span in
> the drained list, where the second loop would still flush TLB entries,
> zap user VMAs, and free the span itself: the free request was dropped,
> user mappings were destroyed for a free that never happened, and the
> pages stayed mapped until map destruction. Keep failed spans on
> arena->free_spans instead and retry them on a later worker run; only
> spans whose PTE clearing actually ran are flushed, zapped, and
> released.
>
> The retry queues arena->free_irq while the map can concurrently be
> freed. arena_map_free() relied on irq_work_sync() + flush_work(),
> which miss an irq_work queued by the running worker between the two
> calls: the irq_work can fire after the arena is freed and its callback
> schedules free_work on freed memory. Set arena->dying under the arena
> spinlock before draining, so the worker stops requeueing, steal the
> orphaned spans (their pages are reclaimed by existing_page_cb()), and
> drain with flush_work() + irq_work_sync() + flush_work().
>
> Setting @dying requires the arena spinlock. raw_res_spin_lock_irqsave()
> can fail (-EDEADLK on a proven deadlock cycle, -ETIMEDOUT after a long
> hold), and proceeding without the lock would race the worker. Retry a
> bounded number of times for a long but finite hold and do not retry
> -EDEADLK; on exhaustion leak the arena with a WARN carrying the error
> code rather than hang map free.
>
> Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  kernel/bpf/arena.c | 95 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 87 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b43..b0d1f0facfb2 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -5,6 +5,7 @@
>  #include <linux/cacheflush.h>
>  #include <linux/err.h>
>  #include <linux/irq_work.h>
> +#include <linux/delay.h>
>  #include "linux/filter.h"
>  #include <linux/llist.h>
>  #include <linux/btf_ids.h>
> @@ -67,6 +68,8 @@ struct bpf_arena {
>         struct irq_work     free_irq;
>         struct work_struct  free_work;
>         struct llist_head   free_spans;
> +       /* set under spinlock during map free; stops the worker retry loo=
p */
> +       bool dying;
>  };
>
>  static void arena_free_worker(struct work_struct *work);
> @@ -370,6 +373,9 @@ static int existing_page_cb(pte_t *ptep, unsigned lon=
g addr, void *data)
>  static void arena_map_free(struct bpf_map *map)
>  {
>         struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> +       struct llist_node *list, *pos, *t;
> +       unsigned long flags;
> +       int ret, i;
>
>         /*
>          * Check that user vma-s are not around when bpf map is freed.
> @@ -380,7 +386,40 @@ static void arena_map_free(struct bpf_map *map)
>         if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
>                 return;
>
> -       /* Ensure no pending deferred frees */
> +       /*
> +        * No fallback if this fails, so retry a few times for a long but
> +        * finite hold; -EDEADLK can't be waited out. Cap the retries:
> +        * leaking the arena is better than hanging map free.
> +        */
> +       for (i =3D 0; i < 10; i++) {
> +               ret =3D raw_res_spin_lock_irqsave(&arena->spinlock, flags=
);
> +               if (!ret || ret =3D=3D -EDEADLK)
> +                       break;
> +               msleep(1);
> +       }

A hardcoded msleep is definitely not the way to go.

> +       if (ret) {
> +               WARN_ONCE(1, "bpf_arena: spinlock acquire failed %d\n", r=
et);
> +               return;
> +       }
> +       /*
> +        * Set @dying before draining: the worker checks it under this
> +        * spinlock before requeueing, so a failed span is either stolen
> +        * here or dropped by the worker.
> +        */
> +       arena->dying =3D true;
> +       list =3D llist_del_all(&arena->free_spans);
> +       raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +
> +       llist_for_each_safe(pos, t, list)
> +               kfree_nolock(llist_entry(pos, struct arena_free_span, nod=
e));
> +
> +       /*
> +        * flush_work() lets the running worker observe @dying so it stop=
s
> +        * requeueing; irq_work_sync() retires anything queued before tha=
t;
> +        * the final flush_work() runs the instance which the retired
> +        * irq_work's callback may have scheduled.
> +        */
> +       flush_work(&arena->free_work);

The extra IRQs are also not a great idea, considering the range tree
failures are
due to memory shortage. There is no perfectly clean way to deal with it, bu=
t imo
the way is to leak the memory instead of trying to recover, so the patch sh=
ould
focus on leaving the range tree and page tables consistent.

Since this patch has drifted quite a bit since the initial revisions,
can you also
remove the Suggested-by tag from me?

pw-bot: cr

>         irq_work_sync(&arena->free_irq);
>         flush_work(&arena->free_work);
>
> @@ -766,7 +805,9 @@ static long arena_alloc_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt
>         bpf_map_memcg_exit(old_memcg, new_memcg);
>         return clear_lo32(arena->user_vm_start) + uaddr32;
>  out:
> -       range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
> +       if (range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped)=
)
> +               pr_warn_ratelimited("bpf_arena: leak range %ld+%ld on fai=
led alloc\n",
> +                                   pgoff + mapped, page_cnt - mapped);
>         raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>         if (mapped) {
>                 flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_=
SHIFT);
> @@ -881,7 +922,20 @@ static void arena_free_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt,
>         if (ret)
>                 goto defer;
>
> -       range_tree_set(&arena->rt, pgoff, page_cnt);
> +       ret =3D range_tree_set(&arena->rt, pgoff, page_cnt);
> +       if (ret) {
> +               /*
> +                * range_tree_set() is failure-atomic, so -ENOMEM leaves =
the
> +                * range allocated and the pages mapped; abort the free r=
ather
> +                * than release pages the tree does not track. Nothing re=
tries
> +                * the free; the program can free the range again.
> +                */
> +               pr_warn_ratelimited("bpf_arena: free of %lx+%ld failed\n"=
,
> +                                   uaddr, page_cnt);
> +               raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +               bpf_map_memcg_exit(old_memcg, new_memcg);
> +               return;
> +       }
>
>         init_llist_head(&free_pages);
>         cdata.arena =3D arena;
> @@ -977,12 +1031,13 @@ static void arena_free_worker(struct work_struct *=
work)
>         struct llist_node *list, *pos, *t;
>         struct arena_free_span *s;
>         u64 arena_vm_start, user_vm_start;
> -       struct llist_head free_pages;
> +       struct llist_head free_pages, cleared;
>         struct clear_range_data cdata;
>         struct page *page;
>         unsigned long full_uaddr;
>         long kaddr, page_cnt, pgoff;
>         unsigned long flags;
> +       bool retry =3D false;
>
>         if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
>                 schedule_work(work);
> @@ -992,28 +1047,52 @@ static void arena_free_worker(struct work_struct *=
work)
>         bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>
>         init_llist_head(&free_pages);
> +       init_llist_head(&cleared);
>         cdata.arena =3D arena;
>         cdata.free_pages =3D &free_pages;
>         arena_vm_start =3D bpf_arena_get_kern_vm_start(arena);
>         user_vm_start =3D bpf_arena_get_user_vm_start(arena);
>
>         list =3D llist_del_all(&arena->free_spans);
> -       llist_for_each(pos, list) {
> +       llist_for_each_safe(pos, t, list) {
>                 s =3D llist_entry(pos, struct arena_free_span, node);
>                 page_cnt =3D s->page_cnt;
>                 kaddr =3D arena_vm_start + s->uaddr;
>                 pgoff =3D compute_pgoff(arena, s->uaddr);
>
> +               /*
> +                * Set the range free before clearing PTEs, and requeue t=
he
> +                * span on failure: the PTEs stay intact and the free is
> +                * retried later. Only spans moved to @cleared (PTE clear=
ing
> +                * actually ran) reach the flush/zap/release loop below.
> +                */
> +               if (range_tree_set(&arena->rt, pgoff, page_cnt)) {
> +                       if (arena->dying) {
> +                               /*
> +                                * The map is being freed. PTEs stay inta=
ct
> +                                * and the pages are reclaimed by
> +                                * arena_map_free() via existing_page_cb(=
).
> +                                */
> +                               kfree_nolock(s);
> +                               continue;
> +                       }
> +                       llist_add(&s->node, &arena->free_spans);
> +                       retry =3D true;
> +                       continue;
> +               }
> +
>                 /* clear ptes and collect pages in free_pages llist */
>                 apply_to_existing_page_range(&init_mm, kaddr, page_cnt <<=
 PAGE_SHIFT,
>                                              apply_range_clear_cb, &cdata=
);
> -
> -               range_tree_set(&arena->rt, pgoff, page_cnt);
> +               llist_add(&s->node, &cleared);
>         }
>         raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>
> +       if (retry)
> +               irq_work_queue(&arena->free_irq);
> +
>         /* Iterate the list again without holding spinlock to do the tlb =
flush and zap_pages */
> -       llist_for_each_safe(pos, t, list) {
> +       llist_for_each_safe(pos, t, cleared.first) {
>                 s =3D llist_entry(pos, struct arena_free_span, node);
>                 page_cnt =3D s->page_cnt;
>                 full_uaddr =3D clear_lo32(user_vm_start) + s->uaddr;
> --
> 2.54.0
>
