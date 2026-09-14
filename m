Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAD34D382
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426959; cv=pass; b=qeqvQDVknkjigsPzgqG5+n4JgsQrOPcdDxGM4mfbWPTtd2Kb32OKK9PQrDNNrM+Eao3dpw/X4+jWSkKzuddlxYS6V7zuhI9JdFBNiM/JurXwme8IcX5vEsFj9b8YSe4MywiwzLn49i+/8thi2jgwUwzrnfbOy9UuF0AqQju396E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426959; c=relaxed/simple;
	bh=HnZj22pjlGHIEfM6bhLJdkIF85ojkiFcxZaEA0PyVZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6EGNR4y1PZEfl347Lva842mrJ0JCBpO/W/8xYJpTh+FCEDHJ9Xls0htlJCy6KEZobUitMFr/n3cA+/crEtGwzSPjmN/IgeIN84pLK1g2RcIsvrD1hcVVMonQ+GoKshsHAOZR0yzda7IVaBXfA2Nq0B1GMMUWUWZQek+0gRVVRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njLUo9f6; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njLUo9f6"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b1334a3b16so2724059eaf.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 16:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789426956; cv=none;
        d=google.com; s=arc-20260327;
        b=jr5bVzoPULsfAMCf9quJCswWyOi3rWQ7LvgwgFeD7IrEjIzC0mGHqyZ/eDSEUuKgSl
         nXcb+SOMFoquobOsumWFzBwVSBC6iabUwFbhJKvhkqLZXJsCAVui1CEuop+Y4/Zg1+/+
         NYxslLn/6W8jkVBPXncDrbL9Ym1Vuzvm+PW1RGM4elEP8pqEECjQVKUB+MCijdIN10Xx
         sB+UzuF3djGJGCyjg0MzEDavUxslHV9q90cpXzXRLKXcvMOdjwUQ896SXCBc2sHJFsWH
         kDW0xw8msssnmyNTTxQW5v4ptfUjM9YmolXbJLdaQmJk6nZTaDOyzzamZSGwPc+XVe+U
         79CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pOUFKWLA82ZDA522DpGzRiQP4xIkyg70D3qyVuxPWKQ=;
        fh=slIclTQ5apa2Oq5/E1qGbL7JWOP1Tq0UMTQVgttIFok=;
        b=nIPFT0XFdYR5xV63R3TADsULeh5cZ+gUwXkXZllyzrq4tGcHalcch1Ya+BcAUQ/IEq
         hNjK3xPOxNJN2phNewcJ5pTv0REvp0nGROSbHMF2mMuKN9XWb4UvsIbbllWp80f20n/M
         e/CLo0OxLa09uXqvLH3UZOdJxhEksd9LlutuqdN7GCSZ62kH0rqpzjq5ta++yWJFw29p
         +9vKHVeOt8MTKfS64UI7W5C3dUu+nrz4MdYukP0FO/GX40tlK/VI+gcmpVkUpFr/A3++
         k4Ju3D7AdHp+cjvtZ9p8PE0SAS7L37gd3XBjO8SwNzzc54yba7PcNOES1oU9QX0Bid3H
         ISOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426956; x=1790031756; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pOUFKWLA82ZDA522DpGzRiQP4xIkyg70D3qyVuxPWKQ=;
        b=njLUo9f613ETcTM0BuZQ/4VcFKGxPrUlgbNcdOnqGn1fpgDzwp1a5Q+vdz6tDUJDrZ
         McuIdpwa0U1GX97oEpWaoSnjchGBZ7wpohw1URwfNZm95eWAWjrRuVaLSWzierLNoTi0
         07PqvdfTBb0sG5IDKXJU5B3jrSJ6LT5fF7Otz6TywYI0cAVi9GHmD5F73G7dSpsA0/UK
         C8Nev/wxrYSqIl1F2SGoL2XAUbw5kndaG/pvZsUAv+fIpulOoU6upAXBL1e4JR1qFzfX
         fdlzqM4JazG9sFpLcubUSpj+hVWNfnpd7fZf5lthjq/189Fw0GAzdh+dQQXrgjGoldfV
         9qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426956; x=1790031756;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pOUFKWLA82ZDA522DpGzRiQP4xIkyg70D3qyVuxPWKQ=;
        b=Xs8o2VKvl+gFGmBwPVh+bbgr5bcyX1gncHAAcX3U93g+kIVPvVuv7e1/Ne86lwlImN
         Sj2MCFNCQCYgDraJ8UFC1+hpgf54JYyy50MVTSNUNzal+flGGnmQAbTasqpSYjmlapZK
         RkJyFDNb5Qx3AzhP8VdpGjvlkUgYZDwkwi0cawSzD514IXD8igG62Es0OVvlBtigGiDb
         3XBR9ShGmjMFowePYRlddiGHeV1ttnVtZCF+N+NFoUOpdkT3FKOn7LzJCKlyUwod2b1r
         l7y2ShmNrws61SptKuWyPUrrKF5m/oCvRj71pIOj82/pxyIZK9MJqKNgljYTPignFmNW
         NASQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMbROZ8yBiYntLQdvJXuJQ4XMtahWgWYvkLVigLJ2eqqB8xsfLrvTTAgex7K7lqWJwyP8=@vger.kernel.org
