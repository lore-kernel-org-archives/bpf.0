Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044936;
	b=1rAjj+W6qk//OvhlofdWXWju29og9oAXRBc3VmNHfiGhIY1cUfLcms2gpHgx347aAl+U
	 S3zg5oVZdmDUwOdTAOcOxEreZAhPP2tlH+9bNNH/rv+HWd+V4tEt2ce1nrJgKj6ScYXr6
	 YwAoUhnMgx2NngjEJn7Yx+Y6AHc0YAAp4I6U08Nmd30VnT6USl1B6fGItFoB3o7Ecn18V
	 6gSrITapGDHyNTRQaUnr/sVXX+zZ3Nc2gG7uu/TyTcSBBF08rLVBUJdk3DBISQlwa/N9W
	 0OTzfe2v79G6RIL4gfRRYFNgo5aBGpGkwk901dgAQJ6nBeSDHHINZjrcw6E4Zz9oZ1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044936;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2acnagTXh+xr2sJRfNZo6Zu2b+AvMnzwD/RO49jKRp0=;
	b=m/hdxU1bKNVvjS3j3R/bBVnDc2a3WUUFF45QbMp+nhuw0KTbDWLvZJt7wPz4UU8fjsYQ
	 r4jpg0gVhm5X9j06yoNDWR603p8ejDx51ep8G40uh9T0RI/uARTFvkGRCAAEbX3QyagFp
	 wJzOQn04UqSwbbSboutPI74nzb32WqtK+ePSXyqmNFNaGoKB22fCdSLQCJ6+ib+vbn3Ia
	 CmvK2qsM395JzKXjEoFQhKMxqeqGpWzeZs/HXm7CYek5iov8w2qIw8/aNph3v3yM65PhG
	 WU5ceZKBRDcHEUlFHhcGCIh1cQTbqfrpptEO2F7p8yID78g5aJQ6aOOPVXACbukhipA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2epo7TM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669F606A32C;
	Wed, 18 Nov 2026 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2epo7TM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFB01F000C5;
	Wed, 18 Nov 2026 23:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044936;
	bh=2acnagTXh+xr2sJRfNZo6Zu2b+AvMnzwD/RO49jKRp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N2epo7TM+4CMqdU9Z7/p9rcgWlA/P76+DKQXTEg7yDOipZZSIsty6IC0YrBbcywCI
	 DJbpuriXg4aAy2YaazApcaqWBW57PtUm8nDcS/ILgaTnRz0fdUuE5pIX6A3ciKPB6F
	 X1dPEDgqViOxdfMlLJevtgoiLyIXyjHPJuvJT8l7ohfZAua1XOQjnFmDlx/UleV5rZ
	 NItGqbCmmF8iKThT2i43FePFdWFkAb1d74n80X17nqpg7HjnxeuSvafTpGFJCAOHVi
	 MBlrtgThq8LgaVR6sH0nM2sEmUoeytwe5U2rqWLvvdFPnVTYfWp/RsbD1Cmj1ByKKt
	 QpVoN95Jy5WYQ==
Date: Wed, 18 Nov 2026 15:35:33 -0800
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
Message-ID: <20261118153533.42cb8def@kernel.org>
In-Reply-To: <CAG4wq-cQVUJgizeowhr4s4Z2Q_o0_dWfAwzXthpBATBB-7edLQ@mail.gmail.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
	<avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
	<CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
	<20261115113902.4834dda6@kernel.org>
	<CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
	<20261116142710.347e8571@kernel.org>
	<CAG4wq-cDYa2GkpWSYeOLwEPv45BtucZk+r=N2b1Srd=gUUO4MQ@mail.gmail.com>
	<20261117161856.6f6c2ce9@kernel.org>
	<CAG4wq-cQVUJgizeowhr4s4Z2Q_o0_dWfAwzXthpBATBB-7edLQ@mail.gmail.com>
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

On Wed, 18 Nov 2026 00:42:55 +0000 Tianyi Gao wrote:
> But I see a fundamental mismatch between reading and writing the RX
> metadata:
> 
> - To read it, we must go through the driver callbacks, because each
>   driver keeps it in its own descriptor format.
> 
> - To write it, the target is always the xdp_frame or the skb, and
>   both are the same for every driver.

Sorry to labor the point but the assertion that the write API has to
be operating on a completely separate copy of the information, via
a completely separate API is unproven IMO.
