Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320778F3A
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 03:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789960586; cv=none; b=DHrkyl6yZos2aKFjFZFIPnuUroH3dtvuwriJyuUg7zPW6klTDx88YOpl/QKQrFeuTxlyB9/aMjiwd2ZME0E79VYPHxKEGDfW3XQnHPx88bzN3qXpfu+9ewnyYIA7ed9zzjYnvCaYhs5j9K56U0fECj7Q5tEk8uHleOfOcNfMgNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789960586; c=relaxed/simple;
	bh=yVzdfYnJIPhS2PlAo3JND4J3PQ2TCqi+Lg4ebPkKhBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dHa6TmIVkwFaq/mNdAgDTDKwIyXQROyH0b6pwtxUeQyHpLDRNxxbKQWVVB5bw2GGfAKeizfBBBnclAQVPnd+0MvNnrGa0XGAYasELXMb8gdHMUqtDekHEVlaH2wlctcmlfFC/cL3AhcYfiOuDSAR61WycSDgSg9w6Rgaikx6SDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbZcGdoQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbZcGdoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866B31F000FF;
	Mon, 21 Sep 2026 03:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789960584;
	bh=6IrRfgsLqeBOJYPTGVtPNQIrXDLTLCDqZMo0pHjsISg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EbZcGdoQhqr/19HgMwI4X4Z8o5DUROjTXQbTW/UiiB+/27KtX4dpHvdf3VbADpyhE
	 0dNrQvIOln4fKbcsJt/Kj8TZ6NyZWXkQRV49Y59A+/7YEPNW+ZEXOC+OgYNF8hqdv2
	 cnSNNO+sQqxIAiT/MUrmMwp9uAksHDZQ7fP7J2AeB6pX0sga1ipawMXSseLovWZn5P
	 cPPvRtAer2eBadLn4sdQA7VWIDs8NEJ4D8X3vE5VeF9ORMpTrAroH6sQj3eC5VNCKq
	 2PQNuU07aJwfmCVtPFMzazRr53YWZWSjXHhk98cGw/mz5d8Iqd/2cXmjX8EGn3DD/0
	 naBQV/it3MWzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13] mm/bpf: Add bpf_proactive_reclaim kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921030854.17858-1-hui.zhu@linux.dev>
References: <20260921030854.17858-1-hui.zhu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 03:16:24 +0000
Message-Id: <20260921031624.866B31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/bpf: anonymous swappiness enum is omitted from BTF
--

commit 1eb287ed1b56fa630faef31e3bfc3e5da668a9da
Author: Hui Zhu <zhuhui@kylinos.cn>

mm/bpf: Add bpf_proactive_reclaim kfunc

This commit adds the bpf_proactive_reclaim() kfunc to allow BPF programs
to proactively reclaim memory from a memory cgroup. It also converts
swappiness macros into an enum with the stated goal of emitting them into
BTF for use by BPF programs via vmlinux.h.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d76477..d8f579c285600 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory cgro=
up
> + * @memcg: the target memory cgroup to reclaim from.
> + * @size: the amount of memory to reclaim, in bytes, clamped to
> + *        MEMCG_CHARGE_BATCH.
> + * @swappiness: the reclaim swappiness, in the range [MIN_SWAPPINESS,
> + *              MAX_SWAPPINESS], or one of the special modes: -1 to use
> + *              the memcg's own swappiness, or SWAPPINESS_ANON_ONLY to
> + *              reclaim only anon folios.
> + *
> + * Performs one proactive reclaim pass on @memcg, like a write to
> + * memory.reclaim but without retrying until @size is reached. Call it
> + * repeatedly to reclaim more than one batch.
> + *
> + * Only available to BPF_PROG_TYPE_SYSCALL, because other sleepable prog=
rams
> + * may run with filesystem locks held, which the reclaim path can deadlo=
ck
> + * on via filesystem shrinkers.
> + *
> + * Return: The amount of memory reclaimed, in bytes, or a negative error.
> + */
> +__bpf_kfunc long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> +				       unsigned long size,
> +				       int swappiness)

[Severity: Medium]
Since the function signature uses int swappiness instead of an enum type,
will the compiler ever reference the newly added enum?

Without a reference in the signature, the enum is treated as purely internal
to the compilation unit and disconnected from the kfunc.

> +{
> +	unsigned long nr_reclaimed;
> +	unsigned long nr_pages;
> +
> +	if (swappiness !=3D -1 && swappiness !=3D SWAPPINESS_ANON_ONLY) {
> +		if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
> +			return -EINVAL;
> +	}

[ ... ]

> diff --git a/mm/internal.h b/mm/internal.h
> index 0434dfcfc36f1..4d426663ddd81 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h

[ ... ]

>  #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
>  #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
> -#define MIN_SWAPPINESS 0
> -#define MAX_SWAPPINESS 200
> +enum {
> +	MIN_SWAPPINESS =3D 0,
> +	MAX_SWAPPINESS =3D 200,
> =20
> -/* Just reclaim from anon folios in proactive memory reclaim */
> -#define SWAPPINESS_ANON_ONLY (MAX_SWAPPINESS + 1)
> +	/* Just reclaim from anon folios in proactive memory reclaim */
> +	SWAPPINESS_ANON_ONLY =3D MAX_SWAPPINESS + 1,
> +};

[Severity: Medium]
The commit message states these are converted to an enum so that they are
emitted into BTF. Because this is an anonymous enum that isn't used to type
any variable or function argument, will it actually be preserved in DWARF/B=
TF?

It appears pahole omits completely unreferenced anonymous enums, meaning
these constants will not be emitted into vmlinux.h as intended.

Could we give this enum a name and use it in the bpf_proactive_reclaim()
signature to ensure it gets generated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921030854.1785=
8-1-hui.zhu@linux.dev?part=3D1
