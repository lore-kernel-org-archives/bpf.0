Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11EA4183D5;
	Wed, 10 Jun 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103516; cv=none; b=PuRF3/N+V6w2gYls80Jx1JxSbuypTXsZ7+7ZudzFFd1O/UJ99LBEpQ7orWwHizlUkAnk7VhxHlSutDS5s57nx2YfsWKq4/RssChkKE9KJ2BK8hx/fsGz+2HWwT3vS2gx7BEuJGbjgDIRXzCurggK7Wy6Uw5zuoWeIr4oNMMaPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103516; c=relaxed/simple;
	bh=/6Nf9G5lLEN8BF9smhemAcg0T3KOlEyIG3wNfGBKmcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfZUAI+MCGGpsAT1R8xmtMvxb2q5UKI7c0vYSzT0DlYpo4RL9KL0VmTjHmacoRpkw1FeBcRCG8Wd+w1K9SE9wLKx/jXaArDNMkzfiBRjwpN+cay+d37ohJGvmAy3Q1qQ5aO/Wd0lD2eJxCLhaI/OZ2XOD6AerPN9VeinetWlnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=FVtbWKkZ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="FVtbWKkZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zZfC0EJJ7HHhhWDFFicBOAdBi6iTtdoJgHhoFDJ4PdI=; b=FVtbWKkZR2WNVBuBAu4NrhMpS6
	4d/EJvs/kP5Q9kfe+Kmb1I7CsJX+tVkpYlK/7+kcgbZ2+YWPuU6GA8BGs7N7viLMkDZ3Py7cxxlN1
	UPYJae7o/49uE3/icRs5V0GvBRN7p3WGwBSGdtQgiZZipxNTEZjDGfWvEU4SHeNFf0ByEG99A3EA4
	Em1d3YBhmehKdYeGGs+3Cbh1IvjkMRSkq0agno8F6fM8hV5CDAQ26NuHjAX9LjGDuck2ynzY9OaxT
	Jl7lrjzG5E62aIkfpl15N3b7xxDADPcX5LHwpoWBAQ9GqfWo+xQJf9CGNb7e540dDDorQ9oiqkXWR
	jkFra1Ug==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wXKNk-009Gg8-0w;
	Wed, 10 Jun 2026 14:58:16 +0000
Date: Wed, 10 Jun 2026 07:58:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 6/7] Documentation: bootconfig: document build-time
 cmdline rendering
Message-ID: <ail6rQnRYKsXPxyF@gmail.com>
References: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
 <20260609-bootconfig_using_tools-v4-6-73c463f03a97@debian.org>
 <20260610233720.82fe59cf42aa57659c2e5697@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610233720.82fe59cf42aa57659c2e5697@kernel.org>
X-Debian-User: leitao

On Wed, Jun 10, 2026 at 11:37:20PM +0900, Masami Hiramatsu wrote:
> On Tue, 09 Jun 2026 03:28:33 -0700
> Breno Leitao <leitao@debian.org> wrote:
> 
> > Add a section describing CONFIG_BOOT_CONFIG_EMBED_CMDLINE: what it
> > does (renders the embedded "kernel" subtree to a flat cmdline at
> > build time so early_param() handlers see the values), what it
> > requires (BOOT_CONFIG_EMBED, a non-empty BOOT_CONFIG_EMBED_FILE,
> > and ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG -- currently x86 only),
> > the bootconfig opt-in semantics, the initrd-vs-embedded precedence,
> > and the soft-error overflow behavior.
> 
> Hi Breno,
> 
> Thanks for adding the document. But related to the Sashiko's comment,
> I believe it's necessary to pre-describe in this document how the
> kernel behaves with various combinations of cmdline and bootconfig,
> both embbedded and initrd/bootloader.
> 
> We can have these ways to pass the kernel options.
> 
> - bootloader cmdline
> - embedded cmdline
> - initrd bootconfig
> - embedded bootconfig (standard/cmdline)

Will do.  For v5 I'll extend bootconfig.rst with a section that walks through
each combination -- which source wins, when parse_early_param() sees it, and
how it shows up in /proc/cmdline and /proc/bootconfig.

> Clearly, we will have the option to choose between a standard embedded
> boot configuration or a command-line one, not either, but the behavior
> is different. I confirmed that is covered.
> 
> Embedded bootconfig is a kind of default bootconfig, which is NOT used
> when initrd has another bootconfig. I made this design because of
> /proc/bootconfig, which is not merged with embedded one. However, 
> CONFIG_BOOT_CONFIG_EMBED_CMDLINE will be a bit different, if it is
> embedded and "bootconfig" feature is enabled, the embbedded one
> has been used already. 
> 
> To avoid confusion, when this option is used, shouldn't we treat it
> the same way as if embedded command lines were enabled, and either
> not display it in /proc/bootconfig (or always display it, by merging
> the rendered string)?

You're right that EMBED_CMDLINE breaks it: the embedded kernel.* keys
are already in boot_command_line before setup_boot_config() ever sees
the initrd bconf, so a user reading /proc/bootconfig would see only
the initrd keys while parse_early_param() acted on the embedded ones.
That's exactly the split-state Sashiko was circling around.

Both options you suggest work for me, but they pull in opposite
directions and I'd rather not guess wrong on the user-facing
contract.  Which do you prefer for v5?

  (a) Don't display embedded in /proc/bootconfig -- keep the current
      "file shows the active bootconfig source" behavior and document
      that with EMBED_CMDLINE=y, the kernel.* subtree may have been
      applied separately via the cmdline.

  (b) Always display embedded by merging the rendered string into
      /proc/bootconfig when EMBED_CMDLINE=y, so the file reflects
      what was actually applied.

Happy to go either way

Thanks for the direction,
--breno
