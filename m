Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208178;
	b=5WAEObbiBbN4XRuftKLFimghJdAykuxBKxyQpZW8ZmFwq7DUWELi9r88jlx4/fDhh5HL
	 ZWw+wNMKgW6a7U1e9Swy3j0ki9gfCPK32oysHJRDjCe9qVFVvqmbiQz3Oyffym9WccTog
	 iGCkiDCjHDgrxMsAPP8ShM60Al3gFa2T6DXVhxyc4S/Qb1k4reTOrqelnOlUSYGtx3Q/7
	 KKJlZXfxAy2aVt+JyOK4FiL7zefG6n4msj/nuBq083cZYS/32n2DTR1Y9ze4a/r5/ffoc
	 Nt7iwtOwBs5cSTImdmqLV6tgpiBk9t13iWiMnNKXo3vxvYxmvLBaBIvVto8a43af4XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=lZR40KBgJ/2Psdf8gDUdz7tLnIyTakA+gek7ngS14Kk=;
	b=jJA88Az5Rqfh3JvhUwchQPF01sctfOhohkxCBuBAnGPZ8f2I3fCdD8GE9K59wubvOKvd
	 zaH6cNmn5lg/3/6BghcJ7k7GooZjHZiBlESaBEZ9eQ3xtFGDKVbIErHjS7sy8WFOWMxOP
	 ShaYL8/Jmgi3k2vMWHnIv2l7YIWNXSQp28Mu7UEcwadxy8v20tZk3rUlHh2X7qQkSxKmM
	 l30LUYhL7//witKfCeMc/H2ijsOkl6+/BcqXH3WZvTCWjdXGSDbBKh0Ry4LKxR/XiLJw8
	 Jz18yL4rd+yKb/4fLnnTBYP1ktF/nWZpzSLj6p4+MgHIbrBQxw5moYaiwnCAlBuGJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JGi33GOb;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB589606A31C
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 17:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB589606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JGi33GOb
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso641356a12.3
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793208177; x=1793812977; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lZR40KBgJ/2Psdf8gDUdz7tLnIyTakA+gek7ngS14Kk=;
        b=JGi33GObSCIPOg5GYE3BnSfBBZVmwwsXZw5eBPhKrmHgpciNqlHmJXek03iCaoShb/
         Wj5OBASXa5rgtunJBpYz7PgBNVHa4wxO3kmcmagshjYaKew1uehhKGUOb27CVWlGm88H
         R+IgFuPQe7cRTRJKJGkxDEJN5YOR1VmcahJsqMrmIVOOqyajbYR/YVkTLVq3i3c02P56
         OdVgC0Si4IJDS5HsNRvud8Gy942JJrfW8OGZ7pETOU8WUou8OHUAbs08DHnRZdexiLCh
         /Yx51RttoshtFjqmVanlByJJtaRO3GQvNDepyO+yxrJ7lm8uPcrQxH+IktwfOakVl3ta
         /fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208177; x=1793812977;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZR40KBgJ/2Psdf8gDUdz7tLnIyTakA+gek7ngS14Kk=;
        b=a8pQAn03oE6yBoOnaE75fDAiOupm5bS8/62kYVeTSlIwKRFliHQ3in3uVs1NRGQ+ux
         KfvvwUsf7ci4JTOJafCXIQUQ1rSXbUlbRAUz2fkTCyVSzabQucoxa6bTSUlE3YjfbEfN
         4gDenG3SfUdzLJ+FA0bA140GzEarDW2mLj3EJbFm7Z9pq14o0uQKTVCmAKio+Gn302bz
         lAlwl7QJcn4DV/1+OnOeauKExkbc5IpwlJEQw0UU904pyBRd3V9Gh6GDMr3aISgPTnZz
         S2VCI3JeVHOdw3PjBH7yzxWjvqXhXDluVdebtIaNXywbYzUXkMkcEW2z5LPhFA8Wb6xg
         7V4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzpZpHqS88F6vofJbHVbBlWuGD8TYIWrh82Pez0aj4wKsgfx65KGKrLR0hn0B+uD66b2+Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyOfTuTPCofCNN5mROV7q9m3srCK9yRqlVvusg3rzSmyLEgkGE
	6zuGV8yumiHh7D0N8eL6dU0o5TsQygqY9km4nQxgvxjkB2hx+sWlLSpcaPwrAg==
X-Gm-Gg: AYBFou2bqBfIfs0WtgF2cgUtBmTG4SrxLlXS6rLZyp5SyN+uunjCLS0XyFYkzdmQByZ
	HhvC3qHbTO/ml7i/QqlV7zZ7YRBTSeTvI0AgUnhvw2iEv86fpXGTaHDOXeRzDoRaOJ7IBF7nV/1
	cbiBMJc2s+ihmrUO31Mu84xZT9N3XYvnM9MFzWfp2w9AcnCmmc1Bgq5hAVq6m/suq/w6LBhhgey
	wN+LKDJ2veVmumV+mZgGLE5rMRbmuBx2EqAFUBUxXJkpO3G0HgysusXq/bVIu9/nk6yAgKPRcyu
	2kJHZIjA8Ci6xRqzvUXvyTlSSdWd2B4ExkbQCeO1Mj9gABjgIHyca1YnLtHgSyirVxK4HUzZ1nz
	E95AHAA4oMSpkdlg6yszDb1lbc8a1nb7OvwuamMyeMkSUkqCc2SkkdHWeEMn+WHiNKabWVYN2PS
	XEjmHzhzxt5Kyvgl1d3njYUM+69LhGiCOli96ZKPZ3PmehnYPC14bScFTYBWFzLu6G8T84g2FGn
	l1itWmw7bE6cHIl688IKL9PLoRKETmamqaSBSoZ0xkb4NY777SOAy7+XmCVVMZUYOnNZ70SxSu8
	z8FvVphaRZV4LWgxn1pNn+BwsZOmhG5WQlDMWnyeI4TYjolL3q9DassLzS2Xf9Vp/XkkWFNDEwL
	BoXfQD7ReOQ/ud9a8zc8mzl7VgSGeXq5JMg==
