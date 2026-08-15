Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94AC3939CE
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837770; cv=none; b=YvwoM+fFnzBIjpkiLXCyMqZt5reAAdgMXmJOw4DpRmLJCDDLuVQ3lD5P1pjP/yJGS9LCVnSUcwk8ElsL/Eugf6cpbZy+FWhR/Jv5osRY7YPR50cbH6fCD3AJw9z0VhtdO1+uAN6zBXmaj3OAhdqKOk9ACxYeu8wedX3HDEKRHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837770; c=relaxed/simple;
	bh=2mJmf1D0mSOhgn23vLi56riBLA9C2JslQDYFmcsND0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qpmjHoyCv9zyN4wo7m9B8P1nubavXFizkKY023UGXGOLrzOxqn8VtH6n0JkOCefco0f/sZ6nMfu50NKNsfPaM0Zh6O9wsp6C43mwjApAfjjWHkiQ7KyCiEfKdBI8hQfv1YAtSyGDwjmJ2dA18g09FIrg4Y+Ufh4g7Nur6WH47Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwTttrOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwTttrOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AA61F00A3A;
	Sat, 15 Aug 2026 23:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786837768;
	bh=Phlz8SP88o2HZ3hExex4sa72TqQpfBEcHpjmdutT0RE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cwTttrOin4OKxlxfEer12ZZbfiS9e5Q8WKfFg3YYUfBqgf8Y1NibeAgythEw2pEeh
	 tHh4PYGHVNLZ6AFZ5V8xfecSMDrJ6AlHZpRaUIIWbt6349g+0PkCfupHWM0tuifgjD
	 fndeeMqEDqVHlA7tHr+qbPVxMN7PpnaAQmfjtSquaxY5lUlbddI+Mmmf8gkG1Gnuqs
	 hp+Pj0syLqIquJ+O7YDP6oVj0Gq08WnKt7E0ZzV4/X3cN6akspkRN/KMHT3hCJx7RG
	 iXXjLVKjckCw+R9CGO8UTBNLK1dVRsQVZPw+1ORxSiD4jWj/W2Jd4boZwnC9QnLfhn
	 b9Yo8k0f5uwOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/6] gve: increment work_done for XDP and error
 packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Washington" <joshwash@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814234845.773189-2-joshwash@google.com>
References: <20260814234845.773189-1-joshwash@google.com>
 <20260814234845.773189-2-joshwash@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 23:49:28 +0000
Message-Id: <20260815234928.77AA61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The patch inadvertently corrupts `rx->rpackets` statistics by co=
unting descriptor errors, allocation failures, and XDP drops as successfull=
y received packets, and creates a mismatch with `rx->rbytes`.

Pre-existing issues:
- [Critical] Missing state tracking for dropped multi-descriptor packets in=
 the DQO RX path causes subsequent fragments to be treated as new packets, =
leading to payload corruption, bypass of XDP drop rules, and unsafe XDP exe=
cution on partial data.
--

--- Patch [1]: [PATCH net 1/6] gve: increment work_done for XDP and error p=
ackets ---
commit 705a50c36a672a5d7810174d670e9330d7aada5f
Author: Joshua Washington <joshwash@google.com>

gve: increment work_done for XDP and error packets

Ensure every packet is accounted for in work_done by incrementing
work_done before checking for the existence of a SKB.

Cc: stable@vger.kernel.org

> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index 0ece2f6fdffb4..db38bc6452969 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -1145,13 +1145,14 @@ int gve_rx_poll_dqo(struct gve_notify_block *bloc=
k, int budget)
>  		/* Free running counter of completed descriptors */
>  		rx->cnt++;
> =20
> -		if (!rx->ctx.skb_head)
> -			continue;
> -
>  		if (!compl_desc->end_of_packet)
>  			continue;

[Severity: Critical]
This is a pre-existing issue, but does the polling loop lack state tracking
for dropped multi-descriptor packets?

If a multi-fragment packet is dropped (for example, by an XDP rule
in gve_rx_dqo()), rx->ctx.skb_head remains NULL. When the loop handles the
next fragment of that same packet, it skips to it because of the
end_of_packet check.

Since skb_head is NULL, gve_rx_dqo() will treat the middle fragment as a
new packet:

drivers/net/ethernet/google/gve/gve_rx_dqo.c:gve_rx_dqo() {
        ...
        /* Append to current skb if one exists. */
        if (rx->ctx.skb_head) {
        ...
}

Can this lead to XDP programs running on partial data and malicious inner
payloads bypassing XDP drop rules?

>  		work_done++;
> +
> +		if (!rx->ctx.skb_head)
> +			continue;
> +

[Severity: Medium]
Does this change inadvertently increment the interface packet statistics
for dropped packets?

By moving the work_done increment before the skb_head check, work_done
now correctly accounts for dropped packets, XDP drops, and allocation
failures in the NAPI budget.

However, work_done is later used to update rx->rpackets at the end of
gve_rx_poll_dqo():

        u64_stats_update_begin(&rx->statss);
        rx->rpackets +=3D work_done;
        rx->rbytes +=3D bytes;
        u64_stats_update_end(&rx->statss);

Will this cause dropped packets to be incorrectly counted as successfully
received packets, causing the rpackets stat to diverge from rbytes?

>  		pkt_bytes =3D rx->ctx.skb_head->len;
>  		/* The ethernet header (first ETH_HLEN bytes) is snipped off

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814234845.7731=
89-1-joshwash@google.com?part=3D1
