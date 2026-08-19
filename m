Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335ED225788;
	Wed, 19 Aug 2026 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163289; cv=none; b=YohnYBEzFeFC0VWkeC/N6mr6GOIA1yaLjuPxVN+UePi34DMnn6dkMCxtlhPXuukdBEKXIqwbzUlt5Gu+S7dMh7mPvuiKvmESmhd2oUMhHCqOGke/FRqaDLJQ6U9MZkCSI4cph8utCAggcyYzQK6Obq7vjHVxqC1vQfj31MYzIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163289; c=relaxed/simple;
	bh=gjFtSccLOGS1+r1ci4HlxIQmE6ZdwiNyXLFHb55WxwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqRyTFJK2Mav4ETUwf52cwZBc1j4TIUl5Oncz9kq7lh7YnS28H7TIbLPjxOopI9C5j/l5DkOVVi9wFcpo+GItQIrP2PmBchH9e+JMRMhVcB8FQMg7W7nONU5RjsqkdN0wP1e0BNr5DjXfjYdjWHGTziBcqWDeg9UgodIyJjsUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=KLvABCmf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mo3J/+IF; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="KLvABCmf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mo3J/+IF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id D391813001C8;
	Wed, 19 Aug 2026 14:14:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Aug 2026 14:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1787163285; x=
	1787170485; bh=BVme79hoRkiBw6t4eEj//pl1ufr9k9eJh/jdgu6CPqs=; b=K
	LvABCmfdZwikDsZYs/PabPcmwBqWBSQFpqOmBS1YgoUR68HQ3MVvg4XUWQpc7qBw
	89Z/ySzitX9CArnyEB2lorlzROAzUqOcFpcbvZVUl9/8aKK+0HhhtUxTuE+4f621
	OqzE77WfMmdfWyUBiCZQVxK1o/Y4rBmOB7x3ckrct3l+i+/o3QgpxgvpSAlvdTxq
	5NGzgRSzxEXioxoGIHPt/BxW3z92kil7TxtH+Ollw02iub7dpdMEX0OFZ3IFARGe
	fW5gv05D3BqggceAolnLf2zfov4uu/rL4bWbp6H0fEMNnuOilc1y3CWQXuJgt3fG
	imNffzSDwziChB9zwClaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787163285; x=1787170485; bh=BVme79hoRkiBw6t4eEj//pl1ufr9k9eJh/j
	dgu6CPqs=; b=Mo3J/+IFlVLLNNdJtnPKlg+u48kgqwnmCXzgORlsGtApYLjBlEr
	3MkI24ee8dV40HeBoa2ZbOnmp6nNOODGI6CrkQKhUwM3SVShChm7a1NAFeZ0dBSI
	yPCdzssPM5lfF/MGIEfOGt7ATJvQboc5/qzYLMCkV+StGzopQrf4/8K5aDK+JhAU
	WFN9Vd592jxxziDbZySr9iOT17gN0NqTV4fEKbiQCIEhGg4C3aW3kKgaFoDYHXqh
	kC0pfaIoKgdyn5B6oJoA4T1taQfChapV7YE3qoqhRoXW59WAGJAKVSwFxS3koAvf
	OQ1aXI5mClDS+2IE+gvWl5Yg47njKvJDGGQ==
X-ME-Sender: <xms:lPKFaqLvez6cyGk72IH_PL-Ng8lRfiHPXlF-Gkv0E2MDV4jK0J8eBw>
    <xme:lPKFaikMe3iGe7HLKIc5aDS4kX9Vks0eQF2LFQJqvPQI3C0Bfp4a-qmTlhBV727Xp
    bNrpkFyPE8GujlKe0VOKv8sMebzt86wxgq9SsVMqnr_oVg0Kf050KQ>
