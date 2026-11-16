Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818574;
	b=nXPaX9Odzn5rD/6El2Krlyb/mJ+lKJPnY18dCoq+jgQGwihdIjKsb6B9b1sEougUSi4/
	 8Un9tQXY7MGK9pdbCX3X2JcZpgBUT7GQ4uSkSWgiS5zT93ci4FVaI/rl/n9k713GXCX9t
	 LPASZcNBqg1hJ4sG7qjw4Bqy8UclYc6nxcoCHbZYCu3ThU142yN29lQXHH6yD3Olg5XjZ
	 b1+EQzI5KVbF7So4PpZk6cZWQLpUnaoNFZTuQwjJMP35k/uNCPCj7ct0+Lpoli5meRjGw
	 5gh8bbD5mQ0UHvaa3qw2wuNpiIY6H/RTJfSGIXWaRsUii/0L11NiUWtMj5Zdxc66HwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818574;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j6BVP6fRvgTsM2Cgn37Y0SFUS0glO5ISVH7WO5s7kTU=;
	b=3Qvs5oF8aYT00goDyHYg3mpvlLrwujzllGooZnUTwUS2amICpviitOrTNyKaFc5CMF0d
	 uQrftSIU6T6P7mFOG4DSMGVyEbS8lKcNKm5wNXYaEwixNa09SNvYik+MxCDZ+Z7la4cVv
	 KbeaM+RkwFaHQU7hEbIDbdtLkHfefCRDBCbTiqr3ZLl/uAy1LmJXraSLP4K6aRgCH+sn9
	 Hzkyte1fUI8B6W4wwd4mrn8Gbbuz0p8fIZ8E6eZEzJExsZW+QIbSKzwnD4mMjBt7bvYTi
	 PbMUaIUh/K0r0wuvZs7zG74D3z/hiRdnemYGbJR/jO2nCX3sbHlkv9E3IJdWZ52cdeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkqhzefH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB2606A32A
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkqhzefH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D2A1F000C4;
	Mon, 16 Nov 2026 08:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794818574;
	bh=j6BVP6fRvgTsM2Cgn37Y0SFUS0glO5ISVH7WO5s7kTU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DkqhzefHLd1AUL7MzzGV0rdFZk7oKOZEO1C/YWnVo3lD7uyzrb5YMt46jeEU1I7W4
	 +sngUdHkXtgtdZJbeUEByLISwc9gs6tTrabHxf49oigXy0D6BMY19xUNBinF01XG5k
	 Cf80hVupJA+KsATucjPizrn6Dy3FUSoacMpDW06TL/DaoVszMVUUWemeREOeZffiU3
	 EH3JSpdx/8EMrkk5bLaY2iKrea1yFQsHXsjU8DtSqZWDza9CrGjRoBKTrB5Ie29XlK
	 88o+m8XptKtNd0+CpIj0bsDvf1SJpVjPhO8a6UwZa1wodZmSnyxPTYxF9jpeujDCJI
	 qEw7l1bIb1q1A==
Message-ID: <sashiko-outbox-216555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 01/16] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
In-Reply-To: <20261116082437.66739-2-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
 <20261116082437.66739-2-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:42:53 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] asm-generic: barrier: VAL shadowing in
  smp_cond_load_relaxed_timeout()
--

commit 02ca6bf44a71704c43817e6ae9df82d53740b4ff
Author: Ankur Arora <ankur.a.arora@oracle.com>

asm-generic: barrier: Add smp_cond_load_relaxed_timeout()

This commit adds smp_cond_load_relaxed_timeout() and its helper
__smp_cond_load_relaxed_timeout() to spin-wait on a condition with a
timeout using cpu_poll_relax().

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index b99cb57dfcccc..bafc8eeff1321 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
[ ... ]
> @@ -273,6 +274,117 @@ do {									\
>  })
>  #endif
[ ... ]
> +#ifndef smp_cond_load_relaxed_timeout
> +#define __smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns,		\
> +				      timed_out)			\
> +({									\
> +	typeof(ptr) __PTR =3D (ptr);					\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
[ ... ]
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	s64 __scl_timeout_ns =3D (s64)(timeout_ns);			\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +	bool __maybe_unused __scl_timed_out =3D false;			\
> +									\
> +	if (unlikely(__scl_timeout_ns < 0))				\
> +		VAL =3D READ_ONCE(*(ptr));				\
> +	else								\
> +		VAL =3D __smp_cond_load_relaxed_timeout(ptr, cond_expr,	\
> +						      time_expr_ns,	\
> +						      __scl_timeout_ns, \
> +						      __scl_timed_out); \
> +	(typeof(*(ptr)))VAL;						\
> +})
> +#endif

[Severity: Low]
Does naming the outer temporary VAL in smp_cond_load_relaxed_timeout()
cause -Wshadow warnings when __smp_cond_load_relaxed_timeout() declares
its own VAL in the nested statement expression?

Unlike smp_cond_load_acquire(), which names its outer variable _val,
reusing VAL here shadows the outer variable on every call (breaking W=3D2
builds with CONFIG_WERROR) and also declares VAL before evaluating ptr,
which would capture any caller variable named VAL referenced in ptr.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116082437.6673=
9-1-ankur.a.arora@oracle.com?part=3D1
