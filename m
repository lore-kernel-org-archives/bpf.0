Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793903251;
	b=yal9NcnEpqjiZ3EyNPmaKEPheldaNH08o6tjxLOc51sETh4Wj3ANGqBKkYXGWvdU0ZXi
	 QxTR0qqJsEgOGgBL6PAgDOW+H7i77LiA91Y8bV1H6rJxwRHuCEEzTWwokb9sHOjlIJT7g
	 ihHFqJeoVoc6NT2LSp1Nse7lAIm7u1Q3jVK4hc0kEcR4M2m355B1UVjZJT4QyNbNBL2N0
	 zuZzKdMchHgEy+wMg6RJDE4lOsxNfGMkeav0yMWurg9YG7a/0Sra3B+IkoF3y84Rid55v
	 Rtk8sHjB2qmmwMJ4IOMy93a0DrIh7rV0ZsqKoh7Oc4Bl0GHKzGxah2i+66KunbGpKpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0BMuIBUqqMoGoHtQTcExAD0lbpUUw9vqFr5Un6zywog=;
	b=yWurGgpCrxJvSOZKqOrB+BKGPApA96hM5b8zeis72Z9vvu9CPNOkL1Mg5bYBxmF6FY+O
	 mxzk/nqdG9ei8X4UqiQMFtueRAaQJZvkMAJdjJClNj+BpBmsyMz/W38cuP+r1GTPK/C2M
	 oXgkd9ddUXVNPWPhHi5WfSANsgnU8+YWunP+j6ImY5YNrj3iA9+wKRxgr2NGvgYKGmnpp
	 AfepnE/SUqujiFV4v3JI6MAJCxpJ6PgAdVxP3hft/j6EB6KrKYUdQWG+R67SsG3zFn9Pt
	 dY4AX0fMm0QzF9wydwQoVDA2bTAkSxpR4NiF+Co5EAdHjZKKimS+BmVW5osv/BamyHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=dVBE0tJk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4215606A32D
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4215606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=dVBE0tJk
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67c11318ad1so340547d50.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 10:27:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793903249; cv=none;
        d=google.com; s=arc-20260327;
        b=oppgzTCkDi4BSKQtppYwuTV0Q8s2bOrhiG4/U1LoWCflGg0PHj5X6gPxhZmaykuhKk
         1BLxybm/F7+5lIHV3UIkag30aaGU114OtzPJymF7QY2eU+uxSc2MP5waqr5tIyG0rDuN
         gGtAYIeyuTgZgk5qVtMr8niiGasbjurjkMJTE1h/t6ejQbpZONDC8U7rQbh+IacvVKxz
         SUqTGoe3ip/rhu/DxZ3AHIDkSSGZyvK6eZmNr8f7Hpoeki5WiV9A923FtfyYYxuGgDpk
         0qH65EwazC0Wqt2rsEG0CZ67hZHsNRJOWbhMpUOJ0u10hxD1dIBDDx9LC+20nEVtP/Nt
         ENNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0BMuIBUqqMoGoHtQTcExAD0lbpUUw9vqFr5Un6zywog=;
        fh=k6Kzd5i0JYNWKm8Fie2SXzY/dA5t7mn6Hk1cPNNnvdo=;
        b=JEy0rAON84Rsa2H1I/DiB1z0TFnVJhgQLiqNUxSy5RqNC4WS9V96hkYdleg0sZ7IS+
         BOjvywVS0914YYmhSQAMbjdE7Pd59TGGBUIYW3cIVbE2/hX5hB6R/KIc2+8i2tCjiI2Q
         zGKtMag4DcsPWD59ZXwEVJPD+b0EfZuNhg3yqM0sO6Cny3f+IF7jvvRVQrZ8yAYa5B5g
         w5ebXcjdtNeTB+m3nakaS7/aRZjiUqdZYF2Osxx7Dmi4fI1MkMLA+Q171KVCHSJnR9eT
         DFMmXEhQuupR/YyEVJIfPkffTXTta8AQ/e1HbCJ0GYQN+raQ8qdrDU/UMaWMX0XaklwL
         TVqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793903249; x=1794508049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0BMuIBUqqMoGoHtQTcExAD0lbpUUw9vqFr5Un6zywog=;
        b=dVBE0tJk6lgpZoqwCLiiPz4FN9seVa0LxQ+sr++kKds68pnRi8kMlgV3zrYemwXUvV
         92S98PWdZ6OfIBQzgIharWHpAK11prxZCWoK356fM1ZXo8DlLA/Da4+3YPtqKzXRyHnW
         vSoa4k3WwD9gi6bO1boBBXgHh0UoT3uWEb3fLfxRGd+lalpoYtxSbAorp1CRcnvZzTFL
         LZF5boM7CGglVV3smJkQ5qBHByvdKYHeWH5Uxn0616l3aLdPNGUPhigF1pc5tcCPJfF/
         yE4eIq4WQC26kAcoUp4IYrmgXYrCrOHaVXKJjukFnEDWSBx6/odxpq1oCUoUMXseLiRL
         pQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793903249; x=1794508049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0BMuIBUqqMoGoHtQTcExAD0lbpUUw9vqFr5Un6zywog=;
        b=apbPcvBNqm4XpyZe8WJD9byjelFg/ZdZzGG1mmddMk3o/fzwH37czAIocQFRN/OJkm
         x3kE+J9EL5TVnK3/FwHKU1awQx8dyhQHylPVIzOiPVyx5oIGLDVvFHIaBz6Lk9zKCXHj
         p+XPQAqIzuyxh4U72B0R2ns81eJNmXlGInEBTYH6zzdOkTMEsl8z73319rYa98PfFxoN
         +ormCZ8sBODw84t7AoSVGNihV2TI2SpjjGuc7O3DZW3G8C0E7h3Rnu8hyrEegxj4mnTo
         Bm2oQfuG3eA1H06UeMFCjuKHY8St6AtUCdoa1t6CkWmuwxYiCCyIj0mgM2Ai2FQX5yR1
         m9Mw==
