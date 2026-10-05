Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C32654705B;
	Mon,  5 Oct 2026 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207152; cv=none; b=HWGppssMkxNsPcGr4Clesp16JMTt5uiBBFT0e/XvvtpcJwVvPrAXka7/kvJ9GVOw5Cs04cV3PCTzxpGOYPskwuONRnvBoDGccFsOFZjjhoZOM1PV82Z3rakuUHUIOpkEPXVebiN7G90Y7lqOmYF7qKfZFHJa8kMMD1SHN7X5eDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207152; c=relaxed/simple;
	bh=KfbZgw+MbnLMNDvDtxjij1k4+Qvjn0s0K1i/l50Ut2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgqmZ+h5ZdKBS93w5fZVSNWhXv7t2KQC8vTtRCS50lCA7OIVlm8FzardSb3JnhO+8ke1NrZviLn6AcDFFkPfw7Fu8RN+jFyHDsp3FmRBdyLYZ6MSiADnPWRtLKc6mfWOEatUKGlY/pUZdwe18TJgtv8TKeJ92DzhWENt2hDgONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaCTm2my; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaCTm2my"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2CA1F000FF;
	Mon,  5 Oct 2026 13:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207150;
	bh=HwhbK90GfJPHbz/p1SAwjEYSFhNOACJ0jZSx9FAlqjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iaCTm2mylRf5L2yDz25np2hXPnS7juatpYG6j/X7rUruFK3ban4Xcuvj8VABTFoj4
	 QC0BBWG/oxfaegPx3vGBGtF/2Vb/SboCt/3YizkrFtnkfxsBB0cWTqhb4YVuXmI5NY
	 P0A6rqw2HkohdJBxTCeEuzmHkR1cz552XBqXAE/wpdYOmVhC4fobs+djNp5rMVxBzo
	 MiQzYxtdVqVsoPQyUbNqIypR3BvbmywlGuSIjSorf16Qkcsp3qDHXfqvJK17cY+Pjw
	 O3YAQKKrbFuRWLrufzuSZzCXbDUyCJHPR1cJJZJuQB422jep2NQPCxwzOzfF2SMvs5
	 1GVnv1oTqr0Dw==
Date: Mon, 5 Oct 2026 15:32:24 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	KBuild Mailing List <linux-kbuild@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Nicolas Schier <nsc@kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the kbuild
 tree
Message-ID: <20261005133224.GA1108555@ax162>
References: <asAzcgDsbNEFIfKV@sirena.co.uk>
 <20261002230632.GA314599@ax162>
 <asA6NZ4QKp4k4nGD@sirena.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asA6NZ4QKp4k4nGD@sirena.co.uk>

Hi Mark,

On Sat, Oct 03, 2026 at 01:11:49AM +0200, Mark Brown wrote:
> On Sat, Oct 03, 2026 at 01:06:32AM +0200, Nathan Chancellor wrote:
> > On Sat, Oct 03, 2026 at 12:42:58AM +0200, Mark Brown wrote:
> 
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your tree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particularly
> > > complex conflicts.
> 
> > Thanks, the 'source' line looks correct to me now. Did you also shuffle
> > CC_OPT_INLINE_MEMSET into scripts/Kconfig.toolchain like below? You had
> > it right in
> 
> >   https://lore.kernel.org/ar5-4Yq3wtmXTWnD@sirena.org.uk/
> 
> > but the patch changed slightly since that resolution ('4294967295' to
> > '4294967294') due to a problem I reported
> 
> That will be delayed for today since the scripting has got confused by
> me moving machines in the middle of running the merge but it has gone in
> later in the merge so it should be there in the final tree, and
> hopefully in the right place next time I run -next (due to LPC/MS it'll
> be spotty at best this week, I and everyone likely to provide backup are
> all in Prauge).

Can you drop the fix up to scripts/Kconfig.toolchain that you added in

  855c706f2179 ("Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git")

? I have temporarily handled this conflict in kbuild-for-next to make
life easier for you in

  fd79efef14d9 ("Merge commit 'ac7445c28e7a' into kbuild-for-next")

and your fix up conflicts with it, as CC_OPT_INLINE_MEMSET is defined
twice.

-- 
Cheers,
Nathan
