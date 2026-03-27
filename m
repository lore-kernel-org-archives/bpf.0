Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748720F067;
	Fri, 27 Mar 2026 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774571308; cv=none; b=WlneNpHzuIUx7TEEvbNfcqzuGbOeecvAHAabDVOqs/Lq00gJF59KpGdjsznnEDCWuU7Yjhefb6y1FT7SVsl8xxrP2RkdUr7OE7h3bE2+2+/rcalZ+A1P/jBdeCtJoGy2STE1AO5XNyiz7ZrcapBwvCMylgEjTlg7HJ0rdTuXo9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774571308; c=relaxed/simple;
	bh=t0f7qTZoFLVX4PbGZBGtZK1nSxhr/Qx9XL4zfR2vAsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWH1RRx5xPLViF6rbj3fLRKlP72Js9DDHEv9Kt/DfzkD8Rmw2FEh3MCASuVm95FFwi1jbIFFxvdPEkI0Reqq7/wCLWNgeuZ5bXmvoaxUz9tx1HYcfQi1Sn9j6IHOPnRa9M+2pAhdVMJa6zfGx51mIh2CF0R6z+zoiesKL1lCb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afdFlI01; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afdFlI01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20196C116C6;
	Fri, 27 Mar 2026 00:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774571308;
	bh=t0f7qTZoFLVX4PbGZBGtZK1nSxhr/Qx9XL4zfR2vAsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afdFlI01rmuTFvP/Fx2DOpuEZUJAxLmkYR4hl6A6EtVkV88LbMUZ4Hfxh8JeAysh3
	 xr3IhQON5KcAB1V+ojfNMV50jv6GZThx9aAaO1n++12EWAHZMJcLClEIQm1dceTSqi
	 5hTpeKMN5B4tu8/JTF+06RTtmFcAmNs5wVdZSq4mqOX9Mt8qwARRSzFxFh4O32ayG0
	 S7QDHlI2L33gfDEIgTAbgA1agvUQaPS00rcgC1YbjXpWz2laQe50snLa6AH6IWuMMm
	 1tbaDnSJgmrYw4Aqjz6WV/R4o/5dExQc95nPXjdnA/mtltdlcQDBaVSRIYaBaxowMy
	 4TqI4fZ3NddCA==
Date: Thu, 26 Mar 2026 14:28:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: zhidao su <soolaugust@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [PATCH] docs: Document pahole v1.26 requirement for
 KF_IMPLICIT_ARGS kfuncs
Message-ID: <acXPKyDPAw6nR9nc@slm.duckdns.org>
References: <20260324062028.2479059-1-suzhidao@xiaomi.com>
 <CAADnVQLbtuD=7mtGZFR25ULhjZ-3ifBpkyRcqu9jPSd2Mt3fBw@mail.gmail.com>
 <69c2dbe8.170a0220.226f48.721e@mx.google.com>
 <e0ca748d-3204-4160-b37d-0f76cbac8c6c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ca748d-3204-4160-b37d-0f76cbac8c6c@linux.dev>

On Thu, Mar 26, 2026 at 03:06:28PM -0700, Ihor Solodrai wrote:
> On 3/24/26 11:46 AM, zhidao su wrote:
> > On Tue, 24 Mar 2026 08:12:12 -0700, Alexei Starovoitov wrote:
> >> I don't think that's true.
> >> At least when implicit args were designed the goal was to avoid
> >> pahole dependencies.
> >> Please share exact steps to reproduce.
> > 
> > Here are the exact reproduction steps and code path analysis.
> 
> Hi everyone, sorry I'm late to the party.
> 
> First of all, a *Nack* to the doc change in isolation, I agree with
> Alexei here. Tejun, I suggest to revert it.

Ah, right, this isn't sched_ext proper even. Sorry about that. Reverting.

Thanks.

-- 
tejun
