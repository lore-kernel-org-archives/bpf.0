Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C322749ED
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685727; cv=pass; b=otjvrTeaVgamzEnxaFvI4WC26fGzpLomJlyQrHxWBhb8K9wAWNtKqqGdXrcsARkGrz9B0tkUCmwXzzogK4ZiHTAwD6Zq2dCIGxudxz+NnbQ2jTrfo0I1jPb+gsRvZv/t5UeK2TPqCg+0LfRobU/baCmPCld6zCSYg4GSdbbiwps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685727; c=relaxed/simple;
	bh=b3Xkd4EKnRyb7vdnRVFaQz5szPGJij4qxH5oDzMhz34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkzfMBjAM0Fl/UnhGwlEtvkTQ9TvKcjDlquGsATI0Q8wymK6+Kl3EIaLzoEspCcbVsbgAr0ctS9ozL6SnIh9H2zEIrh8jxkuHrKsfOL3U2exwpmubLX2qHXZWydy031nGWzxMZDNxdYwQuKXtkp09ZiGh1UM23QB2XLqfAyob8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKvyCFtN; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKvyCFtN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b936331787bso1256370766b.3
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 20:42:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772685724; cv=none;
        d=google.com; s=arc-20240605;
        b=kylAyJdM20da+H3cbUPlOJmmJDfiXuS7flhp4nyKTonpn6C2mZXNTfx/qSeepnCEiz
         Y9aDoQcUpsPSPJ6cXBSOjYhwCVSy2WyC5TX+b49/DJSJBm8oFubZEbJRNoR4v9ncci36
         KN+o0GmKQY1HjOzs6N/cyTxyd3s+bqGICsJ0mj+Rb6U6RAw2Mn76xC5iDdb+r2G0xG6D
         Ef4vDGa/GmeHeLqXGHOB+skWsxvYPmUF1oCusFJgGNrUXlXkd4YKwi5zI16ULQ6+e1mT
         KyKnBoskQw6zBDeJDmiINOKhoBlYQCJQkUSBhd5RtVIcia/bGRf5NDAj6T5quhYgXkgk
         W1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qFs3o4E1Xye81GNOTEaZssjs4l2+yIjCY/hB9HWyfNo=;
        fh=hCoYpKuzaVY7qx20M/uROhbWFxFOp9qjHkDXubyOrS0=;
        b=a30zEiiZQatm5jHW0Igkpw7ASRvSR5qESVfjmA9CEYFLg7dIpy7bS6TIAZj3+dr1Qd
         t1zPiz5kHMJGLrawa3YPRCVyDSlSlRgRLjejNXYEFg2QMaTN6gItYHiU9OPaFHCAIprK
         U0s3gBkqRFQa0mT9JBK0nFgaowWNsnZpSTi4BEtKUn82NxxIunafuMDUMb7UrQiT1ykc
         v1E5ajY/YAcwDgo+PM36s78P4Njf/D7C1ndeyxR/uQiea6UdKOOVlayYBfl8k747wtxV
         A934+/hc4EH5mb5be21NboUFGVay93DUgTHUhW9xIt7dr86JqZn8iJtbhag1MoHWiXW0
         TDyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772685724; x=1773290524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFs3o4E1Xye81GNOTEaZssjs4l2+yIjCY/hB9HWyfNo=;
        b=wKvyCFtNp2FYAD5iUZuRTr8+gCaU0TlVOD/+y4ibaYEbajzz6KZC/aZK07ApJJmvG9
         3NDenGzH0jboVMlOpkp+TrXpcon4cA5pZTzS+rSPvrzUfcPQ3gACjChyxIzkj/5Plgda
         WZj3CzxuvFn6RBzC3OFw4a95WmUaxeZvDQ0I02E89/qbiECMRK4IJWvUZ6GbqllrOc9g
         Qa2B+eRShjeRG5nWBgHJKTdofQYAN3tDEokTTDff/eBtEQuTU1DWFBrVslFQIQ3fWApA
         FZtp6GAwVWgdo6sZbJlyRkLzdKvPR008HeYFgQncFZk5S37SQfd6hwgQOPn2/WqwJzm0
         pMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772685724; x=1773290524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFs3o4E1Xye81GNOTEaZssjs4l2+yIjCY/hB9HWyfNo=;
        b=ILrNJ9B3Ohe7YVoCH6KMLXTe980i2/14Q+n9zq8EkH93jpbJuZZkWs/D1ka/Spovk3
         lDS44tm4RG9a4Sv2DM5DDSv/LCRbMOglBRjROvHi7Jv9oRFMJmmPYScQVa6HD3JPEsX/
         jnq7E9AFO25NYYScIbe/O39vqC+jSto8GH4ixg16q6EgGJZe/egjd48WcPrRhDLSsjKQ
         KbmtCG9OSsbSQo6KDdxl/kjd0/7ggz/S/JlpvGhbr0KSbmR3/sz6Jo++wilmEL2NHXa2
         UPhpWWCjnZCNcRDGhtlA4V/RXquaZbuB4Hmqyt/B5JuWJCCAIbas6wx6crzunxfXP4eZ
         lTZg==
