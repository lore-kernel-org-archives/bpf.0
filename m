Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF242367F2F;
	Mon, 24 Aug 2026 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584702; cv=none; b=U09e+o9ZESRSmJs+el93qCN25F1nEAf2j8ByEybqIAYvb+52XIRTNFyTdWT7rkLf4SK66+iU6m9stk7SinTP7nQp1GXzPFBAhlk5VnQMlLky9gcjV5QXrF78Pb03YpI3HHgRkUsek+CwzPdhX0o8CWp3uCHiwGxF8r5BGUDOKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584702; c=relaxed/simple;
	bh=PP1y4aqvLHRliamyoG5EjEe6vfK2AuBc4DMSzl02Xl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN7TnMvGSBrR6iLQ4ZoQwTqd8lCtqv/ceUTJ2DC5dyPSxHZcvTt5BqKA9sKQoOyeiWc4RVJHO6Xn4eTBVKyCBHURoe2WUngjp7Zfkyd1eVOxHTE33ji9BhPB6zZwKwZpLYrBCDMUKay89TKltKnrt3AoIawY9MiSILOd2EIA1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ex6lSv0R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eXIwBBcO; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="ex6lSv0R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eXIwBBcO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 1151B13800A8;
	Mon, 24 Aug 2026 11:18:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 24 Aug 2026 11:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787584692; x=
	1787591892; bh=4R6k+VGQFBFgbdVkejhQOb6Te72Cxsv0t9TgFx0RFGw=; b=e
	x6lSv0RmxW1dIXXOIctP4xvxwCD/6zarto4OIWdVBnvkArMCeecOEbu+y8PLQhIB
	6ponAN7LqihLnVf0N/yjdVVmCjxdCTVSLhTrkbDYsT7P6JWC7avYuFHpHrz/hSHn
	6PYGhD6sdte4V+OTTQQYjWrlhazuiOFmaROb1A0JW5KxSIqgcZnZ+1X46XFvIWSf
	qeG2kV9wWcDlMQ3Mk5EplVME2tmHumhVv5qXKeqFg+q9B8SWqNnC5mx6VHnXvDwr
	a3sNyH1Q4u6GWdyVhdr0TrTItngXZaO+NI/dPdMrhxrzV2uDhKRSRn/U8KyMjQLk
	DlACT+3bmup67zuX9IeYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787584692; x=1787591892; bh=4R6k+VGQFBFgbdVkejhQOb6Te72Cxsv0t9T
	gFx0RFGw=; b=eXIwBBcOMgrId0MhT7xGuonZzAYLQ9SBGCEPcbmcKyg9l1PzkUk
	Yhw7LwfYOeNQ6elISa2zIXf/jB/bH0y3Rj6zn413xCVqLf3peDLiSUaxPQ5KJXWD
	r2vqo4dA5UU65m7gG9hbdQ4Y3SOKm9upPbFANQ5GyZOQbVyCunTLhcLJki6/Ad8q
	o57O3cJ+hd8bSsJrVIrPWGAzFK1xn6GfzIJ8EdywOShTpsaSSxOXKvmnilp1INfo
	kWYfVXoO0vpHltlzokeyc6cIgR0L5pP2eyX/+17Xc2lhRnz7LZD7ZuLqQCox/31x
	9CFMvGSpZVwQlMdQb/lfoxB5gAzssyd++Ug==
X-ME-Sender: <xms:s2CMairB-nwOo8v6DJvtdmGxKRiGemGGci4o5LBN6GF_VGU1JHpt9g>
    <xme:s2CMahFzGh4bQvKRDKEQi9iGC0EU6fs26lowijrj2FmWk7m88PkpcmquTngXjM6cw
    z31aSdkCVQccQ0wo7UnTGeOWv8MU9Y1lXpV5fzp5d8yt9WJI8Q7Wg4C>
X-ME-Received: <xmr:s2CMaorashIvIbYmsjjdIYE91lHBLQGRHdYktoCSh_A3xNxTqkd2yopz3YM>
X-ME-Proxy-Cause: dmFkZTGrBq7uozOw7CWLzs3aCJpzeKWRqct+d+RCVU9svwkeowOaexP/k82TDyvrYpcQk3
    Q7jqJWPlENomBJKwj/jR2LArhCRXHgiq40dgP7t7yWSOXj11RJ6R1h7viiEzDizAYccCw/
    ZZmhfTuPIBJXVDZpD+V7oB8L2RMW4gJrEbS5FSpC1xcMeiyqq1Lm1GIn+t+Rk11YKQRa37
    VTVNYdzwafpHraSiE5HEeCM+qyaMII50+cfSXno6a41Sf+rt+vTA7/WfiycI5sIAkvme1A
    oAEOSQdFJZaPv7bp+4GSqCfjwHeGbUC2JmWAg1LPa+qv7hN7JdpdZaOlE2yR99CWq0Azkg
    Knn6habbA0x6s63gF1opIJmbmyiW/LoR0hd/CKbJM2F/hH1HBP5Nvn3iReUEKBDROVKZkv
    YhvYR6nNedejhLKFH7OXblMi0XMiyKZIecPj7KRo8Pwqc2NKhwFC0FyRIn3RCe/9JOy2Qg
    CNLQuqKyntEFDhuUlUDVH5syxGie4whYjGqUI8GnO4zYCfktmPd1GsTjMveEA1f3/oXabY
    8CYVaEo0wFrLj0XhrTrORL5xDUQ8lw61cgQsRcjswWbiisdbWsRo8XgzjFXfXeZQ5l5iF1
    fJPYCmAz3qD2mRZGL555Yz9+JwFG5ZZWvIdxyYUKAnYnARbiB5bRvHKmTsNg
