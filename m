Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22716314D1F
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776122718; cv=none; b=N940WJu3bAv+z3RDfMC2uTzEF7NqiTABXtcJpVcG23nCUYTM8lfBjRtORiM9EYwg1TVpN5mjyDZmwb2Qnixzl+2bfptv6S6GmfKcEM/zPGzJ0w+pm457uyfyr+yg0//Xejmd7hKQX/iqSIFi85nBr4LKwJXTPD3qmtJw+gkfWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776122718; c=relaxed/simple;
	bh=Ns0bPP0hYkp0VUQ32He+0AlFMJCX1ufAymam1L2dI/w=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=dh9nDSdewuxUkTWqbz+wtEQ/Ndxq6g0WCawQFiHf+3oOkUKpYVV28sGJ8LfYCykYayQf6DY4t2I2/JKedM4VsjMvkiQFIHIoxIUPJvkeWY/LbkUQK09jWTyfVuc96YMnCWHu6VQHbQwBWKSwqKDljCiyeak8XBrLBFRQNhOLwyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Hx4m8YpR; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Hx4m8YpR"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c79467f128cso301530a12.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776122716; x=1776727516; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MME+I2ae58p/pB5elYsONkyhx5H3F5ly58Yut/m6Nk=;
        b=Hx4m8YpRw/FxWJwbEl4pA7o2EfLyzLH3s3tR2GXunlDTDsAZo+RQQyVV9Bh4akZjvP
         nr8gs59ANH9YVLNcX2XP1Ya3G+U2hIf3H4StZKThGAPYhHcDpcxU83fKcOrxDlndKJbG
         2F/PRF+KtsHluwq+a2c2LL5BmuBbmvZgPltdjI81eAaykxHxX98Yh/14+Zblr5OyjWEa
         ++ALTDwr4fGr2ge+w9AZWMrMu5UwvjAFeLe1MRr6HuSz2nNsxapEjf312UdURp/UcX6b
         RkLGaFtLYC5+4EYb4WSnN6b4uetf1z3KmdPJgDhBnn1FRkQrR1rMpMqWcZNorQppnYxE
         n61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776122716; x=1776727516;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MME+I2ae58p/pB5elYsONkyhx5H3F5ly58Yut/m6Nk=;
        b=D+0TcVfibWew9iS7l9bxgoi33YevX0TCJrIHBWPKRhAIL2f1Um3t4TlJe+NqC9eemL
         IvcSXDu/IYPN7rR9zbx9qEtfaBrDx4dryXQEbVx2ypjnEeIVKS0LQBpTLNOGzRWd9Fyx
         ZHBR+/vRz9pfh5y6ftRlD7zhb1W33Vrm3WgyIGdMsLGYj3F4ZcLbV/sSvVggRQqDv/PL
         0zpj2RBGK+T5ckrIY/bZT4zvTi8KZo1PJCBrYGmxqzwLOf5lBckA5XVXT3hk3/MHaBoA
         +zFWWgsVbGXMW9wTlwsoxO0HzB+JxS/xcBbIb31yVcV8YhaL/YB00jxW1jofvcSs6Oqg
         S86Q==
X-Forwarded-Encrypted: i=1; AFNElJ+LWmDAbBRykGRYQwDMvabArYrGoaqlp1U9QtkxI8xKvujhg7BNxWjcBLby7KqmibUwe+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0Ma7hjOpgfBvPGX9PFWSqkOGlHD/GP4zVuEWwmT+HaBIH1Ez
	1ReQ/oMZ1mRtwUpA18lvCA8RM9WzTRxhD19z4ykDSByPE5o0W3iarDYkEc5cJdu54oQ=
