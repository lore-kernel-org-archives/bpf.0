Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE04048AA;
	Thu, 18 Jun 2026 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781807933; cv=none; b=n/djrj0U/9KFtikeZcMyVa5gclIsaAofgLlTBo6nibqryK17FqnwvgdmJKRGtQtlfHDnmXsW9cB4ZJ008PbW07TzbZ+9hi46w1jraquEnZkg7PiXTeWAOU1hntAmvlxVh2tNQObC3O8JT6QrytS/7dNFpZwgMY8Rjj+IozT8UTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781807933; c=relaxed/simple;
	bh=SX8wZq79+M4+psXDcElf7bosLtw4K0ZukwM5HKB9BnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7wx1dHJQXsN6PmvszITPoKYHaoUPAQFylb6izN5VxfT+jXI76kyaf8dlnBa3+jLvNcT9iIgt7LD5ycBCMSdaVDbz+Yqk8mfqoA/S7Gy4dcUVlTWknt+fZnX2s/2l2fCI7LUHfXr99PBQOou1wK+Jly7P2xElcpvphpE8dhwWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dFvkzbAf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dFvkzbAf"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9056040E01D8;
	Thu, 18 Jun 2026 18:38:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id x9SYV-9y-Tev; Thu, 18 Jun 2026 18:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1781807918; bh=qwqh5eZ76mKgaFMQg0L2w1CcuHyrk1cgEZhuhc/zz44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFvkzbAfQPOK4CXNEHjOU0/pafidSIvBGVQWa+M+eVk0nK+l7FxeVB+KpiPcRjhIW
	 41/E5G1uXxBXncKFyeY0GuJxv4fxduTeEPnbP8sXNoVkzzMpqLY+PWFMFxKJbBfdZE
	 COymlUbaf9iraqt6zd+uEHCya60wgCgRLrE7mQTMyvLa+ThLTpVRTp5r0RqCGYCs7m
	 JL5pqKKRjdjpx/4cItX/ksjJEt+qiu8AvLeZ9ForEPuVDVcdLxHWYqQSE+22XdwJQ2
	 5Uhzl52TNCezG7fGgFJYxv0zH9Fdme6nHdZLrgbrU6Ay7Y4PcXVeqOPjBi70EJnzD/
	 KN5wSUyfx0g9QTmNaHbFg59WiYjJD/5XD6phynGoM/CzKcGFvvFklRwdvQvWe4C3k5
	 EvcEo21v/8LVGINHIAmhKtDpxv9AzY2tCdYHSGuc7S4Q3bSnIzvKs33BwtgbMWYTKU
	 5ofvxNiB72DNUtn4EI22pIbQwqTzDrwegGLyf1+FfNCywaUSfkn/JkQQ9/0VsY5PVf
	 kprrKdQoABzkBguZvRhGgxVN04N7vtW5q9cUV7QkBXuBdE4oREf5stC3l0xg5mrXqV
	 DCaAtrI2zNQ06uCU9QAGMF1Mask20BLMySp4Hx2fSt+9HBhCvtoATqhXTy/AuZXoM9
	 /iYROZjf2CiQojDPnBfTxhVQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC3C540E01D2;
	Thu, 18 Jun 2026 18:38:18 +0000 (UTC)
Date: Thu, 18 Jun 2026 11:38:15 -0700
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
Message-ID: <20260618183815.GDajQ7F-bqTHnrakoi@fat_crate.local>
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
 <326b85af-c41a-4387-90a0-60720111934d@linux.dev>
 <20260618170913.GBajQmOQyOiBLqopUl@fat_crate.local>
 <3207a706-354c-4e9d-ba53-dded1abb1842@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3207a706-354c-4e9d-ba53-dded1abb1842@intel.com>

On Thu, Jun 18, 2026 at 11:12:09AM -0700, Dave Hansen wrote:
> On 6/18/26 10:09, Borislav Petkov wrote:
> > On Wed, Jun 17, 2026 at 03:13:33PM -0700, Ihor Solodrai wrote:
> >> So my question to maintainers is what approach seems best?
> > The CPUID stuff is being rewritten currently and it should address your issue
> > too. If not, then we need to rewrite it better.
> > 
> > Can you reproduce with this set applied ontop:
> > 
> > https://lore.kernel.org/r/20260528153923.403473-1-darwi@linutronix.de
> 
> Thinking about this a bit more... If Ahmed's series does fix this, I
> think it will be accidental. It still uses identify_cpu() and also does
> a memset() of the new c->cpuid structure in addition to the old
> c->x86_capability structure.
> 
> I'm not knocking Ahmed's series by any means. It just probably won't fix
> this issue.
> 
> In a perfect world early_identify_cpu() and identify_cpu() would either
> get consolidated into one thing. Or at least become two discrete things
> that initialize two completely disjoint sets of data. That way,
> identify_cpu() wouldn't memset() anything.
> 
> Isn't that the _real_ fix? Instead of trying to hide the inconsistency
> when good data is blown away, we stop blowing it away in the first place?

early_ is only on the BSP and you want to scan all CPUs.

AFAIR, the last time I was looking at how we scan the CPUID leafs, we do have
cases where there's blips in time when cap bits get disappeared to be
rescanned again. The toggling of MSR bits which control feature flags is one
thing that comes to mind.

But I'm with you on the consolidation approach. I think this is what we should
do here and then that will be converted to the new way once Ahmed's lands.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
