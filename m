Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A8445FFA9
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588105; cv=none; b=fE53efRzsH0qRIcz6baLwNB9+zyRl8XevCjsyXEDul2wff5u6pa26DxmWAdtrSKREb9iRJGujC8jY1HWJwzKtUcrt9u2PWaLjTZyDuXstYjUgaZFTiQpXocuvoV+99/Qf6xMnie/NvOHAIzQ2vtoqJ9SDvy6SK8EWns5ajTqTrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588105; c=relaxed/simple;
	bh=R7GI4VMbvu/twWiiCDvfgzLFCDIO+nNwNcCBjJMHIT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBmGoK+PTBAfvloKbfqXLCumgbZQVlA0uDCcm/0JUaDiBFb45eUrCz0p5zKzmmuWgp22eufzXwp2h2761W00vp1oeAdLSHpINNkPFp/In3eWBSaMzwwM2c/G/Z2jPd9ytroETObFZW7riWty3hZfrF14RvZa3p2Z9MkM/Cqfj6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdXExFqp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdXExFqp"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-482c58a8683so1422963f8f.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787588102; x=1788192902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TIIL6cFp9EGhRh5AI53UlQfVdkS/qav3l3R7BStzUx0=;
        b=PdXExFqpNcgzS1PJ1Fsp003jAGQAd+9itD92Uw6Xz5olpqpY0i8dKsIcZAyqcOU6Mn
         qyeAdZNVAMEIH5ulWZoSmHMOi/mpxoLPOYTO9ZT/2TmNvIDZva1Ajg9KppTNS4yDsavB
         Gc/eSLsdBzUvRE1O27qCgSm+GLsh0TReNonhioC4gnldTxGRJnE96NIHKPXp7trcUCTi
         RfjHAf7l5cbg0g69cT+YPSuaMKOK2Ryb1K8qAG8FeKeU75KiwmD0UK7JKmkgqOP0SPIV
         SB0hjW/S7fXSlztHfQF2pkjHAujP7h5CuietHh/GdKGFx9N28FmSHh4af+T1KHBrUYTh
         Zk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787588102; x=1788192902;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TIIL6cFp9EGhRh5AI53UlQfVdkS/qav3l3R7BStzUx0=;
        b=DtU4dRrbIIyzWTx1VB4euwyjiuj3ygmyq+m6swyb1+/QMQ0Yv7pOUSLe8+bo1MXirH
         abHZdHfsdWQSWT3F0eq8U7IiA99kpaKCmrMBS4iHZ5lmOlrS2J7cOdRmwSFTwEuHpNo8
         xxR4D8EfdptYKsGzfolgUyJbCffVWngTeNFOApAMvzL9rzyinSSxPDbNAQ5PnqhTYPaO
         AD5qFAG6BdAmsrCnHriJV0QMfXCG6csAufgaGSQgtJpQK4O8VB0OR8r8yz5RFk5vsu70
         quM7IHw4FuTLQf5IrvSYyKZC5v52wRuSB/RWqedJ4PMi2t2NJ617DJAzjCuYB9gqHhtX
         9Szg==
X-Forwarded-Encrypted: i=1; AHgh+RoTpYcM7iwTRWY1OF4V5igs4mVxy9hMfQ536dWdVtc4QGTswc8JtpzBNcjtA+2Xqff08iQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lkyAWQF3eIt5esfL2aMMP3fbEq619vw8gl1zHUCeCMFqwLgHSE
	sM76HYf9wAAxDw8UnuZ/MPR7MT80qE6SBqO0i22m1WPKTGbusQ7zbgEz
