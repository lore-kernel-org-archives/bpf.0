Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710B547070
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707739; cv=none; b=aDI1FUFiP8eJm0cjUuICdhStDtALes5kQURsXWbcVQEtRE8ex3NAM6POMvDZTh1FOxskVKVj0wpYGUw+jWun7r+2kYji7O9ZeooIf/TnJ8XcI+S6J6IiTIExOLAMbsM9yr/+K9fsHr/Qwnmwo/+G2UQJ04QSnKFvUqubGjbLc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707739; c=relaxed/simple;
	bh=2uJ/KmdYnoFHA7ntJ16mjGyCL9R9/jL9XoJnV2T4cSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HB6ewVQBheABbH8xcsq99YodF8dLdumoHY9Euc3lLA5G0MLV/ytMdLPLwNHXrvwv90DhIGhqaRxi/RipbaeqGDtjY8HGi+8ZBxNGWXOEW3lj+ldr7V/Eh4FSH1M2G6AzCgLzp7JtauWNi+OziTZ/ugWedlgzrtzUI7r5jpghn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN7h/Zr6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN7h/Zr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599711F000FF;
	Fri, 18 Sep 2026 05:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789707737;
	bh=HL85/5TcjYdC1njx0DAXIl4VIJz6GaPFS5RV8BjSvqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NN7h/Zr61PxNU/MtRuGL7pkrOfvDFpQSkOTh3+EawqSmKEfWe87OxhsRBNq9LT/qp
	 GN1N0cprdezwL/C70X/g6/dQNM86MAA0ZLNDgwrHVHjnk/Gliudn6kzKM3CwUIjX3F
	 JugDJItUQ3mqdX1YIeJZ9J2Z+QA15et3OgCH5tZbFhkyMmQmF4zz8cHHSQ1qIuPywe
	 6Uxw1ufQDWmHaqpH9OxPSZBN8k09/a/H9vNvXkk9dcfMFIxfduEX9YCatJRua70VXz
	 g4txT1wvc2kZ1vqRPbtcnVkJZTLMHj1ck8uYLPxDV/xqEn0lOg5MlIj0zi/TSI7rQX
	 +S6MXYLQTvRnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 16/20] libbpf: Carry the exception cleanup
 table through the light skeleton
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918044322.3292575-1-yonghong.song@linux.dev>
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044322.3292575-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 05:02:16 +0000
Message-Id: <20260918050217.599711F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] libbpf: integer overflow in cleanup_info_tot_sz leads to heap OOB =
read/write
--

commit b9300a1f6022da2aa8b343e05882b46e9f329c64
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Carry the exception cleanup table through the light skeleton

This patch modifies the light skeleton generation to carry the exception
cleanup table (cleanup_info), similar to func_info and line_info. It updates
bpf_gen__prog_load() to allocate space for the records, set up union bpf_at=
tr,
and perform endianness swapping for cross-compiled cases.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index af3a04f161ac1..2345fbdd46f56 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
[ ... ]
> @@ -998,6 +1000,9 @@ static void info_blob_bswap(struct bpf_gen *gen, int=
 func_info, int line_info,
> =20
>  	for (i =3D 0; i < gen->core_relo_cnt; i++)
>  		bpf_core_relo_bswap(cr++);
> +
> +	for (i =3D 0; i < load_attr->cleanup_info_cnt; i++)
> +		bpf_cleanup_info_bswap(ci++);

[Severity: High]
Could this loop result in an out-of-bounds heap read and write?

If an attacker crafts a BPF ELF object with an extremely large .bpf_cleanup
section, load_attr->cleanup_info_cnt can be very large. If the allocation
size calculated in bpf_gen__prog_load() overflowed, this loop will process
hundreds of millions of elements in an undersized buffer.

This could cause memory corruption when cross-compiling (gen->swapped_endian
is true).

>  }
> =20
>  void bpf_gen__prog_load(struct bpf_gen *gen,
> @@ -1011,8 +1016,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
>  			       load_attr->line_info_rec_size;
>  	int core_relo_tot_sz =3D gen->core_relo_cnt *
>  			       sizeof(struct bpf_core_relo);
> +	int cleanup_info_tot_sz =3D load_attr->cleanup_info_cnt *
> +				  load_attr->cleanup_info_rec_size;

[Severity: High]
Does this unbounded 32-bit integer multiplication risk an overflow?

If load_attr->cleanup_info_cnt is excessively large, multiplying it by
cleanup_info_rec_size could wrap around modulo 2^32 to a small positive
integer. This would result in add_data() allocating an undersized heap
buffer for the cleanup info blob.

Combined with the loop in info_blob_bswap(), this could lead to crashes
or potentially arbitrary code execution when processing untrusted files
using the light skeleton generator.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918044156.3283=
973-1-yonghong.song@linux.dev?part=3D16
