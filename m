Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D60314D37
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621509; cv=pass; b=cGFJkmD7vcLZPZ5SnnnzPv+lQVwkxgRg6Esxuy//AguH78zmsZH5WIzHmXivwC/fF3NmtkyDLMjSK6hiVt2yCOf20aiGIqnare7H8laqqrDEb3qZUjy1SSSF3X3xbYeoW8kZRmjdZk70GPlwFB1YlP7hRikANg4d/WuDc5FUNB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621509; c=relaxed/simple;
	bh=57u5vhCVP5EEa+FsK/c7AMFO2KyXey8UN5xlwACjIv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdxBneg0BU2E5thYuCZ6vb45GoZuPn7qR4g4Eu6vPXKE0p8l609CQFI4w++AQN9g5zzesoGPrxMIJmY8kDuyLqRQE7X2dWpu+Q9S1tLgHbWgusL50EKxeWsA4XS7tbKngw9ebWseX4RIu2K5EsVqswkeVbJuMQDvi9JOWSmniGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8KnR0lr; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8KnR0lr"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7984d31b895so64491837b3.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 02:51:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772621508; cv=none;
        d=google.com; s=arc-20240605;
        b=i6B5JBkajTkLORG4WFPjqc0ryC6a7vzqdU5AGNnTGMD852rpDgnOLxx6+SFl34+4Zu
         jW/G4JF6OjQDaHvWTEKj8u1FMPjKqKVb2amJ0bQkVJWiKoWeQhTa11LFFS+GnZsoH5Zx
         /A1DPpAsijbD1FDyx+nJ3E/MdEhbMpg6nHBu1FslI8IYD40BB2NZegz0M2LQXW2Y/GU0
         BI3qmprUSzPitIAOW43zfgBrQYAGwAj1IavODlQtF8k4e7L0x0TDTSELv2hnbkOa1LGx
         FowdxHtR7U/ONJ+Pq3KYihc6XT42O3vfUfuG0s3s6p88O6vl7b1CPvAi1xBfiqCmkZrh
         jorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4PcEkYoFEI5voGPr8pCPoGCSxgYeETv4ZT/GQQL/KoU=;
        fh=WAvsj9Z0CIAy/F9BGNb9QfffVODX8QEISUjE2jjb0E0=;
        b=c/vCtO9E9hebaqTgCmLSbiS5oJ/Ld40PfMTYLiAJ6xwukgGNp0Vjphtkvzt9RxW0mZ
         OZusqb1k2k0xB5/71LdiYFnNxCHHrKgqER7O3YUDBPJ+8d69IS0N7pF5Qs8xaDyfFPAG
         va/zy3e3fFnlCDkH5Bu/Y2EF7bFL5VmffQtkGm+pM589CTQ9ErAI54Po+89YDem1kJcB
         vSVHlWu6TSsLXcjaRCSqxft7O5V8ViiOxU7Ey7e+Wf1YpzKFoaL5Cx7KDkV7hzHuyCkL
         KAdyk68up97MWl1A7jK8ZF/yd9y+tivfM3Esr5oqBXF2wk/HnXVEenkV3oUOgFtetg0e
         3pyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772621508; x=1773226308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PcEkYoFEI5voGPr8pCPoGCSxgYeETv4ZT/GQQL/KoU=;
        b=l8KnR0lrH2nddb2FOAdsXr+wCeHVI0lPlBJ9Iz7OZnfDnV27cA/N58Ro6ZRIBwl8UP
         KqJm0hqFaGPqFPrzZ8XSp/Fp2XW3ugYfAODs1qMH340C3BVVe/VvMrIxyIpjvM8hamR0
         C09NAj62pWHpZ8qhoAlN45Vvq9E/eT7g/ogMjHXefrwpZ4MdueRUq4lHxIdatbJvgH3M
         vTQ71NDBGY7wm2vDRsVJK1DO1SlxL5QIHzBZXhddvNhzHE8dXLQ9GwFUSCi396lPQwfg
         +eONPCqzD4ATW+ogi6LPD24ZimO0f29h6Ur1BNRfI48+vIRK1hJSTn1Ym+hPmqUf6O3S
         2Nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772621508; x=1773226308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4PcEkYoFEI5voGPr8pCPoGCSxgYeETv4ZT/GQQL/KoU=;
        b=CeeyTphTwOFHf7DK86pFHHh828TfBJI35/3khG0AwQLzRYoIa+axAOvgVNY2CVDEeE
         GTuDv8NE0IbWXqXyAFBFf5Lz98CjRrQMIrZm+Ekqnu3Qu4vFrfUe89bt04pu2ubiiq0k
         0ffA/JCtBdoP+Gq3JN5vITmVV6k4dktt885dU1QNhl5iuu/Jw0/8ItfgYHr2ykTKEq2f
         WTKO/xbCeHuAA0Yjv9ODl9GLCBGPNeWbxg30SrVm2Ipaz2xBLccAvcgeJgVVYiOgyVA1
         q6yxK8KDTsGVpxpKO2J4kTodyyjLdFRxMYw4xNKpCrzWMbppDTiFxIR7ySDfm5HlLvUB
         FYow==
X-Forwarded-Encrypted: i=1; AJvYcCVJqHaiNbTYbUptgwVZPhO6Dzj2SAol7Xp0L27vdKPVNsCvPkFwrg+R4KsVyyZcod6/y2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx2D2rX4Qk96eeEZKxoQKPxJnHL1Gzc9LmWaYouMmomzzDt1AY
	GEGRtbwlrJYAjzwt93K/PaRAhLgONwc+aXkYeQMkcGZy2V0Teql++BNtL3oR2QkSKqldsJaoDk7
	YpQyv1BWNzZuywuFvJZzTr9qpqzM5khRgIz7+hPq34epCrriwS7Nl2w29
X-Gm-Gg: ATEYQzyP9ho5ncROYr2ACkXyy0dqEzEboVQotW2gRRo7Yi6sH85tCA58Vjjx8wzCKeY
	f9nN01iy9Fk3Gx5/Qy6J58YicJJLRrxDp8Y111GImPMCFSpcIWdR2X5fxhK6bS4TwOirFJ+5Ev1
	8P/tzdtPaf54a6fd0PyAH2LV4PHpKY+e+eHiQbmdXk8MFY43sL4GEyAngBtu8ZXllWToyyrnzKL
	APbfTGZOJL0W7hF5RZDj41cGUFoUwolCPs52VXyY1sa4RM3RlTHOvC1BlTukyAauSZvBwRFImqW
	imfWh34I
X-Received: by 2002:a05:690c:289:b0:798:caa5:cd31 with SMTP id
 00721157ae682-798caa5e3abmr4129457b3.66.1772621507369; Wed, 04 Mar 2026
 02:51:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303100439.3172296-1-kmta1236@gmail.com>
In-Reply-To: <20260303100439.3172296-1-kmta1236@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 11:51:35 +0100
X-Gm-Features: AaiRm52fwpgkHQRhYeOQXh5WIYeoMabF6E2KRsY4-7GtkGjYqVvq3HycuLPYk-s
Message-ID: <CANn89iLt6xx3hEjTLEAv06G+4bK3TTti=H4qDgS4LxWSwyy7TA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: shrink per-packet memset in __tcp_transmit_skb()
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 11:04=E2=80=AFAM Keita Morisaki <kmta1236@gmail.com>=
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
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
