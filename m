Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C4494829
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160320; cv=none; b=HLkYVrq/dB3v2MUBzBSVjsmNHgpOU5V2iBAmjayeMUo3EDgJxh75UBzKCDSHMVzbIvPrw9UXb3IhBYQeWpU5LJGnJMSZ4upRUH0FptUJ0+KUK3qxWpnmaIFt4moooo32c3ovdtSega0Teb/cG3KO3o+9++JCQHC0QLGlzGSuVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160320; c=relaxed/simple;
	bh=a5ltglB0UYvVP8aZZDalxtmFnWPej1Q5IpmVlwN/WrQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=P7kkAfO8A2ZSuWEzVAfZA2tb19yqFWLdQJyyssK7EArHx8T3l8IriuVPmDcpIkHPgWqIZairK5BjG3TJNj1VBu2bnRduQcV7pMZ071ALARFGuXNS7VYNk15fDhavUoLsjysleXGuT/8Veoa9K+/lB23cbz1535JbzJR5Yl1GzoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ehF1QlWs; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ehF1QlWs"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca12086c06eso861054a12.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787160317; x=1787765117; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sRvfkPMHEHTPAPhUlGsquXh/ui1bgWvByjxen4MjHTE=;
        b=ehF1QlWsBr0+nc0iWThQcSPoXYSon0DFulcF+jgHqpMwtqkQlBTDyuYkBqp+hrsPDa
         ZkNMLX7QuI8FhQDG6Pv0zFXo19j5rlneHDar9GXB2rKs7l1uTNpLaDcAk5fhEEEHW3Oz
         DsJ3t0CUEVcZgFThVbEgbnwV29WzPPxZBcv1dH+a59Mzhard7k405tbLgRmhrHWPL4Th
         TxYYwTzjdXIhYtlKvLRgXU21Uj9KEKry/ySJ/tp2xLR1QyohSvFQ101QUn1WImsJpCMb
         tU7wcJ4TIEo7xw8EZnR8TeuQCwO6t3JFsP0mjkkx3VZ3FGcx8xbxuThrQHkEtGphM0Rw
         ULmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787160317; x=1787765117;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sRvfkPMHEHTPAPhUlGsquXh/ui1bgWvByjxen4MjHTE=;
        b=cMPfDvkFB4Kit33ssaZPPlWxldMJooVILpitu1C+Ab1Vg9SBld+u27+YTqsv8RjlQW
         r+yUki5WHAkwCXT3M6uH37k71b3YZfyZ3SC71pAJyD0cMarjXS40GTDxhMlBhr07oIhM
         cvMl5ecayuTqBQu1cSl4RPzLTzgJwv5QGxpp3ba7AhG0dez80IJmlOfZ0M3aiGNg/Kcc
         nDZRsANZ2Ma41gZ4ucY8VhaHSfx1/t3xMftgsF2EJ7LyOvg0A6NJZhchLFu6FUoF4zYj
         sbmtPYPD9XEU1cewRfsdAjMMg6wbGZG2yqc4AhITpg4Se65S6LwEJ02LoIQPJTr+dA/h
         l6rw==
X-Forwarded-Encrypted: i=1; AHgh+RqFSkT0rmUi7sQbZqNIhaMKsL2mSleFedcSKG2GmgOZZlBsjfVLWKdTg6Wl64QS86LMhx4=@vger.kernel.org
X-Gm-Message-State: AFuF++l5p2Kgb4ZY/O2PCF051GXYLrWFRpHQ0qEwmmZrWDTh//tJWSP/
	KNe5JjMYO+PAu1CteI6D0+h1J3MkjaFqeaIKp1MIEouApKc/WRWdKLew1VtakuoLscY=
X-Gm-Gg: AR+sD11LuElhFF3zW4jKqPV7hUEgvRw9gVQ6MaFQW4eMg68TFRNKPeWlFO9QKxCRbsw
	ucY8pIp7eFYPCJeiYfaS3Q63/UeEwZhCkQA27Z2kScWFYf+UJbnytgNy0T+TYEBun8rDKburRp6
	KQC15abGdeMVjSl2TXsh0mYJHEK6YXkX7jq5izZEq5EbcQdPh8e4UeEkYQJTVVnw+e4FLbZYYQv
	D+zxMICO1QOs174PF3eShKFdXwuEL74zn1yh+63HZad/CizQsI5obqVWWj4VFGJRH+a7rhwBJsr
	q70ng4JLxHrRtRQZRft1bDDkbgxepi5k4VYoKI0M4ys0t1DIUXWPZPZ1E33u5/ewRLAC/tc/r0a
	D9iVVYsP4Pmmnl+eo1Nmk7In2edIaA4k17lDuVEdpl7qH0AplWHu8KNGLsc3FaEWZbehef/R7Ou
	zjAMGg0aX+aQwpY0mGyfMf6j/MemKRHTGu3BohexTtSh22JD6/Jpp6Ae+bRif6UWYMr5ogBMBoW
	m5jZfWb2ZJGkRbrPQ==
X-Received: by 2002:a17:90b:3945:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-39580eafaa7mr12619312a91.6.1787160316949;
        Wed, 19 Aug 2026 10:25:16 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb60a2bsm3451585a91.17.2026.08.19.10.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 10:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 13:25:15 -0400
Message-Id: <DKT3GIN7DFJW.WF0NOSF1MMNQ@etsalapatis.com>
Cc: <linux-kernel@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Yuan Chen" <chenyuan@kylinos.cn>
Subject: Re: [PATCH bpf-next v3 1/3] bpf, arena: fix range_tree_clear
 inconsistency on kmalloc_nolock failure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <chenyuan_fl@163.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260810134800.2875487-1-chenyuan_fl@163.com>
 <20260810134800.2875487-2-chenyuan_fl@163.com>
In-Reply-To: <20260810134800.2875487-2-chenyuan_fl@163.com>

On Mon Aug 10, 2026 at 9:47 AM EDT, chenyuan_fl wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> range_tree_clear() pre-allocates the right-half node before modifying
> the tree, so an allocation failure returns -ENOMEM without altering the
> range tree.
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/range_tree.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 2f28886f3ff7..15b588377a76 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c
> @@ -143,16 +143,22 @@ int range_tree_clear(struct range_tree *rt, u32 sta=
rt, u32 len)
>  		if (rn->rn_start < start && rn->rn_last > last) {
>  			u32 old_last =3D rn->rn_last;
> =20
> +			/*
> +			 * Pre-allocate the right-half node before modifying
> +			 * the tree. If allocation fails we return -ENOMEM
> +			 * without altering the range tree.
> +			 */
> +			new_rn =3D kmalloc_nolock(sizeof(struct range_node),
> +						__GFP_ACCOUNT, NUMA_NO_NODE);
> +			if (!new_rn)
> +				return -ENOMEM;
> +
>  			/* Overlaps with the entire clearing range */
>  			range_it_remove(rn, rt);
>  			rn->rn_last =3D start - 1;
>  			range_it_insert(rn, rt);
> =20
> -			/* Add a range */
> -			new_rn =3D kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT,
> -						NUMA_NO_NODE);
> -			if (!new_rn)
> -				return -ENOMEM;
> +			/* Add right-half range */
>  			new_rn->rn_start =3D last + 1;
>  			new_rn->rn_last =3D old_last;
>  			range_it_insert(new_rn, rt);

