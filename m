Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3F413240
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905664; cv=pass; b=ixKJ/kB34hDCZvFNHsSIudJZ1OjIObR71B/4eO0khiVwHqKc3t9etT+u8HEAGEWwp/+ne5Nk6ePzHo+kn4XzPDRNHZGxrCUdskGjtBGyZN+z6wIFdbm3H07b+7bUk9R3jaTOqgGJ0AOq++jYtxyfQHOXB3R2DkeQL1hDjw1Ar6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905664; c=relaxed/simple;
	bh=FFii1bsKXobctKhMNLtq5d1Ip3RYu1nQ6MH14Bs+3t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCCNhK06BQ5/aocHLEDE7tTTdkCRh6w+u2OZiu9nnx4+CfEv/V2/T1Q9AjdbqesPK1LxBW3oHZ9qk86SO2MpMG3yNDd53mJxL/XLJc15AVnGn2VPwxn2dp6umJHveXskSEqBvfs22S5P5BphVzlDs2BBDpIyZvbSCvmaOP3iAeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLarUOM4; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLarUOM4"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50146fcf927so53843891cf.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 02:41:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768905660; cv=none;
        d=google.com; s=arc-20240605;
        b=JRYB4p05pPk4o2ucxcvFO5K7+m846lnYk6dOP3Ud996evQ+1BTcbBifbPQfOp+rpI9
         ufJ7TTKHM4w3WhnP4QMPikvuPlU0hYYTyZddsV+hEfRcL87CX2AAceRnjiZ98z8nl/GX
         1jcOFAkdlmRbSx3lgUApC17yDKW/hukS897DmbcPDpHq6+XVP4fjjhhSu9nQTZ1zpP2R
         y0/Pmdm2pU8nn0ABd6ux1rjn+bcwujcCb+tx5xl1XZ8DbVckSgln5MCbsuGWShjWXalG
         kvj2Qpjs7COI45BhuPoVp9s4FOQuvN2afqV8vgDsocC5Q3pSF1sJfPiK3SpaUshsGTl0
         AXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FFii1bsKXobctKhMNLtq5d1Ip3RYu1nQ6MH14Bs+3t8=;
        fh=MhXiIlMKBQV3RVeMtN2Ow+KVmZarogtqtMZgmAOiy7k=;
        b=H0vXA9td062BxpTcThQYMxEpTKZTWrv9S+bNsrNck9+cykeSN+scS/O+SApnPW6A+X
         OZIZ001zaB9jfWIYrGjdi6nm3CCVnC9zEUwgUtwvRGBBqcnFT816cGo8R/JVvKtyVimO
         MC7qSqiPUla7uMqCDuAcyC8r0OqI7KathYn05TxQuPeLOfL+n9t9HQqmX4wJYH8ofrXq
         +5t4BCgLwgHQcL1edCLz4IWX6ycL8gPEg98Q9lYXsEjye4/GctPbs2pFQL8KJBdAs++7
         ippPKB/GABNPcjAvuArtzaZToDeFDjQBYeJwjnQUFPSQNJbIwds36DcK6yjQ6BNXS6P5
         yirw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768905660; x=1769510460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFii1bsKXobctKhMNLtq5d1Ip3RYu1nQ6MH14Bs+3t8=;
        b=bLarUOM4KWKl8f8jZgqdcCHw3/BWGLLM0Lee/em0TyNUn56jxnJiCCMwImFosoG8BG
         bZ4ByuHgsMz229Eg7TzNOWTJZjiKMzDRETJfukjRdQEjYMCehR+z4Y7pAI9Q2auCxG7E
         e1Y54T0Hw7PqbKEqIZgANAaOQL9U5/pRC8TAKKDsc79lCOYpctfKAhJ2Q0SXP2DqD2fe
         f1u1/sh1/2CY3SJYi11hp/VEgmCZuNhxk/9RtFJ+F5kkn6NkkA1HU1Hl+vwEhd7LTXRv
         yw2bhlQNHF5yNZqfgxWMhFfvo0XmZUQNedyaSYVtNgkhtW/bP8azuPcC+vXn6D3LFXAM
         ph/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768905660; x=1769510460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FFii1bsKXobctKhMNLtq5d1Ip3RYu1nQ6MH14Bs+3t8=;
        b=e/uEYfBHcpSD+vNZIphBhlpurRMDrSkMlJWJx1zLgn4OUwvTwYL/Zp7UJQeMleMAfC
         ImFQRrrMff5QFufA9++nbYfHk/Y/T/fKFW8k+o3AFYNd5dedlwIzCwbw85FLFcHUzHEY
         m0FQMS8U7UExJbj5Nuz3Tcl2U5tp/YqleIj92JzFLTROTLdgNH2JfmeoJNJ2GcqDyeRE
         ELIcKU4+BP+WjZ+SsEwYmLu4Z5dpb1U16WxDnss+Zun8C+MPpNnaBfTn0XhnOfmSFuyj
         TKxXWPzi95mAj62KejVA3b5K7epPViwxZc4j7siG7XwvYfrTbKxa3r+39cJuGF6ncMv7
         pbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcNo9KnX99HFdyiJ9l5ojiGoU2RbgkHEZUo7lXK7W7jnZhAtkwbtvTu0AEhH7ZK2e1TFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfPO6Psy7xObkEBWz7kPw56xDFfZjlOqfuZftdppZpqh7VjV9
	aF5HhqBpITLhJrk6a02ruBViYguv9y36+6po+YilcBoRnzaXO3VWT72Je2JZL4TK+dUnKy0vtAa
	c5+kMYhiUFlVKAXfuVL56mGOY6+3PNZVjTDgSMpu/