X-Forwarded-Encrypted: i=1; AL+hErENUI+DB7xix7dbbUzPoTriTDUJ9DhYIV2eS0oNwZpjulSPuIQSNdrKbd+K4/WRHCUE1qY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nTqFvncc465LqZprur3d/0MocbtOpDufKpZVlFo6/C59KeKKH
	dStUa/PbI/kXRvHFGIWL4X7H3hAmL+Ptg/GhHCoSuKuLYqOwYEEsiCb2Ee9I+CdZa0lSWkRRQNA
	FOLeoE0KttLdHYfGbATXazd0MRPWeQb86nYb6f9WrHA==
X-Gm-Gg: AYBFou0faWsppt1lNYFpXYRzViH26kIeKwnKHFUHRaB2n0mHfbpci/52QGAqyD5Ov1z
	Vj52ngpNQ9fFPrqFlrwyL8NZuAJdjF00qv8j11bVg5G82U++8Hjb3hrC5c9jKzEI+s4rD/sAH6Y
	Vth3O07tVhLEz9ZPeTVYKCY1/OXvBAm3cgJhN4qXCsORKohGbhXyetjIokTG8uJhaP1KIQMWZ2H
	YiWUg0AyatrrfsPbkOhrwwiKSVe+q33q8gH9F1PcOUmmlGTfNZs+J1fAK44YWOnZC8bTSbCFuI7
	lMbi2gEgdrZvBmervKgNUb1S0ASHH8OlPXDtNyAdD9BqofFpxzUq0dJoUAxeIZ6kZUejU8tRRXA
	HhmnkBYkBLDnsNNBaR6tqw1l95rjk98S8YUOG
X-Received: by 2002:a05:690e:4809:b0:67c:eb7:5906 with SMTP id
 956f58d0204a3-67c143e9cfcmr31637d50.74.1793903248511; Thu, 05 Nov 2026
 10:27:28 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103142856.463063-1-puranjay@kernel.org> <20261103142856.463063-2-puranjay@kernel.org>
 <DMLQ9E8WRFZC.20C48J5Q1TMSL@gmail.com>
In-Reply-To: <DMLQ9E8WRFZC.20C48J5Q1TMSL@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Thu, 5 Nov 2026 18:27:15 +0000
X-Gm-Features: AclHuK-Syidh7sRC-IoR48gzeYAap6YCDnUGaPzB6rdROfg9PzCjuafjKc2oIGE
Message-ID: <CABFh=a6RsKiKFrZ0exGu5+5ve3Ax-u2oVOSXPMiSv=-uWR5NXg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Don't allocate and free prog pack memory
 with pack_mutex held
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 4:54=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 03, 2026 at 06:28 AM Puranjay Mohan <puranjay@kernel.org> wro=
te:
> > Progs are freed from system_percpu_wq too, and bpf_prog_free_deferred()
> > sleeps on pack_mutex. When enough progs are freed at once, these work
> > items take all active slots of the pool that purge_work was queued to.
> > purge_work never runs and everything waits for pack_mutex:
>
> Thanks for taking over.
>
> Turned out Emil is fixing the same issue I was seeing:
> https://lore.kernel.org/bpf/20261102073439.6822-1-emil@etsalapatis.com/
>
> Thousands of work items that sleep don't belong in system_percpu_wq.
> commit 117932eea99b fixed it for cgroup/bpf.
>

