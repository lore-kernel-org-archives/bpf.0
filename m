Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43733483821
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281848; cv=none; b=ccP7UVLtfC2TETEsc7ukKGbJRMLV5yX+ZEGxPI9lvV2ClJoPATxi+Wrvlw03U/h4goXtkN/q0oe1tRr9A/a2z5yBQW9DfLL6sLPep8jUyGun1O5L5FlPYXnFYwhJbWJEZnY4QN69UQCnbTE3UudNFN0mBGVepEPVxOpb+6CqAT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281848; c=relaxed/simple;
	bh=lgwdoTrlO0HEFS94P4RArG+h9VAkaKbGLxswo5sqNXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMf6k2goSaQljemdKat8/9HyWCM/cvPsSNdCIYtHMHxMzqeusBx9+At34g7UXcYjBbyHh0PHeDRs8sbazperTk22s1TcDJLlrQosS+DxTt42jDQlelCksWii5t51iyb3JwYkrs/zG7E699m+cOsyLZw6xiEuV7rayTwG+W7/Dnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHbYyok9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHbYyok9"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b8be0409fso9380245e9.2
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788281844; x=1788886644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bwW47ioONs/Vqr3qlve/7uLurw9nuu4muvuRMdEX4tA=;
        b=bHbYyok97xbWPZzyU/6milPuBdpCPAsQ2et42/SA+T9yhFsZ1PfuFgVON2SnEe4/mO
         HoJZJoE1sWcFRptxieUF/D1OmrLXF8dIDxAJo6nlJCCQICE5qySrex6LZlpFf+2lmAz2
         pxzMx5uLkT1OGx8xa2Sqgye/8V6YsI9c6YNNBawVqjuBxyAAYBntNZHZtD4+/pXY2MbC
         Dy2ftV2vxaQAAyFfWdail9+oGy1iauxkhjVlViT2a2mObXUUx9vBRy1Kr0HZ/VS5LS3k
         59Wjy6WierUI9jZb+R0rpR/jAWKHSd0cixECOuobKOaezb8po8YjBVwoH/rL3vAn3FM+
         grBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281844; x=1788886644;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bwW47ioONs/Vqr3qlve/7uLurw9nuu4muvuRMdEX4tA=;
        b=QayqEt7E3nVQQtyv9fL/Zd1QVpmGv8Gy2txuG9tVhDd1Zype5XNG7U6sndwnv4unWl
         O9uyNMQJ5Z0IjZ9BDpjYhKD3/PUtcGhJWqQF+/QUjkC0pEnhd+dLse9db3yrMybvzNYj
         ncicB+Ns3EBhsgHUBLfuMKJiXGR8eC7c+N3GQlewnjgkPq/9MDEFOnw0z8ecbYADIw++
         pJb+/s63c7SE/YC3hKBY6yQWAM78Vuhf1DBiMrqHQvVp9ONKxhq3NaddfEKw2VS7vOa5
         0PZSM+tNWL0GYWvB8qL3Zv4qufk/1ST4wqy0kEuFZLDUEh0hewMzNrOkIr2j3W0/SrvA
         J8Nw==
X-Forwarded-Encrypted: i=1; AHgh+RrXuTc2OWwu0jxRUVoUmjuq/3L5NHyghgnvbONTPttu+gyUlY8vWow7S+vTK82WeETNktM=@vger.kernel.org
X-Gm-Message-State: AFuF++ngqYe4/s7j/M5mVsohhOfUyYf+MopBrzMxhdJJTn9RKCQmgGJ6
	u72v/jkpftYTKII1b7NBGp3B1WEuIbbzStB9F4dyWHR1t/zbuXROJ50o
X-Gm-Gg: AR+sD13FbZ1Co+LbWfTuR4E3uGsV8heZTnZdrso4KJYSTU1NnuiLb2MBkSL+3TL5aRT
	QUv/k2nzGdxCRSwqehHQnIXkuvyKZc102pc/9nRBxLHlQ1XmgXj4B8qrGrrE3y3VGFj2VBdT98m
	TKNHJvHz1y+AwJfvVRDGTD3UYory6uMwFqP+RFQk1hIFM017Az8eXlNZksp5oH99jDTaAH1T4t3
	aBlFDnBAEXwPmdk2lZzEAjKh3oa3XEibzF2Iz2RODofOAfslwKg5EIqKfdsFLrBUEmbUiwvTbQZ
	cZV3YdxLvvJwpbof/5kq4aIGI5207Or1J8fSBLF647vSSE5j2TL0EWrD/EGvaOThtIhUo+jROfX
	ebbxgeca/ZgJWpq5RIXBvsOy+6nx13cnTnLaKG3hqany2krleM+UVNimARbliib4gAdv7Q+Lc3k
	rL27cN378m7VPSkvO9DaJ+cKIa20Vx2v6Rkr7nfBYH4jcPQflCqfN+MhdZD0bfKUG/gyiYo3zhO
	pi74RjbAnn0nCcdBraqwcBu2w==
