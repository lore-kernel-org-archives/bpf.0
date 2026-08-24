Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F413EFFC2;
	Mon, 24 Aug 2026 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564208; cv=none; b=snisnMLOBIUZr90Zq1ba0BUBcRf77H3ta/nwdirxC22wN3fvx91szK1+8dNe33fb6nEwixpSquypGq4obFVYOmlqUmWtEXjgbw5CFP3yz7lsXQiidzsh1fl8gQjKZY3pn1Z7WUC0RV7/0hMLH3d8n+iEzdVnbVVtI8EB7wLjoo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564208; c=relaxed/simple;
	bh=furb5eTjrZhtAjb2Y4dwcu8oqL9mLcd1WB5TFqTWqvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aB+7UV9PHbjTg5yvvozOGGH6eNGeYRSMXzajBrnj5BCtSDru8C2DusZT8SRjn2Grv5edHjvPAwnHW2clpGCGsJC9mLg/2X7zhBHD7+vx4EJDhoxXNPfaEpu1Zb+tPgnssZyhTKkHJY+VXGSe5di57s1UF+XF/u34sVkY5+iVWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=DXMCZjBE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f1TPtFlX; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="DXMCZjBE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f1TPtFlX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 4CE1413000ED;
	Mon, 24 Aug 2026 05:36:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 05:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787564203; x=
	1787571403; bh=2Nx+Hb1cJLavCtqS/5dokCLvUqZ5zLYRMFKnI3FyAaE=; b=D
	XMCZjBEjE2WRkjfTT/l93Z2ppMDuTmy6M2b+tGmG6Pe6cgYWS/QJpmFE/CdNMMMT
	jzMhjfIQIdszw2DOjRSpI/586aBchUC9AT1qPbo8v3wdZKKhlZ5Kpg+cZgqqUQgF
	gx7csWp8hNW5v/+deheOnROg29BxPD0V9iNRJxd9KyDU+ajWO8FmgvraUvhjkmU9
	nE8CBMmUuQp7QkiVnIvqLf4eFzFGwXF/QTKtHaInl9ugaw3FHuIf+k3brfeI4rkQ
	GEAZdY9YVG+OmfStuuPDvLZ6fFGA/SWqw0aC6ZhSkUzmr3i8bXXEm0jN58JYzEyh
	J9GVFE3cd/eATkRKkJTlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787564203; x=1787571403; bh=2Nx+Hb1cJLavCtqS/5dokCLvUqZ5zLYRMFK
	nI3FyAaE=; b=f1TPtFlXInsC6zBZ9Ay4DThFOjrt39+tJOW0YUNfX2yYr4B85lB
	Bt/uNkxNF4rGsOIZa+P2Z4FXHMJCAfDQZ8uA9f0UtGwADmpzc1xLwbzWXTWFDCv7
	F4+e0UQ2+c6UYlR0sBTlmeEsR1pvpwAFAVljawi0eYq++jb71XpKtmMd7DLPVpki
	MXmFqLpbXUkaCTajElC1DEfRCWBbdyz5byyxowa18y+IWeLgtbDWKFWvnDhSpZ0Y
	lRLc07UlSeXN+WPOOC4Ue+Md1z1dNrHzeCMiGAW/w0gIE6amxPurKPMGCrhwFV00
	HRsNqN/EMEJexTQGhwnniSQSF5ICVbXXUkg==
X-ME-Sender: <xms:qhCMamQ37TdeqI-8c0wyxwX4KjaL5V_FFqpYU-lK0Fg0WLjMOwJ2-g>
    <xme:qhCMasPlBtdhrDLj96UANI2IB47ABZAfi5OyMuylgubxKxnWIIWWgICNr0A2G4Ai3
    0ciF0ryd7KZcPJOWfSMgC9_fQmMtwgBb40-k7clB_HaOTmh1EtNV5w>