Sorry for the delay, I had v2 ready and hadn't sent it. I chatted with Pura=
njay
and am sending it now. If we prefer the approach below he can take over
instead.

> On Emil's patch I proposed to move frees into their own wq
> with max_active =3D 1.
>
>                                          this patch    own wq
>   -------------------------------------  ------------  ----------
>   work items per cpu that sleep on       up to 1024    1
>   pack_mutex
>   same deadlock on vmap_purge_lock       still there   gone
>   N tasks find no room in the packs      N new packs   1 new pack
>   pack_mutex held over execmem calls     no            yes
>
> Row 1 also bounds the time that a prog load waits for pack_mutex.
>
> Row 2: the s390 JIT and the interpreter call vfree() of
> a VM_FLUSH_RESET_PERMS area for every prog.
> vm_reset_perms() calls _vm_unmap_aliases(), so these work items sleep
> on vmap_purge_lock. Its owner waits for purge_work in the same wq.
>
> Row 3: see below.
>
> Row 4 is fine. purge_work gets its slot, so the owner of pack_mutex
> makes progress.
>
> Then no need for the retry in bpf_prog_pack_alloc().
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index fdbf638..6ce2e31 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -70,6 +70,7 @@ extern spinlock_t btf_idr_lock;
>  extern struct kobject *btf_kobj;
>  extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
>  extern bool bpf_global_ma_set;
> +extern struct workqueue_struct *bpf_free_wq;
>
>  typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
>  typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 831f73f..e83edea 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3198,7 +3198,7 @@ static void bpf_prog_free_deferred(struct work_stru=
ct *work)
>         /* The symbols are looked up under rcu_read_lock() */
>         INIT_RCU_WORK(&aux->rwork, bpf_prog_free_images);
>         if (ksyms)
> -               queue_rcu_work(system_percpu_wq, &aux->rwork);
> +               queue_rcu_work(bpf_free_wq, &aux->rwork);
>         else
>                 bpf_prog_free_images(&aux->rwork.work);
>  }
> @@ -3211,9 +3211,26 @@ void bpf_prog_free(struct bpf_prog *fp)
>                 bpf_prog_put(aux->dst_prog);
>         bpf_token_put(aux->token);
>         INIT_WORK(&aux->work, bpf_prog_free_deferred);
> -       schedule_work(&aux->work);
> +       queue_work(bpf_free_wq, &aux->work);
>  }
>
> +/*
> + * Many progs and trampolines can be freed at once and their work items =
sleep
> + * on pack_mutex. Its owner can wait for a work item of system_percpu_wq=
.
> + * Use a separate workqueue, so that they don't fill up max_active of
> + * system_percpu_wq.
> + */
> +struct workqueue_struct *bpf_free_wq;
> +
> +static int __init bpf_free_wq_init(void)
> +{
> +       bpf_free_wq =3D alloc_workqueue("bpf_free", WQ_PERCPU, 1);
> +       if (!bpf_free_wq)
> +               panic("Failed to alloc workqueue for bpf free.\n");
> +       return 0;
> +}
> +pure_initcall(bpf_free_wq_init);
> +
>  /* RNG for unprivileged user space with separated state from prandom_u32=
(). */
>  static DEFINE_PER_CPU(struct rnd_state, bpf_user_rnd_state);
>
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 21d4608..a34e8a2 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -584,7 +584,7 @@ static void __bpf_tramp_image_put_rcu(struct rcu_head=
 *rcu)
>
>         im =3D container_of(rcu, struct bpf_tramp_image, rcu);
>         INIT_WORK(&im->work, __bpf_tramp_image_put_deferred);
> -       schedule_work(&im->work);
> +       queue_work(bpf_free_wq, &im->work);
>  }
>
>  /* callback, fexit step 2. Called after percpu_ref_kill confirms. */
>
> > +     mutex_unlock(&pack_mutex);
> > +     new_pack =3D alloc_new_pack(bpf_fill_ill_insns);
> > +     if (!new_pack)
> > +             return NULL;
> > +
> > +     mutex_lock(&pack_mutex);
> > +     goto again;
>
> Every task that finds no room before task 1 adds its pack allocates
> one more:
>
>   task 1                     task 2 ... task N
>   no room, unlock
>   alloc_new_pack()           no room, unlock
>                              alloc_new_pack()
>   lock, list_add_tail()
>                              lock, room in the pack of task 1
>                              unlock, free the new pack
>
> A pack is 2 Mbytes * num_possible_nodes(). Nobody is charged for it.
> N is the number of tasks, not cpus, since alloc_new_pack() sleeps.
> If we go with your approach the memory needs to be bound somehow.
>
> pw-bot: cr
>
