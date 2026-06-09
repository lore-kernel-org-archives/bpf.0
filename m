Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8953FB075
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003214; cv=none; b=kO0usiXvLxEAxvBpJC8Pg2nQ5pZ+juwIS5zcb9S9Mg53+f27L/DmVC/FDgS20P86ZkP1GixiVlzoIRruZbxY8gsrNtA8hd3eQBvhQZ3QytRleCMFQa20fCVJssOfNedKXTu673jfkNs8l7+a9rPPt+Qo3hI+Rd074sOLjhoAcRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003214; c=relaxed/simple;
	bh=eT/9Sn/sYsrL31GQDuHiuEQUw+7Tb4fr2oU7PuE0GnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3QbZKdYA0MZ6pIXhV6tFkh1RR8eplHvMqGTXaek7L2CUa/kw/M5xC7/vTlhi0+9+FJ8iqBj4VUSJnFVQpa+xT9DBnZyxstOxyp6/Il9lrkajjek5VZ8/49z8ZSof95isTR243A9BhWTxDmakXcd4dIBtY0eLFCut0+XRz51eqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ncykL8Qy; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ncykL8Qy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781003200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOFwe83SM6QIMCLbxJXV0qmGwf1qp7uMCkco1AkMiLA=;
	b=ncykL8QyKMmCpqapX6jRGNRoeYwfXLUa94vpzhXvxJdYLfWIGkVevVUp8Nx8omyNSYfTKh
	DQy8f756Oy0E+iFy92HQtvQMHypZTxhyYbXOr57ZjtD/yyA0WV9iUYro39sFHPOOjo932n
	DvhCSH3dUl1qH2nFsHE0skIi2xVsU2k=
From: Menglong Dong <menglong.dong@linux.dev>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 shuah@kernel.org, liuhangbin@gmail.com, Sun Jian <sun.jian.kdev@gmail.com>
Subject: Re: [PATCH] bpf: Unshare cloned skb before devmap egress XDP program
Date: Tue, 09 Jun 2026 19:06:20 +0800
Message-ID: <L0cwr1-KRSKR7-dJdjDmJA@linux.dev>
In-Reply-To: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
References: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/6/9 18:02 Sun Jian <sun.jian.kdev@gmail.com> write:
> dev_map_redirect_clone() uses skb_clone() when redirecting a generic XDP
> skb to multiple devmap destinations. The cloned skb can share packet data
> with other clones.
> 
> If the destination devmap entry has an egress XDP program, that program
> can modify packet data. Such modifications can then be observed by other
> clones sharing the same packet data.
> 
> This can be reproduced by strengthening xdp_veth_egress to configure a
> different source MAC for each egress device and checking that store_mac_1/2
> observe the MAC configured for their own egress devices. Without the fix,
> the SKB_MODE subtest observes store_mac_1 receiving the MAC configured for
> the next egress device.
> 
> Fix this by unsharing the cloned skb before running the devmap egress XDP
> program. Limit the extra copy to destinations with an attached egress
> program.

Hi, Jian.

This sounds like a good idea in this case. When I have a look at bpf_clone_redirect(),
I found that it use skb_clone() too, which means it has the same problem. The
data can be modified by other xdp prog in the destination NIC if we use
bpf_clone_redirect().

So maybe this is the default logic, and I'm not sure if this patch can break the
existing users :/

Thanks!
Menglong Dong

> 
> Tested with:
>   ./test_progs -t xdp_veth_egress
>   ./test_progs -t xdp_veth
>   ./test_progs -t xdp
[...]
>  
>  destroy_xdp_redirect_map:
> -- 
> 2.43.0
> 
> 
> 




