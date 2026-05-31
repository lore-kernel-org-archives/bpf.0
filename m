Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EFF19CC0C;
	Sun, 31 May 2026 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780248928; cv=none; b=lZPjT9YK0qOzlXDrqljbGpiGabdTsinj1EqrWv0Rw7rE2Wyfbmu1jXhm5pbOn9l8qKuJSo2gumym+Svq/uZ6WktdW12zqdP4gimOfhgyRZ5lvdA1TtypjNhef3NROA4sH6dmnNuKR0grHXgDQf76euOu7SrR7SuSlR/G/+6QIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780248928; c=relaxed/simple;
	bh=a/dEwL8ac24i37LIrBgofaKmIgAOqkPVxlBH7dMGxqU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bksQmcQXbEfdqv0rcu1f+03KBNUZIZ0rXDAEt4wdoKZIgp7JZ4vRdEK22x9O6jGAigOra9WUnve6QjbggVf02L66O/kz8Jo53DXgSDNSkxfkcO9Gvat+c36QGEC1p5+NTdcfqEBn1tGOcSr3UQRGhEi4gCV1QlIIG/E8Z+R7hzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOOiHAkt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOOiHAkt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1582E1F00893;
	Sun, 31 May 2026 17:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780248927;
	bh=F1jakTym0iA49cj74HA9jeTrz7UbtfCnhEju0PMZGaI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JOOiHAkthUZUP4DLW0w85V10okLmCSaBcQiwumbKQcaBHaA831DtbmxFP13tsKzGN
	 F1o/FQOaLU368VcTVjM9GkuD5jn1q8YvI55PbrSJFBLyiQcdIshoSLuX+oqjN5Mxkm
	 KSbp6MlBcRiR5Fh1zFWG7Z+Gncy6oJsqNUFGAYYZSm4P8Jy8hiL9gzfUWsgRiAVBCD
	 81gnxnumIA8jnyFcMlT9eTdguLkbgiWzrMRmj8DQvvDsP8JcwMJoTwouhmmvrEy1ah
	 MuQT2LxGHSnPZk9BeIhaJoE6POzjWv03rbXSbudjYZ2l//yAkmD3VTLCGTJQq0sJPo
	 ThNbrKPJQXB4A==
Content-Type: multipart/mixed; boundary="===============6333441568920207472=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ddd42daeb0da6f6991ee725b1f6c71dc6df723b1f45f01310d791feb5029e29b@mail.kernel.org>
In-Reply-To: <20260531165852.555930-1-tj@kernel.org>
References: <20260531165852.555930-1-tj@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Overwrite scratch PTE when allocating arena pages
From: bot+bpf-ci@kernel.org
To: tj@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev
Cc: memxor@gmail.com,david@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 31 May 2026 17:35:27 +0000 (UTC)

--===============6333441568920207472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 1727503b25d8..520224dc45c9 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -157,15 +157,13 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
>
>  	if (!data)
>  		return 0;
> -	/* sanity check */
> -	if (unlikely(!pte_none(ptep_get(pte))))
> -		return -EBUSY;
>
>  	page = d->pages[d->i];
>  	/* paranoia, similar to vmap_pages_pte_range() */
>  	if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
>  		return -EINVAL;
>
> +	/* May be none or the scratch page, overwrite either way */
>  	set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
                ^^^^^^^^^^

When set_pte_at() overwrites a present PTE (the scratch page) with a
different PFN (the new real page), does the arena allocation path flush
the TLB?

The caller arena_alloc_pages() only calls flush_vmap_cache() after
apply_to_page_range(), which expands to flush_cache_vmap() (a no-op on
x86). This flushes data caches but not TLB entries.

Before this patch, apply_range_set_cb() only transitioned not-present to
present, which requires no TLB flush. But now it can transition
present(scratch) to present(real), changing the underlying PFN.

When a BPF program faults on an unallocated arena address, the
kernel-fault recovery path installs the scratch page into that PTE:

bpf_arena_handle_page_fault()
  -> apply_range_set_scratch_cb()
     -> ptep_try_set()

The faulting CPU then retries the access, loading a TLB entry that maps
the arena kern_vm address to the scratch_page PFN. This entry becomes
stale when a later arena_alloc_pages() overwrites the PTE to point to a
real page.

The arena kern_vm region is mapped in init_mm and shared across all CPUs.
Without a TLB flush, can a CPU holding a stale entry continue
reading/writing the shared scratch page instead of the new real page?

The free path in arena_free_pages() and arena_free_worker() already calls
flush_tlb_kernel_range() after clearing arena PTEs:

arena_free_pages():
    ptep_get_and_clear(...)
    flush_tlb_kernel_range(start, end);

arena_free_worker():
    apply_to_page_range(...)
    flush_tlb_kernel_range(...)

Does the alloc path need a similar flush when overwriting a present PTE?


>  	d->i++;
>  	return 0;

---

> commit 066af9e73183b42ad5ee27805163ce25053ed9bf
> Author: Tejun Heo <tj@kernel.org>
>
>     bpf: Overwrite scratch PTE when allocating arena pages
>
>     apply_range_set_cb() maps the pages for a new arena allocation. It returned
>     -EBUSY when the target PTE was already populated.
>
>     Kernel-fault recovery can leave the per-arena scratch page in an otherwise
>     unallocated arena PTE: a BPF program that touched an unallocated address
>     gets the scratch page installed there. A later bpf_arena_alloc_pages()
>     covering that page then finds the PTE populated, returns -EBUSY, and leaves
>     the scratch page in place. Every subsequent allocation of that page fails
>     the same way.
>
>     Drop the must-be-empty check so set_pte_at() installs the real page
>     unconditionally, overwriting a scratch (or empty) PTE.
>
>     Suggested-by: Alexei Starovoitov <ast@kernel.org>
>     Signed-off-by: Tejun Heo <tj@kernel.org>
>     Cc: David Hildenbrand <david@kernel.org>

This looks like a bug fix for the scratch page allocation failure.
Should this include:

  Fixes: dc11a4dba246 ("bpf: Recover arena kernel faults with scratch page")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26718992256
--===============6333441568920207472==--
