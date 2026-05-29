Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26879368957
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069794; cv=none; b=ldEQfeiGC44pDYAGMS34qkpPoHif6dDhcI8866K7zczPu3BcfsVHfvpOddMfqFilmKlQPXhJbG18OjJ0bWLxiaK5EEl1dkJLytQkhZ7m8WJABEAzmzYlhjTUnYMz2rT2VB/ZpZfBnjxyyqFdbbf17o5w5zmtnXQUlDtjH2Ushn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069794; c=relaxed/simple;
	bh=Ht1uvcRHLGULqmXPNl5np8s6yiWfueuQza7yV1hZIPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ABvYjNCWsdfRGZ1PaXbtu4OAr6CCjpTllLvfeaa2NSfrtfVf/aQrAkpCR8uK3paRgcou0n6CblkgsnaGgKyMEW3wEZEBD6DHm3/w8NrRaP6ho+DDlIuAMBH+r3s/pUTPukZ/8nBMkVMSNv2KhSVqohFKas4VoyMrEn2Hzaw+yRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHoia5qV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHoia5qV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E271F00893;
	Fri, 29 May 2026 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780069792;
	bh=P7Mw5X7UE5PFNrBOrOZbnzXruOVFgd7W3/qM4q6iDGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YHoia5qVCAHzX0My2V9Oay3j743UDvxdPnkvee/amuUgr7iUdwSS/lp/HNOAw2gTF
	 yOW3fRVJMar6TFGP64zjox4sIbMfuObDbg/U0VLVvXtBE1AbPrPOEIkhcS14OyfWMa
	 T0DNvfvnMAl9Wph7vrHebCU3IU9XMh6ZhuUlmpI6znVrsMKMV47Oyi8sKBZd2Ddl2C
	 X4n00uPeHHXFdxEDcCEXx8VBg2/YY6JgO6R1TOOiVXimeGumMPVIN9f97BzqPJrpOw
	 DzZlaut5ofwcVT+osiaOxncrJt68aUsP19QxnpJzlvBcjEf+IMnWB6jtiS9fJTmvuT
	 bOs37veSBNd9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/4] bpf: Fix TOCTOU issue in lwt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529151351.69911-2-leon.hwang@linux.dev>
References: <20260529151351.69911-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 15:49:37 +0000
Message-Id: <20260529154937.E8E271F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Using plain `memcpy()` to read concurrently mutable BPF map memo=
ry causes a data race.

Pre-existing issues:
- [High] Modifying `iph->check` after `skb_postpush_rcsum()` corrupts `skb-=
>csum` for `CHECKSUM_COMPLETE` packets.
- [High] `handle_gso_encap()` hardcodes IPv4 header length to 20 bytes, ign=
oring IP options and leading to corrupted GSO parsing.
- [High] The pushed header length `len` is not validated for 4-byte alignme=
nt, causing unaligned memory accesses and kernel panics.
--

commit 9a2f99096b35970231963f30d1371e5ea1824572
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Fix TOCTOU issue in lwt

This commit fixes a TOCTOU issue where the header pointer passed to
bpf_lwt_push_ip_encap() could point to concurrently mutable memory like
a BPF map value. It resolves this by copying the header into a local
buffer before validating and pushing it.

Link: https://lore.kernel.org/bpf/20260525150010.CDEBA1F000E9@smtp.kernel.o=
rg/

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d3..8009e427851f1 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -599,6 +599,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool=
 ipv4, int encap_len)
> =20
>  int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool =
ingress)
>  {
> +	u8 buff[LWT_BPF_MAX_HEADROOM];
>  	struct iphdr *iph;
>  	bool ipv4;
>  	int err;
> @@ -606,8 +607,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>  	if (unlikely(len < sizeof(struct iphdr) || len > LWT_BPF_MAX_HEADROOM))
>  		return -EINVAL;
> =20

[Severity: High]
This is a pre-existing issue, but is it possible for the len argument to be
unaligned here? If len is not a multiple of 4 (e.g. 21 bytes), skb_push()
later will shift skb->data by len bytes, making skb->data unaligned.

When ip_fast_csum() is called, it performs 32-bit memory accesses on the
pointer. On architectures that do not support unaligned memory accesses
natively (like older ARM, MIPS, or SPARC), would this trigger a fatal
alignment exception and crash the kernel?

> +	memcpy(buff, hdr, len);

[Severity: Medium]
Since hdr can point to BPF map memory that is concurrently mutated by user
space or other CPUs, could this plain memcpy() cause a data race? The
compiler might emit multiple loads or tear the reads, potentially resulting
in an inconsistent header state and triggering KCSAN warnings.

Should data_race() or a lockless safe memory copy mechanism be used here?

> +
>  	/* validate protocol and length */
> -	iph =3D (struct iphdr *)hdr;
> +	iph =3D (struct iphdr *)buff;

[ ... ]

> @@ -637,7 +640,7 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *=
hdr, u32 len, bool ingress)
>  	if (ingress)
>  		skb_postpush_rcsum(skb, iph, len);
>  	skb_reset_network_header(skb);
> -	memcpy(skb_network_header(skb), hdr, len);
> +	memcpy(skb_network_header(skb), buff, len);
>  	bpf_compute_data_pointers(skb);
>  	skb_clear_hash(skb);

[Severity: High]
This isn't a bug introduced by this patch, but does modifying iph->check
after skb_postpush_rcsum() corrupt skb->csum for CHECKSUM_COMPLETE packets?

When an IPv4 header is pushed on an ingress packet, skb_postpush_rcsum()
adds the checksum of the pushed header to skb->csum. If the BPF program
provides an IP header with iph->check =3D=3D 0, skb->csum is updated using =
this
zeroed checksum.

Later in this function, we have:

	if (ipv4) {
		skb->protocol =3D htons(ETH_P_IP);
		iph =3D ip_hdr(skb);

		if (!iph->check)
			iph->check =3D ip_fast_csum((unsigned char *)iph,
						  iph->ihl);

This calculates and overwrites iph->check in the SKB, making the IP header
mathematically sum to 0. However, skb->csum is not updated to reflect this
modification, leaving it inflated by the partial sum of the IP header.

Could this break CHECKSUM_COMPLETE synchronization, causing valid packets to
be dropped later in the network stack?


[Severity: High]
This is a pre-existing issue, but does handle_gso_encap() properly handle
IPv4 headers with IP options?

At the end of bpf_lwt_push_ip_encap(), handle_gso_encap() is called:

	if (skb_is_gso(skb))
		return handle_gso_encap(skb, ipv4, len);

bpf_lwt_push_ip_encap() allows BPF programs to push IPv4 headers with IP
options (where iph->ihl > 5). However, if the packet is a GSO packet,
handle_gso_encap() hardcodes the IPv4 header length to sizeof(struct iphdr)
instead of using ip_hdr(skb)->ihl * 4.

Would this cause the function to point next_hdr into the middle of the IP
options rather than the encapsulated inner protocol header (e.g., GRE or
UDP), leading to corrupted GSO parsing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529151351.6991=
1-1-leon.hwang@linux.dev?part=3D1
