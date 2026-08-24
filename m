Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA934B19F;
	Mon, 24 Aug 2026 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580549; cv=none; b=k8mmKOFyurS4csDxQXo83HehvCmioUMQhOGOzM2VKg0qdG+wJyvBI2o4zBpe8tb8YyanoFsrXRaEyYuilud1jLd8cGafpOEZ4hfV0p5i/L9ndLD8y0rbEbNI4Y+YTquwzYpKKJxhLKZnzqZ6SBKsXKRW666d7I1i9dO6haLkmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580549; c=relaxed/simple;
	bh=FsVeu71hDatFCd5Qszgti9cCU+59xcI8+r/CobTAC+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz8OlaM7OcBRSDKw6ED3POQcJ1Acv6uxO5DpGUe1G9zn9lQz0LPaSUsPSFez3PtuQebSaZBJZmdt7iyeaH0L6hZvAKCxmYIig5aC2eLsZZTlwApkPB9GRoXGZIhc822CX4t73CdddPcYAashPZacEASks/Xi9m2uDNlBVN3PPyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/BbPk+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/BbPk+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3361F000E9;
	Mon, 24 Aug 2026 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580548;
	bh=JvvHdWSgiKDtzeEGBLXovDEMQB/etn0YLv2VjHha/oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A/BbPk+FxFEQ7oFT5u7LI+e00+LwJ8IO/tJbOrC0smfoSE0yUbc9lytxqk2Yiorgc
	 tKR3edSILfdUmhd0Ib0PcfUQFOXlgk+xSApmYONRI2jpmdWiBUQSkre4Zv6YnoBQvD
	 MgeUymGFV5ALU3CHWpSHPCZxhukm+xJ7OetA9tDtw1Fqzss0sJs9oKiEBAY6fAtH4h
	 fXGpIkulZD/NESDP7H4I/qelVbDR5VuYUDcuychKaLxuk/SEEeDKYRYWLg/4wlPlHQ
	 JHutl3YkVq3R0WGLgWLowBeKwNqnrLY9oOnU9h9NjRAiKkbQ4HlRw/BMVfH4cBNuWo
	 QJ9jMLUruA/tg==
Date: Mon, 24 Aug 2026 15:09:00 +0100
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
Message-ID: <aoxPzKTVRmZgmBKg@gremlin>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-4-kirill@shutemov.name>
 <3113ac8b-c1ce-4577-9e93-449b70818918@kernel.org>
 <aobglSY5L1KoIqxF@thinkstation>
 <65433d1e-95ca-4434-828e-8f381d3384b1@kernel.org>
 <aow0Z6mrG2esKpRZ@thinkstation>
 <e1c8c6f5-1b5a-4cad-a52a-f7eff00997c3@kernel.org>
 <aow6J1i2G7U0spjH@thinkstation>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aow6J1i2G7U0spjH@thinkstation>

On Mon, Aug 24, 2026 at 01:36:03PM +0100, Kiryl Shutsemau wrote:
> On Mon, Aug 24, 2026 at 02:28:39PM +0200, David Hildenbrand (Arm) wrote:
> > On 8/24/26 14:10, Kiryl Shutsemau wrote:
> > > On Mon, Aug 24, 2026 at 01:47:54PM +0200, David Hildenbrand (Arm) wrote:
> > >> On 8/20/26 13:11, Kiryl Shutsemau wrote:
> > >>>
> > >>> I went for a clean collapse.c on purpose: the engine is new code, and a
> > >>> new file keeps it readable while both mechanisms are in the tree, with 28
> > >>> as a plain delete from khugepaged.c.
> > >>>
> > >>> Your shape is less churn, though, and it keeps blame: 29-35 move about
> > >>> 1700 lines as add-and-delete today, and most of that would stay put, with
> > >>> only the daemon -- mm_slot, the scan loop, sysfs -- extracted into a new
> > >>> khugepaged.c.
> > >>>
> > >>> If you prefer it that way, I can give it a try for v2.

Please don't respin this as a 57 patch series.

You need to break this into a smaller initial series that lays some
foundations.

Cf. what I've done with scalable CoW series as an example.

> > >>>
> > >>> The rename has to open the series, so it will collide with anything in
> > >>> flight that touches khugepaged.c.
> > >>>
> > >>
> > >> Kiryl, I have to ask, are you using AI to write your replies?
> > >
> > > Yes. I use it check my claims and fix my grammar.
> > >
> > > Why?
> > >
> >
> > It doesn't read the way you would usually write. In a bad way.
> >
> > E.g., "Your shape", "has to open the series"
> >
> > Consider telling the LLM to not change your writing style and focus only on
> > fixing grammar.
>
> Right. Asking for rewrite with proper grammar was a bad move on my part.

Even this reads as AI-generated... Consider writing the replies yourself
please.

You've generated a ton of work here and the AI-style giant replies just
create more.

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

--
Cheers, Lorenzo
