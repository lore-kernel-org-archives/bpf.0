Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716C138B7BA
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781313656; cv=none; b=p1/f+WrsbCc4nR7aZXlnQtrHSdSCXoLOZGz8KrD6QjZz2zMkvTbtgKszCWfnjFHp68EmrXZALusC50T9FsM8rUwMTvwuReCUkIDT9YwyRlPWvVhObdCM9qnNW09GrcNjOCGdVi1AgBmVWOVsHNsBLjZfCsR9LY/2Tu8doGiUhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781313656; c=relaxed/simple;
	bh=clcNVHSzoevrTAq1WCnoWha7R9tTcZY4owAMyciNulY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cf/9r4u/7NXmegCnN2hZNujal9YUNPfSSsh9MESqalk2MDt29v/NOebL65p7mLxVORmDLKvS++3Xs0kjVAK9ctw4k3pe022AQvH1ue57OcF+ftUwQvt+YoQS9V8gadE5Num5A/rDcAvaZMM6uxq3R0bfws2QXbqDot9wrJx+KeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpaL8zPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpaL8zPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30831F000E9;
	Sat, 13 Jun 2026 01:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781313653;
	bh=DUPDdp7oAvd3PH7eopJYYSThkmHgArnWwO9y1Y7YICY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BpaL8zPCsanybMWmFy2N1S4ATZEtGrr556/dYZFUn5FPJKME3l5rtKK6ZC5Ff+kQM
	 NNC/kIwUV/YV5qX8MhkPIm7Mvnn+ITler5XBzjWcW7gZH6kHYslt2f+D306mxfwbtv
	 7N1CVc0oYTONGI1CXuoObWjuIOqSH8Z58jIQsUNQcHxQQCssdYO1kKO729xjBrhqh3
	 jrD31Ypb3IkKrDN1lMQMIugIAQYrycU2PeV/DZ3l1CFTjTBHx7sOoElqQcA6f5jJxC
	 IIFivancF5t3sxUxzH0gMyxChM/FJ6++5hwyCku0PoGlQ9GOXcvQSZN7KfK5sstTCT
	 yOfDIJgAe1dEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next/net 4/5] bpf: Add kfunc to proxy TX HW
 Timestamp.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260613010039.1362312-5-kuniyu@google.com>
References: <20260613010039.1362312-5-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 01:20:52 +0000
Message-Id: <20260613012052.C30831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incompatible `payload_offset` semantics and bounds checking betwee=
n `tcx`, `cls_bpf`, and `bpf_skb_complete_tx_tstamp()` leads to false rejec=
tions or packet corruption.
- [High] Blindly clearing skb_shinfo(skb)->tx_flags destroys the SKBTX_DEV_=
ZEROCOPY flag, causing a permanent memory leak and application hang.
--

commit 07c148630f8e93ce45f5ce41dcd9ee675f05a799
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: Add kfunc to proxy TX HW Timestamp.

