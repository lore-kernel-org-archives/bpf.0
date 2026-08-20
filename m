Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CED40BCA0;
	Thu, 20 Aug 2026 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223974; cv=none; b=p6FpoSSxNFD8vpctJN9L1g9GPBxPxGKBv0xP5ECyieXks/adhwnoiVb5IKk8YHiPrGtDMQyGey/H918INEFdMnNL2qUC4AKDwSkxi9i53djyg5rtjbDEj4ETgqU0IIx/QfsvNY+ZzB0v8oClV+sYEPlFSPCYR/gJLrZnaiY3kG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223974; c=relaxed/simple;
	bh=tB7QzERo676raoNvpVGCNvOZRS4YR8hyCIMfMa4hBHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCKVoWvi1YkR+AqgOpeIiPB6RnF5/cOYYc3GBSCQX1RPsPERPevo9TQFDdL1vP2dOrLXAU6zRGG+S8vykzszYyU3WWXkJCJaDN5eOzKPTwYQtC2OVoRpaSmFzuFa4yODeNW2YzdsGtLEymJtgV9GKPb4zMbTP4x9H3ukYWbjdzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=f2u5j0GK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DaaRtG3b; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="f2u5j0GK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DaaRtG3b"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id C66E713004F4;
	Thu, 20 Aug 2026 07:06:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 20 Aug 2026 07:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1787223970; x=
	1787231170; bh=IlbJQP555HoJqRVdUgR7T/1zsnq9NkrwHb6N1Usk5Mc=; b=f
	2u5j0GKuzTHJISQTE+d6CfSsMGywRKqWI9TiZT68HXf3EvaG55r3KOqtEMPOh969
	Q8cwy93iv8gO3UQ5w9zzdhJZc4X9peEQ7h+aeG21HzKdV5IWoh6UzvfWi7MD+ehU
	7apM7qB3OMuyYTcpUxvnSJ6fDuo77xO8M6V9Slf6EgE+BEJfzH3sCTBEjYtzPfl/
	l73vuNt5algZ0UUT2YyaSKF4F8TRQz3N+aC4rdbnVlCM6iuFLqJIcRSu7FwqH+zB
	oh7CZgmlSbp+n3w55FIhs5Mw5+9Mv1NxpxdMpYGf5BfoAAxeBELW6WLAiWjt0YVG
	+3WhKExU+MClBGoPDNldQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787223970; x=1787231170; bh=IlbJQP555HoJqRVdUgR7T/1zsnq9NkrwHb6
	N1Usk5Mc=; b=DaaRtG3bmortWYnq1FalinBqLj0ElacZAfHgKU/lTzX36jtOMCd
	V9UWJk1jJg7KIy4ynTcWAv75MHCudW7VAMIzSL12enoIFW0yHGgNZfA9Re+55sfD
	qSwxR4Si3VJkWwf4Yg3/VsiER6RNmOpvtpZbcr/BiJUW8EqOOKJMi1G/k1qNVmtt
	kkGSWGLs2+KKgWlfc/2QFMyKeXvp8DBO5OMRHopN2EUplQtspldu4sAAB/Nl+c++
	M29n+yUhWDIXLWA1sijD+RQc4pyM89pIcQ0otmnBpIxQmTfHusajUUAMnN5Er8Xz
	NkEHumKqQvIx1wpdPg18e7htKt8cQFz9vxw==
X-ME-Sender: <xms:ot-GasYe022TbT-F4MYvO-4wnSH3LHiCxseF9p4Mv_4lt1Fv4pIL8Q>
    <xme:ot-GapuUdC_C04fOp9OlGSkt0rZaJ9-y2RFM19_zVGitdfk4bofVyhb1cDG3UTW3-
    oMzF0S1YwUD4SyEvenKZTuweDH_3TcRRLlIXQynx_pQgt5NdEvjvn2o>
