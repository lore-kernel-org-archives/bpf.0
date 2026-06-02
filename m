Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A63CE4B2
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413838; cv=none; b=CKqj7HdCDnJNT8Q7rNgcSYsuaLFPj1xBxtIJBUHFbiaQnTVMigKAi3YFWqmTDjRUeAbBsUfOksqrM8LMAK+J4MUpQZmlDZpexkmx27SUDSpmRzwwYypjsIkgz7bqqkzZ5e3o565lm4Npu9Y7ngUiB/hjKS4bBoFSXnluics3Ba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413838; c=relaxed/simple;
	bh=ITxvei3a+lBmIZMqHKJACznJHIsyapNzKtdqDOvUjrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mMmCYW3+0gEBF/Y+c9rXPAEuO9kYDIKt9dLWmNWYvlibeHA0vvt463NsXQTFXq1UHbBWM0gdcUpVUEM7rnNejXwdE1nEREeMyKla6y5QoHpVxzpkAgGOpEiWVxjcEAPQmj2oFJA3jZqys4a1mav0nHiSGCy0bzfMybi/KbAHShY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVlYOr/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVlYOr/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87F11F00893;
	Tue,  2 Jun 2026 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780413837;
	bh=yA8yl3yez+gnnqtbym4KAizNa6bFJXaEthT4CA7Hijg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EVlYOr/79/qFv7SxVN6oEa5wB1rrHOmK5OkJj34Y0u5cndfEy0ISaNfheaMIBbv4m
	 c6/Doy4vrbk+FPb8lvMuiKy6TfyKEVLGXyRV57mwnzsXhnojrqxb4fwA7VgBG3Pwc7
	 mBnECz5cahHHVVXiZplWndge5f2LfIuBDDCRqO6RVAgWOQ/FaWy12l254CmZvg6zmr
	 WvS4bXLTiD4PPrIjHb91x8Up3nTJkaljVyxgXbJR/WpbtNw/3M8pkt3aEU70ZkhWaO
	 zo819NLcXZoj1M06tnhhslHDIHHJK8BAMW/NG/5+/mPZD+d99ddqWyRE7k7QfvU0Ft
	 QpZ+tio4isWtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 1/2] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602150931.49629-2-leon.hwang@linux.dev>
References: <20260602150931.49629-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:23:56 +0000
Message-Id: <20260602152356.C87F11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing IPv4 header length (`ihl`) minimum bounds check in `bpf_lw=
t_push_ip_encap` allows denial of service via `ip_fast_csum`.
- [High] Time-of-Check to Time-of-Use (TOCTOU) vulnerability in `bpf_lwt_pu=
sh_ip_encap` due to re-reading from eBPF map memory.
--

commit 8004c2f9aa8d7cbb7b762ab79a4e3272c20af453
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Update transport_header when encapsulating UDP tunnel in lwt

This commit updates skb->transport_header in bpf_lwt_push_ip_encap() when
encapsulating a packet that uses UDP. This ensures that checksum offloading
works correctly when a driver reuses the transport header.

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d3..bf588f508b79e 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -612,10 +613,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void=
 *hdr, u32 len, bool ingress)
>  		ipv4 =3D true;
>  		if (unlikely(len < iph->ihl * 4))
>  			return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does bpf_lwt_push_ip_encap() need to veri=
fy
that iph->ihl is at least 5?

An eBPF program can pass an IPv4 header with ihl =3D 0 and len =3D 20. This
bypasses the length validation because 20 < 0 is false. Later in the functi=
on,
this unvalidated ihl is passed to ip_fast_csum(iph, iph->ihl) with a length
of 0. On architectures like MIPS and PowerPC, could this cause the
ip_fast_csum implementation to blindly decrement or loop until reaching the
end pointer, triggering an infinite loop or kernel panic?

[Severity: High]
This isn't a bug introduced by this patch, but could this validation suffer
from a Time-of-Check to Time-of-Use (TOCTOU) race?

The hdr argument can point to mutable eBPF map memory. A concurrent
modification by userspace or another CPU could alter iph->ihl between this
validation and its later uses. For example, if iph->ihl is mutated to 0 aft=
er
this check, it bypasses validation and the subsequent memcpy() copies the
mutated ihl to the SKB, leading to the same ip_fast_csum() kernel panic
described above.

Should the function copy the header into a local stack buffer or the SKB
first, and then perform all validations on that immutable copy?

> +		is_udp_tunnel =3D iph->protocol =3D=3D IPPROTO_UDP;
> +		if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + sizeof(struct udphd=
r)))
> +			return -EINVAL;
>  	} else if (iph->version =3D=3D 6) {

[ ... ]

> @@ -637,6 +644,11 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>  	if (ingress)
>  		skb_postpush_rcsum(skb, iph, len);
>  	skb_reset_network_header(skb);
> +	if (is_udp_tunnel) {
> +		size_t iph_sz =3D ipv4 ? iph->ihl * 4 : sizeof(struct ipv6hdr);
> +
> +		skb_set_transport_header(skb, skb_network_offset(skb) + iph_sz);
> +	}

[Severity: High]
This is a pre-existing issue, but does this newly added code introduce an
additional TOCTOU race by re-reading iph->ihl?

Because iph->ihl is read again here from mutable eBPF map memory to calcula=
te
iph_sz, a concurrent modification could result in an incorrect size calcula=
tion.
Could this allow skb_set_transport_header() to be set to a malicious
out-of-bounds offset?

>  	memcpy(skb_network_header(skb), hdr, len);
>  	bpf_compute_data_pointers(skb);
>  	skb_clear_hash(skb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602150931.4962=
9-1-leon.hwang@linux.dev?part=3D1
