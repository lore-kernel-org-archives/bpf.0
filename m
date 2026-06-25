Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6218DB26;
	Thu, 25 Jun 2026 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398197; cv=none; b=HYdwEB7QfLqe/3DnbmAlvfi+wBPrnzCX2Z5MXEdgbAXWOoEvseHQy+OqzZqzGRz0oiPTviU91sI1rcUbhmkoKrYtYdvF4ioMKdLoQy7KzprNaVGJ3638pKRQXYADDYUeZR1YsDfwELOwgiNBsWQqvuWW4lXQtHFPNO5oYjFulB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398197; c=relaxed/simple;
	bh=MutUaWOcy8UStgksZpXCxUL5JTNVq1Aic408mCjLWjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAS2vIMTsfWVdnTXpnbY7kPBhgO303pGKVuvOOPaagp1UlNC46dFXSeUajflGcSAJyeMJqMgj5DdyF5S5AehAqxhA97/b9Es+Wdf+xWbR6LvH7ealv/CB7TsBNQFGVbqsal2C0rVUNLwHBhyjTeyzDsgVX/CnVoX0d3c7bG9qiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxJwCI6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxJwCI6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F061F00A3A;
	Thu, 25 Jun 2026 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782398196;
	bh=LbSQkfUUlzm5zlB1XH+iM2dbK0d5bmjr1Jd4ex8GGE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nxJwCI6tILxtZLWztXsGB2hXuTRqgwqMtlBNb9SwQfiFgTf4BwK7tkt4/60WcFxhq
	 WgdakcxzOSbmO1pZlz48Hn8c6mLbmbf5jsn3qorIx7dUfoBQsYOSHkQ4t/WckAr//q
	 /MM19xu9Tso+qpPYVDEJwvqTn9R6EWh2B2SN0kZI6RBNmVjrHwFijNIQqjXB0bMesj
	 KC6QtGAldBYE8BAjVx8dDHvsGIOp9N24xCqqMFMMpJjrub7FYm/rASSmESrchXGikh
	 ch3yr3LpxCjtqWw6o6vmJtdz92hDFUBO2Ffk98AleKRl1EIkzsHeAzHVRCUfm+HUda
	 vS5o6WOB4poBg==
Date: Thu, 25 Jun 2026 07:36:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <tushar.vyavahare@intel.com>,
 <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
Message-ID: <20260625073636.449a28c0@kernel.org>
In-Reply-To: <aj0EYNt7Sr1dD96N@boxer>
References: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
	<20260624193326.295e3711@kernel.org>
	<aj0EYNt7Sr1dD96N@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 12:35:12 +0200 Maciej Fijalkowski wrote:
> On Wed, Jun 24, 2026 at 07:33:26PM -0700, Jakub Kicinski wrote:
> > On Tue, 23 Jun 2026 11:10:08 +0200 Maciej Fijalkowski wrote:  
> > > Subject: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test  
> > 
> > Do you want it in net? Either way - we'll need a rebase  
> 
> I have not checked if this has been -net propagated already, but the rule
> of thumb on bpf side was that all selftests related effort goes to -next.
> Is it different on netdev side?

We prefer -next too, but during the merge window net-next is closed.

What we definitely don't want is a -next patch with a Fixes tag.
So either net or drop the tag, please.
