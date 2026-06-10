Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71023409E0F;
	Wed, 10 Jun 2026 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102247; cv=none; b=YaZV0Xu/xMWLE3O8KnUk092aJTaW/EaYeeWBywdnmg5bByoxm14GwSWE2agFLnXjAljW2j/lbBphnXTHEdh7IgKem1OBsVYfOMQWKKMXIY2n6Grt9rLoKb/PFBxlWsj/JAcbApqM0mJ/IF9zLP/K+MH5PWA4xNvcAWgCPPccmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102247; c=relaxed/simple;
	bh=14MudBlUo/MiPH62vrRijCz+mEnKk/r8tJPHbsWJiTE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SFGP8GvQQ9F2oeDFORad4uerfoyGnI6sWuVyG2CM1rr+fRsqVDRK+iz2LOhvv+qEly7kkzuIZr3FocEL3FSro5/ljvIQLlIFjN8Pfh88yT9MiG9vK1tSICwDOON82k/JZJiPE957LicVDxc22t9zjrYg2u+BGdwQAoi1iWkEUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEtZ3tx1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEtZ3tx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C6C1F00893;
	Wed, 10 Jun 2026 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102246;
	bh=+aUpp/Xae8vWFXmLRO1/JAbTv8IzKAGIRt8w/cXpVdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LEtZ3tx1sTTlNW8kg8MsrEOL+4bev4KawN4LIsraa35YLBdb+AoV0/bvVL+ILpTrf
	 vAspeoHdgoo1SU7lbnRtKZLwKg+XDy3v2iTnjfumEgeF2lSJh0FVuako2GEg1D7bPj
	 qH6mEM/ipHlZfPBdoSIIfBQ+clOUsAxvMWel4inbHxFxegfV0dM7dMkwItVrK2/AMn
	 3IIrur9Xcr2IeLkE6rFtdoA9aR9caCxKG9WTHKdpSqy1bOmnV5RsHAQTTdaDcoEozb
	 xIaxnW13GNdUcTsSPKjY0seom93MdmAMe7PfJbPjN70mUpFLdCD8TpGibcjxd4FzLY
	 PJAhbotN9CkPQ==
Date: Wed, 10 Jun 2026 23:37:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 6/7] Documentation: bootconfig: document build-time
 cmdline rendering
Message-Id: <20260610233720.82fe59cf42aa57659c2e5697@kernel.org>
In-Reply-To: <20260609-bootconfig_using_tools-v4-6-73c463f03a97@debian.org>
References: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
	<20260609-bootconfig_using_tools-v4-6-73c463f03a97@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jun 2026 03:28:33 -0700
Breno Leitao <leitao@debian.org> wrote:

> Add a section describing CONFIG_BOOT_CONFIG_EMBED_CMDLINE: what it
> does (renders the embedded "kernel" subtree to a flat cmdline at
> build time so early_param() handlers see the values), what it
> requires (BOOT_CONFIG_EMBED, a non-empty BOOT_CONFIG_EMBED_FILE,
> and ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG -- currently x86 only),
> the bootconfig opt-in semantics, the initrd-vs-embedded precedence,
> and the soft-error overflow behavior.

Hi Breno,

Thanks for adding the document. But related to the Sashiko's comment,
I believe it's necessary to pre-describe in this document how the
kernel behaves with various combinations of cmdline and bootconfig,
both embbedded and initrd/bootloader.

We can have these ways to pass the kernel options.

- bootloader cmdline
- embedded cmdline
- initrd bootconfig
- embedded bootconfig (standard/cmdline)

Clearly, we will have the option to choose between a standard embedded
boot configuration or a command-line one, not either, but the behavior
is different. I confirmed that is covered.

Embedded bootconfig is a kind of default bootconfig, which is NOT used
when initrd has another bootconfig. I made this design because of
/proc/bootconfig, which is not merged with embedded one. However, 
CONFIG_BOOT_CONFIG_EMBED_CMDLINE will be a bit different, if it is
embedded and "bootconfig" feature is enabled, the embbedded one
has been used already. 

To avoid confusion, when this option is used, shouldn't we treat it
the same way as if embedded command lines were enabled, and either
not display it in /proc/bootconfig (or always display it, by merging
the rendered string)?

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
