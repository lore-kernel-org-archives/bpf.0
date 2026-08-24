Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41240407CDC;
	Mon, 24 Aug 2026 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574970; cv=none; b=sg90tBP2Bi4IEdlZpgjoPnn9T00ygG7eulSZecVwe3qSjosbiKQyZ2gbUjNlGxmJU+mZ3tnZClSJGpyko3dcw8RdLM6gGPgGAHzQVhdJ4mN01YTWKWNPq0+V6VlUrJDqEz+odSNwXCfm7xtCCH7qs6JTGWt7lwskf5jvb6T1Ft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574970; c=relaxed/simple;
	bh=E30+cevaORePpAWWr/679C2MvRN5qNVL1DZyBYYvRkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAOqUL/yCj4RFBgKm1WaYdZX0hFqMRwoNOU0cvFFcSTSiahj1NWouG2YVOOIEAB3/nUcyEK2Oa5Pz6RIfsUyt3EPQ9pAwtzNJxzhaPSU3eFjZ3Xoh0WzhcXti4yjHF4BQgjKZP+yUh1dC+6O+jA/1ah9c3+2IkniD2otomdza1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=XNwaLhEt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lAaqQiL6; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="XNwaLhEt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lAaqQiL6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id E7350138016E;
	Mon, 24 Aug 2026 08:36:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 24 Aug 2026 08:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787574966; x=
	1787582166; bh=Halq/ghpcpjzwRr3hDl5BiBIUuH+KlXyRVEyX5gTykY=; b=X
	NwaLhEt6lreAhnuNhuYe63yeUnz+8ExWqYEdcHnZCISOYS8/qXsSqpifilTYi1DI
	8zo2jldWxtdl4pD8CJlIWfW9CG/NLLGislyFEzxc3gzE9Yf9vKZSoWATbHtVUMxQ
	pivnCFwCWoYAl1Kpqp9SO79QylBp6KTbJlexw+k2icgNKIdtoG8AMZmQvEEVak7X
	JRDIwY0ypINns7AT7bbRaSwSxfEBKxeXJJ8Q6sMLS/8QluI+Lwkriup7kOIe6fb8
	58GK2W8pKO+y7ajxH7O/eM8O8EaWbu9GYQnEFaSjLPOgpGhdzTs6S6cgOOwcPVV9
	aNDMMTqSAif9XoQFllo4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787574966; x=1787582166; bh=Halq/ghpcpjzwRr3hDl5BiBIUuH+KlXyRVE
	yX5gTykY=; b=lAaqQiL6lDNBiMyO3Z7e08OKXhMvrp5xhkZoYhMTbb/j8K7Q329
	myZFj4BjPqbhIsI3djhffaIuvqkSsnJ8wXjKI7dH98N6En7feIz1tXfLNQmVmJd6
	nJ21tQdjsbSYIyWbYWDiSmCK7iw/M0dtpn4CwgiBH8okjUQ3bbmk7f9ecL34EiN+
	8bxghrtPFKX5rXtR3ph4tfwUWzA1IZ1XnHFYLoVV25mbsCuw6r/boNFnBbMwYEXX
	8dZSpP1c5BnbPIPoAf3KxbAHMTz74Rj7HAqwKRiU8WNXfuH9jBlI2IuPSO4rI0Fd
	qZsLujEYC79xHlTreIQjbkgjfdpoYzJR2IA==
X-ME-Sender: <xms:tTqMatE9POykR7jIxPD9lT7tQRJ_-tdaFro38r-Y_nrNISjrxn8SCg>
    <xme:tTqMaiyQ7g5tidC7DNd8cz6-HuP_MQQXOqZqmWReC0S-PIM_h3P80hUmkHC3Bt1aI
    j5nyXQOdx7L0Tj8EVuYmruv89vq_XiTNRCEZJ0Pr0of1O47_ND5Uza5>
