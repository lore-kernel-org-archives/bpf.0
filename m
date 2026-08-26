Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3428471CF8;
	Wed, 26 Aug 2026 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766919; cv=none; b=hexfX84h2OsCfNcOR556BZjRKNarGUvXvhuiki/h8JJowP6Gp0Yuef0GVswyfLRA7hJgOfdwG/FoJv5mGqRKWen4ENRXlCqkb+1pYCq6dN/7EH/rkt+mrThoGRE1vvtXJc9S1O4EGxbcYwPSmalbBYVTbTtNxg71XQGRpQRxbRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766919; c=relaxed/simple;
	bh=eWF20d/kLnpGt8uKR0O11FUEjgn3jjhUNhbGdLe/oZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbhmNSew8kQqshpb8/0e9a9PbbVe/tT/5IkFpsTwKqrc6vFaQD5xJuMzc7m/xWC393SjdZt7UcrY4iP7m3+7usB8Uf36h1rb9RkrSwlT48fKcOt+UBRUAAdeS512gYeN+9zdyj2WOqBY64nzypj6QtyL7Qhk1e1ykUMgxcUPwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=a6QD1hq/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j8c5MrpY; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="a6QD1hq/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j8c5MrpY"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id BB4CC13801D2;
	Wed, 26 Aug 2026 13:54:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 26 Aug 2026 13:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787766895; x=
	1787774095; bh=2bQByG0NGolsz8+a6PRUigbbsxEl5vWItJfVtq1Eax8=; b=a
	6QD1hq/hDLGcIi5UhcC8fZVJV/gg+lWo8Em4IgTDR0QqN0IFXBZHnw62SBzTRGxV
	+BCXpEVn54j4vZgW5s7oIDF/qun739IiHKx4mmfBJ7gjHzTA5sriBSbA7QavTHow
	lbcG7uQI9Cf2yN5vJjccrhVCfAtCPKHexiQili8X8eqhJY/owteJfkS2Mgn9CkS7
	PbjxDtnXu5SwWQhfOaFJxizWrGCXgoIuA+3o5aCZlcMiKq5cQHR8S5D2jJHt4TAb
	Uir06Hh8cTG73q9hTyWrS+cEX+dOA7ZAP9mobgm0e0ygOuSloW9CGt86gIGx/8zx
	SFbuNTPprs4o7y98T6UMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787766895; x=1787774095; bh=2bQByG0NGolsz8+a6PRUigbbsxEl5vWItJf
	Vtq1Eax8=; b=j8c5MrpYkaqkl0y05FNftCCFN2zIidZN/4k7tL3rELlkn0UeNv+
	eU4synikzCN9gL6KHsMGmdJ0X2dP0L0Khyalpxw8bLLPhHRs7CzMYxiPzXJdbwxY
	7LQ5LHCp6IamFhd1yYIz0nKrcMnGPSgCxbN41bqmWvNuFvwCdJtdUtK3mijnZQvU
	SqpfmK7mlY2b4i4MIzPLsi/wmhpMir8sAkhn9qs4TOn1lrQOwx2/jfRgEUmRVnV7
	GlXr3SZj6ejLjzCY31s2fgt0xdEcE38sBh0ybtc4iABad0Ss/u3WDSTzBHpx8j6H
	T3Fyu2AoyqgsGRhfKoUmwCtLG8wBkOFHYVg==
X-ME-Sender: <xms:biiPahpqMiPoDTkSxn218jcRh5GhsiXyaxrk3k2eVZxyp6g4JEGdMQ>
    <xme:biiPakEB1cI24gXsaAJ_ZTvF-iR4MgqqPruof3AH0tMG6mjMFTF9efu54mSMqrTuG
    Tox9m1P8Zz67ab5u2UoaGwT_78CHgDZ3Do6O2WGe0632DyC9oCJz5w>
X-ME-Received: <xmr:biiPavqEIIZA3npLSdQJk2IUboUKAaoLN4_vlPIF-MBQxF5VcrfseZA_UEQ>
X-ME-Proxy-Cause: dmFkZTE6xZzK4A32bGUNNPYnXM0UvfGGyn54u86/PwxKoHJcBoHd78FUBKy/v2DPmHJkl9
    z6yymj3dgIgVeStR7UbyVaUs+utRXUnAqYgVFAhnt52kgJZEi5ZQgcbmim5s3+aY6iT7hg
    RAzAXVXWBht8ryRB6o+Lm8WKU9830vEgS4QrvXQDSZi6bLXBuRR0KKNBpTFcUXCXrjZf+a
    SYib5WegN0Asn3j7LrTnbRG94rtanX/000SZQL7VLgr9r2NQkvxXVuBgkwL92yEkOLWxvc
    cWIu/MmaWbAfrHScydQFgzQcAAnuRtF1hgbqCpkqHznEpAuInIfxdkRyZO2Ae1fd3UQ/Jr
    Cv1D/cLBTQpEj9o/s0GrlLzWhnIWSM58LvFdoPhPalweAxhzVh8BJ22krLoJCfutihSKJF
    GtMyiEPEUikdd0udZaidPol5a9WPHZSgEABZEoxgnZX9ABVuBM1xrQsDc+Udjd/eM96Dx1
    xDPv9RvuGgpBfytZrjPZsaDWtNM4mJWYM7yAM5ukQJTadCGdAjjhiniqu9hxesSC+5Jkrq
    pa1niqNodDK4GOP566sFWLhT+/FKYr/w7WLX18J2IkmO9s0LzXZwUnm3+0tDws689cMwpu
    X/HVN05EaQY31jI8yA/Yvt2PRIfY4cGz7MZ8GP+0Tbzp/R6d7/3oFRyWMjnA
