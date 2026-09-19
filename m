Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E0538A70B
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841556; cv=none; b=A+QcQCzVZR4c8b6X0poMa26U+w1J9zNhtEbM77VCXB9JNyZcQw3quMgi/7Ta2/yCDDvEAH6tQiSPDf8LlrOzhEWFkyhJKkSj0QbvT+kYAzblhvjwcdrhHR2/zRRijU40EI+yHIQF7WYDIwByLk5+YfREbfhrQpmaQiBBxNsrUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841556; c=relaxed/simple;
	bh=/2hT6zgP+mOS8MJpGIqUTtaf0kM1o48RlJDVs7oiUU8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YnHLMCXolLQ2wyzohC670eBYRcu9UaCLzuAlrt7xbfMct1WCSDIF9LrZ4e1cz5F23/14JilB5sA8b3Zg5QM+EhDdzf3GPo7dxBwnx1OvHrJbhluZu7wHBmC6y6qPvfhRhVHEKSrvJYnc8lYNspzRzT1+EbGVQcxeBdlfCeH9CrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hlj+FH5p; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hlj+FH5p"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1621293a91.1
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789841538; x=1790446338; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=091mGJb963fZm7TN81QDLSJJlLLidQRDCWzb3G3L/U4=;
        b=Hlj+FH5pty3MgW9dhXqZ4rezBLYI9J1ybtdgEvkGYQuFV9gd5xWcQpxYB1uMlnKHYc
         7v+osd5n1XNmTBdcfYJSDWQma371G1Z0KeYo8bkuv50CYJ1a3Q70vRTQWgB6wnJQjhjz
         I8s3Il6wiIkQm1GACBuzn6tBbPqxMiCK1vQ6wibbuHTfkZHqsjc7Ou483h+K6485x5ZX
         TlyAgyMLrorDwvtMqfPR0pW0S2UAm4g6npucd+Ai10OgS1Y/Rb/gA0k9nlm+gawDMf2I
         DkqnKumGLjhk728cJhyMJlIeeJm6GB4TVDc6XpoVNznu8FxGbKsI2zMZ8Gbut3kilgdf
         vpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789841538; x=1790446338;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=091mGJb963fZm7TN81QDLSJJlLLidQRDCWzb3G3L/U4=;
        b=egKDq5IkHT2P9g+uJTeY1whIcyZsIaysRlzrD4O2G4D+e/Im1XA6AdPK536UPDnZpy
         8t19eC5vi9twk1GdCbRojfnGQtBNyj7Y578yaBrWQTEGljZ4HvWSZKr17Ds5xBMx+MDw
         aTpDK9tNr0MkxAmf9MIwIFvXHrRv7WHEyquimgvDP7nVtyET/Snk4EP8IVndXXVmTLjS
         7iFDga/WRdyEFrO45HuW+M1IOHOXbbMoJNER3FfTQTnqZKHazk66h3M+aKhSSfpDzZt6
         Up4FiEwpMDiH2J7IhJZYKTeC1JJ/LKHifJD7jBA8qbD5vTRGHkyncTdebNo5AKNvPeil
         r3MA==
X-Forwarded-Encrypted: i=1; AKwUvByZCTnf9Wy84QHdtMhnppj2KruUs0HK0v5jIMGagUiXpV8g1S1vumeXDfvTCWZ6LFSDdu8=@vger.kernel.org
X-Gm-Message-State: AFuF++mOpTn3XxlmCG8lDiVr6gcdC0vTrrP1hyi3S/6kAwFGG05mkTFG
	OUZ7qYWuhKj1SC0GWiuR2glwdQjsO3wdU5x1XZzUKApErl39498zcGA4