X-Gm-Gg: AR+sD11NDZrPAqSGUnbLbSpWJERbIeQ+vkPKzVCSf/+qLHighqD2y54SWDFv5BXueYq
	TDrUUO9DtWHp1QTMHEzKDS5eDqRyXND1HBj7WI/GbMFyyTQABLkDDVs4x8bWYOUxc4W5awnujWd
	O5U+5kArQ21b/uOcSSVlh85Z2HNtuQjhXmFS2yE4XsvbsVwaplh8xAOlvBsSNL39ZsKf+lpi/hX
	f7xCjm4cn85q2WfM33szUTuh7iIxVimaeQOENvXOF8RedBYqQhRfZH9SxPj4TEXtYPWiuNe/Tfk
	2pOwdszHhhXYqZgH1BpH5lUb/x5LjIo1d2Vd5NUz12Q9Mj22nwVCgFQD+z1ga3fKKE0iPffJQVP
	2YsiOHTAlyEXs3/CWVTea78eibTCqz4hSI4+wRpoCcFimXcwq/c4fL9beMozJxaLXVOlGaYOrR5
	DIKvZN6hbizB/AsCFh/QGdH/ya3CArvkfjEMX1eYfLOACZHeJ8dYyNLk/RMYfaQwrrhBXUeHtvH
	JjrgzChAp+DDmUQhBd7Ny8qWw==
X-Received: by 2002:a05:6000:290c:b0:47f:7129:6e2d with SMTP id ffacd0b85a97d-482c0b9488dmr35035906f8f.17.1787588101646;
        Mon, 24 Aug 2026 09:15:01 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5c63:74d0:c7a3:a419? ([2620:10d:c092:500::4:7337])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b69d7dsm8621351f8f.4.2026.08.24.09.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 09:15:00 -0700 (PDT)
Message-ID: <0560a24d-2cf9-4e5b-aa61-580af1e56de1@gmail.com>
Date: Mon, 24 Aug 2026 17:15:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] bpf: Cancel special fields in resizable hashtab on
 recycle
To: chenyuan_fl@163.com, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Yuan Chen <chenyuan@kylinos.cn>
References: <DKM6K95EN9OF.3O9XNYWVLYHDE@gmail.com>
 <20260824143621.2098856-1-chenyuan_fl@163.com>
 <20260824143621.2098856-2-chenyuan_fl@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260824143621.2098856-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 3:36 PM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> rhtab_delete_elem() and rhtab_map_update_existing() eagerly call
> bpf_obj_free_fields() when an element is deleted or its value is
> replaced. This runs kptr destructors in the caller's execution
> context, which is unsafe for BPF programs running in NMI context
> (e.g. perf_event programs attached to hardware PMU overflows):
> referenced kptr destructors may take locks or otherwise cannot run
> in NMI.
> 
> Commit a3a81d247651 ("bpf: Cancel special fields on map value
> recycle") switched the hash map and array recycle paths to
> bpf_obj_cancel_fields(), which only cancels NMI-safe fields (timer,
> workqueue, task_work), but it missed the resizable hashtab.
> rhtab_map_update_existing() even documents the intended "cancel"
> semantics while still calling bpf_obj_free_fields().
> 
> Fix the resizable hashtab the same way:
> 
>   * rhtab_delete_elem() and rhtab_map_update_existing() now cancel
>     only NMI-safe fields. Referenced kptrs stay attached to the
>     recycled element and are destroyed by rhtab_mem_dtor() once the
>     element is eventually freed, keeping the reference accounting
>     balanced.
> 
>   * rhtab_map_update_elem() initializes the special fields of a
>     freshly allocated element. The bpf memory allocator may return a
>     recycled element that still owns a referenced kptr, and
>     check_and_init_map_value() would zero that slot, dropping the
>     reference without releasing it. rhtab_init_map_value()
>     initializes the remaining fields (spin lock, timer, workqueue,
>     task_work, refcount) but leaves kptr slots untouched, matching
>     the hash map semantics.
> 
> Verified with a selftest: a perf_event (NMI) program overwrites a
> rhtab element that holds a referenced task kptr, and a second phase
> deletes and re-inserts the element to exercise the recycle path.
> Before the patch the NMI update eagerly released the kptr and the
> recycle path zeroed the inherited slot; after the patch the kptr is
> inherited on both paths and the probe observes it non-NULL.
> 
> Fixes: a3a81d247651 ("bpf: Cancel special fields on map value recycle")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  kernel/bpf/hashtab.c | 70 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d40cb5dd446c..0df8db27cd8c 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2864,14 +2864,56 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
>  	return htab_map_alloc_check(attr);
>  }
>  
> -static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
> -					struct rhtab_elem *elem)
> +static void rhtab_cancel_fields(struct bpf_rhtab *rhtab,
> +				struct rhtab_elem *elem)
>  {
>  	if (IS_ERR_OR_NULL(rhtab->map.record))
>  		return;
>  
> -	bpf_obj_free_fields(rhtab->map.record,
> -			    rhtab_elem_value(elem, rhtab->map.key_size));
> +	/*
> +	 * Only cancel NMI-safe fields (timer, workqueue, task_work) here.
> +	 * RHASH values can also carry referenced kptrs (and per-cpu kptrs),
> +	 * whose destructors must not run from arbitrary BPF execution
> +	 * contexts (e.g. NMI); leave them attached to the recycled element
> +	 * and let rhtab_mem_dtor() destroy them once the element is
> +	 * eventually freed. This matches the hash map semantics introduced
> +	 * by a3a81d247651 ("bpf: Cancel special fields on map value
> +	 * recycle").
> +	 */
> +	bpf_map_free_internal_structs(&rhtab->map,
> +				      rhtab_elem_value(elem, rhtab->map.key_size));
> +}
> +
> +/*
> + * Initialize special fields of a freshly allocated rhtab element, but keep
> + * kptr fields untouched. A recycled element may carry a referenced kptr from
> + * its previous life: the delete path only cancels NMI-safe fields (matching
> + * the hash map semantics), so the kptr reference stays owned by the element
> + * until rhtab_mem_dtor() destroys it. Zeroing it here (as
> + * check_and_init_map_value() would) would drop the reference without
> + * releasing it.
> + */
> +static void rhtab_init_map_value(struct bpf_map *map, void *value)

