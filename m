Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB9133065C
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320883; cv=none; b=LHb8mV0EdA6nwwEgvkr5vhwKy3LWAZOHhz+KUEWLP41RTehx3wYblorTxoWJcVgNotgK59UHVZ0h4IWjG7NVs0qvupM2By/fDCnmjHMN2iaP2lhmpMduqvu5IgVRhF3Iky6+bziA142kW5YcUuMa16U59aeTkjwiLFn+CLMCFnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320883; c=relaxed/simple;
	bh=DcVwa/TaXFFqdaXeeMv2S017RzmWKaG1HXVD3QY8cFc=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QHxYOIiH/DAvvprwV5ztFzCmxOO9qIcfN2d/tgm2UlYZE29VzmvNa0igw+JIo7zBDWymokLMTIRZd67mp3hv9Ni7I7LiYQMgCOwdAjo4lvgqSRXpmHfUTKEbO5e1hMZsXaVFEo5jD0m2Q8ol9x9YfEav+sZgVov8ewCG7ISx450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szPCm5qA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szPCm5qA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A0AC19425
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777320882;
	bh=DcVwa/TaXFFqdaXeeMv2S017RzmWKaG1HXVD3QY8cFc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date:From;
	b=szPCm5qAlfpFUaHTI90Id8+5SRNgAgIbRcNbRaB2ac4JIJYiFSd2318FsavSGkEJS
	 vYHkICqaNQNdtYWF8pysZEPS/VaQDQ4T4Z6UXguBGvOSeXpYP/SVh0CtdfCYpZmLl5
	 uoVYSGHcTVUwW4flLBEGmFzOuhPz4nUjKGR8iiVH72W7dkanfHC4UQ/8cbVW09ekGs
	 6X8SmzAekD6x6Tk4edLhUDpZ19vB3z9LY/IDGH5c4FY+ZsL0a4k0P9KuxHtV966SuV
	 cV+2zhZ61AmweF/YzGlijEB/B99k7Zwn7L2LiJxmc9THdExv9x0Cyz2Z3U5BK5LXnD
	 t/y6c8ma9Z2oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] bpf: arena: use page_ref_count() instead of
 page_mapped() in arena_free_pages()
Reply-To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org>
References: <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 20:14:41 +0000
Message-Id: <20260427201442.97A0AC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Replacing `page_mapped()` with `page_ref_count() > 1` removes =
the synchronous mapcount check, allowing the lockless `zap_pages()` page ta=
ble walk to execute concurrently with `free_pgtables()` during `munmap()`, =
leading to a page table use-after-free.
- [Medium] The patch incorrectly uses a lifetime counter (`page_ref_count`)=
 as a semantic indicator to determine if a page is mapped in user space, vi=
olating MM guidelines.
--

commit 7d590c0af75e613441c8863162be310388ecc992
Author: David Hildenbrand (Arm) <david@kernel.org>

bpf: arena: use page_ref_count() instead of page_mapped() in arena_free_pag=
es()

This commit changes the heuristic in arena_free_pages() to use
page_ref_count(page) > 1 instead of page_mapped() to determine whether
to call zap_pages(). This avoids mapcount usage as pages will not have
a mapcount in the future.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 802656c6fd3c..608c55c260bc 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -729,7 +729,7 @@ static void arena_free_pages(struct bpf_arena *arena,=
 long uaddr, long page_cnt,
> =20
>  	llist_for_each_safe(pos, t, __llist_del_all(&free_pages)) {
>  		page =3D llist_entry(pos, struct page, pcp_llist);
> -		if (page_cnt =3D=3D 1 && page_mapped(page)) /* mapped by some user pro=
cess */
> +		if (page_cnt =3D=3D 1 && page_ref_count(page) > 1) /* maybe mapped by =
user space */

Can this lead to a page table use-after-free during concurrent munmap()?

zap_pages() iterates over arena->vma_list and walks user page tables lockle=
ssly.
During a concurrent munmap(), unmap_region() executes unmap_vmas() (which d=
rops
mapcounts), free_pgtables() (which unlinks and frees page tables), and fina=
lly
tlb_finish_mmu() (which drops the batched page refcounts via mmu_gather).

The VMA is only removed from arena->vma_list later during arena_vm_close(),
meaning it is still visible to zap_pages() during free_pgtables().

Since mmu_gather retains the page reference until tlb_finish_mmu(),
page_ref_count(page) > 1 will remain true during free_pgtables().

With the old page_mapped() check, it would correctly evaluate to false beca=
use
unmap_vmas() had already dropped the mapcount to 0. It appears this change
could allow zap_pages() to walk page tables while they are actively being f=
reed.
This could also be forced by artificially inflating the refcount using GUP =
pins.

Also, does this use of page_ref_count() conflict with the MM guideline that
refcount should be treated as a lifetime counter rather than a semantic
indicator?=20

Speculative references (like GUP pins or page_idle) can transiently inflate
the refcount independently of user space mappings.

>  			/* Optimization for the common case of page_cnt=3D=3D1:
>  			 * If page wasn't mapped into some user vma there
>  			 * is no need to call zap_pages which is slow. When

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427-page_mappe=
d-v1-0-e89c3592c74c@kernel.org?part=3D2
