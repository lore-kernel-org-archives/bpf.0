Received: from mta0.migadu.com (out-73.mta0.migadu.com [91.218.175.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF03DA7C8
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219620; cv=none; b=eX3YPVszcGZqcfGfmc9E8c+/7kJeGt0TK51fu/iu5KTC2CO/nJC81kEAmgsWqVgW9C/MkIJxppPJMUldNTA0QD2cAqaOR16CiCPuLacU/VO5wnNq5m+sUvcisEbDLRWYW/Lxci9zGN+19ucRKZOvE2mnfyYfwoh/fHFkeh6ypyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219620; c=relaxed/simple;
	bh=GytJiuhgyjzjxHhot3wBWyf+fQkUNl3L1F4n3qrJGIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmcDjoY9i14K2a6YSokQ6iALArEXdt6+Zt5xuYsS2WQRPUWFrUMmfx7IIG77wse8cRDrWt9PauQK5KCmJbRzCtwW5DbYTD/qQOUccnZHLFyxK7KMOmvigfP2883ealLB+N8J8MBKYQBclps3QWxbagB7MsiqHR5S88m8GiTw5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l1Wz/g3V; arc=none smtp.client-ip=91.218.175.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l1Wz/g3V"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GytJiuhgyjzjxHhot3wBWyf+fQkUNl3L1F4n3qrJGIs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790219616; v=1; x=1790824416;
 b=l1Wz/g3V0kEpljrLfjVvT6C8o5lW+2iVd1w7z9pTdXdqhgpSAfhbV1pj1dHKTBvk/AgXlGGz
 HqXGTCiWvHXmOcLzNMb2CIt/qAKqLd0JWFw5DImqyOJ+SMUYQVHFRSfYR6QnlMwAfJQWWfeONO1
 q7xeisucwJFscKqE2lk5ax+g=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 584c09d60378d531;
	Thu, 24 Sep 2026 03:13:36 +0000
X-Mizu-Trace-ID: 584c09d60378d531
X-Migadu-Flow: FLOW_OUT
Date: Thu, 24 Sep 2026 11:13:28 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net-next v2 3/6] netlink: specs: rt-route: add lwtunnel
 encap sub-message support
Message-ID: <arSVWN91NDnz_tfF@fedora>
References: <20260920-ynl_rt_encap-v2-0-c664a3e726f6@kylinos.cn>
 <20260920-ynl_rt_encap-v2-3-c664a3e726f6@kylinos.cn>
 <20260923181456.030d9cd6@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923181456.030d9cd6@kernel.org>

Hi Jakub,
On Wed, Sep 23, 2026 at 06:14:56PM -0700, Jakub Kicinski wrote:
> On Sun, 20 Sep 2026 18:06:38 +0800 Hangbin Liu wrote:
> > -CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
> > +CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
> > +	$(call get_hdr_inc,_LINUX_IOAM6_IPTUNNEL_H,ioam6_iptunnel.h) \
> > +	$(call get_hdr_inc,_LINUX_MPLS_IPTUNNEL_H,mpls_iptunnel.h) \
> > +	$(call get_hdr_inc,_LINUX_SEG6_IPTUNNEL_H,seg6_iptunnel.h) \
> > +	$(call get_hdr_inc,_LINUX_RPL_IPTUNNEL_H,rpl_iptunnel.h) \
> > +	$(call get_hdr_inc,_LINUX_SEG6_LOCAL_H,seg6_local.h) \
> > +	$(call get_hdr_inc,_LWTUNNEL_H_,lwtunnel.h) \
> > +	$(call get_hdr_inc,_LINUX_ILA_H,ila.h)
> 
> alphabetic sort, please

OK. Just to make sure, when sort the order, we don't touch the first
rtnetlink.h, right?

> 
> Please look at clashiko review on the web, it won't be emailed out due
> toe kernel.org outage:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920-ynl_rt_encap-v2-5-c664a3e726f6@kylinos.cn

Thanks, I will review the feed back and fix the issues.

Hangbin
