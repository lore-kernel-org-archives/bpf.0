Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB0C3290BD
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781235433; cv=pass; b=FnrNJTgOYU3y4kAcvv01YJUN+1yxUEhUa0pPMbFdvj/IoAf3X8529MfFqh8Iigmoy0nulc5dzbNEgqoXwwbLy/72ffRYMPQirk+hAuTVowQhWnW1reroGzXJZoufezi0vooiwOKBEyM7r5cigGZzcYNqy7f2xaamx3VMnnUjOFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781235433; c=relaxed/simple;
	bh=f9eM4QECuMJVJ64dYWKjBS1Ex/yKf9yovNHknSmTlro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Es0dG/DtG58GDm+YvGXoneJs5rl1CASGYDqOYK5u5MAmlbc1y2B+EabdKzAi+P8+R2STDq/aXvHq2mpudJwVrJDVlQGT8T/P2RT0TDFp85TpZggEq6Gp6xEm+rdGho0JtChF3M+VOz2UwEMVmamQTwHvreKY7oxGD3/PgUCF/cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AszGR0ef; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AszGR0ef"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85ba774551so188322a12.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 20:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781235432; cv=none;
        d=google.com; s=arc-20240605;
        b=CMnCUZMYz5xdKY6vFHzTNwDczWyZSuanm4HuoeQ9MD4PD0K2n0naZ1Wwv/MHI3TQ3M
         1ZMnl6w2vWynqNqEngwwawQtZI0rLkIS1lPdESpk17IAl9fpWnnMlIdw84J2XxW2qH4s
         1GUD9N1DtDht3zapTtIj1iQOz/rYzssTNqFzf/+e2MwRo8lGrtePFnQa56PQHHQ7/Nk6
         6JmoscxnFm9xCbt4oWmDuU6uhlbldf7t7tjG9NFVgtnyThk/yjl25F8fV8IWohExquVn
         DmYVOP2n+D7Ts6UnUpBWNGr0T0/a93kxquSpHRt21M9Co9gActK4hT7uNJe8fgf2+03K
         E3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hZuKy8KsBKoVzcM4mWt3Qcn4TgT+cGVHbQHSYBpfjC0=;
        fh=VPhyqwcWTNwH1jfpIXD5bSCYUcddy6K5jarc0QIKW3w=;
        b=D9Q9tbsBOm9RZSx0DPTjDncXyQRj1xOiHjTe1d0CRNo61rGnVt35qbiyaRchMB7IiT
         axjSsu2kJIphXvCk1BevVrIOPTSe+C64gpBk45aR+9nhwDy49rYhYGgBcqqISujMhCmO
         0B/unBG6BalHL2KTE6VJfHBAlcbk89PlZHD5s1fgraS8SS7ZD0TJI4gk/ng0G/s4asKR
         HFoSFb0Ycn/jUWT/zqm+xDtfTWiibhYXrSb9CJ7ZiZLD9GKodu/2yVg6QS4XtluZKIuZ
         Vf0xBhgdMG+q2/uryPbrLG+XtFEOZPEQK7uWnWo9WfufADj8qe22DIgvxF6u40Ul0aZg
         W7lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781235432; x=1781840232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZuKy8KsBKoVzcM4mWt3Qcn4TgT+cGVHbQHSYBpfjC0=;
        b=AszGR0efURKv8R8m3r5xUF5tjCTzx9ZtypU7J4Vw5u6BUY9QOylE0GcZcdXO/bQG7Q
         0qQAtsvS0yjKfew586AvYVBpqFiBlTR2j8vnKuuaJtPaO5C1O/oRDn+KjsJI0Rbmv4xQ
         3RHmYViuAHHOQmCs3uoFfl7/h+SVfZY51x2liYvzNuTfepbJI6Z33pxwMgvvY7TjKilP
         9Qn6RR7+tTf5CASFz7Sv698P/o3HwL4SFDM6HnMStd4yQ/HylWVpYa/Qv2GKLxZiyELT
         xRUXYeTBp1MJd8m9elf7Whp8QhVcnWkpYuPVEQxK81qJj3kI0uR4xv8z48+xghfqzP18
         /W5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781235432; x=1781840232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZuKy8KsBKoVzcM4mWt3Qcn4TgT+cGVHbQHSYBpfjC0=;
        b=NXQ0PZwpAHp+rpcsw8HgdCq2Ej7pR9+XEbZlUPkDSgMZZf8KNYZz/+kFPPeCzVzTAb
         i+UPE2AFJab2PuKv6RtYFjzSm27GlvmgxBrD4SghDPnLOWXEkWZw986RhOdFvCmg0EvP
         lF0yHEEvTm6833T3fUS6UG1/XnOBU1vZkCyEiEXqkaFLeGYTvVcwpYi71zCPa9BSf30e
         bmipCDrNAnb4xKWVEfCIXfNvETmOFg1kS3qTGPMl7gR5n1myc69bdmEr/GLIEcpbRWMF
         HdBjQPYRzLG8UDFu9oRrOymhHjyhTNM3iZUpD/1qVaJp1R8vBKdj8bokCyje5DRPV12y
         okBw==