X-Gm-Gg: AeBDieu/eEQ1TtK/Q9Ub5PoHNb2ZPv+29G6gODmE5T4a6HixRjCem0vlPp01HVklAC/
	kRHwvbHU0AGdgTmdf6SAVfxjtnMV+aMA1suVzZqLIcvlD/nBOWu+uCHw/7OEdGlYP7zHP6w0WUO
	LcTZCBt74dBIss8PN2TZi17pIMr7ukGxeTeAKbRWgCTqftFR0TP4f0SDlItBaA2dDS/gDyqOomQ
	ptSy50K5D9boNe9HSQXMS3oxtC5wqnU2UNm5k9vNDmXHuEM1S0QcmgzOgKzusuofPDS6qYdPv8Q
	KrhOllUBHTAPD3FDRBquFVEGrBIkhQoaaNfREVolbmZ/3/Sure3U5G8TRZ/LyExsxdLiu0dIjX+
	NDnoxTvWUW3SysqkZOsJF6vg3CABpF7rsZS0eZlkP9qHPk1KOdc/1BzRPN3w37zu3duT2IfoQTK
	Z28KizdzTjSOYyjyLtcQ==
X-Received: by 2002:a05:6a20:7492:b0:39f:3ca8:a31c with SMTP id adf61e73a8af0-39fe4080da5mr16327815637.53.1776122716220;
        Mon, 13 Apr 2026 16:25:16 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a36898sm10347057a12.31.2026.04.13.16.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 16:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 19:25:15 -0400
Message-Id: <DHSEYF5BFPD0.1O9VTHZBV53C2@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <herbert@gondor.apana.org.au>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 07/18] bpf: Implement batch ops for
 resizable hashtab
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-7-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-7-3b3675da1f6e@meta.com>

