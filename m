Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518DD3B14D9
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521866; cv=none; b=OaG0Ad8ytK3HeJQelU0WdEkbWFqf+dbjXCMVn+/4xrdRLorokoHnsKm2U78wYDRSJABWEcdCHa6hqK7p6XYVLv9bDslfZ7B9WrsSIohyq6CZPn45peZPocu7SWA8k3dug0AGZjwu3YvxddQ6fGgdJ3q9YGSfvlNpeYM87llZUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521866; c=relaxed/simple;
	bh=YnkJpuPJb9dnEN1/IAOl8Bz+60w9MlaXU2Cs2IL+BHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JH2SXSTcaS8vHycnZlRt1xdfAe4SPlm4RWVJ7rHa5J+GV24wcwtzW2o7n1fYS4NJXNapQvmUbA8pJq1Tw6aah8NOQlerwWZ4bjBwltwEmVbebqMD1M7qs7JIENAW/dEGDq71KIvNz0DQ1uu1NCXm5s11EDq6Fdr9M/gfYaVbpUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IexjN/Ud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IexjN/Ud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0BB1F00A3D;
	Fri,  4 Sep 2026 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788521865;
	bh=IOv843WcAgK3ZFaMDf7Fs6POxaiGeNhh4QWDeMd2nIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IexjN/UdrP+L5+REG1UlOFbDB/QY1wIiCJQA/FvhETeA5VFZ0xHhWUEZn+LtM15sH
	 yTMtFi2uGzgId7T00POT6BNR9m5P1VesVIbBJr1rey4SPLLSQIrDfKO6jiy7yVFuPf
	 ncV28H0GlRwtyW5B/kSyYVPOc6rg/QQZu2voZ8p5xZfGeEScaO6uj2PaJICTtcNz4t
	 Xi4K6ypmjU5szj4l4vXw0tUd3YPrj1Tj+no96/iqP4muMk1kzi+OyUyQQQPqIUKJxU
	 GGWRQWSKjO3+V3+doeV77o6Vv9xz4cxTAOh4ATHsJ8pkYxLoF+7EUF6RJxcnKMYBoD
	 0/u2gECK6QLZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 3/8] bpf: Cancel special fields when recycling
 rhtab elements
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904104203.345917-4-memxor@gmail.com>
References: <20260904104203.345917-1-memxor@gmail.com>
 <20260904104203.345917-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:37:44 +0000
Message-Id: <20260904113744.BE0BB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing bpf_obj_free_fields() with bpf_obj_cancel_fields() durin=
g map updates and deletions violates BTF-001 and causes cross-key resource =
leakage.
--

commit 87b60bb947c49832ff2d2552730fd3c5124e6130
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

bpf: Cancel special fields when recycling rhtab elements

This commit modifies rhtab map operations to use bpf_obj_cancel_fields()
instead of bpf_obj_free_fields() when replacing or deleting elements. This =
is
done to avoid releasing referenced kptrs and other complex fields in NMI
context, aligning with array and hash map behavior.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 527cc5716ee8c..cc60e99ffbe92 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -2967,8 +2957,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhta=
b, struct rhtab_elem *elem, v
>  		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
>  		check_and_init_map_value(&rhtab->map, copy);
>  	}
> -	/* Release internal structs: kptr, bpf_timer, task_work, wq */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	bpf_obj_cancel_fields(&rhtab->map,
> +			      rhtab_elem_value(elem, rhtab->map.key_size));
>  	bpf_mem_cache_free_rcu(&rhtab->ma, elem);

[Severity: High]
Does changing this to bpf_obj_cancel_fields() leave stale special fields in
the memory cache?

Since bpf_obj_cancel_fields() does not drop kptrs or list heads, these
references appear to remain in the element when it is freed to the cache.
When a new element is later allocated from the cache in
rhtab_map_update_elem():

    elem =3D bpf_mem_cache_alloc(&rhtab->ma);
    if (!elem)
        return -ENOMEM;
    memcpy(elem->data, key, map->key_size);
    copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);

Because bpf_mem_cache_alloc() does not zero memory and copy_map_value()
skips special fields, will this cause the new key to inherit the old key's
populated list head or kptr?

>  	return 0;
>  }

[ ... ]

> @@ -3029,7 +3018,7 @@ static long rhtab_map_update_existing(struct bpf_ma=
p *map, struct rhtab_elem *el
>  	 * kptrs/etc. still sit in the slot. Cancel them after the copy
>  	 * to match arraymap's update semantics.
>  	 */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	bpf_obj_cancel_fields(map, old_val);

[Severity: High]
Does replacing the free operation with bpf_obj_cancel_fields() here violate
the requirement to clean up special BTF fields during map updates?

When overwriting an existing map value in-place, failing to free existing
kptrs or list heads seems like it causes them to outlive the update. Will
this leave stale resources bound to the key indefinitely?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904104203.3459=
17-1-memxor@gmail.com?part=3D3
