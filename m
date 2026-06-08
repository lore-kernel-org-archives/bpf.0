Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EF30FC03;
	Mon,  8 Jun 2026 02:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885759; cv=none; b=BNY5/nOafboctXi162LbLROAGqhLxa2j0dH7cZExMTWlwcfwdWNpXpRbzTT8+ojYxCmr9KGjBDTvxT8qULtHEiR7KF9yKwrwPeSgHTGeTN/dfKfiC4dfom9HHisUEEbs0pGH3j0pXdvSUQwoObEU+cZL4pEnrkSFnAFoQ9kFBpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885759; c=relaxed/simple;
	bh=1yW3nGF+k1cyd6TOnr3aI6fuKTkcHeoCFzAPA0owvD4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DAHfWbAiJuXk4GufugxYWmGH9WR8ZmQ1rdGUWDM02FIhpBr6kXS3fuRdLRauSILod1mN3nvJ7f5cPuHi52PhSzLdotDOuySxaoG/5JbNJaqdNF+Ti+aq33t9YvIvwxtIk/DLJetdxFDBNkMD/pRnE+WerCs3yvfJWw70bYuMpS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YryrMEOK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YryrMEOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AADE1F00893;
	Mon,  8 Jun 2026 02:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780885758;
	bh=aBSarULtiAIbNgz7EOEuuFuqzWO+yqoqqHghdSCdJ5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YryrMEOKa/URJl9Ed4LYJYVdYFN79dFfhRsvvv/Z2A1pqVOsyC+1yNXergIxdOPcj
	 nb/sKI5iK0Bp6WZ1ZQ12IUDbIhbFAUkhWBeZXZRe9MFmyuESIXFgQS/K2Js3xzaB4W
	 EKNs5xdDxxgzs8r3dlyHGfmcJI2VpUUrMPhRA2DGA+TbFbWlHUhLjnYURUDgy0xqMx
	 FMq5r7u6B5QLeBGREwD6tuajwJ7pRsuhRTtzmKrPdAl/aMbPPIGjDv3QXFMo3CPU6D
	 QpVVgtwoFki47KPVdduvlwH2a1Jky7Lt5byDMZ4ly2wCl8Ah5rk1xiJjDi08WxdnD2
	 6qhyn9rpUdaxg==
Date: Mon, 8 Jun 2026 11:29:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 3/6] bootconfig: render embedded bootconfig as a
 kernel cmdline at build time
Message-Id: <20260608112911.ec62dfd24adf235b6db5506b@kernel.org>
In-Reply-To: <20260605-bootconfig_using_tools-v2-3-d309f544b5f7@debian.org>
References: <20260605-bootconfig_using_tools-v2-0-d309f544b5f7@debian.org>
	<20260605-bootconfig_using_tools-v2-3-d309f544b5f7@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Breno,

On Fri, 05 Jun 2026 05:03:34 -0700
Breno Leitao <leitao@debian.org> wrote:

> diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
> index 90eb47c9d8de..aa75a7828685 100644
> --- a/tools/bootconfig/Makefile
> +++ b/tools/bootconfig/Makefile
> @@ -15,10 +15,14 @@ override CFLAGS += -Wall -g -I$(CURDIR)/include
>  ALL_TARGETS := bootconfig
>  ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
>  
> -all: $(ALL_PROGRAMS) test
> +all: $(ALL_PROGRAMS)
>  
> +# bootconfig is a build host tool: Kbuild's prepare hook runs it on the
> +# build machine to render the embedded cmdline, so always compile it with
> +# $(HOSTCC). Using $(CC) would cross-compile it under ARCH=... builds and
> +# fail to exec on the host ("Exec format error").
>  $(OUTPUT)bootconfig: main.c include/linux/bootconfig.h $(LIBSRC)
> -	$(CC) $(filter %.c,$^) $(CFLAGS) $(LDFLAGS) -o $@
> +	$(HOSTCC) $(filter %.c,$^) $(CFLAGS) $(LDFLAGS) -o $@


> Is it safe to pass $(CFLAGS) and $(LDFLAGS) to $(HOSTCC) here?
> When cross-compiling, $(CFLAGS) and $(LDFLAGS) often contain target-specific
> flags. Passing these target flags to the host compiler might cause it to fail,
> or incorrectly generate binaries for the target architecture that fail to
> execute on the build host.

Sashiko found a problem here. Hmm, I would like to build the bootconfig
tool just as a tool. (like `cd tools/bootconfig; make`)
Can we identify the build (make) is called from kernel build process or not
and switching CC/CFLAGS/LDFLAGS?

> 
> Additionally, since bootconfig is an administrative utility meant to be
> deployed on the target system, will permanently hardcoding $(HOSTCC) prevent
> users from cross-compiling it for their target devices?

This is also a good point. We need cros build binary and host binary.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
