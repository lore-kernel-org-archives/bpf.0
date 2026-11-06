Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793924607;
	b=yLRn4LYNMYSghhQO2nqXQSxzwoQtc8MGNNMn2+RHJNDkIdc8DmnVSLGYfF7/+MEJt3GS
	 VwOXnHZScPLW4Vqnfes9yO0LefnTq9jyp913kSIUf4XeRLFLzqjv8hSdoexyuMqW5Fxak
	 ZgIkBkuSKMceeb0yuwLDCkb9H3iUshP4P3jm4OurHy7EFZsCNt7A0htFquAItjNwVfW80
	 uIE5/o6gvA0RtddqJU1nmRD1TKeIaY6o+YOCqLZciJMyYjGPf/zoMdriOqJf2GT0lnV0R
	 hlBRnlcbKo+rZf+2WRXj+2DAKoMXpN0iTbkEEpbFdfmANbiSwsBreZprPN+7kQM5OeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=JHRpu+PB3THsZKhkiB7IUd/2SGSUnjqGUqd0oRnVnNA=;
	b=LNYw5KDzCDBzlSWJf85630dQgy8P/eGPZhjjcy27x4mYYIryFMAtT7wwh8QxegmMNAMR
	 fZQ7OcNM2qgpdT8lEkmgqFJd5MS3efpLMMPesRewPHHtkErsviwk+/QFc2+J1JxzXchVK
	 /rg467UL9/tdIlOX32wep5V3ofFBxRZd5jupOxsmvdxoKg+emEqYn2kYG40nEPK/gYcta
	 fNK+++gVKdIAEhGZKANcQFBYIdxwxMB5QbfOTlB2g2UPqnoXyVY5ipaWuSdU+ppTPMxeV
	 2j/AglwHyULpyiSxUQN40OSDW9Rvc49HkFU6/bXKBCol0rOsZZUPq1e7Vjp+dB5Ypaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nSJ+qY4G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA0606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 00:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86CA0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nSJ+qY4G
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed1414df17so248645ad.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 16:23:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793924606; cv=none;
        d=google.com; s=arc-20260327;
        b=a7Hb8/Ir9vtlRZ5C65Qjf8agpNALK+JqYOPSM3H+nvAbBCfgGCbQ2J6L8bkjnziXcT
         jNoeP3L6o0YdjkuZjhcsIBOFxfqKXtjnXO+UEPLiZiKgeYqJHC8QP99pIvNKNAzBura0
         ZMhI7axMzRtHA2eoOE5Nmwc8VDcC6PTpQCcahasF8mMFOppmTdq489poKJUXi9XFkqR/
         UF3CVbfmFHbswcpTOebPm1xS9TabiJvojg1rXWIx+9f2H3Od1QN0pXhPpG5oZJdV+Rz3
         z9MQv4unGnpf3jfW1OafeVhddRaQkuCWnkZn6QIMZo/Q82fM2cApldntEcoSQ+Fwoe27
         1eQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JHRpu+PB3THsZKhkiB7IUd/2SGSUnjqGUqd0oRnVnNA=;
        fh=E87m5ns1yCPTtF4jxCBSs9j9lcynHQ7PIV9fk/VOlJA=;
        b=LKVGfVv13+EhtX75q2euvNVkJsX0elUS9wrYF/vporMyBDNNoHh9Cb20uwWZtk2JGm
         +taphzdX4WxgwoyK00slNJyO7oD11zSR8xjnaHWxLKEklUsnAQcfU0OP6zv/qg7oM9KV
         K82NA8RcVE/VhWGIhe+dvW1uv28t4dyf+iHk3ORWFImmKDH2SAPegdeLyD0hFSmgltsw
         AVpuYRdk4t70OERBZJ1jmf6nqrYn211mgJ551aXKmxEeQA3HAoDwFtcw42DW0ehOsX6b
         67YBCLmVRFDWPUajX2HZchD1wkDngyRL1gFK5lX4ksMFQp7t7V+5KYadBzdkQBqa2pM3
         7+Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793924606; x=1794529406; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JHRpu+PB3THsZKhkiB7IUd/2SGSUnjqGUqd0oRnVnNA=;
        b=nSJ+qY4GeZk5LU62dzMUsrxiV+767EG3KCcVamMg0m34Z7lD0eXgps0UjdY23ul7i9
         JBOz2RDzO2vHMr7lTbDBO8sC/dxHyg8HAde5MGBHQFizzy50x8AVKuZp0LwiQAslI96d
         Rx3GuQHTDr4FoYCZVnnPWkzQJ6C+TqM3RRTGwhF2v+R7M1lDI85BH+jWVwc/8CMDAMpd
         P2RsFeakIWb+Ms8jsl+lk0EPDQ8h0+1x5nDMfz6ZRJnxwOdbCdgWPsNEg3up9XWH8TTX
         mbSfTbi1rQMQgkVeHB00yqjSSam7RFs6Zmfj+WsqAcx7AcVc6SqPtG8n++LwZ5mRIEAl
         llOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924606; x=1794529406;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHRpu+PB3THsZKhkiB7IUd/2SGSUnjqGUqd0oRnVnNA=;
        b=wsHWpGVfgl4n+AEI+3Ncp/k55wJ+FatGHF6NUSlGepGsB7qPY+552Eh01hf80DiqB1
         ZVXUJB5/ScUNy3iARG2HduvU+dm8p9PkPMlQNB3WxC1umVwIFQ4KE1tf1w80LD3E45AQ
         a39D2fnlE29nzp81ScaNFErVfwKiJZNHnyOk0LxfIvD5lrPvgUQflH5CkKFvJxoftZl5
         Ugy5udsLdjzQjVk3CptQv6XNvivMRjz9hN7QwpBrXJXkOxl6/xdxIkof5aqLhIwBVKAB
         f/jljWzOIR0PLP4Ghd5vvfU9LBSvf3jWA/CqLqFOhl/0EzlKgBD1WOzLpIipgn+OpHdE
         ayEg==
