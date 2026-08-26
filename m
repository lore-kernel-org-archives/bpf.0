Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C617466B57;
	Wed, 26 Aug 2026 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763492; cv=none; b=mNSIxc0xZGQMQ3ADMpCMOvgXtTL4UcQw8ijAwe5X2xuO/hxDZGNOGWkhNUsWl+eIEcMc1bql8LrTsT6mVEIPLtc6SzeGpB1UYsYbK78bYKbITLAbh/6ibeGnAgNtI8RWi5J7ajRa+nYoUCpXjaNkxxJnhYmz1WVREnw20Z6KmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763492; c=relaxed/simple;
	bh=zD4dqAdxXW0Er1wshogf68T7eQtR8N6wUmTMcgSvP24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmpgZy/y5s9UELNCD8gkbgPUU6XJm7oKqOqGQjmqxPKEtBPg+konZLwIZVw3Sdavl9Weq0JeOl89MOxh7g62MP+rrkL+gIM0Cyx+CkKoAxd0tWsP1TbNDAEqOnrMkBrgYNMIg8XySAYfzw54ISTjnp/IdVGsVxoCBNWp9aycBG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=lAEQPsWP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FWcJzcvI; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="lAEQPsWP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FWcJzcvI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id C2A131380030;
	Wed, 26 Aug 2026 12:57:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 26 Aug 2026 12:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787763472; x=
	1787770672; bh=b/RQVU7x/2Ow8BFt80nTwsnGflSL0G5KQoMqCALTqgw=; b=l
	AEQPsWPGylc/rDV+icMKHCvV0frQXk7F5fjF/UWtvHS3U9fWb1ezXQP7ShieFlvj
	GRHu4wj3M0M93AcK6Fk+g0gXO/K1ggVsaQoAtUzo/X7P8nFmbU8FYPwrOSRT/f9e
	K8ehYKgucU/hhblvFh6gJVzwtpue21D8RH6qOhIP9VgSLjzBvcNWlYSd2E9GEAE/
	rptw18RRTdRcy16z9qXWzwSBFQIHkye5hOPOBUJthoVYdNZ2mKXOIK8HHDV/+KQ9
	OuS7oD7vv0OwukUNt0sbRCKWM8g3F9lA/URc0OliMRI76XOfoa10xGDMpreFOEZw
	TM0E2lfzsLh7Rj8u+H/IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787763472; x=1787770672; bh=b/RQVU7x/2Ow8BFt80nTwsnGflSL0G5KQoM
	qCALTqgw=; b=FWcJzcvIbsh6QBt38zORnV7P0eeo8kO9WRVqoXVqib8+79FS694
	XuKDCqcuP8xSUq35/uiGv29rROwTWvnQIfT3oylh06izCKj0M3joTmPZlU47Q4Oe
	3loNfsttBTPANJ3cHFvfNXWdCw0pPQd+2JpG6RTFBc8VMAeOj1lDcOiQaCQaW3H+
	nlZGkNrwXaxWBE6U+6fuS/vhfs6O6JRCigwrHViNUdATu8xEJ0UF5Mtfj+X9E8y0
	7lFkn3SroSWUDnay32P8/uUW1sobt87f/JpREWi7wYr2NjMIEARJ4EyUuk86KUr7
	2aLV0GEJgf39oJ2X/KZqY6UwHX3Lxp+uzIw==
X-ME-Sender: <xms:DxuPak_Ack9LrPRHKaASHS2wMVcpgG-689x44Ryij79y7lQVrFEVtA>
    <xme:DxuPavBx2WNCktSwtgXC0SxfLbBEckvRxdJfhs7E9wmLJzgle1DLPmakYzLyGGnTR
    4WNecrHxs-j4WVhirpK9ouXZhMnQ4889TjbA439uPnzkggzixb8lw1D>
X-ME-Received: <xmr:DxuPaoxK3jWLjl2liKXaRMPDLyn8sdJrUDu7fIXrSdR4UfIMDoQI3XCIRuY>
X-ME-Proxy-Cause: dmFkZTFJ4uM7XbmV139GeFVyMoFnf31HwoxJmPLJ3DOlCGleDxaZYboTq/8g92bw2Tr80S
    wGFNepRmFciZXpZxop62rBrDkHPnv9nXc7KEvSWS/8GpVlaNgXKa6dfYTeFCYhn2wtJOiK
    307oxwUoWuxtmYGFBjteL06s8X6htc+nvVtjVU1989gEb4MnzMjTATDrZasvNpIzgTin/4
    7VGQP/85bb5l9LG5OrzuOshjFlmmTq4AsyZh9HGehMneCAhVUK6bc/pCgfQZDFR3x2TwYp
    uo425DdKwIGf1YipHDcTUXwhFZvn69o/vAlmdQD2hXiHy7vx7Q0z9WPqV/j11J2qlpRNFP
    N0s33neGxgTZZfYnhJK2+RUlWyP4sJ4EnQb1rLd7dDD7onVFIkM3Si6Mqw8hRUnRhJ3FI1
    yd7zVWfgPMI4XKuEiHVCS3DmOtq/A5sbrr3G0llk7qra0Ip8+g/oxdsmWQKj2Zz0hg4kGt
    qz4W6lHUETFMI3z0klSBqecxB0Ht3A+X6YW0W2k0UD3GMOgQgejr6TQFlAOnu6D9X0kjs6
    7RovcdajI+QYh0ZCP+e0ltkW7g35gD/7KAmPd40hfyJR3mBOnA1DxHo/tOjI4SwFyC0eXy
    3fAYexBao+lcCDPzbZXITlpM6JIGVZrdRfMCosWDlctgLcUZVs35a2aMXAMA
X-ME-Proxy: <xmx:DxuPaurxPtHNM4zlRhQUucemYoop_cPCcuSi4QG6ZU93-kiH8PsIkA>
    <xmx:DxuParx3aF35QlDHf8Ot-LSEgCyypoaVBQoro0MUdxDgW10Pjg-V_w>
    <xmx:DxuPaoP12wTEyHve1fnxqo8xoWT0M0b81Y1HMZTWOvA4YSlEo9BfPg>
    <xmx:DxuPatdNAzkwxWAxHwQ7pFsN_taxnKCvmFIevzCVIdFHV2Dv3CPCAg>
    <xmx:EBuPamdFSp7fldrFIU6gA4GT4OKDZYKJ4F5FNQFbvKSXyMShOLEGLOLt>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 12:57:50 -0400 (EDT)
Date: Wed, 26 Aug 2026 17:57:49 +0100
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
Subject: Re: [RFC PATCH 18/57] mm/collapse: install the destinations at PTE
 level
Message-ID: <ao8Yz5tqr2WVlPj5@thinkstation>
References: <20260816224609.308019-19-kirill@shutemov.name>
 <20260825064851.87309-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825064851.87309-1-lance.yang@linux.dev>

On Tue, Aug 25, 2026 at 02:48:51PM +0800, Lance Yang wrote:
> 
> On Sun, Aug 16, 2026 at 11:45:30PM +0100, Kiryl Shutsemau wrote:
> >+		/* Slots with no source gain anon memory that no zap accounted */
> >+		if (nr_populated)
> >+			add_mm_counter(mm, MM_ANONPAGES, nr_populated);
> 
> Well ... KSM zero-page accounting gets out of sync here.

True. Thanks for catching this!

> I was thinking of something like this:

Your code looks correct to me. I will take the collapse_abort_candidate()
hunk as is.

The install side I will organize slightly differently: a
collapse_account_install() that does the MM_ANONPAGES accounting in
addition to the KSM stuff, called from both install paths.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
