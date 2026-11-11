Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.42.203.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428616;
	b=HQmeDhnrcncKWqxHbJXL4s/MIh7U6EGwQk/2GjIyCXXNlBXINMjQPOScHinj18yLh6Yn
	 QUnuNijxH60X23BV9aNDaggixl/tuma8Gb1+f7TItiuNJ99frsIcOKpqNN8dJhYmuvOeS
	 0l0ApJDruFp11+SK75EGqZ6jY/MEJJwPLcOg5QgRmgKHhAPVr1zREBMXMVdAfQu31JHjX
	 whMxniU+GdZynd4NPYCStkBtlb1IbrEqzNBVllHLrz6ZrruvaFU5HIdkToJz+/PUAkn5z
	 Qzv5y0loM7wp/6bc2TLcQozUcGzdzZDsYmqgAXwA8Jz8iXI0g1/PlqM3cCfC98lQM5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428616;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=jkJcn8ydDxvyf3lWLXA7GpBEZpUwB/Y6PIOpFmvjCRU=;
	b=bf2G8JS248pX1tbrUqKkZ4JlsPUS1kyRKnOWLdpaoQgO/MRTVlsewXaLHJL9YZd9KPLX
	 vyirsKZBPQMVRnQ8X/eMotPFyqQe+cai8r5xNV/DLhua1te5nBvfQ71++KEFtMe2rakO6
	 B05L1CBPprTKZngToZn9Te+CZwqvz6GWktk7ZSzxAssJBSLsjLmyVavWzrdFX3ar9Z+sT
	 bwsusJWveg7iFBLaWHtSa43H9ZL8H8/FXoEIJH8mI7g7agGyasIn145teNQT82XkTicTK
	 RF3lWo67IzjIoiKbMMBu+Kr/zme92Nyw9JmcSc4NN+YuiHEj+N2gRoO1cvGTx14Vnkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=iMEZvZ9b;
	arc=none smtp.remote-ip=52.42.203.116
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A91606A31C;
	Wed, 11 Nov 2026 20:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32A91606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=iMEZvZ9b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794428616; x=1825964616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jkJcn8ydDxvyf3lWLXA7GpBEZpUwB/Y6PIOpFmvjCRU=;
  b=iMEZvZ9bKPvYu+lyl63NXczZgb9k00IMn6p/B41NF+YSge2JQ78uaWaI
   3TEwozp7ebCyFqGQJC10YwNyJFTpBT4U3fmu4ddRB2SEvIbFbSVXuqLiW
   JVhDNg6z2jRzcs0ngJJjtAW8tcy7wgkxhx1R6E8fIvRf2wdkkR6tp1Wxf
   D2y5arB9O0zx/GF7R/bGfS/yLIOi5HAWKqBDCS8EZkk/T761sHCwXsd4H
   Gt61dIFcjAFO4DSHsohJvTEKUFf7MHOm1ElAmU8Gbqug0jZ+YyNxqytYv
   OQ5eO/IOET+up0Oduz50oSqV8UXFOpL9cLD7O9EVeN3k0XujH1PLjG10w
   A==;
X-CSE-ConnectionGUID: Qyyc6pHYShOrjNU/eJizYg==
X-CSE-MsgGUID: Fcia4Cx0S3GdQP0ncOIkSw==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33786501"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:23:33 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:12262]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id 16ece643-915b-4807-8d1b-662b366d2515; Wed, 11 Nov 2026 20:23:33 +0000 (UTC)
X-Farcaster-Flow-ID: 16ece643-915b-4807-8d1b-662b366d2515
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 20:23:32 +0000
Received: from dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com
 (172.19.55.127) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Wed, 11 Nov 2026
 20:23:32 +0000
Date: Wed, 11 Nov 2026 20:23:26 +0000
From: David Keogh <dkeogh@amazon.com>
To: Tianyi Gao <tianyi@cloudflare.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, Simon Horman
	<horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, David Woodhouse <dwmw2@infradead.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Alasdair McWilliam
	<alasdair@mcwilliam.dev>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Magnus Karlsson
	<magnus.karlsson@intel.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>, Breno Leitao <leitao@debian.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>, "Danielle
 Ratson" <danieller@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	<bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kernel-team@cloudflare.com>,
	<nh-open-source@amazon.com>
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and
 LL_ALLOC_SPACE()
Message-ID: <avTOvr+yy+2j8xrQ@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
 <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
 <willemdebruijn.kernel.1d64e7848503b@gmail.com>
 <20261107182526.69543-1-tianyi@cloudflare.com>
 <willemdebruijn.kernel.2c6a653eb65fa@gmail.com>
 <20261108190831.3f991a13@phoenix.local>
 <20261109154909.32748-1-tianyi@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261109154909.32748-1-tianyi@cloudflare.com>
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, Nov 09, 2026 at 03:49:09PM +0000, Tianyi Gao wrote:
> To David Keogh: this plan drops the generic device attribute UAPI that
> your RFC proposed. Your TC egress use case stays in v2, with a BPF-side
> declaration instead of the device attribute. Before I proceed, please
> let me know if you are unhappy with this plan.

Sorry for the slow reply. I am happy with the plan, please go ahead.

Dropping IFLA_TX_EXTRA_HEADROOM is fine with me. A BPF-side
declaration covers the TC egress case, as long as the program is
attached to the device the skb is allocated for.

I will rework the TCP test so it sets the value through one of the new
paths, and send it as a reply to v2.

Thanks,
David
