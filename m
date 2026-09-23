Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B413B8930;
	Wed, 23 Sep 2026 04:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137291; cv=none; b=BWrelGwuFglPBy/aSA78nTlMJK2d7bXYYl8cxNJSfMD8tncCoEh07EFD1tx5Cxouzwvg4uO5DrUUXSJaPhxMxbaTeQI3Hilyn2ENUvGfm/Bx560M30oxoEgc6bsyOQEBRHa3V9zHgYb4D7xEH+AMcCRL5WkMJWXqRAA62P+XgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137291; c=relaxed/simple;
	bh=8J9/2QPGibJv8atMjZd4P5SCNndbdItRhrLh1THYqOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEL+G/1C5zU+3zwqYBo8/Bcvpr3IeQmOF/G21TsxEFtoc20yPAkPc76tT3g3X2TIqqP645CtF0R1leBRVuZD8D54HKW1XjvSnpG9b7DOUtMTF6+SgYk4p4QdWEiWW2EFNYwosOnU7TxtV81D/cCXazI14LxHEkSELA0n5FmZLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3vjvKsH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3vjvKsH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852271F000FF;
	Wed, 23 Sep 2026 04:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790137289;
	bh=8gm/zN6fCcjmwq5mKseC3GenP7LmjNeWg6wSLYqzJiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B3vjvKsHQ1zdACev6FmC1n6esdgacJiUBe8fac08OqAvR+sY3BvJgDY7mEV2XroiN
	 EoFBpzSGj6OmlzSA99Zh0/L1jMNQQ07gVkm93z9XwPD1gnArkFzMH3JPzPa/V6lDfx
	 eootcLSOQalvn/937541GbcdZoBGV6ajL5pmKH9MbbH/5fv0efgyZGKcEv8YCM05XB
	 JVhN/uGLqv96rClfsbYpHDqpPB3dRzfpuHETknpzkdINWnJD+koE/ZMma7ouZnwXA6
	 u2fUL6tfYxBwyKEZk7LjtVefSIfNOpcuDEWrx+XMOcyBMFMuQ2EczLKaqH151WcfaD
	 bpERtNRPtIihw==
Date: Tue, 22 Sep 2026 21:21:28 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4] bpf: crypto: Use AES-CBC and AES-ECB
 libraries
Message-ID: <20260923042128.GC42709@sol>
References: <20260923032703.59816-1-ebiggers@kernel.org>
 <20260923033742.D45A81F000FF@smtp.kernel.org>
 <DLMEAUZ632XP.210Y7S9N70NHW@gmail.com>
 <20260923041124.GB42709@sol>
 <DLMEKP1LHU07.31JTP12GKADU8@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLMEKP1LHU07.31JTP12GKADU8@gmail.com>

On Wed, Sep 23, 2026 at 04:15:13AM +0000, Alexei Starovoitov wrote:
> On Wed Sep 23, 2026 at 4:11 AM UTC, Eric Biggers wrote:
> > On Wed, Sep 23, 2026 at 04:02:22AM +0000, Alexei Starovoitov wrote:
> >> On Wed Sep 23, 2026 at 3:37 AM UTC, sashiko-bot wrote:
> >> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> >> > - [High] bpf: BPF_CRYPTO is silently disabled if AES libraries are modules
> >> > --
> >> >
> >> > commit 1bcee0286f1c7c6c86befd107081ebb8a0fb0eed
> >> > Author: Eric Biggers <ebiggers@kernel.org>
> >> >
> >> > bpf: crypto: Use AES-CBC and AES-ECB libraries
> >> >
> >> > This commit reimplements BPF crypto using the AES-CBC and AES-ECB library
> >> > APIs instead of the lskcipher API. It adds a new BPF_CRYPTO Kconfig option
> >> > to conditionally compile crypto.c based on the new AES library dependencies.
> >> >
> >> >> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> >> >> index d7d25477ef481..a44ecfa3e9ef5 100644
> >> >> --- a/kernel/bpf/Kconfig
> >> >> +++ b/kernel/bpf/Kconfig
> >> >> @@ -91,6 +91,15 @@ config BPF_UNPRIV_DEFAULT_OFF
> >> >>  
> >> >>  	  If you are unsure how to answer this question, answer Y.
> >> >>  
> >> >> +config BPF_CRYPTO
> >> >> +	def_bool y
> >> >> +	depends on BPF_SYSCALL
> >> >> +	depends on CRYPTO_LIB_AES_CBC
> >> >> +	depends on CRYPTO_LIB_AES_ECB
> >> >
> >> > [Severity: High]
> >> > Does this dependency logic silently disable BPF_CRYPTO if the AES libraries
> >> > are built as modules?
> >> >
> >> > BPF_CRYPTO is defined as a bool in Kconfig but depends on CRYPTO_LIB_AES_CBC
> >> > and CRYPTO_LIB_AES_ECB, which are tristate symbols. Under Kconfig rules, when
> >> > a bool depends on a tristate that evaluates to m, the dependency evaluates
> >> > to m, which downgrades the bool to n.
> >> >
> >> > Consequently, kernel/bpf/crypto.c might not be compiled, and the crypto
> >> > kfuncs could be silently stripped from the kernel. Existing BPF programs
> >> > using crypto kfuncs will fail to load with "unknown kfunc". Because the AES
> >> > library symbols lack user prompts, users cannot manually fix this by
> >> > explicitly setting them to =y in menuconfig.
> >> 
> >> The bot is correct. Looks like a regression.
> >
> > Users can enable the libraries indirectly by setting
> > CONFIG_CRYPTO_AES=y, CONFIG_CRYPTO_ECB=y, and CONFIG_CRYPTO_CBC=y in
> > their kconfig, as the self-tests config does.
> >
> > I do not know what you expect.  The libraries themselves do not contain
> > independent functionality (besides functions that other things in the
> > kernel can call) and thus are hidden symbols themselves, as per the
> > usual convention in the kernel.
> >
> > As I said on v1, if you want a prompt for BPF_CRYPTO, I can add that.  I
> > can't find any other example of kfuncs having prompts, though.
> 
> No. prompt is not necessary.
> My question is why disable BPF_CRYPTO when these are modules?

If libaes is built as a module, then either bpf_crypto would have to be
built as its own module (which we already ruled out on the last thread),
or else this code would have to be merged into libaes.  From my
perspective putting this functionality in libaes seems weird because
this acts more like a user of the crypto code than part of it.  But
maybe it would be more aligned with how kfuncs are usually implemented?

Note that it's kind of hard to actually build a kernel with libaes as a
module anyway, though, due to so many things needing AES support.

- Eric
