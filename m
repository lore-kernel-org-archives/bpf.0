Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00AB4CA784
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787256; cv=none; b=pq2RJkfdXKFTbCAn1bqRUgJTbwWVtSSw2irGy5k/FuYpY9yx+cogsXtwEjEkF4b6RyyNGeC1JfIDsCbl+7oFSX+O+Qnnz9mkeoGQ9GvwemGVxSxIFXPmr2h2dsHWazt+X7RfWI3/s0P7PbYoUV80hfWNNJS7iS0Fk0LiCU+Q18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787256; c=relaxed/simple;
	bh=SppBPdOMAyu96CmRjey9BDJ//WBCfQoDCWY4FxakB1s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rJf9qIlOGIL3PC4SU83L4WJ3Kt2WR5uy1TjTdi2U88qnogvgYf4sWcl1pgsmpeRUTdJ8z8qkLLBbyjhheSe5xRFG/qkw7oIReoop/kEyLOolGFg9Wueo5G7cmW7wZkESHAAfZ0tctSwDpL+jdpcYC95WyHe2dTrCJ/Kis8NtPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wlz7z4eC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wlz7z4eC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C361F00898;
	Wed, 30 Sep 2026 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790787255;
	bh=otXXRbPON7ldP2f7U7dxUktFC97a71ovhJP7gXXALo0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wlz7z4eCYklgHT6bqkPLiyGtE0yYF/pFdby3oJcqE5WdX1MTO05dTqDdwQ7hoO7r4
	 2hRySnAo4DErcSkhO89cLIqsx3qOrpeymZBLi/trlvY+lXTYmjiERjuWbOJZPaVojB
	 iO5ukiHLWPsvOglq/QYeWJKDnPp1eqCwECS/YNQdfld4oeEXQZ4SzBd7/JUglBv4D7
	 T7vQnLSs002uIa7YTG1wfJydXI2lVo2XczEcbF8VLB39NV/PQg3lpt3hspjW1xu/5w
	 jymlw6ZqnFo6uSSltkkG8hocls72YBqn5gS7wPvrSICO0pUlF2OZh9yn+s5HEMfNPI
	 S2KuxSdYBD8zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: reject incompatible socket assignments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shihuang Liu" <shlomojune6@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930164020.41006-1-shlomojune6@gmail.com>
References: <20260930164020.41006-1-shlomojune6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 16:54:15 +0000
Message-Id: <20260930165415.85C361F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: bpf_sk_assign bypasses family check for encapsulated packets
--

commit bd75dbe60b27d785e5799901fce33eb038028e20
Author: Shihuang Liu <shlomojune6@gmail.com>

bpf: reject incompatible socket assignments

This commit fixes an out-of-bounds stack buffer copy by validating socket
and packet family compatibility in bpf_sk_assign(). It ensures IPv4/IPv6
socket mappings match the packet protocol, maintaining compatibility for
dual-stack and mapped sockets.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 70dc621672f2e..173349bd2a3f9 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -3491,6 +3491,64 @@ static int bpf_skb_proto_xlat(struct sk_buff *skb,=
 __be16 to_proto)
>  	return -ENOTSUPP;
>  }
> =20
> +static bool bpf_sk_assign_family_ok_proto(const struct sock *sk, __be16 =
proto)
> +{
> +	const struct inet_connection_sock_af_ops *af_ops;
> +	unsigned short family;
> +
> +	switch (proto) {
> +	case htons(ETH_P_IP):
> +		family =3D AF_INET;
> +		break;
> +	case htons(ETH_P_IPV6):
> +		family =3D AF_INET6;
> +		break;
> +	default:
> +		return true;

[Severity: High]
Does this default case bypass the family check for encapsulated packets?

If a TC ingress BPF program uses bpf_sk_assign() on an encapsulated packet
(such as MPLS), the switch statement falls through to the default case
and unconditionally returns true because protocols like ETH_P_MPLS_UC are
unrecognized.

If this packet is later decapsulated (e.g., via the TC act_mpls module), its
protocol could change to IPv6 while retaining an assigned AF_INET socket. W=
hen
the networking stack processes this decapsulated IPv6 packet with the AF_IN=
ET
socket, it may interpret the IPv6 control block data as IPv4 metadata,
leading to an out-of-bounds stack access.

Can this be triggered remotely by sending encapsulated packets, defeating t=
he
vulnerability fix for setups performing decapsulation?

> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930164020.4100=
6-1-shlomojune6@gmail.com?part=3D1
