Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9849738E;
	Fri,  9 Oct 2026 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545509; cv=none; b=aS1fsE5BZj+HiZ2/goEO/8zrtAIX/HGpFOYNLUqZZEsyAOgOgY9aoOaNeKYJnJV4MrsZJEy0W7j1rWCZH3TCh7GSDhJctaGIGpoTEIWE8qN1QAJAybC2GHyoqR1YKdYJdO48Vm8yqORjFAZZew+3BqsDPJlb3rqvxAv6Ot4HjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545509; c=relaxed/simple;
	bh=TDFEYy/Q/xEYECc94YNGYpg4Q/2TeXJxyRpR1xMyR2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqa8IIJdXQeu/QLvzXkSAw78hSXi0CdypRqSH14+B9l6P3fC1Hm++PvzusuK2GG72DKhX2+ZByo31BciJ51ikdQ/HtciPufkTnupnb4CL3sg0pJYrqs78vVq/cHnULLbTframx6Zum7GzfljXjSRXRVe9xf27CMfk+W7F3AYbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGmJi/3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGmJi/3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45301F000FF;
	Fri,  9 Oct 2026 11:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791545496;
	bh=TDFEYy/Q/xEYECc94YNGYpg4Q/2TeXJxyRpR1xMyR2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nGmJi/3WdIz7DcgX/GzMzaKt92xgA+x5e3sBci9m0VGBd/McpS1+zBtQtpexkXfqf
	 2wwDbDcF4Njq7OWB+Re+dEgCoqLHwLHyluOv5vx78XvCULP8LQYXWXKtIcTsk5nUVM
	 aSlrq+CrpoCriHIbaxYmPRq1g4gV7DIpLKoZe2xTI4wPsIOc0DYlMt59n8TziUK99z
	 n2BxSleErFa5kIaXl5M1uuTqD2VNRgaebUU3I5yFNMpWt6t/OG+ihrwnq/41zK3X7r
	 euuZabEg7p1XBGUVufxdtvrFJAQD2Yz1nxGOo+lcPzizOBE2yuW+Q+/RwwxDnfiOS9
	 8AyLe1iNvrsDg==
Date: Fri, 9 Oct 2026 12:31:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2] mm/vma: keep the unlinked VMA off the file across
 unmap on mmap hook failure
Message-ID: <asjQQF_Ok1TZPm1M@gremlin>
References: <20261007101800.58d50b1b20a10738e630bfd5@linux-foundation.org>
 <20261007194708.2009-1-okerixx@gmail.com>
 <e139339c-1e55-438b-86bf-0960ad4029f1@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e139339c-1e55-438b-86bf-0960ad4029f1@linux.dev>

-cc slopper

On Thu, Oct 08, 2026 at 02:48:07PM -0700, Ihor Solodrai wrote:
> BPF CI caught this bug on linux-next as well:
> https://github.com/kernel-patches/bpf/actions/runs/37736351874

Nice that it caught it!

Is there a way to automatically notify patch author that when it happens? Does
it bisect, etc. or just green/red?

--
Cheers, Lorenzo
