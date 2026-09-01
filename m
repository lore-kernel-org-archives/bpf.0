Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352FD3C4B63
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273391; cv=none; b=qcXy1LOklC8P4mjoRc5swljUZlMUzUX4GAoO7NKaSEp3bkIEBRe1jpsbCH1+DtHU6i/lYzZ1ZADLVv+Bw1Qd8CCSgrFjRUAasnk8jwk9dYtdz19ExyCz15mB5x9+nXAbx2v+QNhBsjj0/q6zwO1yXY0a4kswmmuiwK0AXGtlO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273391; c=relaxed/simple;
	bh=MN+4GVjs190XtoBO1nncnXjbg7K7rNDNNcRlNhyEnEs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=de92JwfprByT5zs4Bdh0fh2N0SUFWY8jPCSAwx7u2hCMhLNOQp+zyOjpae/6zaxF6HYKuqnZB9cJxOGF9F6by1pahMqxdMCNgbUHiMli6zuzyQ4iiKN15VTlzTvIiwjkCCaFsEAKHZ3VHKvUOsZZG9MpaADJJAa3h+aUwdpSy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk1h6WZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk1h6WZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64601F000E9;
	Tue,  1 Sep 2026 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273389;
	bh=tY8Cj/VJSrRqh3XaZTQtXYgdqbzcyVZLc7exBsKIqBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hk1h6WZxgfu+ht5PKaoABFtYJ4owBkTLsUOgnks135oeZN94CAfVulkd45eBxYYlW
	 fnnVL16SwUiQH9eTta/vYUzkSaXWEm8ZSlyd5tUtA1TKhkMFhTicoKf9dk40Ad7xCz
	 DVY/EzoY0Qsz2chfFl662VzEhVTsmAnFOhU80SznJ6llNwqMb1o32rMTjeD6A/1vxR
	 YyTJdm2wNIH6icywktAJXJfVlYIhhSH1YsRNmAw9Z7lW5iupfMTFsyqyf3wPR97naj
	 xIHh63YP6sbGW0fUDQOjYjRVCi1NXZm2uKkRJF9HGf2SJSt9xcUpPsqKNig2xlCPDo
	 dMUjX6tG/5pCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/bpf: Fix map_lookup_percpu_elem on sparse CPU
 IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260901141954.29449-1-suchitkarunakaran@gmail.com>
References: <20260901141954.29449-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 14:36:29 +0000
Message-Id: <20260901143629.A64601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The BPF helper bpf_map_lookup_percpu_elem and its map-specific imp=
lementations do not verify that the requested CPU is a possible CPU, allowi=
ng out-of-bounds kernel memory reads. The patch exposes this preexisting ke=
rnel bug by changing the test to loop over `nr_cpu_ids` and call the helper=
 on non-possible CPUs, leading to arbitrary memory reads and test failures.
--

commit c6b22dcf947502ea445cd52bb9052f6450168c31
Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>

selftests/bpf: Fix map_lookup_percpu_elem on sparse CPU IDs

This commit updates the map_lookup_percpu_elem selftest to handle sparse CPU
topologies by reading the possible CPU mask and explicitly iterating up to
nr_cpu_ids instead of the total count of possible CPUs.

> diff --git a/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_ele=
m.c b/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
> index ca827b1092daa..d8da0696b97cf 100644
> --- a/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
> +++ b/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c

[ ... ]

> @@ -57,17 +57,17 @@ int sysenter_getuid(const void *ctx)
> =20
>  	map_ctx.map =3D &percpu_array_map;
>  	map_ctx.sum =3D 0;
> -	bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
> +	bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0);

[Severity: High]
This is a pre-existing issue, but does changing this loop to iterate up to
nr_cpu_ids expose a kernel bug on sparse topologies?

When the BPF program loops over non-possible CPU IDs, it passes them into
bpf_map_lookup_percpu_elem(). The map-specific lookup implementations, such
as percpu_array_map_lookup_percpu_elem() in kernel/bpf/arraymap.c and the
hash map equivalents in kernel/bpf/hashtab.c, check if the CPU exceeds
nr_cpu_ids, but they do not verify if the CPU is actually possible:

kernel/bpf/arraymap.c:percpu_array_map_lookup_percpu_elem() {
    ...
    if (cpu >=3D nr_cpu_ids)
        return NULL;
    ...
}

Without a cpu_possible(cpu) check, passing a non-possible CPU ID causes the
kernel helper to retrieve an unmapped base pointer.=20

When read_percpu_elem_callback() receives this pointer, it expects a NULL
return for non-possible CPUs. Instead, it gets a valid-looking pointer to
unmapped memory. Can dereferencing this pointer crash the kernel?

Should the kernel helpers be updated to validate cpu_possible() before the
selftest is modified to intentionally trigger this path?

>  	percpu_array_elem_sum =3D map_ctx.sum;
> =20
>  	map_ctx.map =3D &percpu_hash_map;
>  	map_ctx.sum =3D 0;
> -	bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
> +	bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0);
>  	percpu_hash_elem_sum =3D map_ctx.sum;
> =20
>  	map_ctx.map =3D &percpu_lru_hash_map;
>  	map_ctx.sum =3D 0;
> -	bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
> +	bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0);
>  	percpu_lru_hash_elem_sum =3D map_ctx.sum;
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901141954.2944=
9-1-suchitkarunakaran@gmail.com?part=3D1