X-ME-Received: <xmr:qhCMalScg1ZkjSdwXXhg2VS7paIFLyzeiHzwF5yFy9mEQ1AXSu6liZ_nOoU>
X-ME-Proxy-Cause: dmFkZTGz2jKxdMw4ERsyN6C8iQmqO+8xUhsL9pZAKxT69wFsIBys6xB5LktOPJ4MI0l3D4
    YlQadQlnEULRi3wFdFmH6J6Q8kOxZQ66f3Y59fqSOl3sUuOKJyBZVkwP5F6bCwor0D4c1j
    gWQvh+36ctO8XdjR32mGCjZTL7fyCcLpjQDQ1iGjdJj/+SYA83G6of8uS0pWlA7axesh8u
    HWEBAcFTwYyhzVS1HsUvRPl3jc+FFnGEDM7Z5rwtBPS5sXCOn2wLUJWaRCE/5l8OQTIyl5
    aQorjdmPeS4asVy6AP0atTHEfHFq/SWWHDzBowQEToeLuoCh8aVSMWmCd2dHb4AdJVptru
    M3jBUrNeIY2YnduC523fa8mPAYP2Wp62CxBO6cl25BResJENTq0fvto5ryW7GDnZnJUODj
    FAY4dqLp4Bd68fBeVKpNNRd+lQ3DkUTzCJye397QJoqDU4vwpPjJ2SAKEFhCGMYZTeShgn
    hfnINvkBcagzM4zgrpkWQYc2Eypj5LSuP0FLfgxSk2U/TjQIQYJ23knpwjHSd6HW7BwMfW
    J2sfFufBDoqKYso8TIWw4eZTHWZd46+UWkANzrimpT4M1+Q3Edr3yRcV4DDUE1eciOEeMt
    u4ynfdRZwB0yiRDbuR7W1cGkJZ9oxpCZzcLqutIZYpPJQbf25PnbcoUi2WrQ
X-ME-Proxy: <xmx:qhCMaiAvmDZ9d8WATh6CVccjjdVgDgZD-ATr803hgjx-jCFJvptaIw>
    <xmx:qhCMau48MjRLWCDIWbpjXuTa7IN_1WC1HaeNAjU1YLXIUY_Q9vhUMQ>
    <xmx:qhCManAAFbQJAxNCN_lgbOpTJZlqNmj8vZcOVOmLVIEBA_50xeMQPg>
    <xmx:qhCMaifiEw2UntNmGOI3F20xqaC7E_YuxmmtQLe81ruQZXh9Oz1HvA>
    <xmx:qxCMamsgyLPF5we723-a0VKd-R3Khai29a0-_8ma3PHL_N9lh8Mdh97r>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 05:36:41 -0400 (EDT)
Date: Mon, 24 Aug 2026 10:36:40 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	nico.pache@linux.dev, baolin.wang@linux.alibaba.com, baohua@kernel.org, 
	dev.jain@arm.com, hughd@google.com, liam@infradead.org, mhocko@suse.com, 
	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com, 
	usama.arif@linux.dev, vbabka@kernel.org, ziy@nvidia.com, usama.anjum@arm.com, 
	agordeev@linux.ibm.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jannh@google.com, willy@infradead.org, pfalcato@suse.de, 
	rostedt@goodmis.org, mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH 08/57] mm/collapse: scan a table for what a collapse
 could use
Message-ID: <aowPqZU0aj2gSEjW@thinkstation>
References: <20260816224609.308019-9-kirill@shutemov.name>
 <20260824083903.52962-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824083903.52962-1-lance.yang@linux.dev>

On Mon, Aug 24, 2026 at 04:39:03PM +0800, Lance Yang wrote:
> >+	/*
> >+	 * The bitmap and the selection offsets stay relative to the table:
> >+	 * natural-alignment math needs the table-absolute position, not the
> >+	 * position within an arbitrarily placed VMA.
> >+	 */
> >+	first_offset = (start - pmd_addr) >> PAGE_SHIFT;
> >+	for (i = first_offset, addr = start; addr < end;
> >+	     i++, addr += PAGE_SIZE) {
> >+		pte_t pteval = ptep_get(pte + (i - first_offset));
> 
> Hmm, ptep_get() does not look right for a lockless scan ...
> 
> On arm64, a contiguous PTE sends ptep_get() to contpte_ptep_get():

...

> The later freeze can reject a stale candidate, but the earlier PTE read
> is still lockless. Should the read use ptep_get_lockless() so arm64 can
> retry if it finds an inconsistent PTE in the contpte range?

Good catch, thanks -- switched to ptep_get_lockless() for v2.

I don't think it would lead to any correctness issues: both variants
take the pfn and the protection bits from one __ptep_get() of the target
entry, so all contpte_ptep_get() can get wrong here is the young and
dirty bits it gathers from the neighbours.  The scan reads dirty only
for the lazyfree skip, which the freeze re-tests under the page table
lock, and young only as a hint.

But it is still the wrong accessor for a walk that holds no lock.

collapse_faultin_addr() already reads its entry with ptep_get_lockless().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
