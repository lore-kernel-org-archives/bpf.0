Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5473A1CEA;
	Thu, 20 Aug 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224282; cv=none; b=oIGmgKWDEU+J5gxum38b6qTkRoFAWJ1pIERb4kB7D64E2DC0JAif/eyg2T2/ZF+ChJQvRjw57LDD+FBHlOy6gxv2z4hEJpmWW6SLyXVQqftV5vekxRciZzEWnSGig1BNqqpNc4scgnpH1OCOtD6fDnaQiX/KZHiDQhUnuyp/wIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224282; c=relaxed/simple;
	bh=Lb6GhQMq5eu79b3p7oVW449PP4Y18Dv/xsmYBHiZLYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxXLziaPr73k8HkMJpes/WYiSxdmXb/W4ly2ERXLMWqSxQGqgqUYhEZzYTrRquEEq4yu/8fXbVciEyyqutv+CN2nPfsv3yN2lF2FNznuNunGSDc4bRrDYfvQx99EpmVRQ6Jyb0wA5xmr+FbS1rCvwfWzJ81g5W7XqO1OSeHB5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=KU1+i7z4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PagUZJvm; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="KU1+i7z4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PagUZJvm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 701571300542;
	Thu, 20 Aug 2026 07:11:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 20 Aug 2026 07:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1787224278; x=
	1787231478; bh=g9xsCX0WBUUnfBOKB0w7/8Sors9fi6e3DmVtM4E2/4M=; b=K
	U1+i7z47jS/fBLaFTfoj6mmFdxh6iUw05H+jTqBZiQF5VD4GNTURHHD3Nsl3AkNf
	q440lJTbNRyuHU70y+RTw/qwLg5QgQMHPOoY/YvYj12IhydCO98I1j9JUHshw+f1
	FkwJSWWoZPKmbZOt3r3+2kdfxcNLPndbGwIpnOxfnZaOZyD/Iiptnx1f9/tY4bTC
	K4JyAVplLEZ/dzLgQ9p+iJh8PF61P63//nMc6Yex0dW/J2L9shCsDDdzSdcwQu6o
	VeppE28WnaHc/Q0tliWFkq5EVCcaiRlLYWP4Ka0roDg/h2eYZ3jCI/aMtPBdBb2a
	RAIpRNXn0XXRz57GM4gFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787224278; x=1787231478; bh=g9xsCX0WBUUnfBOKB0w7/8Sors9fi6e3DmV
	tM4E2/4M=; b=PagUZJvmqFmQep9zijjZCNDOkk2VTJM6cXWjSMGUp70gTevh8wI
	GB8PSELsZV52BP+N+2MiA1+CrSaBHjmSIp9FoJhIfDvfaNCWCXQjrmVO4SDNdDlv
	C5cxPXf8yUsQkFECN+CSS+/mN/RIfaxYNG/pVO5zPBXfTGnECOg16q9XnQ8i4me1
	uu6ZOwuV5MVQYEs5ASUXCeBCiSeabZpGbXYv15iiVUzmdanVvJ2P6kVDS3WngoU+
	/TBPIFKL83avXU5pC9goRqM/Wtgj4Hgy3tYRvtzh8Y6wxaxasQRXXpjeMAikscY+
	CSQp4LpVHUWY67gM+Ulw2nTy9qNQFsMxhdA==
X-ME-Sender: <xms:1eCGav41xO4Sr31Im6zqFiGb8CPE8fPWFzAt-JWQoVXuFUDjGCQZug>
    <xme:1eCGalWpRxsb-fgWxZgOrusBw7BbpycYwxJzCN7TmkBqM0qWEZxNNTs6uFP3LjUIV
    -BfEqx12170xLjX8fL8ohxJVjokCVRx7TXOP9EGSCygI9LNiRN55eFY>
