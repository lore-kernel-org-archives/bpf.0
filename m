Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C45446050;
	Tue, 15 Sep 2026 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515906; cv=none; b=NIL2oObdLy9XrEduSELewctQqSHxenz7Q4wh/2632yPjkQfPD+FYaQrCeM7J4R+nEvWI2BhPmSpDXRF0b/nQBfbAfJ/V1mwuanHTxwPpe4GYGTvH2P32ZOANwFO9KrrUuBHBrNVAkYPt31HlyO1w8FGYYvN8X511veWcWzeQSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515906; c=relaxed/simple;
	bh=TwbZz4yqmtTRaliiLX65TjWws79z0tEdZWvIbJh6LUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFuoGMT2PmjgUf/CSX89iTEkCKTMVDL3QFFY9svXT6d8PqV3x5+2pbWs0fDM4tJUArAgebEIMhBtwOH5iD4uLAwcmv7g/U8Co5ekedKKxZKiwms/65noOoTzQelevPixl5G7X+LxfGsJ/hdbeq8RC06kcilh4q5Wt0ThMj33bSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RAknP2JI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RAknP2JI"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B784F40E022C;
	Tue, 15 Sep 2026 23:45:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ae8IO3rTvQBP; Tue, 15 Sep 2026 23:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789515891; bh=sua8TdP0bzU7O4yeelRGte5eUw3jSiWCDLoLEwBKAG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAknP2JIIeZeK9h2G6f7LQKJi2k5OGaS69ajtnCTxRXTaC8rDSKcw3rfCyh36WSYM
	 XTodwHxgxmHJkAUBCscwjdaI7IurnTLuy56Mf+IlHgKYJe0zsBbSJWdnda62a0Bely
	 QiPpan9JKstIIIn3knRU+gquXvL947K+2sx7h7V4mxMYdEPDkvkpOz+9sDJDtf8nfg
	 4aUk4YEw7L3pqS4njz8vnELlHnX7ZrmZo25YiVDULWMWqJsD00IhQhvYS+Z/XkRq/T
	 cXDZw91A/v4f74mWiPGU+LCoK9XRP0i5oL2NyDw/Sm+g2uY3Kwak4u5TQa3QsQceBj
	 TpJtWBdO0Qi1kw2Y0ganBEJfh25EyykpdJns4bmKncnFJ8kK7L8lQT/dbScNzWPKcF
	 zI/9/XxXmw8Sruq9lZJVfoFgNB0OWYQ0sz/asKojYX8UVeaX2Kemzk13JB54jKvzti
	 8wQ1NpGIkwAh0GP9Aa0M5ywUt211LyT/dIe4S2gyNWT+2QBq26BJFfXFzEUQl5aLBU
	 1FntjsvFhRI//EvqSOWRDGzGVpaRLykBy7tmhmeW0sZIlheiZVygSZpBLvyqgmt2+y
	 ilj8H8UpfmZcrk0apH1Suj2S73UNcQ0K/iXZSp98PKr2POmhr3wA8+8gusd1bZ7u0m
	 bDABwjYU8hko+E60UbYYfDuc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3288940E01F9;
	Tue, 15 Sep 2026 23:44:35 +0000 (UTC)
Date: Tue, 15 Sep 2026 16:44:32 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/5] x86/cpu: Initialize boot CPU cpuinfo defaults
 early
Message-ID: <20260915234432.GBaqnYYPlPud4KssDD@fat_crate.local>
References: <20260814235134.3461435-1-ihor.solodrai@linux.dev>
 <20260814235134.3461435-3-ihor.solodrai@linux.dev>
 <20260915023115.GFaqit8zcWHGkAdHD5@fat_crate.local>
 <a6f41d17-62f0-4ba6-a8f0-bc18866d2784@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6f41d17-62f0-4ba6-a8f0-bc18866d2784@linux.dev>

On Tue, Sep 15, 2026 at 09:34:42AM -0700, Ihor Solodrai wrote:
> Should I respin with fixed up messages?

Yes please.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
