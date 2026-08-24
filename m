Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D33411A01;
	Mon, 24 Aug 2026 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590812; cv=none; b=Ot+lSSqT2pXSRIc6/spc+j4jYpS1l/l3TDgMjEB4HW35jx7cvzGSgNO5es0ZJ2dZJjm67DZV8dKoDqsbYbZ3KWNVZdK0De1zvXwA0QSbWYahYYIyRJcVc5oh/TpCKlT2cjsQvFkdUaBKTU9AzIhgA/dMiMJK5ADMJLwqi0ynXWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590812; c=relaxed/simple;
	bh=kovMxV3tDmufRXIQ1n34Oq30ILmOaW452JSuGb6TQz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdFlaaHTuLWZH5j3sZW5nLYIMMsIOn2jSf77c1SG399gK49MoQpSuE/ecytN5CxFI/VS3o7PbdcOx67Z2aMJkgXXW+yOacRLG7dFPofxmQ1ZWg4CbOqMK1ZxY0D765o5C1yQ2tZxREZycKp5je+trtnk8qZlfTXawKj/BCpbezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ9OvYKh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ9OvYKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771851F000E9;
	Mon, 24 Aug 2026 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590811;
	bh=nct0GfFThXU+uRAh3/FXFDpq9aYkue9rlgNBVH3JitQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gJ9OvYKhhQq27htNgGOlt/P3H6X3YfPsxzL1b0quFovndKNySknU9vErizFoTX35D
	 UavqVf5YhxWwSYt+4xbQeWMObpe3fgx8RQX6/0luwvoOS8iK8/zkSNQR4139rvqSgn
	 L6VUwC/lcizYu+L0Hy4M/ZJta3h5hXKYZ5M/Iov83m84a2bcfW2ckhVXfj/xQx/QDF
	 u89w8ZEOyYZGcXQhbofr78vKqpZrPE1e9OPogOnZxnNyIRxfJKm85NVP4OFCzsAKwV
	 cCesI1wh9DSON+jHCRkNA3sKSk0vPLZOvlpP1N2TCJwNl+Gt3Myrm09ZjRm5JbrywH
	 BiOJPA9+kyPbg==
Date: Mon, 24 Aug 2026 18:00:04 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	akpm@linux-foundation.org, nico.pache@linux.dev, baolin.wang@linux.alibaba.com, 
	baohua@kernel.org, dev.jain@arm.com, hughd@google.com, lance.yang@linux.dev, 
	liam@infradead.org, mhocko@suse.com, rppt@kernel.org, ryan.roberts@arm.com, 
	shuah@kernel.org, surenb@google.com, usama.arif@linux.dev, vbabka@kernel.org, 
	ziy@nvidia.com, usama.anjum@arm.com, agordeev@linux.ibm.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, jannh@google.com, 
	willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 00/57] mm/collapse: rebuild collapse on migration
 primitives
Message-ID: <aox36P0DMLqYD7py@gremlin>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <aoLAly-oL2OAa4n8@lucifer>
 <aoLkMUtmzRVuv2Hx@thinkstation>
 <aoQ77EcD3M2kjeya@lucifer>
 <0153303d-f9d6-45ea-a276-fbf2e5625ef9@kernel.org>
 <aoXn1B7cPnPq7uxd@thinkstation>
 <aoxRs0mjyQnpO-IT@gremlin>
 <aoxcN7jrfbK_Ac8V@thinkstation>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoxcN7jrfbK_Ac8V@thinkstation>

On Mon, Aug 24, 2026 at 03:59:50PM +0100, Kiryl Shutsemau wrote:
> On Mon, Aug 24, 2026 at 03:22:02PM +0100, Lorenzo Stoakes (ARM) wrote:
> > This whole reply seems AI-generated...
>
> It is not.
>
> I heard David's feedback. Will adjust accordingly.
>
> >
> > You replying only to David twice in this sub-thread which isn't exactly giving
> > me warm fuzzy feelings about the working-around-me concerns I raised here.
> >
> > So simple feedback - send a relatively small, no-functional-change series that
> > improves THP code and lays foundations for future changes. After the merge
> > window.
> >
> > Can you explicitly ack this please?
>
> Ack.

Just to follow up - Kiryl and I spoke directly (much better medium than text :)
and it's clear  that there's just been some miscommunication here.

So - in general all's good and we are it seems in violent _agreement_ about
moving forwards (split out to reasonable foundational series that build upon one
another -> eventual switch on).

Let peace reign :)

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

--
Cheers, Lorenzo