X-Gm-Message-State: APuU4Z+L5pVOT3C6HO3bxNdGms5ZnA5tDB8U+6GQEzG5qhuFFUhSUV1h
	QBBO3P5s3Xs2WwG2pafxI7FWLF9cA/SwV+TfgdfsBJhXTqrDrbVxWBwTboitabzZ8kuX73mDN5S
	SYaN7ntbIDtPN0phceEmFf5fclDG/DNU=
X-Gm-Gg: AYBFou2CqAXQd7nvlzwp/0Vl4mkXCbHTzhFZIrudIunaH2QKDuE7DWEnPosjxxyAMW1
	v5gu6GzVJQnI4c1hqXhRmoLbszp+FauGLRU+LSIZ5U40+ciTN1HpK0UTfUeNGox7aR42QNvE4pP
	rK0fK27fJYh6yVi/SA1dYYZeOAAnWzZsPt+xRYc2AmvlquBfuYExSR6kGmoNpjWpRb6lurkg0TV
	IDDjxvOCH+uj+0H7NColpp63cuONHJdEjy8E3gX/lTge4STRdJjuEqIwDriajZpJV6qCxIVyp72
	U1oPIU2i9YIAhUxra9PgmCG4obJNBZFuxLh5LpJ1o2/yt0dFHgF4NaiZgKWXPDj/fqGrf2I1vK4
	vv3CHtkHM4lSoeFoHKST59jNXtdGwQuLVjHg+4xGNFwm7mCSeI4asrZS5IusK1y4aHSKyGPoVr3
	643nuqiMgO5UURCIj7YBDDKPR7KSckv079SQ==
X-Received: by 2002:a17:903:1cc:b0:2e4:a360:fcc6 with SMTP id
 d9443c01a7336-2ed40c96719mr15218485ad.35.1793924605719; Thu, 05 Nov 2026
 16:23:25 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105184411.29248-1-emil@etsalapatis.com>
