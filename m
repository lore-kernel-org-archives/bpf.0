Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564DA29BDBB;
	Fri, 10 Apr 2026 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783992; cv=none; b=VlNB6Xve4q2PfMnJip3pEoAu8+1F2qwnmQpvR3a8PW4MuFtG2+piK6kNWtUouGcgp3RQ3nCfpJog3ushApYBrwDApKwASyPeKRhXIXsU8jCrOXPbNjWYA9kStptWy1kGElDoLNPoc8A3/ZgwG8fqhqn8K3XdeI987WHXrBXkFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783992; c=relaxed/simple;
	bh=gGsYUBEVZo5hL9O/fOakoYwSsS5d8ujkz8bA913vz/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlXRyFgd/bwTidXqNsfe4FKO3RinrkiS4u+bL9dpezeLkduNcbL3L7QG3OzDyFoZPKgPrgHMbefRbS8tIWer7nd1kmSFXlDQnl9OcioHewS5LsUHMbMpP0IWg2uxp0ZLcvTnTbTV3jC1XmeDs2yFg+zwdTbycebdNZpenR1K+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdK01tbF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdK01tbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28374C4CEF7;
	Fri, 10 Apr 2026 01:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775783991;
	bh=gGsYUBEVZo5hL9O/fOakoYwSsS5d8ujkz8bA913vz/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EdK01tbFfPp86XRPo/eMsK/uDK4xhM8XN5Fro5qYwi3RjHBxMyP6UwwfsZiT+LaEZ
	 JRSvRY0cAeyha/rwP5Ecci8hMrtI5EP3wglEys7029PioWgWZTrnp0JIBH6PmsXvsd
	 ehxuxumwnFyP9lGJgOiBfU8LnOfY4xF2ZfAbjQBUJfnKcv0lxfqnPNu+nZF0QsCCkd
	 4F5meCw3vK/o9fqz66vXvjcrF03SYuLBBaZUAicxKFjaKR+9vHGulpxGeP4Bp215aO
	 nZcFuaSrNgpDBUAvuAGOrTs2w7k9STTW5KDCDXJna5L4y7zTVo889+im+3y3gUDNL4
	 0vU1l8xcU5SHA==
Date: Thu, 9 Apr 2026 18:19:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v11 14/14] selftests/net: Add queue leasing
 tests with netkit
Message-ID: <20260409181950.7e099b6c@kernel.org>
In-Reply-To: <244b745a-3c95-48c3-b6c5-11ed3eacdf46@davidwei.uk>
References: <20260402231031.447597-1-daniel@iogearbox.net>
	<20260402231031.447597-15-daniel@iogearbox.net>
	<20260408162238.16709090@kernel.org>
	<244b745a-3c95-48c3-b6c5-11ed3eacdf46@davidwei.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Apr 2026 08:26:30 -0700 David Wei wrote:
> > ksft_run() can't be called multiple times.
> > 
> > The first run looks like it's purely testing netdevsim. So that should
> > move to selftests/net. The rest which tests HW should stay here.
> > Please also move all the setup inside the test cases.  
> 
> Sorry, didn't know about multiple ksft_run(). I'll prep the follow up
> separately so we can land it soon after 7.1.

I have a patch queued to make multiple ksft_run()s hard-fail.
So let's not wait until after the merge window if that's what you mean.
