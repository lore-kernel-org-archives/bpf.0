Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B00F3A1692
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 05:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032608; cv=none; b=rP37MuNGv6K+vdK5SL8nPY/2dBDsRwhqONYZN8wa2Y+YfoeIYQxNHRO8rRjf1uHZxbX1FaGs9lZ+wRom73JxsjHwaGbP8xLBLz8GT/g79A6NM4A38NVC6UtfQ+Ar8g5LggLcMD2kOWgUtriMrCQXKPF7rE9d/P6AKo4KEG8xBwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032608; c=relaxed/simple;
	bh=rxCsYYbdDed7ETBIzZ/fkiefh8/+o9ywGaSrZiYVRr4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=VxcMS0TwJsbjKU2kxtw+xsK2H0SbVRxQfQdEm1QzjJ9hZYzUn1zVUZzSaS+P0gc9D2FpjN0E9ExCQ+hfI/4qMSo4KiDbDcoqxSg5xu7RcN5S+HznMG6bvUuObxsI42vB9pIFZSsyA2jOjsQuJtQSnPvdEnmpDgmYEHn8zMhHy+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=WCbjesLd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="WCbjesLd"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so7811189a91.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 22:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780032605; x=1780637405; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/UlsWXbnlywpZNi56py/1CKrzpnAXP49BFYVBPQEJw=;
        b=WCbjesLdGTBTwdAQkCvjRNRkLeBtaVWh8QAW284rtOBj6yIuIXT3upVG8l9goWO435
         tjShmrgu3pWab/VH9H8ATFgPct1fSNGLULo8i8RirSM2IKmskvqA0dVhlL4K2TXJD1sk
         V14u4K8hk8iMT2m+UQc8CzY1yU4ks0neFnHsh6bbNIsGYWQpxQLvVmpulUvJ0mgUUZCX
         oZ/66tf/ewXwtlAeqkWylW4iK9IOaY++bMyUNTsUesyiaBkWMdfI6A6oDvaBohlIezMW
         99Tjm6DhWWP6xPJf+Kk1oNor36si3neFt3E6G6z1bvbmnmiKO/rFZKrwmaDw195vu4wV
         JyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780032605; x=1780637405;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/UlsWXbnlywpZNi56py/1CKrzpnAXP49BFYVBPQEJw=;
        b=kc0uV0ZiUo73YuJ1nTnsbq2NbqcFA54w/etivGDBp8l7zjFqYEJ2gTfxWwBC+MZd+A
         eKJhf6TKqak4mTPqvUFdFAr4IfkMlsMtOTSrRm4gMsMKz10/pXwiq2gN5D4cWoxwoMDm
         wn4of83V0WlSuO40C0YjUj+T8elU564KotqnxWdrQlccLAGd+c+XK58JL4CzF/64LDUu
         UdWTpIWKdHTl8a0tOmI/1GMdFAmyAtjAp4yQ2RAWOBosqplmirx3/mO+JqGsi6yxylWE
         0rPwFeQZ4ULR2zwTWSyN3ga0Q6sFAJRf1nzA93GAc/GClqVftNDs6bQ59n4VDPk/Rj/h
         IVow==
X-Forwarded-Encrypted: i=1; AFNElJ+3UgERjDLnwEGEkp1HBnCNn0OZp25BQl5x9SYwTZ2lkVsoGRO+beXVit4MP05TPiAo+fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywba8HwVs9ePScBsOpdo8rq7rgjRtTs8Q8o+pQebU5maxoBbEys
	jBbv8jElVwrHSwnuKrEKnK2tpS+NlJA3NHMum4SNcF4dhMeNA4g3oz8SOexdGv4SEHU=
X-Gm-Gg: Acq92OGMq4rGWvfjYwFP0TitChu56+9BUUZeKcg0JSTlALevWlEwPyZD30p6vS42xTs
	w+rwK0qutCtuOv+5+PoagIojiD2gcP6lZtRxCrZBfoPas7kjSVeHrzg38b9VzsvEyj5XMw5ajIt
	uQpI6SlltoWTuwLFqDU+AANXtum6XDrerMQEsGtJkCEwZG5A0tMbMTUwfnBPhFuDg9nNpcYcqy2
	Fr8HmRtPgz5HuGxeIqC3g8sgrZo/j+fxsF+wf2KcbsqoMqmLekobX0wTc+ZXLcut7zqbvmbpNPL
	E9RszA3fpEAMlWAVN1wDQo3mAOxYs+vQZ4IAxSnSPQHQ0dPJmUcu00zpO43kBsj861iIN7J0p9H
	zQUhTyS7kbIeL4UpxhO//Z3Z7xPbxGuoWBmh9VfYMPgje3yY2heyaGfCDeMWPdL5qYzEBG93iWy
	Gd+YPGJUZuHmbbJ2AUz58cr5kSH0z1XIrpuP0=
X-Received: by 2002:a17:90b:17c9:b0:36b:9184:ea49 with SMTP id 98e67ed59e1d1-36bbd13ac3cmr1639053a91.26.1780032605209;
        Thu, 28 May 2026 22:30:05 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc6631789sm551648a91.8.2026.05.28.22.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 22:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 01:30:03 -0400
Message-Id: <DIUWW97NOAG2.N0U9S6VNDIQ7@etsalapatis.com>
Subject: Re: [PATCH bpf-next] bpf: Take mmap_lock in zap_pages()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
 <eddyz87@gmail.com>, <david@kernel.org>, <tj@kernel.org>,
 <linux-mm@kvack.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260528222014.38980-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260528222014.38980-1-alexei.starovoitov@gmail.com>

