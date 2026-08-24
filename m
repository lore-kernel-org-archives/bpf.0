Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C8F3F328C;
	Mon, 24 Aug 2026 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575081; cv=none; b=NTphdmPkF2HA8UFYJZFv1sv1HP1UCs3/bg2yklD/APKvkU3/ztlPhKDzoMIZTQJrzu7g1TqY1ZZkF8tgVwkiAPCoTHjw3AK1u08MH5jJ9KhVuwJVGDxuZnmm2kkbUcb+66JJFKo4SmN0Z6WGWZvkqbJMTzOaG4Y5iN5TyZnoXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575081; c=relaxed/simple;
	bh=YuKm5h4FJivTzNYFtQBsp3v95fibyY50aVxIZ1hFB6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJvPpL63Xr0Edm28rVSjCCRAS+VofN9FnoZzOVCJl+v5Joy5RFFj4nVKREGJcHeqejReWrCYCkQKM3WSXqOe8of9pHfHkxnUBNNlzLdC+Rp6kzSUnhkuph+lfr3YOzKptgo8OOfrrm4DZ+DbGMJxxQBA59TNIhsOeoxppuMn+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=SJOBuqoT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y0T5/pTM; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="SJOBuqoT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y0T5/pTM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id ACCAF1380293;
	Mon, 24 Aug 2026 08:37:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 24 Aug 2026 08:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787575078; x=
	1787582278; bh=4+ZXrHhOcBNBIWSTKX8h/D+gSOatS4LTJk6DxU43bvs=; b=S
	JOBuqoTpRZnoUcj18paDGTJxmqQMHeGAO5tqVOMb66NOsjBsqN0usyDojsqHFm8o
	YwhyH8Qge/ybjiXY0sSwgbOXtG0A+yk6xGopSvJyVUugG6tfD9dpGLBOgVrIwuHa
	tT3S/LPCJThrY5PEDkrjeOPNkyfM9plZ3H5R1dYxxnph67zJCb6TgGoatk7jjNJl
	ZTFj8yrOz39JuAVZO0+XNfTybA/KLxtq/o7U2k4Sbd72q+HWV3VFbEzxj6HsDbSu
	Kb3KeFQJe300YRMCVnbDbvI3YSy9RkzB+NIaJmMwQMMgBiqPELjbY2DuAIkxh4xj
	npFAnGnfpJQtdoLL9uItA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787575078; x=1787582278; bh=4+ZXrHhOcBNBIWSTKX8h/D+gSOatS4LTJk6
	DxU43bvs=; b=Y0T5/pTMB8VJ8mAceiSRNanYWt5zXnC43h3jCMJ9QAWf04l2swi
	pD5ddTN3S+Nw1F5JW+8vuLVAorMf8hW1spoGbvc1O8Gwgot5R5z6P6J9nlUbmFG7
	/1hv9zWTuy5ZASLdgxjfiZo/OpS85uzxwTcUAXIokMhS5v0ikDpS8JNm27I8cW8Z
	UBKnsm+/NlfubBzl3AKjtZqVvNqAaNC1UUdg8Umse3u15hFTGUV0hbICcG9dUyFc
	GLlYFnGREr6vb5eH1q0AylyxcPt0kh3yhmurEJ/mQZHJ68y4hLKJW39T1q/msfwy
	CiryKQAfbho+uBRuEJLMm/BK1/MwPB7AeIA==
X-ME-Sender: <xms:JjuMauxO6FySxIcOaHs8arOohEaT0-DcSVy5FI2jB-iQtE_makpRZg>
    <xme:JjuMaqsadM63Co14tbsXNwp4z8utQUMx6Nm32_8qCg_8jEK18Voch4B4N2P94_jk1
    xY2Fu-W8Z2tRdqvHghcDv0SrgI8jXoSM_QEc9VtHd5ERvLDI_oc1dBx>
