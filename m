Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.240.27.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984623;
	b=Y1Gnmx6PkzxzObLgvnd/CUffXgsSqU2O2u3dprG9EV9MuE5CxfcG5xZr/zfXB982ecx1
	 a34IXmiYBKNhI0Yh2ZJQPvHgKNmlhhgu4hIgMgLFwox7o/UFKVNilQ4mI//R8Q6cSpLFf
	 wJA8JLLyrY37ScmO1AZUvubPSDVlGEFGrLlu7sPGfOKheaNwLb1+5f9nBD53CzEfrgv+O
	 px3gc74hK46vfysnUi2ZAtRomfhLcVIpb74VwgBE818895zN6B1tvKYgjj7+c9K4fVz7P
	 dhBL1z9mE8Wg5jYU0iebPArcrENY10sH5TLIfttomHrVPi5B+tgnzr2MB2Cwr/qOH+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984623;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Feedback-ID:X-SES-Outgoing;
	bh=A2LbPxlANFscuDu+5t6LoJ+YO+qfoCuiwkLsdsczSs4=;
	b=f4GSGujn37LyepSbaajVAuIAWnT1zUfQvGAE98vk72b7GZK9dYL5Ad0vfSAmZN9dfUPY
	 JnOpmRRwm9N3DtduNj8E210FdZybFmCEYFqKW6tcFXoP7k3bmZ4Os+/i0qZRDVqcq+5UP
	 EWjFkL3EOGIejn8DgAvHce+K87rXlKpJ1zVT5Sp4JLQRuKwNFemBgYoyNgyhnC4WTz0Hl
	 slCci+2PbcG6Ru39SeOB5WC5UMD8WO/OjCCh2yK2eKBG7dKaFbAW8Aukjvz6mc6SLvneV
	 Vr4Tjhn6fcr0ZVpUp2XfIfMbpJZFxd4q9+j/rX69kmBQJ/uuzRTvgzfDT7fhD0zJhJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eliskeggs.com;
	spf=pass smtp.mailfrom=us-west-2.amazonses.com;
	dkim=pass header.d=eliskeggs.com header.i=@eliskeggs.com header.a=rsa-sha256 header.s=5wf2ig6m4xs5fvcu5nmk6zmaekj5twpk header.b=aMIieMyq;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=iLi5uCYL;
	arc=none smtp.remote-ip=54.240.27.27
Received: from a27-27.smtp-out.us-west-2.amazonses.com (a27-27.smtp-out.us-west-2.amazonses.com [54.240.27.27])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186A606A322;
	Mon, 26 Oct 2026 03:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6186A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eliskeggs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us-west-2.amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eliskeggs.com header.i=@eliskeggs.com header.a=rsa-sha256 header.s=5wf2ig6m4xs5fvcu5nmk6zmaekj5twpk header.b=aMIieMyq;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=iLi5uCYL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=5wf2ig6m4xs5fvcu5nmk6zmaekj5twpk; d=eliskeggs.com; t=1792984622;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=A2LbPxlANFscuDu+5t6LoJ+YO+qfoCuiwkLsdsczSs4=;
	b=aMIieMyqNmiWx5SOQvYw/09ThJHTSl0FHiX1rGynNpEov/suluJAC5W0VjmvIDdI
	LkXm9GjwRhLuo8mtFs0s9tnMeogzIaK5m/vDaEFuedukU5RD9PQFVx8SmHZGqQgyOBp
	Jpdu+cOaXgS+akchCwEcb/Q5siMP/2gGozanjEQM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1792984622;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=A2LbPxlANFscuDu+5t6LoJ+YO+qfoCuiwkLsdsczSs4=;
	b=iLi5uCYLf2AE1CoxngD8YySv3oj7AGYaAU8tetFyCThPuzNBMLfp2oVjtWWQik+4
	C3wEYhpzsmJBU9K87XNj321/nuSZivjf+p94infmSheOkArLpkvsaDbjxtFg99FZWkO
	Dn/OhE1HUOO7DAjta2U5phrokcqYYBmbTG3KSjeM=
Date: Mon, 26 Oct 2026 03:17:02 +0000
From: Eli Skeggs <kernel@eliskeggs.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
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
Message-ID: <010101a176362646-06b53e65-6c20-4ac2-9e05-b74eb5376abf-000000@us-west-2.amazonses.com>
References: <20261025-sockmap-bare-fin-v1-0-bb8feae7c4a7@eliskeggs.com>
 <20261025-sockmap-bare-fin-v1-1-bb8feae7c4a7@eliskeggs.com>
 <23181ba7-e4ef-4475-92ee-366e0ca2dcf0@linux.dev>
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
In-Reply-To: <23181ba7-e4ef-4475-92ee-366e0ca2dcf0@linux.dev>
Feedback-ID: ::1.us-west-2.aEUYuRRC8Z+WeC8mlWAQBpqJLV0VswmaEnHpVsice/Y=:AmazonSES
X-SES-Outgoing: 2026.10.26-54.240.27.27

On Mon, Oct 26, 2026 at 09:59:00AM +0800, Jiayuan Chen wrote:
>
> On 10/26/26 7:41 AM, Eli Skeggs via B4 Relay wrote:
> > From: Eli Skeggs <kernel@eliskeggs.com>
> >
> > Treat a return of 0 as success when there is no data to send, while
> > continuing to fail on a 0 return with residual bytes. The loop exits
> > without incident on an empty skb, and the skb gets cleaned up as usual.
> > On an ingress redirect, the empty message is still queued as before, but
> > the target socket no longer reports EPIPE.
>
> The target can't receive anything after that though. The empty msg sits
> at the head of psock->ingress_msg and nothing ever dequeues it:
>
> [...]
>
> So the user gets EOF on a socket whose peer never closed, and everything
> redirected to it after the FIN is lost. Without a verdict prog on the
> target it is worse, tcp_bpf_recvmsg() returns -EFAULT forever.
>
> Since this patch is already about the zero-length skb, can you handle
> the ingress side too? E.g. in sk_psock_skb_ingress(), don't queue an
> empty msg when len is 0 and the skb was redirected (skb->sk != sk). The
> self PASS case must keep its empty msg since is_next_msg_fin() depends
> on it.

Yep, thanks for pointing that out.

Alexei suggested skipping empty skbs in sk_psock_backlog():
https://lore.kernel.org/all/DMEE6SW3UE97.2DF11HBEBKYYI@gmail.com/

To your point, I think the critical difference between these approaches
happens when the sk's backlog queue is not empty and the socket's own
FIN (the self PASS FIN) gets queued. In that case, we rely on the empty
msg to correctly update copied_seq, and skipping it means the copied
sequence number ends up 1 behind rcv_nxt.

This path is already broken: when a socket's FIN gets queued behind
other skbs, the backlog reports the erroneous EPIPE just as in the
redirect case.

I do like the simplicity of skipping the empty skbs entirely. I don't
immediately see what the consequence is for copied_seq being behind in
this terminal state, but the approach that updates copied_seq does seem
strictly more correct.

Is that the right interpretation? Let me know what direction I should
take for v2.
