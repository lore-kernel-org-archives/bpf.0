Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563206;
	b=tGjq9lWX5FgyzeJ6odW34/z4mzOKnB6syOebWtcsFISr16AJzP4lUirnfAZb7WRAD57t
	 Oqth44O45Itvr4XTy8N8bcuW9Bn1XwVWk4SS8RMbjexkQ1WZjr82mbHZqPjjIexf1BFGx
	 2+vYvzzqozDAsu3uT7umP5iGrWpTS7svBQBfZJFdgFLYQEUCDXlNvMWx7ec4+pcokZLba
	 9TJH2oW+3CDxCHckxwCHO6TkjCHH3tP3YrzHpqQcjx2d0l4Kgwd9UYtdzG22Iu8ttoXNF
	 M7WwVRTLOUcJE6UCQs7Rd0ps6Nj10h8Fhiskn/6TKUfEqSQztrcOlX9NkOAKhmz2B2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563206;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1FyAloL1CQ37USPXEbDXl0f3lUCARYwolnoAtKyF9hE=;
	b=BCKa36jJ4L8x2iJj37JX1OYrdl3hZTAyH9Yf9BmXrzvNa59iMYoF16Z3Q8SITCkcDwcV
	 oJUxEKnEQVZSfWdUouyBezdQ+1/jfXwuXUD17gOyFRQYtq8xYXr/+MFe2YCVk6JYjVik8
	 yva13g6XKzzm8RCv6sqJ719GUj4duJxNUW6uL3ocRMijsrspYa7RY0+ZDEYcVZH2lemWq
	 G9XOmjtovQqH5kpSN/vi3Sp4LzqMUeL9tCv+pdNWj1bwHUnmRCb2AbhsfY7gt1ybOmuwE
	 X4XCGCJ+ifdgVKooFNmluD2Tu6zzJdMw5zGrJQsB5ylF7Ep0FvUDpB2KKnRmFdKO/vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fuUc73Ij;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420B606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fuUc73Ij
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A775E1F000C1;
	Sun,  1 Nov 2026 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793563205;
	bh=1FyAloL1CQ37USPXEbDXl0f3lUCARYwolnoAtKyF9hE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fuUc73IjQECJra1B/K4576nm5yn4nSpi2E5BOhOY5Z9iJF05ouGh0aqap2iSyy+/s
	 1FaZ7I5LVpyOCZoEpNqJ/kMqJIoZ2yID0p8hvtvQt5pHHaZETv+I2QFKnhPcgP1pJ7
	 64HHzFhvYCvhdt7bp4XVOvbD5GOzjBMPXgAz90f+VlNz6xdWY3+kSAk/UyRqCWBik0
	 UxKAl8PRLig15a8Tn/LkK1UsUi7d7mhSIuJ0D1WWwbdlq+LVspkSUhqtgHcIlbZYTV
	 Fokx0UVNgL8o91vONldRGANzjTs7+NZxKB2d33rkUTSzZCDPsvEjMcKcAxusyRyIU8
	 Xyfg1QYQDqUlg==
Message-ID: <sashiko-outbox-192643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 27/27] bpf: Check the offset in
 bpf_skb_generic_{push,pop}()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261101190535.1454146-28-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
 <20261101190535.1454146-28-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 20:00:05 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: u32 wraparound of off in bpf_skb_adjust_room() bypasses bound=
s check
--

commit 294bb6515ed77f7d0955cf5e521eacaeed3e3e77
Author: Chris Mason <mason@kernel.org>

bpf: Check the offset in bpf_skb_generic_{push,pop}()

This commit adds bounds checks in bpf_skb_generic_push() and
bpf_skb_generic_pop() to ensure off does not exceed skb->len and pulls the
first off bytes into the linear part of the skb before moving data.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 21fcdc7cd950d..9245009d9f1eb 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3369,6 +3369,10 @@ static const struct bpf_func_proto bpf_skb_vlan_po=
p_proto =3D {
> =20
>  static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
>  {
> +	/* The bytes in front of @off are moved with skb->data. */
> +	if (unlikely(off > skb->len || !pskb_may_pull(skb, off)))
> +		return -ENOMEM;
> +
>  	/* Caller already did skb_cow() with meta_len+len as headroom,
>  	 * so no need to do it here.
>  	 */
> @@ -3389,9 +3393,10 @@ static int bpf_skb_generic_pop(struct sk_buff *skb=
, u32 off, u32 len)
>  	void *old_data;
> =20
>  	/* skb_ensure_writable() is not needed here, as we're
> -	 * already working on an uncloned skb.
> +	 * already working on an uncloned skb. The first test
> +	 * keeps off + len from wrapping.
>  	 */
> -	if (unlikely(!pskb_may_pull(skb, off + len)))
> +	if (unlikely(off > skb->len || !pskb_may_pull(skb, off + len)))
>  		return -ENOMEM;

[Severity: High]
Can off wrap in bpf_skb_adjust_room() before reaching bpf_skb_generic_push()
or bpf_skb_generic_pop()?

In net/core/filter.c, bpf_skb_adjust_room() computes off as:

	off =3D skb_mac_header_len(skb);
	switch (mode) {
	case BPF_ADJ_ROOM_NET:
		off +=3D bpf_skb_net_base_len(skb);
		break;

When skb->network_header < skb->mac_header by 1 to 20 bytes (for ETH_P_IP) =
or
1 to 40 bytes (for ETH_P_IPV6), skb_mac_header_len(skb) returns a u32 near
UINT_MAX (0xffffffd8..0xffffffff).

When mode is BPF_ADJ_ROOM_NET, adding bpf_skb_net_base_len(skb) (20 or 40)
wraps the 32-bit unsigned off to a small value in 0..39 before
bpf_skb_net_grow() or bpf_skb_net_shrink() calls bpf_skb_generic_push() or
bpf_skb_generic_pop().

Because off has already wrapped to 0..39, the off > skb->len check in
bpf_skb_generic_push() and bpf_skb_generic_pop() passes whenever
skb->len >=3D off. When growing with encapsulation flags in bpf_skb_net_gro=
w(),
u16 mac_len =3D skb->network_header - skb->mac_header also wraps to
65496..65535, and skb_set_network_header(skb, mac_len) sets
skb->network_header far past the end of the packet.

Would it make sense to validate skb->network_header >=3D skb->mac_header (or
check skb_mac_header_len(skb) before adding bpf_skb_net_base_len(skb)) in
bpf_skb_adjust_room()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101190535.1454=
146-1-alexei.starovoitov@gmail.com?part=3D27
