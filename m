Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3213F1FDA61
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974365; cv=none; b=ls4E0UAvWjLD28Wssh8d3V/SOOqZnTKGeH+BR4jRfaw61yrrjU/Zblc6IF2dwOdd7W56iQetaTyR22hqY94/pQhnjRR8j29d0Yw8ZVyY/PcW5knIqFfYc1QSKY1VztNqMJZQNmjvgHdCtWfJIVZZSm7noV6F2UCKGMjNbmhiMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974365; c=relaxed/simple;
	bh=L8f7fIFMUWeTKAulMy9VC73H6Y5kfiBzTTyuMXylsXc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=touUX+Al0NtUgO71rpr3YwWR7WskvswKG/Ne2FRrWyPg8IzuIjKm8MrMsdb3ZD0Bw30ujGXMFh9AJL7zyx/H3xrKNh0XVA8fTdACRCKQ+YfjjhaAYUPNdd9BYOAZanDSjku1uPQygMe3y9wNTiOBlyKmgQcpCL7fKDYr09uMsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJvFLIrp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJvFLIrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8BB1F000FF;
	Wed, 14 Oct 2026 10:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791974363;
	bh=SfQToFvXazNbxq2C59xH0F9QTETRf74jP+goHD0KMKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BJvFLIrpX6f+upblwXacCdQFYRUxR7fScV0IqnhUTe1QBlVAj7ftXiPIaYvBAzB3q
	 85asus04sHg4/dTaScYUsoo4WJAb31Ww7BFl66cFkMvrgP4Bkf7x9xIVHTIIJ7SvTt
	 gRdYGY2jzC4hRvJXEy5cQiJbI7mT7CEfwgQ4QrJElfOZniAcfmLBMS7y16KaubmvjQ
	 o1VDb5GR2NvW6LDohhGLETRRLKNbqNfCb04sDlN2rnH7clkFf2tpwoEwL/zsFCjS7o
	 xSAJpOvQAqfOMWztUD2dHtu84hA+UMETdZ+9ZOnZe5AUIcG2pr2+ZGaa34vnakVme/
	 SLfO1hyzww5Vw==
Message-ID: <sashiko-outbox-171146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 2/4] tcp: add BPF_SOCK_OPS_TCP_TS_ID_CB to
 assign a TSval identifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Willem Ferguson" <wferguson@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261013103906.2660384-3-wferguson@cloudflare.com>
References: <20261013103906.2660384-1-wferguson@cloudflare.com>
 <20261013103906.2660384-3-wferguson@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 10:39:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: bpf_load_hdr_opt() returns -EOPNOTSUPP for BPF_SOCK_OPS_TCP=
_TS_ID_CB
- [Low] bpf: UAPI multi-line comments violate subsystem guidelines
--

commit 5e1ec68deb60daa79748ce9bcb640700acc7dd70
Author: Willem Ferguson <wferguson@cloudflare.com>
   =20
tcp: add BPF_SOCK_OPS_TCP_TS_ID_CB to assign a TSval identifier
   =20
Let a sock_ops program pick the identifier that the previous patch
encodes in the low bits of TSval, for passively opened connections.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 732b35cc08d1c..b440a3fd96d0e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
[ ... ]
> @@ -7137,8 +7138,12 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
> +	/* Call bpf to select a TCP timestamp connection ID for a passive
> +	 * connection before sending the SYN-ACK.
> +	 */
> +	BPF_SOCK_OPS_TCP_TS_ID_CB_FLAG =3D (1 << 7),

[Severity: Low]
Does this multi-line comment violate the BPF subsystem guidelines?
The guidelines strictly require multi-line comments to have the opening /* =
on
its own line, with the comment text starting on the next line.

>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0xFF,
>  };
> =20
>  enum {
> @@ -7282,6 +7287,14 @@ enum {
>  					 * sendmsg timestamp with corresponding
>  					 * tskey.
>  					 */
> +	BPF_SOCK_OPS_TCP_TS_ID_CB,	/* Called after a passive SYN created a
> +					 * request socket and before the SYN-ACK is
> +					 * sent. Not called for SYN cookies. Arg2 is
> +					 * the number of low timestamp bits available
> +					 * for an identifier. Set reply to an identifier
> +					 * that fits in Arg2 bits. Replies are ignored
> +					 * for usec timestamps.
> +					 */

[Severity: Low]
Similar to the above, does this multi-line comment violate the BPF subsystem
guidelines by starting text on the same line as the opening /*?

[Severity: Medium]
The commit message claims that the BPF program can use bpf_load_hdr_opt() to
inspect the incoming SYN packet during the BPF_SOCK_OPS_TCP_TS_ID_CB callba=
ck.

However, the backing kernel helper bpf_sock_ops_load_hdr_opt() restricts ac=
cess
by calling is_locked_tcp_sock_ops():

net/core/filter.c:is_locked_tcp_sock_ops() {
	return bpf_sock->op <=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
}

Because BPF_SOCK_OPS_TCP_TS_ID_CB is appended to the bpf_sock_ops enum here=
, it
has a higher integer value than BPF_SOCK_OPS_WRITE_HDR_OPT_CB and fails this
check.

Does this cause bpf_load_hdr_opt() to unconditionally return -EOPNOTSUPP,
silently breaking the documented feature capability?

>  };
> =20
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013103906.2660=
384-1-wferguson@cloudflare.com?part=3D2
