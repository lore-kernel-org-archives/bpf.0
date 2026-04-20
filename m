Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487113B8D4F
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692482; cv=none; b=laa/OyVcgNjuVVT6pcOf5RWUf8un07XCc+P0a98vPR4/v1WoPsnUr1ZGdkF4vAsyFB0QceoHm6TMmey3BGHAojgn44anCame3nbrN7gdW3FDoyBZ7ZvjA+PSYEnahgMl8R6SgMrYqkeecbsn9USRWO5YBTZEGTrBxUrBR/OUxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692482; c=relaxed/simple;
	bh=k/q62INwdjAEBziy/7INPs3qFTuMpF+nSSFuvoNxNNQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rc7YufyzJyt36+4FiQC26PQQMPgIfthljMCPYiArzoUCO/VzdR3zSGU6Q3G9JrRMSlcGviAFcPU9P/yCrtcCXw2lvvGt48XSTA78BVSckvT949zxr5q6vjZvn8kgV+hZ5FPvZEC1zHA6MgIfYMXKsSqwLYmPHk5abt771nrAwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jgfAhwm7; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jgfAhwm7"
Message-ID: <0e5602f1ca92074cbef0554a7a399ff8b1cc8a1c.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776692478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kCdYkBecA7/XuJGra8UNjONJIUlL0HUiZi6CEQkvrI=;
	b=jgfAhwm7v63qhatUrEnfbZRCAWf8zCZlaIbkqymHQ5Vjs/dTkUuuxWGu5Q2/BPiiPGc8U2
	FpCl8oicE31ejBzReQbvjqzRKT8eqdTULSlViutlNUsxatKsE/sBBjBMUZP6uOl3RAMXT2
	9+wceeUUj8JyJ7A5o7piE2h+fC/3rDs=
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject TCP_NODELAY in TCP header option
 callbacks
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Mon, 20 Apr 2026 21:41:06 +0800
In-Reply-To: <20260418092235.98444C19424@smtp.kernel.org>
References: <20260417092035.2299913-2-kafai.wan@linux.dev>
	 <20260418092235.98444C19424@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Sat, 2026-04-18 at 09:22 +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] The patch prevents an infinite recursion causing a kernel stack =
overflow by rejecting
> TCP_NODELAY in specific BPF_SOCK_OPS callbacks. However, it fails to addr=
ess the exact same
> recursion vulnerability achievable via bpf_sk_setsockopt in a BPF TCP con=
gestion control algorithm
> (BPF_PROG_TYPE_STRUCT_OPS).
> --
>=20
> commit 4ff4d98f6b4e3c3d90f9268761de84573f49fd86
> Author: KaFai Wan <kafai.wan@linux.dev>
>=20
> bpf: Reject TCP_NODELAY in TCP header option callbacks
>=20
> This patch rejects bpf_setsockopt(TCP_NODELAY) when called from
> BPF_SOCK_OPS_HDR_OPT_LEN_CB or BPF_SOCK_OPS_WRITE_HDR_OPT_CB to prevent
> unbounded recursion and kernel stack overflow.
>=20
> Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@=
std.uestc.edu.cn/
>=20
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index fcfcb72663ca3..eae2f2c542716 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5833,6 +5833,12 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_s=
ock_ops_kern *, bpf_sock,
> > =C2=A0	if (!is_locked_tcp_sock_ops(bpf_sock))
> > =C2=A0		return -EOPNOTSUPP;
> > =C2=A0
> > +	/* TCP_NODELAY triggers tcp_push_pending_frames() and re-enters these=
 callbacks. */
> > +	if ((bpf_sock->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
> > +	=C2=A0=C2=A0=C2=A0=C2=A0 bpf_sock->op =3D=3D BPF_SOCK_OPS_WRITE_HDR_O=
PT_CB) &&
> > +	=C2=A0=C2=A0=C2=A0 level =3D=3D SOL_TCP && optname =3D=3D TCP_NODELAY=
)
> > +		return -EOPNOTSUPP;
>=20
> Does this same recursion vulnerability exist for BPF TCP congestion contr=
ol
> algorithms using BPF_PROG_TYPE_STRUCT_OPS?
>=20
> If a BPF congestion control algorithm invokes bpf_setsockopt(TCP_NODELAY)
> from its cwnd_event callback when handling CA_EVENT_TX_START, could it
> trigger the same unbounded recursion?
>=20
> When the kernel transmits the first packet of a data train via
> tcp_transmit_skb(), it invokes tcp_event_data_sent(). Because
> tp->packets_out is not incremented until later, tcp_packets_in_flight(tp)
> evaluates to 0, triggering tcp_ca_event(sk, CA_EVENT_TX_START).
>=20
> If the BPF program then calls bpf_setsockopt(TCP_NODELAY), it would resul=
t
> in this call chain:
>=20
> tcp_transmit_skb()
> =C2=A0 tcp_event_data_sent() -> invokes CA_EVENT_TX_START
> =C2=A0=C2=A0=C2=A0 cwnd_event()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_setsockopt(TCP_NODELAY)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_push_pending_frames()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_write_xmit()
>=20
> Since the outer tcp_transmit_skb() hasn't finished, the send head hasn't
> advanced. Wouldn't tcp_write_xmit() see the same SKB, attempt to transmit
> it again, and re-enter tcp_transmit_skb() causing an infinite recursion?
>=20
You are right.=C2=A0I can reproduce this.=20
=20
> Should the restriction on TCP_NODELAY be enforced at a broader level, suc=
h
> as inside _bpf_setsockopt(), to protect contexts holding the socket lock
> during TX paths?
>=20
We can check in sol_tcp_sockopt().

> > +
> > =C2=A0	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, opt=
len);
> > =C2=A0}
> >=20
>=20

--=20
Thanks,
KaFai
