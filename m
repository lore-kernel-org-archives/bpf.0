Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70688480947;
	Tue, 15 Sep 2026 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469167; cv=none; b=MbumCuYbNDBy4Zy/RgRKiYnWrlGMYKflJXHkgY04TBvH4weERLkvpQwUxo0/0CISSwQxgbruthDiBlrl7Cz2nJtbImgQY81QzWPn2wbjgrTHCd1LwudBSy3SKAExS02FkQEklDrc1kMDkHFuejg/mnYogNXNrpPe0rzBEfEn1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469167; c=relaxed/simple;
	bh=tPPCaI+dc6oCnB4eW0zp2YzwMrmZd7d0mP5zizY6mKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM1/+WqdQUvK84ME7wXVO2XCklRVn+isfdn5bmlDpEHWKPe9CJd1fLI+cTGZxJxlRux5vWZxdqQEIOQ84zOb9AQlKiizVHlNkMWSeKT0QAQLRugZNBPQk08KG47sRyxx9Tm6AETYx11zKj6B7BdxdGRtGASNnqICRBgI8L/eTew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=L6Rc9ri6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=prKVy886; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="L6Rc9ri6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="prKVy886"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id E145B130051A;
	Tue, 15 Sep 2026 06:46:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 15 Sep 2026 06:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469162; x=
	1789476362; bh=r3KZSIAXGNgRgXQOPp8px8yy9kwrf84Q26i0MJdE59o=; b=L
	6Rc9ri6gxOuiD4wi+F4wef0a+UJG3EiKJgnLWTLHVEuP2+3wj7T8IKZ0B6yDEWWG
	Rm4ZRGyt51MckaWR05Hr0T7xAGvJE1ALKaZd1VUKZgJokVcvrRTR7mUWsWRqXK2E
	9+hdo5R2yNg8kExFfkOQ17IGg3Jw+kuhOZtz9N0fC4Eh9Oga3O5w95DDEze/K3T6
	I1nJLl8V6uAVt03r/Z3CSUr0gayS/pNXiEHpjJi7+CgQAKIy1lxlU/jT3MRV0cNP
	OKVwiEHLiK2BmanG+W8XUrQo47YFtv5+v7VrZqADMQfaMmTJ/QQaXjb2SyeSVIbR
	UfCmgsW2N7P4jiCYK7yGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789469162; x=1789476362; bh=r3KZSIAXGNgRgXQOPp8px8yy9kwrf84Q26i
	0MJdE59o=; b=prKVy886uXsn6neUNmcdJmKXoR9+2Oz849wVpc5xfxikecwlI1v
	OzTaFGnwulqZJsN3UMQ5VPHGPOcKz8ao3fvIBIxcZwacIJyFJHFvtfUhyLFjjY0S
	tu/wZ0EKacJ2aleR1w+W16vNGjBiWW59PmESpJWe4sqC1c8sUAVCAkdllibLM1Gt
	JACF7lYog81yldUY55iIK0dJDUioDZofFF+gf5+JoQi70DEeKNg/AYfMbm/MxE5K
	yfSlV6GWZP3WU7W0ZC3I3QvwgzUjTRBjPVk/pLkMd4ArdYD4nr/XcWFFrogWI0sD
	vb5KsMOM84YDaUtr2pJGLL6zjS0BSZW5N9A==
X-ME-Sender: <xms:6SGpavVCAue0eV8cvmHt1ZCUzT6awTHI5y_G8H-cjxPLULy7t9yadg>
    <xme:6SGpap42XUC_IC4BjACzT-tlborJZP-U77tyl_4xpZchdpZVxMrkC9r0Y87lws1Zw
    A94vbuVjfertnWE1tp1382I-eUaB7y6HY67AxPpzUg05ab4kQofEtef>
X-ME-Received: <xmr:6SGpaqJcFbEvAl65vM5X_uwTe1dEIaQDTcugMUgG0htPpEOgLEEUHRxiSqE>
X-ME-Proxy-Cause: dmFkZTFDaruGlOr6fTdt0YZFnkPzwcHHkwV4lV9ndG6J2fASDcnXeHcQHuo3f91XsUJ2pA
    HU/uv77nPp1rP5u/CbuPdLN/p1jpq3LVrMj2+B0r4SYZ7ziJEAJcJenoZ8R0wqbx6uZdgx
    iwTu6LwFZHMvs/xqnUg2729mQ1gnrMulHt85qf2gQIHouioHBhh4T8jxnHZTj4Ry1kp9wz
    upUTCMcgIk4OAkHdMZTxTifA04sMoR4eTQ43U9O+yMhwCEBYBv0BpxD4y1bzDxD6miaZ+0
    f1p8SRDckwuQcEfweit5QYJe3BE3SEy4P90VboaSv38MUixnvuoBh8IePTHqg6uI6uPwSQ
    9TnlZDd3WFxpHdKywm9yfMnU/s7dF/B8Dv/U6Mr+3+8NScUaikLRHSGmTXPt+/oh6dqnmk
    6e/qjUYVd0japbWkdvtZpESil5JyXy91rl5ZhL0+cWwfCfNqOkCDdT+5qnXiTucG0iuVtF
    EkDTimZuGUuiqYGPAyIrjcyUXuso9C/YJp1sDYYIcDspQyRxdqx/HHBc9WMlpIkxe8qydI
    9ecVBuO3NoCqT3ImcHztcP3MfpOaGOm+I7hu0xyohn5YiEyq6gVd6BnqgUe27onY+gXnNB
    35uBC2q/EENiA+1aXvvah/BYgPogoJCqQsxuAbiN8clRuqmZKm1nn8TiWeww
X-ME-Proxy: <xmx:6SGpakhpOYKJaTFw4kZPYqtjdtCwcfNdN7HVop_yjwrlEWB-d4LxcA>
    <xmx:6SGpasK-800YAOZRVu7WXruEk_79vLmMCl6tQEVAZtTR6UUIhZoX_Q>
    <xmx:6SGpahGXgD-PlfvDBrMuI_H4LSSUXL-bLvomY3yUdXoMhyBTszbf-A>
    <xmx:6SGpak2rKS216hDIjSz-nBdsOO-FC6wZhkrn9oTdK17KmMZ7K01OgA>
    <xmx:6iGpasX0no-uhE96hzvYa67Wne1yGJN4-TV6_rq8-nnEI3DQG57hLGFw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:46:00 -0400 (EDT)
Date: Tue, 15 Sep 2026 11:46:00 +0100
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
Subject: Re: [RFC PATCH 00/57] mm/collapse: rebuild collapse on migration
 primitives
Message-ID: <aqkg_iU46BJghUNk@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <9f51ac27-24b2-495b-b397-84865f977d24@kernel.org>
 <aoXRi3ngBhO54Akk@thinkstation>
 <fd179a26-fd69-4b5f-9af1-b3755ba9030a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd179a26-fd69-4b5f-9af1-b3755ba9030a@kernel.org>

On Mon, Sep 14, 2026 at 05:07:37PM +0200, David Hildenbrand (Arm) wrote:
> > As I mentioned above, we drop the ptl after the freeze. And take it a
> > second time for the install.  Allocation and the copy run in between with
> > no lock held -- on 64K the copy at PMD order is 512M of it, which is why
> > it cannot sit under either lock.
> 
> Hold on, are freezing all folios to collapse? That cannot possibly work with
> COW-shared folios that are mapped into other address spaces.

I break COW for worthy candidates in the faultin prepass before freeze,
alongside swapin. It simplifies the picture substantially. No rmap mess.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