Could you please double check if this is needed at all?
I think bpf_map_free_internal_structs() going to reset
special fields to 0, so immediate reuse by __bpf_async_init(),
bpf_task_work_schedule() correctly identifies fresh fields.

> +{
> +	struct btf_record *rec = map->record;
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return;
> +
> +	for (i = 0; i < rec->cnt; i++) {
> +		struct btf_field *field = &rec->fields[i];
> +		void *field_ptr = value + field->offset;
> +
> +		switch (field->type) {
> +		case BPF_KPTR_UNREF:
> +		case BPF_KPTR_REF:
> +		case BPF_KPTR_PERCPU:
> +			continue;
> +		default:
> +			bpf_obj_init_field(field, field_ptr);
> +		}
> +	}
>  }
>  
>  static void rhtab_mem_dtor(void *obj, void *ctx)
> @@ -2963,8 +3005,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
>  		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
>  		check_and_init_map_value(&rhtab->map, copy);
>  	}
> -	/* Release internal structs: kptr, bpf_timer, task_work, wq */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	/* Cancel NMI-safe fields; full destruction happens in rhtab_mem_dtor */
> +	rhtab_cancel_fields(rhtab, elem);

Let's directly call bpf_obj_cancel_fields() here and below, 
so it is consistent with htab.

>  	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>  	return 0;
>  }
> @@ -3022,10 +3064,11 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
>  	 * BPF_F_LOCK, matching arraymap semantics.
>  	 *
>  	 * copy_map_value() skips special-field offsets, so old timers/
> -	 * kptrs/etc. still sit in the slot. Cancel them after the copy
> -	 * to match arraymap's update semantics.
> +	 * kptrs/etc. still sit in the slot. Cancel the NMI-safe ones after
> +	 * the copy to match arraymap's update semantics; referenced kptrs
> +	 * stay attached and are destroyed by rhtab_mem_dtor().
>  	 */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	rhtab_cancel_fields(rhtab, elem);
>  	return 0;
>  }
>  
> @@ -3066,7 +3109,14 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
>  
>  	memcpy(elem->data, key, map->key_size);
>  	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
> -	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
> +	/*
> +	 * Initialize special fields of the (possibly recycled) element, but
> +	 * leave kptr slots alone: a recycled element may still own a
> +	 * referenced kptr that rhtab_mem_dtor() will release, so zeroing it
> +	 * here would leak the reference. Fresh memory from the bpf mem
> +	 * allocator is zeroed, so skipping the kptr init is safe there too.
> +	 */
> +	rhtab_init_map_value(map, rhtab_elem_value(elem, map->key_size));
>  
>  	/* Prevent deadlock for NMI programs attempting to take bucket lock */
>  	bpf_disable_instrumentation();