X-ME-Proxy: <xmx:biiPas5hdOI-hAWkJUBnpREq4LcAl_d0ZAJoDDQiBj_yPYtQTc5_IA>
    <xmx:biiPagQl5NLN6RnDvd52CuARJrrjrPd2VvT5dWIZo2gqhL2pTkmJsw>
    <xmx:biiPas6VoCR-shXK5WEbAb6YKiT_rfDZLbVwe_gPYXJbR0Q4ZTzpbA>
    <xmx:biiPai3vXJc0NvPk6-ISHeblxTysiG54VfQheJefcZY4zfRdtcJkaA>
    <xmx:byiPaoiTxPpmjY5QptMidWSgn1kC-CQECCM_aoaGoy_kZjwTPTydQRu0>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 13:54:53 -0400 (EDT)
Date: Wed, 26 Aug 2026 18:54:52 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Lance Yang <lance.yang@linux.dev>
Cc: hughd@google.com, akpm@linux-foundation.org, david@kernel.org, 
	ljs@kernel.org, nico.pache@linux.dev, baolin.wang@linux.alibaba.com, 
	baohua@kernel.org, dev.jain@arm.com, liam@infradead.org, mhocko@suse.com, 
	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com, 
	usama.arif@linux.dev, vbabka@kernel.org, ziy@nvidia.com, usama.anjum@arm.com, 
	agordeev@linux.ibm.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jannh@google.com, willy@infradead.org, pfalcato@suse.de, 
	rostedt@goodmis.org, mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH 19/57] mm/collapse: install a PMD leaf as the
 terminal layer
Message-ID: <ao8jHveJqHegERGF@thinkstation>
References: <20260816224609.308019-20-kirill@shutemov.name>
 <20260825122354.98021-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825122354.98021-1-lance.yang@linux.dev>

On Tue, Aug 25, 2026 at 08:23:54PM +0800, Lance Yang wrote:
> >The detached one is not: GUP-fast and RCU pte walks that read the old PMD
> >may still be inside it, and on broadcast-TLBI architectures the flush
> >expels nobody.  Quiescing it would need an IPI, which has nowhere to go
> >here -- outside the pmd lock it opens the pmd_none() window this design
> >does not have, inside it is a broadcast under a spinlock.  So the
> >detached table goes to pte_free_defer(), which holds the free until those
> >walkers finish.  One transient table page per PMD collapse is the cost.
> 
> Well, git history spells out why pmdp_get_lockless_sync() is needed here.

One more good catch, thanks!

> Could we keep pmdp_get_lockless_sync() right after pmdp_collapse_flush(),
> before map_anon_folio_pmd_nopf() (and while the locks are still held)?

Yes, I will put pmdp_get_lockless_sync() there.

Here's what I got to my tree:

      /*
       * Nothing fallible sits past here.  No anon_vma_lock_write either: rmap
       * walks on the sources are unreachable -- refcounts frozen, folio locks
       * held from freeze to putback -- non-rmap pte walkers see migration
       * entries, pmd-level observers see the old table or the leaf and never an
       * intermediate, and fork, mremap and munmap take a write lock where the
       * round holds a read lock.
       *
       * The flush inside pmdp_collapse_flush() is the round's second over this
       * range: the freeze displaced every leaf here and flushed before dropping
       * the ptl, and the verify above proved nothing has been mapped since.
       * What it covers is the paging-structure caches -- a CPU may still hold
       * the pmd-to-table link, for a table that is about to be freed -- which
       * is why the helper shoots down a pte range rather than a pmd.
       *
       * If pmd_t is too wide to load in one access, a lockless walker reads
       * it half at a time.  Such a walker holds interrupts off, so an
       * interrupt between two present values is what keeps it from assembling
       * halves of both; the flush above does not always send one.
       * pmdp_get_lockless_sync() does, and is an empty inline wherever the
       * entry loads atomically.
       */
      old_pmd = pmdp_collapse_flush(vma, cand->addr, pmd);
      pmdp_get_lockless_sync();
      old_table = pmd_pgtable(old_pmd);

      /*
       * The smp_wmb() in __folio_mark_uptodate() orders the copied data before
       * the install below publishes it.
       */
      __folio_mark_uptodate(cand->new_folio);

      /*
       * Deposit a freshly allocated table, not the one just detached: a
       * deposited table has to be quiescent, because whoever withdraws it frees
       * it immediately (zap_huge_pmd()) with nothing to hold a lockless walker
       * off first.  A table that has never been reachable is quiescent by
       * construction, which is why collapse_alloc() secured one.
       *
       * The detached table is not quiescent.  GUP-fast and RCU pte walks that
       * read the old PMD before pmdp_collapse_flush() may still be inside it,
       * and on broadcast-TLBI arches that flush expels nobody.  Quiescing it
       * would take an IPI in a pmd_none window, which this design does not
       * have.  So the table goes to pte_free_defer(), which holds the free
       * until those walkers finish, as retract_page_tables() does.  One
       * transient table page per PMD collapse is what that costs.
       */
      pgtable_trans_huge_deposit(mm, pmd, cand->deposit);
      map_anon_folio_pmd_nopf(cand->new_folio, pmd, vma, cand->addr);

Any objections?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
