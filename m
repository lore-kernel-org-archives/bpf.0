Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055EE2F2607;
	Tue, 19 May 2026 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779233214; cv=none; b=HfsJ7/eAf47PyFzqhyJu/tQaCPnsl6PXK6EJc2JRTAirK5tmHOoxg6fRGdjeyryI52x155mrsQvplm/9d3feKbMjFoLZRc8bsHZJNt6GknndO3+xthZFW8aU1MhnEX+dCzId9YP/oS2xVQ4TAP70ktiTn2zxWXs1k2miwodO1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779233214; c=relaxed/simple;
	bh=I0hsHaMtnPi/bAvwUJpJzf8T7fh6Jopm/e+Iidj6xAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uESbWuy1IB1uz0fmx5L4tlvgoL62FMTZz31FJ7pb1mTyk2icl//3QrFirto2AozLabVec67b7BRHeJigjqo3OoM3EFE23O0HQlcmNyUu+uGU4MXdvj//r03/rG/p/k+vYrFs/SQeORLExaaeK3VEVUV/eOFIYFRdcwG2ec7GeaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AczC3q4j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AczC3q4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8941F000E9;
	Tue, 19 May 2026 23:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779233212;
	bh=HYjnBPBPS67l+j1tn04D+J2nO0RoeF3lUjicMmnNUls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AczC3q4jZdt2BLmc4SNIdD+4Zpdtb1nIO5fXG+JHOhccAzw4DacDluBOUT0X2wFRv
	 QpSA9qH3KSdJf/wG/xc7oasCymqdfFY7w0Ymfs7K9NHeu0AnExwHr93KNB9aoDF85g
	 8Q6Ec1Dhbl0rQzr0yUjUd0Ai/AdkFS0b8vtKNbcOHUaqNO7c32Sw684h2RrZJFoAG8
	 WSS0alaZNxQ3anxJdbbEm7lx+rQnlBh961bajcQcaaIEmmIRepXJthzntqwvpbq9cq
	 EyVEYGDd1y8fqZi/ria9kKFs2eJfjDwmGrN+z2Ruje0uU0dmlKV4RKjQG0T1gIWC/T
	 KDU8Yn+OvS1xg==
Date: Tue, 19 May 2026 16:26:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Amery Hung <ameryhung@gmail.com>, Martin KaFai
 Lau <martin.lau@kernel.org>, Dimitri Daskalakis
 <dimitri.daskalakis1@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net] selftests: net: Fix checksums in xdp_native
Message-ID: <20260519162651.765cd587@kernel.org>
In-Reply-To: <364bb4db-2a45-4b01-b2bc-1f6fdff937ad@nvidia.com>
References: <20260513072355.1083381-1-noren@nvidia.com>
	<20260514183832.5ef205c1@kernel.org>
	<aa818076-6e5a-4b61-bc7f-0bfe3907fe2f@nvidia.com>
	<20260518143138.74839bf9@kernel.org>
	<364bb4db-2a45-4b01-b2bc-1f6fdff937ad@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 10:04:03 +0300 Nimrod Oren wrote:
> On 19/05/2026 0:31, Jakub Kicinski wrote:
> > This patch needs a respin for the issues Sashiko pointed out, to be 
> > clear.  
> Replied to Sashiko earlier (my reply went to sashiko-reviews and bpf
> but not netdev - oops).

Yeah, it's a bit buggy in how it collects the CCs.

> All issues are pre-existing and harmless, so I don't think they should
> be addressed in a net fix.

Please fix the csum thing.
