Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583504;
	b=lyqI/OTObbRBIDPjdV7xOhSLrITmpsosLjjinJM6YnNLEPLtTIbErljnmeb5zuBJN/DU
	 ymwOPUQ77zEx6Sue1jImnJ6zohW1qoxA6WyICrwYsyLPVG2RDPAflZFOFOtsvm0f0i7kF
	 wHK/++Q7uDGy2FnlfzlTDuDyhapR3karUrjGJdw3EoCXcIHMb28O5tC5uPGjjfXu8BLCM
	 HCxEzNkvxm5Kru5R/NLmV2vBldjux/jDsB2Dph86Ec/jWwdE3pzdj+1Nd4lP0hvwoXmhF
	 gPiaXP74c2DQQg5BnsAZnORB9Qjmix/++iOSHguo5iAmYwRORVvVOandsBuFUmxbEKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583504;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=NNGxMQXJMdTjnSOv10aQKb/ppFNgCMDdDlSf+doGbnI=;
	b=15AynNAzlpSVaUTQp/KUInGfrfZWylyQlsZqVKwSlFhQPRBGWO6QvH0YY2uOwj/vEH8v
	 1oPRTDHiZvM3OQ/TKkKqU7UE3sSvsDr+kKwsQKxTA660+zcvLT3EOoq0GUMTdQGPDAFQY
	 gasFPUwamr+WEhX0DqG7eAWw5ghd9WwU4xlJllfHpkwLp9xIj0w6KzW+kFV73uGdFX8Tj
	 SEmUGCeE1Og38w1QqgJK/Brkx087ScrZRfJZ5jrKkG57ExAH1jMwHx0fg/XDfqTXnATgw
	 MUsdZ0OgtSSYZccAIYuxzM5YNvnWLE3U/Hy9AT6+zASaFrXXNnncEOPHJEcws7vGOfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtG9PuG7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85868606A319;
	Wed, 21 Oct 2026 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtG9PuG7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4751F000C4;
	Wed, 21 Oct 2026 11:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583504;
	bh=NNGxMQXJMdTjnSOv10aQKb/ppFNgCMDdDlSf+doGbnI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BtG9PuG7VaGKIXkWXibhz2PCSsATBTBkEm2LrSY2Y343uHvevVYcopKMX5TehF69x
	 x1xCzOfknTAYZAaYrATXygE/jy9CLTHP2IU1xfb9pkcnd7ZXLCRQahK5ET4qBm684J
	 WNCbZVP4Ty/LLwMRjTebM0RlduZLs9vqiLLZ7NNFL0DELf1YWuzS28cx2e4lU2AVkY
	 WDRfwlh19vCdfj4IRHdbOKIgl+wEwVs5RnA6uuZWx6z1Wfhs0DoAmOPStXvqLwmECW
	 /WVwqgT+LciSEOJ941TtrzHyGviNvJ/fyPoyvFc9aTJeWGk2pr1VqLsNx7t125xZF7
	 uLBx1KbTSJYOQ==
Content-Type: multipart/mixed; boundary="===============7595896769208109114=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <13ad2d54c140d070976519eba79bb098d6c2d95b64bd8c51640b45c9972baea2@mail.kernel.org>
In-Reply-To: <20261021112437.1799213-2-zhen.ni@easystack.cn>
References: <20261021112437.1799213-2-zhen.ni@easystack.cn>
Subject: Re: [PATCH v3 1/7] mm/page_owner: extract page_owner_next_eligible() from read loop
From: bot+bpf-ci@kernel.org
To: zhen.ni@easystack.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,akpm@linux-foundation.org,vbabka@kernel.org,surenb@google.com,mhocko@suse.com,brendan.jackman@linux.dev,hannes@cmpxchg.org,ziy@nvidia.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,zhen.ni@easystack.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 11:51:43 +0000 (UTC)

--===============7595896769208109114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> mm/page_owner: extract page_owner_next_eligible() from read loop

