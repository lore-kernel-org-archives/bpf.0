Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A921CC4F
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567268; cv=pass; b=l66d4pNKPnkvkNYlJphPJ21+ci5wg5dmYSzdC5GLcVj7shhQbdUT+P1TxtQigzYpLJ/so5I3Zw8xeU0lS/6PqhSozumnyy7coWagdb/cBAGHbZr9HhctMeSFykAMp28A7j8YV+utw87TXRwB+WDzPc/+kSGnsDYJiWVBDZNpJmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567268; c=relaxed/simple;
	bh=kQKMO3NnDjf/7HVMh5zxEE6uTYJTGgTPj+DSv/vkZ70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJZI1fTx0RghjW+IJYRhAOCZimp4u139iqrL5zqf4bhh0Q1JUIer40BJXb6HrpWignWsWFDU5XiNoqCEmNQlfwfrpI7aCW4b5wM9uyZGJ2MeCAnaXIpRz5PqKQHXVQlvvNO8J5Lmz2Dgw6I47DvBbkzILw1ARgG/8Sw9fea+9HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iqf6N3zp; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqf6N3zp"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so4320607f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:27:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769567265; cv=none;
        d=google.com; s=arc-20240605;
        b=g6C9YVBQcJ7JEiU22K8uvIoIZPrpDTRohDDNdXTv57gSCs6eH+KNlt1zsvigbRgIwO
         AFSk0wjFY/rE6QZsrhEI8U0X44rbaSGHMKlxPzHY3Yw6oZutP8sPz4B0wajU2dPNzFiN
         udO4OzjOHhOdwF2CG3bCqIBLPoGrfUqw6SPG8+QwGhzOjlI+RAFVBTW0gbT/nFU1HpAo
         O9KHsVOv4tW+stWglW104zJGhuoOINILRVZVSPRe8g/1GqqyDigGyFx5AAehk3uSXjPj
         erBWTtYeOusFHRBH6LPyTHk+EoWi+PtEcHxj0JdctdOVC9gfy4L9VCBuKgGn+W/3NtEt
         ZKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gao4ipUlmOIwcq99MQVTnaBelmvpZVAv6HM5nyo0jY8=;
        fh=U1Wixv5PsyoYb3MXvvGNfuTmdBvwNZFRfduxqfUTSpA=;
        b=SstLK8fZiJkaLu/6541EcuP3rf5iE9vMvzr9C20J+pU700g2wE8Q5rshaqyKwR1o+x
         WoN9y1pWFJg2yBB14JTdxv9gDhjmTw0wt2zF9VtqM0Y354f8cgDB5FHfAfVYNJwNAaO2
         ea0Uo0jmmUc7aKvxjo60jN0NuZ4CYNAkuD5X+2sIqEssFk8nHuJ+kt9BGNDQRkjcHxBO
         neczVX1h/Hf5N6XkQkVPqQ84qiVxL6YJzjVMoh9wb9d365YkPQ96L5nykwY1kn/WAT4h
         LixnJcQmt37mG0jn6xLtciOAuTNOxPJI/X8BXXyTZZsNQuneh26ZZhuUFx+gTmJ60pXD
         STyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769567265; x=1770172065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gao4ipUlmOIwcq99MQVTnaBelmvpZVAv6HM5nyo0jY8=;
        b=Iqf6N3zp8/WrKFCZScK0KvtjfzSmRpGAjSf+Pb7QzFaaGFyG+5WjHXunDygawvTqor
         oTd0RKmGYDaQPyQJbWPNegxVI95QmtnBCA7j5aABA7OcCthsdS4QfSZNIhSuK8s1zuq7
         bp8+xy2et11HnpLGxjQI+SB3cmvTRKg0+09jPpamCJbyqWLKCi6KgeVhyvZBsl0lD2Y5
         3SsbmK0quZGYoLxa2vyXcKstN3GaSkdCwc9m8ApcRvXOo6qy2xJiqIZoMQMWs+r+1RdI
         pwtKQxRxZK5Pyu3mJD4E3PB5V0n6MsMgVwjWHJeOPjrp1ua52sO5n7PphNFht4eiKTG2
         NqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769567265; x=1770172065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gao4ipUlmOIwcq99MQVTnaBelmvpZVAv6HM5nyo0jY8=;
        b=i2oOBZsDEYOLFzpGRQpQRMTqBe9+8siU6Fw6ZheVsUlM/QyQjCi6294/O3/LuElFgY
         T2TmJ6yyrkOg3/xOXpfb0Hqot9gpKiZ00vLBdi9yKv/UT+cDq3rcSa0l21/zhsM7dEDE
         KfjXjjANn3KR3bMtjanFeiSbb4VtIf7iO3jU16MdSyJPS3YDbM0py+ZsKPBNlwye5VVY
         WcBErAcjCB8RrEf6AkXP0jlWauY7arv+RRbzBqfDGXT6QlaJgvg15JJHp/ezof1bMh00
         Vk+roCJhoptoH7GMNcwlIg4oYm5nAmxNJruYINcSPA4UJzrrBNj828hNgMYz/XCdj5Ep
         LzFg==
