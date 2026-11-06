Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793984194;
	b=TMsssjiVMcrDDp0w8Uhs6ibIj20Jvly815nfoIfFn6lJ5wahO9T7h77EFv1O9RqV9HB1
	 3F7Zx7UlZOn+8HLLS8GoOCbkwPznUB4qoGfmXy9lMM6FpuRmyKctBREjxQ9MbVJyD5Ztc
	 9Qk1wDuofdkiCuD2ia9dI+Kf4B0RA6w7oFG8YFpWajTxqsGMiOdMoomLgyFUX+NYnf+Hf
	 Ch66WGHu3ce63IVwhI7NfwLgQcnFuyyzfTM0BaBgE6LVR45pVGla5IsF27qE4T8hI5Cjh
	 uLwmbSlgVdHCCwD34q3RuaoP6ciAHQhvCVtDjCzdIoN0AEm97XF+ulf8Ytj3lbHfBmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=AvsZipJQd3N+aW9q9yz8PnuJq8twP8IW8udPI5xfiVo=;
	b=VxZmHTrsDel77j2sX6zkplS5YL/+HwL6LNRybfKpag+gr9oWz3lDCbyji1tTjpFW5ACB
	 7OthgQDFcdbNFN87M03xkNakw2S+FYoK7S1uqrDQjjWOlf75bPePtqhUH4CuRa46AyWuu
	 SLVxsdIaIKA/wHupMzpO1ALiDWp7mQvR7PNQqhfsUhWKjloUJQNEx5fdx3/Tp55Vf8ucb
	 1nRt/pXC2+UAQAqcy9NPpCwJ0h2DQi2jrsomtVQYnjTMuXTzH3qFIDp1RPtAy3dAhUmhC
	 9ujEiGdAe5srOS3FRHzUDFi/23hfTxNw072h2C7jbpRwdX6ff33sy1WNw43QqHe/zrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=BWbReMUF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E8606D837
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 16:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 056E8606D837
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=BWbReMUF
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67c0ffaae1dso1657607d50.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 08:56:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793984193; cv=none;
        d=google.com; s=arc-20260327;
        b=PyHRf2ECitzGxiOP+yOjDDP5ffsMWDSIjn7pefVzfdMePKoaGjngcu3c91NJyG28PK
         4rAVuVGBrcZsOV08jro9pneEpsCuu8QA6QXjGlB2PMhWKq4+OHRDdNNv017mmn5Zi6uo
         rJfFN9ivz2ixClLGEoh2DgdS5G1yIwZyBle2rluIzfOINd3Jd6HxRMszfpXB1D6L/2LX
         6hlvj6w53a5vo0WqNaHai+/mjE4Y8PtIWWPpHfPuh7BOQk5CGQv3D9k2kAJHjggiFtWa
         BENAc92o2b7VPnW60km98rajAouUZO6thU+Wlju1dLoGPjkAibC24RWJf4Mrjg/jYQYf
         t1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AvsZipJQd3N+aW9q9yz8PnuJq8twP8IW8udPI5xfiVo=;
        fh=r6qwkCjC8qyj5I48V83rVbZqtjZHuhw1SZHoXSzUzsU=;
        b=CQFj9N6/Kr4tL467jDKBz+Qmey4g9ZWcHpuWn+aLlCbGUwMPy1h5Ozo+9hI02lm66G
         Zqp9KnCmArZTC7Pr3TjA3gNQHHW1qOTi3pEPyx+e0R+N3IanbIlaSq6c2VAHqSYehjQx
         bRz6R+76OKo5I/RDLluTga9cLxrF5oQj3Z7SBzJ4QaJQsm+n8zdl/doS1G9DDJmgP0Kh
         Qdt+xiA1p6z3xtu+FaTHMm/kjoNj4rZRFio4G62cpmr9jZJ7/ECLJWLlBUNqEt+eD4wK
         eWCCEQx3G6Sz5bXyKjCuLI5DS3pR06HRYSJCo+YBsjoIDDU0B+cG5lVuTcw5aizOqy15
         AEdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793984193; x=1794588993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AvsZipJQd3N+aW9q9yz8PnuJq8twP8IW8udPI5xfiVo=;
        b=BWbReMUF0pdYT7pafV78bwosoW5+PIcUalaZCsgSeaMb37wlsAIKvhAksmNnJ62ib5
         ItrGCmCYod3vzgAEvraMKDSLYv3oRsAtKzbNdualGqkb3oG67lZaV7nZlc8/5s+Jhuor
         DTlqJPa1Rp7oi/lde+lW+ErRYP5oZTkF5Wv7SxsN3eLS+ZkrJ5r1tDoolcpkPHc+Fx6I
         XD6DxUylkjf6ZA8frw4FpxTRzChXhpYgHFerlOU5v/wRqrLM4y9fRPaodgf5ymqDJH9w
         +qX2u9fX+7pEPVRIo5GRJMMLYRe+h1nVXkRYpINkmDCC7isFvl3GfpunqFXoK+zP8umV
         f4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793984193; x=1794588993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AvsZipJQd3N+aW9q9yz8PnuJq8twP8IW8udPI5xfiVo=;
        b=YLvGFJhkfCwlUhNTFbylePjWglazTyRqvR+qxzNtJCjMkBDIvCUbmr5QPoQ2RLuDjl
         k+ABERoqg1gwFVjqb0F/ZZJwJifAwahYmgr3+R/fifaJzC+v9o19qlpnh5y9DO2hVqnS
         oKx4PbyUNs8mhIBaJSByhGZVjSHQCOuNaUQp+35YhyS0QA1E9QlRJEjhTDnRefZSDdI9
         f5yCCY+j745UaOrkTCI6zhqxBpHGSS0RBazQq16irsfzfWwVkcuy9SKjQ/zqehQcwxIB
         4ztGqNx2wHHcyVwc1FQMyR0yRtgiRWYJYeZ7wgSAZj6WLV8kTjHPDVTnswVyzvyuzd4+
         JXRw==