X-Forwarded-Encrypted: i=1; AJvYcCXcIVZijtL2EgwlapsObLoScOnDTdfBQVbGB5bYgNMF5MaG8lr9AJcmMt3IGOrHWzR+QIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8YANNkevPJ+gPSCacA+WAIJW52hkepAv1ERVFHtgwTZY0nXD
	fkGiWaWlOR4DcOeQMf9P6Xu/ItRmVHm347khGOC1O6M3qCw1XrhIzl8avnn/wm/UP53q+eCh2mw
	3+6RmGQ7t+MqEy7B5JWNU5U9zupNINPB5OLz08pqe
X-Gm-Gg: ATEYQzwhwSJOTj++qRaLBNT/BdNFX2jCWFqdNdwdCw0as7K4fK0VdvWV7K+6P9Ef7IZ
	75/EGiSFJeFbl9N06p/GD8WWcB4qk0yjRiJGbC80ET0HRnJ82hR2U/U6VmfbVAyrlC0WWfb/ow2
	seyKWUXTcVRAswJ1ixCYSDfbqRwgd6Ae5nMTbTH6CD5BtItrP5dYRrsoH+DlRGkdWuLFYCW17U3
	GNx6VFI2Tx/4fZA2Ak4crX99jiKhTpvvogvNpVax29PGdlY4i9rlRos5mfvUyZ6BHIo8upU//mo
	rvk4JNKBYIKo7CX0RGtILOkt23Ws0PeMfiopWWBP3cX/RXgRxQ4uHzA4Hb+MzKk4pl797b4/
X-Received: by 2002:a17:906:6a1a:b0:b8f:bb98:b8f6 with SMTP id
 a640c23a62f3a-b93f11c5ad3mr265537366b.19.1772685723621; Wed, 04 Mar 2026
 20:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304111517.2088694-1-kmta1236@gmail.com>
In-Reply-To: <20260304111517.2088694-1-kmta1236@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 20:41:50 -0800
X-Gm-Features: AaiRm51le4VIOnY5bCLbPnwrxhsRbSgcv1k1w5UJIrgYGqVkL7f7CO9wRGze_zY
Message-ID: <CAAVpQUD0gfpzZaMDBNuK2RQ1U5=3=5u-gb-jpLMxFvYPYQ+-Ow@mail.gmail.com>
Subject: Re: [PATCH net-next V2 RESEND] tcp: shrink per-packet memset in __tcp_transmit_skb()
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 3:15=E2=80=AFAM Keita Morisaki <kmta1236@gmail.com> =
wrote:
>
> Use struct_group() to group the three fields in tcp_out_options that are
> read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt()
> (mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memset
> with a targeted memset of only that group.
>
> struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> CONFIG_MPTCP=3Dy (typical distro config). Every remaining field is either
> assigned before first use by tcp_established_options()/tcp_syn_options(),
> or gated behind its OPTION_* flag in tcp_options_write(). This memset
> runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
> bytes to 4 bytes reduces per-packet overhead on the hot path.
>
> Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=3Dy):
>
>   Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
>   After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)
>
> Also add opts->options =3D 0 at the top of tcp_syn_options(), which
> already used |=3D without a prior clear. tcp_established_options() alread=
y
> clears opts->options at its top.
>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