X-Gm-Message-State: AOJu0Yz++pBh4r5aSBJ0mAtjHAa27KPCb46YcxT+dDZN2hItXKK4aF5J
	OjzGxrPrK67TsqAk1B4Uikyp5QTQFl1362511Uwck2adHL3sY5K3csIH7QDDJe+XW+V2prhhfyF
	Z+lWQDWdITMjEMzjfX5Og4TJXUrvxhYI=
X-Gm-Gg: AZuq6aIighAkBxLFIwYANzX2eFrIJsS2JG3m/9ZXgyIJN3CPsVbt1K/bdKvCni5sLUR
	BRCC5VD5u+BvtIIkpuIOBwf0YXurdwLPTcU8Go57i3ZxZYBaT3AE+jD0ccfQBGQoT8h2Qxc41r1
	MuImTPpZnjrb/P4XFYXtQSJpSFSgzmHvQ4TT4jZ8tBSrhyGLMhpJ9+lUsj/ZfKAckWYSwPC7rLB
	E1cRsP/cQWb5iuUg6gZ27YpCs2aOmLGeO5i+MDCCsZ9CTInaw/Pr1FKzQs5qZNKsOpXZGGxFIPt
	n2uvSJck/uEgGGzlVCmvc1sRmN+kwDkafH9TfKo=
X-Received: by 2002:a05:6000:2c0f:b0:435:a52a:6351 with SMTP id
 ffacd0b85a97d-435dd06fdcamr5571699f8f.28.1769567265043; Tue, 27 Jan 2026
 18:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123055658.372869-1-leon.hwang@linux.dev> <20260123055658.372869-2-leon.hwang@linux.dev>
In-Reply-To: <20260123055658.372869-2-leon.hwang@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 Jan 2026 03:27:08 +0100
X-Gm-Features: AZwV_QikRELPKkiHav8bifJDmZ5LbpBRmz_K7m2jmSCN-B7jXjXSAiP6UeRts0I
Message-ID: <CAP01T77UY=FjNg9RDFQP8UYsS67gJBEsJjZBobu=Dh-fHG-+Yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Disallow BPF_F_LOCK with mixed
 special fields and centralize flag checks
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Jan 2026 at 06:58, Leon Hwang <leon.hwang@linux.dev> wrote:
>
> Disallow combining BPF_F_LOCK with map values that contain special BTF
> fields other than bpf_spin_lock (e.g. kptr or uptr). Such mixing may lead
> to subtle or undefined behavior in map value handling. Reject these
> combinations early by returning -EOPNOTSUPP.

The commit log is really suboptimal in giving context on why you're doing this.
You should summarize the discussion from [0], otherwise unless people
go dig that thread they'd have no clue.

Also, I would remove the 'undefined behavior' wording. It's just
semantically different, in that the update doesn't free fields,
but there's no undefined behavior.

  [0]: https://lore.kernel.org/bpf/CAADnVQLib8ebe8cmGRj98YZiArendX8u=dSKNUrUFz6NGq7LRg@mail.gmail.com

Please also increase test coverage for other maps in patch 2. Even if
covering all local storages is not practical, we can definitely do
task local storage.

