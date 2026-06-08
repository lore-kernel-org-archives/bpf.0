Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BFA3E7BCA
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931471; cv=none; b=HJs3LMhqX6mHYEJd+5O67DPnhUZwqW/7FnuUPSxjp3I9lrctjGD7CjhECWZvWUeX5w/9sfvTEP75UHwRevT3A5A4WJu6ZQmsQw340+CnFgm4blQ25xMKNU4KdcoQR1JM9C5IhS/7+DEYzVYa/SupBmk1jW/h9ove96cwOgWrqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931471; c=relaxed/simple;
	bh=esqEcT6dCMPEA9qubbqCfAjxBDsaVuJbMCm9RiX+no0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X8MVjrUaZcKqir+/DbMXGPuXtO6qli7lV+Lll8EPlZl0bXKw/znwyl6dxZyNcCTq6pnpR1XF1N9aly81F6dVm6yshAz0b0rmCFV7xGKSLkJNTr1mQLOGDeYyVIcTP1Z7uBEqg9KM3WppWNbDJqazg7AK3ki587cK0cpw6DoxUtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtR38CRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtR38CRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A701F00893;
	Mon,  8 Jun 2026 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931470;
	bh=al0TBRuE6aj4B/+craPiTs7pl7E/zIz69622If/uPj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gtR38CRpTywiX3h86i2PfzHOGZPeL8uNxwJpoZCwH15qBWgZssKPErXxhMdHHvSiS
	 riyeDuBw4EkToQS+K5doyJxPv3AmiBYsUQ+1wowDkqquLQFXZ4ZYAEPdWauRg8VZ33
	 BybIVLq+BV6HDekOInPJXX5WOmZhHDJ5nb0sqv+vIxv595EGF38OKQu48EI2c5HheZ
	 18FLoq6S+k5TGB+lZlcpMKyKbrTVifq/PcjfyL6+BAbzzqcxzFlmivcukbSrdZNLRK
	 JuEGgxJ4efURJ49uLJdUoBAyUEFR6qan7N+DnmssMlTN0UHA9iygKYgthVI0z0SqVE
	 Trh8U50LNXDtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 5/9] bpftool: Generate skeleton for global
 percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608145113.65857-6-leon.hwang@linux.dev>
References: <20260608145113.65857-6-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:11:09 +0000
Message-Id: <20260608151109.D0A701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Exposing `.percpu` maps via `skel->percpu` in generated skeletons =
introduces severe abstraction violations: silent write failures in Light Sk=
eletons and stale data reads in Subskeletons.
--

commit 8d5ae684c03b8ed70309315b60b9b65b471e24bd
Author: Leon Hwang <leon.hwang@linux.dev>

bpftool: Generate skeleton for global percpu data

This patch enhances bpftool to generate skeletons that properly handle glob=
al
percpu variables. The generated skeleton includes a dedicated nested struct=
ure
for percpu data, allowing easier initialization.

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 6ae7262ebe0c1..e0c5c643fe9ea 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[ ... ]

> @@ -263,13 +268,12 @@ static bool is_mmapable_map(const struct bpf_map *m=
ap, char *buf, size_t sz)
>  		return true;
>  	}
> =20
> -	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMA=
PABLE))
> -		return false;
> -
> -	if (!get_map_ident(map, buf, sz))
> -		return false;
> +	if (bpf_map__is_internal(map) &&
> +	    ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) || bpf_map_is_percpu_da=
ta(map)) &&
> +	    get_map_ident(map, buf, sz))
> +		return true;
> =20
> -	return true;
> +	return false;
>  }

[Severity: High]
Does forcibly treating the percpu maps as mmapable here break subskeletons?

Since subskeletons operate on an already-loaded BPF object to read or write
live state, this change might cause do_subskeleton() to export pointers to
disconnected user-space memory.

If they point to the disconnected PROT_READ initialization buffer instead of
live state, would reads always return stale initial data and fail to reflect
live kernel modifications?

[ ... ]

> @@ -847,7 +851,7 @@ static int gen_trace(struct bpf_object *obj, const ch=
ar *obj_name, const char *h
>  	bpf_object__for_each_map(map, obj) {
>  		const char *mmap_flags;
> =20
> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
> +		if (!is_mmapable_map(map, ident, sizeof(ident)) || bpf_map_is_percpu_d=
ata(map))
>  			continue;
> =20
>  		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)

[Severity: High]
Does skipping map finalization for percpu maps in light skeletons leave the
user-space initialization buffer mapped as PROT_READ | PROT_WRITE?

In standard skeletons managed by libbpf, the buffer is protected with
PROT_READ to explicitly crash on invalid writes.

If we skip finalization here in gen_trace(), it seems writes to lskel->perc=
pu
after load() might silently succeed without actually updating the kernel ma=
p.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145113.6585=
7-1-leon.hwang@linux.dev?part=3D5
