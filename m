Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBB03B0583;
	Fri,  4 Sep 2026 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556870; cv=none; b=CFd0VMV6GXxRyy+AF41OWQc6YAG1VgVfZgWUJ0NN4G56M71adOHWO1iIncD6BadMh/ofdHQOSh5c5Sw643hTNj75mihuujuToDAKMpak0neExiOY8iOpXXCp4i7GfWWwaqYN2MeFx+/vI8kgtpbQoY9gnx8dcR/dkndzxcnL59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556870; c=relaxed/simple;
	bh=ow/zXpa/eilavpoy7ibKNGTK1Mwz7lSkjoPBxcAUZWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mh5hkiJmV9qUVVbQzqcbG8Tvsh8APskP5veK8PzbomRFyW46LT+UsFgAZD+DBkmorzILt+OxVllf0zeIpud1YqCoS4bIYhMiIWO02nEfw9U4EaP7jjxakeIqyBXUoeEVIm+cbIZ6/BNgoVbeK+xAwSpLZddeaKEECg3PR615/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJNh2F13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJNh2F13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04621F00A3D;
	Fri,  4 Sep 2026 21:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788556869;
	bh=810qIrJpDWh09K9kiOgzNLqoPRq3TOZvKHQZ9uIXbHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OJNh2F136QTDXfXqn/x/sNTU41W2vOUXtSGgnjnhvUhVLk5yktSG4WaQLbYXmROX1
	 tRp7E0AJJ0Uuonq2ZQ5Hvi6SDTeg+i9N5kL8XIevovUd9GXvv3h7cjursjeS7p3Gig
	 DUPU+UAZypLywR3yNCNaF/veNamOFyp1ormbyyengO6t89lLUxcSuF83KqvVLY/aXQ
	 FSKEbMHFwi0ESyyTnljDU+ekT4+X6u11UoyASXArh+Q+BcECp8Y9436zZV5BAb/kQT
	 LFXrk/ACGFdIjQ/bHFBSRr93/xHElmOcpsFD1Ni641nc5zFCLtXUhe42XXMUzwrn9r
	 7kmG4oF2j6zKw==
Date: Fri, 4 Sep 2026 14:21:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <pabeni@redhat.com>,
 <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v12 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <20260904142108.72652338@kernel.org>
In-Reply-To: <apo3CVfUw2-aXF8F@rkannoth-OptiPlex-7090>
References: <20260903023324.3078284-1-rkannoth@marvell.com>
	<apo3CVfUw2-aXF8F@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Sep 2026 08:42:09 +0530 Ratheesh Kannoth wrote:
> On 2026-09-03 at 08:03:24, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> > Add TC_SETUP_QDISC_MQPRIO offload for channel-mode mqprio with
> > TC_MQPRIO_SHAPER_BW_RATE. Program per-queue MDQ CIR/PIR through the
> > NIX TX scheduler mailbox for each non-QoS transmit queue. When offload
> > is active, allocate one SMQ per such queue, parent every MDQ under
> > TL4[0], and map each traffic class min/max rate to the queue(s) in that
> > class.  
> 
> will address sashiko comments in v13

Please wait for netdev-ai report before you respin
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903023324.3078284-1-rkannoth@marvell.com
It seems to have found 5 more issues 

Yes the embargo is really long for you, because it takes you 10+
revisions to get anything merged.
