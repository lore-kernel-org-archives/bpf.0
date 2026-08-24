Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58EA31D375;
	Mon, 24 Aug 2026 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573430; cv=none; b=G2xA6PgPVG/Mv4EAIMC4YV8RpLihtR6xfrhGoyLDJKEeaAijE+qsTnUXdhvNwRF/yLO24nPWCxQ5u91qqL62Q956vrRTWKF9I/k8OYXGpBNwtfzgwkv+W9rDdX45FLe/oMr56ZKL6XomTIUwo1q/mATHbrsHu64biqvn8E+QOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573430; c=relaxed/simple;
	bh=dLB84hXw8vFlf1kXJN55yunC1M7YnYe1ooNCC07hjJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHD1M8YPQ2RLfHMEMEAp4/nFAGEqkUCurWYS25UvK5juEGAgGLa7ZsA7jpOsX/GXY+uvFb5QXseI20g699uEtiTMvG8/v9mY9TG7b20bozo2BV+NH5qOldPSVxrhlItLCBBUYnKE0OIgTTNiiIn+W7Cd66+KqRGAamzhxiaFJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Ixf8Oa9C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OXgLEY2A; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Ixf8Oa9C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OXgLEY2A"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id B20B513801CB;
	Mon, 24 Aug 2026 08:10:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 24 Aug 2026 08:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787573427; x=
	1787580627; bh=+BetWuGtES6FYCL43UJL392AYum+pn8KC95eoabgl+4=; b=I
	xf8Oa9CGDPitrXuxFpRTrNA/CUA4sLabnalrpbCnQQxYCTmD9GO+glAmL3vtkY6h
	QLXiD3Hj1AHISvBlFKZLIBGppjLCqHHxa07bdE0OVsc9UdQfjLpRqtDgAIg2U77O
	tnAjFSA8z7aiv1DX3PihtFYqDxukxvEiJRzMYdt/yqHRUHSNg34hpmIgnPsXgmLB
	4X6AvQ2DhwD5CAJeBoj+qKjwVkvuo2Y2S5QQLu9t+MuFoGwS+3YMn8Wmf8eX/yoB
	1dfdTWV5XJRG6HZYHyk440xfHYoDj0NQU8KajMbz+qkQHuQ4WGNutoAe4/XJ0KWj
	VB4HeMYa8p5b4eUKrj8lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787573427; x=1787580627; bh=+BetWuGtES6FYCL43UJL392AYum+pn8KC95
	eoabgl+4=; b=OXgLEY2A9FwIshfHHebpmoL+yx5E+ITZcbpOPAGV+NYLBq6GmXf
	tqbl6hT115nzi2LiraX2sQtMCAouB41P0K7ztgelcc30CIKxOKGVwAxPiXjRUNlJ
	hhvQtHoZ7b82sTa+OQShJFcW883gdd+bBjt+z72BQSwjHyAG2F8t05MSpSyDfFTx
	umE3vvEfytupD416/dNvaZNbpuhxdJZfuapJh3QE84YJp9eUWlceLyWw+qKvk0FO
	pvi5rxXEPfCMZWk+emR3FuYO46O0DPHX2xehfDIi49yLMcoTfSQGpQuasd+IW+cS
	jUsyRKtZHHukq9dy3yt4i6GTTeU2uI8eGoQ==
X-ME-Sender: <xms:sTSMakFevnMHez-TsqKHTsGyWanYrCxBrd4Lk3gnXCC-4OprI7Za_Q>
    <xme:sTSMatz_urE6iaOB-WyzJTICJtuu0FSjK67-8vMGykqbqeF5RseyorO3k10B-ziJp
    uOA0wmzDAMsSmRUj1jE8uAGKOKiRAZAYbfgN0hqzmvQA6VM2b1kgHws>