X-Forwarded-Encrypted: i=1; AFNElJ8TtwvsYMeUnPJwtkdv7H2tddjtSgXCQ0fmZ7y5bgs47ag7xuB/fk4t4YUgRoOgReKjJaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6WWm6pIxtxB3mQZeYrcqZ7HNKKxKaR8D7T4/uD3gDbqjUI/k
	kcjQtPN1boyoIhBlbV5Kk3+rfEz69ucKm55ni8k45mJr6hKvlzEGS/xl4xDFUFG3aZYGlRLzmAS
	xmrPZlCeVG7PUT76+kDwVSC1qADbV4s1h3Ru6
X-Gm-Gg: Acq92OFxYUmxsHkXZlLPeBO9CljX2UYxylRNHlYHlrvmAxbkPGUeU/e7aHSW4zumBTC
	brAY2JJ6NbTugyY45hek01DdI+ZYDE4E9xRxH/OFEXEKQRSNonRLlpPxGV8yGi5LQFu8bOiWnbY
	BUvxeTXc/aLfxKYj9JTMnn5kqTqPMRS9du9XUvOmRGZWe8P3SQAyVgTCFB2gDkP+oVhbgU0G3LU
	XWbO1B/OuRHprJkOKUZPRvCW7KKhn1k88oqqWXWVGM0KEjh8NR8aMHLRQESFVptW3KeCGyI2iUr
	mbeDfHXk/o8U7eBmlvSpJogg0F7Q5z0TC2sM10sQ/uPC9p0+iBwRzn/jed8qnm9ccftmmCaEPXL
	4uz8BVXrpj+5frMo1zlGav52J
X-Received: by 2002:a05:6a00:130f:b0:842:7fc8:eba with SMTP id
 d2e1a72fcca58-8434cb0aee8mr976470b3a.11.1781235431674; Thu, 11 Jun 2026
 20:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612001803.23341-1-kuniyu@google.com> <20260612001803.23341-5-kuniyu@google.com>
In-Reply-To: <20260612001803.23341-5-kuniyu@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Jun 2026 20:37:00 -0700
X-Gm-Features: AVVi8Cc3LWqeHHmqgGwv1rpYa72x9cqFhMV1KKvuFVbN6h0AgGgzm1GevRLaZhg
Message-ID: <CAADnVQJjHDbpAt2=Jkytz1GxHebPXeSEM2drekh=7vXhgQBkmw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 4/5] bpf: Add kfunc to proxy TX HW Timestamp.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 5:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index b4ac1180f5a8..bd9343288928 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4706,6 +4706,14 @@ struct bpf_hwtstamp {
>         u64 reserved;
>  } __packed;
>
> +struct bpf_tx_tstamp_cmpl {
> +       u32 tskey;
> +       __be16 protocol;
> +       u16 network_offset;
> +       u16 payload_offset;
> +       u16 reserved;
> +} __packed;

Here and in the prior patch..
let's not penalize modern architectures like x86 and arm64
just because somebody has sparc on the shelf that collects dust.

Also don't use 'u16 reserved'. 'u16 :16' is better from backward compat pov=
.

And consider addressing sashiko findings.
Everything with [high] or [critical] most likely needs to be fixed.
[medium] and below is a grey zone.

pw-bot: cr
