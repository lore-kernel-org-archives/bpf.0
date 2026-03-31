Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E966A3D8911
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943728; cv=none; b=YXGx2wdEenFnfiLSVM2YFJl5ZvEZrPSTmLHghPkQVLzr05LYC9HSEYj6ns0q1BfN+zvKHWq2gtsLEZXCt8wAEWxiGIjN6oHMB7rpFIwj5zXuDC0uwz8hzAaqyjNna4fRMqrZLYNPmkTyt14VGfW+6XmcBTvDpBiEDDcL9H19Aas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943728; c=relaxed/simple;
	bh=778yORRXqloS93hBMFXxU0TOgCHvEeAGEkAxgdN1NGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHeAGsmxxYqVSbn1Z8ZWluNkUlRfNfuAwvP+lFeIBWuDjdSOvR1PwV8fghcv7hiODAqZH6GThNsO38YWbQIsy330I4F7wkJcB86xj4MN4WRaOEHOpW17pBXCW6OR8F+e84qwGJLYsOKALPUki5bxd8g1D8KP0cn+x8cKclC3p8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ77kmeq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ77kmeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4C1C2BCB3;
	Tue, 31 Mar 2026 07:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774943727;
	bh=778yORRXqloS93hBMFXxU0TOgCHvEeAGEkAxgdN1NGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQ77kmeqDacWo1J4TYJ7GXD9jKtSimG+xh3H78go4LrVEJiufPhcQ4W1jsTXyLZnX
	 saxYXNNVEHWg0VfEso/bCcdd+aexoCfQpDWJItmXpsbNbcue/Gf4+lDdfaByRJMsST
	 ktZ76FxO2OnP30+m2d0+uh/VoPG7GXiWNNGYMKp04CyUoUhsAANSkYdjPrQND9dmeP
	 ydo+jGlik9OpvUZYh3jG4ls/2LN62c/O8O6moqVSdDXTvOK27mhPjQlMhhKJ8UsOkF
	 mF4Rtc0MfNdENT7hNsdkRKD0o7r5PoabMkyKYR3PdUD1lc7RIFYZL4LBbI1cSCNqfa
	 luAHRirBio+Hg==
Date: Tue, 31 Mar 2026 09:55:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	bpf <bpf@vger.kernel.org>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Abhishek Dubey <adubey@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [linux-next-20260327]resolve_btfids warnings for unresolved
 bpf_lsm_bdev_* symbols
Message-ID: <20260331-verglast-lernziel-ea0b91c55682@brauner>
References: <6ebc74b5-3dd8-4bb5-adac-fa32bf71eacd@linux.ibm.com>
 <CAADnVQ+KpCZqjAhMBzDZqm14yaORK-PG2VHRnub1Q0gYTHKG=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+KpCZqjAhMBzDZqm14yaORK-PG2VHRnub1Q0gYTHKG=Q@mail.gmail.com>

On Mon, Mar 30, 2026 at 07:42:18AM -0700, Alexei Starovoitov wrote:
> On Mon, Mar 30, 2026 at 6:45 AM Venkat Rao Bagalkote
> <venkat88@linux.ibm.com> wrote:
> >
> > Hi,
> >
> >
> > While testing linux-next, I’m seeing the following warnings during the
> > build:
> >
> >
> > WARN: resolve_btfids: unresolved symbol bpf_lsm_bdev_free
> >
> > WARN: resolve_btfids: unresolved symbol bpf_lsm_bdev_alloc
> >
> 
> Christian,
> 
> looks like those two need some #ifdef

Did you want me to resend or are you fine with fixing it up in-tree?
I don't have a problem if you do that fwiw.
