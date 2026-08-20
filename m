Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558340D576;
	Thu, 20 Aug 2026 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223804; cv=none; b=rCRS+c2Emh1hDv331T00bYKqCcw2Ni5jpdCrGdwiNi0I5UzDgN4td+cy6otVN/Ci2TdVUSagrIyhu6YnhPThdIWxLEEcy6bJ1K6gNLrWX74PVXWqUMOLo2Bpcb4qfu58ZFzudgKOlfxp++bV60cDpCGr7D/ljN2F9d6RMAoW1z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223804; c=relaxed/simple;
	bh=MshPta0iS4mZ0fKT4KHy6tm15BxxtVAwgEpW3rUAxA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Er4NIwWOVfK9m6bHCRQaav6gpKNkXAMbRJYuSGvq200okQPwHNI90YJ3v7Zj2gk64+7UivqA5F6f0W2V02G26gZCpX5krXAktcpmoFsAovns38W2E+DCoa4eGVSo05ZVS7AS/ZPPCNg1iNxogunqwDogDnI/rsdMsUX+C9kO5hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=h4v6ksqI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NyRnjdYU; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="h4v6ksqI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NyRnjdYU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 475A81300412;
	Thu, 20 Aug 2026 07:03:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Aug 2026 07:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1787223800; x=
	1787231000; bh=Huxg0qnn8fJu2M90AV87+SuAfu8Ucyiqn+uzaPm0SrQ=; b=h
	4v6ksqINBbc34I4HOLT3AbOu32/sKqYADiwHGzlD98l13WoAINBksGpyeoXXdD5f
	UoqREfMddBIi975ert0Mr0i78QrK/e3xq7ECPR1JJuZBUY6pG1blQSfmtWDXavDV
	1LEeanH6BTFYYsV/MFzYM2d6GD7CL214O4VUCGkEQQRwgh25GeZQPzGCVpJf9BFj
	xRMrug9FwiWMvLy8W1nqPSlHBX2i92C8NQlJX35z6o3QydrSjCtIRT+eCsYyEYmN
	Ip7k5Ri1LtzMcllkgVp6lZ29VyKIwr95MA5RNBuviG/P+AonvEY98qIp+ixk2t1k
	YDYBHhJoKwzfuBSNfKtDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787223800; x=1787231000; bh=Huxg0qnn8fJu2M90AV87+SuAfu8Ucyiqn+u
	zaPm0SrQ=; b=NyRnjdYUysVmvUR4O7aJctJHDmO840NF+AWUeFSZS+sNRLSS5me
	oz0KWOjglgTalpUzbPZzKVK/mMRFZ5JVYsUW5sKc8ZCrrx5Eso8eDGVRLB1jSxSj
	DmAQ0kHFZ/jJzkWTRLsnOODFagmetK2ZKkbLWCtnVQriDq1nB9tOQIIuehYSXM4U
	rCYhTeVACwgvYa5spo+lakIKuRNkaQASaDZygF2TB0ItCbfwdx6v3xiTeK566iPR
	kViOLi1IrVuxkou8bifuQOMm2kf9/dw/RN4SkfhzZSxy7AtJlNyPGxQNyQOxM1Lj
	AH1rOcMYI4fgDfliD2GAB/FSFzL9CvUkA/w==
X-ME-Sender: <xms:9t6GaocOyZ4Kcrw-dfXQvd3qt0Rn7dG1dtEEupg03sdidovPwIUm8A>
    <xme:9t6GaqrxLtRyapyzx8x5aliQL-pUuuqZ_1ZVAYdZ4wEp8R_cnCC4TjLYh8U9s4BjA
    epx9HZVQP4x4-IEQ-3ze9SC9Obm0E-FkbNM2-3aeZDuRbk1CwpAXLY>
X-ME-Received: <xmr:9t6Gaq83NmZfRE5FXFHy56tn6PaN40rXnZyQzOQ_rLJj9QlTSY-GZg6djJc>
X-ME-Proxy-Cause: dmFkZTGi6rYBThRI+gPyGqdk0gFejnshTs0jgIzYkHn1s57eIU7ysIOO/3U0Ycz+WDPRsG
    Xg6Mi4zSwoYf+kByU9Z601ezWYRZ7CD5oBc3a8TT1GxISzvrIVbtQy07pVJjH6pMRKazKM
    T5KmOo0T0kSDTIayR5gbXkxp/HgxutAVUB864oI+T4m9++yknzJUqkDAQxi5ZSDTnoe+PA
    5sTANMdPYnapL/OG2KdEQdahdAUgDEnYurAINXjN7w1+/1He/I8pHReJNLNA+1mrtA7nh9
    nApoJG+kju/satpHLA3UpprOXSmphHqB+XSj2l8+kJeLRXw6jQA2FjYZB1zzWUVtm4xmb4
    kB0FhUDB+xl5IWAscGtOZYxq406x1djv4HpZ/5JsWMUiVQs96OfPkqP7yKWBEUf345lKr4
    LjO4lpPzLKRDR/9Ft6wJYaBzdtr0VHuhPc09+qElWx7UTEi3oipPhURF+SNJpbux/wwdYX
    BsY/QW08vXBu2VejLT6uNZqYpDCgZxqCHkvC4x3OYQMCsJoAEK8g5hihi2mGtNuVCVlc6Q
    fTk0GKDiWw6jxYcFM8RMYeK7FV3KECjBemKaxPwQgfD4o590POwtB4foQvRiQwOXC/dcBR
    Kw91DvwHqEHRZOFpia4ShePdJqP0IN++0iZI64Ou1VEw6j0yRbFXpue5udOw
X-ME-Proxy: <xmx:9t6Gat8WHH_2XHJPtGOHMMmwD0oiKJVsMGaGWdtthGC2QIinKr7vSQ>
    <xmx:9t6GakGDpdxRrNHyerT3FWlJFNQAE0hyiGtm-WfW0Csdx1O19cZVvA>
    <xmx:9t6GaseD3MznHKp_gnNGiUzq72B66nmj32qekJgWwE_o1gyLK3bexg>
    <xmx:9t6GajL4OmDCNkH7xMCXtvIO-G8bi9hyuMwdHoESCM5nhjci_uKgtg>
    <xmx:-N6Gapksungxu3LqO7qD0bxG2JX_M0hlsf96JbCsppTXk_gujFucI2EO>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 07:03:17 -0400 (EDT)
Date: Thu, 20 Aug 2026 12:03:16 +0100
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
Subject: Re: [RFC PATCH 02/57] mm: add pte_none_or_zero()
Message-ID: <aobe4JwweJ0DZV0X@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-3-kirill@shutemov.name>
 <4e8e208c-3aa4-4060-b0a2-499bc76d19fa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e8e208c-3aa4-4060-b0a2-499bc76d19fa@kernel.org>

On Mon, Aug 17, 2026 at 07:57:29PM +0200, David Hildenbrand (Arm) wrote:
> And let the callers still spell both cases out.
> 
> if (pte_none(pte) || pte_is_zero_page(pte))
> 	/* Do something amazing */

Works for me.  I will drop pte_none_or_zero() and add pte_is_zero_page(),
which lines up with is_zero_page() in mm.h.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
