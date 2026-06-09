Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47426B2D3;
	Tue,  9 Jun 2026 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968893; cv=none; b=Uv31CCrvMJhshezk26QmOQF60NidXEKs2SZHuGgdmXTFqUbshl4GHTxfEOhhqS6eJgY4zmyAr09n0yoyp4RQtzWrHJ/d7Nd4PtfUT9xf2VE+mm93QQX7xBFw0aw6RgB4kgrxucx7k67OAl+zKk2NLnJoDoJFzLzZ7v39GVKNWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968893; c=relaxed/simple;
	bh=ub253+LnCietUqOYZskAZYNVdjA1Fth/D8XFf5NguYk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=goLgZLBhBQ4qvYRTHwcoqMJVaz4e0ccX3l2vLAKjzM+dRt7moq45MrIieRzBqBJWRtxLbvlbKy+ZlGWFdWI/BQsfvOXhEyzRof4Xg2d9Lcxsuao2qniHQgVOL7kpKEPwTLeidS/K4sq/UCGlDREYpuwVL7yHkdU4ogY4L647y6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Por0PhLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Por0PhLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F081F00893;
	Tue,  9 Jun 2026 01:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780968892;
	bh=vmZpCmuQ7wnqO/HZtrmD6xeHLLBF/ouoM10uO0DNTf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Por0PhLMP79NepOjIWPiWkHnvzQ+eXwkBv5Xjv5jYrjk1TDsj1TzcrF7PoZjBCyfF
	 jgv2uffcCsM1ZokMG1TLIFUzabaXkdrc3+SM5xT/rf/W0JW0O+QKLHxfR94MCuy520
	 hLYj16XH8DsHmXkv3Y7nli2hm1IX+sIW4mqjOZPgpX+7/HKm/DQLs2/Txzpxag1y8o
	 TL0lyaqZ/n1CgpI5TDjO5iSlu8CYqOPzSm2zZR5dxNW35ykbeFw3IZK8y/SEUXfhr8
	 3STcmTvgYn3EXYv85pIhFURsr5u5Bv8HMdWyo7R9wUaCkvb+4nGH6TmoqwWNKsGuAe
	 9dQuJO7jD3+2A==
Date: Tue, 9 Jun 2026 10:34:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 6/6] x86/setup: prepend embedded bootconfig cmdline
 before parse_early_param
Message-Id: <20260609103446.7d29679c90e834ff8e32c56d@kernel.org>
In-Reply-To: <aibSj4XeRWJmasCx@gmail.com>
References: <20260605-bootconfig_using_tools-v2-0-d309f544b5f7@debian.org>
	<20260605-bootconfig_using_tools-v2-6-d309f544b5f7@debian.org>
	<20260608191928.d7d2dea899b94f05d397f891@kernel.org>
	<aibSj4XeRWJmasCx@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 8 Jun 2026 07:41:05 -0700
Breno Leitao <leitao@debian.org> wrote:

> On Mon, Jun 08, 2026 at 07:19:28PM +0900, Masami Hiramatsu wrote:
> > On Fri, 05 Jun 2026 05:03:37 -0700
> > Breno Leitao <leitao@debian.org> wrote:
> > 
> > > Call xbc_prepend_embedded_cmdline() in setup_arch() right after the
> > > CONFIG_CMDLINE merge and before strscpy(command_line, ...) so the
> > > build-time-rendered embedded bootconfig "kernel" subtree is part of
> > > boot_command_line by the time parse_early_param() runs. early_param()
> > > handlers (mem=, earlycon=, loglevel=, ...) now see values supplied via
> > > CONFIG_BOOT_CONFIG_EMBED_FILE without parsing bootconfig at runtime.
> > > 
> > > Gate the prepend on the bootconfig opt-in: only fold in the embedded
> > > kernel.* keys when "bootconfig" is present on the command line, or
> > > CONFIG_BOOT_CONFIG_FORCE is set. Applying the embedded cmdline
> > > unconditionally would (a) diverge from how embedded init.* keys are
> > > treated and (b) break fail-safe recovery: a malformed embedded
> > > console=/mem= could panic the boot with no way for the admin to disable
> > > it by dropping "bootconfig" from the bootloader cmdline.
> > > cmdline_find_option_bool() runs before parse_early_param(), so the gate
> > > is cheap and correctly ordered.
> > > 
> > > Select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG so the user-visible
> > > CONFIG_BOOT_CONFIG_EMBED_CMDLINE option becomes selectable on x86.
> > 
> > This seems like a dummy config. what code does depend on this flag?
> 
> No C code reads ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG directly — it's
> a silent gating symbol, the same ARCH_SUPPORTS_* idiom as
> ARCH_SUPPORTS_CFI, ARCH_SUPPORTS_LTO_CLANG, etc.
> 
> Its only role is the depends on line of BOOT_CONFIG_EMBED_CMDLINE: an
> arch selects it once its setup_arch() calls
> xbc_prepend_embedded_cmdline(), and that makes the user-visible
> BOOT_CONFIG_EMBED_CMDLINE selectable.
> 
> Right now, only x86 supports embedded bootconfig, thus, only x86 does
> the following (last patch):
> 
> 	config X86
> 	+       select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG
> 
> So, no other platform can see CONFIG_BOOT_CONFIG_EMBED_CMDLINE.

Ah, OK. I missed the 3/6, which defined the dependency.

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