X-Gm-Gg: AYBFou3UJ1KNqG5Acv++T1XutTcePLH/rY+uR1qQsDZ+nGSNw/5SivSSCJo0tdI+yhU
	a31pwre1XrzUppUCYipQLTxv1WQQf8kXM+kpjxgZP1wuHy015/0A/NAUQCtGkjYdskRf8qw3U/l
	jFvyaKxfeNRPsDwwd2hH256/L1i9d50htbxW5BqnsmtHPv0GGStyaMg4tel3wgd6gQLXuePmyP1
	cxkSNwBYPG62hPB3y6lhs/UVWlEX6+o7Q8o5rQEOrISqJffLtQTntphSPf8iqARa+zeWq4jU8aK
	B3FHmS3FxjeTE8AHtn/Qj34j0fuGfWEiexJgwIffLNkzBDQazRH88u/HLWA41DVFDPqJgw3ur8H
	TWWTiXbit4piqgLieUFzcI65iy5Gzo/dkSupT1O9iDIc9GmsbSt6ocZpuKt2Ou3rQRNckl7fol8
	fWyIF1xeRWxIHVPuQkEKlP5zwxkjI2fZ/7ptrC60CndhQdV+vZ/Z5WcgEHA4lTnQP8cqul2s7R5
	+2Lk4VLl1bpIn0CZAHss0XN4Dr40pJAkENkWc9y/ff1NlzMwrcgzN1+jfhRpJznSstI1I13VBXw
	IppC
X-Received: by 2002:a17:90b:2681:b0:39e:6c6a:657d with SMTP id 98e67ed59e1d1-39e6c6a67c0mr4274816a91.64.1789841538426;
        Sat, 19 Sep 2026 11:12:18 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02738654csm3624279a91.3.2026.09.19.11.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 11:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 18:12:17 +0000
Message-Id: <DLJHVEYXMZ6R.1YX59HGMRMYO0@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, "Jason Xing"
 <kernelxing@gmail.com>
Subject: Re: [PATCH RFC net-next 0/9] net: BPF Timestamping 2.0 for TCP
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jason Xing" <kerneljasonxing@gmail.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <willemb@google.com>, <kuniyu@google.com>
X-Mailer: aerc 0.17.0
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>

On Sat Sep 19, 2026 at 2:37 PM UTC, Jason Xing wrote:
> From: Jason Xing <kernelxing@gmail.com>
>
> Greeting,
>
> It's BPF Timestamping 2.0 that aims to observe the packet latency
> more efficiently and simply for different protocols. The current
> series is only focused on TCP protocol.
>
> At Netdev 0x1a/Netconf 2026, the history, background, motivation and
> rough implementation of the feature were exhaustively introduced[1].
>
> History
> =3D=3D=3D=3D=3D=3D=3D
> - In 2009, Patrick Ohly implemented the basic infrastructure
> - In 2014, Willem de Bruijn enhanced the TCP latency observation
> - In 2024, Jason Xing proposed its lightweight BPF version
> Detailed slides from 28 to 32 [1].
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Even though BPF Timetamping 1.0 is comparatively low-overhead,
> transparent, it's still complicated due to a few points inherited
> from the design:
> - Inflexible/fixed reporting phases (qdisc/driver/ack)
>   When we confirm the issue arises from the kernel by using attribution
>   ability of timestamping feature, we need to further minimize the scope
>   until the issue is fixed. That means, we then have to resort to write
>   a few complex BPF progs with the similar functionalities (like skb
>   level tag) which should not happen.
> - Not enough low-overhead
>   Serving the sensitive applications, an always-on latency observation
>   platform should mitigate the self-impact as much as possible. As we
>   can conclude from BPF Timestamping selftests, there are some blocking
>   and time-consuming points like where reading/writing BPF maps happen
>   in the extremely hot paths.
> - Minor flaws
>   There are a few minor flaws inherited from the initial design, like
>   missing tagging the last packet[2][3][4].


All these "issues" sound minor and on their own do not warrant new uapi.

This RFC don't even have an example of how it could be used end-to-end.

So soft nack from me for now.

pw-bot: cr
