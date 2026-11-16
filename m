Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868033;
	b=hplwH9RTpse1hTyCVrZWZ2cKJrDCbfM7bI+tn0t3zA7m/viyc3RfR8ptaVZ5lWLqRrH3
	 ns13UNQ/lBGauS7NgxeOPNRQpOZJ61PNHnl8w3/kpub/H2YiOKsWduzGV3Kx2TzDVMUjV
	 AbPZp8gD3i27sDxSyGLT5+FJ1PZrIXme5ofoV6/b6DKaqghCzCQIpqQNPMy87f1USo015
	 XsPaUdeEtxq23f4FQb8aZCYdCCqPLXdgkYLAH+j+s7D60p5ES3v1VQ4hmxNi72WRx16Zx
	 pEwMdolETgmH1bVf7e4+yQ/ipkBT15VHfd2y3AWYj8bhunA1Vho7uFEexfLHGWeY7jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868033;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yTKvK6Q2yCQePo9OFHjf3+LCM7gt5vNfOS7VI6PK0to=;
	b=b+bKZ6Rqb2EEz3bnwpwmKMF6d5XVjEWW+toF4reYNspT0sd3OyMIGhQMizXZFdQ+fe78
	 v8nrsipoD5lG0eqd3UWG1KgSrduYm+cV+1u+eP5A9401Woiwx9AajxCbeaDyYw7SZMDaE
	 6qNc0V3J1YK1XNq/96OygV8UpencbJrUAiIeXhVZkZ9gxMfsFZdn0iX1M2vtdys5lfVpi
	 8ea9sjpfIGObhvr2rOGJzvpywuT6fnZCcdnA01au0VA12A+BEgBDgzuCiybJf6orNrYZK
	 wEoEuNCbHv+ymqL1v5Cn+FRXDR5FHRPK9SoNLzhta9sP5bs8tUNRS5PrtlnZbnA9l1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=md2D4WPO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F8606A884;
	Mon, 16 Nov 2026 22:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=md2D4WPO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283BA1F000C4;
	Mon, 16 Nov 2026 22:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794868032;
	bh=yTKvK6Q2yCQePo9OFHjf3+LCM7gt5vNfOS7VI6PK0to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=md2D4WPOInNakDSqWfE1IPbeod9zOxz2pjEYXRvX5XiOz3ugZVGikYj7oFVPNv5TA
	 anRLz9W1IPaeffFSXdQM5eIkNzSl7SSBVcl2XNx1GIfniOATopc5iOYnfIW2tcJICz
	 aVn8KUWMqGcxXYidnfS7JXA/XupIgyyf55FAXfxOjNnYtNjcQUssyVADQa/bzbhV3W
	 UicZSxsZqypH7o7MtWctPXY/bJPQqUdH6+NnMUSsGHKKnFY1lnd0GDxpKiTXt7vuKS
	 VxK1w0CvT9hWXVQ6g73MyFiBbMOQ63w53AYN7IuB3i9vZCAPLRr0V5/4yR2A03YPn6
	 UCdDxRThMLAvA==
Date: Mon, 16 Nov 2026 14:27:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir
 Vdovin <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Donald
 Hunter <donald.hunter@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Chris J Arges
 <carges@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, llvm@lists.linux.dev,
 kernel-team@cloudflare.com, Tianyi Gao <tianyi.gao@linux.dev>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
Message-ID: <20261116142710.347e8571@kernel.org>
In-Reply-To: <CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
	<avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
	<CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
	<20261115113902.4834dda6@kernel.org>
	<CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
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

On Sun, 15 Nov 2026 23:36:34 +0000 Tianyi Gao wrote:
> On Sun, 15 Nov 2026 11:39:02 -0800 Jakub Kicinski wrote:
> > On Wed, 11 Nov 2026 01:07:46 +0000 Tianyi Gao wrote:  
> > > - On veth, an XDP program removes software GSO from the peer, limits
> > >   its MTU, and can copy skbs from the peer.  
> >
> > Could you remind us why you XDP_REDIRECT xdp_frames to the veth
> > if you end up allocating the skb on the veth, anyway?
> >
> > I thought that was to let veth run its own prog before skb is allocated
> > but you're saying that you want to avoid veth having a prog, so clearly
> > it's not that.  
> 
> Thank you for your comment!
> 
> XDP_REDIRECT into a veth without a program on it has been supported
> since commit 0e672f306a28 ("veth: check for NAPI instead of xdp_prog
> before xmit of XDP frame"). There is demand for it [1].
> 
> With or without a program on the veth, and on cpumap, this series
> keeps the RX metadata from the NIC until the skb is built.
> 
> [1] https://lore.kernel.org/all/20210416175929.35c3c389@carbon/

Perhaps I'm slow but I don't see how this answers my question.
I read your reply as "the config is supported and my team uses it".

The question is _why_ you use it. Let's leave the cpumap case aside,
you provided no legitimate reason why having an XDP prog in that case
is a problem. With veth - you are right that attaching XDP causes
problems for pure skb traffic. For veth cases, however, there's no
strong reason to delay the skb allocation. Hence my question.
Why not let the driver allocate the skb if we know that the
redirect target will need to allocate one, anyway.

Since your patches are not a natural / clean extension of the existing
infrastructure - we should step back and make sure the use case is
practically justified.