X-ME-Proxy: <xmx:s2CMah4wYvZbj6R7EJ9YPrG4Gp-gGKzx-uIf6swKk5TBraFQoPuyuQ>
    <xmx:s2CMahTdQIhtSGFldSDJqf7wpi646AJCYPwHvTPJS5j2d1oiYsoKvw>
    <xmx:s2CMap5UOTk7_UI21zazLuvUr0qDgnzTCN-fRMCGx8G4kWtB0CcSYw>
    <xmx:s2CMar0Nld_nG-oHqzposRto5TvAcbGhUiHU1V9Bl8TnKuufIyhKyQ>
    <xmx:tGCMatihjfbFNlvOfqG59HofWvaw06MKJ8-znghXGqljSc1SlI8xCh4c>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 11:18:10 -0400 (EDT)
Date: Mon, 24 Aug 2026 16:18:09 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
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
Message-ID: <aoxe92BxF-5xaScD@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-4-kirill@shutemov.name>
 <3113ac8b-c1ce-4577-9e93-449b70818918@kernel.org>
 <aobglSY5L1KoIqxF@thinkstation>
 <65433d1e-95ca-4434-828e-8f381d3384b1@kernel.org>
 <aow0Z6mrG2esKpRZ@thinkstation>
 <e1c8c6f5-1b5a-4cad-a52a-f7eff00997c3@kernel.org>
 <aow6J1i2G7U0spjH@thinkstation>
 <aoxPzKTVRmZgmBKg@gremlin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoxPzKTVRmZgmBKg@gremlin>

On Mon, Aug 24, 2026 at 03:09:00PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Aug 24, 2026 at 01:36:03PM +0100, Kiryl Shutsemau wrote:
> > On Mon, Aug 24, 2026 at 02:28:39PM +0200, David Hildenbrand (Arm) wrote:
> > > On 8/24/26 14:10, Kiryl Shutsemau wrote:
> > > > On Mon, Aug 24, 2026 at 01:47:54PM +0200, David Hildenbrand (Arm) wrote:
> > > >> On 8/20/26 13:11, Kiryl Shutsemau wrote:
> > > >>>
> > > >>> I went for a clean collapse.c on purpose: the engine is new code, and a
> > > >>> new file keeps it readable while both mechanisms are in the tree, with 28
> > > >>> as a plain delete from khugepaged.c.
> > > >>>
> > > >>> Your shape is less churn, though, and it keeps blame: 29-35 move about
> > > >>> 1700 lines as add-and-delete today, and most of that would stay put, with
> > > >>> only the daemon -- mm_slot, the scan loop, sysfs -- extracted into a new
> > > >>> khugepaged.c.
> > > >>>
> > > >>> If you prefer it that way, I can give it a try for v2.
> 
> Please don't respin this as a 57 patch series.

I didn't plan to.

The goal of this RFC was to show the final form I want to reach.

I will move cleanups and refactoring to the front of the patchset and
submit in small self-contained chunks while keeping the rest working in
a private branch.

> You need to break this into a smaller initial series that lays some
> foundations.
> 
> Cf. what I've done with scalable CoW series as an example.
> 
> > > >>>
> > > >>> The rename has to open the series, so it will collide with anything in
> > > >>> flight that touches khugepaged.c.
> > > >>>
> > > >>
> > > >> Kiryl, I have to ask, are you using AI to write your replies?
> > > >
> > > > Yes. I use it check my claims and fix my grammar.
> > > >
> > > > Why?
> > > >
> > >
> > > It doesn't read the way you would usually write. In a bad way.
> > >
> > > E.g., "Your shape", "has to open the series"
> > >
> > > Consider telling the LLM to not change your writing style and focus only on
> > > fixing grammar.
> >
> > Right. Asking for rewrite with proper grammar was a bad move on my part.
> 
> Even this reads as AI-generated... Consider writing the replies yourself
> please.

Seriously? This is border-line insult.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