X-ME-Received: <xmr:1eCGan4NZHwQx_gMpmQaQAeBEfjA6FnShBBwBT3ZKH9EOY7qh-6mi84o-3g>
X-ME-Proxy-Cause: dmFkZTE0kLAPelY3PhKKgfOZReZlwUXCE2P+0W3Lsq0wn1U8jgUAUWTZGyhI7tcRZnVTCb
    PshjWZOgj5Oe8lG1fycLvPkM2WPvj3VvahId3o3ZrQfFqXv1hczkf19HxS/ojoQQHQMG4E
    Td+uhh0fXapAah0ml84fpRB7tzK8Yw3eEnpDiyM09M80hT7656Wy1r8DPVWW5UkwozcDgc
    veEgvxmSeLwe1C1/u6343GWpJWQcEESNTABMaj282WuViN7jYhRdvbjsZz6StVtV5sUpMo
    5rWloeYRfSADBeGXkVLM+Kh/s+R0/bZngF+2STWRGn791FSVF1pf1ChlwkUilcOAiDxntZ
    dxRzYJBEyyPadtn4QGMYxkODvUaEP9m6+Ecx0DINgUHxNK0Hhnacv6+Dz0MHehkbu39EVv
    Zy9q4iPh0OAK5uFaGrzt4one4rabz38n2w1H2Cggve/3mOswlytYQCbdIdU64fiyBBAJvH
    e0ioudfoJz65Rf6nSruDUGIce598LTvLwTJS1EcoTnUPXLRvVAoejecmJqFTmc+SAOLcu4
    ipx+Nv7CcBi1uUzY6hjAZNdd+K5sAGPBh+uaSHgC+TjYE/snlo5SsVZWLZKjZOpbQitDhb
    C+HLQ/XTGjJbkQRtYtnwLnpDeChP/3qcB9DG8JvHh5AzDUYACf/rzJnr+h/A
X-ME-Proxy: <xmx:1eCGagIajLtMjAqLMf2TclkZP1geG1bLcWCE8vDugh2Fra-luva1rg>
    <xmx:1eCGaihLbHlYtrTex95q2LSogmkbsSdStbhIHiG9tCjdGRTNZbecqw>
    <xmx:1eCGaiIrDcCoQY4Bxe06GEatnevG7gW7nHu2ENb143y2hsKvegh_XQ>
    <xmx:1eCGavH7MdRTj1hgvXaLbmlT9vQFZiclztw7QqjIHo1ho8dKIkht-A>
    <xmx:1uCGaqVWpfH-32-MnAdGOVOn4Jg0MNG2WMsYrvrUzzR0lwx5d3TjZWMk>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 07:11:16 -0400 (EDT)
Date: Thu, 20 Aug 2026 12:11:15 +0100
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
Message-ID: <aobglSY5L1KoIqxF@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-4-kirill@shutemov.name>
 <3113ac8b-c1ce-4577-9e93-449b70818918@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3113ac8b-c1ce-4577-9e93-449b70818918@kernel.org>

On Wed, Aug 19, 2026 at 04:19:41PM +0200, David Hildenbrand (Arm) wrote:
> On 8/17/26 00:45, Kiryl Shutsemau wrote:
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > Preparation for building the new collapse engine in its own file.  The
> > engine and khugepaged.c need to agree on what a collapse result is and
> > what state a scan carries.
> > 
> > Move enum scan_result and struct collapse_control into a new
> > mm/collapse.h.
> > 
> > No functional change intended.
> > 
> > Assisted-by: Claude-Code:claude-opus-5
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > ---
> 
> BTW, I'm wondering whether it would result in less churn (independent of the
> other changes) to
> 
> a) Rename mm/khugeapged.c to mm/collapse.c
> 
> b) Move stuff into mm/collapse.h that a new ...
> 
> c) mm/khugapegd.c will need.

I went for a clean collapse.c on purpose: the engine is new code, and a
new file keeps it readable while both mechanisms are in the tree, with 28
as a plain delete from khugepaged.c.

Your shape is less churn, though, and it keeps blame: 29-35 move about
1700 lines as add-and-delete today, and most of that would stay put, with
only the daemon -- mm_slot, the scan loop, sysfs -- extracted into a new
khugepaged.c.

If you prefer it that way, I can give it a try for v2.

The rename has to open the series, so it will collide with anything in
flight that touches khugepaged.c.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
