Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975A3DB31B
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248419; cv=none; b=W8Alnzt3jf06WxWlCQe2r13AGuElGx9RnSi9tWia2SrZbzrSWvdmKeMHqW3vGQOPKFPDe2logLDbgKkCsPvM4KJubhyE9zc6v+tOF9LaiLyOfu4/IYBIH5+vGSyvuxB5b/Ba80+D+QEyvEOq54BzhiyEG38A1i3unZGuqW+LmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248419; c=relaxed/simple;
	bh=GmbXwIDNcSzlW5aBWZPJk0vfrNsgAza9M5KKJoPzY18=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u7LcbPTuHHZyW/ANFCQUXzMpm5VQQLgXZNYlA0nB6tuwrfUWLZtsRPMFYeoHwC+Z9+zvWv8oLZ167ZoDyveJaqlF2IzWKpo+QEWOEsvrPtEQTa0t4hJFjm80KEpKMBS2/8uWR2kBqITWhnwM2BsSAYft6lnoEV+HqsEzKU3ZS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8au3Qip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8au3Qip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793CD1F000E9;
	Fri, 12 Jun 2026 07:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781248416;
	bh=DU97BM1pBVG6RTEAGkcAe9LVpaY760yrHFZvAoR8lnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M8au3QiphBzPlP/07uF3AgLtaD7QBWgbbDh5lTAh06vpG8YD1nqwpKbLCl46YohwA
	 +cU6Ey2aKgGKa1CbDGj+Dd8tMJjmnwnuWjUXz5b5Idc3HOEJ/N48W2S1Ujj4stnuio
	 HD58ymZJ/j1jQgi5nMJcZQ8ot2MUBTzhFinWvKKLznofEJfbukyEfsHHleawNbO+59
	 RE92g4DgyudqZCVucF1QE8FPJtYGGuWHfRUJ63RKQkkIeA/BGdE2FuwCulc0U0Skyp
	 QXQqD9+G5SpJqP5oy5GAuMitkSCBNUuD3Oisxw+OnU6NmRWdVa1GSRcK/x+I3zxGqC
	 SABylt6R1Y5bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce
 sk_tx_busy_loop()
Reply-To: sashiko-reviews@lists.linux.dev
To: menglong8.dong@gmail.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611071242.2485058-2-dongml2@chinatelecom.cn>
References: <20260611071242.2485058-2-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 07:13:36 +0000
Message-Id: <20260612071336.793CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] TX completions processed during sk_tx_busy_loop() incorrectly in=
flate the LINUX_MIB_BUSYPOLLRXPACKETS metric.
--

commit 0f753148fd82b1cf0ba3816b5e615f5e3039ba1b
Author: Menglong Dong <dongml2@chinatelecom.cn>

net: busy-poll: introduce sk_tx_busy_loop()

This commit introduces sk_tx_busy_loop() for NIC drivers that support TX
NAPI. It allows scheduling the TX NAPI, if available, instead of the RX
queue NAPI during busy polling.

> diff --git a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -6951,6 +6946,9 @@ static void __napi_busy_loop(unsigned int napi_id,
>  	if (!napi)
>  		return;
> =20
> +	if ((flags & NAPI_F_TX_NAPI) && napi->tx_napi)
> +		napi =3D napi->tx_napi;
> +

[Severity: Medium]
Will the returned work from the TX NAPI incorrectly inflate the
LINUX_MIB_BUSYPOLLRXPACKETS metric?

Further down in __napi_busy_loop(), the returned work is unconditionally
added to the RX-specific busy poll metric:

count:
        if (work > 0)
                __NET_ADD_STATS(dev_net(napi->dev),
                                LINUX_MIB_BUSYPOLLRXPACKETS, work);

If sk_tx_busy_loop() causes us to use the TX NAPI, does this mean TX
completions are now accounted as RX busy poll packets, potentially polluting
system monitoring statistics during TX-heavy busy polling workloads?

>  	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>  		preempt_disable();
>  	for (;;) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611071242.2485=
058-1-dongml2@chinatelecom.cn?part=3D1
