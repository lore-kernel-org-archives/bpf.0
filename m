Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D01EB2C
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531809; cv=none; b=MVBCULN7FhVWHvV5IeJFi1Ux8l/SbzlK+taXIf2YXZK7QcBdilWy/Vjgq/bNKaQzLX6jfs0+Of762G4V0MjArfR13P3Z52orvqAK0O2HcNF0mud8rm6T/eLwb1wCecACa2DG9Cejy3ttalilDVxSUgL3bluJtWthcN+BL28cTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531809; c=relaxed/simple;
	bh=buLb+owpdciph9dPh2OkZc6B2bg0sd4Sxa2gBjBRo6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyPKiJ4dw3KY9W62EGSNRajr1R/IEHst/cUNI/09ja/NXaYTKk6fXYXHrBlH9TXevplv3aYzFOTS129T5fOf0cqy2HgQudhWItCvvhIxV6wd6ABgXJI6l9WUcruM6rUsXSmA8OR8OA8gPn9wYAwrmXDgjOWH+s8bS5ImAUbG2SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=ajFBB8EZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mn/7CN7V; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ajFBB8EZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mn/7CN7V"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 70C335C01A2;
	Fri, 15 Mar 2024 15:43:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 15 Mar 2024 15:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1710531805; x=1710618205; bh=kiqrEF6yu4
	KatRRIf3QuAVNOsMn9S0lqz0TQKSVpJq0=; b=ajFBB8EZax6yRYGQYzA+LKdSc6
	G4IAd4R7d01dHaiEQ07QInYMlu0yMKH+TQ5iDU7AF+3WCIyT9y2alOHKev7VFHJY
	oEbczlMVO0YenSDuo7m4wby1WFb/zLUvrEr8NSL4euHm1ofhlGYeLoBR5RpFQwfT
	Mdk57q5zw21hoT+EaWSTRqxAEQThJkQmQ3m/ge+tyaepGJwAKu3H7rtFpWh7AQi3
	DE+1XfLaI84TsTUayMJPtYtaGPU1R/k8DUgzOrUvxDgEN/U0is2O+mMQ6wy2bGBb
	VSJyJjlKpM3bBDlD23G2XUqFwFHk5P+9Llj0L0eU/3SFfAGwnesMhRcN98zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710531805; x=1710618205; bh=kiqrEF6yu4KatRRIf3QuAVNOsMn9
	S0lqz0TQKSVpJq0=; b=Mn/7CN7V9nqpuZLGKZlFEq1RZOsy8UE1Txyen978Bg2E
	lPerHL2CeXQD0SsDbKNXTu7NTppbjVYRI6Nb5bNgpbXVjnxv9iZwXCG/Y4o5Thnb
	YQC7ekuj1AXovSzbbePRxN1+XkyogVsM/7uWcvzXKkrMIvNo6eu7AT0Se0Dt6lBR
	ESpap1bvuJIqxmV2HTfpEKYhooCygvPo/iwAyxkVjXpdjKwuCVamtkxVfxxfd3nq
	Ew9+z6WrY5m3/5Ui1uA4FlXUqTF/SG5iUQx8Zd5udgUEUq5hsWLyNQgM032WzxyF
	aldioSJz9bjg8MCloX/K57s6KX3GvKftpmqxi7cmgA==
X-ME-Sender: <xms:3KT0ZRGEvuBe2PyH31qpVpLA5P6FpebCX4xUsaHvjtxCLDtRMkr65Q>
    <xme:3KT0ZWWdZ6FYSxJO1FXuDTYw6LftsTv-OXWr0KTZcR68YJEidKYrY-YLrIjMpz341
    lR1YxjxcE7HglItsA>
X-ME-Received: <xmr:3KT0ZTIaA3enLil_ryti9VkYKNNQg2fJMY2p1XrHIVRQKAK6MfDeIgde5iNXay4KIo1OuuJdhkYtijDTrW9Tp-W5QzyFxIkSwyDLqMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepueejteekhedvvdekle
    fhheegveevheevjeelffduheetuddufeehfeekkeelveejnecuffhomhgrihhnpegugihu
    uhhurdighiiinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:3KT0ZXF_1jxnd0Bp7crZeeqCUm3XRzwK4E2KUqZulUzX9ozduON5pA>
    <xmx:3KT0ZXWNQ1T_3xPQMZIn3s-qC8xHe8Rv7TcRvVhOymLw3jgziS4ROw>
    <xmx:3KT0ZSP1nPAORsmFUhzxURc8u7JQoHigpXFFyt2ZAe9yLGNqcLuVQA>
    <xmx:3KT0ZW1j8z_q-2gphDBReuPU60qRYsxUoaYK4ijyVmWRod4rwjqYiQ>
    <xmx:3aT0ZTrzVBR0Cf57cXWasN0B62BsipKHOTsujRkPNjuDeMUPsweLmQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Mar 2024 15:43:24 -0400 (EDT)
Date: Fri, 15 Mar 2024 13:43:22 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: acme@kernel.org, jolsa@kernel.org, quentin@isovalent.com, 
	alan.maguire@oracle.com, andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v4 2/2] pahole: Inject kfunc decl tags into BTF
Message-ID: <itgzcn4cru32sk6sswbami2ojdynwyrfof3pnx5v4j3walx5oh@4qi3337fqnrz>
References: <cover.1707071969.git.dxu@dxuuu.xyz>
 <28e81ccf28d6dd33f6db50af6526dc1770502b8d.1707071969.git.dxu@dxuuu.xyz>
 <1853738ac796d75c53970e21b6d61bf5140a6cc1.camel@gmail.com>
 <7bpvkfzqfawuzltt7jicekwlbxokdbprom6io3fxef3rbng4ud@hwohkmt662ar>
 <773a54ed9f0cfb91c1b7c1978070bb86e42ac568.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773a54ed9f0cfb91c1b7c1978070bb86e42ac568.camel@gmail.com>

Hi Eduard,

On Wed, Feb 28, 2024 at 11:33:28PM +0200, Eduard Zingerman wrote:
> On Wed, 2024-02-28 at 09:07 -0700, Daniel Xu wrote:
> > Hi Eduard,
> >
> > Apologies for long delay - life has been busy.
> 
> Hi Daniel,
> 
> No problem, thank you for reaching back.
> 
> [...]
> 
> > > > +static char *get_func_name(const char *sym)
> > > > +{
> > > > +	char *func, *end;
> > > > +
> > > > +	if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
> > > > +		return NULL;
> > > > +
> > > > +	/* Strip prefix */
> > > > +	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> > > > +
> > > > +	/* Strip suffix */
> > > > +	end = strrchr(func, '_');
> > > > +	if (!end || *(end - 1) != '_') {
> > > 
> > > Nit: this would do out of bounds access on malformed input
> > >      "__BTF_ID__func___"
> > 
> > I think this is actually ok. Reason is we have the strncmp() above
> > so we know the prefix is there. Then the strdup() in the malformed cased
> > returns empty string. And strrchr() will then return NULL, so we don't
> > enter the branch.
> > 
> > I tested it with: https://pastes.dxuuu.xyz/c3j4kk
> > 
> >         $ gcc test.c
> >         dxu@kashmir~/scratch $ ./a.out
> >         name=(null)
> > 
> 
> The test is for "__BTF_ID__func__", but nitpick is for "__BTF_ID__func___"
> (three underscores in the end).
> 

Ha, got it. Didn't see the 3rd one. Fixed in v5.

[...]

Thanks,
Daniel