The commit adds two kfuncs, bpf_skb_scrub_tx_tstamp() and
bpf_skb_complete_tx_tstamp(), to proxy TX hardware timestamps. This allows
socket applications to receive TX hardware timestamps via SCM_TIMESTAMPING.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0c6c270d9f7d1..a45cdf38616ac 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4456,6 +4456,41 @@ tcx_run(const struct bpf_mprog_entry *entry, struc=
t sk_buff *skb,
>  	return tcx_action_code(skb, ret);
>  }
> =20
> +static int skb_do_completion(struct sk_buff *skb)
> +{
> +	enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_INGRESS;
> +	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
> +	struct bpf_tx_tstamp_cmpl *txtscmpl;
> +
> +	if (!(ri->kern_flags & BPF_RI_F_TX_TS_CMPL))
> +		goto drop;
> +
> +	if (skb_unclone(skb, GFP_ATOMIC))
> +		goto drop;
> +
> +	__skb_push(skb, skb->mac_len);
> +
> +	txtscmpl =3D &ri->txtscmpl;
> +
> +	drop_reason =3D pskb_may_pull_reason(skb, txtscmpl->payload_offset);
> +	if (drop_reason)
> +		goto drop;
> +
> +	skb->protocol =3D txtscmpl->protocol;
> +	skb_set_network_header(skb, txtscmpl->network_offset);
> +	__skb_pull(skb, txtscmpl->payload_offset);
> +
> +	skb_shinfo(skb)->tskey =3D txtscmpl->tskey;
> +	skb_shinfo(skb)->tx_flags =3D SKBTX_HW_TSTAMP_NOBPF;

[Severity: High]
Does this direct assignment cause a memory leak if the packet was sent with
MSG_ZEROCOPY?

If the user application sends a packet with MSG_ZEROCOPY, tx_flags contains
SKBTX_DEV_ZEROCOPY and a reference to ubuf_info is held. Blindly overwriting
tx_flags here erases SKBTX_DEV_ZEROCOPY. This prevents skb_release_data()
from calling skb_zcopy_clear() when the SKB is freed, leaking the ubuf_info
reference and causing the userspace socket to hang indefinitely waiting for
the completion notification.

Can we mask out only the timestamp flags or preserve SKBTX_DEV_ZEROCOPY?

> +	__skb_tstamp_tx(skb, NULL, skb_hwtstamps(skb), skb->sk, SCM_TSTAMP_SND);
> +
> +	consume_skb(skb);
> +	return NET_RX_SUCCESS;

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index bee1e7eee5eae..fce2d24aad487 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12396,6 +12396,67 @@ __bpf_kfunc int bpf_skb_set_hwtstamp(struct __sk=
_buff *s,
>  	return 0;
>  }
> =20
> +__bpf_kfunc int bpf_skb_scrub_tx_tstamp(struct __sk_buff *s)
> +{
> +	struct sk_buff *skb =3D (struct sk_buff *)s;
> +
> +	if (skb_at_tc_ingress(skb))
> +		return -EINVAL;
> +
> +	if (skb_unclone(skb, GFP_ATOMIC))
> +		return -ENOMEM;
> +
> +	skb_shinfo(skb)->tx_flags =3D 0;

[Severity: High]
Does clearing tx_flags here also destroy SKBTX_DEV_ZEROCOPY?

Similar to skb_do_completion(), if a user application sends a packet with
MSG_ZEROCOPY, blindly clearing tx_flags to 0 erases SKBTX_DEV_ZEROCOPY.
When the SKB is ultimately freed after transmission, skb_release_data()
will not call skb_zcopy_clear(), leading to a leaked ubuf_info reference
and hanging the userspace socket waiting for completion.

> +
> +	bpf_compute_data_pointers(skb);
> +
> +	return 0;
> +}
> +
> +__bpf_kfunc int bpf_skb_complete_tx_tstamp(struct __sk_buff *s,
> +					   struct bpf_tx_tstamp_cmpl *attrs,
> +					   int attrs__sz)
> +{
> +	int defined_sz =3D offsetofend(struct bpf_tx_tstamp_cmpl, payload_offse=
t);
> +	struct sk_buff *skb =3D (struct sk_buff *)s;
> +	struct bpf_redirect_info *ri;
> +	struct sock *sk =3D skb->sk;
> +	s32 delta;
> +
> +	if (attrs__sz !=3D sizeof(*attrs) ||
> +	    memchr_inv((char *)attrs + defined_sz, 0, sizeof(u16)))
> +		return -EINVAL;
> +
> +	if (!sk || !sk_fullsock(sk))
> +		return -EINVAL;
> +
> +	if (!skb_at_tc_ingress(skb))
> +		return -EINVAL;
> +
> +	if (attrs->payload_offset > skb->len)

[Severity: High]
Are there incompatible payload_offset semantics between here and legacy TC?

In skb_do_completion(), skb->mac_len is unconditionally pushed before pulli=
ng
txtscmpl->payload_offset:

	__skb_push(skb, skb->mac_len);
	txtscmpl =3D &ri->txtscmpl;
	drop_reason =3D pskb_may_pull_reason(skb, txtscmpl->payload_offset);

This structurally requires payload_offset to be relative to the MAC header.
However, for BPF programs attached via legacy TC (cls_bpf), the MAC header
is not pushed prior to ingress execution, meaning skb->len excludes mac_len.

If a MAC-relative offset is provided, it will exceed skb->len for small
payloads (e.g., empty TCP ACKs where mac_len + offset > total_len - mac_len=
),
causing a false -EINVAL rejection.

Conversely, if a BPF program compensates by sending a network-relative offs=
et
to pass this validation, it will cause skb_do_completion() to pull from the
MAC header incorrectly, corrupting the packet.

> +		return -EINVAL;
> +
> +	delta =3D attrs->payload_offset - attrs->network_offset;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613010039.1362=
312-1-kuniyu@google.com?part=3D4