On Thu May 28, 2026 at 6:20 PM EDT, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> zap_vma_range() requires the owning mm's mmap_lock to be held.
>
> Taking mmap_read_lock under arena->lock would AB-BA against
> arena_vm_close() and arena_map_mmap(), both of which run with
> mmap_write_lock held and then acquire arena->lock. Instead drop
> arena->lock, mmget_not_zero() the vma's mm, take mmap_read_lock, and
> re-resolve the vma via find_vma() since it may have been unmapped or
> replaced while waiting.
>
> Track processed vmls with a per-call generation in vml->zap_gen and
> serialize zap_pages() callers with a new arena->zap_mutex so
> concurrent callers on different uaddr ranges do not mark each other's
> vmls processed before the zap is done.
>
> Reported-by: David Hildenbrand <david@kernel.org>
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/arena.c | 61 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 1727503b25d8..9b2dea229b38 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -60,6 +60,8 @@ struct bpf_arena {
>  	struct list_head vma_list;
>  	/* protects vma_list */
>  	struct mutex lock;
> +	u64 zap_gen;
> +	struct mutex zap_mutex;
>  	struct irq_work     free_irq;
>  	struct work_struct  free_work;
>  	struct llist_head   free_spans;
> @@ -289,6 +291,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr=
 *attr)
>  	if (err)
>  		goto err_free_scratch;
>  	mutex_init(&arena->lock);
> +	mutex_init(&arena->zap_mutex);
>  	raw_res_spin_lock_init(&arena->spinlock);
>  	err =3D populate_pgtable_except_pte(arena);
>  	if (err)
> @@ -391,6 +394,7 @@ struct vma_list {
>  	struct vm_area_struct *vma;
>  	struct list_head head;
>  	refcount_t mmap_count;
> +	u64 zap_gen;
>  };
> =20
>  static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *=
vma)
> @@ -403,6 +407,7 @@ static int remember_vma(struct bpf_arena *arena, stru=
ct vm_area_struct *vma)
>  	refcount_set(&vml->mmap_count, 1);
>  	vma->vm_private_data =3D vml;
>  	vml->vma =3D vma;
> +	vml->zap_gen =3D 0;
>  	list_add(&vml->head, &arena->vma_list);
>  	return 0;
>  }
> @@ -746,12 +751,60 @@ static long arena_alloc_pages(struct bpf_arena *are=
na, long uaddr, long page_cnt
>   */
>  static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt=
)
>  {
> +	unsigned long size =3D (unsigned long)page_cnt << PAGE_SHIFT;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
>  	struct vma_list *vml;
> +	unsigned long vm_start;
> +	u64 my_gen;
> =20
> -	guard(mutex)(&arena->lock);
> -	/* iterate link list under lock */
> -	list_for_each_entry(vml, &arena->vma_list, head)
> -		zap_vma_range(vml->vma, uaddr, PAGE_SIZE * page_cnt);
> +	/*
> +	 * Taking mmap_read_lock() under arena->lock would deadlock against
> +	 * arena_vm_close(), which runs with mmap_write_lock held and then
> +	 * acquires arena->lock. Drop arena->lock for mmap_read_lock().
> +	 *
> +	 * Use per-call my_gen, recorded in vml->zap_gen, to remember which
> +	 * vmls this invocation has already processed across the lock drop.
> +	 * Hold zap_mutex around the whole walk so concurrent zap_pages()
> +	 * callers cannot overwrite each other's marks on shared vmls --
> +	 * otherwise call B's mark would make call A skip a vml that A has
> +	 * not yet zapped for A's uaddr range.

One thing I'm fuzzy on: If the vml gens are to mediate between zap_pages
calls on the same arena, doesn't the zap_mutex already serialize those
calls? In that case, since zap_gen is only used for zap_pages(), do we
actually need gen counting?

> +	 */
> +	mutex_lock(&arena->zap_mutex);
> +	mutex_lock(&arena->lock);
> +	my_gen =3D ++arena->zap_gen;
> +	for (;;) {
> +		mm =3D NULL;
> +		list_for_each_entry(vml, &arena->vma_list, head) {
> +			if (vml->zap_gen >=3D my_gen)
> +				continue;
> +			vml->zap_gen =3D my_gen;
> +			if (!mmget_not_zero(vml->vma->vm_mm))
> +				continue;
> +			mm =3D vml->vma->vm_mm;
> +			vm_start =3D vml->vma->vm_start;
> +			break;
> +		}
> +		if (!mm)
> +			break;
> +		mutex_unlock(&arena->lock);
> +
> +		mmap_read_lock(mm);
> +		/*
> +		 * Re-resolve: while we waited the VMA could have been unmapped
> +		 * and a different mapping installed at the same address.
> +		 */
> +		vma =3D find_vma(mm, vm_start);
> +		if (vma && vma->vm_start =3D=3D vm_start &&
> +		    vma->vm_file && vma->vm_file->private_data =3D=3D &arena->map)
> +			zap_vma_range(vma, uaddr, size);
> +		mmap_read_unlock(mm);
> +		mmput(mm);
> +
> +		mutex_lock(&arena->lock);
> +	}
> +	mutex_unlock(&arena->lock);
> +	mutex_unlock(&arena->zap_mutex);
>  }
> =20
>  static void arena_free_pages(struct bpf_arena *arena, long uaddr, long p=
age_cnt, bool sleepable)

