Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D312D5C7A;
	Fri, 26 Jun 2026 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485653; cv=none; b=ZLXl+C282CUeSAwM0TFSiDJNAV6/0HZ5dtiw5NMPhT6H74rAaV6TpzcXQmIOip/tPOzYobgdaG5Vs8dvVRXv2wXuKhU8KJwPWUrSW12TaB0b8QHt2zDudDj+b4Q1TLeWJxrTrDHNwPlyWmQHXrtmoh4+JoxwZ/PdbXMefrbLHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485653; c=relaxed/simple;
	bh=4/zqp6G7zm1feI3SkgkRziJVevArgiCNJesjxpmTUSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z04OIeeqD+dMc6SNidN2QcO/qSRLSjZheRdUqLfXZjyOdi+7ynxPAfFPSkUmMJnHHb0XWrS1QFADMCVWwkPH8O3XlKaTg5EK8EiT6X4Ck6L599mW4GhXS5SJbDq41iSYqmlFf6eFXYRJ5GsL8Jse76OktS5sVy+xxdRr3nVx5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uCbvmUwP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uCbvmUwP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rqaQAqtRte520b74K9t083gmmRChi1kEVk9vgjlvgZY=; b=uCbvmUwPrXOg3IS6ymJYUE5jPg
	BJ/quKovoNdYPPVymkuiyuPg9saySriEXgjWp00I8v9nbo5pJbioKTw9gntFfaHkcUaySDJRuWxMm
	iYxm+gbk//05IaTJwbahbnd9DNbuI7wmUutI9iaWJ4gnhhCz+mAQVQjiJ08dyGo3Q+rRWyUfp1CY0
	vx6Cp3hbxwjmr4OnRqZFKVbjvA7Bzk1ckT53BGmBU2CgYDHPkdPHhD5bHW7fP8DKyXc8V/Z2SThDS
	AIUvQAZx5bRWDdC4lO3QaNorlkMHYcUyyJuK/bHgXppLtaGRW6n4FprkftQac+N3QdGuNpsCY3eov
	sDp61/nw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd7wF-0042t0-0u;
	Fri, 26 Jun 2026 14:53:51 +0000
Date: Fri, 26 Jun 2026 07:53:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, linux-doc@vger.kernel.org, 
	kernel-team@meta.com, Nicolas Schier <n.schier@fritz.com>
Subject: Re: [PATCH v7 0/9] bootconfig: embed kernel.* cmdline at build time
Message-ID: <aj6SZrtZb6rfQUJZ@gmail.com>
References: <20260626-bootconfig_using_tools-v7-0-24ab72139c29@debian.org>
 <20260626233327.b5c9c8de494acdde4ddf5c02@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626233327.b5c9c8de494acdde4ddf5c02@kernel.org>
X-Debian-User: leitao

On Fri, Jun 26, 2026 at 11:33:27PM +0900, Masami Hiramatsu wrote:
> > The userspace pieces (xbc_snprint_cmdline() in lib/, tools/bootconfig -C)
> > already landed; this series wires the rendered cmdline into the kernel.
> > 
> > Motivation: today the embedded bootconfig is parsed at runtime, after
> > parse_early_param() has already run, so early_param() handlers can't
> > see embedded values. Folding the kernel.* subtree into the cmdline at
> > build time gives a CONFIG_CMDLINE-equivalent for embedded-bootconfig
> > users without forcing them to maintain two cmdline sources.
> > 
> > Behaviorally, the "kernel" subtree is rendered to a flat string at
> > build time and stashed in .init.rodata. setup_arch() prepends it to
> > boot_command_line before parse_early_param() runs. Overflow is a soft
> > error: the helper logs and leaves boot_command_line untouched rather
> > than panicking, so an oversized embedded bconf cannot brick a boot.
> > 
> 
> Thanks for update!! This looks good to me.
> Let me pick it and test it.

This is great. Thanks for it and for the support so far.
--breno