TL;DR: The nid filter's page->flags read now happens outside the page_ext RCU
window, so it may fault on an unmapped vmemmap during memory hot-remove; later
patches fix it, so it is only a bisect window.

> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index fbbda7ba914b..92a92cdf74ec 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c

[ ... ]

> @@ -798,13 +794,45 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  			goto ext_put_continue;
>
> -		/*
> -		 * Access to page_ext->handle isn't synchronous so we should
> -		 * be careful to access it.
> +		/*
> +		 * Take a snapshot of the page_owner record inside the RCU
> +		 * window, then validate it, so that print_page_owner()
> +		 * reads the checked handle from the same snapshot.
>  		 */
> -		handle = READ_ONCE(page_owner->handle);
> -		if (!handle)
> +		scan->pfn = pfn;
> +		scan->po_snap = *page_owner;
> +
> +		if (!scan->po_snap.handle)
>  			goto ext_put_continue;
>
> +		page_ext_put(page_ext);
> +		return true;
> +
> +ext_put_continue:
> +		page_ext_put(page_ext);
> +		cond_resched();
> +	}
> +
> +	return false;
> +}

[ ... ]

> +	/* Find an allocated page */
> +	while (page_owner_next_eligible(&scan)) {
> +		struct page *page = pfn_to_page(scan.pfn);
> +
>  		if (state->nid_filter_enabled) {
>  			int nid;
>  			memdesc_flags_t page_flags = READ_ONCE(page->flags);

Can this READ_ONCE(page->flags) fault on an unmapped vmemmap?

In the parent commit the nid check ran between page_ext_get() and
page_ext_put(), so it was inside rcu_read_lock():

    page_ext = page_ext_get(page);   /* rcu_read_lock() */
    ...
    if (state->nid_filter_enabled) {
        memdesc_flags_t page_flags = READ_ONCE(page->flags);
        ...
            goto ext_put_continue;
    }
    ...
    ext_put_continue:
        page_ext_put(page_ext);      /* rcu_read_unlock() */

Now page_owner_next_eligible() calls page_ext_put() before it returns true,
and read_page_owner() reads page->flags with no RCU section, no
get_online_mems(), and no page reference held.

The RCU section mattered for memory hot-remove:

    offline_pages()
      memory_notify(MEM_OFFLINE)
        page_ext_callback()
          offline_page_ext()
            synchronize_rcu()

try_remove_memory() requires the blocks to be offline before
arch_remove_memory() -> ... -> section_deactivate() ->
depopulate_section_memmap() unmaps the vmemmap.  While a page_ext_get()
reader was active, that section's memmap could not be torn down.

After this patch, an offline plus remove can complete between page_ext_put()
and the READ_ONCE(page->flags), because synchronize_rcu() no longer waits
for this reader.  This needs CONFIG_PAGE_OWNER with page_owner=on,
CONFIG_MEMORY_HOTREMOVE, a nid filter set through page_owner_write(), and a
concurrent hot-remove of movable memory.

The commit message says "No change to the output is intended", but it does
not mention that the nid filter's struct page access moves out of the page_ext
RCU window.

For context, the parent already read struct page without a pin in
skip_buddy_pages() (PageBuddy() before page_ext_get()) and in
print_page_owner() (page->flags, pageblock flags and page->memcg_data after
page_ext_put()), so this widens an existing race rather than adding a new
class of problem.  It does turn one protected access into an unprotected
one, though.

This is fixed later in the series, so it is only a bisect window issue:

- 915f86c7862f ("mm/page_owner: protect page access with mem-hotplug read
  lock") re-resolves the page in read_page_owner() with pfn_to_online_page()
  under get_online_mems() before the nid check.

- 2cf991a93cbd ("mm/page_owner: record the NUMA node in the scan cursor")
  moves the nid computation back into page_owner_next_eligible(), "to avoid
  dereferencing a possibly-unmapped page".

Could the nid be read in page_owner_next_eligible() before page_ext_put(),
for example by storing it in the cursor?  Alternatively, could the
mem-hotplug protection patch be reordered ahead of this one?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39593164040
--===============7595896769208109114==--
