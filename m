Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955733DB32A
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327031; cv=none; b=HJ3ifEF7sdAKJbGuPlMj260vsmcKHZvVannha3884V7a6rw2uD8Xar9lpNQCbQMfVZDLm97fw73UqT+wljxv4WdDg02bMaTHlNV4QCzoNE2vW86NzAxn0ySw+yjuHs8c3sLJUl0DV+6V5YWHSHv7tDbQtNtPO7ePJxXYCquETnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327031; c=relaxed/simple;
	bh=jHLS81rl/sS+VgJpeb10j25BNeO8RjKsK0URSHtjt7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bmv5dUj4FshypZ0i2PPUrY+F+Y0RuLWjUpNVAFuBxjSYcwFzZ3Jt6hHD2sV+//ToRH2ZxR1O+FQKScOsa3Yf6D1xBG/dS5FanXK+dMuqiUd5IMIQHupYohNA2RpvDprMMHImuxVce3ZTw9sFHS7FNV53d9NPJz+7P5X1QZ6D3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZsqMrOW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZsqMrOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51601F00893;
	Mon,  1 Jun 2026 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780327028;
	bh=+pzhjFbS2YQY7uayiNTHp0wlMBi8+qw4VxFSL3S50i8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FZsqMrOWOoIxhKYYEMqQc3GUCQkAxTI9NQ4/7iF6qRj9CB4aVyX4GKXzge323aAaQ
	 4vAplrHIBIDH/hs4UleBLwp8XCAEAi7GyQAZIeO11T32WyCsGeySMpC9Jf6vN9bgdv
	 IDRH4H4miefm9gGOCV8amrkBgMfcNt0J7suXjuYfri7aYitIsZuHWMq9kBpo1rMgN9
	 b9xI2q+6ftOmfDb+PAWMn3FinrWlZdbcNXkPWRh/nD3VeiekwE1nv+PmC6j/K8dz/x
	 jw2SkXuQCV/v+Lo9otnlDxduBC1FUbpIxvy6ulJkn4kW8Da40w7YmBQjHj+OSBsaUt
	 K0CY+keKVzziQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260601150203.20352-2-leon.hwang@linux.dev>
References: <20260601150203.20352-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 15:17:07 +0000
Message-Id: <20260601151707.C51601F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Time-of-Check to Time-of-Use (TOCTOU) vulnerability in transport h=
eader offset calculation leads to out-of-bounds write.

Pre-existing issues:
- [Critical] Missing validation of `iph->ihl >=3D 5` allows unprivileged BP=
F programs to trigger a kernel panic in `ip_fast_csum`.
--

commit 0be2d8b388e17b2000afd2e38ff89f5f956084ae
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Update transport_header when encapsulating UDP tunnel in lwt

This commit updates bpf_lwt_push_ip_encap() to set the skb transport
header whenever the encapsulated packet uses UDP. This ensures that
drivers relying on the transport header for hardware checksum offload
do not drop packets due to incorrect checksums.

Cc: Leon Hwang <leon.huangfu@shopee.com>

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d3..65d1dfbf3312b 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -612,10 +613,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void=
 *hdr, u32 len, bool ingress)
>  		ipv4 =3D true;
>  		if (unlikely(len < iph->ihl * 4))
>  			return -EINVAL;

[Severity: Critical]
This is a pre-existing issue, but does this code properly validate the
minimum IPv4 header length?

Because len is an unsigned u32, if a BPF program provides a buffer where
iph->ihl is 0, iph->ihl * 4 will be 0. Since len < 0 is never true, the
check trivially passes without returning -EINVAL.

Later in the function, ip_fast_csum() is called with iph->ihl. On some
architectures (like PowerPC and MIPS), the ip_fast_csum() implementation
assumes ihl >=3D 5 and subtracts from it, causing an integer underflow in t=
he
loop counter that leads to a deterministic kernel panic.

Should there be an explicit check that enforces iph->ihl >=3D 5 before the
length calculation?

> +		is_udp_tunnel =3D iph->protocol =3D=3D IPPROTO_UDP;
> +		if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + sizeof(struct udphd=
r)))
> +			return -EINVAL;
>  	} else if (iph->version =3D=3D 6) {

[ ... ]

> @@ -637,6 +644,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>  	if (ingress)
>  		skb_postpush_rcsum(skb, iph, len);
>  	skb_reset_network_header(skb);
> +	if (ipv4 && is_udp_tunnel)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + iph->ihl * 4);

[Severity: High]
Can iph->ihl change between the initial length validation and this call?

The hdr pointer (and thus iph) points to a buffer provided by the BPF
program, which might be concurrently modified by userspace via a shared
BPF map. Because skb_cow_head() acts as a compiler barrier, the compiler
will reload iph->ihl from this untrusted memory here.

If it is concurrently changed to a larger value (like 15) after the initial
validation, the transport header offset could be set beyond the end of the
SKB data (skb->tail).

Could this lead to out-of-bounds memory writes when network drivers later
dereference this transport header to update checksums?

> +	else if (!ipv4 && is_udp_tunnel)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + sizeof(struct =
ipv6hdr));
>  	memcpy(skb_network_header(skb), hdr, len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601150203.2035=
2-1-leon.hwang@linux.dev?part=3D1
