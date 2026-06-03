Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD03E5A2D
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512407; cv=none; b=sZeUiBSvV5kONtceUX74kjL0mNPlhcoI9L0hPEgEW5X64lD80ev/sAl9ujIJ8d3cAugl6Q0OgfRUPWnq4g/rS+biGpASTGkReNFUHbUHBOtvYP+A7mfOzkhv7vy+8YkJ4rdSXx5LlBPU3TSK6bRMmQlUYQob3Sgq5UNErAEpFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512407; c=relaxed/simple;
	bh=YEx9lqxd+jPlI/dgqekSi50qmuQssyRiPKCgxAh4u2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A4EM//X3vCTv0dS/QsovT+xGGIIRK1809Cn4qIZKt8My2gnjGzeohUIz8KhpUIiorVC5rykGfqROLxz5JJ5X4TX/k+bU0z/CDoATFZvmltTuT0ePSEBHNe7krhzfC5Mia8dVcJkPF0Xz0ErL24xiTZ91KZAJhMNYJpB6NrVM26Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5Vd5Efc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5Vd5Efc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABD41F00893;
	Wed,  3 Jun 2026 18:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780512406;
	bh=URtBiKjNZH92F/c8828G6DGGiWPsEFIs7yka9bnCE3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5Vd5EfcHfFlYqcDnS78YA1euubppHAdHsitgbvYteTDyuDUuS22n169G/6tby1Rk
	 oOx9agEi802qTK2rJERM4plli7UZL/PO1okhXP30tw6Kz8lVLiHV7Pa5uoNV+E7ZuE
	 RFSrqdDo9C2DTJCNuk6HFnKfMY0iNBetlV7CsbzcSdiSJZ/P19ZqeDdI6rXT5D06KL
	 NrDkZ/i7K2QGb78N5Ui/ODFSjGe+cubJ/QKSHeFj5qXNyr6O9frnzOUKYa1zKdXW/y
	 eq9jvzC5gl0uor5/CLHu8PNEifNTorp+FVvDDvEu670SB2D3XIGlnLkm+A0Igq5KJ9
	 dhotsit9AdVlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: libarena: Add spmc queue
 data structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603182727.3922-3-emil@etsalapatis.com>
References: <20260603182727.3922-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 18:46:45 +0000
Message-Id: <20260603184646.5ABD41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Duplicate pops occur in spmc_owned_remove.
--

commit 32e23022b6cf8e4bb5da76036f824fc171bf9e71
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add spmc queue data structure

Expand libarena with a single producer multiple consumer deque data
structure. This is a single producer, multiple consumer lockless structure
that permits efficient work stealing. The structure is a Lev-Chase queue,
so it is lock-free and wait-free.

> diff --git a/tools/testing/selftests/bpf/libarena/src/spmc.bpf.c b/tools/=
testing/selftests/bpf/libarena/src/spmc.bpf.c
> new file mode 100644
> index 0000000000000..7fd7b18a03732
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/spmc.bpf.c
[ ... ]
> +__weak
> +int spmc_owned_remove(struct spmc __arena *spmc, u64 *val)
> +{
> +	volatile struct spmc_arr __arena *arr;
> +	int ret =3D 0;
> +	ssize_t sz;
> +	u64 value;
> +	u64 b, t;
> +
> +	if (unlikely(!spmc || !val))
> +		return -EINVAL;
> +
> +	b =3D smp_load_acquire(&spmc->bottom) - 1;
> +	t =3D smp_load_acquire(&spmc->top);
> +	arr =3D READ_ONCE(spmc->cur);
> +
> +	smp_store_release(&spmc->bottom, b);

[Severity: Medium]
Could this ordering result in duplicate pops?

Because top is read before bottom is updated here, could stealers erroneous=
ly
consume the same item as the owner? In a standard Chase-Lev queue, storing
bottom before evaluating top, separated by a full memory barrier, is requir=
ed
to avoid this race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603182727.3922=
-1-emil@etsalapatis.com?part=3D2
