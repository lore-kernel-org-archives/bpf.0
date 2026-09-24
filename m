Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97D430E0D5;
	Thu, 24 Sep 2026 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265205; cv=none; b=p7LYpHzj822B6IafaWpplowLCHDuDFghtkbB15dCKuMTZdIb8b73xwFYzKnKy2+CHUM9Y1ANZHcVzUrOo+AI+IAtTWIQMnBtQLzAV1WqAg2QZ7rM1WdggpPq7aBuhsupj55cHEzIGVYTZOJiQ6d2H2BIaJpPiA7TBqvrk65alwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265205; c=relaxed/simple;
	bh=o8T5fhc4PASIpizhXYJf5s9l1q4Ab5cRRzkL7TVBphE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/kZNbZrpM+rNKjCwPoGzqre4XLHiuH45VB5/5cXfvswPcSeUYRrtDeiKTBut987wGdldW5Ho2mKfAUMvz9dTl3Ka3xblsHowqNFbxlj3q9OZG0VOOLYFKZiMVIPhuFieL37NC6TiYfFYdLLCSGU+FQcSz1nLsz87LXbujlccR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ1XTfIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ1XTfIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E43A1F000FF;
	Thu, 24 Sep 2026 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265203;
	bh=klw6x4dPEqWqUc/AU47L7f37XBvvcheV+LgjTD5qxKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FZ1XTfIefvFMarg0SU/pXCVl52RFPSNGsaY9zN7u8MT3SapghWaSsl5ofqD+kO29X
	 +eAmIcEn9vvciDOb+ieE/A1nf00REYE+B0SYsSO6+CKzH1qpqERCsWLmbyQz7SR6hZ
	 pg3CouusEb2eg312+TSOccDjOP4gwUuv5Ep2qW1hUFn4Gz00YXsFz6VhkbzL1yOjNC
	 nvU0daX9Ff5D8pclgOyDZZos0kfC7FJ40alxv9swA1gu0jie1Xw7xy83HbENMaCssV
	 vJznvZj9VH6XJUvvFo5wdQQ7mITzFsAqocUYOWIHcpqIMyHDyiOTOYrbRwWn6dBpfF
	 5beYA5nuX3zAQ==
Date: Thu, 24 Sep 2026 08:53:22 -0700
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
Message-ID: <20260924085322.2d1478bb@kernel.org>
In-Reply-To: <arSVWN91NDnz_tfF@fedora>
References: <20260920-ynl_rt_encap-v2-0-c664a3e726f6@kylinos.cn>
	<20260920-ynl_rt_encap-v2-3-c664a3e726f6@kylinos.cn>
	<20260923181456.030d9cd6@kernel.org>
	<arSVWN91NDnz_tfF@fedora>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 11:13:28 +0800 Hangbin Liu wrote:
> On Wed, Sep 23, 2026 at 06:14:56PM -0700, Jakub Kicinski wrote:
> > On Sun, 20 Sep 2026 18:06:38 +0800 Hangbin Liu wrote:  
> > > -CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
> > > +CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
> > > +	$(call get_hdr_inc,_LINUX_IOAM6_IPTUNNEL_H,ioam6_iptunnel.h) \
> > > +	$(call get_hdr_inc,_LINUX_MPLS_IPTUNNEL_H,mpls_iptunnel.h) \
> > > +	$(call get_hdr_inc,_LINUX_SEG6_IPTUNNEL_H,seg6_iptunnel.h) \
> > > +	$(call get_hdr_inc,_LINUX_RPL_IPTUNNEL_H,rpl_iptunnel.h) \
> > > +	$(call get_hdr_inc,_LINUX_SEG6_LOCAL_H,seg6_local.h) \
> > > +	$(call get_hdr_inc,_LWTUNNEL_H_,lwtunnel.h) \
> > > +	$(call get_hdr_inc,_LINUX_ILA_H,ila.h)  
> > 
> > alphabetic sort, please  
> 
> OK. Just to make sure, when sort the order, we don't touch the first
> rtnetlink.h, right?


Why not, you have to modify that line anyway to add the \
