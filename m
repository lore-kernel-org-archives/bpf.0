Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451DD37C904
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776343405; cv=none; b=OL5xFZgJMiMqFDSIotem2IVSk+aYv7HCvKMf02JeTmAoFVbZUparLKZtcLDtvP6qAwdSakVU/RTGLGLvnR0LoGtM0saoPD8v3KDR9X4kFyXQxDzH9xJvWzvJFUmhCRqNgRTdV7x5mI7DCkbDehVaoDoD4re0dwIkY/IPFnVpxL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776343405; c=relaxed/simple;
	bh=Qi1pNaunXloa1fPbKqIcVElwKPaahyRSQcOfK0ngHOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I9Yw4dw9oo5f/CCLfPNe9sbqbhQkgfN25+aFU33uFim/AyVn+OXc6jXgwvPDJBQrBFZcNZzoPkpF9xvWsn07sRUiHVSYiw5ME2gg6ajqzTEMgtRgN/jV9QzB9mIgwW+mjOl1sjTKA+zhLnB6HJ/uwau7q8HB7M1mzc2qyBoaamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlkcZbkO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlkcZbkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CE6C2BCAF;
	Thu, 16 Apr 2026 12:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776343404;
	bh=Qi1pNaunXloa1fPbKqIcVElwKPaahyRSQcOfK0ngHOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DlkcZbkOvf1AG9VFoBx3TXE+0z1CAbl2UngNVg+RulNua6EBrFxpE2Z3c5ZMvB4TO
	 4zJughGtpcK1T2ISY9HsxNtoyb5AW5TEYj8dMor6q5dIKofNMskSI9JKeLUTOn7us6
	 WmlGXlB03L6x6LGJEZlOkvsxWCSZ6yUzfaA6Ma04HnT5DP4kdA34WgR6zv+kzPB3R2
	 DFwUnp2Fod8KTlc5u5uZ6f7HiUAnBUE/7ihV5deMcOEb4d+gtM7w4O8xQjCu0/OI5R
	 vONabBKyNdxwsAb7p2Q67AA4nEEsSjaTTk17bQXEp8GfoSk8qTLqyZRXZM1YEaOnD4
	 l/luAAzZvdWAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: tc_tunnel validate decap
 GSO state
Reply-To: sashiko@lists.linux.dev
To: "Nick Hudson" <nhudson@akamai.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416075514.927101-7-nhudson@akamai.com>
References: <20260416075514.927101-7-nhudson@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 12:43:24 +0000
Message-Id: <20260416124324.B0CE6C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] The test's definition of SKB_GSO_UDP_TUNNEL_MASK incorrectly inc=
ludes SKB_GSO_TUNNEL_REMCSUM, causing a semantic mismatch with the kernel's=
 bpf_skb_net_shrink() implementation and false failures on REMCSUM packets.
- [Medium] The assertions for IPXIP4/IPXIP6 GSO flag clearance and encapsul=
ation state are unreachable dead code because the test never sets the BPF_F=
_ADJ_ROOM_DECAP_IPXIP4 or BPF_F_ADJ_ROOM_DECAP_IPXIP6 flags.
- [Low] Invalid pointer arithmetic (`kskb->head + kskb->end`) causes a comp=
ilation failure on 32-bit architectures.
--

commit 8a46b3df0c44611594d9db9e0db3c3d027d83a7d
Author: Nick Hudson <nhudson@akamai.com>

selftests/bpf: tc_tunnel validate decap GSO state

Require BPF_F_ADJ_ROOM_DECAP_L4_UDP and BPF_F_ADJ_ROOM_DECAP_L4_GRE enum
values at runtime using CO-RE enum existence checks so missing kernel
support fails fast instead of silently proceeding.

After bpf_skb_adjust_room() decapsulation, inspect skb_shared_info and
sk_buff state for GSO packets and assert that the expected tunnel GSO
bits are cleared and encapsulation matches the remaining tunnel state.

> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/t=
esting/selftests/bpf/progs/test_tc_tunnel.c
> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> @@ -37,6 +38,23 @@ struct vxlanhdr___local {
> =20
>  #define	EXTPROTO_VXLAN	0x1
> =20
> +#define SKB_GSO_UDP_TUNNEL_MASK	(SKB_GSO_UDP_TUNNEL |			\
> +				 SKB_GSO_UDP_TUNNEL_CSUM |		\
> +				 SKB_GSO_TUNNEL_REMCSUM)

Does this mask incorrectly include SKB_GSO_TUNNEL_REMCSUM?

The kernel's bpf_skb_net_shrink() implementation intentionally does not cle=
ar
SKB_GSO_TUNNEL_REMCSUM when processing BPF_F_ADJ_ROOM_DECAP_L4_UDP. If a
packet with REMCSUM is processed, won't this cause a spurious test failure
when the test later checks (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK)?

[ ... ]
> @@ -655,6 +684,35 @@ static int decap_internal(struct __sk_buff *skb, int=
 off, int len, char proto)
>  	if (bpf_skb_adjust_room(skb, -olen, BPF_ADJ_ROOM_MAC, flags))
>  		return TC_ACT_SHOT;
> =20
> +	kskb =3D bpf_cast_to_kern_ctx(skb);
> +	shinfo =3D bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info=
);

Will this cause a compilation failure on 32-bit architectures?

On 32-bit architectures without NET_SKBUFF_DATA_USES_OFFSET, sk_buff::end
is defined as a pointer (unsigned char *) rather than an offset. Adding two
pointers is an invalid operation in C and will result in a build error.

> +	if (!shinfo->gso_size)
> +		return TC_ACT_OK;
> +
> +	if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +	    (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
> +		return TC_ACT_SHOT;
> +
> +	if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> +	    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> +		return TC_ACT_SHOT;
> +
> +	if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> +	    (shinfo->gso_type & SKB_GSO_IPXIP4))
> +		return TC_ACT_SHOT;
> +
> +	if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> +	    (shinfo->gso_type & SKB_GSO_IPXIP6))
> +		return TC_ACT_SHOT;

Are these conditions unreachable?

Looking earlier in decap_internal(), for IPPROTO_IPIP and IPPROTO_IPV6, only
BPF_F_ADJ_ROOM_DECAP_L3_IPV4 and BPF_F_ADJ_ROOM_DECAP_L3_IPV6 are set on the
flags variable.

Because BPF_F_ADJ_ROOM_DECAP_IPXIP4 and BPF_F_ADJ_ROOM_DECAP_IPXIP6 are
never added to flags, this IPXIP GSO validation block and the subsequent
encapsulation validation appear to be bypassed entirely.

> +	if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +		     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
> +		if ((shinfo->gso_type & SKB_GSO_TUNNEL_MASK) && !kskb->encapsulation)
> +			return TC_ACT_SHOT;
> +		if (!(shinfo->gso_type & SKB_GSO_TUNNEL_MASK) && kskb->encapsulation)
> +			return TC_ACT_SHOT;
> +	}
> +
>  	return TC_ACT_OK;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416075514.9271=
01-1-nhudson@akamai.com?part=3D6
