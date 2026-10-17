Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E615239E6C
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202739; cv=none; b=s+3TcCB//mfjXGkI1JByJNw/5ROBm45z10lkJB0p2AU2u1uQxSU5zrPpco37yssCi4I/SvxFE0UHhedCJzmKaWawy4NhbQZHwqz/Y06z6gH4Oom+wcS/oh+nZlEvPv8vjma9PwpXZ/AiawqK6otmhg5uwlJXcxDg8KcZjbHOwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202739; c=relaxed/simple;
	bh=zt58rHOmJFV1gcAqwHHvv3hqqVu+mXB/xLM5Gh93Lj4=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=CtmcPVXiCwIK4GQddhGCAwM388esVyJek4d+7orT0+359cdA45j8Zc0M2EoJAEjmobPNkEBK57CHfG3Gt+b9eQsYiVl7FLzBfE/LjtX6j4vzheQgSQStLvb2kPUd4Ndsx7zYfTkNgjjUjjrUHwlNw0WO7xh90kKOotAMY0Yke6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQu58jxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQu58jxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FEF1F000C8;
	Sat, 17 Oct 2026 02:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202737;
	bh=/c+kWbWJpSo4s2AWkJKhgYsjXJTCe8paa/lG1TGS6dI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YQu58jxkYOgkKWABeM+PyJyiyqhGotT1//rrxF3+O5BOks/kQ6SGCdAKZ7f2qiZB6
	 y/BKz0fuSw4m22kFrWIwWa01YPjW9w0AGcu9cWZ7liW5nr1wuYFn7AfZvgmdDP+uLd
	 z2q0nqywO9sfMtUysc1l0uo7Ki2mnJu6aL29ol+80+9QwovnBzKfG35I9XC/J4OQpM
	 7PyCoAEPufJaI6lRrjf+8WMWU/b8sst2q7S03aZtCUepysln757hDVV/s7Zz4oEbEK
	 tizzx7E57QtHzsKQlYDtZPOuKnsiJz/zGO0XaPRCBKpqUW67reDeoHPzTwVIA23EBv
	 XPYx2kCboMeeQ==
Message-ID: <sashiko-outbox-175184@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 36/38] bpf: Follow the head if an skb is
 written from a slice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017012451.364800-28-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
 <20261017012451.364800-28-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:05:37 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: duplicate bpf_try_make_writable() call in __bpf_skb_store_b=
ytes()
--

commit cd64e2e5d6a96038e5e37496663c8035d9bcd26c
Author: Josef Bacik <josef@toxicpanda.com>

bpf: Follow the head if an skb is written from a slice

This commit introduces bpf_try_make_writable_from() and updates
__bpf_skb_store_bytes() and __bpf_skb_meta_store_bytes() to adjust the sour=
ce
pointer when making an skb writable reallocates its head.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index bf01152d0cf9a..54e9084b9263a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1752,9 +1752,32 @@ static const struct bpf_func_proto bpf_skb_store_b=
ytes_proto =3D {
>  	.arg5_type	=3D ARG_ANYTHING,
>  };
> =20
> +/*
> + * The source of a write through a dynptr may be a slice of the same skb.
> + * Making the skb writable can move its head: follow the move.
> + */
> +static int bpf_try_make_writable_from(struct sk_buff *skb, u32 write_len,
> +				      const void **from)
> +{
> +	const void *head =3D skb->head;
> +	bool in_head =3D *from >=3D head &&
> +		       *from < (const void *)skb_end_pointer(skb);
> +	int err;
> +
> +	err =3D bpf_try_make_writable(skb, write_len);
> +	if (!err && in_head)
> +		*from =3D skb->head + (*from - head);
> +	return err;
> +}
> +
>  int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *f=
rom,
>  			  u32 len, u64 flags)
>  {
> +	if (unlikely(offset > INT_MAX))
> +		return -EFAULT;
> +	if (unlikely(bpf_try_make_writable_from(skb, offset + len, &from)))
> +		return -EFAULT;
> +
>  	return ____bpf_skb_store_bytes(skb, offset, from, len, flags);
>  }

[Severity: Medium]
Does calling ____bpf_skb_store_bytes() after bpf_try_make_writable_from() e=
nd
up calling bpf_try_make_writable() a second time without updating from?

Looking at ____bpf_skb_store_bytes() in net/core/filter.c:

    BPF_CALL_5(bpf_skb_store_bytes, struct sk_buff *, skb, u32, offset,
               const void *, from, u32, len, u64, flags)
    {
        void *ptr;

        if (unlikely(flags & ~(BPF_F_RECOMPUTE_CSUM | BPF_F_INVALIDATE_HASH=
)))
            return -EINVAL;
        if (unlikely(offset > INT_MAX))
            return -EFAULT;
        if (unlikely(bpf_try_make_writable(skb, offset + len)))
            return -EFAULT;

        ptr =3D skb->data + offset;
        if (flags & BPF_F_RECOMPUTE_CSUM)
            __skb_postpull_rcsum(skb, ptr, len, offset);

        memcpy(ptr, from, len);

When a BPF program calls bpf_dynptr_write() or bpf_dynptr_copy() on a
BPF_DYNPTR_TYPE_SKB dynptr using a slice of the same skb as the source,
__bpf_skb_store_bytes() calls bpf_try_make_writable_from() and then calls
____bpf_skb_store_bytes().

Inside ____bpf_skb_store_bytes(), the second bpf_try_make_writable() call
follows the chain:

    bpf_try_make_writable()
      __bpf_try_make_writable()
        skb_ensure_writable()
          pskb_may_pull()
            pskb_may_pull_reason()
              skb_might_realloc()
                pskb_expand_head()

When CONFIG_FAIL_SKB_REALLOC triggers, skb_might_realloc() reallocates and
frees skb->head during that second call without updating from, leaving from
pointing to the freed head before copying into ptr.

Also, because __bpf_skb_store_bytes() calls bpf_try_make_writable_from()
before ____bpf_skb_store_bytes() checks flags, invalid flags will only be
rejected after the skb has already been uncloned or pulled (and will return
-EFAULT instead of -EINVAL if skb_ensure_writable() fails, unlike
__bpf_skb_meta_store_bytes() which checks flags first).

Note that passing packet slices directly to the bpf_skb_store_bytes() or
bpf_lwt_seg6_store_bytes() helpers is prevented later in the series by comm=
it
"bpf: Refuse packet slices for packet-changing helpers", so could
bpf_try_make_writable_from() be used directly inside ____bpf_skb_store_byte=
s()
instead of duplicating the checks in __bpf_skb_store_bytes()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017012058.3557=
87-1-alexei.starovoitov@gmail.com?part=3D36
