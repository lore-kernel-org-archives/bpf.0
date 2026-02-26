Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D1644D6A4;
	Thu, 26 Feb 2026 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138282; cv=none; b=nXM0cm+VTZLJm/FrTTZr65qDtUEyfVMZ2Mrsb89/Jh6b8jMDTrVyoC8/v6t/7LW7/nG5NTkahnCFjRM7Y/mKYxs8pZEVhMuj0wA7psQ5/FRxlB5mzMIdzL1a9+aIifgyTlLDiQfgolnY0tR9qrr/s9ckbDTggKtF3SHPKM5SqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138282; c=relaxed/simple;
	bh=3rU58kaT+scIKnvDShojsZJTZPKJ+3Bp2BYn3NLdhv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZP5u9zn+/F1wJwSB0WxEujngPDE8+ANYxD6w3K0NOytL97xdnkV65yo1ISOR+39l/hNknZq4/RmSQB5p8NBm74y7SMiyhMWajOks2h0Ji27PoYjilkyaQhko20NyiJqtgHzad2NcPAsGjaO/MxWvLOu/91Qgol7lq59Tget4VzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7ShULN8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7ShULN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE568C116C6;
	Thu, 26 Feb 2026 20:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772138282;
	bh=3rU58kaT+scIKnvDShojsZJTZPKJ+3Bp2BYn3NLdhv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7ShULN8F8NrOKp45Z2v+56G50WABI2JlDEHnhIXDmto/hI8VGQs+dpFtiVNSaQxk
	 vLnnRgMKaRrTkDOcJ2/fMnAT55SzalbVcea4YP6VS1DopeN54LrnrZcIRCRM8zyxfD
	 emhOLqdMz1nUZGec1fc4/UJZT/GIlHr0GtKWLKHxKqne4qpSCYxl5MdMNTy90OgQBm
	 eZi1uYxluY3RcPaKDUbMz2jdOlItdA8hjEpmFQqju/XwR+Y6O6y5SarwmyAHx2zF9E
	 FI25LIPXA3+QTebuG0oqQ4SOI49P3CIGiAwfdjq6bKyW0TKNd8V/CrE88vFIb05hCk
	 gzKIeJkXwCErQ==
Date: Thu, 26 Feb 2026 13:37:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] kbuild: install-extmod-build: Package resolve_btfids if
 necessary
Message-ID: <20260226203758.GC3196155@ax162>
References: <20260226-kbuild-resolve_btfids-v1-1-2bf38b93dfe7@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226-kbuild-resolve_btfids-v1-1-2bf38b93dfe7@linutronix.de>

On Thu, Feb 26, 2026 at 08:41:48AM +0100, Thomas Weiﬂschuh wrote:
> When CONFIG_DEBUG_INFO_BTF_MODULES is enabled and vmlinux is available,
> Makefilefile.modfinal and gen-btf.sh will try to use resolve_btfids
> on the module .ko. install-extmod-build currently does not package
> resolve_btfids, so that step fails.

Heh, ironic that I was just looking in that area yesterday and I had
thought that this would be necessary if vmlinux is available but then
never followed up... Thanks for this.

> Also package resolve_btfids if it may get used.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Nicolas, can I take this as a fix?

> ---
>  scripts/package/install-extmod-build | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
> index 2576cf7902db..f12e1ffe409e 100755
> --- a/scripts/package/install-extmod-build
> +++ b/scripts/package/install-extmod-build
> @@ -32,6 +32,10 @@ mkdir -p "${destdir}"
>  		echo tools/objtool/objtool
>  	fi
>  
> +	if is_enabled CONFIG_DEBUG_INFO_BTF_MODULES; then
> +		echo tools/bpf/resolve_btfids/resolve_btfids
> +	fi
> +
>  	echo Module.symvers
>  	echo "arch/${SRCARCH}/include/generated"
>  	echo include/config/auto.conf
> 
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260226-kbuild-resolve_btfids-ca233983ebbb
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
