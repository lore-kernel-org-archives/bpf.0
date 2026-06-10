Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA130242D9D
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054510; cv=none; b=s8JSHAWVWc0hhLRsiQGuXmaVMYEMTIVewRvONRlNMtgou1flHlPQ6geNWIXrjggetyzZ5bcu2m00yTEd1D/e/5wPiFHkB26T+Jz59QfRTHmfgfbi+E+I1dUSqe+finD321GQozUjbxH+ahyRw89CS7fBvQb5LdNs7JvEN3qFUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054510; c=relaxed/simple;
	bh=RvIol9gM/1py5Hk7h4bLp0YoIkMSmUzyYPhAbZ4stdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsiWJg4UaHlQvtJz/ud6+uGF2cIHq3YcEni0/D2bgBqQkKNhn+iVTyf425i+ziY04Cbc0YbbMmBmf4dkuEGEiA3eFnl/i7WJU3mycbigBgud5jSM19hib/VD1PoGtOkEAcBVmShEU0oNSc07o5Z52GC9UmdhtesM8unaws5Iorg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bxpB40Vv; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bxpB40Vv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781054496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbRzG6Pa36uez5VKdsIv2ql0J1GpmIHCqFTPixbR7/o=;
	b=bxpB40Vvc0ffLgfxsdSmHEVmfGQoqhtPRbWF8R6I+AuIYCZJGyL0xye2AExJHV1Illbc1D
	uM3OlhIi9wkbKa/S2XQc7lN3WqvWYoymrvt3l2eQ0vrRL42Wd7mwYh0JPnRjG8S+1UtCPG
	37kMelikDsIFVMspvuA4BOtMrAHttVg=
From: Menglong Dong <menglong.dong@linux.dev>
To: Sun Jian <sun.jian.kdev@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 shuah@kernel.org, liuhangbin@gmail.com
Subject: Re: [PATCH] bpf: Unshare cloned skb before devmap egress XDP program
Date: Wed, 10 Jun 2026 09:21:25 +0800
Message-ID: <AgOg1pJHQN-gpKhYUz3SMw@linux.dev>
In-Reply-To: <DJ4XIOT2RVMT.28I5LA2UOZVUI@etsalapatis.com>
References:
 <20260609100214.337538-1-sun.jian.kdev@gmail.com>
 <L0cwr1-KRSKR7-dJdjDmJA@linux.dev>
 <DJ4XIOT2RVMT.28I5LA2UOZVUI@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/6/10 08:06 Emil Tsalapatis <emil@etsalapatis.com> write:
> On Tue Jun 9, 2026 at 7:06 AM EDT, Menglong Dong wrote:
> > On 2026/6/9 18:02 Sun Jian <sun.jian.kdev@gmail.com> write:
> >> dev_map_redirect_clone() uses skb_clone() when redirecting a generic XDP
> >> skb to multiple devmap destinations. The cloned skb can share packet data
> >> with other clones.
> >> 
> >> If the destination devmap entry has an egress XDP program, that program
> >> can modify packet data. Such modifications can then be observed by other
> >> clones sharing the same packet data.
> >> 
> >> This can be reproduced by strengthening xdp_veth_egress to configure a
> >> different source MAC for each egress device and checking that store_mac_1/2
> >> observe the MAC configured for their own egress devices. Without the fix,
> >> the SKB_MODE subtest observes store_mac_1 receiving the MAC configured for
> >> the next egress device.
> >> 
> >> Fix this by unsharing the cloned skb before running the devmap egress XDP
> >> program. Limit the extra copy to destinations with an attached egress
> >> program.
> >
> > Hi, Jian.
> >
> > This sounds like a good idea in this case. When I have a look at bpf_clone_redirect(),
> > I found that it use skb_clone() too, which means it has the same problem. The
> > data can be modified by other xdp prog in the destination NIC if we use
> > bpf_clone_redirect().
> >
> > So maybe this is the default logic, and I'm not sure if this patch can break the
> > existing users :/
> 
> I think for use cases where we are using bpf_clone_redirect() to use
> one clone for inspection this would add an unnecessary copy. Maybe
> adding *_copy() variants instead of changing the *_clone() would be
> better? That way we wouldn't be changing the behavior for existing
> consumers and the naming would be consistent with the skb_* methods.

Agree. It's not a good idea to change the logic of the existing API. Or
maybe we can add a BPF_F_CLONE flag for the existing API.

> 
> But more importantly, is there an actual use case for the kind of API
> that the modified selftest requires? Nobody until now has considered
> the existing behavior to be a problem.

Agree too. Obviously, this is not a bug. For the use case in the commit
log, it's something that can be fixed by the user themself. If we need
modify the MAC, we'd better attach a BPF program for all the egress
device in the devmap.

> 
> >
> > Thanks!
> > Menglong Dong
> >
> >> 
> >> Tested with:
> >>   ./test_progs -t xdp_veth_egress
> >>   ./test_progs -t xdp_veth
> >>   ./test_progs -t xdp
> > [...]
> >>  
> >>  destroy_xdp_redirect_map:
> >> -- 
> >> 2.43.0
> >> 
> >> 
> >> 
> 