X-Received: by 2002:a05:600c:3511:b0:499:adb4:a922 with SMTP id 5b1f17b1804b1-49b91c4bab5mr413374315e9.12.1788281844013;
        Tue, 01 Sep 2026 09:57:24 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:f403:a537:85fc:d569? ([2620:10d:c092:500::6:3965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72c28sm362209f8f.6.2026.09.01.09.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 09:57:23 -0700 (PDT)
Message-ID: <6727850f-7d94-4e01-bc42-bd630f7e6e26@gmail.com>
Date: Tue, 1 Sep 2026 17:57:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Cancel special fields in resizable
 hashtab on recycle
To: chenyuan_fl@163.com, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Yuan Chen <chenyuan@kylinos.cn>
References: <0560a24d-2cf9-4e5b-aa61-580af1e56de1@gmail.com>
 <20260901062845.1379760-1-chenyuan_fl@163.com>
 <20260901062845.1379760-2-chenyuan_fl@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260901062845.1379760-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/1/26 7:28 AM, chenyuan_fl@163.com wrote:
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
> Fix the resizable hashtab the same way: call bpf_obj_cancel_fields()
> on delete and in-place update, matching htab. Referenced kptrs stay
> attached to the recycled element and are destroyed by rhtab_mem_dtor()
> once the element is eventually freed, keeping the reference accounting
> balanced. No special-field initialization is added to the element
> alloc path: fresh elements come zeroed from the bpf mem allocator,
> recycled elements already had their timer/workqueue/task_work slots
> reset by bpf_obj_cancel_fields(), and check_and_init_map_value() would
> zero the kptr slot of a recycled element, dropping the reference
> without releasing it.
> 
> Verified with a selftest: a perf_event (NMI) program overwrites a
> rhtab element that holds a referenced task kptr, and a second phase
> deletes and re-inserts the element to exercise the recycle path.
> Before the patch the NMI update eagerly released the kptr and the
> recycle path zeroed the inherited slot; after the patch the kptr is
> inherited on both paths and the probe observes it non-NULL.
> 
> Fixes: a3a81d247651 ("bpf: Cancel special fields on map value recycle")
> Suggested-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  kernel/bpf/hashtab.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d40cb5dd446c..aaedda3730f3 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2864,16 +2864,6 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
>  	return htab_map_alloc_check(attr);
>  }
>  
> -static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
> -					struct rhtab_elem *elem)
> -{
> -	if (IS_ERR_OR_NULL(rhtab->map.record))
> -		return;
> -
> -	bpf_obj_free_fields(rhtab->map.record,
> -			    rhtab_elem_value(elem, rhtab->map.key_size));
> -}
> -
>  static void rhtab_mem_dtor(void *obj, void *ctx)
>  {
>  	struct htab_btf_record *hrec = ctx;
> @@ -2963,8 +2953,9 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
>  		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
>  		check_and_init_map_value(&rhtab->map, copy);
>  	}
> -	/* Release internal structs: kptr, bpf_timer, task_work, wq */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	/* Cancel NMI-safe fields; full destruction happens in rhtab_mem_dtor */
> +	bpf_obj_cancel_fields(&rhtab->map,
> +			      rhtab_elem_value(elem, rhtab->map.key_size));
>  	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>  	return 0;
>  }
> @@ -3022,10 +3013,12 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
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
> +	bpf_obj_cancel_fields(&rhtab->map,
> +			      rhtab_elem_value(elem, rhtab->map.key_size));
>  	return 0;
>  }
>  
> @@ -3066,7 +3059,14 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
>  
>  	memcpy(elem->data, key, map->key_size);
>  	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
> -	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
> +	/*
> +	 * No explicit special-field initialization, matching the hash map's
> +	 * non-prealloc path: fresh elements come zeroed from the bpf mem
> +	 * allocator, and recycled elements had their timer/workqueue/task_work
> +	 * slots reset by bpf_obj_cancel_fields() on delete. kptr slots are
> +	 * left untouched so a recycled element keeps owning its reference
> +	 * until rhtab_mem_dtor() releases it.
> +	 */

I'm not sure this comment is useful, we don't comment on why we are not zeroing
special fields in htab, so why here.
Please address the finding of the bot regarding the old_val variable and for the
next respin send the patch series independently, not as a response to an old thread.
>  
>  	/* Prevent deadlock for NMI programs attempting to take bucket lock */
>  	bpf_disable_instrumentation();

