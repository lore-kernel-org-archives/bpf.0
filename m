Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D236AB47
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070772; cv=none; b=Yd1aS8sbwVkR26fomxUVyHo1yXfobrDzFiz5WERvvUH9zucFJvhp8zeWa9KX9SxNgvBuTSGEemuetcWGTGzbsVFcbFOhx0K5QHq18wF7FkvUwlAUJcsmQ93dBV5uyIPZJyznHsqLuFCe/XuIu4Y211llOHAwS7Pf1JyrQrwH/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070772; c=relaxed/simple;
	bh=hFYAk/q0DhQWpscGa8iRn6/IDDXCD5Mtv61fypvOzzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mqIWpI5X68gGJM2wc1M+25jzBDjYmW36E60XfnyZZkCKvm/sT4sAuTF5cfHa0PW1lp1b0gJwXRkBV6GCxgxwMcHOh6E44pjd9jzLFK6jlOrEgup7C5/oAUHVO+6tkLDXTNRjrMvrZXbROtIoj4xiVnunPJfvSeE6GqasCfejGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pyg52LWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pyg52LWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DDD1F00893;
	Fri, 29 May 2026 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780070771;
	bh=mqZ2Z4poqM3uAKVXX0FcqYLV7l5Btbfxe/6SLkVraIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pyg52LWfCII8j8Gev/wyBHU8pAxtWx5NMYslM2QtifV91BgiwzO8IWn58zLTGb0bD
	 zLNvwHwYNlaT+YZxVQyhv/U8CrkdKRtdK1bRMZU27A+KHxIkJSq3+SlMbHl7jjnnBB
	 Bv6OZspdPTKjVDUy7cPgt3Y69gLOHxjqmwHBOTiPLyVMXitlxE3GJNH9GmnqbBpMBP
	 eJiVPWBBhPBYKLW159/5kL6RtQlQdq88stGf0hA2BErD2G5YT9+gcpYO2HPZNxrcA+
	 LWvNrS0CB9S0h6zdgSTejUiB1FezYQLzH2pyv7IGXpak1WVO2T4Ih/+bIu3bqE31Qe
	 //Gof/MQLPdng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/4] bpf: Add check iph->ihl < 5 in lwt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529151351.69911-3-leon.hwang@linux.dev>
References: <20260529151351.69911-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 16:06:10 +0000
Message-Id: <20260529160610.E9DDD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_lwt_push_ip_encap updates skb->csum incorrectly for CHECKSUM_C=
OMPLETE packets by calling skb_postpush_rcsum() before calculating the IP h=
eader checksum.
- [High] handle_gso_encap() hardcodes the inner IPv4 header length to 20 by=
tes, ignoring IP options, which leads to reading garbage data as transport =
headers.
--

commit f2ce106c7be32fdcff1b6d3eb89a4fe4496a86d1
Author: Leon Hwang <leon.hwang@linux.dev>
Subject: bpf: Add check iph->ihl < 5 in lwt

This commit adds a validation check for the IP header length (ihl) in the B=
PF
lightweight tunnel IP encapsulation path. It ensures that the header length=
 is
at least 5 (20 bytes) to prevent an infinite loop in ip_fast_csum() on cert=
ain
architectures like MIPS.

Link: https://lore.kernel.org/bpf/20260525150010.CDEBA1F000E9@smtp.kernel.o=
rg/

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index 8009e427851f1..c306120e11d29 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -613,7 +613,7 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *=
hdr, u32 len, bool ingress)
>  	iph =3D (struct iphdr *)buff;
>  	if (iph->version =3D=3D 4) {
>  		ipv4 =3D true;
> -		if (unlikely(len < iph->ihl * 4))
> +		if (unlikely(iph->ihl < 5 || len < iph->ihl * 4))

[Severity: High]
This isn't a bug introduced by this patch, but since we are validating the =
IP
header here, could this lead to an incorrect skb->csum for CHECKSUM_COMPLETE
packets later in this function?

When a BPF program leaves iph->check =3D 0, skb_postpush_rcsum() is called:

    if (ingress)
        skb_postpush_rcsum(skb, iph, len);

This calculates the partial checksum of the IP header and adds it to
skb->csum. Later, the correct checksum is calculated and overwrites
iph->check:

    if (!iph->check)
        iph->check =3D ip_fast_csum((unsigned char *)iph, iph->ihl);

However, skb->csum is not updated to reflect this modification. Because a
valid IP header's checksum zeroes out its 16-bit one's complement sum, does
the addition in skb_postpush_rcsum() incorrectly add the header's
unchecksummed sum to skb->csum, causing packets to fail CHECKSUM_COMPLETE
validation and drop?

[Severity: High]
This is a pre-existing issue, but since this patch explicitly permits IP
headers with options (where iph->ihl > 5), does handle_gso_encap() handle
them correctly at the end of this function?

If the packet requires GSO, handle_gso_encap() hardcodes the IPv4 header
length to 20 bytes:

net/core/lwt_bpf.c:handle_gso_encap() {
    ...
    next_hdr_offset =3D sizeof(struct iphdr);
    ...
}

If IP options are present, won't handle_gso_encap() mistakenly read the IP
options as the transport header's protocol flags (e.g., GRE flags or UDP
checksum)?=20

Will this misconfigure GSO and result in corrupted segmented packets or
hardware drops?

>  			return -EINVAL;
>  	} else if (iph->version =3D=3D 6) {
>  		ipv4 =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529151351.6991=
1-1-leon.hwang@linux.dev?part=3D2