X-Gm-Message-State: AFuF++mVUeTXp4822/KDIiB2fanMmH61QY6qtRDXVOmV3D7GKqRyGnFY
	eHRUz/ob0VaMXbBzX6MVudsNOE2npyPNPtOtD+QT4rjlwUH9mxo4P00OhBrPqEPxlwyO3SMfcpD
	cxyvq03HQxYz48zAAeIEYbhNLyB/W4Wc=
X-Gm-Gg: AYBFou2Xm7sYnMq1EvwzKLJpWsKqmSJ0QbJSmbMfGY1FOXrjAhPotd41BWlbofs/I4v
	zK6sbdtJO2XmUanRSSteGy3y8vK+dxoSJsBeWrBycGFoZQuMN+ykTVG1NL6ll7GjdZoxsDZnA4C
	rFV+GmHOkoLaQqCq1RtkqzjhJjUGA6GE2oNR3hMZeXH/ea8KhvaRbzOQ60j6g8QPcJilQIKWsIN
	fY6gltpZXutG5nkc23wE9KDgSKx4DBE7105/kd95uv0Ltwtvvs1M2HIPQpZg2DnxlvwsviA6hWP
	56yOX9cqi5DXr9jMUmlWFNed4f3X8kpRz51DmJK/h+UcdOuOMUdJ4mg=
X-Received: by 2002:a05:6820:2226:b0:6ba:1878:2a6c with SMTP id
 006d021491bc7-6c540088554mr2619502eaf.4.1789426956040; Mon, 14 Sep 2026
 16:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914073356.791518-1-cui.tao@linux.dev> <20260914073356.791518-2-cui.tao@linux.dev>
In-Reply-To: <20260914073356.791518-2-cui.tao@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 14 Sep 2026 16:02:24 -0700
X-Gm-Features: AcwNN1VZkBQqQYfMVd7gQUm6WpRn7TeG3A6jO20_KXpKUTM9cv8b_LakI3YB1JE
Message-ID: <CAMB2axNkTS-UuH-KctiY+5qh-JZZkKsiyQr_KOnGJt1bPoL3eA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] blk-iocost: add BPF struct_ops cost model support
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, josef@toxicopanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, linux-kselftest@vger.kernel.org, 
	cuitao@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

I mostly looked from a struct_ops perspective.

