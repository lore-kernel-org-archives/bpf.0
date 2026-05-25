Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E074383300
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721212; cv=none; b=R7+POPvaC3MWZzjVztam7KBWEYwOo+ovMwFPnmVKR5NhH3aXimI2G86FBDluPnGuWRWDnpA3v33FJuwjQCppUR57RqbsDJq55wIFhnWDt06RRrbLh+uzc0bkl6iSjJoPDT50060HmUWdnYX2esezYxj+EMAg+4pzbo0ULJ/jRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721212; c=relaxed/simple;
	bh=XDLIvVcq4aU4ZTw1xFyBNKetOM5RndV1+5BVRwFcPPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jkWwUNOrmLiq/YoDdU54iMog+6A+4DuQuPi3fIROJZtPTkxbsyzjEUXNe/0czKnPv7y0hfyxKk4Ye4rxXDM03S1AV08bi+96HQRKeaDGD5lu0P2DHV5YJ+0DdVOtOiYVvQRpLWpwC+u7nrdMp1lh3oRN3tyn5m/ZSoKjKhvGwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDcMhMdP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDcMhMdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEBA1F000E9;
	Mon, 25 May 2026 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779721210;
	bh=NLSe4ollmpJcBpca83Nfv+W2v4klhQgVzHZZ6SkuK8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mDcMhMdP1UjEM8tSuhwki/Yk0aK82Me1anR/OYuCnNG8nJlcSxnCKywZA2w/OBsoO
	 G4YkgOZUuVAuRRZTyHwa4iLGvbkklBfwjQEYCmpRe10/DLBzIXr0/nC+MxYRchLZNs
	 0OM+u6jQi+mOGADQC/a9oIQoJXpZUVJB6zgBXQ/Dperna1bTw2Q9aJWqf62JK76876
	 szLBSQ8XitP86s5SUd4HJs2qRfHqoN5do294scyEhHXuuGH1K9nJEoFbPVyB0WNpPB
	 xVipA2l9A+Wtxphderq9C+iCBazofAI4/gAASYU6TnrY3USTLG00lbWuUZDDlseSd7
	 W2qUqTxQmEAsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Update transport_header when encapsulating
 UDP tunnel in lwt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260525142650.2569-2-leon.hwang@linux.dev>
References: <20260525142650.2569-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 15:00:10 +0000
Message-Id: <20260525150010.CDEBA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition exists due =
to reading header fields directly from the mutable BPF-provided buffer afte=
r length validation.
- [Medium] The transport header is updated without verifying that the packe=
t length actually contains the full UDP header.

Pre-existing issues:
- [Critical] Missing validation for the minimum IPv4 header length (iph->ih=
l >=3D 5) before calling ip_fast_csum() can cause a kernel panic.
--

commit 957c78832bf7e636702330e3ec4773ffefe95be0
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Update transport_header when encapsulating UDP tunnel in lwt

Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
When a driver reuses the stale skb->transport_header to offload checksum
computation to NIC hardware, VxLAN packets encapsulated by
bpf_lwt_push_encap() may be dropped due to incorrect checksum. This patch
updates skb->transport_header in bpf_lwt_push_ip_encap() whenever the
encapsulated packet uses UDP.

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d3..cbb2803367c6d 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -637,6 +637,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>  	if (ingress)
>  		skb_postpush_rcsum(skb, iph, len);
>  	skb_reset_network_header(skb);
> +	if (ipv4 && iph->protocol =3D=3D IPPROTO_UDP /* UDP tunnel */)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + iph->ihl * 4);

[Severity: High]
Can a concurrent modification to the BPF-provided header cause an
out-of-bounds transport header offset?

The hdr pointer passed to bpf_lwt_push_ip_encap() can point to concurrently
mutable memory such as a BPF map value. Reading iph->protocol and iph->ihl
directly from hdr here, after length validation has already occurred,
appears to introduce a Time-of-Check to Time-of-Use race condition.

If a concurrent modification changes iph->ihl, the calculated transport
header could point well past the end of the pushed IP header. For small
SKBs, this could cause skb_transport_header to point out-of-bounds into
skb_shared_info.

Would it be safer to perform these reads after copying the header into the
SKB, using the copied, stable values instead?

[Severity: Critical]
This is a pre-existing issue and was not introduced by the patch under
review, but is there a missing validation for the minimum IPv4 header
length before ip_fast_csum() is called?

Earlier in the function, the length validation checks:

    if (unlikely(len < iph->ihl * 4))
        return -EINVAL;

If a BPF program provides an IP header with ihl =3D 0, the check len < 0
evaluates to false because len is at least 20.

Later, ip_fast_csum() is called with ihl =3D 0. On architectures like MIPS,
the ip_fast_csum() implementation reads 16 bytes and then uses a loop:

    do { ... word++ } while (word !=3D stop);

where stop =3D iph + ihl. If ihl =3D 0, stop is physically behind word,
causing the loop to endlessly increment through the address space until
it page faults.

Does this code need a check to ensure iph->ihl >=3D 5?

[Severity: Medium]
Does this code verify that the packet length actually contains the full UDP
header?

This updates the transport header for UDP tunnels based solely on the IP
protocol, but it doesn't seem to validate that len actually encompasses
the full struct udphdr.

If an IP header is pushed with IPPROTO_UDP but a truncated length (like
len =3D 20), the transport header is set to the end of the IP header. A NIC
driver might then attempt to parse the subsequent memory as a UDP header,
which could lead to broken offloads or out-of-bounds reads.

> +	else if (!ipv4 && ((struct ipv6hdr *)hdr)->nexthdr =3D=3D NEXTHDR_UDP /=
* UDP tunnel */)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + sizeof(struct =
ipv6hdr));
>  	memcpy(skb_network_header(skb), hdr, len);
>  	bpf_compute_data_pointers(skb);
>  	skb_clear_hash(skb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525142650.2569=
-1-leon.hwang@linux.dev?part=3D1
