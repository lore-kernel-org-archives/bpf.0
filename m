Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2C53F39DD
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652712; cv=none; b=qDR6HtP97cvazSJVWtqWLIrs8y+OtjNMbqWZ+g3v4Ywi2FN1X232iVvwfNNpNIp11/2eKWzOUh2gUc2lhL+rELFe3Y0JjvxRmLVk7omZgBVmdm1abjCTkyJDRoW6gG9u+6GOxKxgFSFngr1YNq7pBztizLM8sXl89EDaYc253z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652712; c=relaxed/simple;
	bh=W19ZITm3IzDaC5FXxy2nrBHB/SmZMM25p1NfcScWc5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QzUcKrLTpXv54svycnWYn+Np9fdvkZRFEpb/BxyKhhue3IwVkgemn0ZJgE9N4YHP2HEm12TXWbiTwdvh0sSOt9aSNEFCd4eE3ke/kfZtKl7G22PnReZr9za3Jptmxs/5eDYScaSdrN5bEjNG20Jh9gR4uD1RuEJ7OblLJyOWOV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckiGDbj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckiGDbj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A4C1F000E9;
	Tue, 25 Aug 2026 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787652711;
	bh=zbsB/pHZlLF+ulctIpFIUMt9Wzablcks6W5aD9RDO8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ckiGDbj5JuKYrH3coiUnR9ToRXLhv5U1tclX5KqdWvJokcvY4krDLETeJOaYAEG/8
	 K/Y+kqLcftD+TZBI2LqOQoQbY6GqyhyQb/FzVSSE+smVT9gdz2ZtP1PIx510ShOm6H
	 gnt4tDNsf6B5r8U1qb3VZsxkL4Ri8EkhShNpFxB52IXjWXeqdFdUKsTSVCYZIJ7GZa
	 3aRh1WuJzaKM2/2frbxNxxWxPYp2IRBjmYb0nL3g52cFGMNbwvSar+TwFsvM5VNWGu
	 xX/R9hrvZfNs/cWVSBYi0GA8ajMS/6M2gCX7+YymGbvTKDuPnwTyzWPrBMYepxnToA
	 B28lApHSxDXVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 1/4] bpf: Add a sleepable page allocator for
 map memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Khawar Ahemad" <ahemadkhawar123@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260825094955.83240-2-ahemadkhawar123@gmail.com>
References: <20260825094955.83240-1-ahemadkhawar123@gmail.com>
 <20260825094955.83240-2-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:11:50 +0000
Message-Id: <20260825101151.21A4C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Pages allocated via `__bpf_alloc_page()` in non-sleepable cont=
exts are not zeroed, leading to a critical information leak. When `can_allo=
c_pages()` is false (e.g., in BPF programs running inside a BPF spinlock wh=
ere IRQs are disabled, or under the spinlock in `arena_vm_fault`), the allo=
cator falls back to `alloc_pages_nolock(__GFP_ACCOUNT, nid, 0)`. Because `_=
_GFP_ZERO` is omitted and the page is never manually cleared, uninitialized=
 physical memory is returned and subsequently mapped into the BPF arena. Us=
er space can then read this uninitialized kernel memory. (Note: The origina=
lly provided concern regarding missing dcache flushes on cache-aliasing arc=
hitectures is a false positive because BPF arenas are only supported on har=
dware-coherent PIPT architectures like x86_64, arm64, riscv64, etc., via `b=
pf_jit_supports_arena()`).
--

--- Patch [1]: [PATCH bpf-next v6 1/4] bpf: Add a sleepable page allocator =
for map memory ---
commit 49db9a147d01ab11180f1f75062c2ee24918b7a4
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: Add a sleepable page allocator for map memory
   =20
This commit adds bpf_map_alloc_page_sleepable() for callers that are known =
to
be in a sleepable context. It allows them to use the normal blocking alloca=
tor
which can reclaim memory and engage the OOM machinery.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -602,15 +602,14 @@ static bool can_alloc_pages(void)
>  		!IS_ENABLED(CONFIG_PREEMPT_RT);
>  }
> =20
> +#define BPF_PAGE_GFP (GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT | __GFP_NO=
WARN)
> +
>  static struct page *__bpf_alloc_page(int nid)
>  {
>  	if (!can_alloc_pages())
>  		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);

[Severity: Critical]
This is a pre-existing issue, but does missing __GFP_ZERO here cause an
information leak?

When can_alloc_pages() evaluates to false (e.g., in BPF programs running
inside a BPF spinlock where IRQs are disabled, or under the spinlock in
arena_vm_fault), the allocator falls back to alloc_pages_nolock() without
zeroing the page.=20

Because this uninitialized kernel memory can subsequently be mapped into the
BPF arena, user space could read it.

> -	return alloc_pages_node(nid,
> -				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
> -				| __GFP_NOWARN,
> -				0);
> +	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825094955.8324=
0-1-ahemadkhawar123@gmail.com?part=3D1
