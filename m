Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65BF37B3E4
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056836; cv=none; b=Db6Ot/YaWRY9M06G1PcxrxEsXBRo+y055zf9S4/fMw3/yN6Cu+wBNJhO+YedPcEYUkfUUQ+r2ZWHocmvTD9aqaK1G4u2IWI4L8yp5gK+yDwo7kpLZCTtbl93CK+Njw36sjfxodEV/dDod6w1dELcsYcLLOot5mXHzxmj54ln+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056836; c=relaxed/simple;
	bh=/6lY5zVfP0B0BSX24jFbcL5w6uR1C9EcwoPVOKja6/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jiqHdV6GLwiWmy1q/Cy0d4c7dhJaJzGOxNyt9gDDpyNzzbucYFQ6lv262JbjkV1YMW+NYr8CyLolMIwtfbNNHduBCwu5PSOIocmPxw6zFw26NNl+FqiARDYisajZMPj3pU8Y1zGaWcSXLYMFsgwwV29j60LK+AAkcr4Q7rgh7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtLzYhwP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtLzYhwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154F91F0089B;
	Sat,  3 Oct 2026 19:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791056834;
	bh=4bQu+mDgabgl62yWVxSGylv5+wnBqpAw17HXz8pS3Q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KtLzYhwPfXdvIWp6jsTcucCXlrogqmbiFh9vj3ygPK6AqdTSMUV/ehlyWSj0x30Qg
	 v7L5GpVblPCii8Fl1svqzww8owKE/42ycS9vLQJ1jIEb2AQuAXumZIYByfD1x2H3EU
	 cFiBZe4ubPylcsgrxm4XJWPDNo1You6uPl2SJ2Hva5lt/slhiN62kfeTkvy/IaaIMe
	 psL0D3OBRT6F/XSqReLru8ilM2oa6zZerex5IEdY4WYfAYRbdC9jcFliQAGYmcFAGT
	 oY+EnnfFxKnOv+6J67zjjpXjbqm1N/RnfBz9Y2/3LFzAze0T93J2zOwxHPH3a6TGej
	 JEPpCYQnYxYkw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next v2 2/3] bpf: Add PPPoE decap support to
 bpf_skb_adjust_room
Reply-To: sashiko-reviews@lists.linux.dev
To: ThisSeanZhang <thisseanzhang@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261003193347.1137527-3-thisseanzhang@gmail.com>
References: <20261003193347.1137527-1-thisseanzhang@gmail.com>
 <20261003193347.1137527-3-thisseanzhang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 19:47:11 +0000
Message-Id: <20261003194712.154F91F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment violates subsystem style
--

commit c1a6f04f8833d9df42d737a66bf20c54f24fcd8b
Author: ThisSeanZhang <thisseanzhang@gmail.com>
Subject: bpf: Add PPPoE decap support to bpf_skb_adjust_room

This commit adds the BPF_F_ADJ_ROOM_DECAP_PPPOE flag to bpf_skb_adjust_room=
(),
enabling TC BPF programs to decapsulate PPPoE session packets. It removes
the PPPoE headers and restores plain IPv4 or IPv6 skb metadata for later
consumers.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 80ebf3cf2e783..c6f7ccee5c187 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -3920,6 +3960,23 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, =
skb, s32, len_diff,
>  		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
>  			return -EINVAL;
> =20
> +		/* PPPoE decapsulation is mutually exclusive with the
> +		 * other decapsulation types.
> +		 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred
BPF subsystem style?=20

The BPF subsystem conventions require multi-line comments to have the
opening /* on its own line. Could this be updated to match the standard
formatting?

/*
 * PPPoE decapsulation is mutually exclusive with the
 * other decapsulation types.
 */

> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_PPPOE) &&
> +		    (flags & (BPF_F_ADJ_ROOM_DECAP_MASK &
> +			      ~BPF_F_ADJ_ROOM_DECAP_PPPOE)))
> +			return -EINVAL;
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_PPPOE) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003193347.1137=
527-1-thisseanzhang@gmail.com?part=3D2
