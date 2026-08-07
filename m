Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2A314B9A
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068962; cv=none; b=SnJZHzGhT/8m2HXZkw6O3mv5wezLbgfSKThTan4vGftRQ1ntTMDfols7RGvyzMTOYT3NuhkQlfdsPl4nviJ5BAhHBsqEMRxSBzbGbNJmXMbhYPjQ9Lzb7UBBlCGT2tX5xJbwUK1s0TAaUh9MG+FbAC7XG4yxvVXK4YpSwag43Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068962; c=relaxed/simple;
	bh=RNvD5sxNW1GAbSzcRgEjjMNm8XViNnhG8XV0MRGxKW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i9WLgxfwsNE0Hmphgl6TPySfOllWbTRtGqLRCKsj5Ich9hyzsDFeIT9QL+AlfSg4pG6flgZDgWT4GW09z+j/l8etfZTb9XSFdOg491sHb4KXTTrDBY2CMSbCsh5gKJPMegcP8mo3lyBdA6AKgaY8I2CjMUS4GW+YeFycChUgxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6bt4DJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6bt4DJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8C61F000E9;
	Fri,  7 Aug 2026 02:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786068961;
	bh=8JLnV8tdUnAOlKbaITEfkyehomUyOsFJB4Ndpa4WLWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j6bt4DJtlWOK/ZWXX3vIPhxnt7PXC6hNcesd72kwY9BkTvXbuye+qJqD4UZSGk5z3
	 eJUNHDYJ1n4/u1fyeT3sqxC+MNjFXoBB9oDqO6S02zE3vuUyQMi5L5axcKPFpzP3V/
	 ruaQOwudqlAqxxmdsiW6NyMIRFuPh6Iv6JGZdOE2+HPvkkGh64rL2bZv4hAz76XU6q
	 rubr36dg/n/QjaXeAU/NaDkyIgrQRBcNC1b2WvXqgPkCAe7AweefjTpWUlQHmZWIAK
	 jdLit63M32YHW2TXnj2dpjNcDc/jWht3F9oxBkRvVsxBgdX0ot0/JGO6AJyXnARlnb
	 Yx0FS48xRtegA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] bpf: Fix queue/stack map u32 index overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260807020548.1376979-2-chenyuan_fl@163.com>
References: <20260807020548.1376979-1-chenyuan_fl@163.com>
 <20260807020548.1376979-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 02:15:59 +0000
Message-Id: <20260807021600.DE8C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] When `attr->max_entries` is exactly `U32_MAX` and `attr->value_s=
ize` is 1, the internal map capacity tracker `qs->size` silently truncates =
to 0, permanently breaking the map while still allocating 4GB of kernel mem=
ory.
--

--- Patch [1]: [PATCH 1/2] bpf: Fix queue/stack map u32 index overflow ---
commit 47dbebc907a9c220d2feebeadd6501394e5a0348
Author: Yuan Chen <chenyuan@kylinos.cn>
Subject: bpf: Fix queue/stack map u32 index overflow

The queue/stack map addresses elements[] with the product of a u32
head/tail index and value_size, but the storage itself is allocated in
64-bit arithmetic. This patch restores a bound check to reject maps whose
element storage would exceed U32_MAX bytes.

> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -59,6 +59,13 @@ static int queue_stack_map_alloc_check(union bpf_attr =
*attr)
>  		 */
>  		return -E2BIG;
> =20
> +	/*
> +	 * The u32 head/tail index is multiplied by value_size to address
> +	 * elements[]. Bound the map size so the product cannot overflow.
> +	 */
> +	if ((u64)attr->max_entries * attr->value_size > U32_MAX)
> +		return -E2BIG;
> +

[Severity: Medium]
This is a pre-existing issue, but could this check still allow a truncation
in qs->size when attr->max_entries is exactly U32_MAX and attr->value_size
is 1?

If a map is created with those attributes, it bypasses the bounds check
above. Then in queue_stack_map_alloc(), the size is incremented by 1:

kernel/bpf/queue_stack_maps.c:queue_stack_map_alloc() {
    ...
    u64 size, queue_size, cost;
    ...
    size =3D attr->max_entries + 1;
    ...
    qs->size =3D size;
    ...
}

Because qs->size is declared as a u32 in struct bpf_queue_stack:

    u32 size; /* max_entries + 1 */

does assigning size (which is U32_MAX + 1) cause qs->size to silently
truncate to 0? This appears to result in a 4GB map allocation that remains
permanently empty since its capacity tracker is 0.

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807020548.1376=
979-1-chenyuan_fl@163.com?part=3D1