X-Gm-Message-State: APuU4Z/BENLuhtXkIW+FeHyMzsZ8PVr279feqOmsd85U+X8ulDiNosa+
	nGWxMaVPWGl7OdfpX1Rrf8Rj8tnbIElQ9KvhbJ/nH5fyCdQ7dKYWWTQwbVdAHWGe4gU6AU8Fo7m
	E+c3lD2VLws+7afFoluSSfDqeqoLJfoXx0rLz2UBGuQ==
X-Gm-Gg: AYBFou0Gxk7zQ7h/kmVZC18xjuMy0HkSaP6ISCFJFYF1fz3JAmKaGEsJlprZ9SydtpF
	1CPpxjrn4a+CM4cQd+YpGSt34ZIUA+NflrROkaeZs/hYIh1coWyJNDL/4uWRl0LlU5VL4EoV4iy
	IM2viLkqF/x9k8dE54qtHs5BltCJGkXb/BWAyOgu8wYrzFYYhTkCK3tKj430X6xtK3icUkfbGUy
	nlv2XXS/RkuyujK89XpzbftRNBjxfVj8+ZAF0Hgg6vqg7sXq7iFHeFxCLGEiLq9ha26HiEUtdOj
	TI8ZW3y5qim1ODjKpqRpYKrn3zJMCcui5Uxn93QkvaMliqpu45x33k5aXx5DWC9puOmBBq9dron
	QKJVFKwJJWhxbb32Chg1FqXJ04WrsbYG51gR16Hs3ufZxk3cJWbo3tsaZ2PwBlkBiAYDLOdjM
X-Received: by 2002:a05:690e:813:20b0:679:b16a:8da9 with SMTP id
 956f58d0204a3-67c1405287cmr1206387d50.3.1793984192700; Fri, 06 Nov 2026
 08:56:32 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105184411.29248-1-emil@etsalapatis.com> <CAEf4BzYYZrKWX=DTUqpwi3yspk=qbtRy1jDersRSsEGMeP6rXg@mail.gmail.com>
