Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEF728850E;
	Tue, 18 Aug 2026 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058385; cv=none; b=iwcIVmXxvTYEpByMN3ziPXrGDAwYkzVOUum6/RhLWOz02uktXEgCAUpAgwqcI1Hmw1bgQGhQv3dSNdIdb+raerhToF6795/SqrnHgAT+0kMwSfodS8s6XpFqoYCyrnCWEByRZbeH0tEDfXqEDAM1m2VMfpIP6ZwlOGHTDY8m1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058385; c=relaxed/simple;
	bh=RW8zb0//OXCZ+3LgsKliE6ixUusF/NMzExmKxaGvrto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0PYU/nx4IiCFV8hj1Kz4H6KlDnrCq2xc1ko1zq34qzRvxdIFBK/r7KsxiUEEDy1yqSlld0OhgVg8DmOAVrUggHS7qSKhVhXAmaftzRkJ5ORskrhNkaSTPEwO/+9I+JWAhPjPHL4d616oPTn0ZPxN8MYAKRtoBmmjltwqS7QGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBPFVZoD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBPFVZoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6129A1F000E9;
	Tue, 18 Aug 2026 13:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058383;
	bh=2FNlOtEne2BhEcu6Y7eW1kChoZuYnNWnX7RcE7P3Zb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mBPFVZoDG/SLvcTMfgNwPH9Cb2Oc/RS/O5Y/sOn89/7RKIcKsexMMbOI7UxhXJnw5
	 qgGYBl5SRQcgYW5bVdyIgSF5vZ+AsLxvFi7Bw6rdpnr/ZzKRPCflhzjdDMUqJVqyWe
	 h/U0C7iBuN2NGm2gP2ulaBTuLXGo7pOSlPZE1gR9T6Y7A6zeCf2otS9HOx68k9skLj
	 h6eLusz8CfDbnR+Cpr7JRYS/jzjTCr9mt6r1mgmIFE8H+Wwtaa/tMKo+3z4Q/3vpow
	 4lAC7OqmrogXiAuWgMbXdy7aXV0pKKuaSNvYoZmSyijUWr2su5VdioTWYzH+IIu/Xk
	 xCwck/ygS4rQQ==
Date: Tue, 18 Aug 2026 14:06:01 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, david@kernel.org, nico.pache@linux.dev, 
	baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com, hughd@google.com, 
	lance.yang@linux.dev, liam@infradead.org, mhocko@suse.com, rppt@kernel.org, 
	ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com, usama.arif@linux.dev, 
	vbabka@kernel.org, ziy@nvidia.com, usama.anjum@arm.com, agordeev@linux.ibm.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jannh@google.com, willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 00/57] mm/collapse: rebuild collapse on migration
 primitives
Message-ID: <aoQ77EcD3M2kjeya@lucifer>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <aoLAly-oL2OAa4n8@lucifer>
 <aoLkMUtmzRVuv2Hx@thinkstation>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoLkMUtmzRVuv2Hx@thinkstation>

(I'll reply to the rest of this later)

On Mon, Aug 17, 2026 at 02:38:44PM +0100, Kiryl Shutsemau wrote:
> David and I talked about this at LSF/MM.  I can give it a try if it fits
> your idea of "feature freeze" -- and if it doesn't collide with the series
> you have in flight, in which case I'd rather go after yours than around it.

Whether intended or not you sound rather like you are trying to override me
in favour of my co-maintainer here and it's... not helpful.

David and I co-maintain THP together, are in constant communication, and
have a great working relationship :)

IOW - if one of us states a position on the sub(sub?)system - then take
that to be the actual position.

I have poured what must be hundreds of hours now into THP maintainership -
it's by far my biggest workload on the maintenance front, by far the most
painful and by far the most thankless.

I do it because I care about mm a great deal and am, frankly, driven by a
desire to see THP turn from a flaming trash pile of a code base with
confusing semantics and many, many broken parts into something that serves
the community's needs with far less maintenance burden.

Looking over your series it seems some of the patches works in this
direction (great!), but much else of it fundamentally changes key
behaviour.

So it's just a question of deferring the latter until we get to a sane
point with the former.

I keep talking about this stuff because companies are motivated by wanting
to solve their problems (understandably) but if nobody pushes back then THP
will continue to be a series of changes lumped on top of one another adding
more and more technical debt.

--
Cheers, Lorenzo
