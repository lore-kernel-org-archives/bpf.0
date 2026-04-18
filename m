Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0512BAF7
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776504156; cv=none; b=lawI+Z/2+B6BauBhxDhzjVA8csXx26tZ9qXPy/pJlAj+OvDqjhb7l0VXbX+Dv8yv7QQTqNLyfed3w2WeqWuGkI3jI3v3HRrINc0YK+qW5kGzCMF08jfXIienAC00eEPP89mIIAvWYmP1VGPSYERNolA66hyZPYw6n6TBtfIB81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776504156; c=relaxed/simple;
	bh=9sroYPfd5oOTCYi5MHZk95YviKuiCk6B3xyar7PP3xU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lPiGaEsjPE2OtaRSDsZcTnMOv2h0g+6HmD5EuNwIzXDkWGKPRfLs1WbmoQrmhuUWy/a/zcbwt0B51xYt3wSK6vrEZoukZoqnoDgvc4ooSaDbvNWLyEvNraM17pIqasDr3eJPiHT5nYGoDSDnJqhVkTJMigf+tCwldnf2LGhm+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4Jxj+uW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4Jxj+uW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98444C19424;
	Sat, 18 Apr 2026 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776504155;
	bh=9sroYPfd5oOTCYi5MHZk95YviKuiCk6B3xyar7PP3xU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=L4Jxj+uWAW9BPklL6ko6j2O8ZOxYphIOB4/octcha07RXwm8GRRCfAVI6VKRh4Op8
	 W0K3Z7d5zOkN9nqPzaiXEollT3UNRZHF/D5LgE7rMjK5cwnLKXupcmD6CCpDyKIxbM
	 k8BivhG0qemO6QG6wOkvYZYTF2Nlg7mOip4E2sWsjSongtDdw4jf+qIAahY6YZXt8c
	 pyfKFQUFGjFjHPtQzMt11jHkwN+n6EExEnvcyVlPkikshfikHEnd3zX4Pr3lnGq6qd
	 Maqb7NsXOcjT8sI0FsoJS7JZtx//C5uv9kqCymMMlr4IbamlvJ/hneSf75+S4Qp0gZ
	 t/fO2mLZq495A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject TCP_NODELAY in TCP header option
 callbacks
Reply-To: sashiko@lists.linux.dev
To: "KaFai Wan" <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417092035.2299913-2-kafai.wan@linux.dev>
References: <20260417092035.2299913-2-kafai.wan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 09:22:35 +0000
Message-Id: <20260418092235.98444C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The patch prevents an infinite recursion causing a kernel stack ov=
erflow by rejecting TCP_NODELAY in specific BPF_SOCK_OPS callbacks. However=
, it fails to address the exact same recursion vulnerability achievable via=
 bpf_sk_setsockopt in a BPF TCP congestion control algorithm (BPF_PROG_TYPE=
_STRUCT_OPS).
--

commit 4ff4d98f6b4e3c3d90f9268761de84573f49fd86
Author: KaFai Wan <kafai.wan@linux.dev>

bpf: Reject TCP_NODELAY in TCP header option callbacks

This patch rejects bpf_setsockopt(TCP_NODELAY) when called from
BPF_SOCK_OPS_HDR_OPT_LEN_CB or BPF_SOCK_OPS_WRITE_HDR_OPT_CB to prevent
unbounded recursion and kernel stack overflow.

Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@st=
d.uestc.edu.cn/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index fcfcb72663ca3..eae2f2c542716 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5833,6 +5833,12 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_soc=
k_ops_kern *, bpf_sock,
>  	if (!is_locked_tcp_sock_ops(bpf_sock))
>  		return -EOPNOTSUPP;
> =20
> +	/* TCP_NODELAY triggers tcp_push_pending_frames() and re-enters these c=
allbacks. */
> +	if ((bpf_sock->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
> +	     bpf_sock->op =3D=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB) &&
> +	    level =3D=3D SOL_TCP && optname =3D=3D TCP_NODELAY)
> +		return -EOPNOTSUPP;

Does this same recursion vulnerability exist for BPF TCP congestion control
algorithms using BPF_PROG_TYPE_STRUCT_OPS?

If a BPF congestion control algorithm invokes bpf_setsockopt(TCP_NODELAY)
from its cwnd_event callback when handling CA_EVENT_TX_START, could it
trigger the same unbounded recursion?

When the kernel transmits the first packet of a data train via
tcp_transmit_skb(), it invokes tcp_event_data_sent(). Because
tp->packets_out is not incremented until later, tcp_packets_in_flight(tp)
evaluates to 0, triggering tcp_ca_event(sk, CA_EVENT_TX_START).

If the BPF program then calls bpf_setsockopt(TCP_NODELAY), it would result
in this call chain:

tcp_transmit_skb()
  tcp_event_data_sent() -> invokes CA_EVENT_TX_START
    cwnd_event()
      bpf_setsockopt(TCP_NODELAY)
        tcp_push_pending_frames()
          tcp_write_xmit()

Since the outer tcp_transmit_skb() hasn't finished, the send head hasn't
advanced. Wouldn't tcp_write_xmit() see the same SKB, attempt to transmit
it again, and re-enter tcp_transmit_skb() causing an infinite recursion?

Should the restriction on TCP_NODELAY be enforced at a broader level, such
as inside _bpf_setsockopt(), to protect contexts holding the socket lock
during TX paths?

> +
>  	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417092035.2299=
913-1-kafai.wan@linux.dev?part=3D1