In-Reply-To: <20261105184411.29248-1-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 16:23:13 -0800
X-Gm-Features: AclHuK_g2QnZWoPFZnnlANQqM2vPzh2niBrLJyqHT-kBw5sDTt5tnz6_iWFpN-0
Message-ID: <CAEf4BzYYZrKWX=DTUqpwi3yspk=qbtRy1jDersRSsEGMeP6rXg@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Use dedicated workqueue for freeing BPF programs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 10:44=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> BPF program freeing currently runs from the system workqueue. With BPF
> program pack allocations, freeing the last program in a pack can take
> pack_mutex and call into execmem/vmalloc code to change page permissions.
> That path may queue a vmalloc purge helper to the same CPU and wait for i=
t
> to finish.
>
> If enough other BPF program free workers are already active on that CPU,
> they can all block on pack_mutex and consume the system workqueue active
> slots. The worker holding pack_mutex then waits for the vmalloc purge wor=
k,
> but that purge work cannot run because the queue is full of pack_mutex
> waiters:
>
> [   24.646667] INFO: task kworker/0:4:1291 blocked for more than 10 secon=
ds.
> [   24.646669]       Not tainted 7.3.0-00001-gdeaa120a9b25-dirty #11
> [   24.646670] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [   24.646671] task:kworker/0:4     state:D stack:0     pid:1291  tgid:12=
91  ppid:2      task_flags:0x4208060 flags:0x00080000
> [   24.646675] Workqueue: events bpf_prog_free_deferred
> [   24.646678] Call Trace:
> [   24.646680]  <TASK>
> [   24.646686]  __schedule+0x5bc/0x1430
> [   24.646702]  schedule+0x3f/0x100
> [   24.646706]  schedule_timeout+0x106/0x110
> [   24.646711]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   24.646713]  ? mark_held_locks+0x49/0x80
> [   24.646720]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   24.646723]  ? lockdep_hardirqs_on_prepare+0xdc/0x190
> [   24.646726]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   24.646732]  __wait_for_common+0xc1/0x1d0
> [   24.646735]  ? __pfx_schedule_timeout+0x10/0x10
> [   24.646748]  ? __flush_work+0x1f8/0x550
> [   24.646751]  __flush_work+0x309/0x550
> [   24.646759]  ? __pfx_wq_barrier_func+0x10/0x10
> [   24.646783]  __purge_vmap_area_lazy+0x3e4/0x440
> [   24.646796]  _vm_unmap_aliases+0x2d5/0x330
> [   24.646810]  change_page_attr_set_clr+0xb9/0x580
> [   24.646817]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   24.646833]  set_memory_nx+0x3b/0x50
> [   24.646838]  __execmem_cache_free+0x35/0xb0
> [   24.646848]  execmem_free+0x98/0x160
> [   24.646864]  bpf_prog_pack_free+0x152/0x190
> [   24.646871]  bpf_jit_binary_pack_free+0x17/0x90
> [   24.646876]  bpf_jit_free+0x5e/0x130
> [   24.646882]  process_one_work+0x289/0x790
> [   24.646886]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   24.646888]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   24.646902]  worker_thread+0x1b3/0x370
> [   24.646908]  ? __pfx_worker_thread+0x10/0x10
> [   24.646911]  kthread+0xf7/0x130
> [   24.646914]  ? __pfx_kthread+0x10/0x10
> [   24.646920]  ret_from_fork+0x293/0x300
> [   24.646923]  ? __pfx_kthread+0x10/0x10
> [   24.646927]  ret_from_fork_asm+0x1a/0x30
> [   24.646947]  </TASK>
>
> Move deferred freeing of BPF programs, program images, and trampoline
> images to a dedicated workqueue to avoid this deadlock.
>
> Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> ---
> v1 -> v2 (https://lore.kernel.org/bpf/20261102073439.6822-1-emil@etsalapa=
tis.com/):
>
> - Rebase onto the current bpf tree and move RCU-delayed program-image
>   freeing to the dedicated workqueue after the upstream symbol-lifetime
>   change. (Alexei, Andrii)
> - Move deferred trampoline-image freeing to the same workqueue.
>   (Alexei, Andrii)
> - Set `max_active` to 1 to limit workers waiting on `pack_mutex`. (Alexei=
)
> - Correct the `Fixes:` tag to 72210662c5a2 ("mm: vmalloc: offload
>   free_vmap_area_lock lock"). (Alexei)
> - Drop the standalone stress selftest and send a single patch. (Andrii)
> ---
>  kernel/bpf/core.c       | 21 +++++++++++++++++++--
>  kernel/bpf/trampoline.c |  4 +++-
>  2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 831f73f82599..5c0003fa3e29 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -24,6 +24,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/static_call.h>
>  #include <linux/vmalloc.h>
> +#include <linux/workqueue.h>
>  #include <linux/prandom.h>
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> @@ -3143,6 +3144,17 @@ static void bpf_free_used_btfs(struct bpf_prog_aux=
 *aux)
>         kfree(aux->used_btfs);
>  }
>
> +struct workqueue_struct *bpf_prog_free_wq __ro_after_init;
> +
> +static int __init bpf_prog_free_wq_init(void)
> +{
> +       bpf_prog_free_wq =3D alloc_workqueue("bpf_prog_free", WQ_UNBOUND,=
 1);
> +       if (!bpf_prog_free_wq)
> +               panic("Failed to allocate BPF program free workqueue\n");
> +       return 0;
> +}
> +early_initcall(bpf_prog_free_wq_init);
> +
>  static void bpf_prog_free_images(struct work_struct *work)
>  {
>         struct bpf_prog_aux *aux;
> @@ -3198,7 +3210,7 @@ static void bpf_prog_free_deferred(struct work_stru=
ct *work)
>         /* The symbols are looked up under rcu_read_lock() */
>         INIT_RCU_WORK(&aux->rwork, bpf_prog_free_images);
>         if (ksyms)
> -               queue_rcu_work(system_percpu_wq, &aux->rwork);
> +               queue_rcu_work(bpf_prog_free_wq, &aux->rwork);
>         else
>                 bpf_prog_free_images(&aux->rwork.work);
>  }
> @@ -3211,7 +3223,12 @@ void bpf_prog_free(struct bpf_prog *fp)
>                 bpf_prog_put(aux->dst_prog);
>         bpf_token_put(aux->token);
>         INIT_WORK(&aux->work, bpf_prog_free_deferred);
> -       schedule_work(&aux->work);
> +       /*
> +        * A pack_mutex holder may wait for vmalloc work on system_percpu=
_wq.
> +        * Keep program frees off that queue so mutex waiters cannot exha=
ust
> +        * the active slots needed by the vmalloc work.
> +        */

