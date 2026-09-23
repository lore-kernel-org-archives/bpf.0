Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E73B8930;
	Wed, 23 Sep 2026 04:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136687; cv=none; b=fuwyXCKpnPvdaYt6rIvmMwf8iVNgDpngGaTpuwlVeerb/paIloMVKOrP+917LDw+pASmHB+tL0YjHTFstOJL/kwHXxBeZpu+ZnGFi10Hm2MZkR9nxBP4wpA09ac5bqMFztp0OgiiUCSUFW5aMfvEn9VONeYimjbXb9e9CXa/2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136687; c=relaxed/simple;
	bh=Vklr7/OiaNYIJiJmNmgv75itseqCt5FefFgD22GPze4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiZD8znHYgeJseF2KmfM7Q+2201BLuKv8IpJ2CNpCGzUcvxi3ZCTBHyWxir71KDtq9WwQNsW+4qTae4ERyDze7Bw/vtkMjSl1pJDQk2uDDQ8+CCuffdOy01ZFglJUnkSZI4JypKkoXz0hOakJXn7eckw0CefC23/yGAjqFRG9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNYOHcB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNYOHcB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2446A1F000FF;
	Wed, 23 Sep 2026 04:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790136686;
	bh=3/sfiWMC1EivnZYRzQvYrEQx8IUJvByWRFkWC+DDU9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MNYOHcB5tlFkDUYxEpp0e7JrUITdoHxzWAkDReFG6tStMDm9/S+2HGdEIapzjL8Iz
	 vKE7q7CSYoYes4nHQq4WX+EOg9DG6Gtrs67VrKV1pyOq0YwPrTzHv3iLhtVhs129He
	 Jwv6tWyr7alWEoVO4wJHIntMUjaNh9xYM9zxJPLqgwaQVB97qMwk2Ys5PaZCbyxNEU
	 oT35SADAPryC/5jak6lBI4AgA3MBSIj67Cn7HnmAbOKP8kPvaw/OX1H71AnzqPr4KA
	 lrt1X5m0mO8UGHWqWrtZBV4AksY14FU97GuU7hgY5AWmhea2QL6+zb6+t/HmqaXz9E
	 va67vOFxInzUQ==
Date: Tue, 22 Sep 2026 21:11:24 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4] bpf: crypto: Use AES-CBC and AES-ECB
 libraries
Message-ID: <20260923041124.GB42709@sol>
References: <20260923032703.59816-1-ebiggers@kernel.org>
 <20260923033742.D45A81F000FF@smtp.kernel.org>
 <DLMEAUZ632XP.210Y7S9N70NHW@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLMEAUZ632XP.210Y7S9N70NHW@gmail.com>

On Wed, Sep 23, 2026 at 04:02:22AM +0000, Alexei Starovoitov wrote:
> On Wed Sep 23, 2026 at 3:37 AM UTC, sashiko-bot wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] bpf: BPF_CRYPTO is silently disabled if AES libraries are modules
> > --
> >
> > commit 1bcee0286f1c7c6c86befd107081ebb8a0fb0eed
> > Author: Eric Biggers <ebiggers@kernel.org>
> >
> > bpf: crypto: Use AES-CBC and AES-ECB libraries
> >
> > This commit reimplements BPF crypto using the AES-CBC and AES-ECB library
> > APIs instead of the lskcipher API. It adds a new BPF_CRYPTO Kconfig option
> > to conditionally compile crypto.c based on the new AES library dependencies.
> >
> >> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> >> index d7d25477ef481..a44ecfa3e9ef5 100644
> >> --- a/kernel/bpf/Kconfig
> >> +++ b/kernel/bpf/Kconfig
> >> @@ -91,6 +91,15 @@ config BPF_UNPRIV_DEFAULT_OFF
> >>  
> >>  	  If you are unsure how to answer this question, answer Y.
> >>  
> >> +config BPF_CRYPTO
> >> +	def_bool y
> >> +	depends on BPF_SYSCALL
> >> +	depends on CRYPTO_LIB_AES_CBC
> >> +	depends on CRYPTO_LIB_AES_ECB
> >
> > [Severity: High]
> > Does this dependency logic silently disable BPF_CRYPTO if the AES libraries
> > are built as modules?
> >
> > BPF_CRYPTO is defined as a bool in Kconfig but depends on CRYPTO_LIB_AES_CBC
> > and CRYPTO_LIB_AES_ECB, which are tristate symbols. Under Kconfig rules, when
> > a bool depends on a tristate that evaluates to m, the dependency evaluates
> > to m, which downgrades the bool to n.
> >
> > Consequently, kernel/bpf/crypto.c might not be compiled, and the crypto
> > kfuncs could be silently stripped from the kernel. Existing BPF programs
> > using crypto kfuncs will fail to load with "unknown kfunc". Because the AES
> > library symbols lack user prompts, users cannot manually fix this by
> > explicitly setting them to =y in menuconfig.
> 
> The bot is correct. Looks like a regression.

Users can enable the libraries indirectly by setting
CONFIG_CRYPTO_AES=y, CONFIG_CRYPTO_ECB=y, and CONFIG_CRYPTO_CBC=y in
their kconfig, as the self-tests config does.

I do not know what you expect.  The libraries themselves do not contain
independent functionality (besides functions that other things in the
kernel can call) and thus are hidden symbols themselves, as per the
usual convention in the kernel.

As I said on v1, if you want a prompt for BPF_CRYPTO, I can add that.  I
can't find any other example of kfuncs having prompts, though.

It is really up to the people who actually want these kfuncs to say what
they actually expect them to do and how they expect to enable them.  It
has been really hard to get that information, unfortunately.

- Eric
