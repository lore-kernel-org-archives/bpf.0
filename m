Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D092D0C72
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188834; cv=none; b=YUpDu/81mvuvGNCVnCIgkismLJgJIW5qvN6Dy3W/T7WyU3ybes5uLT/bVp0Rpelzx+1xOh5mk0GCshFF90aQsKgNQH3D+G1HCV1L2FsIB5I79y0jaz89Xg5KM+Vt9TEQ0ktmvi6+1QmYFwC0PbYn1GvTKAw2/pFD89fCR5NFVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188834; c=relaxed/simple;
	bh=eCCGTxOIRRrhX5jvoyNKDjno1z/Yb87IQAtr6P8Lvmg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=scI1Nq39oNrLtuXe8i3PLWEb7b/Z8rYm3ZNDApOdGOaC/Ow0LJggZJ8eiGPyI/8DeepXVnt+ckTAuKAWQpHjWWu6w3X48A14z+8mQK4n21OpY760oOLyMthXqOLwU7nYEx1B1oNThFMHj+aQbsrC3gnbmL/1pMKOP1zR9HYsalc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=v3gizIId; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="v3gizIId"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so5207447eec.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776188832; x=1776793632; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3T2fuS57CU5vrj2RA4JUHILEv9q4Kx5JNTWOobQ8TA=;
        b=v3gizIIdVVgQNq4ZElCAYVLcvsbApszCSnUEj1lRdov0eT+39uqMttx3sSv5sb3Sgg
         4IEDicy1wB6r7meIEDdzkg4ntLh1+XkiSU9i6z+bXLDxJRsdE1p2NlkzEKcNehhOwTL/
         QxNOfkGrk02OGYn6iq0wAyJshqcOiefsMZAvrI5/qyEnMk7BjIlTr11DtIPRjUqTJvYa
         491Jo5aotfNHfGYXzFpxT/G8aaJN+R1624bo2Ag99WrwFbJTiItudZp5dOJYm9OQ4qxM
         O1qXx0R4/pDuHD7tWzEEZ17UxhYJIshm/OKZM4af+BNMcHHgWMtpSrXVFDCfU4u9Jg2M
         eSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188832; x=1776793632;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j3T2fuS57CU5vrj2RA4JUHILEv9q4Kx5JNTWOobQ8TA=;
        b=RmCz+hS3cxxkwMwCsfQfU/W3sRwtppfbeVMyZaECarpFpZNeqMNtyIySnFTkS5Qgrt
         Hv6tQicWz9OcHAFMfnP+UVFY0pbvLP4rqb+TS972gTPnogaFxh/GWIfr8/CRDBtFDEk6
         A4CSi2tjyfNcqF6Wloaale3k40A51Y9zh8N8OOWPKDz27sMZp8S4A7tJ7KTNsqtQSwYV
         D+1fbifeqrXImyhQ6qF6f7f1G5YT2o4BdTeQU3gM3TSX7iBWxbpOV+hHkxUSLlSi1Sga
         2E6518ekweP7z/EgQoJ3P2RmPIT93Vmt5wWSu1q+IRJjw1zRRueRc4sodl02K0q8qXq+
         e+WA==
X-Forwarded-Encrypted: i=1; AFNElJ9asPRdo/2FGeaZXPv9ZcwoRdiMV+B3i3jcDyB3T1ZzXrsAqN5qB9GaDJLy+kaMMMHwy8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMRDR4QakPkd4a/z5ImBKIS1CkE8DmSnG/FtleRQ+VZJvF75b
	RXXpXnfNxEa03u0UFpoYlzWVXkvt3r1Q7YM6iAQfAKrb4IAkwwWei2fGiXrJ0ScZx0o=
X-Gm-Gg: AeBDieu4aruSE7JtPbRLUUrITmk+6mXX5LDdWlIH1JjLjDK1W6ojmg3RWwXNJZ/t5aA
	gOMH+NZpp6MU7TpKxOhY4ymL4QHg4AEZnWrMOGFr4h01+09Dj2Xjqs48jgSF/+JzLy1oepBH6r7
	kE5y7PmdYcC+9k5Zqd51eyuUg5ddKlBi5vYNWfeb+V81oTjRYbaF7bSxgIY6RfG8o7HRPlot2wq
	/ALOWyh7XfQUSI5PdKF+Ju4+BAAPnyJjhctLnpE1hnkDc+g28J1hGl9E3S8G2byjMz31nF9YAEi
	GIYLBeyZeO5P5ms1Sce24fVksHXNBT+KwaLoW8eFdldCGgJlYS/vaQcJYa3HgT3nqmaLZxgXbjp
	aeCNkJJq43XwLcgeBIx00lLYuHv6OrS+uiyJSRKAQ5ChtOm/l1zGJoTsuJSP+um8NiuSdeGlkQq
	1PPJl+tD5UkUEdTkQ=