In-Reply-To: <CAEf4BzYYZrKWX=DTUqpwi3yspk=qbtRy1jDersRSsEGMeP6rXg@mail.gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Fri, 6 Nov 2026 16:56:20 +0000
X-Gm-Features: AclHuK_tL_eGZzHc3zL42vMQ5hBRmlemkUL-SEKluZa-98SNqrdot6ujZl9pOzQ
Message-ID: <CABFh=a65gpPshf-u1d-0kn8L1CTn4T8yzXvHn611=SZhohrQqQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Use dedicated workqueue for freeing BPF programs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 12:23=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 5, 2026 at 10:44=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
> >
> > BPF program freeing currently runs from the system workqueue. With BPF
> > program pack allocations, freeing the last program in a pack can take
> > pack_mutex and call into execmem/vmalloc code to change page permission=
s.
> > That path may queue a vmalloc purge helper to the same CPU and wait for=
 it
> > to finish.
> >
> > If enough other BPF program free workers are already active on that CPU=
,
> > they can all block on pack_mutex and consume the system workqueue activ=
e
> > slots. The worker holding pack_mutex then waits for the vmalloc purge w=
ork,
> > but that purge work cannot run because the queue is full of pack_mutex
> > waiters:
> >
> > [   24.646667] INFO: task kworker/0:4:1291 blocked for more than 10 sec=
onds.
> > [   24.646669]       Not tainted 7.3.0-00001-gdeaa120a9b25-dirty #11
> > [   24.646670] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
> > [   24.646671] task:kworker/0:4     state:D stack:0     pid:1291  tgid:=
1291  ppid:2      task_flags:0x4208060 flags:0x00080000
> > [   24.646675] Workqueue: events bpf_prog_free_deferred
> > [   24.646678] Call Trace:
> > [   24.646680]  <TASK>
> > [   24.646686]  __schedule+0x5bc/0x1430
> > [   24.646702]  schedule+0x3f/0x100
> > [   24.646706]  schedule_timeout+0x106/0x110
> > [   24.646711]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   24.646713]  ? mark_held_locks+0x49/0x80
> > [   24.646720]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   24.646723]  ? lockdep_hardirqs_on_prepare+0xdc/0x190
> > [   24.646726]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   24.646732]  __wait_for_common+0xc1/0x1d0
> > [   24.646735]  ? __pfx_schedule_timeout+0x10/0x10
> > [   24.646748]  ? __flush_work+0x1f8/0x550
> > [   24.646751]  __flush_work+0x309/0x550
> > [   24.646759]  ? __pfx_wq_barrier_func+0x10/0x10
> > [   24.646783]  __purge_vmap_area_lazy+0x3e4/0x440
> > [   24.646796]  _vm_unmap_aliases+0x2d5/0x330
> > [   24.646810]  change_page_attr_set_clr+0xb9/0x580
> > [   24.646817]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   24.646833]  set_memory_nx+0x3b/0x50
> > [   24.646838]  __execmem_cache_free+0x35/0xb0
> > [   24.646848]  execmem_free+0x98/0x160
> > [   24.646864]  bpf_prog_pack_free+0x152/0x190
> > [   24.646871]  bpf_jit_binary_pack_free+0x17/0x90
> > [   24.646876]  bpf_jit_free+0x5e/0x130
> > [   24.646882]  process_one_work+0x289/0x790
> > [   24.646886]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   24.646888]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   24.646902]  worker_thread+0x1b3/0x370
> > [   24.646908]  ? __pfx_worker_thread+0x10/0x10
> > [   24.646911]  kthread+0xf7/0x130
> > [   24.646914]  ? __pfx_kthread+0x10/0x10
> > [   24.646920]  ret_from_fork+0x293/0x300
> > [   24.646923]  ? __pfx_kthread+0x10/0x10
> > [   24.646927]  ret_from_fork_asm+0x1a/0x30
> > [   24.646947]  </TASK>
> >
> > Move deferred freeing of BPF programs, program images, and trampoline
> > images to a dedicated workqueue to avoid this deadlock.
> >
> > Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> >
> > ---
> > v1 -> v2 (https://lore.kernel.org/bpf/20261102073439.6822-1-emil@etsala=
patis.com/):
> >
> > - Rebase onto the current bpf tree and move RCU-delayed program-image
> >   freeing to the dedicated workqueue after the upstream symbol-lifetime
> >   change. (Alexei, Andrii)
> > - Move deferred trampoline-image freeing to the same workqueue.
> >   (Alexei, Andrii)
> > - Set `max_active` to 1 to limit workers waiting on `pack_mutex`. (Alex=
ei)
> > - Correct the `Fixes:` tag to 72210662c5a2 ("mm: vmalloc: offload
> >   free_vmap_area_lock lock"). (Alexei)
> > - Drop the standalone stress selftest and send a single patch. (Andrii)
> > ---
> >  kernel/bpf/core.c       | 21 +++++++++++++++++++--
> >  kernel/bpf/trampoline.c |  4 +++-
> >  2 files changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 831f73f82599..5c0003fa3e29 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/skbuff.h>
> >  #include <linux/static_call.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/workqueue.h>
> >  #include <linux/prandom.h>
> >  #include <linux/bpf.h>
> >  #include <linux/btf.h>
> > @@ -3143,6 +3144,17 @@ static void bpf_free_used_btfs(struct bpf_prog_a=
ux *aux)
> >         kfree(aux->used_btfs);
> >  }
> >
> > +struct workqueue_struct *bpf_prog_free_wq __ro_after_init;
> > +
> > +static int __init bpf_prog_free_wq_init(void)
> > +{
> > +       bpf_prog_free_wq =3D alloc_workqueue("bpf_prog_free", WQ_UNBOUN=
D, 1);
> > +       if (!bpf_prog_free_wq)
> > +               panic("Failed to allocate BPF program free workqueue\n"=
);
> > +       return 0;
> > +}
> > +early_initcall(bpf_prog_free_wq_init);
> > +
> >  static void bpf_prog_free_images(struct work_struct *work)
> >  {
> >         struct bpf_prog_aux *aux;
> > @@ -3198,7 +3210,7 @@ static void bpf_prog_free_deferred(struct work_st=
ruct *work)
> >         /* The symbols are looked up under rcu_read_lock() */
> >         INIT_RCU_WORK(&aux->rwork, bpf_prog_free_images);
> >         if (ksyms)
> > -               queue_rcu_work(system_percpu_wq, &aux->rwork);
> > +               queue_rcu_work(bpf_prog_free_wq, &aux->rwork);
> >         else
> >                 bpf_prog_free_images(&aux->rwork.work);
> >  }
> > @@ -3211,7 +3223,12 @@ void bpf_prog_free(struct bpf_prog *fp)
> >                 bpf_prog_put(aux->dst_prog);
> >         bpf_token_put(aux->token);
> >         INIT_WORK(&aux->work, bpf_prog_free_deferred);
> > -       schedule_work(&aux->work);
> > +       /*
> > +        * A pack_mutex holder may wait for vmalloc work on system_perc=
pu_wq.
> > +        * Keep program frees off that queue so mutex waiters cannot ex=
haust
> > +        * the active slots needed by the vmalloc work.
> > +        */
>
> very specific pack_mutex reference is more confusing than helpful,
> imo. should we keep it generic and say that bpf_prog freeing goes
> through its own workqueue to not accidentally block or slowdown system
> queue or something along those lines?
>

