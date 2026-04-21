Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE542E8DEC
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786649; cv=none; b=bWyrsnQw8PU8WrjYslEbHu7IqBgEzD5XfXZLsyfJLymtPp6APE9oeb533kG/y1jzUXcYGWOX8DMTeeJCnK771MlzXzvW7Drx0qWKHYmJmMBRA8FQl42/58NDMAEngGTocOpNPspza72oDB02szpnjV4tCYHl7dG3LF4BBvazHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786649; c=relaxed/simple;
	bh=uIaX7HJkeRZprlQHOw3IBZih3XmAWm21aNzyECQgp3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YaafcZK7y9VAWSHq4ujblm9veCKyy4ziFZBB4LQsM5lqgn6MTECbUPVh7MGBtDPDHa/qrlH/retweIgJTNRj0lu75Sty4KMFWcn+oj9/cHpBaOaiWrtU63kOb24E1ikQfi6rE7Z7SOLY5wvNidBQQ0WLyMDzeQdxGguNPNwDMsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r2ujUNBs; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r2ujUNBs"
Message-ID: <b546fbe2c2e8bc3783b18944df01d2e15171ed70.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776786646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIaX7HJkeRZprlQHOw3IBZih3XmAWm21aNzyECQgp3M=;
	b=r2ujUNBs+3CIblj8FgVvBGRJxRoKdYOUIaj6NiwbjuvKX5t0Q8nbcSNSaqHeoGR25DibjT
	qScfJ26gg/rbpWhrIoobAX7RLuPhseeN58RfNigZjspJSFu5hXxmCbtxeMn8rX/GDE229b
	e1L4DGg2rDGB5Yh/j+/Di90hN1rGKkw=
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject TCP_NODELAY in TCP header option
 callbacks
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org
Date: Tue, 21 Apr 2026 23:50:29 +0800
In-Reply-To: <2026420174537.e2om.martin.lau@linux.dev>
References: <20260417092035.2299913-2-kafai.wan@linux.dev>
	 <20260418092235.98444C19424@smtp.kernel.org>
	 <0e5602f1ca92074cbef0554a7a399ff8b1cc8a1c.camel@linux.dev>
	 <2026420174537.e2om.martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Mon, 2026-04-20 at 11:12 -0700, Martin KaFai Lau wrote:
> On Mon, Apr 20, 2026 at 09:41:06PM +0800, KaFai Wan wrote:
> > > Does this same recursion vulnerability exist for BPF TCP congestion c=
ontrol
> > > algorithms using BPF_PROG_TYPE_STRUCT_OPS?
> > >=20
> > > If a BPF congestion control algorithm invokes bpf_setsockopt(TCP_NODE=
LAY)
> > > from its cwnd_event callback when handling CA_EVENT_TX_START, could i=
t
> > > trigger the same unbounded recursion?
> > >=20
> > > When the kernel transmits the first packet of a data train via
> > > tcp_transmit_skb(), it invokes tcp_event_data_sent(). Because
> > > tp->packets_out is not incremented until later, tcp_packets_in_flight=
(tp)
> > > evaluates to 0, triggering tcp_ca_event(sk, CA_EVENT_TX_START).
> > >=20
> > > If the BPF program then calls bpf_setsockopt(TCP_NODELAY), it would r=
esult
> > > in this call chain:
> > >=20
> > > tcp_transmit_skb()
> > > =C2=A0 tcp_event_data_sent() -> invokes CA_EVENT_TX_START
> > > =C2=A0=C2=A0=C2=A0 cwnd_event()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_setsockopt(TCP_NODELAY)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_push_pending_frames()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_write_xmit=
()
> > >=20
> > > Since the outer tcp_transmit_skb() hasn't finished, the send head has=
n't
> > > advanced. Wouldn't tcp_write_xmit() see the same SKB, attempt to tran=
smit
> > > it again, and re-enter tcp_transmit_skb() causing an infinite recursi=
on?
> > >=20
> > You are right.=C2=A0I can reproduce this.=20
> > =C2=A0
> > > Should the restriction on TCP_NODELAY be enforced at a broader level,=
 such
> > > as inside _bpf_setsockopt(), to protect contexts holding the socket l=
ock
> > > during TX paths?
> > >=20
> > We can check in sol_tcp_sockopt().
>=20
> I don't know how it can use the socket lock to single out this case.
> All bpf programs that are allowed to call bpf_setsockopt should
> have the sock lock held. Maybe I am missing something obvious.

I tried to find a way to determine if the sk is in tx state in tcp_transmit=
_skb(),
but didn't succeed.

>=20
> In bpf_tcp_ca_get_func_proto, it checks what ops can do bpf_sk_setsockopt=
_proto.
> Right now, it rejects the "release" ops. One option is to create a new
> func_proto, bpf_sk_setsockopt_nodelay_proto, to reject TCP_NODELAY.
> Instead of checking cwnd_event[_tx_start] in bpf_tcp_ca_get_func_proto,
> I would return bpf_sk_setsockopt_nodelay_proto for all ops. We can revisi=
t
> and be more selective in the future if the hammer turns out to be too big=
.
> "release" ops will remain disallowed from calling bpf_setsockopt.

Great, I'll try this one. bpf_getsockopt(TCP_NODELAY) will not trigger=C2=
=A0
infinite recursion, I will keep it as is.

--=20
Thanks,
KaFai
