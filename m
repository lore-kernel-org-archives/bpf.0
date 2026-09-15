Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437042AF86
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489716; cv=none; b=ViYLF9pjIYQ96b7JdXu9DVS4NXVpSX23fdLp295jywgCST92tNCgnpouyHzzdcYrCz3LYZzymcRqWfF9JX8HIq5BTo/G3bZ0ngTGlWZbs0gfscQtha/aBvGJ0MlErwmWRlr2YmjsbEp823pBhYREk35nEc4/1viSp5w2zUODw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489716; c=relaxed/simple;
	bh=Ysx6fI+jAhYSdjF8TjNIhefuyDDkUzXmNvD1IKb3ZPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CepRqcgwuNZnfZaXBFzP+KJTFM7QxjH1Gu1lQYETze4uhDKgEs4q7UAFLKj6tQcN/Pvva7vrOP4Vx0GLE7F4T6einz2+WjvLhGw1mY7Dn1KA3t3EzWQ6GS6Fjp/Q79/QtWRN13T+aeZ/TcFl1jgD/gW6/Hjgwr47C0l50yQvay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dstw3gRc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dstw3gRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B751F000FF;
	Tue, 15 Sep 2026 16:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789489715;
	bh=aosPcYTFnGwj+vozy2BORrvSGqO9tgXoTJZve+R25wg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dstw3gRcbEwUJuBcVjQWUly5XM1oN827GtCcIWugLcSiO02ifX1TNBczSEYBPX5gp
	 hvc9R6n6qO9Jkm+qoZjDrjzJ1zYkNh0QdmLCLIDfXz9L2SJpHpOP8Q4Tu23LQjo7ao
	 EfX2q9SgHgl+7a3nUKxMENjsa7+IpdJdgS5XpsKiqDRrsJeh4BPswAP2JwU0f8uu2A
	 DOGt9OsrTRk3Smn+pO2QllykwrdIxiY900ZEaCmHScK2ltdlqfKThNHFtqdOcj19KL
	 T6ZFnze5l1a7W1BA+ZpKNuDMGl7fgjazvBD+DaobS6rQdR7Q5qZd7Jmkr7Y67Ceyyv
	 FFXebrRQOqgOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3] bpftool: Compute map size of light
 skeletons at runtime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260915161450.96249-1-leon.hwang@linux.dev>
References: <20260915161450.96249-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:28:34 +0000
Message-Id: <20260915162834.E2B751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: compilation failure in skel_internal.h due to non-standard rou=
ndup macro
--

commit cf9410def9715a95832e67f7002ebd4dabf2d7ad
Author: Leon Hwang <leon.hwang@linux.dev>

bpftool: Compute map size of light skeletons at runtime

This commit addresses an issue with generating light skeletons on
a host with a different page size from the target. It accomplishes
this by passing the original map dimensions and dynamically computing
the mmap size at runtime.

> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> index 1f3f332dffbe9..9e16b8e8cb7c9 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
[ ... ]
> @@ -193,25 +197,39 @@ static inline void skel_free(void *p)
>  	free(p);
>  }
> =20
> -static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
> +static inline size_t skel_map_mmap_sz(size_t val_sz, __u32 max_entries)
>  {
> -	munmap(p, sz);
> +	const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> +	size_t mmap_sz;
> +
> +	mmap_sz =3D roundup(val_sz, 8) * max_entries;
> +	mmap_sz =3D roundup(mmap_sz, page_sz);

[Severity: Low]
Does this code rely on the non-standard roundup macro from <sys/param.h>?

When users include the generated light skeleton header in a project compiled
with strict C standards (e.g., -std=3Dc99 or -std=3Dc11) without _DEFAULT_S=
OURCE
or _GNU_SOURCE, the roundup macro might not be defined. This can cause a
compilation error due to an implicit declaration of function.

> +	return mmap_sz;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915161450.9624=
9-1-leon.hwang@linux.dev?part=3D1
