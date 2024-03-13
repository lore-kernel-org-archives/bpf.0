Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46326C147
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710299847; cv=none; b=r5cyMU/jb2inHTZrI3Ia2nR4EwsToI8/Xe8uupDTMawyxvLHv5oLaMX72dKMUe2319aN6HHOofvax5AZbhrglo4Enws1/c8w/HlTD66iTLPb+4uJTbZ7PNCloCp0Ub62BY4bkAN2c8JSoo16kE0PMIypYV8CiN50XTiYhEd5G0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710299847; c=relaxed/simple;
	bh=VeytVHTZaDvfTg7tzEZ4AYfH7KWnF7KE/RJr7oZW/f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXEpqa8Jl36p8iMKavu6gdKe3vqFfPaph9rVg5ByNyQmaiCuRlVgSDnAZoJvFO+wB/EdzNtSegcTvWAxodF3YzqhYy0XcK6hgP3GovbgJ1SuA1hLqsL5tJWol69cU+FTl4Y3QanHvBwd5NKISi8vCaP/SqQitEnzjTA1fr1RnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Mu0t7U3E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jgaJWiap; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Mu0t7U3E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jgaJWiap"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 5CC7F5C0065;
	Tue, 12 Mar 2024 23:17:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 12 Mar 2024 23:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1710299845; x=1710386245; bh=JLxuvz4dXY
	vC57RZ5WOpbCIOv1xzOWomyd1ZNq5z0fA=; b=Mu0t7U3EIKbYc9sIMxGHol+Aer
	ekOHdfcwsGcakVGk803hdvVeDskkwvnXWTEpVqPflYPUsgBdKm3Q6Nw3DI4IzA1c
	Wa7UmDU2L2VOdYBDokafxrYgkV5wE27pGX/sEi4fE3maUAvJ4Peq9yRZFGL0tR06
	7BvFh26FCyIR91hJ8l0uTDQPvJN/w+xKARVfaG+2qsBo6PF/oJ6geThf3mkQIVnx
	0cM4ma2g7xHH86RBnuAfHTrEWwfDmZAQAh/7eyBlYby8CiJXHtvM3V1OYsBgKny6
	xw5zUXAy7A6x4YfCXRhPbZ8TBQg2qwwtR0ZTFAzRjRKnapk8HNexFSbucT5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710299845; x=1710386245; bh=JLxuvz4dXYvC57RZ5WOpbCIOv1xz
	OWomyd1ZNq5z0fA=; b=jgaJWiapVMrnenYrvJwHaaa3nKGzAHE8dSejSmkJlnEg
	lsSFFABDkMAnXUQmZRZV0sZp9ff0tGTuZD6MSVdJMgc+Zm/wSioECX8LN8K+nAMq
	+5RckMlyH7+ku1i4gjJLYip4SJuudBzzGXEVNH1+dQLJH6WOgLdpo/1alPlhnXaC
	/UwgroBgQt1aJ76RKjts7QWbP/UXMtV8yJFT+Jy8924akEUPyGQ/Rm+meAeO5qNS
	QHz3iW74ZQVwk4Euam6TzaNMBgiw+59f5WswGtyLcfU/RJD/F/zK/TQe+wwkjtcb
	rRex82PKYWYsQ48wm69HlcbEAlgBpJchpL3QqA9l5A==
X-ME-Sender: <xms:xRrxZbD5KW6Fy4PlXGqeC5pkjg6z8lDb-B3gO4-O74DRYP6Ll4Sl_g>
    <xme:xRrxZRiMabQuKl1D4i65WEyVakAh8H39XdulKm1daasEPfzDOlELeWBEg_a0LWbd1
    NCebnf8PsmP_7Hg7w>
X-ME-Received: <xmr:xRrxZWmOTpKX1D43VB6_RtZIgccTD10ov3sl2blC0SWKVYTDH9UEnGJwUv4t1TKAWuxuDtuiJVGbRFGIlP1T9kJzlIVOtsolGYMcptw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeggdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpeeujeetkeehvddvkeelhfehgeevveehveejleffudehteduudef
    heefkeekleevjeenucffohhmrghinhepugiguhhuuhdrgiihiienucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:xRrxZdxkFHsi_qAoUo55TZ7x4_MoWjLeU9VqIsgniAMFpK8f3PJ2mA>
    <xmx:xRrxZQReYLlWlvfDoQAkHLS_Vj8kg2m7qIH95reTQLrqTHyq_PPVWQ>
    <xmx:xRrxZQY8Fif-CnheZ66e1lq-FzxjtJGADaCXVzjp5P25Lq_Q_aJy1w>
    <xmx:xRrxZRSEiponSV3Qa9QGzn3KXAi2FRLWaCHwLlCoAj4nmSxOUQMQpA>
    <xmx:xRrxZVRMLg9FjpMKXD7NZNg9ogSgsAK87CubVbiZ1bkjcfD4CMvPyg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 23:17:24 -0400 (EDT)
Date: Tue, 12 Mar 2024 21:17:22 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, jolsa@kernel.org, quentin@isovalent.com, 
	andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v4 2/2] pahole: Inject kfunc decl tags into BTF
Message-ID: <tqkiee5rc3szutsobuuttgpv4ejjhnjbcfhkdozkrvxcjrp6zf@2mvkkhhbn7vj>
References: <cover.1707071969.git.dxu@dxuuu.xyz>
 <28e81ccf28d6dd33f6db50af6526dc1770502b8d.1707071969.git.dxu@dxuuu.xyz>
 <8e0580c6-bc72-4644-a010-c73d779f385c@oracle.com>
 <s3fcrvcbxjn47nw3nhcus4hmyx3zkxz26vz4ddm2fxoskacf4s@tfd2rx7n33vc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s3fcrvcbxjn47nw3nhcus4hmyx3zkxz26vz4ddm2fxoskacf4s@tfd2rx7n33vc>

Hi Alan,

On Wed, Feb 28, 2024 at 05:57:01PM -0700, Daniel Xu wrote:
> Hi Alan,
> 
> On Thu, Feb 08, 2024 at 10:00:15AM +0000, Alan Maguire wrote:
> > On 04/02/2024 18:40, Daniel Xu wrote:

[...]

> > 
> > Then all you'd need to do is iterate over BTF functions, using
> > btf_encoder__find_function() to get a function and associated ELF info
> > by name.
> 
> Didn't know about this, thanks. I'll take a look at if the patch can use
> the existing function metadata. That should get rid of
> btf_encoder__collect_btf_funcs() if it works.

I experimented with this a bit and I'm not sure if it's a good approach.

Here are the two commits:

        https://pastes.dxuuu.xyz/xo9jwk
        https://pastes.dxuuu.xyz/xmzew5

Basically my approach was to fan-in all the function info collected by
the different threads. I don't think it'll work cuz some of the data
(the name in particular) in struct elf_function belongs to the thread's
struct btf_encoder instance. Which is all freed by btf_encoder__delete()
before btf_encoder__encode().

It could probably be fixed, but doesn't seem very clean to me. So I
think it'll be better to keep the code as-is. Unless you were thinking
something different.

Thanks,
Daniel