X-ME-Received: <xmr:tTqMagmBDW5MjyUhQ26nLxMFm-wtpKIkyE154-qRIyzyMo2AVu-R3WZwXXw>
X-ME-Proxy-Cause: dmFkZTF5asgg6APcHCRRNjBCQ9gXGuK668V8MVNtl2aHA4haIibMMp4f3mU+yDh2HpFJDp
    VGKvyfsEX1iisUN0oqJLUZfcpBudESliKqaFOjN29FGcLMQCGn8WzCD04M2gPcqh2jOXxq
    TWnruryoiEaOIooipC/o5/MDxXkEEbgRERWfvB3dt8tPQpH9AFStR2lQR4bB9O3re0vryU
    7C3LwMzGnKw6zBjJF0G+xJ+GRjs7okbNLLc8dp5YQcQK5Six3viX2tWrqs2p/aeuTnIIcM
    Q8+LtpYicGcP7U1JC54V/izDp1hRw8aC/tlX4mikhZ5SOri7gblL2enAiIAFgJxVoWjAYY
    Rfval5jE8DZcqhBmfu0ydqxPIOi/NiYqlAU11QhGJpMeHrURgNFF2OA0S8Ysz6Jwt9ats/
    B4EHeVDTOLRJebKUiFqIyvIcqp04ZI0LJ32DM0NNSWN1L+XUHuXgFR98hTlXAVgUsCZk/n
    eq8r//W+ksz63YcYPzIZ9w+9KtMOse/d+yVYekz7F0doIARM/tnzGwBbW+SJVbcaaVmUx+
    qe8/cKpSB64Vme+mQdTDfUZmVf8g7sD0N5nZvbxzExcHVwh2xL2wdI2WJw6LjYdDcsn+ct
    Cu+PTZpzEPcBo00oDOWorqPCg/9nbFDNRZH4MoaEEgLwR5PdW4ACMKPIzUbg
X-ME-Proxy: <xmx:tTqMajEupezKhPuT7WIpBHJwmpvwG2t9wQwMY0YCQDUO1cdslQ1Zjw>
    <xmx:tTqMaisdkEYUs9T-PmIn6tTiigbTagx_vCnbRV_i7aa1vOxJT2nqzA>
    <xmx:tTqMamlIwHsafL1sXhxVcsGwLPQvGEL_okVBmXvuostnCpngnSJUvw>
    <xmx:tTqMaiw9NztmLX6IU7iPoQJX9YGE3oiM1shaUWUGCpWRu7UHA2lvuA>
    <xmx:tjqMauvLoeCO_dMAYDuNOv_aqgV2Yg2Na_2VUUSSvBzyiYAq7zYd4Nv8>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 08:36:04 -0400 (EDT)
Date: Mon, 24 Aug 2026 13:36:03 +0100
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
Message-ID: <aow6J1i2G7U0spjH@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-4-kirill@shutemov.name>
 <3113ac8b-c1ce-4577-9e93-449b70818918@kernel.org>
 <aobglSY5L1KoIqxF@thinkstation>
 <65433d1e-95ca-4434-828e-8f381d3384b1@kernel.org>
 <aow0Z6mrG2esKpRZ@thinkstation>
 <e1c8c6f5-1b5a-4cad-a52a-f7eff00997c3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c8c6f5-1b5a-4cad-a52a-f7eff00997c3@kernel.org>

On Mon, Aug 24, 2026 at 02:28:39PM +0200, David Hildenbrand (Arm) wrote:
> On 8/24/26 14:10, Kiryl Shutsemau wrote:
> > On Mon, Aug 24, 2026 at 01:47:54PM +0200, David Hildenbrand (Arm) wrote:
> >> On 8/20/26 13:11, Kiryl Shutsemau wrote:
> >>>
> >>> I went for a clean collapse.c on purpose: the engine is new code, and a
> >>> new file keeps it readable while both mechanisms are in the tree, with 28
> >>> as a plain delete from khugepaged.c.
> >>>
> >>> Your shape is less churn, though, and it keeps blame: 29-35 move about
> >>> 1700 lines as add-and-delete today, and most of that would stay put, with
> >>> only the daemon -- mm_slot, the scan loop, sysfs -- extracted into a new
> >>> khugepaged.c.
> >>>
> >>> If you prefer it that way, I can give it a try for v2.
> >>>
> >>> The rename has to open the series, so it will collide with anything in
> >>> flight that touches khugepaged.c.
> >>>
> >>
> >> Kiryl, I have to ask, are you using AI to write your replies?
> > 
> > Yes. I use it check my claims and fix my grammar.
> > 
> > Why?
> > 
> 
> It doesn't read the way you would usually write. In a bad way.
> 
> E.g., "Your shape", "has to open the series"
> 
> Consider telling the LLM to not change your writing style and focus only on
> fixing grammar.

Right. Asking for rewrite with proper grammar was a bad move on my part.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