X-ME-Received: <xmr:lPKFasKZf0n8wV2nkh0Olplme-EwXxid4y133wZyB2y7nnTqH6XgH4UcPKA>
X-ME-Proxy-Cause: dmFkZTEAtFenU/LIphu3Pm49APH73zcxjrAh2+DT4lFCFbZt96OaIx4ArNaVHowyzXvVYq
    W9xIIWcgbmtY3cjbSg/G2Y0T8WiYG5K6kc2ogcT1loTWpIezio7q0XuH2d/9UQmNT4K6A0
    0pN7iv0uM0ugmuDBqeHdLUS0qJmciBjJUha6nFw5DI6EhAz6fiASPyDmKpU5uZpRJg3hbh
    Shv7Ge2QX7/OVC4F5vijUSC7W9rEnGk6DMkPJ4Q23BjQco4fQNkMPH9H/lSgdBZEYofptL
    F/oVyFzuZ2aM7moWyI+T/hY0fFE9E3s9gQO4+ik03UGpXnO7FrgCh6nj/ueW5pe+kcnBqA
    pqGhMD+WLbggTIO06gXYj0sz4WHSevh5yMn/bimQn/YZcLcxOpT26WcnTZjbPCPZjpb6yq
    E3vHGwI1syn/uasT2tyhaUF2Ynyj2ecS0RGUe6Rl8mPPu8i1tlznxN+ZWrsQIseFcFP96F
    7/IwIUZN/XQCl2Yf3XxxiJ8rUkXbUW4vJZtEJpODZVUpsoABguaUgkO2PGt8EB5ZYQAiKK
    knm3LVtaiot6Sm+b/eztEGXipoYfKvAa86UxdKwvemuGNIll5br7W0yaH9RhMUoEJWDbOS
    igazw5XGsdwgchQFhdlAQC1BAimZUr2MUaw+IZ+S4Er1pAGj9Zz119IfhsxA
X-ME-Proxy: <xmx:lfKFavbq-xYQLNHEf0FGKGjyBhhY4GRzsQd5rGkjkXP1sUr7-Bb9QQ>
    <xmx:lfKFagx7sxZ6lmILtDIYG9cx2LdbFyG7nGRwVtJpAGTiqjraO7jJeQ>
    <xmx:lfKFajZnk4rX6I_xKUN-mGgwTce1WnrKVkfwtrrs9fxykpufCiHT6w>
    <xmx:lfKFanWIw2NrfuC4qkcIJ-hakJgyWTTyW0GehHJJwnVZaIcttTZpUQ>
    <xmx:lfKFarC8AemfcCfiABb6bq09GyoMNAcE-K7_lW3mEEThY0EAGwt1sIEs>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 14:14:44 -0400 (EDT)
Date: Wed, 19 Aug 2026 19:14:42 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>, 
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, nico.pache@linux.dev, 
	baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com, hughd@google.com, 
	lance.yang@linux.dev, liam@infradead.org, mhocko@suse.com, rppt@kernel.org, 
	ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com, usama.arif@linux.dev, 
	vbabka@kernel.org, ziy@nvidia.com, usama.anjum@arm.com, agordeev@linux.ibm.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jannh@google.com, willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 00/57] mm/collapse: rebuild collapse on migration
 primitives
Message-ID: <aoXxkVQJle4Qdl_9@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <aoLAly-oL2OAa4n8@lucifer>
 <aoLkMUtmzRVuv2Hx@thinkstation>
 <99138bda-55ba-4c58-9b79-b76e9daecdde@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99138bda-55ba-4c58-9b79-b76e9daecdde@kernel.org>

On Tue, Aug 18, 2026 at 04:15:27PM +0200, David Hildenbrand (Arm) wrote:
> > David and I talked about this at LSF/MM. 
> 
> Ah, I missed the context in my other reply. Lorenzo already had some patches at
> some point to split up mm/memory.c into better chunks that will also better help
> our subcomponent maintenance model.

Lorenzo, if you can dig those out, I would rather build on them than start
over.  Happy to do the legwork.

> I think the challenge is how to handle huge_memory.c, because ideally, we'd not
> have these stupid callbacks into huge_memory.c once we make PMDs just a
> first-class citizen.

Agreed on settling the target shape before moving anything.

Splitting by operation answers most of huge_memory.c on its own, though.

Its entry points are named after the operation they implement, and each has
one destination: do_huge_pmd_anonymous_page(), do_huge_pmd_wp_page() and
do_huge_pmd_numa_page() belong next to do_anonymous_page() in
mm/fault.c.

zap_huge_pmd() next to zap_pte_range(), copy_huge_pmd() next to
copy_pte_range().  change_huge_pmd(), move_huge_pmd() and follow_huge_pmd()
have their callers in the right file already -- mprotect.c, mremap.c, gup.c
-- so they move to the caller.  The callback goes away because the PMD case
becomes a branch beside the PTE case instead of a call into another file.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
