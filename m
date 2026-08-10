Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB037A840;
	Mon, 10 Aug 2026 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348938; cv=none; b=SGgZD8I72r9TnTA1nYcZAtrV8YCmv4hBg/a8sdb78MhNV/BotUq3ANyP8eeAkKKCpxcBxDnaXlpVxLsCdX1SnMPauxOIbRwZqQ1w6YOVg3yPEBEfB1KQ3noMV5BFXDGLOS+lM2lIO7FOKnrUNj36iQt+Cp/anj0k4dEMROH6qoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348938; c=relaxed/simple;
	bh=/fNc5SGhyQrQXVKbO9qDIggCMXulGF5DofcIfTX2n0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mibxv7CBRKYY/xABQI/vtCMPcAsYewwOh3kFMI7LKQloiFuABjpuRquW74E2h8HPdmGUjXmUD7YrTGNXnuPH33rparrCuneOV3WuEF0cEYojZp44+SlCSi1ErmUBIBiSkPRo8IfhBNpHGW63bUdWyVTy8CpR7BshVWJqurf694I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qezp4qo+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qezp4qo+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/W+XsVUanySFDoNBpzYIBGgh3CLboIF3g/MwTHkub7A=; b=qezp4qo+EM4MmFDTanMWwbRJL9
	qNIZtnbKaU+vByTJAmeA9wu0laxT4NVLwJWUsY/vKFZD+sZ4vCw1IHlYlCtUkOiTMzvKFtRVk/UHS
	3jjuPa9lD1GlowZbI9Nhz6/aNdf0+kr+9lK3ygSamRdocnvarxhPPYtBNa8Mgd59yK9Ok56jNbyQ1
	v4sJwgV9xwSNUGFNHeL/a9cH4sKlGarSQUui1Erb0iHlq/kLeXpnuh/0XJ2DunSAnm4JvdWQpCLW8
	M4Qsy1CVkk5HYVNC6fOceNgDJOHmp0+TYbNhJUU6m1MfTeEaL+WA85mtHLX44TjdbigJpzgvVdIAD
	bzsryJLw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtKxV-0000000Aa0a-2GFE;
	Mon, 10 Aug 2026 08:02:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6F0023030A6; Mon, 10 Aug 2026 10:02:07 +0200 (CEST)
Date: Mon, 10 Aug 2026 10:02:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Jennifer Miller <jmill@asu.edu>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	linux-hardening@vger.kernel.org, xmei5@asu.edu,
	samitolvanen@google.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v1 1/1] bpf: Enable JIT hardening by default
 when x86_64 CFI is enabled
Message-ID: <20260810080207.GD1642880@noisy.programming.kicks-ass.net>
References: <20260710191932.120911-1-jmill@asu.edu>
 <20260710191932.120911-2-jmill@asu.edu>
 <202608091030.C69278022@keescook>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202608091030.C69278022@keescook>

On Sun, Aug 09, 2026 at 10:30:35AM -0700, Kees Cook wrote:
> On Fri, Jul 10, 2026 at 12:19:32PM -0700, Jennifer Miller wrote:
> > Initializes bpf_jit_harden to 1 if x86_64 CFI is enabled. Prevents the
> > misuse of BPF JIT code to craft CFI signatures or Endbr64 instructions
> > by enabling constant blinding for JITted BPF code from unprivileged
> > users.
> > 
> > Signed-off-by: Jennifer Miller <jmill@asu.edu>
> > ---
> >  kernel/bpf/core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 47fe047ad30b..ed22b90c6e4e 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -548,7 +548,11 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
> >  /* All BPF JIT sysctl knobs here. */
> >  int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
> >  int bpf_jit_kallsyms __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
> > -int bpf_jit_harden   __read_mostly;
> > +/* Enable hardening by default when x86_64 CFI is enabled to prevent CFI
> > + * hashes and endbr64 instructions from being crafted.
> > + */
> > +int bpf_jit_harden   __read_mostly = IS_ENABLED(CONFIG_X86_64) &&
> > +					IS_ENABLED(CONFIG_CFI);
> 
> Why not just do this for all CONFIG_CFI?

Additionally; does it make sense to add an arch hook to
bpf_jit_blind_constant() / bpg_jit_blind_insn() such that architectures
can blacklist certain values?

Because as is, the whole thing *can* still generate an ENBBR by sheer
accident.

I'm thinking something simple like:

	while (imm_rnd ^ imm == gen_endbr() || imm_rnd == gen_endbr())
		imm_rnd = get_random_u32();

should do.
