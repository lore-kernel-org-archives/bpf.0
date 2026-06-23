Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C528C874
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782258060; cv=none; b=H09nR3pa/72v+MRQHbwoE3yTVKp3V7BEdMdkRIKPaIeAl6BKw0H7gg6luJuzz2ejND2uDq8xa8zjqTB6CDtNyfO8YNRDxXlXPckH/3sMxNjxBRIBUC6hiGLWY8WESIIRGn/Mq016+svs1Pfz/YdP/E1wH1OhV0Nsmzcn25JPlwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782258060; c=relaxed/simple;
	bh=qiVK0E34mqnruXUYv4a/qcg+BCtkaDCQugkJTK56W5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k/ltaRfyGtSfMv9J/1px8IK73v/sTRu6QBYHQuUcMEgVUmCi1ck056aYuUHlXPpPhz1B+7sEavK9DHQ1DeMEJQMAlKQLWg9dJsr8Kvoqy/A6SHmxejAT1naes7jO1U5eI7IWbB2qxu/eduCGYCTqE/szi76Au1Lnx++YsnBFpXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZKDFtrp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZKDFtrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132101F000E9;
	Tue, 23 Jun 2026 23:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782258059;
	bh=tltvtaufnYpwCylMgGssnHjYt4vS62Sm+xqqPG/1NbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cZKDFtrpQsystduPj/++QOQ+gZHIO/6Rw+/8YENtdfS8XLKmEER0BLqVY5YyX8uv9
	 0evR5V3l9sku+0fT/gGsfHH8Lw7EgrdZiRdY2XCwqYiRZTkwf28AvpJdYTJGzJ6U1N
	 WlE8Y6S/e87blSOEQ3b3m1Pqr9UIFRZ5QNeQSN0YBlA5/g5bryN77fbv33Rwm9zSqz
	 N+2FPFNTIu6TS0Mihn3IM1/xA3Y+SdPxYP7N/7zL/wzA+QpRN37DlDzp8VehRDJTP0
	 snMJIl2rjDImiPu8UJap6qmXnxcp//S4CDybffz3eQhu2DiT2X/V5XKBWtdzgR+oYA
	 lDpecVpyUkIFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 12/15] bpf: tcp: Support parse/len/write
 header option hooks in bpf_tcp_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623175006.3136053-13-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
 <20260623175006.3136053-13-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 23:40:58 +0000
Message-Id: <20260623234059.132101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Incorrect pointer arithmetic on the BPF context array causes NULL =
pointer dereferences on 32-bit architectures.
- [High] A missing bounds check in TCP option parsing combined with a TOCTO=
U double-fetch allows a malicious BPF program to cause a heap buffer overfl=
ow.
- [Medium] The struct_ops TCP option reservation is gated by a completely u=
nrelated cgroup BPF static key, breaking the feature for established connec=
tions.
- [Low] Multi-line comments in BPF subsystem files violate the required com=
ment style.
--

commit d91122a96beff2abb78548435a7fd30a3c89c2ac
Author: Amery Hung <ameryhung@gmail.com>

Add the TCP header option callbacks to the bpf_tcp_ops struct_ops type

This patch exposes TCP header option callbacks as struct_ops members to
allow BPF programs to parse, reserve, and write TCP header options. It
mirrors the legacy BPF_SOCK_OPS callbacks and shares the reserved window.

> The hdr_opt_len fast path in tcp_established_options() is gated by
> cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS). Note this is a global,
> per-attach-type static branch: it is enabled whenever any bpf_tcp_ops is
> attached, even one that does not implement hdr_opt_len or that is attached
> to a different cgroup.

