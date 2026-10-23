Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792718688;
	b=Gzqy+zxjSO2mezMLphWuP3ngk4nK6PFUWJr2QLencsAGWjyF062P9UEMLxiiIfwgPDb2
	 4HxCvo0FSDyV3XvI9+cewbk84bV9JdHGUyCHqJMnlT1ZtMlA5H5eQmnbHo5FFR/szdHAZ
	 zHml4nfhXdOEL8AUDLR6eZlKUKndVZ6wI6kC1cyAun7DaNa/WiJJJZUafES7ARN7pn1jn
	 0kutKgI5XABkANWNoVWFd5yGGn/LtvPVbtXbn3ZE5NG25TvpDqERE+DtCJVpbUEZg1kIQ
	 oGWj2gEIZ8LWCP6aqcFh6Amln9lXKiY+pvHVq7Z1C6Jxh1rg7gYsru/Vk/gWp+gR4Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792718688;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QfwiiMEIJLM6wtWCzdveJsVg3jUOpd7xifwJvw6jT6c=;
	b=OPklP/18XdlscOgHI7ALnCxXAE1hMCCHh++ZLm5CldnQcnQGBOIdf6/1cdxOfTbdzsE8
	 MFFqsUkfzmtv5Ko9A37m9xdjVGQYJMPlmBcEfxk/pL4BNrsn3Q43z1cbXNGoiDR8ZF+W8
	 Xuw7WYkFiSgdylKx+x4hQ+nFL/Yc9O6M64PqigviZ12pwNzU6FfyMh+/GfuwPh6pAN6iN
	 mgsUunm+CaYwAGzca+O3qsS22Ul5UGNwVFoYCXRpIBlMVt3iz/3o4pULd0YWcJCfOoPMp
	 fUyEd+qPzE7J5utML2SO9vczQuG8ndFNNHBbrQY295uSzDo5yLGdzL99fHTFsZE2MUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQSpi8UE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC6606A319;
	Fri, 23 Oct 2026 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQSpi8UE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAE81F01825;
	Fri, 23 Oct 2026 01:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792718687;
	bh=QfwiiMEIJLM6wtWCzdveJsVg3jUOpd7xifwJvw6jT6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZQSpi8UEwcsqoxxHVT+yb48q4b9dZZ0j0njxnfkUMKcSvlhmo6JNd3ndN19Ubbu/C
	 fscbYwACtSeoXhplh0vPRdE7V+SZ8SBzp+mJlj5EvY7BbUawZjZWTNzH3ssQ3qaO+t
	 0b4JoQoW80ib2f3Bs/NMT3ASfa8N+uqSf1J+yJK5O8I6eafnocI8k4McDiLi5E2a2j
	 uloHDf+uXhuepSzQ6uNKaIj7kVTZFGFa/5nOAS9ke5JzlrwDttY9KcQmrF6RkCAEFE
	 EAXScGwIJnyjEOBnfVgw6MFNws2W9QtG1+SEOeersyFXmQTcZX3UlfYmkcxoIDr+HE
	 JukHHoNpAsOIA==
Date: Thu, 22 Oct 2026 18:24:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
 <tushar.vyavahare@intel.com>, <kerneljasonxing@gmail.com>,
 <bjorn@kernel.org>
Subject: Re: [PATCH v4 net-next 09/15] selftests: xsk: run one test case per
 xskxceiver invocation
Message-ID: <20261022182446.64516c7f@kernel.org>
In-Reply-To: <atovTlRGERDYjB4q@boxer>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
	<20261016174338.787135-10-maciej.fijalkowski@intel.com>
	<20261021150145.65a22a61@kernel.org>
	<atovTlRGERDYjB4q@boxer>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 17:44:14 +0200 Maciej Fijalkowski wrote:
> > Really not loving the amount of "library" code added here.
> > Do you need this just to run it over veth in net/ and over
> > real HW in drivers/net/ ? Are the test cases very different?  
> 
> Now that you bring this up, would be good to clarify expectations of this
> work. The lib input is what veth and hw runners share to avoid code
> repetition. The separation comes from a fact that we still want to cover
> SKB and DRV modes (via veth at net/test_xsk.py) and ZC mode is covered by
> drivers/net/hw/xsk.py.
> 
> My assumption was that would not hurt much to carry common code within lib
> file. I might have been wrong tho.

We should try to avoid pushing things into lib whenever possible.

> > I wonder if we could solve this by parameterizing the env
> > class to use veth instead of netdevsim and then have unified tests?  
> 
> Tell me more regarding the unified tests. Is that okay'ish to run
> veth-based tests from drivers/net/hw ? I thought it was not and I shared
> my insights on similar work which does the same kind of migration
> (xdp_features bpf->drivers/net/hw) and it seemed to be heavily veth
> dedicated - the bpf sh runner was basically veth based, but so does the
> xskxceiver and I moved away from this after Bjorn's input (turned out to
> be a good thing).

The other way around. We can add mixed HW and non-HW tests in
drivers/net When run against non-HW we need to be careful to XFail
instead of failing or Skipping, so that SW CI "is green".

> each runner can have single ksft_run() call, right? So, do you think
> separate files for veth and hw runners is still okay?

SW and HW testing are done by separate executors. We'd have some
trouble (read: we'd need extra wrapping) if we we needed multiple 
envs for SW testing, but SW vs HW is easy. Executor will either
run with no env exports and get the SW test, or it will be exporting
$NETIF etc and test will run against $NETIF.

> In veth runner I don't even instantiate NetDrvEpEnv as I have veth pair
> being created 'manually', however having a param similar to existing
> netdevsim one would be nice and xdp-features set could benefit from that
> as well. 

Yup!