X-ME-Received: <xmr:ot-GaluvtYf9JywIxbtKZ5hcvp-gkjDYUda0OWvjjRJoIUWnXvQDRoSqTxA>
X-ME-Proxy-Cause: dmFkZTGRDXCIHniUcoVMUnNwDLHfq418rjl5TVbty+TXWcaa6tAYts2Y88Shduu/9w8j4t
    lPFGoY+OtiV6YKtC01nyfGKWAAZyEvhd5YxugVsaCWY64LBgqnkWX3IUmygySMtpYfXgyz
    Ouj7muvo/0NThRgZWRwmQ5vFyfhrr1DBAq/W4iDGTyed9JUBb/oP4T1T4qi8kwZgJ6091X
    2SmfsnYIgmVl2EXnpcVJ7LzHkhc4+ckuhvpCop3EssknVkM1P6dKF5wQWH4MltvujePLbx
    Fb2PlnY4i4uu7+IjHpqRW61rtT6e5vF5oFXEroprm1JDdRUd3us22+z1w6/6t78qQjZIqx
    3LEDAbZR47zYr1jd98PUqkIsynHnGWiaAdqKz+KtIPWT3HaW7ZFzWJfs5EfypEiJGncf0H
    aCppRFPFPCPw+SO00MQpS+W+5PtSZjut+Q3EFoVE7Cc7/beLoQUBzIWa/I47Xgsbn/X6To
    wK6sHYYTK3Z0kZ0YdjWzJE04oZbokx/i5aX/tCea2o8oU/whMSNy5YWYVGJKnxjy7ZwfMH
    tTvGjfURot5zs5JFDHaCgdnS17BHbGAN898MRMCIl6bNUBgQ1gcveTyEsmlvay2ofeUmyX
    CO8BMGGZ/tz8KvGSpMH1YsEbFqWs7D6tJDJjEY8Ir9h/SSOosiRvcVqqRChA
X-ME-Proxy: <xmx:ot-Gag3YWp-O_C0X74W5IR1CY787CmhDsf6BABALPyr50-EjuuNVQQ>
    <xmx:ot-GaqPmULJo9CqQ7nkuGRnoJcDjz8lpYOUv1ODuYt-nD6FC0eF6-g>
    <xmx:ot-Gat63ao7t9oZdhcK1k0UlSiDpXkwFovwQZSlnXHlGmNU3AaWLjg>
    <xmx:ot-GapbQTSMkKFXLHiDuBGbn2qVMpNkDBehjz-WOWBJGmDpBHBEBhg>
    <xmx:ot-Gal1hVmEH9KQ8U9rPr4NQ0HLH_J3VEO4h-2Ot25pYqrL92QWV-4px>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 07:06:09 -0400 (EDT)
Date: Thu, 20 Aug 2026 12:06:08 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, nico.pache@linux.dev, 
	baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com, hughd@google.com, 
	lance.yang@linux.dev, liam@infradead.org, mhocko@suse.com, rppt@kernel.org, 
	ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com, usama.arif@linux.dev, 
	vbabka@kernel.org, ziy@nvidia.com, usama.anjum@arm.com, agordeev@linux.ibm.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jannh@google.com, willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 03/57] mm/collapse: add collapse.h for the shared
 collapse state
Message-ID: <aobfkZLCjzkDMzfa@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-4-kirill@shutemov.name>
 <aoQ47NMwUddi8h1M@lucifer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoQ47NMwUddi8h1M@lucifer>

On Tue, Aug 18, 2026 at 11:50:55AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Sun, Aug 16, 2026 at 11:45:15PM +0100, Kiryl Shutsemau wrote:
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> >
> > Preparation for building the new collapse engine in its own file.  The
> > engine and khugepaged.c need to agree on what a collapse result is and
> > what state a scan carries.
> >
> > Move enum scan_result and struct collapse_control into a new
> > mm/collapse.h.
> >
> > No functional change intended.
> >
> > Assisted-by: Claude-Code:claude-opus-5
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> 
> Any change that introduces a new file should in the same change update
> MAINTAINERS (in the THP section to which this belongs :)

Will do.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
