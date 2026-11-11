Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429454;
	b=fNEukRASf06Uvp+hpW8QB7uRGOSw4uf/qncCDbiOpFQfOvvW8VOxTIngSPpOEWn1TkS7
	 sXYu5stPD5iZW+K6UGsRx/ztaLgOAThzFgVCqr5Ei6InIvUBi9MMChnLs/UmFDFWIDmJo
	 RWoSrmeMS5BEXt+2hPkC9oEbw5lV677iO6PcPYLfCzvNHR1mIA6es9Zns/+pntN2a2Bn/
	 f3REUD5lgTOoLmW1bCGObtGItYYitl6mNU6y5ZbFH7V0soiQIVMxiOn+MnFQ7DZjTCMDK
	 CpZq/Nq67QS1V8pI6NIliLIVgHjJHW1EX4LhWr+C29hxEEBjd0+rKbkF6ffPbw3lAyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429454;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=vpIyzJPxRnrClrGT6opul0fGUGxCRQ7iTyzY6dXBUDc=;
	b=zxAmY3ZOMfYU7j0Ax/EivjCF0hX+8RUtcbG+wH6m+aEyWS2NagOvExHTwK40JM/QlbiN
	 d4k9swPVOucbFdqgW2pjXxfTesb5rYi1h/j+UXlzpdOMNWGuioJ114vOpcYEhaB4xXLQA
	 /KaaCFpGUy+wa3AWyHm7xRzJ7xxNCSpceadgWaGcbgq1JDTuu3OSMlYgjKRYrDbQ0fDcr
	 jFoWe/0ygw3bHHRQUngGjJUDTskzuOK7B1f8eyAW9vl4qT3wmPKbO3xLSfalMHpBIsCx7
	 F8AsPnpzL7BtiwnuPjyZbJmA9xx8x7E9innHGZFu4PHYnF0QQ7anhMJR6HFhZNac6uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=YYK+ZnQk;
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD6606A89F;
	Wed, 11 Nov 2026 20:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDDD6606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=YYK+ZnQk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794429454; x=1825965454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vpIyzJPxRnrClrGT6opul0fGUGxCRQ7iTyzY6dXBUDc=;
  b=YYK+ZnQkBuda9ap87dQ89X265NEdYSbOfrslXe+vr4TgOAvKtLF2YWFh
   pA6hFgDHWeVo72/2XUwFeictRpNtmLjDn9VcZa21pMPhbpsa35xOVGjcn
   iBoVHonTPHh1awrKgicakSWwvsLqHmMXsVSWx8k0FqVG4jxycVkNFZXJU
   2j/1u4z4/4B+/qit6fiDCVZxcGZkJGwJ/qLm+UWENRaH84I7jjF8WbzrP
   x39J6naVHcWAk75aPjEfG7wr8T0GgyftPcU3su3CL3ywyKh7kGzWWn77Y
   RdJKCu0+40Th3c6s2ixzkwC9BaOB3MLNZsQkEU7JpSvjT5yXs8SD9M/by
   A==;
X-CSE-ConnectionGUID: tiE9b2HlQrqB/PDjzj+nRw==
X-CSE-MsgGUID: GGJF9NIVRMGQ5ByMC+l/mA==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33526248"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:37:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:13310]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.127:2525] with esmtp (Farcaster)
 id 389de7d3-cdac-4a03-93bb-a296349c3841; Wed, 11 Nov 2026 20:37:30 +0000 (UTC)
X-Farcaster-Flow-ID: 389de7d3-cdac-4a03-93bb-a296349c3841
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 20:37:30 +0000
Received: from dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com
 (172.19.55.127) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Wed, 11 Nov 2026
 20:37:29 +0000
Date: Wed, 11 Nov 2026 20:37:24 +0000
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
Message-ID: <avTSBFpR2t7PO9tx@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
 <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
 <willemdebruijn.kernel.1d64e7848503b@gmail.com>
 <20261107182526.69543-1-tianyi@cloudflare.com>
 <willemdebruijn.kernel.2c6a653eb65fa@gmail.com>
 <20261108190831.3f991a13@phoenix.local>
 <20261109154909.32748-1-tianyi@cloudflare.com>
 <avTOvr+yy+2j8xrQ@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
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
In-Reply-To: <avTOvr+yy+2j8xrQ@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, Nov 11, 2026 at 08:23:26PM +0000, David Keogh wrote:
> Dropping IFLA_TX_EXTRA_HEADROOM is fine with me. A BPF-side
> declaration covers the TC egress case, as long as the program is
> attached to the device the skb is allocated for.

One correction to that, after checking how our hosts run the program.

Our TC egress programs are not attached individually. A loader keeps
a chain: only the head is attached to the NIC, and the rest, including
the program that encapsulates, are reached by bpf_tail_call through a
prog array. The head can change as programs are added and removed.

So if the kernel reads the declaration when a program is attached, it
never sees the encapsulating program, because that program is only
ever inserted into the prog array. Putting the declaration on the head
instead does not help either: the head is a different program that
pushes no headers itself, and it can change.

For the BPF-side declaration to cover the TC egress case, it needs to
account for tail call targets. Tianyi, how were you planning to handle
a program that is only reached by tail call?

Thanks,
David
