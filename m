Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CA221DB6
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781339869; cv=none; b=OgzTIiZBWmVDyz4F2I6myhN4yp7FcC6yJQjvdV/8IFSfNO/7YMPTXZXQaI1ebzIg/WKs9VlwR9FP0YYXC9ClSvyPSMk34Elrr7aU6FMcoxLgusznnDJScdw0gTd45q6QLOdSmP8XBr4WRd86AJe9zgb66f6sd7A5245tLqRiygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781339869; c=relaxed/simple;
	bh=l+UdaRbck7sBmkgyy2131wcQdkIFYCYv91wfDFy8zg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IDmCFTedmO7RKBxoo3DxM94eMk02QYM5h8Ch/5uSp9j1YxuVYsykoFJzs3uC2wVYe4+2CQRSH7yTEDk+dxq2YNWtK6tRV5DtHEHLNsRJeQ4pp/o3Orpkf52PQdNMevzqELWMVUQxdtmPfi2OEcF2VvG0vPVroZLg1xY9U/Fl6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyewXCL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyewXCL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2991F000E9;
	Sat, 13 Jun 2026 08:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781339867;
	bh=Ucc+cVPg2baYTD/cpkyFwFGoD5pSOePGZt1zyhPronU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AyewXCL8VTUEVgiSHNcid9OPc8vhrn5wWmW8n1rtwBJmoOTSapNkp6O1rXMT/3Q2j
	 GRNNceYtHk1EHV6BpXxEKyFh4MznCnTnK/P783rf373HRx52m57Spi+waFOAk3AXfP
	 f/DAyu9PO/9a677vhRSHtzN0xwdUgLl2rqdAV5pL9uumQJvwYA8ngg3xTvr6fxbaqA
	 4ByeCIYSlS4p1a8VRjckGT2r+vyuhCKuFTh65Y5eRt8k5BEfV0wmjwU7Alj2l7HFok
	 lQAwk0uT+7m1CRWVU1x90vA2+z/w6muaXQVlp79nxIfAVxEqXGzQMeTwq9kSftlx+T
	 vl5+/TGoyg45A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix BUG_ON in skb_to_sgvec() on a
 resized ingress skb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260613082442.3252576-1-rhkrqnwk98@gmail.com>
References: <20260613082442.3252576-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 08:37:47 +0000
Message-Id: <20260613083747.CA2991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning -EINVAL when an SKB is shrunk by a BPF program causes th=
e `sk_psock_backlog` worker to incorrectly treat the valid shrink as a fata=
l error, leading to an unintended broken pipe (EPIPE).
--

commit 54e4eaf90ac6a727b56c416746a6a961673b62f5
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: fix BUG_ON in skb_to_sgvec() on a resized ingress skb

This commit prevents a BUG_ON when a BPF program shrinks an ingress SKB.
It accomplishes this by clamping the length to skb->len - off and
returning -EINVAL if off is already past the SKB length.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index e1850caf1a71a..2961178ebd1e1 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -550,6 +550,10 @@ static int sk_psock_skb_ingress_enqueue(struct sk_bu=
ff *skb,
>  {
>  	int num_sge, copied;
> =20
> +	if (off >=3D skb->len)
> +		return -EINVAL;
> +	len =3D min_t(u32, len, skb->len - off);
> +

[Severity: High]
Could returning -EINVAL here cause the sk_psock_backlog() worker to
incorrectly treat a valid SKB shrink as a permanent error?

If an SKB is queued to the backlog worker, sk_psock_backlog() uses a
do { ... } while (len) loop to process stm->full_len:

net/core/skmsg.c:sk_psock_backlog()
    ...
    do {
        ret =3D -EIO;
        if (!sock_flag(psock->sk, SOCK_DEAD))
            ret =3D sk_psock_handle_skb(psock, skb, off, len, ingress);
        if (ret <=3D 0) {
            if (ret =3D=3D -EAGAIN) {
                ...
            }
            /* Hard errors break pipe and stop xmit. */
            sk_psock_report_error(psock, ret ? -ret : EPIPE);
            sk_psock_clear_state(psock, SK_PSOCK_TX_ENABLED);
            goto end;
        }
        off +=3D ret;
        len -=3D ret;
    } while (len);

If a BPF program shrinks an SKB so skb->len is 50, but stm->full_len
(len) is 100 and off is 0, the first loop iteration will process the
clamped 50 bytes.

On the second iteration, the loop passes off=3D50 and len=3D50 to
sk_psock_handle_skb(). This evaluates if (off >=3D skb->len) and returns
-EINVAL. The backlog worker then treats this as a hard error, calling
sk_psock_report_error() and permanently destroying the socket's TX state.

Additionally, is there an inconsistency in how sk_psock_verdict_apply()
handles this clamped length?

net/core/skmsg.c:sk_psock_verdict_apply()
    ...
    err =3D sk_psock_skb_ingress_self(psock, skb, off, len, false);
    if (err < 0) {
    ...

If the same shrunk SKB is processed directly by sk_psock_verdict_apply(),
the clamped positive length is treated as a success. The remaining bytes
of stm->full_len are ignored without error, rather than dropping the SKB.

This seems to create a situation where the behavior (silent truncation vs
broken pipe) depends entirely on backlog queue timing.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613082442.3252=
576-1-rhkrqnwk98@gmail.com?part=3D1
