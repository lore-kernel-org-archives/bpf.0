Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93973D6CC6;
	Tue, 28 Jul 2026 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226981; cv=none; b=tfJB854/eejbrp/G+quTU1vnG7rfjiwAxBKMmuyrCNafiQBfKyPZHg+0avPw59ckCWfmBcMqA+ZHuKNctYxIyMBPavkxhIH4mE5zDZnFdt8RS01Ynv1/QuPLe4G8XI9+KZpIUFYzClGuAFV6KpDKk8SCIt5/aBadnD8u/Ube/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226981; c=relaxed/simple;
	bh=cZMHdLFb3zBcPfF2egyYyUkiIkSscJ+bKGQoAeQzUQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hq1Eog2TQRhuxyP7ZyN9eLphbGdRkj9LoaXRohX5UKULzBtdDeI0i/j0JX98h56ykIUKwmWtrWj1EqRRokNeULxZHhSeKiC5WVC2YWE4fBGkvnqbqcizFgbA9LI7ugCtOKRaQPQz/X3QBQsTWREfjCgIYNmQvodcvMPXzOqb1Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wod5U-00000001A80-3EU6;
	Tue, 28 Jul 2026 10:22:56 +0200
Date: Tue, 28 Jul 2026 10:22:56 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH] libbpf: don't preserve ownership during install
Message-ID: <amhm4G33dMpLJx/k@nb282.user.codasip.com>
References: <20260728071516.2706695-1-martin@kaiser.cx>
 <20260728072519.118D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728072519.118D11F000E9@smtp.kernel.org>

Thus wrote sashiko-bot@kernel.org (sashiko-bot@kernel.org):

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The use of the GNU-specific `cp --preserve` extension breaks `make install` on platforms with BSD or BusyBox `cp` implementations (e.g., macOS, FreeBSD, Alpine).
> --

> --- Patch [1]: [PATCH] libbpf: don't preserve ownership during install ---
> commit 20b6f948388a1067581300a57d47fc33d1950c11
> Author: Martin Kaiser <martin@kaiser.cx>

> libbpf: don't preserve ownership during install

> This commit modifies the libbpf install_lib target in the Makefile to
> prevent leaking the source tree owner's UID into the root filesystem. It
> replaces the cp -p flag with the --preserve=mode,timestamps flag to only
> preserve specific file attributes during installation.

> > diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> > --- a/tools/lib/bpf/Makefile
> > +++ b/tools/lib/bpf/Makefile
> > @@ -231,7 +231,7 @@ endef
> >  install_lib: all_cmd
> >  	$(call QUIET_INSTALL, $(LIB_TARGET)) \
> >  		$(call do_install_mkdir,$(libdir_SQ)); \
> > -		cp -fpR $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
> > +		cp -fR --preserve=mode,timestamps $(LIB_FILE) $(DESTDIR)$(libdir_SQ)

> [Severity: Medium]
> Will this break the installation process on platforms that do not use GNU
> coreutils?

> The --preserve argument is a GNU-specific extension. It appears this might
> cause the make install target to fail with an unrecognized option error on
> systems relying on BSD or BusyBox implementations of cp, such as macOS,
> FreeBSD, or Alpine Linux.


commit 1375152bb02a ("tools: lib: thermal: don't preserve owner in install")
makes a similar change for tools/lib/thermal/Makefile.

I'd assume that it's reasonable to require coreutils for kernel compilation.

AFAICS, kernel builds on Alpine linux require the alpine-sdk package which
contains coreutils.

Thanks,
Martin
