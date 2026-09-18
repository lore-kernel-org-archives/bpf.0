Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13C3D6472;
	Fri, 18 Sep 2026 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735986; cv=none; b=HDdkoMAEigyxSJJm0BrcYrZEQ++wvAjhtwO4axUi3wY4TjEkVqLPOHCvL3CwXep9O8ORyqPmEhAxuT/lPIXuvycTP2h6yxoKqlpPqR1940kn6rAxdyQZ8r6V9v39b+No18k7yb3ZPxQ9ErIDkQWXZyiPIlLnqAYIn0Hqog/TyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735986; c=relaxed/simple;
	bh=2ncYWKs9/G457e0TIMJkQtP2RGNqn/MM5f6ZGz30Pqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFKzwCisW9Hr+akUNRxHmuEPOdTZZs+4OctIqOhvBHjhyNNCgWVoZEJMhxZK713ZVzN0eOl4AF/nPKS1a7D+aQE1321U7FDrEdtZvUCMIP2vO905Ne4mK/PhzTQP20BSVfo+77Geo7Y7i8t3hHoQ5luG7RX/vOJyGFs8BU1CjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lpDEvPGV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ozIsrfVa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lpDEvPGV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ozIsrfVa"
Date: Fri, 18 Sep 2026 14:52:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789735978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQVf2D1vSIBEX5SAz3nmwawQDRDC/utjdahEJjcSvmg=;
	b=lpDEvPGVp6VLeayxI7uq42JROh4f5RTZRJCpmY2RaWVMA/pULDFLMTa5bs/2t1sk1W7YBD
	cjvmbwsdK4y7VcDSUSxNG9NMA48eYNAeLOI/atgpnDxWWzFyfnOXpuqpkSu7uYaiYsDYQf
	C1U8OqxzporbB7VyX64MMg0IO97+rHRPp+5vi2Q4SYWKhRdIVnAfw33MyYsxJJfxjxKMEZ
	F/GTF152fL6rd74QTKgaduOO/PPpnQbdblsnRV2+UtJzUa79qnGIGGcS3a5ERit4Lrszsr
	aalGw4Xp/+rKocZMJlfgeX2tn4juhLo2vjo3VJ2KzoKm8aeqaXCnMhjuaDlNmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789735978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQVf2D1vSIBEX5SAz3nmwawQDRDC/utjdahEJjcSvmg=;
	b=ozIsrfVa3Olq+erTitmGiIJ+WxFDHUjn9ufxp81wWInAwyJ7wximXE/Zm7TUdac1FX6kkB
	j0VCmtYbkEd3y7AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, ihor.solodrai@linux.dev, ast@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, shuah@kernel.org, martin.lau@kernel.org,
	mason@kernel.org
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Use %p for pointer formatting
Message-ID: <20260918125256.ZEsLOzCf@linutronix.de>
References: <20260918102610.gxA3km8_@linutronix.de>
 <aec6c555995eb1efb36bafec4c49e2235fc6899cb74beb6dcb3ce058ada6d814@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aec6c555995eb1efb36bafec4c49e2235fc6899cb74beb6dcb3ce058ada6d814@mail.kernel.org>

On 2026-09-18 11:38:34 [+0000], bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Use %p for pointer formatting
> >
> > Networking used to print the socket pointer with %p as output in the
> > /proc interface. This was later changed to %pK in order not to reveal
> > the actual pointer value. The output format has then been copied to bpf
> > tests which produce the same format including the %pK format modifier.
> >
> > Networking recently replaced the socket output with a plain 0 because
> > the socket pointer added no value to the output and the %pK should be
> > removed from library handling. The format remained otherwise unchanged in
> > order not to break any tools which parsing this information.
> >
> > This change removes the %pK modifier from bpf, following the change in
> > networking.
> 
> Does this subject line accurately describe what the patch does?

Oh. The %pK gets removed, not replaced with %p.

> Looking at the actual changes, no %p format specifier is introduced
> anywhere in the test code:
> 
> - bpf_iter_netlink.c gets a literal "0  " string
> - bpf_iter_tcp4.c / bpf_iter_tcp6.c / bpf_iter_udp4.c / bpf_iter_udp6.c
>   get a literal "0" string
> - bpf_iter_unix.c gets "%08u" with a constant 0 argument
> - test_snprintf.c simply drops the %pK specifier (its remaining %p was
>   already present before this patch)
> 
> The only place where %p appears in the patch is in README.rst, in a
> historical verifier log excerpt.
> 
> The body text says "This change removes the %pK modifier from bpf",
> which matches the v1 subject "selftests/bpf: Replace %pK output with 0"
> rather than this v2 subject.

Indeed.

> A few additional points:
> 
> The changelog is unchanged from v1 and doesn't mention the
> header/column-width edits this version adds:
> - bpf_iter_netlink.c "sk" column changed from 17 to 3 chars
> - bpf_iter_unix.c "Num" column changed from 18 to 10 chars
> 
> This seems relevant since the body asserts "The format remained
> otherwise unchanged in order not to break any tools".

This updates the output so the column width aligns with the output.
"Format unchanged" means no items were removed or reordered.

> The referenced networking commit isn't named in the message. Looking at
> the v1 discussion, commit 7c0ec6288b497 ("net: Replace %pK output with
> 0") was cited below the --- separator, so it's absent from the committed
> message. That commit doesn't appear to be in this tree yet (checking
> net/netlink/af_netlink.c, net/unix/af_unix.c, net/ipv4/udp.c and the
> tcp_ipv[46].c files still use %pK), which would make a Link: or commit
> reference useful for readers.
> 
> > order not to break any tools which parsing this information.
> 
> This isn't a bug, but there's a grammar error here ("which parsing"
> should be "which are parsing").

Okay.

Sebastian
