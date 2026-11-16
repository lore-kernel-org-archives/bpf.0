Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818959;
	b=LxB+cZyi+Fos/E2cmPm55qekTB+vubpR64sXjP2xAqE1qon5GowuQQVCx7cGIrPojQYd
	 cDrSBkALJp6pOWyAojNUdqksnIteI0cRnDHm89MQ9XrIaw7JKMTMOFlW8dPV1Ju57QBTv
	 72YkGFhid2zxQ2bJCtPrWxAojsFEMqjR7uh0G3m0I/n2+aYixGwqOJiM5v7fK8EqfUvVB
	 O32d6oLRZgPaLHdSGz7K67qOrazCTbQA3FJY1ktcAw2Lrd0ZupXw1FVVyEwbpyDb8cgJ3
	 y+yyXL1dnCRLDRtFXTLF06pKF9GMUh9SweMjuk9eql61GuOFe0ujq1JW7ldMLFnqV5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818959;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hnbuqwmr0A2P9VRwKK4OoUKdKMsipLDCPIoemKhSJ6M=;
	b=PuY4kM1IXK7Ixc0W1qzj7jGtsZdeybcLjFshxwnfWq9AR0uxHvm/Rz9I5DnJyLxKLGjF
	 y9p0lKHAg612F/mgiLB1ITob7OcVa4xN/E7aiNWAS9MIBL7Bl8zPZf6zHZvwMLi5kWN2b
	 byKI8q3U1SYiTlLFlXdmyyqFWSBaLo2QVar5AMjWVEKfl6GQAeULn3g9QWLaej4o/X1Za
	 kotAJENfhl0NRBH2lcRZ4sM595To9fAoCIqBVGLTi0agpR249T4rRyRfzPKsDdBE5ovEc
	 vfS7/HHV09SSjfs7VdTBzaVF5Qky9RusY/IBPuRI6VHUX8V6dvafuWAI7oNGx7ygdyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDYh+Hq6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E0B606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDYh+Hq6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56251F000C6;
	Mon, 16 Nov 2026 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794818958;
	bh=Hnbuqwmr0A2P9VRwKK4OoUKdKMsipLDCPIoemKhSJ6M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DDYh+Hq618gFqrIcnGF1Yra1NDcs44dOrQDPl12acBXmJaA9O+y9oJ1p5NK8V56Iw
	 YdfKKNIpYPbreppyLLTENWaF5aScThhGDHct/1/QWR/FASZVzmPIlptcBPfw5r6LYH
	 8DbTdd869+qeaGan0xNif1m1S+ULSW3J0pm+8ndLb0ysCcH+Cbuyk34pxUQ2h8GiLJ
	 e3sqJBu4yopCZhqxRPnDSxWcmHjfLIJ5PNXzMhpPMqWghKNqCotEzc/9ZgBhqIO3wW
	 +NTEAb5mhvIgtsVQNIcHcvkWuqaK+9VwCps2mhlSWHc6I+y0bek+w5jwPUKvNXhWHd
	 wOeBr2dQLzlOw==
Message-ID: <sashiko-outbox-216566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 07/16] atomic: Add atomic_cond_read_*_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
In-Reply-To: <20261116082437.66739-8-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
 <20261116082437.66739-8-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:49:18 +0000
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
- [Low] Documentation/atomic_t: inaccurate non-atomic_t and conditional
  store text
--

commit d324a5d412956ca2cd74e953ba1e9d33ac409b28
Author: Ankur Arora <ankur.a.arora@oracle.com>

atomic: Add atomic_cond_read_*_timeout()

This commit adds atomic_cond_read_{acquire,relaxed}_timeout() and
atomic64_cond_read_{acquire,relaxed}_timeout() wrappers around the
smp_cond_load_*_timeout() helpers, and documents the conditional read
interfaces in Documentation/atomic_t.txt.

> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index bee3b1bca9a7b..0e53f6ccb5580 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -16,6 +16,10 @@ Non-RMW ops:
>    atomic_read(), atomic_set()
>    atomic_read_acquire(), atomic_set_release()
> =20
> +Non-RMW, non-atomic_t ops:
> +
> +  atomic_cond_read_{relaxed,acquire}()
> +  atomic_cond_read_{relaxed,acquire}_timeout()
> =20
>  RMW atomic operations:
> =20
> @@ -79,11 +83,11 @@ SEMANTICS
> =20
>  Non-RMW ops:
> =20
> -The non-RMW ops are (typically) regular LOADs and STOREs and are canonic=
ally
> -implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
> -smp_store_release() respectively. Therefore, if you find yourself only u=
sing
> -the Non-RMW operations of atomic_t, you do not in fact need atomic_t at =
all
> -and are doing it wrong.
> +The non-RMW ops are (typically) regular, or conditional LOADs and STOREs=
 and
> +are canonically implemented using READ_ONCE(), WRITE_ONCE(),
> +smp_load_acquire() and smp_store_release() respectively. Therefore, if y=
ou
> +find yourself only using the Non-RMW operations of atomic_t, you do not =
in
> +fact need atomic_t at all and are doing it wrong.

[Severity: Low]
Are these two documentation updates accurate?

First, atomic_cond_read_{relaxed,acquire}() and
atomic_cond_read_{relaxed,acquire}_timeout() take an atomic_t pointer and
dereference &(v)->counter, so labeling them "non-atomic_t ops" seems
misleading (the underlying non-atomic_t primitives are
smp_cond_load_{relaxed,acquire}() and
smp_cond_load_{relaxed,acquire}_timeout()).

Second, in the semantics paragraph, there are no conditional non-RMW store
operations, and inserting "or conditional" breaks the "respectively" mapping
between the four regular non-RMW operations and READ_ONCE(), WRITE_ONCE(),
smp_load_acquire(), and smp_store_release() while omitting
smp_cond_load_*().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116082437.6673=
9-1-ankur.a.arora@oracle.com?part=3D7