X-Received: by 2002:a05:693c:80c1:b0:2d9:6f2f:9f6f with SMTP id 5a478bee46e88-2d96f2fd124mr2723479eec.24.1776188832358;
        Tue, 14 Apr 2026 10:47:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::cfa6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d8dee27fccsm11203829eec.28.2026.04.14.10.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 13:47:09 -0400
Message-Id: <DHT2E3SO4O0U.3IHGPWXP84PWZ@etsalapatis.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 07/18] bpf: Implement batch ops for
 resizable hashtab
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>, <ast@kernel.org>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <kafai@meta.com>,
 <kernel-team@meta.com>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-7-3b3675da1f6e@meta.com>
 <DHSEYF5BFPD0.1O9VTHZBV53C2@etsalapatis.com>
 <9cbfadf0-39ca-437e-88d7-3bb7030b799d@gmail.com>
In-Reply-To: <9cbfadf0-39ca-437e-88d7-3bb7030b799d@gmail.com>

On Tue Apr 14, 2026 at 4:08 AM EDT, Mykyta Yatsenko wrote:
>
>
> On 4/14/26 12:25 AM, Emil Tsalapatis wrote:
>> On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>
>>> Add batch operations for BPF_MAP_TYPE_RHASH.
>>>
>>> Batch operations:
>>>   * rhtab_map_lookup_batch: Bulk lookup of elements by bucket
>>>   * rhtab_map_lookup_and_delete_batch: Atomic bulk lookup and delete
>>>
>>> The batch implementation uses rhashtable_walk_enter_from() to resume
>>> iteration from the last collected key. When the buffer fills, the last
>>> key becomes the cursor for the next batch call.
>>>
>>> Also implements rhtab_map_mem_usage() to report memory consumption.
>>>
>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>> ---
>>>   kernel/bpf/hashtab.c | 137 ++++++++++++++++++++++++++++++++++++++++++=
+++++++--
>>>   1 file changed, 134 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> index e79c194e2779..a79d434dc626 100644
>>> --- a/kernel/bpf/hashtab.c
>>> +++ b/kernel/bpf/hashtab.c
>>> @@ -3051,19 +3051,150 @@ static long bpf_each_rhash_elem(struct bpf_map=
 *map, bpf_callback_t callback_fn,
>>>  =20
>>>   static u64 rhtab_map_mem_usage(const struct bpf_map *map)
>>>   {
>>> -	return 0;
>>> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
>>> +	u64 num_entries;
>>> +
>>> +	num_entries =3D atomic_read(&rhtab->ht.nelems);
>>> +	return sizeof(struct bpf_rhtab) + rhtab->elem_size * num_entries;
>>> +}
>>> +
>>> +static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
>>> +					       const union bpf_attr *attr,
>>> +					       union bpf_attr __user *uattr,
>>> +					       bool do_delete)
>>> +{
>>> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
>>> +	void __user *uvalues =3D u64_to_user_ptr(attr->batch.values);
>>> +	void __user *ukeys =3D u64_to_user_ptr(attr->batch.keys);
>>> +	void __user *ubatch =3D u64_to_user_ptr(attr->batch.in_batch);
>>> +	void *buf =3D NULL, *keys =3D NULL, *values =3D NULL, *dst_key, *dst_=
val;
>>> +	struct rhtab_elem **del_elems =3D NULL;
>>> +	u32 max_count, total, key_size, value_size, i;
>>> +	struct rhashtable_iter iter;
>>> +	struct rhtab_elem *elem;
>>> +	u64 elem_map_flags, map_flags;
>>> +	int ret =3D 0;
>>> +
>>> +	elem_map_flags =3D attr->batch.elem_flags;
>>> +	if ((elem_map_flags & ~BPF_F_LOCK) ||
>>> +	    ((elem_map_flags & BPF_F_LOCK) &&
>>> +	     !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
>>> +		return -EINVAL;
>>> +
>>> +	map_flags =3D attr->batch.flags;
>>> +	if (map_flags)
>>> +		return -EINVAL;
>>> +
>>> +	max_count =3D attr->batch.count;
>>> +	if (!max_count)
>>> +		return 0;
>>> +
>>> +	if (put_user(0, &uattr->batch.count))
>>> +		return -EFAULT;
>>> +
>>> +	key_size =3D map->key_size;
>>> +	value_size =3D map->value_size;
>>> +
>>> +	keys =3D kvmalloc_array(max_count, key_size, GFP_USER | __GFP_NOWARN)=
;
>>> +	values =3D kvmalloc_array(max_count, value_size, GFP_USER | __GFP_NOW=
ARN);
>>> +	if (do_delete)
>>> +		del_elems =3D kvmalloc_array(max_count, sizeof(void *),
>>> +					   GFP_USER | __GFP_NOWARN);
>>> +
>>> +	if (!keys || !values || (do_delete && !del_elems)) {
>>> +		ret =3D -ENOMEM;
>>> +		goto free;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Use the last key from the previous batch as cursor.
>>> +	 * enter_from positions at that key's bucket, walk_next
>>> +	 * returns the successor in O(1).
>>> +	 * First call (ubatch =3D=3D NULL): starts from bucket 0.
>>> +	 */
>>> +	if (ubatch) {
>>> +		buf =3D kmalloc(key_size, GFP_USER | __GFP_NOWARN);
>>> +		if (!buf) {
>>> +			ret =3D -ENOMEM;
>>> +			goto free;
>>> +		}
>>> +		if (copy_from_user(buf, ubatch, key_size)) {
>>> +			ret =3D -EFAULT;
>>> +			goto free;
>>> +		}
>>> +	}
>>> +
>>> +	scoped_guard(rcu) {
>>=20
>> AFAICT this guard makes sure the RCU critical section extends from the
>> beginning of rhashtable_walk_enter_from all the way to walk_stop(), is
>> that correct?
>>=20
>
> This guard is to make sure that when rhashtable_walk_enter_from()=20
> initializes iterator, the element which it initialised with is not=20
> freed. rhashtable_walk_start() calls rcu lock as well, that's why I can=
=20
> end guard right after rhashtable_walk_start().
>

Sounds good, thanks.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>>> +		rhashtable_walk_enter_from(&rhtab->ht, &iter, buf, rhtab->params);
>>> +		rhashtable_walk_start(&iter);
>>> +	}
>>> +
>>> +	dst_key =3D keys;
>>> +	dst_val =3D values;
>>> +	total =3D 0;
>>> +
>>> +	while (total < max_count) {
>>> +		elem =3D rhtab_iter_next(&iter);
>>> +		if (!elem)
>>> +			break;
>>> +
>>> +		memcpy(dst_key, elem->data, key_size);
>>> +		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
>>> +		check_and_init_map_value(map, dst_val);
>>> +
>>> +		if (do_delete)
>>> +			del_elems[total] =3D elem;
>>> +
>>> +		dst_key +=3D key_size;
>>> +		dst_val +=3D value_size;
>>> +		total++;
>>> +	}
>>> +
>>> +	if (do_delete) {
>>> +		for (i =3D 0; i < total; i++)
>>> +			rhtab_delete_elem(rhtab, del_elems[i]);
>>> +	}
>>> +
>>> +	rhashtable_walk_stop(&iter);
>>> +	rhashtable_walk_exit(&iter);
>>> +
>>> +	if (total =3D=3D 0) {
>>> +		ret =3D -ENOENT;
>>> +		goto free;
>>> +	}
>>> +
>>> +	/* Signal end of table when we collected fewer than requested */
>>> +	if (total < max_count)
>>> +		ret =3D -ENOENT;
>>> +
>>> +	/* Write last key as cursor for the next batch call */
>>> +	if (copy_to_user(ukeys, keys, total * key_size) ||
>>> +	    copy_to_user(uvalues, values, total * value_size) ||
>>> +	    put_user(total, &uattr->batch.count) ||
>>> +	    copy_to_user(u64_to_user_ptr(attr->batch.out_batch),
>>> +			 dst_key - key_size, key_size)) {
>>> +		ret =3D -EFAULT;
>>> +		goto free;
>>> +	}
>>> +
>>> +free:
>>> +	kfree(buf);
>>> +	kvfree(keys);
>>> +	kvfree(values);
>>> +	kvfree(del_elems);
>>> +	return ret;
>>>   }
>>>  =20
>>>   static int rhtab_map_lookup_batch(struct bpf_map *map, const union bp=
f_attr *attr,
>>>   				  union bpf_attr __user *uattr)
>>>   {
>>> -	return 0;
>>> +	return __rhtab_map_lookup_and_delete_batch(map, attr, uattr, false);
>>>   }
>>>  =20
>>>   static int rhtab_map_lookup_and_delete_batch(struct bpf_map *map, con=
st union bpf_attr *attr,
>>>   					     union bpf_attr __user *uattr)
>>>   {
>>> -	return 0;
>> Shouldn't these have been -EINVAL or -ENOSUPP in previous patches?
>>=20
>>> +	return __rhtab_map_lookup_and_delete_batch(map, attr, uattr, true);
>>>   }
>>>  =20
>>>   struct bpf_iter_seq_rhash_map_info {
>>=20