[Severity: Medium]
Is this description accurate? Struct_ops do not enable this cgroup static
key. Will this check evaluate to false in non-cgroup-bpf deployments,
skipping space reservation for established connections but still calling
write_hdr_opt later?

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
[ ... ]
> @@ -3005,6 +3005,45 @@ struct bpf_tcp_ops {
> =20
>  	/* Called on listen(2), right after the socket enters TCP_LISTEN. */
>  	void (*listen)(struct sock *sk);
> +
[Severity: Low]
This isn't a bug, but does the BPF subsystem prefer the opening /* to be on
its own line for multi-line comments?

> +	/* Parse the TCP header options of an incoming skb received on an
> +	 * established connection. Use bpf_dynptr_from_skb()/bpf_skb_load_bytes=
()
> +	 * to access the options.
> +	 */
> +	void (*parse_hdr)(struct sock *sk, struct sk_buff *skb);
> +
[ ... ]
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
[ ... ]
> @@ -66,6 +87,99 @@ static struct bpf_tcp_ops __bpf_tcp_ops =3D {
>  	.retrans =3D retrans_stub,
>  	.connect =3D connect_stub,
>  	.listen =3D listen_stub,
> +	.parse_hdr =3D parse_hdr_stub,
> +	.hdr_opt_len =3D hdr_opt_len_stub,
> +	.write_hdr_opt =3D write_hdr_opt_stub,
> +};
> +
> +BPF_CALL_4(bpf_tcp_ops_store_hdr_opt, void *, ctx, const void *, from,
> +	   u32, len, u64, flags)
> +{
[Severity: High]
Can this pointer cast lead to reading the wrong offset on 32-bit systems?
The ctx array contains 64-bit integers, so casting directly to a pointer
array might result in reading the upper 32 bits (which are zero) on
little-endian architectures, causing a NULL pointer dereference.

> +	struct sk_buff *skb =3D ((struct sk_buff **)ctx)[1];
> +	struct bpf_sock_ops_kern sock_ops =3D {};
> +	u32 opt_off =3D ((u64 *)ctx)[5];
> +	u8 *op, *opend;
> +
[Severity: Low]
This isn't a bug, but multi-line comments in the BPF subsystem typically
place the opening /* on a separate line.

> +	/* bpf_tcp_ops does not keep track of the end of the written TCP header
> +	 * options, so search for it every time the helper is called. The free
> +	 * space is NOP-filled, so a TCPOPT_NOP ends the search rather than bei=
ng
> +	 * skipped as in a normal option walk in sockops.
> +	 */
> +	op =3D skb->data + opt_off;
> +	opend =3D skb->data + tcp_hdrlen(skb);
> +	while (op < opend && *op !=3D TCPOPT_NOP) {
[Severity: High]
Does this loop prevent op from advancing past opend if the option length
byte is forged? If op[1] is maliciously modified concurrently in the BPF
map memory before __bpf_sock_ops_store_hdr_opt() does its memcpy, could
the next call to bpf_tcp_ops_store_hdr_opt() advance op past opend and
cause an out-of-bounds memcpy?

> +		if (*op =3D=3D TCPOPT_EOL || op + 1 >=3D opend || op[1] < 2)
> +			break;
> +		op +=3D op[1];
> +	}
> +
> +	sock_ops.skb =3D skb;
> +	sock_ops.skb_data_end =3D op;
> +	sock_ops.remaining_opt_len =3D opend - op;
> +
> +	return __bpf_sock_ops_store_hdr_opt(&sock_ops, from, len, flags);
> +}
[ ... ]
> +BPF_CALL_4(bpf_tcp_ops_load_hdr_opt, void *, ctx, void *, search_res,
> +	   u32, len, u64, flags)
> +{
[Severity: High]
Will this cast misalign the array index on 32-bit architectures? Treating
the 64-bit integer array as an array of 32-bit pointers will cause the
wrong bytes to be read for the context argument.

> +	struct sk_buff *skb =3D ((struct sk_buff **)ctx)[1];
> +	struct bpf_sock_ops_kern sock_ops =3D {};
[ ... ]
> +BPF_CALL_3(bpf_tcp_ops_reserve_hdr_opt, void *, ctx, u32, len, u64, flag=
s)
> +{
[Severity: High]
Could casting ctx to a pointer array here also lead to a NULL pointer
dereference on 32-bit systems due to reading the upper 32 bits of the
previous 64-bit argument?

> +	unsigned int *remaining =3D ((unsigned int **)ctx)[5];
> +
> +	if (flags || len < 2)
> +		return -EINVAL;
[ ... ]
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
[ ... ]
> @@ -1244,6 +1281,15 @@ static unsigned int tcp_established_options(struct=
 sock *sk, struct sk_buff *skb
>  		size =3D MAX_TCP_OPTION_SPACE - remaining;
>  	}
> =20
[Severity: Medium]
Does this cgroup check evaluate to false for struct_ops in non-cgroup-bpf
deployments? If so, does it silently skip reserving space in
bpf_tcp_ops_hdr_opt_len() for established connections, while still calling
write_hdr_opt unconditionally later?

> +	if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {
> +		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> +
> +		remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
> +						    remaining);
> +
> +		size =3D MAX_TCP_OPTION_SPACE - remaining;
> +	}
> +
>  	return size;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.3136=
053-1-ameryhung@gmail.com?part=3D12
