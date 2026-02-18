Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425E42F3C26;
	Wed, 18 Feb 2026 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409147; cv=none; b=JpLZOWIHe23sslr3cmy12K16uBar4+s+qfduEdH569vBj8JXZDT0IXNWh2INwehvxRrv8imdjs2U2gz5X/R688C8gZQ3rQv6czuuq17jEMedjxKPjxMxRZRiaI3eXpmoyKxPrlSFPXrDCVYZslrsY9WbSmAMEZEVb5gZFhXAr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409147; c=relaxed/simple;
	bh=kLT5JACKc+pOyYqVJ+9OSDCRSuRTgDta+j0hURrW3uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLeAfeolXu9Pl+/jPhBHZ/BbPglWiUWtbhbGk6s6lQ7EHiNSLc/PGXyahOhkYZa8vUp9CCkRBzCduz3KEz+CDnxsdp8o4LrQlLSUs2eoIgWYToQRlHV2nrrvvjrHbUpSy+Attqs2vfza4jCTHjVu9ODKMFIeGLeZT0m6Kc5ccfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCU8OyxW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCU8OyxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C731AC19421;
	Wed, 18 Feb 2026 10:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409146;
	bh=kLT5JACKc+pOyYqVJ+9OSDCRSuRTgDta+j0hURrW3uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCU8OyxWGobVBw6YWdUCkVTPQH6Ra2qN08bDV7im5z2H45wp6KVFC9h3s7aYNJTws
	 NmBo9Nx6OrBYV8ZXDnelrY5pQ5hR5n0HnkNuSVAZUkiSOMRE4EOUk9VW2ZSodtmdaH
	 DIB6YUNKx2jvP8vGJvBxRvV8y8eSjUF3rn8zK0Vv1KWdrquHNcJocBidNPXUGRdK+G
	 mPjmvUVpHB/iJcSXf4j12o/yWJjUYSInDRweH4Kozw0ZsKs6BMlr+x/Q7tbL/mLf8I
	 rdJedrdMMzNSlcmtDg/B1JaJEBbcpQ2LrzYueyh37eIvYvmi+hzsmLs1xEX8eVoJh3
	 Ut6CO+/MC6Yow==
Date: Wed, 18 Feb 2026 10:05:41 +0000
From: Simon Horman <horms@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] eth: fbnic: Advertise supported XDP features.
Message-ID: <aZWO9RlTrPP2QPUB@horms.kernel.org>
References: <20260218030620.3329608-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218030620.3329608-1-dimitri.daskalakis1@gmail.com>

On Tue, Feb 17, 2026 at 07:06:20PM -0800, Dimitri Daskalakis wrote:
> Drivers are supposed to advertise the XDP features they support. This was
> missed while adding XDP support.
> 
> Before:
> $ ynl --family netdev --dump dev-get
> ...
>  {'ifindex': 3,
>   'xdp-features': set(),
>   'xdp-rx-metadata-features': set(),
>   'xsk-features': set()},
> ...
> 
> After:
> $ ynl --family netdev --dump dev-get
> ...
>  {'ifindex': 3,
>   'xdp-features': {'basic', 'rx-sg'},
>   'xdp-rx-metadata-features': set(),
>   'xsk-features': set()},
> ...
> 
> Fixes: 168deb7b31b2 ("eth: fbnic: Add support for XDP_TX action")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

