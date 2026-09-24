Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B93161A1;
	Thu, 24 Sep 2026 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212498; cv=none; b=QDkdSxq08/zJa2KWnFbPREQOKhtBltCDKH7d3+cUCiWkXpCTEv9Mnhx77RQpPV1lE+8hLtRKDURyy3IdS+JGByRpQo5gM0SrJZZEObZjQcXb/4b44Pgfw2IU8CzWf01uYtSzTMy26pNPrqiMUA5B2S82PVrI+Thuiy0se8WY9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212498; c=relaxed/simple;
	bh=XLVmGcM5xSylhqHzTElpGNFnnmPKphSJqBC0pk6KkKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWfUn6rgHQaNMSBcZjtFqQEWug8+MswtSobMt8hNvTkJxqSC5Yry2JvqeByylYdg2xUoF87lxyd7UKI/lKXS421cfHOeFTA+eO/n1abxQn6kxFxxKVd7aAx/1VCE3EYglwIdgZ63ZjEeuG25olsnAnfF8aCCkQehhjr0CKrzxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVE4CYfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVE4CYfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1D01F000FF;
	Thu, 24 Sep 2026 01:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790212497;
	bh=Z0kfeF4W9Sxc3U3MoefbjhOXCbbkuBqFeoIAphD1O+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LVE4CYfAAbfqvRoChA2LIbKI9quK1NCWxR3438kiREFYQTdFeKWwgtw+63Y2Sgex3
	 A2PWjZv5PGO8DoSBUD+qTO4wtf9lU8lEkRxaKNmUg44w0P6sTjYPoaI33CxOFw14en
	 wyc4jhNtBiEAt9MyudSBGqSgPY5dVDWJaldwf9wplOyHoxujuJRpDD9bsK0SJvW5Z+
	 3UCttp7TNUpjhK3OormZi5XFV/MkVdsW0JNOqecLhFofioxEvpQENjtb1+nolYpfCX
	 3R9GMipTH/eiRtB3loLuXjavVq8dKwXMWgKZ4bXK7ZV3xPEY78m1yM8nhe0Fsr2p1T
	 s4bWp04ozDmHg==
Date: Wed, 23 Sep 2026 18:14:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net-next v2 3/6] netlink: specs: rt-route: add lwtunnel
 encap sub-message support
Message-ID: <20260923181456.030d9cd6@kernel.org>
In-Reply-To: <20260920-ynl_rt_encap-v2-3-c664a3e726f6@kylinos.cn>
References: <20260920-ynl_rt_encap-v2-0-c664a3e726f6@kylinos.cn>
	<20260920-ynl_rt_encap-v2-3-c664a3e726f6@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 18:06:38 +0800 Hangbin Liu wrote:
> -CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
> +CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
> +	$(call get_hdr_inc,_LINUX_IOAM6_IPTUNNEL_H,ioam6_iptunnel.h) \
> +	$(call get_hdr_inc,_LINUX_MPLS_IPTUNNEL_H,mpls_iptunnel.h) \
> +	$(call get_hdr_inc,_LINUX_SEG6_IPTUNNEL_H,seg6_iptunnel.h) \
> +	$(call get_hdr_inc,_LINUX_RPL_IPTUNNEL_H,rpl_iptunnel.h) \
> +	$(call get_hdr_inc,_LINUX_SEG6_LOCAL_H,seg6_local.h) \
> +	$(call get_hdr_inc,_LWTUNNEL_H_,lwtunnel.h) \
> +	$(call get_hdr_inc,_LINUX_ILA_H,ila.h)

alphabetic sort, please

Please look at clashiko review on the web, it won't be emailed out due
toe kernel.org outage:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920-ynl_rt_encap-v2-5-c664a3e726f6@kylinos.cn
-- 
pw-bot: cr
