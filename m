Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439186;
	b=vLGjlsN/yLi056IQmFF67Q1GnPEawuOMDFfL8q+IIFpK23m97j7JBqeg1L6p5KGHjqXc
	 +m18KzkXGKMgeO1IBuS1cYaboCh30jQMNtFjSrJWjeLGuixOk8DbfkdVbwXIjYWXsnQhy
	 f1n7DdzytwFxU2ndjT5yfiNP95fyyBdJUX7uzNPaFD99R0DKMeVdfUNumpYlFjJiCNPSb
	 ri1K5YmfkacUOoLZwE8eFjhlclAyZ5pDUUocXqgyJQkcIEiZM5Tv0xvptbYbTRb2EFwPD
	 xGJsOjdyXnuRBkOEVr5k1ZurAvXIgvRHmI9Ww6R4lL21pmv4gmSNTT+ieuru3/pZtCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439186;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=NcCiWMGAG/KcYeA/c2y5e8aTtWFVROWmHzpV73vYmEA=;
	b=hTGs8bVIMzN6bSdj87VOox4hFZzMQizjz0Qz/iVjWAJjiuCXy3EgG1kqG+ycGRWv3HeJ
	 2ziAl3kbBIKcV02QNvnZgRbuHAlgQ+EuCq0jwohVnEZCpAX5MZo6XR9jllQviU4SJHl4I
	 087c5A27oznG5sUU0330O1btT/kK6L0OT21IyMRBwiJtep7/DeDkdeHBZj1abuqJF+QXR
	 H+3WwVdM9ZKQBHdYbV3e7v8z6Z1Bvncdw7THlR+aaJPfOoDZwKXlHMmONfGs4UwVf3rit
	 hs4YgDB74joX9a3suM6tv6fp32DrmfTfcHUujHW0rKZ73mXGBvtZF0Gu/jHoPAg1PHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=IGyO4tUN;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F326F606A321;
	Wed, 11 Nov 2026 23:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F326F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=IGyO4tUN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794439185; x=1825975185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NcCiWMGAG/KcYeA/c2y5e8aTtWFVROWmHzpV73vYmEA=;
  b=IGyO4tUNNamfqJNlGdZY459Ybc1udO70iDVM97rAWz+fhCa2UMfU8x+T
   rFs4bcLhNIRn6IyQSsFO7y3wvH23hhA7+T6fEBAu9u6Q4QRN4yjmr85b4
   NBxxgYv1iy3ouAu+m4FGC5oxqNkYq41ebvT1MjyMHse5qABRv+f3RbLal
   Qg9QVD6TYgFUle/oaKmzCi7OL0Qtqr5Y9tZYjXwn5B2fcrnVn6C6r4h86
   6fbXD5Xi8SeA/PcKniFYePT7LujIIBDF1sJ5DmWOkVR9Okn9uWdowFL8I
   cx8UgnDrBUkJrYaPvo9pK7OpwovPFQwCTsl+l0uaxmpFzwKzWWniS9Xmy
   g==;
X-CSE-ConnectionGUID: 6zDr3jFwQyKdSmvl3eZr3Q==
X-CSE-MsgGUID: SFQQkNPQRoqkURot+YmiOw==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33275423"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:19:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:7426]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.141:2525] with esmtp (Farcaster)
 id 976397fa-12de-4c16-a3e5-30f8dd11ed40; Wed, 11 Nov 2026 23:19:43 +0000 (UTC)
X-Farcaster-Flow-ID: 976397fa-12de-4c16-a3e5-30f8dd11ed40
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:19:42 +0000
Received: from dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com
 (172.19.55.127) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Wed, 11 Nov 2026
 23:19:42 +0000
Date: Wed, 11 Nov 2026 23:19:37 +0000
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
Message-ID: <avT4CezZCiRhvCXw@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
 <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
 <willemdebruijn.kernel.1d64e7848503b@gmail.com>
 <20261107182526.69543-1-tianyi@cloudflare.com>
 <willemdebruijn.kernel.2c6a653eb65fa@gmail.com>
 <20261108190831.3f991a13@phoenix.local>
 <20261109154909.32748-1-tianyi@cloudflare.com>
 <avTOvr+yy+2j8xrQ@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
 <avTSBFpR2t7PO9tx@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
 <CAG4wq-d+LtEi-omGwzgqx14rCp_4J9HztGMpa8ioMsviaPw+ZQ@mail.gmail.com>
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
In-Reply-To: <CAG4wq-d+LtEi-omGwzgqx14rCp_4J9HztGMpa8ioMsviaPw+ZQ@mail.gmail.com>
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, Nov 11, 2026 at 09:41:32PM +0000, Tianyi Gao wrote:
> My current plan is that the kernel reads the tag only from the program
> that is attached with tcx. One way to use it is for the loader to tag
> the head with the largest headroom that any program in the chain can
> push. The tag describes the whole chain, so it does not matter that
> the head pushes no headers itself. When the loader replaces the head,
> the new head carries the tag and the kernel reads it again.

Thanks, that works for us.

> By the way, I plan to support tcx only in this series. A tcx program
> is attached to one device, so the kernel knows which device to update
> on attach. A cls_bpf filter can sit in a tc block that is shared by
> several devices, which is harder to handle.

tcx only is fine with us. Our chain is attached with cls_bpf today.
Rather than move it, the simplest option for us is a separate tcx
program on each device that carries only the tag and returns
TCX_NEXT, so the existing tc chain still runs after it. A few
questions so we can check that this works with v2:

1. Is the tag read for programs attached with BPF_PROG_ATTACH as well
   as with BPF_LINK_CREATE? "bpftool net attach tcx_egress" uses
   BPF_PROG_ATTACH, so a startup script could do the whole setup
   without keeping a link pinned.

2. When several programs are attached at the same tcx hook, is the
   value the largest tag among them, and is it recomputed when one of
   them is detached or replaced?

3. What is the exact form of the tag: which BTF element it must be
   attached to, and the string format? It would help to have that
   documented, since programs will depend on it.

4. Is there an upper bound on the value, and is a larger value
   rejected at attach time with an error, or clamped?

Thanks,
David
