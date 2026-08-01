Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02C31715D
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785565337; cv=none; b=LhXUW6uy/UwlfxLUGLKL6ARZS232pbZ/SKa7R3waA0njt6SQDAoE1JTZ6F8DEBv6nodlAXG25HO2YZoTdFefde9A7L0+eUwyi2c9vjlbcezitpqvA+fym8wLytLKF3UalkLVBFpahpDlU9EYFle30Qu8kZ3YMyVhzyO5UWtVXQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785565337; c=relaxed/simple;
	bh=vn27u9poBCCez1Cy7RylQPOsZTX4h2Ekr9br/OYewyk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QWPxotCWsOu9liLN4dj30AK/d/EXHSNs648VyRSXJ/9OzFRhGjKWqPjx4P5VgRe4OKzjZw/mcLBKtGXHEUao25nP8H/PcHhoL0l/sVeI1WeL8lQMXnf3HV47VoNYxGKJd5yGPnTqbSG0eIl9A+eNlC215UcU92PmlsTaffSgHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPWcjesD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPWcjesD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E8C1F00AC4;
	Sat,  1 Aug 2026 06:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785565335;
	bh=Apdpp437ite3K+JVTWewTDhniP6Cpg/QAOYxA51HH/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPWcjesDxuaec/fVnJXzgJtPrS3Vw6II2YNaHNcE0+ix49maiOLNfn/Bm31EDjXQf
	 5P+zIPlrgDPhwFvaYNehlXflAi3PudXtgj3boUT+eCuF7+7YhwVMB5ShYIFvGEJG83
	 4T8YOZk4V39wzuJzhpVAdPg4qprHQC491utzs3oTfnX6H9IvamoBnKDRwXv9pobDOj
	 nAAWAkxTT4lhVeD8qiRSrn/+1khSJrsMAfjxqJxNtFIXuXIjvL7LwtyjLFgNZgxU5d
	 jeAFGGeWomqJMdGu5vinR3Had96G9bK+ySxQY8+NpZbrI6Un/SqHE6zYVvnU1XXQVq
	 9RqTnTas4mI2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/1] net: cap advertised device headroom
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiling Zou" <zhilinz@nebusec.ai>
Cc: bpf@vger.kernel.org
In-Reply-To: <0ae4aa29223b89049727aec4d36f144bad41537e.1785476387.git.zhilinz@nebusec.ai>
References: <0ae4aa29223b89049727aec4d36f144bad41537e.1785476387.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 06:22:14 +0000
Message-Id: <20260801062215.43E8C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch attempts to prevent 16-bit skb header offset overflows b=
y capping `needed_headroom` to 512 at device configuration. However, this o=
nly mitigates overflows caused by a single massive headroom allocation. It =
fails to prevent cumulative overflows in the data path. An attacker can cha=
in multiple tunnels and interpose a qdisc like `netem` to bypass the `dev_x=
mit_recursion()` limit (since `netem` defers transmission to a timer, unwin=
ding the call stack and resetting the recursion counter). Because `needed_h=
eadroom` is capped, `skb_cow_head()` will repeatedly calculate a small `del=
ta` and trigger `pskb_expand_head()`. Each call increments the 16-bit heade=
r offsets. After enough chained transmissions (e.g., ~1600 tunnels), the of=
fsets will exceed 65535 and wrap around, leading to out-of-bounds reads or =
writes when the headers are accessed.
--

--- Patch [1]: [PATCH net v2 1/1] net: cap advertised device headroom ---
commit 9a8b47db3e094ff90f0e4cb79a3ba54d0ddcaab8
Author: Zhiling Zou <zhilinz@nebusec.ai>

net: cap advertised device headroom
   =20
IP tunnel and netkit devices can publish headroom values that are derived
from user-created stacked devices or directly supplied netlink attributes.
The dynamic tunnel transmit path already caps growing needed_headroom at
512.

Link: https://lore.kernel.org/all/0c6c64e9bbd71a0decc8504a384061e0e631be13.=
1785054561.git.zhilinz@nebusec.ai/

> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index d708b66e55cda..85e3455cea259 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -629,8 +629,7 @@ struct metadata_dst *iptunnel_metadata_reply(struct m=
etadata_dst *md,
>  int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_d=
st,
>  			  int headroom, bool reply);
> =20
> -static inline void ip_tunnel_adj_headroom(struct net_device *dev,
> -					  unsigned int headroom)
> +static inline unsigned int ip_tunnel_limit_headroom(unsigned int headroo=
m)
>  {
>  	/* we must cap headroom to some upperlimit, else pskb_expand_head
>  	 * will overflow header offsets in skb_headers_offset_update().
> @@ -640,6 +639,14 @@ static inline void ip_tunnel_adj_headroom(struct net=
_device *dev,
>  	if (headroom > max_allowed)
>  		headroom =3D max_allowed;
> =20
> +	return headroom;
> +}

[Severity: High]
This is a pre-existing issue, but does capping needed_headroom to 512 here
completely mitigate the 16-bit header offset overflow in
skb_headers_offset_update()?

While this prevents a single massive allocation from overflowing the offset=
s,
it seems it doesn't prevent cumulative overflows in the data path. If a deep
chain of network tunnels is created and a delaying qdisc (like netem) is
attached to each to bypass the dev_xmit_recursion() limit (since netem
defers transmission to a timer, unwinding the call stack and resetting
the recursion counter), skb_cow_head() could repeatedly calculate a small
delta and trigger pskb_expand_head().

Each call increments the 16-bit header offsets in
skb_headers_offset_update():

net/core/skbuff.c:skb_headers_offset_update() {
    ...
    skb->mac_header +=3D off;
    ...
}

After enough chained transmissions, could the offsets exceed 65535 and wrap
around, leading to out-of-bounds reads or writes when the network layers
access the wrapped header pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0ae4aa29223b8904972=
7aec4d36f144bad41537e.1785476387.git.zhilinz@nebusec.ai?part=3D1
