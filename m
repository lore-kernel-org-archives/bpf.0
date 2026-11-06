Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991651;
	b=iD8Cr1LghzOlLEVm9yFdRfr0U2+1KWgg68VEc1IO9WCjf2gjvjbeR9gauzmvCx4sg9yO
	 YWe2FVDBTSoxsk/hY57Z5qRopWGPAtHkkKvWzmVWR6J1gUD77AB8wPHEGEnK3rI6SI7BO
	 NxOvNGrmYIHnZhZO5EFVi0cQSX0c4uAvybDPpB/aKNywepLPhOLf30Fa7lxHIBB1HJ3kq
	 SuUz/lmm53IdnUCoBwYONZoyMZGc4+kz59924O2l+p8CK4qbY7myQGvbZyIjqxosLV907
	 QwAB3BidWBK5DqXrPniQmKOj3f/3spVX4DaSh0YeVsU4gUACV5wzW+Pwda1jFQeCJsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991651;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=01wU+Zz1r6+jd+0/l3DROTIWKZT4+ev+ThVsQQdlTP0=;
	b=IPaqHolJOjcq2Z6ISt86PBXLApEbIl2KQpiqsB6HKv7ggAneTeh4Sg1b9/IlINT1+Bur
	 dK7u5TDd7hHqNVRP1VhWQANuJAAzoDu2XYPqOrqfjlCy+njNRaWu2nko8gBHcaUfO/J0N
	 OiMRwB1argNByz68PzNoDGqqRI4jLdjqNrOzevM0WrMRA72z4JXbMLNB5a1gvTBNVzgD5
	 9gb8x70aQSg7OTiwfxH5PngZDnPJu35gTjX3liLiMYWDH7h3rEG3owKii6s7iDbSwUYxn
	 aN+I1Ijz016vSySkP+8Y1Lygz/qKPFiIpHYlVv1ICvqzXqMM6CjnTFD8mKZE6YeuOhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=DxPXVrQK;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C0606A326;
	Fri,  6 Nov 2026 19:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 299C0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=DxPXVrQK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793991651; x=1825527651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=01wU+Zz1r6+jd+0/l3DROTIWKZT4+ev+ThVsQQdlTP0=;
  b=DxPXVrQKJnaeUPmmH8TbrFN0qnxKLwLkHb2MWVW3v68WLvVAJXXXYPd4
   UHapvbnPn5IzRozwaGw4ZWGREmtNf6KUBTrA0hQ65M4R0KxtfjFVou7HY
   5MNoVSGkvLMSPduH6AebD/3jQLXyzRi/JTvkJSdE02xwjYhwwKFidYUpO
   vp+jD+JqlDuxSHvpm28e512f5s3tdoe30WaCktzVkAEvSMTxBdORs0xZE
   /nLLYSFRBoBy1nRU+cRTaoIeDxL07PMAgvawNsXrV4yF8asm/VRK2zVEe
   5aj4dNyyFYbhjruLPVWvxUFgg9p8z9BfkX8RbDk4a8Rfkcm29NoG5k7gI
   Q==;
X-CSE-ConnectionGUID: hZ6i3u4WRh6rI8tthZwIwQ==
X-CSE-MsgGUID: YSU9M6zTT9e94jvb8ET6LA==
X-IronPort-AV: E=Sophos;i="6.27,199,1787011200"; 
   d="scan'208";a="33212643"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 19:00:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:27931]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.238:2525] with esmtp (Farcaster)
 id 99508936-c187-4210-b7fe-ec1167405487; Fri, 6 Nov 2026 19:00:48 +0000 (UTC)
X-Farcaster-Flow-ID: 99508936-c187-4210-b7fe-ec1167405487
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 19:00:48 +0000
Received: from dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com
 (172.19.55.127) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 6 Nov 2026
 19:00:47 +0000
Date: Fri, 6 Nov 2026 19:00:42 +0000
From: David Keogh <dkeogh@amazon.com>
To: Tianyi Gao <tianyi@cloudflare.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Dragos Tatulea
	<dtatulea@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, Alasdair McWilliam
	<alasdair@mcwilliam.dev>, "open list:BPF [RINGBUF]" <bpf@vger.kernel.org>
CC: Nimrod Oren <noren@nvidia.com>, <nh-open-source@amazon.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 0/6] net: configurable extra TX headroom for local
 egress
Message-ID: <au4j2nQdOwr90ffh@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
References: <20261015235335.4162993-1-dkeogh@amazon.com>
 <b8914a523b4a6b80424c5001d3d8012c6a98fd04.camel@infradead.org>
 <bba453eb-769e-458b-88f7-8cc9bcafc1db@nvidia.com>
 <a8f2f84e-7dc0-473d-afb1-af710d621f69@iogearbox.net>
 <atW00dwVpYS4WO5a@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
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
In-Reply-To: <atW00dwVpYS4WO5a@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Tianyi, Jesper (added to Cc),

Tianyi got in touch off-list offering to help get this series merged,
and sent a draft v1 built on the comments in this thread. Thanks, and
sorry for the slow reply. I would be glad to work on it together, and
I would like to keep the discussion on the list from here so everyone
can follow it.

Tianyi, you have a second use case for this: an XDP program on a veth
peer. Please describe it here, as it bears directly on the points
raised above.

I suggest you post v1, with patches 1-4 from me and 5-8 from you, and
the cover letter under your own name, since the veth XDP case and the
new measurements are yours. Please drop my Co-developed-by and
Signed-off-by from patch 5. It is your test, and little of the RFC test
it replaces is left.

I rebased your draft on net-next 0822d2fe3826 and ran it on x86_64 and
arm64. tx_extra_headroom.py passes on both, and with patch 2 reverted
the push and XDP cases fail as expected. A few things to fold in before
posting:

- The note below the --- that native XDP on veth still copies belongs
  in the body. The motivation says veth copies every packet, and this
  series only removes the copy for generic XDP.

- checkpatch --strict reports "Macro argument reuse 'dev'" twice on
  patch 1, for LL_ALLOC_SPACE_EX(). It is the same pattern as
  LL_RESERVED_SPACE_EX() and I am fine leaving it, but NIPA will flag
  it, so a line under the --- may save a question.

- The comment above main() in xdp_helper.c still says the helper does
  not process packets. Something like "with -t it sends one frame
  through the TX ring and exits once the frame completes" would match
  patch 6.

- The iproute2 patch does not build against iproute2-next yet, because
  its uapi copy has no IFLA_TX_EXTRA_HEADROOM. Worth saying in that
  patch that it depends on the kernel side and a header sync.

On the questions you raised:

1. Should removing LL_RESERVED_SPACE_EXTRA() go in patch 1? Yes. The
   reason it cannot be reused is tied to the new macro, so it reads
   well there.

2. Should new fragments from ip_do_fragment() and ip6_fragment() also
   get the extra headroom? No, leave them. A larger value would send
   more packets to the slow path, which copies them.

3. Is patch 5 fine with you as author and my Co-developed-by? As
   above, please drop my trailers from patch 5.

4. Should there be a test that TCP is not reallocated? Yes, I have
   one. It runs one TCP connection over IPv4 and one over IPv6 with
   tx_extra_headroom 0 and 512, and checks that the headroom of the
   TCP packets is the same. With ip_finish_output2() changed to use
   LL_ALLOC_SPACE(), the IPv4 case fails (headroom 246-254 becomes
   566-574). It applies on top of your patches, so I will send it as a
   reply to v1.

Daniel, Dragos, David: unless you see a reason to hold off, the plan is
for Tianyi to post v1, addressing the comments in this thread.

Thanks,
David
