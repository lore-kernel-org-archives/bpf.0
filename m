Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B523B3F23B6;
	Tue,  9 Jun 2026 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000230; cv=none; b=E+6G2HhkWt5mQ18QXviOrqTdidBjsW8Nf6bZE6CRMl0MHxewzLBb2qyUeoPbPkZp5pdp4cQcc5HZCif/3/sR4WHBJLnbWJroTNE2KL+DMswbZdOACFul4n9A8Ir4H1QY+0JQ4Hw7H4j9Ghfa0u8CGnV5b5zjSaFritnbHtf/Nt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000230; c=relaxed/simple;
	bh=CA358HIu20sn56nJ4KQrMlv/y7IL84T5f3Hax0mdNvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b38edYKGYs9j4YE0cOC1ng8zwdW2kNQFa2g1yXMFCD2kr6BP3mjMpigkrOKKronxxAqwee9Q9kYLBojkE7nHYwdB3SOOFrG0xGreALbVPHDzMxdVNy2++s1IbEOpyKxc35JpOoJ/r/mNWH4e4nTi7Npnn+5uxRwKRqb4FKQAaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QCzVuM8I; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QCzVuM8I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nXkhW7gK992U0F8zjkoZLE6zzrR6bII1RM3e5glVcQk=; b=QCzVuM8IXTjKEuMSpZiFN95Bx7
	qH9fdod7i1VMGT+zkh9TLJ9aZg4CoB4m7kouZ1dgAuevUD2R3mqZJ5+Lxy41sB02gvk1dP6/22gQl
	pY9zkgvp48Tvff4FoMvAr1vHAkznkF1TWMZMU3koFf9NOpRCK9nF7Ecr0OaoiZnn/JRCnA4bOgiWF
	iaxUqHZITvky06UhN3a/4mGZsGKn1rKkC/yla321BJb0kScqT9GZTcH+96eXaj/GuzMa9zjCOQwTb
	zmi+ga0U/Mdn5AD7IlnfeqNQgmKPLNP8rtmo7KTidgR6mCp9vVbMUR8C32w5vvo/LzKQjnRNUxthc
	ecwz68nw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWtVc-008KRz-0e;
	Tue, 09 Jun 2026 10:16:37 +0000
Date: Tue, 9 Jun 2026 03:16:30 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 0/6] bootconfig: embed kernel.* cmdline at build time
Message-ID: <aifi1tbU2eeExo5o@gmail.com>
References: <20260608-bootconfig_using_tools-v3-0-4ddd079a0696@debian.org>
 <20260609104611.a0a5def510944d12cd0b6dfc@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609104611.a0a5def510944d12cd0b6dfc@kernel.org>
X-Debian-User: leitao

On Tue, Jun 09, 2026 at 10:46:11AM +0900, Masami Hiramatsu wrote:
> On Mon, 08 Jun 2026 09:23:57 -0700
> Breno Leitao <leitao@debian.org> wrote:
> 
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
> Sashiko still leaves some comments. 
> https://sashiko.dev/#/patchset/20260608-bootconfig_using_tools-v3-0-4ddd079a0696%40debian.org

Ack. There are two "low" issues and one high. I will fix all of them in
v4.

> BTW, can you also update the document (Documentation/admin-guide/bootconfig.rst)
> about what is the expected behavior of this feature (kconfigs, examples)?

Sure, good idea. I will add a new patch documenting this new feature.


Thanks for the review,
--breno
