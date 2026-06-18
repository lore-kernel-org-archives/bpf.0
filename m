Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F931DDC1D;
	Thu, 18 Jun 2026 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802584; cv=none; b=UzETXbKkfq2ZqNQrcC/oSo9s5pN07+Y/gvbiPOJxrZ9ABrVgf4M80BSz+7gPYFb4HTtyjtNebI7H+q5qAs14fz5vnXEiabJsZOUr2vgIHNEmaVvUj16cqA81guysGobH9r9Kc4oqkfQAF/2ahKlX3Ej0NhYHf/cdmR+pqNYMMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802584; c=relaxed/simple;
	bh=ENpQMuYZJoBNkfXeFyOQiJiIy/YQyfAyOuHpN9bmnHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmjBnQYZKX+KtJKE2lnlj2rLjFncjYHw7SXAeFYQPDqSiHwW9xs7EkvBmLzzaqKPsogE2yEpuj2cfra0/t2jOd+MrZNKnxck7jNIZU+dsIRFAamnl678DW1feioEgl6Hw4fdgbterp9HH5DTIUdGuoL9pRkrmVDV0Mwk7+FTBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Jn4lzMSf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Jn4lzMSf"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5B82840E0287;
	Thu, 18 Jun 2026 17:09:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 66VyEZMRCJp2; Thu, 18 Jun 2026 17:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1781802575; bh=hy1iY7sl6/2Sjr/G/dWwXWxqs32V/TwIOK86/jZYZ8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jn4lzMSfz9qxGWiDiy7D3IlfchOOE3WN5eiOfV9+VM8vD8YQEB3Z/aJVIhL6/AKC8
	 aegt/8l5KXCzR3ITfuK5fpFE9wrfVG0IIvxyUNfmTnVyxCybWMoAvXoXj+P3wEgfiw
	 274kDPCu3kHPi/sX+l8lcttO+G3Uocl8j4U1fwTsFIweNMm9GaPwW0FOAUzleohuy0
	 7Ok0e07ReuV1+TQ3q7Cp/UpYCH7kHbJY412JuPav+IjbvCpXVgBZp8eMkc2wmY0/YP
	 Ekd6UWQyrEKOtBLsUjtLMXz6fA9WPAvN6iIyFlGplgoy4wKgdqVDh/bBCt8z3YrAPy
	 msFckykQCrayfA1X15uXAAqxz2xXFMOQQ8EV0ydbBCVc49H3PebThmZszAks9smhRe
	 2SgB8I9d5+1YUDy9MEURMB0wKmDzHDWZN/kuxWsvTCeWga3HgkgMg4RSMT6b1sBmGc
	 omdo53zdjfuqJ9XnJgE++0qJXGjaMawYtGzZdRzC2/nXFPgePjX/aXrGxd4XFpFUgf
	 993gGw6PSXEnde0+Q9AQwtCycg7OVxkcm3pssUU3eEXB+4lnztTDjMwLzLNckqmPXQ
	 K8CutW3K6oKHQq9Oui85W/c/3aAxp/jY6VqhABYSek5Fje8MD2DA+KtIkJW09zXuGi
	 wNcG9aEzRIEe/zhxarjR/PgU=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0BCF40E01D8;
	Thu, 18 Jun 2026 17:09:16 +0000 (UTC)
Date: Thu, 18 Jun 2026 10:09:13 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <20260618170913.GBajQmOQyOiBLqopUl@fat_crate.local>
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
 <326b85af-c41a-4387-90a0-60720111934d@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <326b85af-c41a-4387-90a0-60720111934d@linux.dev>

On Wed, Jun 17, 2026 at 03:13:33PM -0700, Ihor Solodrai wrote:
> So my question to maintainers is what approach seems best?

The CPUID stuff is being rewritten currently and it should address your issue
too. If not, then we need to rewrite it better.

Can you reproduce with this set applied ontop:

https://lore.kernel.org/r/20260528153923.403473-1-darwi@linutronix.de

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