X-Received: by 2002:a17:90b:4b0e:b0:3ac:929e:691 with SMTP id 98e67ed59e1d1-3ae57f9b30cmr2053159a91.17.1793208177177;
        Wed, 28 Oct 2026 10:22:57 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb2c5sm380155a91.3.2026.10.28.10.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:22:56 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 17:22:56 +0000
Message-Id: <DMGN8VM2BAOR.28NRNN51MCI8I@gmail.com>
Cc: "Yun Lu" <luyun@kylinos.cn>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Mykyta Yatsenko" <yatsenko@meta.com>, "Shuah
 Khan" <shuah@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Retire task work before reclaiming
 hash elements
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yun Lu" <luyun_611@163.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261028073525.1035605-2-luyun_611@163.com>
References: <20261028073525.1035605-1-luyun_611@163.com> <20261028073525.1035605-2-luyun_611@163.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 12:35 AM Yun Lu <luyun_611@163.com> wrote:
> Leave ERR_PTR(-ENOENT) in task-work slots before returning non-preallocated
> HASH and RHASH elements to the allocator. The existing fetch/acquire error
> path rejects the retired slot. Reopen it only when the allocator acquires
> the storage again. Also retire a reinitialized RHASH candidate abandoned
> after insertion finds an existing element or fails: a reader of a previous
> incarnation can still hold its value pointer and install a context there.

This is overkill.
It adds a 3rd value of twk->ctx and two new functions that hashtab.c
calls in 6 places.
The kfuncs start to work differently for prealloc and non-prealloc maps.

The map knows whether the element is deleted. Look it up.
In bpf_task_work_acquire_ctx() the prog owns the ctx in PENDING state.
The irq_work is not queued yet.

  prog                                   delete
  cmpxchg(&twk->ctx, NULL, ctx)          unlink the element
  cmpxchg(&ctx->state, .., PENDING)      xchg(&twk->ctx, NULL)
  lookup

Either the lookup doesn't find the element or the xchg() finds the ctx.
It's the same scheme as the usercnt check in __bpf_async_init().

hashtab.c doesn't change. A deleted element gets -ENOENT in all map types.
The cost is one lookup per bpf_task_work_schedule_*().

The diff doesn't have the reorder of FREED and detach in
bpf_task_work_cancel_and_free().
That's a fix for a different race. It doesn't need a new ctx in a deleted
element. Pls send it as a separate patch with its own steps.

Something like this (compile tested only):

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1..acd62ef 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1148,6 +1148,14 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
 	return (void *)value - round_up(map->key_size, 8);
 }

+/* Is the element that holds this value still in the map? */
+static bool bpf_map_value_is_linked(struct bpf_map *map, void *value)
+{
+	u32 idx;
+
+	return map->ops->map_lookup_elem(map, map_key_from_value(map, value, &idx)) == value;
+}
+
 enum bpf_async_type {
 	BPF_ASYNC_TYPE_TIMER = 0,
 	BPF_ASYNC_TYPE_WQ,
@@ -4741,6 +4749,19 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 		return ERR_PTR(-EBUSY);
 	}

+	/*
+	 * The prog can still hold a value of an element that was deleted from the map.
+	 * bpf_task_work_cancel_and_free() is done with it and nothing stops a new callback
+	 * when the element is freed. The ctx is published and PENDING at this point: either
+	 * the lookup doesn't find the element or bpf_task_work_cancel_and_free() finds the ctx.
+	 * An idle ctx stays in the element until the element is reused or freed.
+	 */
+	if (!bpf_map_value_is_linked(map, (void *)tw - map->record->task_work_off)) {
+		(void)cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
+		bpf_task_work_ctx_put(ctx);
+		return ERR_PTR(-ENOENT);
+	}
+
 	/*
 	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
 	 * scheduled. This does not address any race or correctness issue, but rather is a policy

[...]

> +	bpf_task_work_free(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
>  	bpf_obj_cancel_fields(&rhtab->map,
>  			      rhtab_elem_value(elem, rhtab->map.key_size));
>  	bpf_mem_cache_free_rcu(&rhtab->ma, elem);

bpf_wq and bpf_timer have the same problem.
bpf_wq_init() on a deleted element installs a new cb. cb->value points to
the element. htab_mem_dtor() ends in cancel_work(). It doesn't wait for
bpf_wq_work(). The callback still runs when the element is freed.
Pls fix all three.

Also trim the commit log. The 5 steps and the splat are enough.

pw-bot: cr
