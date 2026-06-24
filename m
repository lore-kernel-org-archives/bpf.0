Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAAA24676D
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308019; cv=none; b=NbV1kFUTRHgTsb0MvrNsR7N0ha9pBHB4VZB0zDcXPw491E6p+I0Emi4jjDvn9gMojErvv/ypdeRrrMJFCQ+xPOR76H0lyJIz9imWIH8POpsNK+0noIvY0yJI7Nf4BJMKWro5Bpdbcx4DV1mxs77vPNd1fqlW7C63imOqKFRYI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308019; c=relaxed/simple;
	bh=kqALxvCv5hcvtn/VSN4a74zhks3eFUUcr6cnmbZpTmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l7PiKeB5MpEJmb8pWpPLw4YpCKtdz4mrKK2CrFeD+Ituv3NvLljK6CBH63hrIi76wXdgV/ZCsItV0P4mjVjRuX1ocgq0A5uzYLH9Mi8m7QWixdi7mpAslxBJZVKvMUAiqTsM2qMiv+J0JNL6IpYMcgERewOZkkoKkzirW6fFHpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVFcS/Hl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVFcS/Hl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F3F1F00A3A;
	Wed, 24 Jun 2026 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782308018;
	bh=mzLhVhDlW7fOpagGEKBv7ryy6+s1E0cRqF6wSmh04zI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oVFcS/Hl+X2N9jbOBZZjhAgcsuyZo45yuqX0YJslebJ3biZNY/O2waKKYt60bbYVl
	 UIQc6UJrUmDStAKy05DVBgixKhpZn5mECDKWDAPUXSQFJ94jbM9NiEX4REOF1kVHoE
	 X0yTZgw+hLd1P988m3tcPEtcEOBIodnraMPA0vl43JpFNud7hfKv5g52FItNl9ob5W
	 07ZKy1dvHToTGNyx6RGxLYTd30BbCz5c2Ly85ikLe1zluhw4MT9gH7FxeLd0og4xMW
	 /p/B3HEztx4fRXmt/fQltTK8MvqsAW8HDXXPE7op38Gvdh3QBaP/uSSzrQQfO9Jasn
	 OSCkoJ2rXe1nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/7] xsk: drain continuation descs on invalid
 descriptor in __xsk_generic_xmit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623133240.1048434-4-maciej.fijalkowski@intel.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-4-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:33:36 +0000
Message-Id: <20260624133337.54F3F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `invalid_descs` statistic is repeatedly incremented for the =
same invalid descriptor if the Completion Queue (CQ) is full.

Pre-existing issues:
- [High] A malformed descriptor (e.g., invalid TX metadata) permanently sta=
lls the TX ring because it is never consumed.
--

commit b076f5f0d28ebb521e9e57462363bc0f2250e923
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit()

When the TX loop in __xsk_generic_xmit() encounters an invalid descriptor
mid-packet, the partial skb is dropped and the offending descriptor is
released. This commit ensures remaining continuation descriptors belonging
to the same multi-buffer packet are correctly drained on the next iteration
instead of being treated as a brand-new packet.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index e80c035a7af54..c489fadc36087 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[Severity: High]
This is a pre-existing issue, but does encountering a non-transient error
during skb building permanently stall the TX ring?

In __xsk_generic_xmit(), if xsk_build_skb() returns a non-transient error
like -EINVAL (for example, from an invalid XDP_TX_METADATA payload), it
intentionally skips releasing the descriptor:

net/xdp/xsk.c:xsk_build_skb() {
    ...
    } else {
        /* Let application retry */
        xsk_cq_cancel_locked(xs->pool, 1);
    }
}

Since the error is not -EOVERFLOW, __xsk_generic_xmit() jumps to out
without releasing the descriptor:

net/xdp/xsk.c:__xsk_generic_xmit() {
    ...
    skb =3D xsk_build_skb(xs, &desc);
    if (IS_ERR(skb)) {
        err =3D PTR_ERR(skb);
        if (err !=3D -EOVERFLOW)
            goto out;
    ...
}

Because the descriptor remains at the head of the TX ring and the error
is non-transient, will every subsequent call peek the same descriptor,
fail with -EINVAL, and exit without ever advancing?

[ ... ]

> @@ -1128,6 +1128,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>  		if (xs->skb)
>  			xsk_drop_skb(xs->skb);
>  		xskq_cons_release(xs->tx);
> +		xs->drain_cont =3D xp_mb_desc(&desc);
>  	}
> =20
>  out:

[Severity: Medium]
If the completion queue is full, does this post-loop cleanup jump to out
without consuming the invalid descriptor from the TX ring?

Looking earlier in this same xskq_has_descs() block in __xsk_generic_xmit(),
if reclaim_desc is true, it attempts to reserve a CQ slot:

net/xdp/xsk.c:__xsk_generic_xmit() {
    ...
    if (xskq_has_descs(xs->tx)) {
        bool reclaim_desc =3D xs->skb || xs->drain_cont;
       =20
        if (reclaim_desc) {
            err =3D xsk_cq_reserve_locked(xs->pool);
            if (err) {
                err =3D -EAGAIN;
                goto out;
            }
        }
    ...
}

If xsk_cq_reserve_locked() returns -EAGAIN, we jump to out before reaching
the xskq_cons_release() call in the diff above.

Would the next invocation (via poll or sendmsg) then peek the exact same
unconsumed descriptor?

Since xskq_cons_is_valid_desc() increments invalid_descs every time a
malformed descriptor is peeked:

net/xdp/xsk_queue.h:xskq_cons_is_valid_desc() {
    ...
    if (!xp_validate_desc(pool, d)) {
        q->invalid_descs++;
        return false;
    }
    ...
}

Could this arbitrarily inflate the invalid_descs statistic while the
CQ remains full?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623133240.1048=
434-1-maciej.fijalkowski@intel.com?part=3D3
