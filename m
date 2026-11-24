Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501287;
	b=gJMuBCciHG4WhRk6d2pZBozGNwXsBuEBbS7n8C20uTVUMELiAFQxAZipgMHNTntlYmGy
	 WLSNNpYT2qw/U89q7P94L/95qwpFSU3PJa7g5z71Eqd2uCefD5EbdQ16/JEjdxAV1qmF5
	 nOUsywOm05I3M3RHCnxr5vOJlstpXH0hk5BRHl7nttCBPwMicP15wc/FwLZf8jyhovEPS
	 hcm8q+l9TIHIqC6MMN6ZPJRjMqlF/V+4otXxDAeqwxY+o11Uj8nxYWaSgHGvUMkKDKd+/
	 PZLQ54kEmDHRmmzitL64l0GchvEq3qFQC5ThalqTkFpi/TujOQVBM+GsP02Ku4CZLJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501287;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9AGZtx0jRV4khbBwWkO0hN479mXwbq0I9ucT5HkGwEE=;
	b=kZzO0KLQiJDLThTANUGEuTvI80dzkOzeVAMed1qvVCmevUxqUglc5iLGaHigU7cInUHu
	 LzUF/CNBqFsDaVrZ+e5WN+q9j3EGlxYclxd56qfU7vyVQpZ1NzHlcUHQGQu2Z8lS+3CKQ
	 QxlFQNKuwX0vSlsUg95ArRRR1f4jYZrhO1NQNw5RwtCWSuTZxC0f9ERNoZok6IMQ4dMfg
	 x8pihQZv+PWsCdjB9ydGDV+Tp/2wHMznbP6aKfyoCMRJYcXQAXA4AnqB7KiF71iMDBMfm
	 F0VcSnevOMRaAMsnTxGyyCJg31vMAG1VmgVdxCzf2PFNGbD3+LsA9ihPdrwYUYRizgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z6u8/1U0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95466606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6u8/1U0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FF21F000C4;
	Tue, 24 Nov 2026 06:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795501287;
	bh=9AGZtx0jRV4khbBwWkO0hN479mXwbq0I9ucT5HkGwEE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Z6u8/1U0zQL1EkqkpKSooI6UARIc7A6ER8dSf+OJGyADZ6JOg8NHEEUlXl76iZjB5
	 zE9tS7JR7w3B6a6LxtKmKlhlDoRzJlvVJj1LfqqNn+uXZipgZ2q41Qj6ETuMOK06rh
	 IbzhtZ5vb/347/FBeFhLomlOqgMDVdm9vM1peEHkFOuSqYjZvlGLTrDvri0fcsOp0n
	 M/CS1IhZ9uRqtADIEXa2AppXpybUhBM+ChrTK9IYpWwDJy5vatRhXAVGPu2dJ8UmbP
	 nc+GcW3POhH2Zdk/Cud45b8hJgTRviX2rJ4clEd/7aUFoZUGr3DkGPj5xmA/nsZWBr
	 Q2/Ok9mGX849w==
Message-ID: <sashiko-outbox-230586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261124060357.11700-2-emil@etsalapatis.com>
References: <20261124060357.11700-1-emil@etsalapatis.com>
 <20261124060357.11700-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 06:21:26 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] bpf: missing dcache flush in __bpf_alloc_page() [1]
--

commit 761d9aaa5b4ddd842253567eefeb0a2ef78a0aa0
Author: Emil Tsalapatis <emil@etsalapatis.com>

bpf: Add call for selecting kmalloc or kmalloc_nolock at call time

This commit adds bpf_map_kmalloc_maylock() to attempt a non-sleeping
kmalloc() when spinning is safe before falling back to kmalloc_nolock(),
and switches BPF local storage allocations to use it.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ec8e787929112..4c72b05e11eb0 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -627,5 +627,5 @@ void *bpf_map_kmalloc_maylock(const struct bpf_map *m=
ap, size_t size, gfp_t flag
>  struct page *bpf_alloc_page(int nid, bool sleepable)
>  {
> -	if (!sleepable || !can_alloc_pages())
> +	if (!sleepable || !can_spin_in_alloc())
>  		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
> =20

[Severity: Critical]
This problem wasn't introduced by this patch, but does bpf_alloc_page()
miss a dcache flush on cache-aliasing architectures [1]?

Both alloc_pages_nolock() and alloc_pages_node(..., __GFP_ZERO, ...) zero
the page through the kernel linear mapping, leaving the zeroed lines in
the CPU data cache without flushing them to main memory.  When user space
subsequently mmaps the BPF map or arena page at an aliasing virtual
address, the CPU can bypass those dirty cache lines and read stale data
from physical memory, disclosing uninitialized kernel memory to user
space.

[1] https://sashiko.dev/#/bug/linux-f9f23bef-4238-4cdc-90e6-85c0f416ca5b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124060357.1170=
0-1-emil@etsalapatis.com?part=3D1
