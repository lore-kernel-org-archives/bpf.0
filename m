Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E43815DE
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359940; cv=none; b=RcZzg7HD15gxVeWICJjjcU/6BrrlK9Hg1ymthuGtrdMA6PEfmSomkIYe1F2xbqGlDEilqYThAIOXNQtOSyiMm5ngzEGnq8BnibesaPvHQ3OeuvxAGqi4sV3IYf3wakzP1JbqvdoT8B3tSX7762QTvlcbn4HXc1mwvHY7Afz7hm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359940; c=relaxed/simple;
	bh=iRgMwuk0r1pJUPO8tqlgUrndM/Mog4iRLmiIsXrtVGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TQDD1YmwdU/oSOWla+gx9Ul8XBsws9td0G/HTF1gaVkgwoNJNg7rHmH+GYZ0vIF5S8v2voocLkF7HdeL9zjFgTWgg7gjoRlzaV/jw7qRfs3rPZyilvOnfcCR7gsKgUf+MGycjgwVM7GxqElb3Av3dgfR/57RrCwYa3AYjlHpBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAIKVlbh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAIKVlbh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9597A1F000E9;
	Mon,  6 Jul 2026 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783359938;
	bh=sUj1zsnTUUdgl6Hk+L9fZzf464N6c7SlPjKI5YuZtkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PAIKVlbhKQXkzxeGG90VyqiHC4ps/wuYcBRVRtQ5L2teJkXDOiahoDixL3QauGi7p
	 U9R6u/Is4aGWtwbK2bfxrNrBtkGrfSV03N3G0PiURQC3oJEdl5ADW4RiY+XiRXRntQ
	 12JMgc20x2KDQNqkBf38rbjWTsZsN1VFf0AQLGasDCCIfLZSBYGCV3pXqbq7sbpxKX
	 5rgM0TcHAUsXSLOBbRpBVFnqeI4lXvBEBnL64GaAIfB2fza+bwGnnpJTt48FOvVKm5
	 CemHAwMXnGtO/7ulMBOj03BRzYUeMScITSk3d40TQHH53K+B1BniuUMdTR/tLpDsnQ
	 aoXp69qhyowBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 12/15] bpf: tcp: Support parse/len/write
 header option hooks in bpf_tcp_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706171918.317102-13-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-13-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:45:37 +0000
Message-Id: <20260706174538.9597A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Out-of-bounds write in bpf_tcp_ops_store_hdr_opt via TOCTOU race c=
ondition.
- [Medium] Logical starvation of bpf_tcp_ops header option space due to sha=
red reservation allocation.
- [Low] BPF multi-line comment style violation.
--

commit 16cbab0861ea029c828cf9218ec942f85b8d7050
Author: Amery Hung <ameryhung@gmail.com>

bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops

This commit adds TCP header option callbacks to the bpf_tcp_ops struct_ops
type. These mirror the legacy sockops callbacks but expose them as
struct_ops members for regular function signatures.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2102f9f2afd63..7bf702117602d 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -3005,6 +3005,45 @@ struct bpf_tcp_ops {
> =20
>  	/* Called on listen(2), right after the socket enters TCP_LISTEN. */
>  	void (*listen)(struct sock *sk);
> +
> +	/* Parse the TCP header options of an incoming skb received on an
> +	 * established connection. Use bpf_dynptr_from_skb()/bpf_skb_load_bytes=
()
> +	 * to access the options.
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment start on the same line as
the opening /*? The BPF subsystem coding style prefers the text to start on
the next line.

[ ... ]
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index 3febbc8dd1a06..b27613898337e 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -66,6 +87,102 @@ static struct bpf_tcp_ops __bpf_tcp_ops =3D {
[ ... ]
> +BPF_CALL_4(bpf_tcp_ops_store_hdr_opt, void *, ctx, const void *, from,
> +	   u32, len, u64, flags)
> +{
> +	u64 *args =3D ctx;
> +	struct sk_buff *skb =3D (void *)(unsigned long)args[1];
> +	struct bpf_sock_ops_kern sock_ops =3D {};
> +	u32 opt_off =3D args[5];
> +	u8 *op, *opend;
> +
> +	/* bpf_tcp_ops does not keep track of the end of the written TCP header
> +	 * options, so search for it every time the helper is called. The free
> +	 * space is NOP-filled, so a TCPOPT_NOP ends the search rather than bei=
ng
> +	 * skipped as in a normal option walk in sockops.
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment start on the same line as
the opening /*? The BPF subsystem coding style prefers the text to start on
the next line.

> +	op =3D skb->data + opt_off;
> +	opend =3D skb->data + tcp_hdrlen(skb);
> +	while (op < opend && *op !=3D TCPOPT_NOP) {
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

[Severity: High]
If a concurrent BPF program modifies the map value containing the TCP option
length during the helper execution, could the copied length cause the loop =
to
advance op beyond opend?

If op exceeds opend, would the calculation opend - op underflow the u8
remaining_opt_len into a large positive value? This could lead to an
out-of-bounds write when __bpf_sock_ops_store_hdr_opt() calls memcpy() using
skb_data_end.

[ ... ]
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 978d8474460b0..15915d452d6a1 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -573,6 +573,13 @@ static void bpf_skops_write_hdr_opt(struct sock *sk,=
 struct sk_buff *skb,
>  	if (nr_written < max_opt_len)
>  		memset(skb->data + first_opt_off + nr_written, TCPOPT_NOP,
>  		       max_opt_len - nr_written);
> +
> +	/* bpf_tcp_ops portion is NOP-filled (everything past the sockops
> +	 * writer's bytes). The writer find the append point by scanning from
> +	 * first_opt_off + nr_written to the first NOP.
> +	 */
> +	bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, synack_type,
> +			 first_opt_off + nr_written);
>  }

[Severity: Medium]
Does max_opt_len contain the combined space reserved by both the legacy hook
and the new bpf_tcp_ops hook?

If a legacy program dynamically writes more options than it initially reser=
ved,
could it incorrectly consume the space intended for bpf_tcp_ops, causing la=
ter
store_hdr_opt calls to fail with -ENOSPC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706171918.3171=
02-1-ameryhung@gmail.com?part=3D12
