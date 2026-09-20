Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E063A8743
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915170; cv=none; b=kfyLN2wmc3foN0Q9DBjyaXx4XDYHY7swiShtessiSnnCpnTLOqnkDRtJUF86lnScW8FO+K2oghbYi5dkuyp6tqc0K8T1C4rtcHHG1k1uXra3LlpdwF/MPg7Ez7oUov0+mq/A6TFDkVy0+3JN2HTcn4gmsx8wAG+rWsSRUZt2IaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915170; c=relaxed/simple;
	bh=shTgSYje1jfZtldLPfuQ9TpRNMd7SEkboXQoDFzCoAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JNeJ+AcImXxZMN65yE5ZYT+KvGMw6W6L2+kHh+6DnLSE6mOVI9DA26EPspnHxyPRyZk71/TaY8QNE2YfsrR26qiMCccUhsffluvnX6w4FrZF75gKvJmDrBVCGqJShy61VwHOg9QZRUnItaLCr1x33TEQSOQE1iE1HxdIog/hBWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPQXFgKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPQXFgKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016541F00898;
	Sun, 20 Sep 2026 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789915168;
	bh=calhiynY1S4a2SznO7CkmD6WL3u4UaPbbxv/OQ6kffM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nPQXFgKaS8whdcj+cwcp6HSK6wh1vT5OIxVeRKNdvlcxGni+A89Tt4iPTZxoD+t2K
	 vwCV18nxT0ApuOrmbvPaoQZ4ke+UcHYFVyQ1gQup0cC8xpdrZMs36EL3u6mLYm5Aoo
	 V4P9ZPGgUPDDzq06rLEpFqWFzSnHdK1GlQGLRauCxwglwbA/HSt4OslvpKiE5rGeld
	 aRjyExoOfulZOf8PHluqeZudaLy/XxN7x8kt+Q7Z0IOnhL5vEUpjrxHsx15+zCbVKr
	 MeS2ezDkqwvsvMvoxqWaVS0BowuNe/lfYXyHyDM4fxgQTFNj8QjddRaT9VKVIeGQoT
	 wUnRqW4dX+P9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 6/9] bpf-timestamping: restore skb hwtstamp
 if it is used by start time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260919143732.11772-7-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <20260919143732.11772-7-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:39:27 +0000
Message-Id: <20260920143928.016541F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: start_time clobbered by hwtstamp when start_time is zero
--

commit 0169de67fe5c3f53f4f477e65c35152b1fba307d
Author: Jason Xing <kerneljasonxing@gmail.com>

bpf-timestamping: restore skb hwtstamp if it is used by start time

When BPF Timestamping V1 (SKBTX_BPF) and V2 are both active, writing the
hardware timestamp into orig_skb clobbers V2's start_time on the
retransmit-queue skb. This commit saves start_time before the write and
restores it after the V1 callback returns, so both timestamping generations
can coexist.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5686,6 +5686,7 @@ static void skb_tstamp_tx_report_bpf_timestamping(s=
truct sk_buff *skb,
>  						  struct sock *sk,
>  						  int tstype)
>  {
> +	ktime_t start =3D 0;
>  	int op;
> =20
>  	switch (tstype) {
> @@ -5695,6 +5696,8 @@ static void skb_tstamp_tx_report_bpf_timestamping(s=
truct sk_buff *skb,
>  	case SCM_TSTAMP_SND:
>  		if (hwtstamps) {
>  			op =3D BPF_SOCK_OPS_TSTAMP_SND_HW_CB;
> +			if (static_branch_unlikely(&bpfts_v2_needed_key))
> +				start =3D skb_hwtstamps(skb)->start_time;
>  			*skb_hwtstamps(skb) =3D *hwtstamps;
>  		} else {
>  			op =3D BPF_SOCK_OPS_TSTAMP_SND_SW_CB;
[ ... ]
>  	bpf_skops_tx_timestamping(sk, skb, op);
> +	if (static_branch_unlikely(&bpfts_v2_needed_key) && start)
> +		skb_hwtstamps(skb)->start_time =3D start;

[Severity: High]
Does this code permanently overwrite start_time with hwtstamps when
start_time is initially 0?

The && start condition skips the restoration when start_time was 0.
This leaves the skb_shared_hwtstamps union corrupted with hwtstamps instead
of 0 for start_time on the retransmit queue, causing downstream logic to re=
ad
a massive hardware timestamp instead of 0.

Also, could re-evaluating the global static key bpfts_v2_needed_key here
introduce a race condition that skips the restore if the key is disabled
concurrently? A local boolean flag might be needed to track whether
start_time was saved.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919143732.1177=
2-1-kerneljasonxing@gmail.com?part=3D6
