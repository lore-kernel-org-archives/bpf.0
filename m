Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6C51A732
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859657; cv=none; b=qjc/a1WqGWtdqDKcfrL0ykNTUJ6RA3YGMjgXiOaf/jEiHZ1hRjxycuzb2yGnc2NdzZ/hWOwRYs00PBcb3BHHnkacnyBltBT5FuDAs4/ikRhjjxaq/qE5op3nivJTpVC4+IE0bm8+6yZ8OXUrWhR8lb3IJBv/PvwWUHiDe2Rmvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859657; c=relaxed/simple;
	bh=fQ7IhGwhXfB7IiqAplp58u35Dfa7UzCe5/IwwI55IDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bRUX8y45vp0530rw4uDSRhp/eMdKXmDjV3x1ydQJbJO5/undjsLo9z2KSKFAeyJLOy2YPb1eblE+tRkzBKnGTonxQJBMGCDqxDsw0AYGIp+FI8kxyTpJxTzILtfIdWDt/Ycv5JxVOkPBVgmTzH/A6MlL+4fJzMIzBbJWs49+K3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4lTN2BL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4lTN2BL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2EB1F00A3E;
	Tue,  8 Sep 2026 09:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859655;
	bh=VScu1IaMGQSYRixtOdY7vTuw4no4axnL/87tP/8pSa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V4lTN2BLSNzOB8CbLexHlyqAenh2ZcCt01j7LcSYqhn3WgPJ16AQfX7gLs4Bb/gYe
	 HETf10eChApHq/dgJDQvE1dAzjIL2EDKWIRW/IzfjF4uhDxxT950H2FBmJHE3tllzY
	 n03aCZOGM1iklkJw90RGMaPTC/tBHh4+n7N9wmVEEo7+MDd0jaLT59K0HYsR4ZvchU
	 WvV9gQbtqO8JJa0wVyNoE5dybpqM6dfKICbOZQzgiDJQ4eJXhC3oioRBQBxc70DOcA
	 DA9XriXJBtFMUq3Vbjozkc/KIrj+bdW/KcVecY0sxt0OuCqbNgU74FninbkPL4Ggkz
	 1AZ0WH4G+z6kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3] bpf, sockmap: Fix self-redirect copied_seq
 double-counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <1a8e797a1b26e2f695aaac22ac644c2862f63466.1788858299.git.tanggeliang@kylinos.cn>
References: <1a8e797a1b26e2f695aaac22ac644c2862f63466.1788858299.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 09:27:34 +0000
Message-Id: <20260908092735.1C2EB1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Inconsistent TCP sequence accounting (copied_seq) for BPF stream_v=
erdict self-redirects depending on ingress queue state.
--

commit 1c84437e57670b82a168813bb40bf5ab64fc2722
Author: Geliang Tang <geliang@kernel.org>

bpf, sockmap: Fix self-redirect copied_seq double-counting

This commit attempts to fix a copied_seq double-counting issue by
converting a self-redirect verdict to __SK_PASS in
sk_psock_verdict_apply(). This bypasses the __SK_REDIRECT case entirely
and lets the __SK_PASS path queue the skb to the psock ingress queue.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05d..df385a5a961e8 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1000,6 +1000,10 @@ static int sk_psock_verdict_apply(struct sk_psock =
*psock, struct sk_buff *skb,
>  	int err =3D 0;
>  	u32 len, off;
> =20
> +	if (verdict =3D=3D __SK_REDIRECT && skb_bpf_ingress(skb) &&
> +	    skb_bpf_redirect_fetch(skb) =3D=3D psock->sk)
> +		verdict =3D __SK_PASS;
> +

[Severity: High]
Does converting this to __SK_PASS introduce inconsistent TCP sequence
accounting (copied_seq) depending on the ingress queue state?

When the queue is empty, sk_psock_verdict_apply() calls
sk_psock_skb_ingress_self() directly:

net/core/skmsg.c:sk_psock_verdict_apply() {
    ...
    if (skb_queue_empty(&psock->ingress_skb)) {
        ...
        err =3D sk_psock_skb_ingress_self(psock, skb, off, len, false);
    ...
}

This successfully creates a message with msg->sk =3D sk, which allows
tcp_bpf_recvmsg_parser() to correctly advance copied_seq.

However, if the ingress queue is not empty, the skb is queued for the backl=
og
worker. When backlog processing later reaches sk_psock_skb_ingress():

net/core/skmsg.c:sk_psock_skb_ingress() {
    ...
    if (unlikely(skb->sk =3D=3D sk))
        return sk_psock_skb_ingress_self(psock, skb, off, len, true);
    msg =3D sk_psock_create_ingress_msg(sk, skb);
    ...
}

Since sk_psock_strp_read() sets skb->sk =3D NULL before verdict application,
this check fails. The resulting msg has a NULL sk, bypassing copied_seq
advancement entirely.

Could this failure to advance copied_seq lead to TCP window exhaustion and
cause the connection to stall (a Denial of Service for the socket),
essentially replacing the 2x over-counting bug with a 0x under-counting
bug?

>  	switch (verdict) {
>  	case __SK_PASS:
>  		err =3D -EIO;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1a8e797a1b26e2f695a=
aac22ac644c2862f63466.1788858299.git.tanggeliang@kylinos.cn?part=3D1
