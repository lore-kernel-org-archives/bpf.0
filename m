Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2D374A05
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139739; cv=none; b=qNrAM2cfx4EahCz+ymlqMVzVLQMpDSt1ssNlHoVIeaKLS7l5Mu56E425S1PBCkrdNsQbjqK66BSYTl4lkIY/KT0a8cPiNuL3YEHegRjWuMdRGIR4hT1nJN/myii1xKg6shzFg9wkYhZqAyCfte4v7JfNQmbPbz72j6Le4FzMAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139739; c=relaxed/simple;
	bh=Fy3vVmZFQKyiQvLTe3aYCuWhcgKe8joTr3WiBwtqY/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lycr3TpCFbeiDKOUBKd50BH+oP5MP0Ev0nfk9YKovlzLGzhQBJ7ISiDU7bf05XacxxDBVJwPe43mBrKBDDXYy5e1U8d9BGJNmDUg3a0KRYnQbuTpecWzwlPVQSbOb9EHZ2qopYwZJ8I1zqD+4BfijwVnQ65Le/o/avdxMkQQc0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jS14WRCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS14WRCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9111F000FF;
	Fri, 11 Sep 2026 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139737;
	bh=xrfySFkPeIIPBNGWrc28P6XWT7JkbJuh+uxoP2KEEjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jS14WRCeX18PCLr568UBQRNS5C9maQA6dlZ5Pgw+deLjzZ7pEmDGNq2Tq+0mxjyaq
	 qQMRjvDDw62of/RIJnQs+yUuJmFzmtYXAqIOLVCk1aD6Ydhr92WYUsrcFwqhN4sKkQ
	 FTG8JS+C5uy/AT2IYUPzMqrJUv3wLwa4qgG1Sayih9fdXtfY4GoTkTKewGk1bG32wO
	 Lj8ce6cvrTm/AkrH+iOtdXt09SLm/JA9+QJudG8vHE1ai8imv4tmeArmQ+cxzZynwW
	 tIfG6x6ddvJTN8ca3sv3RJttGRr2rGa0Xp1GPuZTiKIvdniulMdPQhssPICWkr8rjU
	 dGOVQ8pkCpIOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13 net-next] net: udp: split IPv4 specific logic into
 udp_ipv4.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fernando Fernandez Mancera" <fmancera@suse.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910144914.8025-7-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-7-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:15:37 +0000
Message-Id: <20260911151537.BB9111F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Aggregated IPv4 UDP packets are silently dropped during GRO comple=
tion when CONFIG_IPV4 is disabled.
--

commit d963ce43c73f11f406bea2e26b36c86cf494d30c
Author: Fernando Fernandez Mancera <fmancera@suse.de>
   =20
net: udp: split IPv4 specific logic into udp_ipv4.c
   =20
This commit moves IPv4-specific UDP socket logic from udp.c into a new=20
udp_ipv4.c file. This isolates the IPv4 functions from the generic UDP=20
socket infrastructure, allowing the INET subsystem to be compiled without=20
IPv4.

> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
[ ... ]
> @@ -954,6 +960,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
> =20
>  INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int n=
hoff)
>  {
> +#if IS_ENABLED(CONFIG_IPV4)
>  	const u16 offset =3D NAPI_GRO_CB(skb)->network_offsets[skb->encapsulati=
on];
>  	const struct iphdr *iph =3D (struct iphdr *)(skb->data + offset);
>  	struct udphdr *uh =3D (struct udphdr *)(skb->data + nhoff);
[ ... ]
> @@ -975,6 +982,9 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct =
sk_buff *skb, int nhoff)
>  					  iph->daddr, 0);
> =20
>  	return udp_gro_complete(skb, nhoff, udp4_lib_lookup_skb);
> +#else
> +	return -EAFNOSUPPORT;
> +#endif
>  }

[Severity: High]
Does this cause aggregated IPv4 UDP packets to be silently dropped during
GRO completion when CONFIG_IPV4 is disabled?=20

When an IPv4 UDP packet stream is aggregated by GRO on a system compiled
with CONFIG_IPV4=3Dn, returning -EAFNOSUPPORT causes the GRO engine=20
(gro_complete) to treat the completion as a failure, invoking kfree_skb()
and dropping the packet.

Since udp4_gro_receive remains unconditionally enabled in udpv4_offload_init
(as net/ipv4/udp_offload.c is compiled when CONFIG_INET=3Dy), untrusted
network input can reach this path. Even on an IPv6-only node, an L2 bridge
or packet sniffer expects to see L2 traffic correctly. Dropping aggregated
packets breaks L2 bridging of IPv4 UDP traffic and prevents packet sniffers
from seeing bulk traffic streams.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910144914.8025=
-1-fmancera@suse.de?part=3D6
