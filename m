Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B4367B62;
	Thu, 25 Jun 2026 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401378; cv=none; b=RFt+Am2huw0mQnvakCV0ZEDpdPmXQ6Uk/VTj+jfkjicQBdSDexkr0p1B/3sudCKGgPpFtPu/vEZ0KjizF1O+T4ibjtHUw6kSfq2Qk+IdXszInMALpq7TLEduT9W1FYhbwzKEAxYRcZf35e4lqtOWrelHr2FX7T+eJCJFWDDOzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401378; c=relaxed/simple;
	bh=w4J8LMxa47GaTafta8LeIflw8fTgvKf83WTxJtwwJz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xy/vieTWh2cZHk0slPBid3br2Ve055xIODlxyRDWb56Nj3OSUztHxw/wL+ZH7RCBw/BO23f0Qxnb+REWrJhSkKfjtUZKmTzANqqwNzomJNWSR46IW27K0/OleaDHsyf1sJ8rNPQWuf4dik+Nc+eOouZ5IhhvP0IGWzPzSyhLjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyjUgV6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyjUgV6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D391F00A3D;
	Thu, 25 Jun 2026 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782401376;
	bh=bs4Yn4Wfai7P6kGfbd32/Pz8JgxaNOwodkyvGYPv2uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JyjUgV6KrkzbIZnrM5fdUZ5eYa6GuthSNIk77fjYuN0bpLV68sCRKmwkD5strMGKR
	 JyTXk14zp54DZp6/n60s6htkfmj7z8qr/H27RNUMvniDkFseADd0J6am2KvjwsC7V8
	 ofh/sPwq9qur+ka/ykbrAA0BVz3oVNYt4SLEQBL4IDpSSDw/rcUFnJ7i8jlf0LYRWE
	 2Y32kMIhwOHD4wsJzkLZ0q/wb0WZy3AnBjoAgOFQsPWbebutla3lwsm4UlP4c1O0yE
	 ZZKxu466mQhV3bxu/UjlDNsIL6yNIcHKqGqp0dSn7tlcPsl2V3jXeizy3Qc92i5rFm
	 r/WADWGOi+8jg==
Date: Thu, 25 Jun 2026 08:29:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <tushar.vyavahare@intel.com>,
 <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
Message-ID: <20260625082936.3a44f8c6@kernel.org>
In-Reply-To: <aj1He9vNkRh+Ettf@boxer>
References: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
	<20260624193326.295e3711@kernel.org>
	<aj0EYNt7Sr1dD96N@boxer>
	<20260625073636.449a28c0@kernel.org>
	<aj1He9vNkRh+Ettf@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 17:21:31 +0200 Maciej Fijalkowski wrote:
> On Thu, Jun 25, 2026 at 07:36:36AM -0700, Jakub Kicinski wrote:
> > On Thu, 25 Jun 2026 12:35:12 +0200 Maciej Fijalkowski wrote:  
> > > On Wed, Jun 24, 2026 at 07:33:26PM -0700, Jakub Kicinski wrote:  
> > > I have not checked if this has been -net propagated already, but the rule
> > > of thumb on bpf side was that all selftests related effort goes to -next.
> > > Is it different on netdev side?  
> > 
> > We prefer -next too, but during the merge window net-next is closed.
> > 
> > What we definitely don't want is a -next patch with a Fixes tag.
> > So either net or drop the tag, please.  
> 
> I have verified that offending commit is present in net tree. Could you
> apply the v2 that I unfortunately sent already targeted at net-next, to
> net tree?

Will do. Hopefully it applies, cause net-next wasn't forwarded yet
so it doesn't include Tushar's patches.