X-ME-Received: <xmr:sTSMavkusQFypit3V_l0slgntFw9tgm5BIRSseDwrXGQr2uX1oIjqPAgNAk>
X-ME-Proxy-Cause: dmFkZTFGxilWmuF3Gl8ZPZwxYmOPn0BEaIq9i7rD4Dd/1XrTGUj4VjY7hNztkoxXS7e9ZX
    YOYCvvo5OHvsSrHohvqkiiFE9sNB19lqguDTit2SqCzhTpIB4v7LIV83ME+lt1IbVb1ARD
    e2/EdAAQDqfcEuYGEcfG4q+pt7q0fC/FZ/Vwcmo58WjowQAHZApEtHoFu5aD3C7z71y8Gz
    zEBghY8bMP6bHVe/TUqSuv5AD/pO/LC3TsFeZXg8JGdhaszDVG/9i81PGz50gehDJn8PWC
    NP7q7ABVVUq2eZhbZ330aHp8uM7GSMXzZSNR0JpPHXuEnVRObiMpWpE0UIl/UvwHR+Qxbi
    LjgmsAooNDIMPFmX+m4464q6lesSjU7e/tnyt/a5TB9v/aGR+RPfNiUYCrz8UicH7kgOzK
    rHR16IBtYq47Sxs1gjnHLNodrByJ2R8drPfrlc2ftPLOOr7rvKPQ4DdbZS+7xYh0Vgmnhy
    2/0LjGGwEFpWBjeUFBtWudNveidd7/90j6jHovxDPLZQmyY1cg9CZb8dEfjrGJOgW7kIeE
    H3WCMtKx4SHKzby3wyJshdKRJKNjd82g4Qd9I7RaJWq3NJRPfHEKV0uSmPFjBWLRJF3o4N
    /YUfL4CmzBhuyh+mxcZu7/mHScQh79irYR2t9Svxs88/JmR08/JUxMStYqdA
X-ME-Proxy: <xmx:sTSMamHd21CAaMomXAUVBo-FgA5wNjmNhqpK2QhqUJt_H1qk4uX0Iw>
    <xmx:sTSMapvUfTPGmNUMJiknWiPNnSQ-SYLAuCW3ejG48vYb5PuKcs-jzw>
    <xmx:sTSMahkDBiv3DzcXCA9aoXsj6BChh_cqnCHBtR1t1s90pYwIxkXnng>
    <xmx:sTSMahza4TvNiccZORwLjRcEtq71ZdGd-U92dZ30euOc5yQZfOXlAQ>
    <xmx:szSMahs7409M3gBwcHW-k22zOB_yMvq_Ys9rNUlTLNp4mIiedxwAMkWn>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 08:10:24 -0400 (EDT)
Date: Mon, 24 Aug 2026 13:10:23 +0100
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
Subject: Re: [RFC PATCH 03/57] mm/collapse: add collapse.h for the shared
 collapse state
Message-ID: <aow0Z6mrG2esKpRZ@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-4-kirill@shutemov.name>
 <3113ac8b-c1ce-4577-9e93-449b70818918@kernel.org>
 <aobglSY5L1KoIqxF@thinkstation>
 <65433d1e-95ca-4434-828e-8f381d3384b1@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65433d1e-95ca-4434-828e-8f381d3384b1@kernel.org>

On Mon, Aug 24, 2026 at 01:47:54PM +0200, David Hildenbrand (Arm) wrote:
> On 8/20/26 13:11, Kiryl Shutsemau wrote:
> > On Wed, Aug 19, 2026 at 04:19:41PM +0200, David Hildenbrand (Arm) wrote:
> >> On 8/17/26 00:45, Kiryl Shutsemau wrote:
> >>> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> >>>
> >>> Preparation for building the new collapse engine in its own file.  The
> >>> engine and khugepaged.c need to agree on what a collapse result is and
> >>> what state a scan carries.
> >>>
> >>> Move enum scan_result and struct collapse_control into a new
> >>> mm/collapse.h.
> >>>
> >>> No functional change intended.
> >>>
> >>> Assisted-by: Claude-Code:claude-opus-5
> >>> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> >>> ---
> >>
> >> BTW, I'm wondering whether it would result in less churn (independent of the
> >> other changes) to
> >>
> >> a) Rename mm/khugeapged.c to mm/collapse.c
> >>
> >> b) Move stuff into mm/collapse.h that a new ...
> >>
> >> c) mm/khugapegd.c will need.
> > 
> > I went for a clean collapse.c on purpose: the engine is new code, and a
> > new file keeps it readable while both mechanisms are in the tree, with 28
> > as a plain delete from khugepaged.c.
> > 
> > Your shape is less churn, though, and it keeps blame: 29-35 move about
> > 1700 lines as add-and-delete today, and most of that would stay put, with
> > only the daemon -- mm_slot, the scan loop, sysfs -- extracted into a new
> > khugepaged.c.
> > 
> > If you prefer it that way, I can give it a try for v2.
> > 
> > The rename has to open the series, so it will collide with anything in
> > flight that touches khugepaged.c.
> > 
> 
> Kiryl, I have to ask, are you using AI to write your replies?

Yes. I use it check my claims and fix my grammar.

Why?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