X-ME-Received: <xmr:JjuMahyTa8PTHf-d_XN6m8oBoE4uI8fSJLDXQFO4Zj16Ww4D_YWd4upLLy4>
X-ME-Proxy-Cause: dmFkZTFatED5oZ77MZ22tmOlCD7GXKUCkzazb9gE5N4jgJhO01yYiclBrAnEbUBwSMdDoc
    xpS8o1ggZwKBr0QTMYS32p4YvobQag58DBIKQmfASsSYKFAQkV56vf0rfC+M5T/OAxyf9+
    0BZZrbk1y3cjZ7YKuDxC1b7JW+tNrUw6zPDKlukbK3F1Ex8Ss+kandwlYX1KARtnat28hK
    +dtQLf49G4LcemSGTffDvkSTWzHV3mDceKuVvXIWrRZx5JR0WlkLGTn9wDNBBZi/llCEgY
    dyPJRCsKQyE+/7S/K1X1tfD5wJhh2tcYYfhhBh9LbMoMvU6qhEbhxGy/O6t5DGZuoCPFR8
    yte7bPjdZw6iZbXU1WqcKwdEQD+O45PZpWtLMr2N2TfP9kDgMEcFkVGBIQCGc4hZghM1hx
    HB6bGHOO1H3WwR8Igy6WL0tBYTv2HEkz3LZkl/Uu28pT5K5aekNMDVy6452N2FOOQSl99T
    pTQg0PGbhGIw1sz6c3kzH7JbbE+CUGVqMcgkMRsqa8VkM0K4ul76/czBecME8fJQlNok2e
    VOnYxVTTGDk9pI8UG4hofchPXLr85+xVdD/TArfiawIBOJNLbNPW7C8IdUjB2Ebgv/ApYq
    yvyePaUH7xTtILMBfO2o0Q+CTU9+OpD6r6t/zIEJaG8WKE7p9Jdnxbb2XkLA
X-ME-Proxy: <xmx:JjuMakjyc-2lgDWCP_lubdQSINTnPd2c7mC3kuta_Tj3w4HCQixyCg>
    <xmx:JjuMavZE-hmQOIB3IlqJr7s_7f2F7PxPD-3h2S0jrAUGVP7n_9YcIQ>
    <xmx:JjuMatib15jvUIdzdqXUBi8FczOeLG2jOwd_rCWLD5tMHYsbTPydMw>
    <xmx:JjuMam99b79C06mkp61kQLmt3F1GM_CkeV-aY-YV-zYhcOTJP-08Mg>
    <xmx:JjuMagJMmNs3FIFLkKCEOfVwULclr412rRPHM0btNEi_XdxgVHRK83jj>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 08:37:57 -0400 (EDT)
Date: Mon, 24 Aug 2026 13:37:56 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	nico.pache@linux.dev, baolin.wang@linux.alibaba.com, baohua@kernel.org, 
	dev.jain@arm.com, hughd@google.com, liam@infradead.org, mhocko@suse.com, 
	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com, 
	usama.arif@linux.dev, vbabka@kernel.org, ziy@nvidia.com, usama.anjum@arm.com, 
	agordeev@linux.ibm.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jannh@google.com, willy@infradead.org, pfalcato@suse.de, 
	rostedt@goodmis.org, mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH 12/57] mm/collapse: allocate a destination per
 candidate
Message-ID: <aow636Xhrof8hj38@thinkstation>
References: <20260816224609.308019-13-kirill@shutemov.name>
 <20260824112005.63097-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824112005.63097-1-lance.yang@linux.dev>

On Mon, Aug 24, 2026 at 07:20:05PM +0800, Lance Yang wrote:
> >+	if (unlikely(mem_cgroup_charge(folio, mm, gfp)) ||
> >+	    folio_memcg_alloc_deferred(folio)) {
> 
> One small nit: folio_memcg_alloc_deferred() passes GFP_KERNEL to the
> deferred_split_lru allocation.

...

> This only affects calls that find the metadata missing; after it has been
> installed, later calls take the fast branch. Still, it bypasses the gfp
> with direct reclaim stripped for the freeze window. Could
> folio_memcg_alloc_deferred() take that gfp here?

Right. Passing down gfp is the right thing to do here.

Thanks, will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