X-Gm-Gg: AY/fxX6qQ/hYulWt5FEOmeBbJ+4Cs2RamD8vj5pM3gdOYm4h/CR5cg2u26LZQZYfuEu
	X3CWjtxAfFKRIo+MPHNZp+LcV6iEH/7Q0cAD6QRCakzbtSoxH7MbQFS0IQT5wwjB6ygvaGtBEJr
	xtMqjN6tAQX96Rqjcwi3qHgrBvyFA03A3cv2dcxxEeebQNjjS1CA85qoKqU+zSDmUom7HHuuzWY
	Fxp82+YzNh8gMP99U9AkkQHSysEic6Rr2zsAhI9Sf2R+pQWsINxy6kHSrMjxZBAWSZ4qpTpSw8r
	sjAxnA==
X-Received: by 2002:ac8:7d16:0:b0:4ff:7eaf:6fa1 with SMTP id
 d75a77b69052e-502a156ae5dmr191196621cf.11.1768905659838; Tue, 20 Jan 2026
 02:40:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-10-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-10-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 11:40:48 +0100
X-Gm-Features: AZwV_Qhir59xi47UnYx9OyC5NKVZCvDNZj7hbofVsggQLWG8gFaqMb9MOW1Nco4
Message-ID: <CANn89iJPE=rCExzfFw-eKe5PiukTnmUogaLJSXgo6JfDeZiezQ@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 09/15] tcp: accecn: retransmit SYN/ACK without
 AccECN option or non-AccECN SYN/ACK
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> For Accurate ECN, the first SYN/ACK sent by the TCP server shall set the
> ACE flag (see Table 1 of RFC9768) and the AccECN option to complete the
> capability negotiation. However, if the TCP server needs to retransmit su=
ch
> a SYN/ACK (for example, because it did not receive an ACK acknowledging i=
ts
> SYN/ACK, or received a second SYN requesting AccECN support), the TCP ser=
ver
> retransmits the SYN/ACK without the AccECN option. This is because the
> SYN/ACK may be lost due to congestion, or a middlebox may block the AccEC=
N
> option. Furthermore, if this retransmission also times out, to expedite
> connection establishment, the TCP server should retransmit the SYN/ACK wi=
th
> (AE,CWR,ECE) =3D (0,0,0) and without the AccECN option, while maintaining
> AccECN feedback mode.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
