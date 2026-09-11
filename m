Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7C379966
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148580; cv=none; b=KANro2QgOWLQDQoxKJP8WTNEGr18mPQleX5tK2FbDFGSZRs+qoLKDuXBzN/C82UzIfdKQNjNO7J5rXJiRJ+LVdJBQq6pQeyprfgwahT/XcPHXba9oU8n8yvvxrfTAbS/Id0Lc7e2nk8m+m1mDb9QBoqHg4J123mcrY3dFI1m/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148580; c=relaxed/simple;
	bh=SzC+EkbzqSWeYDRJASLttJAK3/pHU9g9OhvXEg0bBRE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fYef7R3glmO22Yj6ci1V/Rwtywqt++mzTdOpzhhsLBeTR8OeaGK/Gnh588k25AucKn4dcfNEn89kxQ7WiuNCocA/zI8W4VyfNDLXY3Pac839z5uqlzD3cPLgx17XszgnjnP+1vQKNEIifwlk6Eqvb0e04afqT/b87vJSLUYVOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHO1EPaw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHO1EPaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A064D1F000FF;
	Fri, 11 Sep 2026 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789148578;
	bh=dYdhXjUOo7xVcCoDwzjMT8iFVC86ECmto4Rgj0bK4RQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bHO1EPawN9bHUFNqQUylgXiTevUXza6tCEmAAbf+JxqHzW3GybVav1BR9bEB4GwN7
	 xarEJTH6DNrT9s04WHK8oq1D89xpSBZ286AoNBflovLfOomueZrb5Kk6RtvHv37wDm
	 kCPvy/SpzaDF2Azk1lHoyMAb3b7c6S0q1j+3c+IXdtschHj0lhlVx0P+eLyG3wEOC9
	 LiA2Q1SbKwTEgr5STnwCn/lYjGMVwvUYm/ev0aVKOBdtbgD8kBn0+djns3GygiRP5p
	 kPGR040AFKX41mkUehgZWwyQOa8pTytkWBr+dycUcsPAPQSR3K6L2IX7kb3xvOL0vf
	 1794hqlJqRLWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: reject incompatible socket assignments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shihuang Liu" <shlomojune6@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911172313.64009-1-shlomojune6@gmail.com>
References: <20260911172313.64009-1-shlomojune6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 17:42:58 +0000
Message-Id: <20260911174258.A064D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The newly added bpf_sk_assign_family_ok() check fails to preve=
nt assigning IPv6 packets to IPv4-mapped AF_INET6 sockets, allowing a bypas=
s that triggers the original stack buffer overflow.
--

commit d0f229f5acd0292d1114ee92bd952f7af2a9e02f
Author: Shihuang Liu <shlomojune6@gmail.com>
Subject: bpf: reject incompatible socket assignments

This commit rejects incompatible packet and socket families in bpf_sk_assig=
n()
and bpf_sk_assign_tcp_reqsk() to prevent a stack buffer overflow. It contin=
ues
to allow IPv4 packets to use dual-stack AF_INET6 sockets.

Link: https://lore.kernel.org/netdev/20260823101809.26802-1-shlomojune6@gma=
il.com/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index cae43b9991627..b5452113f974a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -3491,6 +3491,32 @@ static int bpf_skb_proto_xlat(struct sk_buff *skb,=
 __be16 to_proto)
[ ... ]
> +static bool bpf_sk_assign_family_ok(const struct sk_buff *skb,
> +				    const struct sock *sk)
> +{
> +	unsigned short family;
> +
> +	switch (skb->protocol) {
> +	case htons(ETH_P_IP):
> +		family =3D AF_INET;
> +		break;
> +	case htons(ETH_P_IPV6):
> +		family =3D AF_INET6;
> +		break;
> +	default:
> +		return true;
> +	}
> +
> +	/* Requests inherit the listener family, but have family-specific ops. =
*/
> +	if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> +		return inet_reqsk(sk)->rsk_ops->family =3D=3D family;
> +
> +	return sk->sk_family =3D=3D family ||
> +	       (family =3D=3D AF_INET &&
> +		sk->sk_family =3D=3D AF_INET6 &&
> +		!ipv6_only_sock(sk));
> +}

[Severity: Critical]
This is a pre-existing issue, but does this logic still allow a bypass that
triggers the original stack buffer overflow when handling dual-stack AF_INE=
T6
child sockets?

If a dual-stack AF_INET6 listening socket accepts an IPv4 connection, it
creates a child socket with sk_family =3D AF_INET6 and sk_backlog_rcv =3D
tcp_v4_do_rcv.

If a malicious IPv6 packet is assigned to this IPv4-mapped child socket usi=
ng
a TC BPF program, bpf_sk_assign_family_ok() evaluates to true because both =
the
packet and the socket report AF_INET6, incorrectly allowing the assignment.

If the socket is locked by userspace, the packet gets queued to the backlog.
Upon unlock, release_sock() calls the socket's backlog handler,
tcp_v4_do_rcv(), to process the IPv6 packet.

If tcp_v4_do_rcv() rejects the packet (for example, due to out-of-order data
on a half-closed socket), it jumps to the reset label and calls
tcp_v4_send_reset(), which unconditionally passes the IPv4 options offset to
ip_send_unicast_reply() and __ip_options_echo().

Since the packet was originally processed as IPv6, the control block contai=
ns
h6 data instead of IPv4 options. Attacker-controlled IPv6 extension headers
can overlay the IPv4 option offsets, which causes __ip_options_echo() to
execute an out-of-bounds memcpy into a stack buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911172313.6400=
9-1-shlomojune6@gmail.com?part=3D1
