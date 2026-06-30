Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D293ED3B3
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812905; cv=none; b=UVlOB5QuxX2LCINH+Xi/I1muRqym72sqPzm2Y6uQ0IqYtxXUcSy0xVT5d2fHc+V89YMTpatlHLCGoHYE2LFhubDGlHg4+x4hoig/voHrBzSs8mYeEo4AdajVGmhxBLhFVfIwMIEJvGTzXzRUh3ireP+32Q2dkHyijQyV17rhHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812905; c=relaxed/simple;
	bh=SBrsYnp8nWmUIkU9WJP8Nl8H+TnO/nxtNfDvbbFwjqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZSnzdYwWhPOKSvxe+n7+aXEw9YMJy30vOEvkhDAIVk7ZN8C0SIkJMQEiin7UvC/UynBsswLDX/CPPTGy+w1J8MO+ABDxH5wZGzzK47KZHPMgt8oQ18iMtDkanNal0TwBxbcJ6BwOv9ie0FwIpFWii7OWOrtgBl+TZxS0Yilj5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM+1jwHX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM+1jwHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897BD1F00A3D;
	Tue, 30 Jun 2026 09:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782812904;
	bh=9lHoOdeiBXFiVyC2J1edLTFPMx92pr/EwYNXje33gcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NM+1jwHXt184rV/Fd9k8VhXl2K4DrTjjSzjohiq7UU4ZZzvouTIbBVPDkpizrohCZ
	 kGKZbvkMHmZ7x3awmJNLOc3z5lOzeXEx4o1VtDwyx0wWjv62IlylNG+4x9gl6RYJsl
	 YPDZ/bq7SH/BzEHtTams8DGJdtW06eW8m3csSTvK58B2b/cVLKnuMcW3Yf+cg8ObvG
	 QxHkGHFvtNKWLx5b9nImw+z5G387F4Pvl3tvy1+T+hwijMR8K0vti8pBe15VDKWUp/
	 KYwDFOcCp6gMWcmC2PXJsrJ6rKtA1vZuHt5aAr5mp48UevVIJPE75p5c8IEivDyseT
	 +agd1NNlljusQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] bpf: Fix smp_processor_id() call trace for
 preemptible kernels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Edward Adam Davis" <eadavis@qq.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_45066D89AD6EF9AED34CA567FA46CA52C606@qq.com>
References: <20260630084910.D5C3A1F000E9@smtp.kernel.org>
 <tencent_45066D89AD6EF9AED34CA567FA46CA52C606@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:48:23 +0000
Message-Id: <20260630094823.897BD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch addresses the syzbot warning at the wrong layer by addin=
g `get_cpu()`/`put_cpu()` inside the BPF memory allocator. This masks the c=
aller's missing migration protection while leaving sibling allocator APIs v=
ulnerable to the exact same crash.
--

commit 231004c76441ce47022b6f1dabd04453961dcac4
Author: Edward Adam Davis <eadavis@qq.com>

bpf: Fix smp_processor_id() call trace for preemptible kernels

This patch wraps unit_free_rcu() with get_cpu() and put_cpu() in
bpf_mem_cache_free_rcu() to avoid a preemption warning.

Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dfd7e415d891073b83e1f

> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index e9662db7198fe..8f91f2b3848ff 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -951,7 +951,9 @@ void notrace bpf_mem_cache_free_rcu(struct bpf_mem_al=
loc *ma, void *ptr)
>  	if (!ptr)
>  		return;
> =20

[Severity: High]
Does this fix the issue at the right layer? By adding the preemption
protection here, it masks the fact that the caller is running with migration
enabled, which leaves sibling APIs vulnerable.

For example, in __rhtab_map_lookup_and_delete_batch() in
kernel/bpf/hashtab.c, the batch loop iterates and calls rhtab_delete_elem()
without disabling migration.

If the map elements contain special fields (like BPF_KPTR),
rhtab_delete_elem() will first call rhtab_check_and_free_fields(), which
eventually calls bpf_mem_free().

Since bpf_mem_free() also uses this_cpu_ptr() without get_cpu() protection:

kernel/bpf/memalloc.c:bpf_mem_free() {
    ...
    unit_free(this_cpu_ptr(ma->caches)->cache + idx, ptr);
    ...
}

Will this result in the exact same BUG being triggered on that path? Should
the missing migration protection be added to
__rhtab_map_lookup_and_delete_batch() instead of modifying the allocator
here?

> +	get_cpu();
>  	unit_free_rcu(this_cpu_ptr(ma->cache), ptr);
> +	put_cpu();
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_45066D89AD6=
EF9AED34CA567FA46CA52C606@qq.com?part=3D1
