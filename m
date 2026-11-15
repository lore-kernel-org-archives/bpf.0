Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794769960;
	b=RajqQ2eWZOreZNDNJt135W+O95Wq9HI5EQ1AMd1CsAxzMP8QWmpCMZUklQDGvRRbNvC3
	 Y5DRz+S25Ie7MauYEbOMjHGv2rLJAsP2ysq+pt7NXyFTD0UMOaPOYoYMRGCBRpCjSH+WO
	 AzgD6XJ6dt0z78AX/c3WE88z1hQaGApW3Rx429a7MtWzf8r0bahHCyESJKnr2yj/FzB92
	 uwXUeld5ykf6LTAf3KjF57tNjUchRxTpVFvvAKxuMlcE+baY9SjFkkQRtDjMxXgeX9MKs
	 4ulJnCGklcv9OIkcp7h1c7vFfFte+6QVyQCV3yd2jDI+l8iycgCT6aP6gIbcHTYnNWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794769960;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Xqlm2kOR1cxrlmJ+MYBK2EL8pgLaXkcSwS+2jbI07RQ=;
	b=UZH7qclvSlvw1D9bsA2G4zJ7TsaUMPK4XJ3A4yn5XAoqt4iyMQiczaGEdH1GiPOHXMs2
	 Mt1vJTNu92Dqxt1K7Xb9igPdAoDk7F9Ja+vCEVuxRTOZEHgEy+M4M1QmhDqAiuSpKZua0
	 /AUgSmkx8J6V5t469ps05pQqRSjMibe5TA4PRGFTp00Msxku8Y+A1xiB+V6DxIN43YR04
	 bV3cHcfh0tLQRpzvhwmQ/8vut5sYQckBeBZlAWia4WEkcl/vLXdV41Zx2nrbeTQ2X3GWV
	 xj+kAw9AMmMd3w5VLzlyRurUBFiCacrWfaEXuyvR6EI9p/ORND9I+mxstuxCVSHWYeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjO7B99O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4CA606A31A;
	Sun, 15 Nov 2026 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjO7B99O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EF71F000C4;
	Sun, 15 Nov 2026 19:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794769960;
	bh=Xqlm2kOR1cxrlmJ+MYBK2EL8pgLaXkcSwS+2jbI07RQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KjO7B99OaOq2BmFtymQVEXKQouaExUwmim5LYsv9zGWLSgFfTkw94kGJEOXQeU2Mx
	 DCs2YyItL7JHsDcJaFZ/SxlTprQxy05AjkkNffvW2QRnAOf9r9lJS2l5Oz5LgNfCuO
	 Tmyv1lSHS+aeefWLirLUO81uKDnlomVdeCv2yXyxQJE0FGXL8Qxbb/zyDTqxs93z3s
	 MZw1JXQjGIsemX5daI/TnF5OhjPB8XHSmTuze2wAmW6GeE9r8j35SPQNbaNEE+pdlj
	 VTvnLJTyzKYQ6SkRJV5gps4pHiYlEw3P2963JK5b+GYckIs3bkNxzECuUDKic1H13W
	 DH6f+NjjpI5uw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 sdf@fomichev.me, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, alexanderduyck@fb.com,
 kernel-team@meta.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, asml.silence@gmail.com, axboe@kernel.dk,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org,
 almasrymina@google.com, mike.marciniszyn@gmail.com, bestswngs@gmail.com,
 razor@blackwall.org, dw@davidwei.uk, aleksander.lobakin@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, stuclar@meta.com
Subject: Re: [PATCH net-next v1 10/11] eth: fbnic: Support RX buffers it
 cannot split
In-Reply-To: <179443689907.2199510.5966675063900520158@kernel.org>
References: <20261110102039.1002605-11-bjorn@kernel.org>
 <179443689907.2199510.5966675063900520158@kernel.org>
Date: Sun, 15 Nov 2026 20:12:37 +0100
Message-ID: <87tslhhpsq.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@kernel.org writes:

[...]

> Wouldn't the restarted queue keep the old EN_HDR_SPLIT, which no longer
> matches the MAX_HDR, PAYLD_OFF and PAYLD_PG_CL values in CTL1? Nothing
> corrects it until the next restart of that queue.

Pre-existing for the drop mode, and the per-queue bits make it worse. I
have a net fix that serializes link up and queue start with a lock.

[...]

> Should both callers require that the completion starts the buffer and
> also closes it, i.e. a zero offset and PAGE_FIN set? Passing the rcd
> into fbnic_bd_one_desc() and doing both checks there might keep the
> header and payload paths from drifting apart again.

v2 drops these checks instead. With MAX_HDR, PAYLD_OFF and PAYLD_PG_CL
as programmed, the device closes a whole buffer after one descriptor,
and fbnic trusts its completion ring everywhere else.


Bj=C3=B6rn