>
> Centralize map update flag validation in bpf_map_check_op_flags() and
> reuse it across array, hash, local-storage, and task-storage map update
> paths. Explicitly reject incompatible BPF_NOEXIST/BPF_EXIST combinations
> and invalid BPF_F_LOCK usage to keep flag validation consistent and
> eliminate duplicated per-map checks.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h            |  7 +++++++
>  kernel/bpf/arraymap.c          | 11 ++++-------
>  kernel/bpf/bpf_local_storage.c |  7 -------
>  kernel/bpf/bpf_task_storage.c  |  3 ---
>  kernel/bpf/hashtab.c           |  8 +++-----
>  kernel/bpf/syscall.c           |  4 +++-
>  6 files changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5936f8e2996f..c5863487ee73 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3935,9 +3935,16 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
>         if ((u32)flags & ~allowed_flags)
>                 return -EINVAL;
>
> +       /* BPF_NOEXIST and BPF_EXIST are mutually exclusive. */
> +       if ((flags & (BPF_NOEXIST | BPF_EXIST)) == (BPF_NOEXIST | BPF_EXIST))
> +               return -EINVAL;
> +
>         if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>                 return -EINVAL;
>
> +       if ((flags & BPF_F_LOCK) && btf_record_has_field(map->record, ~BPF_SPIN_LOCK))
> +               return -EOPNOTSUPP;
> +
>         if (!(flags & BPF_F_CPU) && flags >> 32)
>                 return -EINVAL;
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 67e9e811de3a..1cff40f109cd 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -366,10 +366,7 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
>         struct bpf_array *array = container_of(map, struct bpf_array, map);
>         u32 index = *(u32 *)key;
>         char *val;
> -
> -       if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
> -               /* unknown flags */
> -               return -EINVAL;
> +       int err;
>
>         if (unlikely(index >= array->map.max_entries))
>                 /* all elements were pre-allocated, cannot insert a new one */
> @@ -379,9 +376,9 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
>                 /* all elements already exist */
>                 return -EEXIST;
>
> -       if (unlikely((map_flags & BPF_F_LOCK) &&
> -                    !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
> -               return -EINVAL;
> +       err = bpf_map_check_op_flags(map, map_flags, BPF_EXIST | BPF_F_LOCK);
> +       if (unlikely(err))
> +               return err;
>
>         if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
>                 val = this_cpu_ptr(array->pptrs[index & array->index_mask]);
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index e2fe6c32822b..80b50091cbbf 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -493,13 +493,6 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>         unsigned long flags;
>         int err;
>
> -       /* BPF_EXIST and BPF_NOEXIST cannot be both set */
> -       if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
> -           /* BPF_F_LOCK can only be used in a value with spin_lock */
> -           unlikely((map_flags & BPF_F_LOCK) &&
> -                    !btf_record_has_field(smap->map.record, BPF_SPIN_LOCK)))
> -               return ERR_PTR(-EINVAL);
> -
>         if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
>                 return ERR_PTR(-EINVAL);
>
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> index a1dc1bf0848a..21d84818e64e 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -125,9 +125,6 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
>         struct pid *pid;
>         int fd, err;
>
> -       if ((map_flags & BPF_F_LOCK) && btf_record_has_field(map->record, BPF_UPTR))
> -               return -EOPNOTSUPP;
> -
>         fd = *(int *)key;
>         pid = pidfd_get_pid(fd, &f_flags);
>         if (IS_ERR(pid))
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3b9d297a53be..2f6ed3e80308 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1093,9 +1093,9 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>         u32 key_size, hash;
>         int ret;
>
> -       if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
> -               /* unknown flags */
> -               return -EINVAL;
> +       ret = bpf_map_check_op_flags(map, map_flags, BPF_NOEXIST | BPF_EXIST | BPF_F_LOCK);
> +       if (unlikely(ret))
> +               return ret;
>
>         WARN_ON_ONCE(!bpf_rcu_lock_held());
>
> @@ -1107,8 +1107,6 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>         head = &b->head;
>
>         if (unlikely(map_flags & BPF_F_LOCK)) {
> -               if (unlikely(!btf_record_has_field(map->record, BPF_SPIN_LOCK)))
> -                       return -EINVAL;
>                 /* find an element without taking the bucket lock */
>                 l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
>                                               htab->n_buckets);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3c5c03d43f5f..49e424e5f492 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1780,6 +1780,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>         bpfptr_t uvalue = make_bpfptr(attr->value, uattr.is_kernel);
>         struct bpf_map *map;
>         void *key, *value;
> +       u64 allowed_flags;
>         u32 value_size;
>         int err;
>
> @@ -1796,7 +1797,8 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>                 goto err_put;
>         }
>
> -       err = bpf_map_check_op_flags(map, attr->flags, ~0);
> +       allowed_flags = BPF_NOEXIST | BPF_EXIST | BPF_F_LOCK | BPF_F_CPU | BPF_F_ALL_CPUS;
> +       err = bpf_map_check_op_flags(map, attr->flags, allowed_flags);
>         if (err)
>                 goto err_put;
>
> --
> 2.52.0
>
>
