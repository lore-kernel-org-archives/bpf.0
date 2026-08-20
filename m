Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4490418A29;
	Thu, 20 Aug 2026 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223183; cv=none; b=ssLexdsRPg13MbLOSzi29la/SXbsQHcx9KbmDoI/A0M/mUwxc1Xt+73rzc4BupuXYy3Npk+ZusfjqxI+B3grMQabzIH04Lkln3O9zM5NsCyAKM3KYbIMW8hPrAU2jeQ6T8drtujjs6crXujvebGDbjbnQ5yx0gnQhLRfwk7plxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223183; c=relaxed/simple;
	bh=1x3G83+lsmYYDnZXUUc21SyZAESIqwuRlkVLLvM6xzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws0X9sI5JP6pU5sEa65F6TO3TZtZofMbtcEgFkrkdsHqX4WoBbRbVxjckQOZgew2IOs/UF4PQRNAczCZDOyxtBpYdWP5+6VgJPXmZlzwMofUSwfvazfAE+UJPZCIAuq8cbptnv8HcLaL7FclNBqvfpSVfWqOWRIClGgceQXaMNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=lGwToSj8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=meE7wau4; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="lGwToSj8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="meE7wau4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id F2BE213000D7;
	Thu, 20 Aug 2026 06:52:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 20 Aug 2026 06:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1787223177; x=
	1787230377; bh=1Hm6dRu/lDSOGHkykkLzQS7nEKTBeP5xgqIC54jHG7w=; b=l
	GwToSj8vmRVt7iD8kNLWQM3v96QhNpGsPEAIsmLFJdObYyjPTBvrw7Ujk6VQKuDp
	GCcFVbMUBnkDnKFediQ74DkjI0r5j9sygg69IGVprIeK/QZbukiszEh/8GT6zLyO
	7qOQyfHwFR2vEffF+kH1h8xR3FHtjv+JzVnshE9icj3cLJNPFGGtBS+N4sCNnKE4
	WCi+TVKbB0rs1hivSdibID+uGzDvlVf95YSq+EIS+1g1hDBgjK3hHbgyCgdpkFpo
	WArd82fv+rxaxOBasx/YlltyJmaRk38eM43LSn0HQBY+0UdJNDJT40lEgZj8Gouv
	IJwdIGvzlbFfbqpx/wLrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787223177; x=1787230377; bh=1Hm6dRu/lDSOGHkykkLzQS7nEKTBeP5xgqI
	C54jHG7w=; b=meE7wau4CKenl5UIRKtWlLbHB0nH5Rd4PKesazkis9U68OKk4Wn
	EQ3Z5R2pmVJ69WzQ6nQ9nIAaTMAoQtgsAikt3XwO+xFU7SeCwmNQenIdOf/PYzEZ
	MYw0IhPYRj0yRM/c9q3oK76xpF9/JNGoFWnHGCObkf63ugBBYvOx4tMXBVF1s+xF
	SiMSy9RmN+erVgJS/RQLTd+rESLKHl5B3vHQVPab+tLGMYhqMgeLK6h3ItmyW3vD
	5IfFWiPeyEbuUvX4ZHugoazneYVRXdqxx0ulsuh215HxrGproxrWmp5eUeOykS9V
	5kzIC+7I33DzGtBFvmvVR+/ZFpwUMopnoeg==
X-ME-Sender: <xms:iNyGat54BC7xFMs_8l708cxxc_QNa1N1KRy3lm3UYpbEGggUlgpZaA>
    <xme:iNyGarViOayqVZ8tXexJEDUOBz4FGxvlpPQEw1SI7PiuPfT9vIONKpD6EAahfXlIc
    ugsaYtQ096OKZWtsK4pFHHSpfMIZWGwSX6KgtfyIGdWztTaOIozpEE4>
