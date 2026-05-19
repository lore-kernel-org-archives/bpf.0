Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B293ED13B
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229512; cv=none; b=tYS8+wl4PmDbPHsa1LYnN38gISzXB9ogGcwLZ9DcgmiFAce3i4uuKyvyZrg1aQuwwPAKQN8OBNotsmXTJ+JaGUb0AYBVWT16+CNCqkbAWIaGN+hPw0F8UA8SkN6fhUK1uoPNFciZwllXIb5M/DlkxVrCn3SGUO9biY3jjd6vXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229512; c=relaxed/simple;
	bh=+xxu/cEjBz+R6W/62pm9vB6QgH2Ix002rnkkyEDX2Es=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iQN/WceFg3GPgB44wdtS9jkch4dY4dgg8UvE13it5PZJwBStSPMZ2qWrO5TV6vZt4yeAL8OGJeh95fdoI70tJlF0iC+tMN0CM73mOf9Z4vBoTy/4bSZpKgQYMdaAps+I2umvUaIcoTp43v7nPbjhna2Esa0si7qq5VheIyb2hXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSU7Xon3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSU7Xon3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A6F1F00893;
	Tue, 19 May 2026 22:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229511;
	bh=KigcglvqYM6V3AizExJR18J7NtF+53y304wn3Zctb+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WSU7Xon3hetmF86ubJEMN0erNcELOfPa/YYdNQ2M7g/d4yezFGpNUwNW/uuHY7L57
	 UviorbXvdPXpfp30KYpZf66yT+eUtPNTJ3P2gzF8qMo5OhUOaBa6k8nYfZZb2oFlkb
	 CErLbgS1nddfDRidJajrJG0qfGwM7paHYoz+R45JJbQLDSeFpRiIQvSQn8WBPMX2cq
	 gX8oY9rXV6bSB86D7KkJGLHA0cc74lBuvm1qgN93pkXDZPkAqYmh/JSZWsWaSYED/o
	 WPB9VAVEdoN1VKDF7WFm1RiOccJQnHukRUY9sWhRp49bcVllS/4GPtJOeG9wJl83Db
	 Or6UdVFz5jlfw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 03/12] bpf: Add bpf_struct_ops accessor
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Martin KaFai Lau" <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519215841.2984970-4-martin.lau@linux.dev>
References: <20260519215841.2984970-4-martin.lau@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 22:25:10 +0000
Message-Id: <20260519222511.75A6F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added bpf_struct_ops_kdata_map_id() function is an exact,=
 redundant duplicate of the existing bpf_struct_ops_id() function.
--

commit 4987adf60416fed4393443ee95dc6549cf2cfba0
Author: Martin KaFai Lau <martin.lau@kernel.org>

bpf: Add bpf_struct_ops accessor helpers

This commit adds several new helper functions, including
bpf_struct_ops_kdata_map_id(), to access bpf_struct_ops fields. It also
refactors the link update validation to allow reuse in the upcoming
cgroup attachment changes.

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 28eab24ef0ed0..8650a3b88bf6a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -1199,7 +1199,33 @@ u32 bpf_struct_ops_id(const void *kdata)
>  }
>  EXPORT_SYMBOL_GPL(bpf_struct_ops_id);
> =20
[ ... ]
> +u32 bpf_struct_ops_kdata_map_id(void *kdata)
> +{
> +	struct bpf_struct_ops_value *kvalue =3D
> +		container_of(kdata, struct bpf_struct_ops_value, data);
> +	struct bpf_struct_ops_map *st_map =3D
> +		container_of(kvalue, struct bpf_struct_ops_map, kvalue);
> +
> +	return st_map->map.id;
> +}

[Severity: Low]
Is there a specific reason this new function is needed when the existing
bpf_struct_ops_id() already provides this exact functionality?

Looking at the code just above this addition, bpf_struct_ops_id()
performs the identical mapping and returns the identical field:

u32 bpf_struct_ops_id(const void *kdata)
{
	struct bpf_struct_ops_value *kvalue;
	struct bpf_struct_ops_map *st_map;

	kvalue =3D container_of(kdata, struct bpf_struct_ops_value, data);
	st_map =3D container_of(kvalue, struct bpf_struct_ops_map, kvalue);

	return st_map->map.id;
}

Since C allows implicit conversion from void * to const void *, could the
upcoming caller just reuse bpf_struct_ops_id() directly? If a stub is
needed for when CONFIG_NET is disabled, perhaps a static inline fallback
for bpf_struct_ops_id() could be added to include/linux/bpf.h instead of
duplicating the implementation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519215841.2984=
970-1-martin.lau@linux.dev?part=3D3
