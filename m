Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.240.27.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792981521;
	b=pssHGJ8odug59Ig+2cW4TbYBcN4O3fVDWvu8G9WAvZ5Jyc9v6S1PqzDE82D0AFCqsxpe
	 IyiOFSQtqqUSNri42OjjbFNU73H4Yr1L74RQX2hjaszKPM5Rx6iIYaOcqNoLH+3Ki1gI0
	 BCkDUo7NpaZ+nXGJvitJ4BrUKOV53x3l00XlV7ZprpVrmcemknknxDEK0r0uOb/rt5cRc
	 pxgsiToiij1FlU/bysnIEVcRVyV5rMgnv+St+qxWQClT44LcCTppycXijYuas6SkdAIU+
	 Tdfo7AVKdtN7bLkpCxAMClHRku6ppQEshaZmLD1h8SAxKyrzBzRzteiJo12Jy1iWCTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792981521;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Feedback-ID:X-SES-Outgoing;
	bh=mOSnnefzNqn/6aThbNT9VG6t46jh9yA3DrEsrzMoR2o=;
	b=5KqHW+XdR8ZFgduSkHqzPDrjsOWiTuKF/mdlsI3e9CuwUmnauVlIt1FcGQxQ7zl5DKDz
	 npMVKH3/4ofJWdOScvDZZtjkWTYH6Q//lmNgOaGLHZ/8WlgSI7f/0MqWRgYLDUcXt7MIr
	 EqXAN99nDc4JYt0BsJ/JYAiTVvLpxqauBxs4o4YMpJ8HQt5k60psHcyn3HWRedBStDekV
	 HSjpZu1YKK1/ViN8Z7bBhlO/Vpjtw7LLBbgSJ8NVjSjb+Qh7Vj8xr6vum53aPyuuLklTq
	 sQezwsDmD+P4faPqgr0f2MFUVtzyULurUodxAcp5LPQbkSbso3cRB5S2SVpAbYdQMtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eliskeggs.com;
	spf=pass smtp.mailfrom=us-west-2.amazonses.com;
	dkim=pass header.d=eliskeggs.com header.i=@eliskeggs.com header.a=rsa-sha256 header.s=5wf2ig6m4xs5fvcu5nmk6zmaekj5twpk header.b=nvLgzNL9;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=uRbAHSEA;
	arc=none smtp.remote-ip=54.240.27.27
Received: from a27-27.smtp-out.us-west-2.amazonses.com (a27-27.smtp-out.us-west-2.amazonses.com [54.240.27.27])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860B606A31A;
	Mon, 26 Oct 2026 02:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E860B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eliskeggs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us-west-2.amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eliskeggs.com header.i=@eliskeggs.com header.a=rsa-sha256 header.s=5wf2ig6m4xs5fvcu5nmk6zmaekj5twpk header.b=nvLgzNL9;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=uRbAHSEA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=5wf2ig6m4xs5fvcu5nmk6zmaekj5twpk; d=eliskeggs.com; t=1792981520;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=35YpjmCQnDHx1pTvHTeuKBReAyIAyciGpvzy/nmgkfo=;
	b=nvLgzNL9sMCAAgNUnV73o92WKlsOZuOraGO2WRUzWEPtCGelFWa/7iY3D6qiuJwr
	OfBi/4xjkD3P2NVJKfb4t0UwWDsgXXwxb3Esog6CQxDCguaJF+BFiftnkRXyGH7BpBE
	NqbChxFSMyFUzXtsF3IBdDjGf1N9MWydM1D+8L9Q=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1792981520;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=35YpjmCQnDHx1pTvHTeuKBReAyIAyciGpvzy/nmgkfo=;
	b=uRbAHSEAJogdrDohGdkpYULAkw8oMI61hWMQ1C6KTKs9oWLIHuFiYATMRNPOkvR8
	SEIxNXdxk29TNvNt355YnD2wZ+UDoYFnTHnOKez3fNXOS2tfYCGIXbuYG4R8VXvsbIJ
	QRiqwNrEX5cHtXFW5XWTJ/DnRLk8ma6PJgrCmBPg=
Date: Mon, 26 Oct 2026 02:25:20 +0000
From: Eli Skeggs <kernel@eliskeggs.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Stop reporting EPIPE on
 zero-length skb redirect
Message-ID: <010101a17606cf6f-5e824e65-23b0-4539-835b-e8527b8c1f57-000000@us-west-2.amazonses.com>
References: <20261025-sockmap-bare-fin-v1-0-bb8feae7c4a7@eliskeggs.com>
 <20261025-sockmap-bare-fin-v1-1-bb8feae7c4a7@eliskeggs.com>
 <DMEE6SW3UE97.2DF11HBEBKYYI@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMEE6SW3UE97.2DF11HBEBKYYI@gmail.com>
Feedback-ID: ::1.us-west-2.aEUYuRRC8Z+WeC8mlWAQBpqJLV0VswmaEnHpVsice/Y=:AmazonSES
X-SES-Outgoing: 2026.10.26-54.240.27.27

On Mon, Oct 26, 2026 at 01:51:43AM +0000, Alexei Starovoitov wrote:
> On Sun, Oct 25, 2026 at 04:41 PM Eli Skeggs via B4 Relay <devnull+kernel.eliskeggs.com@kernel.org> wrote:
> > On an ingress redirect, the empty message is still queued as before, but
> > the target socket no longer reports EPIPE.
> 
> That leaves the target broken.
> Nothing dequeues the empty sk_msg. __sk_msg_recvmsg() sees
> sge->length == 0, returns -EFAULT and leaves it at the head of ingress_msg.
> tcp_bpf_recvmsg_parser() finds FIN in is_next_msg_fin(), returns 0 and
> does copied_seq++ on a socket that didn't receive any FIN.
> So every recv() on the target returns 0 and moves its copied_seq further
> past rcv_nxt, and the data redirected from other sockets stays behind
> that msg forever.

Thanks, I'd missed that detail of __sk_msg_recvmsg().

> Lets skip empty skbs instead. That covers both directions.
> The socket's own FIN that goes through the backlog is not queued either,
> but SOCK_DONE check in tcp_bpf_recvmsg_parser() returns 0 anyway.

That does sound much cleaner. v2 will skip empty skbs entirely, and I'll
add a corresponding selftest for the ingress pathway.
