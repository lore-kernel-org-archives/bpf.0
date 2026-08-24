Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C521544CF29;
	Mon, 24 Aug 2026 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586703; cv=none; b=hphvo8FbezWgWbK2GpCeCXcyJw+1OvoOtVVSXTXhN6K64+N/7F5U0w5OGdMGBVAYvKNWKLUc2cQBu3OaLGTo5dfrk2BY0zXcuQEIMaKKO7NMl3d3QMx2uuvNwtV3GqMtpVEobBFqsY3wsOn0+anALKe3Z6sTVFVFvAdfeNfUQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586703; c=relaxed/simple;
	bh=WBZXZg8XyazabFSG7+jXaRU5eW4xxTYW1kiZhb3p5oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbE64qXC61jjNmndtXeThWVRy68l/tBcf7lNFMpWM0LNdPuT6fmrtKxqi3yP2IRzAyiaCB8d7U38H6NT5V2Bb+XYFJU/qWUuLh8RweCtw4TlFZlG5yckelftr1liAinq6ZlWKlMFE2wLwFpxsCUQjoMixauEHxroIslBJB3mbks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLYHtqIZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLYHtqIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8811C1F000E9;
	Mon, 24 Aug 2026 15:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787586702;
	bh=WBZXZg8XyazabFSG7+jXaRU5eW4xxTYW1kiZhb3p5oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KLYHtqIZxdRIYDXtaaqoX2/ljO5lG1Zu82Dntr1fIhjL54cQHCrwzOvN64gRGjOuC
	 3ZIlfGOd5o3DVRNyAkTakRpY3nbAUmsMcYEEn+qkj5lN+4OWRBBDGT9AHlHCfRQkFU
	 ZtnAJyeea4W2kqfjiGYx2phf9OGh/d426eLtjbOmhKN1SAiUTgiYqPEjZZYv4OWotC
	 id/QWoppDuGm61CNaVlvELeeCZbK+Zl5nLR29120diREBBX/z5HGoSgDCIPcLoJb5E
	 Ouxv+7gB76sATufgD0OghTTuJgJ4oe4nZZfYPfa3BVdGv8nflOtvujgNNeJwteZmme
	 Avdmoq7P7PFIQ==
Date: Mon, 24 Aug 2026 16:51:35 +0100
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
Subject: Re: [RFC PATCH 03/57] mm/collapse: add collapse.h for the shared
 collapse state
Message-ID: <aoxnmhXB1w1UoPpu@gremlin>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-4-kirill@shutemov.name>
 <3113ac8b-c1ce-4577-9e93-449b70818918@kernel.org>
 <aobglSY5L1KoIqxF@thinkstation>
 <65433d1e-95ca-4434-828e-8f381d3384b1@kernel.org>
 <aow0Z6mrG2esKpRZ@thinkstation>
 <e1c8c6f5-1b5a-4cad-a52a-f7eff00997c3@kernel.org>
 <aow6J1i2G7U0spjH@thinkstation>
 <aoxPzKTVRmZgmBKg@gremlin>
 <aoxe92BxF-5xaScD@thinkstation>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoxe92BxF-5xaScD@thinkstation>

On Mon, Aug 24, 2026 at 04:18:09PM +0100, Kiryl Shutsemau wrote:
> On Mon, Aug 24, 2026 at 03:09:00PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Aug 24, 2026 at 01:36:03PM +0100, Kiryl Shutsemau wrote:
> > > On Mon, Aug 24, 2026 at 02:28:39PM +0200, David Hildenbrand (Arm) wrote:
> > > > On 8/24/26 14:10, Kiryl Shutsemau wrote:
> > > > > On Mon, Aug 24, 2026 at 01:47:54PM +0200, David Hildenbrand (Arm) wrote:
> > > > >> On 8/20/26 13:11, Kiryl Shutsemau wrote:
> > > > >>>
> > > > >>> I went for a clean collapse.c on purpose: the engine is new code, and a
> > > > >>> new file keeps it readable while both mechanisms are in the tree, with 28
> > > > >>> as a plain delete from khugepaged.c.
> > > > >>>
> > > > >>> Your shape is less churn, though, and it keeps blame: 29-35 move about
> > > > >>> 1700 lines as add-and-delete today, and most of that would stay put, with
> > > > >>> only the daemon -- mm_slot, the scan loop, sysfs -- extracted into a new
> > > > >>> khugepaged.c.
> > > > >>>
> > > > >>> If you prefer it that way, I can give it a try for v2.
> >
> > Please don't respin this as a 57 patch series.
>
> I didn't plan to.
>
> The goal of this RFC was to show the final form I want to reach.
>
> I will move cleanups and refactoring to the front of the patchset and
> submit in small self-contained chunks while keeping the rest working in
> a private branch.

Sorry missed this bit - great, that works for me obviously!

--
Cheers, Lorenzo