On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add batch operations for BPF_MAP_TYPE_RHASH.
>
> Batch operations:
>  * rhtab_map_lookup_batch: Bulk lookup of elements by bucket
>  * rhtab_map_lookup_and_delete_batch: Atomic bulk lookup and delete
>
> The batch implementation uses rhashtable_walk_enter_from() to resume
> iteration from the last collected key. When the buffer fills, the last
> key becomes the cursor for the next batch call.
>
> Also implements rhtab_map_mem_usage() to report memory consumption.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/hashtab.c | 137 +++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 134 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index e79c194e2779..a79d434dc626 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3051,19 +3051,150 @@ static long bpf_each_rhash_elem(struct bpf_map *=
map, bpf_callback_t callback_fn,
> =20
>  static u64 rhtab_map_mem_usage(const struct bpf_map *map)
>  {
> -	return 0;
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	u64 num_entries;
> +
> +	num_entries =3D atomic_read(&rhtab->ht.nelems);
> +	return sizeof(struct bpf_rhtab) + rhtab->elem_size * num_entries;
> +}
> +
> +static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
> +					       const union bpf_attr *attr,
> +					       union bpf_attr __user *uattr,
> +					       bool do_delete)
> +{
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	void __user *uvalues =3D u64_to_user_ptr(attr->batch.values);
> +	void __user *ukeys =3D u64_to_user_ptr(attr->batch.keys);
> +	void __user *ubatch =3D u64_to_user_ptr(attr->batch.in_batch);
> +	void *buf =3D NULL, *keys =3D NULL, *values =3D NULL, *dst_key, *dst_va=
l;
> +	struct rhtab_elem **del_elems =3D NULL;
> +	u32 max_count, total, key_size, value_size, i;
> +	struct rhashtable_iter iter;
> +	struct rhtab_elem *elem;
> +	u64 elem_map_flags, map_flags;
> +	int ret =3D 0;
> +
> +	elem_map_flags =3D attr->batch.elem_flags;
> +	if ((elem_map_flags & ~BPF_F_LOCK) ||
> +	    ((elem_map_flags & BPF_F_LOCK) &&
> +	     !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
> +		return -EINVAL;
> +
> +	map_flags =3D attr->batch.flags;
> +	if (map_flags)
> +		return -EINVAL;
> +
> +	max_count =3D attr->batch.count;
> +	if (!max_count)
> +		return 0;
> +
> +	if (put_user(0, &uattr->batch.count))
> +		return -EFAULT;
> +
> +	key_size =3D map->key_size;
> +	value_size =3D map->value_size;
> +
> +	keys =3D kvmalloc_array(max_count, key_size, GFP_USER | __GFP_NOWARN);
> +	values =3D kvmalloc_array(max_count, value_size, GFP_USER | __GFP_NOWAR=
N);
> +	if (do_delete)
> +		del_elems =3D kvmalloc_array(max_count, sizeof(void *),
> +					   GFP_USER | __GFP_NOWARN);
> +
> +	if (!keys || !values || (do_delete && !del_elems)) {
> +		ret =3D -ENOMEM;
> +		goto free;
> +	}
> +
> +	/*
> +	 * Use the last key from the previous batch as cursor.
> +	 * enter_from positions at that key's bucket, walk_next
> +	 * returns the successor in O(1).
> +	 * First call (ubatch =3D=3D NULL): starts from bucket 0.
> +	 */
> +	if (ubatch) {
> +		buf =3D kmalloc(key_size, GFP_USER | __GFP_NOWARN);
> +		if (!buf) {
> +			ret =3D -ENOMEM;
> +			goto free;
> +		}
> +		if (copy_from_user(buf, ubatch, key_size)) {
> +			ret =3D -EFAULT;
> +			goto free;
> +		}
> +	}
> +
> +	scoped_guard(rcu) {

AFAICT this guard makes sure the RCU critical section extends from the
beginning of rhashtable_walk_enter_from all the way to walk_stop(), is
that correct?

> +		rhashtable_walk_enter_from(&rhtab->ht, &iter, buf, rhtab->params);
> +		rhashtable_walk_start(&iter);
> +	}
> +
> +	dst_key =3D keys;
> +	dst_val =3D values;
> +	total =3D 0;
> +
> +	while (total < max_count) {
> +		elem =3D rhtab_iter_next(&iter);
> +		if (!elem)
> +			break;
> +
> +		memcpy(dst_key, elem->data, key_size);
> +		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
> +		check_and_init_map_value(map, dst_val);
> +
> +		if (do_delete)
> +			del_elems[total] =3D elem;
> +
> +		dst_key +=3D key_size;
> +		dst_val +=3D value_size;
> +		total++;
> +	}
> +
> +	if (do_delete) {
> +		for (i =3D 0; i < total; i++)
> +			rhtab_delete_elem(rhtab, del_elems[i]);
> +	}
> +
> +	rhashtable_walk_stop(&iter);
> +	rhashtable_walk_exit(&iter);
> +
> +	if (total =3D=3D 0) {
> +		ret =3D -ENOENT;
> +		goto free;
> +	}
> +
> +	/* Signal end of table when we collected fewer than requested */
> +	if (total < max_count)
> +		ret =3D -ENOENT;
> +
> +	/* Write last key as cursor for the next batch call */
> +	if (copy_to_user(ukeys, keys, total * key_size) ||
> +	    copy_to_user(uvalues, values, total * value_size) ||
> +	    put_user(total, &uattr->batch.count) ||
> +	    copy_to_user(u64_to_user_ptr(attr->batch.out_batch),
> +			 dst_key - key_size, key_size)) {
> +		ret =3D -EFAULT;
> +		goto free;
> +	}
> +
> +free:
> +	kfree(buf);
> +	kvfree(keys);
> +	kvfree(values);
> +	kvfree(del_elems);
> +	return ret;
>  }
> =20
>  static int rhtab_map_lookup_batch(struct bpf_map *map, const union bpf_a=
ttr *attr,
>  				  union bpf_attr __user *uattr)
>  {
> -	return 0;
> +	return __rhtab_map_lookup_and_delete_batch(map, attr, uattr, false);
>  }
> =20
>  static int rhtab_map_lookup_and_delete_batch(struct bpf_map *map, const =
union bpf_attr *attr,
>  					     union bpf_attr __user *uattr)
>  {
> -	return 0;
Shouldn't these have been -EINVAL or -ENOSUPP in previous patches?

> +	return __rhtab_map_lookup_and_delete_batch(map, attr, uattr, true);
>  }
> =20
>  struct bpf_iter_seq_rhash_map_info {

