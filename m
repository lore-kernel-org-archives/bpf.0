Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2346175A9C;
	Wed,  1 Jul 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911946; cv=none; b=uLEj0zYdcnN3HmENznWo4IWN7VKi99yt4tOJ2CIkrQsUxY2OR0pcbxBOsm4a+qX18PEjcOSt6PeZ9JFrxHAvr574p4rhaL1Ezawkfoy40UWAavDHUur6cTLtiH/IonjrE9GxhaDjmkT7pCjySOMWBhjiXj6y7RWPXMuzdK6MsV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911946; c=relaxed/simple;
	bh=mAdFDQ8AcvQAgDJvsxsyvsNAwB4oMDL8D6ztJxqCDx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRHjGIkHnwNTzqKUPqalPG1c7yvCD9+rdeF/Le1R3Y3R5CFvES2JyjA7KzQZQ3K6eak0GbRqIjwBySGq6E/BECEARj/FTv1pUQTpBGMj9XisgzN+NS6BjOTWxV7jU6l6HM/BZJkLnOlcAnK5q9BWzVniBppEEgP2S+dLGW+jvgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=sZdKUQnu; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="sZdKUQnu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D3XkahpkJHZpP7dKJ9sD5EcAJKoxvPM2S4aUH1ixxHo=; b=sZdKUQnuG3GVEcwsy01q/E56EH
	kR3NcZf0ZDbyP5/gtSTrYi9pIGjTrvdkN6u/stI1MXtXpVGZaWsuL6l+eepq0TZZizOnBlqAQ9e02
	bh4hQlzz3BnVJI8nbiftEcrTUx6P141DzFl8wTB4rwge90+T3OXLeZcKHLVksf3a1eTl9PWBW0YOh
	JXU5f0kjWsZylIbTHQVD2evFrPXKPw56C/ECDe+0WHZ7TfAN8+Z3UCJrvDe3QLem8lRrlZGMjrRfD
	313qMOfdYW3HIVGC9VePWhqf/6el6nUKHcOgILwPlzFdSFDjZbwCpOEEI/9JhIH+IxVVyLBgHFwK6
	ilRr+l+g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weupo-007rq6-2l;
	Wed, 01 Jul 2026 13:18:37 +0000
Date: Wed, 1 Jul 2026 06:18:30 -0700
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
Message-ID: <akUTHGb7NANeqyNd@gmail.com>
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
> On Fri, 26 Jun 2026 05:50:09 -0700
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
> Thanks for update!! This looks good to me.
> Let me pick it and test it.

Thanks Masami,

Let me know if you need anything else from my side.

Once these land in linux-next, I'll merge them into Meta's kernel tree
and put them into production. Looking forward to seeing how it works out.

Really appreciate all your support getting this across the line.
--breno