Fair, I will adjust the wording.

> > +       queue_work(bpf_prog_free_wq, &aux->work);
> >  }
> >
> >  /* RNG for unprivileged user space with separated state from prandom_u=
32(). */
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 21d460866dfe..4eab33d1ad33 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -577,6 +577,8 @@ static void __bpf_tramp_image_put_deferred(struct w=
ork_struct *work)
> >         bpf_trampoline_put(tr);
> >  }
> >
> > +extern struct workqueue_struct *bpf_prog_free_wq __ro_after_init;
>
> this extern should be in include/linux/bpf.h, please move it there
>

Ack.

> pw-bot: cr
>
> > +
> >  /* callback, fexit step 3 or fentry step 2 */
> >  static void __bpf_tramp_image_put_rcu(struct rcu_head *rcu)
> >  {
> > @@ -584,7 +586,7 @@ static void __bpf_tramp_image_put_rcu(struct rcu_he=
ad *rcu)
> >
> >         im =3D container_of(rcu, struct bpf_tramp_image, rcu);
> >         INIT_WORK(&im->work, __bpf_tramp_image_put_deferred);
> > -       schedule_work(&im->work);
> > +       queue_work(bpf_prog_free_wq, &im->work);
> >  }
> >
> >  /* callback, fexit step 2. Called after percpu_ref_kill confirms. */
> > --
> > 2.54.0
> >