> +
> +static const struct bpf_func_proto *
> +bpf_iocost_get_func_proto(enum bpf_func_id func_id,
> +                         const struct bpf_prog *prog)
> +{
> +       switch (func_id) {
> +#ifdef CONFIG_CGROUPS
> +       case BPF_FUNC_cgrp_storage_get:
> +               return &bpf_cgrp_storage_get_proto;

This seems redundant. BPF_FUNC_cgrp_storage_get should already be part
of bpf_base_func_proto.

> +#endif
> +       default:
> +               return bpf_base_func_proto(func_id, prog);
> +       }
> +}
> +
> +static int bpf_iocost_check_member(const struct btf_type *t,
> +                                  const struct btf_member *member,
> +                                  const struct bpf_prog *prog)
> +{
> +       /* calc_cost() is called with RCU read lock held */
> +       if (prog->sleepable)
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +static int bpf_iocost_init_member(const struct btf_type *t,
> +                                 const struct btf_member *member,
> +                                 void *kdata, const void *udata)
> +{
> +       struct iocost_model_ops *ops = kdata;
> +       const struct iocost_model_ops *uops = udata;
> +       u32 moff = __btf_member_bit_offset(t, member) / 8;
> +
> +       switch (moff) {
> +       case offsetof(struct iocost_model_ops, name):
> +               if (bpf_obj_name_cpy(ops->name, uops->name,
> +                                    sizeof(ops->name)) <= 0)
> +                       return -EINVAL;
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static u64 bpf_iocost_calc_cost_stub(u64 opf, u64 nbytes, u64 sector,
> +                                    struct blkcg *blkcg, u64 model_flags);
> +
> +/*
> + * kdata is seeded from the CFI stubs, so calc_cost is never NULL; a
> + * model which did not implement it inherits the stub, which prices
> + * every IO at 0.  Compare against the stub to reject it.
> + */
> +static int bpf_iocost_validate(void *kdata)
> +{
> +       struct iocost_model_ops *ops = kdata;
> +
> +       if (ops->calc_cost == bpf_iocost_calc_cost_stub)
> +               return -EINVAL;

This should check !ops->calc_cost. CFI stubs are used to construct
trampolines; they are not copied into kdata for callbacks omitted by
userspace. Also, should the reserved name "linear" be rejected here?

> +       return 0;
> +}
> +
> +static int bpf_iocost_reg(void *kdata, struct bpf_link *link)
> +{
> +       struct iocost_model_ops *ops = kdata;
> +       struct iocost_bpf_model *m;
> +       int ret = 0;
> +
> +       if (!bpf_struct_ops_get(ops))
> +               return -ENOENT;

struct_ops core should hold a map reference when calling .reg().
Calling bpf_struct_ops_get() in reg() and bpf_struct_ops_put() in
unreg() doesn't seem necessary.

> +
> +       m = kzalloc(sizeof(*m), GFP_KERNEL);
> +       if (!m) {
> +               bpf_struct_ops_put(ops);
> +               return -ENOMEM;
> +       }
> +       refcount_set(&m->refs, 1);
> +
> +       mutex_lock(&iocost_bpf_reg_lock);
> +       {
> +               struct iocost_bpf_model *other;
> +
> +               list_for_each_entry(other, &iocost_bpf_models, list) {
> +                       if (!strcmp(other->ops->name, ops->name)) {
> +                               ret = -EEXIST;
> +                               break;
> +                       }
> +               }
> +       }
> +       if (!ret) {
> +               m->ops = ops;
> +               list_add(&m->list, &iocost_bpf_models);
> +               list_add(&m->lifecycle, &iocost_bpf_lifecycle);

This seems to contradict what the changelog says: "blkcg
online/offline notifications follow the model binding, not the name
registry"

> +       }
> +       mutex_unlock(&iocost_bpf_reg_lock);
> +
> +       if (ret) {
> +               bpf_struct_ops_put(ops);
> +               kfree(m);
> +       }
> +       return ret;
> +}
> +
> +/*
> + * Unregistering drops the registration reference.  When the last
> + * reference is gone (no device bound), the node leaves the lifecycle
> + * list and is freed; otherwise bound devices keep it alive and it
> + * keeps receiving blkcg online/offline notifications.
> + */
> +static void bpf_iocost_unreg(void *kdata, struct bpf_link *link)
> +{
> +       struct iocost_model_ops *ops = kdata;
> +       struct iocost_bpf_model *m;
> +
> +       mutex_lock(&iocost_bpf_reg_lock);
> +       m = iocost_bpf_model_lookup(ops);
> +       if (m) {
> +               list_del(&m->list);
> +               if (refcount_dec_and_test(&m->refs)) {
> +                       list_del(&m->lifecycle);
> +                       kfree(m);
> +               }
> +       }
> +       mutex_unlock(&iocost_bpf_reg_lock);
> +
> +       bpf_struct_ops_put(ops);

Mentioned above. Doesn't seem to be necessary.

[...]

> +static const struct iocost_model_ops *
> +ioc_bpf_model_prepare(const char *name)
> +{
> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
> +       const struct iocost_model_ops *new = NULL;
> +       int ret;
> +
> +       if (!name[0])
> +               return NULL;
> +       ret = iocost_bpf_model_get(name, &new);

It looks more straightforward if iocost_bpf_model_get() just return
the ops ptr and ERR_PTR on error.

> +       return ret ? ERR_PTR(ret) : new;
> +#else
> +       return name[0] ? ERR_PTR(-ENOENT) : NULL;
> +#endif
> +}