X-ME-Received: <xmr:iNyGal47XIR6C_PL9lYLPJXFMcpAeMSpoWverE2zKXbOXLBAvYBdNDx6pWk>
X-ME-Proxy-Cause: dmFkZTFWRza+tZqbwe6AvSvswwNn1vm2ouOEl3sD29XdKlxSbeb7SJ+ft0N23ZfHAXdLoD
    HmugP2x8o1qZZdYgJ6uNKnryUZdf9vJIX7yG1Wd0puBWlPtUU9+QdT2J4Dz6j/J8OsU9Lu
    cHBdXN2icIfdMLZpxUxDYeqctOT72wTuhC9gb/P4RO5svqtLV3/dQMxW07EDCY/HgRS0R5
    hIWhoRHy8caBmuUGk6MLMFA2fTWneQj91H7dazgLVy+nDRNY6KF3ioVB/SCkQrHtuzDw57
    zzT/SzyH8GGH6dfj0mKV7WEwwBQIKCfmWOLYVVVdY2G5L5TUscUlN0MnsMmOT7XGn5nqZ3
    qTusjp1bsmaQ7NxNYNGdouQ+Lzho5PCtqMOZXHY/7N8mFMRgD536Lix289uLH1lUZ5l7Bs
    0EKkfid8uPYzb8PyS0LZ5AGD6stNkDOaYLtEQ+FU4ShSANtBwfDpn7DoszKmWH82qWAlZf
    IibZn0VeyWcdksSZ6k5AMmFRba7hM1obgBOhf0ePHT8321pqVtXzXm7r6Ac9BoQcxbdoGX
    DiQyx+zJJ8bPCAxR69l9MIPqGhG3bFnUFNk13wc1BQkNJDAjeLqZCWgh8a/ngZ29YtnBdz
    5UGnWNG2Fm8ctlMT15phLBhY3M3l86Iw7muaQrld5L7QUvHK5Ib+j58n5HSQ
X-ME-Proxy: <xmx:iNyGamLi7qP7Vxx2Urm__5VWE9vtQY2VDeeZD2Ww17JIYTyID0H14g>
    <xmx:iNyGagjcASSknb_rBn_7XGrZaAw0RVIp9r9LgWWiYqMx7ZibjiT0gg>
    <xmx:iNyGaoIaZZAMY58wc3AOrGX1JTsHPReoBCi33oNnA_pSv5mWAwG5lw>
    <xmx:iNyGatEnM3ejngFdRo3f_F-khoayz0ka4TzC0oi5RkdtRfyGbUZ5QQ>
    <xmx:idyGahzkie0eSCaUoBYs-yYze10njpQW-hnyNaeDBMfy-8AIxueySSoN>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 06:52:55 -0400 (EDT)
Date: Thu, 20 Aug 2026 11:52:54 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, ljs@kernel.org, nico.pache@linux.dev, 
	baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com, hughd@google.com, 
	lance.yang@linux.dev, liam@infradead.org, mhocko@suse.com, rppt@kernel.org, 
	ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com, usama.arif@linux.dev, 
	vbabka@kernel.org, ziy@nvidia.com, usama.anjum@arm.com, agordeev@linux.ibm.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jannh@google.com, willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 01/57] mm: add pte_folio()
Message-ID: <aobZECx2aTUHP6n3@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-2-kirill@shutemov.name>
 <7e40cdfe-67d2-4ddf-a048-f33b2d590371@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e40cdfe-67d2-4ddf-a048-f33b2d590371@kernel.org>

On Tue, Aug 18, 2026 at 07:09:48PM +0200, David Hildenbrand (Arm) wrote:
> On 8/17/26 00:45, Kiryl Shutsemau wrote:
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > Callers that want the folio behind a present PTE spell it out as
> > page_folio(pte_page(pte)).
> > 
> > Add pte_folio() as the folio companion to pte_page(), and convert the
> > callers in fs/proc/task_mmu.c and mm/hugetlb.c.
> > 
> > Preparation for the anonymous collapse engine, which reads the folio
> > behind a PTE in several places.
> 
> [...]
> 
> >  
> > +/**
> > + * pte_folio - Return the folio mapped by a present PTE.
> > + * @pte: A present page table entry.
> > + *
> > + * The folio companion to pte_page(); only meaningful for a present PTE
> > + * that maps a struct-page-backed folio.
> > + *
> > + * Return: The folio containing the page @pte maps.
> > + */
> > +static inline struct folio *pte_folio(pte_t pte)
> > +{
> > +	return page_folio(pte_page(pte));
> > +}
> 
> There is a reason why most code doesn't need that: because they should be using
> vm_normal_page() / vm_normal_folio(), or need the exact page and handle special
> ptes differently (see gup.c that uses pte_page()).
> 
> And other code that uses pte_page() doesn't really operate on folios AFAIKs.

Fair.  pte_folio() does not fit the abstraction as it stands, so I will
drop it.

I thought that maybe we can rework vm_normal_*() to be a predicate on a
page table entry, so if it returns true the caller can safely use
pxx_folio(). It would be a cleaner interface in my opinion.

vm_ops->find_normal_page() breaks the idea, though.  Xen (being the single
user of the vm_op) wants the special bit to indicate a custom translation
to the page here.  A bool cannot describe this.

Ugh..

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
