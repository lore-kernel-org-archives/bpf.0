Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DF25F7B9;
	Fri,  2 Oct 2026 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982400; cv=none; b=KfALSFy1f1H1VISnY+TxNtxseoeNSDRJXulsueiyuz388LjUPS5PojC8R10yzhvNICCGpWk+6JcC9EIhdYH2jI7lkK/NYRiUWz6otHWBmhhb6IExoqTJo0S+Jy55heiSOwHQORcIBOK31dy4ZsWxIlZ/FTPGgZ0smkZTCJwRMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982400; c=relaxed/simple;
	bh=G0ehjrQTHNkoIUtvOrhLgjOSaa2sUAG6/htLVsm0ySs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkzahUHNMm7NjsirXa0gFfVexuprdGF/VUE1lCYHTz4UUvM+IN9mnzoqpkeeGnUuxs/rek0uZX7WhtvupqIEiM8b4pTfAhNzgEJO3PodB9qzt3Cf9/g9J3YUxwlIHDxQIvRtqWxrHWZdA+VGqd4YmVi1ebd5u2TZZaHNp9R+/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiXSF2C/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiXSF2C/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B441F000FF;
	Fri,  2 Oct 2026 23:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790982398;
	bh=/L5zJYgpln1RMs+685EXIcz9wmgL0JHHpmJGUTsDh+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GiXSF2C/tcsnNKP9r/fJrFmV9qRWCCNsxaWC1Areuy5RVdQnis5UNY+q2TVeNsSdi
	 2Lj4XGOP53fPB7i3LWP4yJ4rzuJXkqIEGcjTpFXFumqjd++rijV9Y0RpvAn1WXDZB/
	 XosfrWYk7XSOx/hdyFQvI7WbPyfj6MjNPpRC9SskoOV4IOAJU9ClKhln1Z73B85ZXX
	 5XpEhWdnsvEyfvMoTSq2VaD3QKATvGYu0q7wiNJN2NgQ9XcCyvknyhrcRPS1R7HE0b
	 VBZpcQdUDQdMvlPDr1Og2dIIctclLDa0rr9ifF6vCT6BcGF5DUa6Hw77Z6GLwKg9Y2
	 8RmAtMcAoYAfw==
Date: Sat, 3 Oct 2026 01:06:32 +0200
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
Message-ID: <20261002230632.GA314599@ax162>
References: <asAzcgDsbNEFIfKV@sirena.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asAzcgDsbNEFIfKV@sirena.co.uk>

Hi Mark,

On Sat, Oct 03, 2026 at 12:42:58AM +0200, Mark Brown wrote:
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   init/Kconfig
> 
> between commit:
> 
>   f85147b291e35 ("kbuild: move the toolchain checks into scripts/Kconfig.toolchain")
> 
> from the kbuild tree and commit:
> 
>   eb13a1ff271b0 ("random: vDSO: avoid call to memset() when zeroing reserved parameter")
> 
> from the bpf-next tree.

For the record, this change is from Linus's tree, as it was merged in

  ac7445c28e7a ("Merge tag 'random-7.3-rc6-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random")

but presumably your stable base does not have that merge depending on
whan you started -next so it comes in from the bpf-next merge of Linus's
tree in

  2b5440b31caf ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.3-rc5")

I just wanted to make sure the bpf folks didn't think they were on the
hook for this conflict, it is only on me with the Kbuild tree now.

> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks, the 'source' line looks correct to me now. Did you also shuffle
CC_OPT_INLINE_MEMSET into scripts/Kconfig.toolchain like below? You had
it right in

  https://lore.kernel.org/ar5-4Yq3wtmXTWnD@sirena.org.uk/

but the patch changed slightly since that resolution ('4294967295' to
'4294967294') due to a problem I reported

  https://lore.kernel.org/20261002094932.GA3435055@ax162/

before the patch was sent upstream, so I wanted to make sure that you
did not reuse the old resolution (and I didn't see a mention of it in
this email).

diff --git a/scripts/Kconfig.toolchain b/scripts/Kconfig.toolchain
index d708a175fe48..c9d2aef4e355 100644
--- a/scripts/Kconfig.toolchain
+++ b/scripts/Kconfig.toolchain
@@ -247,6 +247,11 @@ config CC_HAS_ALLOC_TOKEN
 config CC_HAS_MULTIDIMENSIONAL_NONSTRING
 	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
 
+config CC_OPT_INLINE_MEMSET
+	string
+	default "-finline-stringops=memset" if $(cc-option,-finline-stringops=memset)
+	default "-mllvm -max-store-memset=4294967294" if $(cc-option,-mllvm -max-store-memset=4294967294)
+
 config LD_CAN_USE_KEEP_IN_OVERLAY
 	# ld.lld prior to 21.0.0 did not support KEEP within an overlay description
 	# https://github.com/llvm/llvm-project/pull/130661
-- 
Cheers,
Nathan