very specific pack_mutex reference is more confusing than helpful,
imo. should we keep it generic and say that bpf_prog freeing goes
through its own workqueue to not accidentally block or slowdown system
queue or something along those lines?

> +       queue_work(bpf_prog_free_wq, &aux->work);
>  }
>
>  /* RNG for unprivileged user space with separated state from prandom_u32=
(). */
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 21d460866dfe..4eab33d1ad33 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -577,6 +577,8 @@ static void __bpf_tramp_image_put_deferred(struct wor=
k_struct *work)
>         bpf_trampoline_put(tr);
>  }
>
> +extern struct workqueue_struct *bpf_prog_free_wq __ro_after_init;

this extern should be in include/linux/bpf.h, please move it there

pw-bot: cr

> +
>  /* callback, fexit step 3 or fentry step 2 */
>  static void __bpf_tramp_image_put_rcu(struct rcu_head *rcu)
>  {
> @@ -584,7 +586,7 @@ static void __bpf_tramp_image_put_rcu(struct rcu_head=
 *rcu)
>
>         im =3D container_of(rcu, struct bpf_tramp_image, rcu);
>         INIT_WORK(&im->work, __bpf_tramp_image_put_deferred);
> -       schedule_work(&im->work);
> +       queue_work(bpf_prog_free_wq, &im->work);
>  }
>
>  /* callback, fexit step 2. Called after percpu_ref_kill confirms. */
> --
> 2.54.0
>
